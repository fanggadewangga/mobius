---
name: flutter-widget-patterns
trigger: "widget", "ui", "layout", "component"
---

# Flutter Widget Patterns

Best practices for building UI in Flutter:

1. **Composition Over Inheritance**: Build complex widgets by composing smaller ones.
2. **Const Constructors**: Use `const` wherever possible to improve performance.
3. **Responsive Design**: Use `LayoutBuilder`, `MediaQuery`, or `ScreenUtil` for multi-screen support.
4. **Theme Driven**: Avoid hardcoded colors/fonts. Use `Theme.of(context)`.
5. **Lifecycle**: Use `StatefulWidget` only when necessary. Prefer `StatelessWidget` with state management.

"A widget should do one thing well."
