## Context Navigation

When you need to understand this codebase:
1. ALWAYS query the knowledge graph first: `/graphify query "your question"`
   - Graph location: `../graphify-out/graph.json` (unified graph: Flutter site + Hub source + Hub content)
2. Only read raw files if I explicitly say "read the file"
3. The graph connects this Flutter site to the hub at `../hub_sio2renovations/` — both source code (`src/`) and content (`content/`)

## Rules

ALWAYS before making any change: search the web for the newest documentation.
Only implement if you are 100% sure it will work.

---

## Project Overview

**SiO2 Rénovations** — Site vitrine Flutter Web pour une entreprise de rénovation à Paris.
Cible : web uniquement (Flutter Web). Pas d'app mobile native.

---

## Architecture

```
lib/
├── main.dart                        # Point d'entrée, routing GoRouter
├── api/                             # Appels HTTP externes
│   └── contact_form_api.dart        # POST formulaire de contact
├── components/                      # Composants réutilisables multi-screens
│   ├── customer_contact_form_component.dart
│   ├── footer_component.dart
│   ├── my_drawer_component.dart
│   ├── my_nav_bar_component.dart
│   ├── success_popup_component.dart
│   └── professional_contact_form_componenet.dart
├── data/                            # Données statiques (mock)
│   ├── services_data.dart           # Liste des 2 services (SdB + Appartement)
│   ├── steps_data.dart              # Étapes du processus client
│   ├── customer_feedbacks_data.dart # Témoignages clients
│   └── google_map_data.dart         # Coordonnées Google Maps
├── manager/                         # Orchestrateurs (init, lifecycle)
│   ├── cookies_overlay_manager.dart
│   ├── contact_form_manager.dart
│   └── inject_google_maps_script_manager.dart
├── models/
│   └── contact_form_request_model.dart
├── screens/                         # Pages de l'application
│   ├── landing_screen.dart          # Page principale (sections en cascade)
│   ├── about_screen.dart
│   ├── contact_screen.dart
│   ├── projects_screen.dart
│   ├── partners_screen.dart
│   ├── splash_screen.dart
│   ├── legal_montion_screen.dart    # [typo dans le nom de fichier — ne pas renommer sans vérifier les routes]
│   └── privacy_policy_screen.dart
├── sections/landing_screen/         # Sections de la landing page (ordre d'affichage)
│   ├── welcome_section.dart
│   ├── services_section.dart        # Node le plus central du graphe (betweenness 0.257)
│   ├── what_type_of_renovations_section.dart
│   ├── before_after_section.dart
│   ├── key_figures_section.dart
│   ├── company_profile_section.dart
│   ├── values_section.dart
│   ├── why_choose_us_section.dart
│   ├── steps_section.dart
│   ├── customer_feedback_section.dart
│   └── work_together_section.dart
├── services/                        # Logique métier et services web/mobile
│   ├── contact_form_service.dart    # Service actif (web)
│   ├── cookies_consent_service.dart
│   ├── inject_google_maps_script_web_service.dart
│   ├── contact_form_mobile_service.dart      # ⚠️ INUTILISÉ — voir section Dead Code
│   └── inject_google_maps_script_mobile_service.dart  # ⚠️ INUTILISÉ
├── utils/
│   ├── global_colors.dart           # Palette SiO2 (orange #F7931E + noir)
│   ├── global_routes.dart           # Constantes de routes
│   ├── global_screen_sizes.dart     # Breakpoints responsive
│   └── global_others.dart
└── widgets/                         # Widgets atomiques réutilisables
    ├── my_button_widget.dart
    ├── my_google_map_widget.dart
    ├── my_rive_button_widget.dart
    ├── carousel_slider_widget.dart
    ├── photo_wall_widget.dart
    ├── hover_sub_menu_widget.dart
    ├── my_horizontal_menu_widget.dart
    ├── my_hover_route_navigator_widget.dart
    ├── my_hover_url_navigator_widget.dart
    ├── my_hover_slide_link_widget.dart
    ├── cookies_consent_banner_widget.dart
    ├── image_preloader_widget.dart
    ├── opening_hours_widget.dart
    ├── files_picker_widget.dart
    ├── my_captcha_widget.dart
    └── my_back_to_top_button_widget.dart
```

---

## Conventions

- **Couleurs** : toujours via `GlobalColors` (`lib/utils/global_colors.dart`), jamais hardcodées
- **Routes** : constantes dans `global_routes.dart`, jamais de strings littérales
- **Breakpoints** : via `GlobalScreenSizes`, pas de valeurs fixes dans les widgets
- **Données** : toutes dans `lib/data/`, pas dans les widgets ni les sections
- **Sections landing** : chaque section est un `StatefulWidget` autonome avec ses propres animations
- **Animations** : `VisibilityDetector` + `AnimationController` pattern — déclenchement au scroll

---

## Packages clés

| Package | Usage |
|---|---|
| `rive` | Animations boutons (my_rive_button_widget) |
| `lottie` | Animation success popup |
| `carousel_slider` / `carousel_slider_plus` | Carrousels images |
| `visibility_detector` | Déclencher animations au scroll |
| `flutter_staggered_grid_view` | Grille photos (photo_wall_widget) |
| `slider_captcha` | CAPTCHA formulaire contact |
| `google_maps_flutter` | Carte Google Maps |
| `flutter_dotenv` | Variables d'environnement |
| `shared_preferences` | Stockage consentement cookies |
| `url_launcher` | Liens externes (hover widgets) |
| `flutter_svg` | Logo et icônes SVG |
| `animated_text_kit` | Texte animé welcome section |

---

## Dead Code identifié par graphify

Ces fichiers sont isolés dans le graphe (aucune arête entrante) :

| Fichier | Statut |
|---|---|
| `lib/services/contact_form_mobile_service.dart` | INUTILISÉ — doublon de contact_form_service.dart |
| `lib/services/inject_google_maps_script_mobile_service.dart` | INUTILISÉ — doublon web service |
| `lib/manager/contact_form_manager.dart` | INUTILISÉ — export conditionnel commenté, remplacé par `contact_form_service.dart` direct |

**Décision** : ces 3 fichiers peuvent être supprimés en toute sécurité (degree=0 dans le graphe). Confirmé le 2026-04-23 — non supprimés volontairement.

---

## Lien avec le Hub (hub_sio2renovations)

Ce site Flutter est le **front vitrine**. Le hub Next.js (`../hub_sio2renovations/`) est le **hub de contenu SEO**.

Le graphe indexe les deux couches du hub :
- **`src/`** — code source Next.js (App Router, composants, lib)
- **`content/`** — articles et pages SEO locales (markdown)

### Pont de navigation Flutter ↔ Hub (communauté "Cross-Project Navigation Bridge")

Flux implémenté (avril 2026) :
1. `resources_section.dart` → `_openUrl()` : `history.replaceState('/?scroll=ressources')` puis navigue vers l'URL hub avec `?return=<origin>/?scroll=ressources`
2. `hub/src/components/RefTracker.tsx` : lit `?ref=sio2renovations` et `?return`, stocke dans `sessionStorage`
3. `hub/src/components/BackButton.tsx` : `window.history.back()` — retour contextuel via historique navigateur
4. `main.dart` : détecte `?scroll=ressources` → bypass splash screen → `LandingScreen` avec scroll auto

### Connexions sémantiques identifiées par graphify
- `resources_section.dart` ↔ `BackButton.tsx` / `RefTracker.tsx` (pont cross-projet, INFERRED 0.85–0.95)
- `services_section.dart` ↔ articles "Rénovation Appartement" et "Rénovation SdB" du hub
- `what_type_of_renovations_section.dart` ↔ articles hub (conceptually_related_to)
- `before_after_section.dart` ↔ article appartement + service rénovation complète
- `articles_data.dart` → URLs hardcodées `hub.sio2renovations.com` (EXTRACTED)

Le graphe unifié est consultable via :
```bash
! xdg-open ../graphify-out/graph.html
```

---

## Commandes utiles

```bash
# Lancer en dev web
flutter run -d chrome

# Build web
flutter build web

# Analyser le code
flutter analyze

# Graphify — interroger l'architecture
/graphify query "comment fonctionne le formulaire de contact ?"
/graphify query "quels widgets utilisent VisibilityDetector ?"
```
