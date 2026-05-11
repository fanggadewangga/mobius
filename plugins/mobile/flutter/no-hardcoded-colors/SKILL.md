---
name: flutter-no-hardcoded-colors
trigger: automatic (always active for this project)
platform: mobile/flutter
---

# Flutter — No Hardcoded Colors

## Main Rule
NEVER hardcode colors. ALWAYS use theme colors or project color constants.

## FORBIDDEN Patterns

```dart
// ❌ WRONG — all of these are forbidden
color: Colors.blue
color: Colors.blue[700]
color: Color(0xFF1A73E8)
color: const Color(0xFF1A73E8)
backgroundColor: Colors.white
textColor: Colors.black87
```

## CORRECT Patterns

```dart
// ✅ CORRECT — use Theme
color: Theme.of(context).colorScheme.primary
color: Theme.of(context).colorScheme.onSurface
color: Theme.of(context).colorScheme.error

// ✅ CORRECT — use project color constants (check ColorsApp / AppColors / ColorTokens)
color: ColorsApp.primary
color: ColorsApp.textPrimary
color: ColorsApp.surfaceBackground
```

## How to Find the Right Color
1. Check `ColorsApp` / `AppColors` / `color_constants.dart` in the project.
2. Check the project's `ThemeData` for semantic colors (primary, secondary, error, etc.).
3. If the required color is missing: ASK the developer, do not hardcode.

## Allowed Exceptions
```dart
// ✅ OK — transparent has no semantic equivalent
color: Colors.transparent

// ✅ OK — in the theme/color definition file itself
// (the file defining ColorsApp can use Color(0xFF...))
```

## Checklist
- [ ] No `Color(0xFF...)` outside color definition files.
- [ ] No `Colors.*` except `Colors.transparent`.
- [ ] All colors use theme or ColorsApp/AppColors.
