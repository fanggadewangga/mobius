---
name: flutter-const-sizing
trigger: automatic (always active for this project)
platform: mobile/flutter
---

# Flutter Sizing Constants — SizesApp

## Main Rule
NEVER hardcode spacing/sizing values. ALWAYS use `SizesApp` constants.

## Required Mapping

| Hardcoded (WRONG) | SizesApp (CORRECT) |
|---|---|
| `EdgeInsets.all(16)` | `EdgeInsets.all(SizesApp.margin)` |
| `EdgeInsets.symmetric(horizontal: 16)` | `EdgeInsets.symmetric(horizontal: SizesApp.margin)` |
| `SizedBox(height: 16)` | `SizedBox(height: SizesApp.margin)` |
| `SizedBox(width: 8)` | `SizedBox(width: SizesApp.marginSm)` |
| `BorderRadius.circular(8)` | `BorderRadius.circular(SizesApp.radiusSm)` |

> Note: The mapping above is an example. Always check the `SizesApp` class in the project for the exact values before assuming constant names.

## Correct Usage

```dart
// ✅ CORRECT
Padding(
  padding: const EdgeInsets.all(SizesApp.margin),  // <- const because SizesApp.margin is const
  child: ...,
)

// ✅ CORRECT — const widget because all values are const
const SizedBox(height: SizesApp.margin)

// ❌ WRONG — hardcoded
Padding(
  padding: const EdgeInsets.all(16),
  child: ...,
)

// ❌ WRONG — can use const but not used
SizedBox(height: SizesApp.margin)  // <- missing const
```

## Required `const` Rules
Always add `const` if:
- All widget parameters are compile-time constants.
- The widget does not depend on state or runtime variables.
- `SizesApp.*` are always const — widgets that only use SizesApp can always be const.

## When a Value is Missing in SizesApp
If the required spacing is not in `SizesApp`:
1. ASK the developer first — do not hardcode.
2. There might be a proper constant name that you haven't found yet.
3. If it truly doesn't exist, propose adding a new constant to SizesApp, do not bypass it.

## Lint Check
Run after completion:
```bash
flutter analyze
# Look for warnings: prefer_const_constructors, prefer_const_literals_to_create_immutables
```
