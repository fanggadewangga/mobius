---
name: kotlin-flow-patterns
trigger: "flow", "stateflow", "sharedflow", "collect", "coroutine", "async"
platform: mobile/android
---

# Kotlin Flow Patterns

## Hierarchy: Flow vs StateFlow vs SharedFlow

| | Flow | StateFlow | SharedFlow |
|---|---|---|---|
| Replay | No | Last value | Configurable |
| Initial value | Not needed | Required | Not needed |
| Use case | Data stream | UI state | Events |

## StateFlow for UI State
```kotlin
// ✅ CORRECT
private val _uiState = MutableStateFlow(LoginState())
val uiState: StateFlow<LoginState> = _uiState.asStateFlow()

// In Composable
val state by viewModel.uiState.collectAsStateWithLifecycle()
```

## SharedFlow for One-time Events
```kotlin
// ✅ CORRECT — navigation, toast, snackbar
private val _events = MutableSharedFlow<LoginEvent>()
val events: SharedFlow<LoginEvent> = _events.asSharedFlow()

// In ViewModel
viewModelScope.launch { _events.emit(LoginEvent.NavigateToHome) }

// In Composable
LaunchedEffect(Unit) {
    viewModel.events.collect { event -> /* handle */ }
}
```

## DO NOT collect in lifecycleScope directly
```kotlin
// ❌ WRONG — leak when in background
lifecycleScope.launch {
    viewModel.uiState.collect { /* ... */ }
}

// ✅ CORRECT
lifecycleScope.launch {
    repeatOnLifecycle(Lifecycle.State.STARTED) {
        viewModel.uiState.collect { /* ... */ }
    }
}

// ✅ CORRECT — in Compose
val state by viewModel.uiState.collectAsStateWithLifecycle()
```

## Commonly Used Flow Operators
```kotlin
flow
  .map { it.toUiModel() }          // transform
  .filter { it.isActive }          // filter
  .distinctUntilChanged()           // skip duplicates
  .debounce(300)                    // for search input
  .catch { e -> emit(emptyList()) } // error handling
  .stateIn(viewModelScope, SharingStarted.WhileSubscribed(5000), emptyList())
```
