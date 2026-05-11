---
name: ios-combine-async
trigger: "combine", "async", "await", "task", "publisher"
---

# iOS Asynchronous Programming

1. **Swift Concurrency**: Preference for `async/await`, `Task`, and `Actors`.
2. **Combine**: Use for stream-based logic and UI bindings.
3. **Threading**:
   - `@MainActor`: For UI updates.
   - Background tasks: Implicitly handled by `async` functions or explicit `Task.detached`.
4. **Memory Management**: Use `[weak self]` in Combine closures or long-running Tasks to avoid retain cycles.

"Structured concurrency for safer code."
