---
name: ios-swiftui
trigger: "swiftui", "view", "body", "state"
---

# iOS SwiftUI

Modern iOS UI rules:

1. **Declarative UI**: Focus on what the UI should look like for a given state.
2. **State Management**:
   - `@State`: Local private state.
   - `@Binding`: Two-way connection to state.
   - `@StateObject`: Reference type lifecycle managed by the view.
   - `@ObservedObject`: Reference type lifecycle managed externally.
3. **View Composition**: Break views into smaller components.
4. **Previews**: Provide `Canvas` previews for all views.

"State is the single source of truth."
