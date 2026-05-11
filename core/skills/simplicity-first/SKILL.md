---
name: simplicity-first
trigger: automatic
applies_to: all
---

# Simplicity First

Mobile development often suffers from over-engineering. Follow these rules to keep the codebase clean and maintainable:

1. **Avoid Over-Abstraction**: Don't create interfaces or multiple layers if a single class or function suffices.
2. **Standard Components Over Custom**: Use standard platform widgets/views unless a custom one is explicitly required.
3. **Flutter Specific**: Don't use BLoC for everything. `setState` or `ValueNotifier` is often enough for simple UI state.
4. **Android Specific**: Don't over-complicate ViewModels. Keep them focused on UI state management.
5. **iOS Specific**: Use SwiftUI's native state management (@State, @Binding) before reaching for external architectures.

"Complexity is a bug." — prioritize readable code over "clever" abstractions.
