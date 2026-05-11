---
name: android-jetpack-compose
trigger: "compose", "composable", "ui", "layout"
---

# Android Jetpack Compose

Modern UI development rules:

1. **State Hoisting**: Move state up to make composables stateless and testable.
2. **Recomposition**: Keep composables light. Use `remember` and `derivedStateOf` to avoid unnecessary work.
3. **Themes**: Use `MaterialTheme` for styling. Do not hardcode colors.
4. **Previews**: Always provide `@Preview` for UI components with sample data.
5. **Navigation**: Use `Compose Navigation` with type-safe routes if possible.

"UI is a function of state."
