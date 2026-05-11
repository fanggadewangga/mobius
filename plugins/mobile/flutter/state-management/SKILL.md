---
name: flutter-state-management
trigger: "state", "management", "bloc", "riverpod", "provider"
---

# Flutter State Management

Depending on the project's choice (check `CLAUDE.md`), follow these patterns:

## BLoC (Business Logic Component)
- Keep BLoCs focused on a single feature.
- Use `emit` for state changes.
- Ensure all states are immutable.
- Use `BlocListener` for side-effects (navigation, snackbars).

## Riverpod
- Use `ConsumerWidget` or `ConsumerStatefulWidget`.
- Preference for `AsyncValue` for network data.
- Avoid global mutable state.

## Provider
- Use `ChangeNotifierProvider` or `StateProvider`.
- Keep providers small and focused.

"Choose the right tool for the job. Don't over-engineer simple screens."
