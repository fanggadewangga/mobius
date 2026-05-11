---
name: android-kotlin-coroutines
trigger: "coroutine", "async", "await", "suspend", "flow"
---

# Android Kotlin Coroutines

Best practices for asynchronous programming in Android:

1. **Scoping**: Use `viewModelScope` in ViewModels and `lifecycleScope` in Activities/Fragments. NEVER use `GlobalScope`.
2. **Dispatchers**:
   - `Dispatchers.Main`: UI operations.
   - `Dispatchers.IO`: Network, DB, Disk.
   - `Dispatchers.Default`: CPU intensive tasks.
3. **Flows**: Use `StateFlow` or `SharedFlow` for UI state streams. Avoid `LiveData` in new projects.
4. **Exception Handling**: Use `try-catch` or `CoroutineExceptionHandler`.
5. **Testing**: Use `runTest` and `StandardTestDispatcher` for unit tests.

"Concurrently correct, sequentially simple."
