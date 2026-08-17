#!/usr/bin/env bash
# sync-build-to-desktop.sh — Pull the latest CI-built Flutter web bundle and
# copy it to the Windows desktop as web-YYYY-MM-DD, ready for FileZilla upload.
#
# Usage:
#   ./sync-build-to-desktop.sh            # pull + copy
#   ./sync-build-to-desktop.sh --dry-run  # show what would happen, copy nothing
#
# Safety rules:
#   - Never overwrites an existing desktop folder (same-day reruns get a -2, -3… suffix).
#   - Aborts if build/web/assets/local.env is missing and cannot be restored,
#     because the app cannot load its runtime config without it.

set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BUILD_DIR="$REPO_DIR/build/web"
DESKTOP_DIR="/mnt/c/Users/La Production/Desktop"
TODAY="$(date +%F)"
DRY_RUN=false
[[ "${1:-}" == "--dry-run" ]] && DRY_RUN=true

echo "== SiO2 frontend → desktop sync =="

# 1. Fetch the latest CI build (ff-only: this repo is CI-managed, local commits are unexpected)
echo "-- git pull (ff-only)"
git -C "$REPO_DIR" pull --ff-only
echo "   HEAD: $(git -C "$REPO_DIR" log -1 --format='%h %s')"

# 2. Sanity check: the build output must exist
if [[ ! -d "$BUILD_DIR" ]]; then
  echo "ERROR: $BUILD_DIR not found — CI build missing from the repo." >&2
  exit 1
fi

# 3. local.env is untracked on purpose (secrets): restore it from the repo root copy if the pull lost it
if [[ ! -f "$BUILD_DIR/assets/local.env" ]]; then
  if [[ -f "$REPO_DIR/local.env" ]]; then
    echo "-- restoring build/web/assets/local.env from repo root local.env"
    $DRY_RUN || cp "$REPO_DIR/local.env" "$BUILD_DIR/assets/local.env"
  else
    echo "ERROR: build/web/assets/local.env is missing and no root local.env to restore from." >&2
    echo "       The deployed app would fail to load its Google Maps key and backend URLs." >&2
    exit 1
  fi
fi

# 4. Pick a target folder name that never clobbers an existing one
TARGET="$DESKTOP_DIR/web-$TODAY"
SUFFIX=2
while [[ -e "$TARGET" ]]; do
  TARGET="$DESKTOP_DIR/web-$TODAY-$SUFFIX"
  SUFFIX=$((SUFFIX + 1))
done

# 5. Copy
if $DRY_RUN; then
  echo "-- dry-run: would copy $BUILD_DIR → $TARGET"
else
  echo "-- copying to $TARGET (this can take a minute on /mnt/c)"
  cp -r "$BUILD_DIR" "$TARGET"
  # Post-copy check: local.env must have survived the copy
  [[ -f "$TARGET/assets/local.env" ]] || { echo "ERROR: local.env missing in copied folder." >&2; exit 1; }
  echo "   size: $(du -sh "$TARGET" | cut -f1)"
fi

echo "== Done. Next step: upload '$(basename "$TARGET")' with FileZilla,"
echo "   overwriting main.dart.js and flutter_service_worker.js on the server."
