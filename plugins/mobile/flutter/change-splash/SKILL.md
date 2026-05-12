---
name: flutter-change-splash
trigger: "change splash", "update splash", "splash screen", "native splash"
platform: mobile/flutter
---

# Flutter — Change Splash Screen Workflow (Multi-Flavor)

## Overview

Changing the splash screen in this banking app involves:
1. `flutter_native_splash` package.
2. Multiple flavors: **dev, test, preploy, pilot, prod**.
3. Assets are typically provided by the UI/UX team.

DO NOT edit native files directly — always use the package first, then verify the results in the native layer.

## Step-by-Step Workflow

### Step 1 — Prepare UI/UX Assets

Assets provided by the UI/UX team should be placed in the appropriate paths.
- [ ] Verify asset paths (e.g., `assets/images/splash/`).
- [ ] Ensure assets match flavor requirements (different logos for dev/prod).
- [ ] Confirm background colors for each flavor.

Recommended paths:
```
assets/images/splash/splash_dev.png
assets/images/splash/splash_test.png
assets/images/splash/splash_preploy.png
assets/images/splash/splash_pilot.png
assets/images/splash/splash_prod.png
```

### Step 2 — Configure Flavor-Specific YAMLs

Create or update separate configuration files for each flavor:
`flutter_native_splash-dev.yaml`, `flutter_native_splash-test.yaml`, etc.

Example `flutter_native_splash-dev.yaml`:
```yaml
flutter_native_splash:
  color: "#FF6B6B"                        # Dev background
  image: assets/images/splash/splash_dev.png
  android_12:
    image: assets/images/splash/splash_dev.png
    color: "#FF6B6B"
  fullscreen: true
  android: true
  ios: true
```

### Step 3 — Generate Native Assets per Flavor

Run the generator for the specific flavor you are updating:

```bash
# For Dev
dart run flutter_native_splash:create --path=flutter_native_splash-dev.yaml

# For Test
dart run flutter_native_splash:create --path=flutter_native_splash-test.yaml

# For Preploy
dart run flutter_native_splash:create --path=flutter_native_splash-preploy.yaml

# For Pilot
dart run flutter_native_splash:create --path=flutter_native_splash-pilot.yaml

# For Prod
dart run flutter_native_splash:create --path=flutter_native_splash-prod.yaml
```

### Step 4 — Verify Generated Files

**Android:**
```
android/app/src/main/res/drawable/launch_background.xml
android/app/src/main/res/mipmap-xxxhdpi/splash.png
android/app/src/main/styles.xml
```

**iOS:**
```
ios/Runner/Base.lproj/LaunchScreen.storyboard
ios/Runner/Assets.xcassets/LaunchImage.imageset/
```

### Step 5 — Test on Specific Flavor

```bash
flutter clean
flutter pub get
flutter run --flavor dev   # or test/preploy/pilot/prod
```

**Visual Checklist:**
- [ ] Correct logo appears for the selected flavor.
- [ ] Background color matches flavor-specific design.
- [ ] Logo is centered and not cropped.
- [ ] No old splash remains (if so, `flutter clean` is mandatory).

### Troubleshooting

```
ISSUE: Wrong flavor splash appears
FIX:   Double check the --path argument in Step 3 matches the target flavor.

ISSUE: Android 12 splash icon is too small
FIX:   Ensure the android_12 section is correctly configured in the flavor YAML.
```
