---
name: flutter-change-app-icon
trigger: "change app icon", "update app icon", "app icon", "launcher icon", "change icon"
platform: mobile/flutter
---

# Flutter — Change App Icon Workflow (Multi-Flavor)

## Overview

Changing the app icon in this banking app involves:
1. `flutter_launcher_icons` package.
2. Multiple flavors: **dev, test, preploy, pilot, prod**.
3. Assets are typically provided by the UI/UX team.

## Required Questions Before Starting

- [ ] Are the flavor-specific icons available? (usually provided by UI/UX)
- [ ] Are there adaptive icons (foreground + background) for Android?
- [ ] Are there specific icons for the App Store (1024x1024px)?

## Step-by-Step Workflow

### Step 1 — Prepare UI/UX Assets

Place the provided assets in the appropriate directory (e.g., `assets/icons/`):
```
assets/icons/icon_dev.png
assets/icons/icon_test.png
assets/icons/icon_preploy.png
assets/icons/icon_pilot.png
assets/icons/icon_prod.png

# For Android Adaptive Icons (Optional but recommended)
assets/icons/icon_foreground.png
assets/icons/icon_background_dev.png
...
```

### Step 2 — Configure `flutter_launcher_icons` YAMLs

Create or update separate configuration files for each flavor:

**Example `flutter_launcher_icons-dev.yaml`**:
```yaml
flutter_launcher_icons:
  android: "launcher_icon"
  ios: true
  image_path: "assets/icons/icon_dev.png"
  adaptive_icon_background: "#FF6B6B"
  adaptive_icon_foreground: "assets/icons/icon_foreground.png"
  remove_alpha_ios: true
```

### Step 3 — Generate Icons per Flavor

Run the generator for each flavor:

```bash
# Generate for all flavors
dart run flutter_launcher_icons:generate -f flutter_launcher_icons-dev.yaml
dart run flutter_launcher_icons:generate -f flutter_launcher_icons-test.yaml
dart run flutter_launcher_icons:generate -f flutter_launcher_icons-preploy.yaml
dart run flutter_launcher_icons:generate -f flutter_launcher_icons-pilot.yaml
dart run flutter_launcher_icons:generate -f flutter_launcher_icons-prod.yaml
```

### Step 4 — Verify Generated Files

**Android:**
```
android/app/src/main/res/mipmap-*/ic_launcher.png
android/app/src/main/res/mipmap-anydpi-v26/ic_launcher.xml (Adaptive)
```

**iOS:**
```
ios/Runner/Assets.xcassets/AppIcon.appiconset/
```

### Step 5 — Visual Test per Flavor

```bash
flutter clean
flutter run --flavor dev   # or test/preploy/pilot/prod
```

**Checklist:**
- [ ] Correct icon appears for the selected flavor.
- [ ] Adaptive icon animation works on Android (if configured).
- [ ] No transparency issues on iOS (ensure `remove_alpha_ios: true`).

### Troubleshooting

```
ISSUE: Icon does not change on home screen
FIX:   Uninstall the app first, then run flutter clean and rebuild.

ISSUE: Adaptive icon looks weird
FIX:   Ensure the foreground image has enough padding (safe zone) so it doesn't get cropped.
```
