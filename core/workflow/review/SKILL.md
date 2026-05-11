---
name: mobile-review
trigger: "review", "ready", "finish", "commit"
---

# Mobile Code Review

Before finalizing a task, perform a self-review or ask the AI to review based on these criteria:

1. **Architecture Compliance**: Does it follow the project's pattern (MVVM, BLoC, etc.)?
2. **Performance**: Are there heavy operations on the main thread? Any potential memory leaks?
3. **UI Fidelity**: Does it match the design/requirements? Is it responsive?
4. **Error Handling**: Are all exceptions caught? Is there user feedback for errors?
5. **Clean Code**: Descriptive names, no dead code, proper formatting.
6. **Platform Specifics**:
   - **Android**: Check for context leaks, correct use of Coroutines.
   - **iOS**: Check for retain cycles, Swift Concurrency best practices.

"Code is read more often than it is written."
