---
name: android-mvvm-pattern
trigger: "create screen", "create feature", "implement", "viewmodel", "ui state"
platform: mobile/android
---

# Android MVVM Pattern

## Layer Responsibilities

```
UI Layer (Activity / Fragment / Composable)
  └── Only: observe state, handle user events, navigate
  └── FORBIDDEN: business logic, direct data access

ViewModel
  └── Only: expose UI state (StateFlow), handle UI events, call use cases
  └── FORBIDDEN: import android.view.*, direct DB/API call, Context (except Application)

Domain Layer (Use Case) — optional but recommended
  └── Only: one use case = one business operation
  └── FORBIDDEN: framework dependency

Data Layer (Repository + DataSource)
  └── Repository: interface in domain, implementation in data
  └── DataSource: remote (API) or local (DB)
```

## UI State Pattern (Sealed Class)

```kotlin
// ✅ CORRECT — one sealed class per screen
sealed class LoginUiState {
    object Idle : LoginUiState()
    object Loading : LoginUiState()
    data class Success(val user: User) : LoginUiState()
    data class Error(val message: UiText) : LoginUiState()
}

// In ViewModel:
private val _uiState = MutableStateFlow<LoginUiState>(LoginUiState.Idle)
val uiState: StateFlow<LoginUiState> = _uiState.asStateFlow()

// In Composable:
val uiState by viewModel.uiState.collectAsStateWithLifecycle()
```

## ViewModel Template

```kotlin
// ✅ CORRECT
@HiltViewModel
class LoginViewModel @Inject constructor(
    private val loginUseCase: LoginUseCase  // inject use case, not repository directly
) : ViewModel() {

    private val _uiState = MutableStateFlow<LoginUiState>(LoginUiState.Idle)
    val uiState: StateFlow<LoginUiState> = _uiState.asStateFlow()

    fun onLoginClicked(email: String, password: String) {
        viewModelScope.launch {
            _uiState.value = LoginUiState.Loading
            loginUseCase(email, password)
                .onSuccess { user -> _uiState.value = LoginUiState.Success(user) }
                .onFailure { e -> _uiState.value = LoginUiState.Error(e.toUiText()) }
        }
    }
}
```

## What Should NOT Be in a ViewModel
```kotlin
// ❌ WRONG
class LoginViewModel : ViewModel() {
    fun login(context: Context) { ... }         // NO Context
    fun updateView(textView: TextView) { ... }  // NO View reference
    val db = Room.databaseBuilder(...)          // NO direct DB
    fun callApi() = retrofitService.login(...)  // NO direct API call
}
```

## Checklist Before Submit
- [ ] ViewModel does not import `android.view.*` or `android.widget.*`.
- [ ] UI state uses `StateFlow`, not `LiveData` (unless project still uses LiveData).
- [ ] No business logic in Activity/Fragment/Composable.
- [ ] ViewModel is injected via Hilt / Koin, not manual `ViewModelProvider`.
- [ ] Repository is injected, not manually instantiated.
