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

# 6. Cache-bust main.dart.js with the build id.
# Flutter web does NOT hash the main.dart.js filename, and visitors who cached it
# under the old "max-age=1y, immutable" header (served until 2026-08-31) will keep
# that stale copy — for them, only a URL change forces a fresh download.
# Keep this step at least until those cache entries expire (~August 2027).
# Guarded: aborts if the expected patterns are not found (e.g. after a Flutter
# upgrade changes the generated files), so a broken patch never ships silently.
if ! $DRY_RUN; then
  BUILD_ID="$(cut -c1-8 "$BUILD_DIR/.last_build_id")"
  [[ -n "$BUILD_ID" ]] || { echo "ERROR: could not read build id from $BUILD_DIR/.last_build_id" >&2; exit 1; }
  echo "-- cache-busting main.dart.js with ?v=$BUILD_ID"

  BOOTSTRAP="$TARGET/flutter_bootstrap.js"
  INDEX="$TARGET/index.html"
  [[ "$(grep -c '"mainJsPath":"main.dart.js"' "$BOOTSTRAP")" == "1" ]] \
    || { echo "ERROR: mainJsPath pattern not found in flutter_bootstrap.js — Flutter output changed, update this script." >&2; exit 1; }
  [[ "$(grep -c 'href="main.dart.js"' "$INDEX")" == "1" ]] \
    || { echo "ERROR: preload pattern not found in index.html — update this script." >&2; exit 1; }

  sed -i "s|\"mainJsPath\":\"main.dart.js\"|\"mainJsPath\":\"main.dart.js?v=$BUILD_ID\"|" "$BOOTSTRAP"
  sed -i "s|href=\"main.dart.js\"|href=\"main.dart.js?v=$BUILD_ID\"|" "$INDEX"

  # Post-patch check: both files must now reference the versioned URL
  grep -q "main.dart.js?v=$BUILD_ID" "$BOOTSTRAP" && grep -q "main.dart.js?v=$BUILD_ID" "$INDEX" \
    || { echo "ERROR: cache-bust verification failed." >&2; exit 1; }
  echo "   patched: flutter_bootstrap.js + index.html"
fi

echo "== Done. Next step: upload '$(basename "$TARGET")' with FileZilla, overwriting"
echo "   main.dart.js, flutter_service_worker.js, flutter_bootstrap.js, index.html"
echo "   and .htaccess on the server (bootstrap/index carry the ?v= cache-bust)."
