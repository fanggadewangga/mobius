---
name: android-mvi-pattern
trigger: "intent", "action", "reducer", "state", "side effect", "create screen"
platform: mobile/android
---

# Android MVI Pattern

## MVI Concept
```
User Interaction
      ↓
   Intent/Action (sealed class — what happened)
      ↓
   ViewModel / Reducer (process intent → new state)
      ↓
   State (data class — immutable snapshot of UI)
      ↓
   UI (render state)
      ↓ side effects (one-time events: navigation, toast)
   Effect (sealed class — fire-and-forget)
```

## MVI Template

```kotlin
// 1. Intent — what the user does
sealed class LoginIntent {
    data class EmailChanged(val email: String) : LoginIntent()
    data class PasswordChanged(val password: String) : LoginIntent()
    object LoginClicked : LoginIntent()
    object ForgotPasswordClicked : LoginIntent()
}

// 2. State — current UI snapshot (MUST be immutable / data class)
data class LoginState(
    val email: String = "",
    val password: String = "",
    val isLoading: Boolean = false,
    val emailError: UiText? = null,
    val passwordError: UiText? = null,
)

// 3. Effect — one-time events (navigation, toast, etc.)
sealed class LoginEffect {
    data class NavigateToHome(val user: User) : LoginEffect()
    data class ShowError(val message: UiText) : LoginEffect()
}

// 4. ViewModel
@HiltViewModel
class LoginViewModel @Inject constructor(
    private val loginUseCase: LoginUseCase
) : ViewModel() {

    private val _state = MutableStateFlow(LoginState())
    val state: StateFlow<LoginState> = _state.asStateFlow()

    private val _effect = Channel<LoginEffect>(Channel.BUFFERED)
    val effect = _effect.receiveAsFlow()

    fun dispatch(intent: LoginIntent) {
        when (intent) {
            is LoginIntent.EmailChanged -> _state.update { it.copy(email = intent.email) }
            is LoginIntent.PasswordChanged -> _state.update { it.copy(password = intent.password) }
            is LoginIntent.LoginClicked -> handleLogin()
            is LoginIntent.ForgotPasswordClicked -> { /* navigate */ }
        }
    }

    private fun handleLogin() = viewModelScope.launch {
        _state.update { it.copy(isLoading = true) }
        loginUseCase(_state.value.email, _state.value.password)
            .onSuccess { user -> _effect.send(LoginEffect.NavigateToHome(user)) }
            .onFailure { e -> _effect.send(LoginEffect.ShowError(e.toUiText())) }
        _state.update { it.copy(isLoading = false) }
    }
}

// 5. Composable
@Composable
fun LoginScreen(viewModel: LoginViewModel = hiltViewModel()) {
    val state by viewModel.state.collectAsStateWithLifecycle()

    LaunchedEffect(Unit) {
        viewModel.effect.collect { effect ->
            when (effect) {
                is LoginEffect.NavigateToHome -> { /* navigate */ }
                is LoginEffect.ShowError -> { /* show snackbar */ }
            }
        }
    }

    LoginContent(
        state = state,
        onIntent = viewModel::dispatch
    )
}
```

## MVI Anti-Patterns
```kotlin
// ❌ WRONG — State is not immutable
class LoginState {
    var isLoading = false  // mutable — wrong
    var email = ""         // mutable — wrong
}

// ❌ WRONG — Direct view update from ViewModel (MVVM style)
_uiState.value = Loading  // OK in MVVM, but MVI uses reducer/dispatch

// ❌ WRONG — Navigation logic in ViewModel (should be in Effect)
fun login() { navController.navigate("home") }  // ViewModel should not hold navController
```

## Checklist
- [ ] State is a `data class` with all val (immutable).
- [ ] Every user action calls `dispatch(Intent)`.
- [ ] Navigation and one-time events go through `Effect` / `Channel`, not directly in State.
- [ ] `state.update { it.copy(...) }` — always use copy, do not mutate directly.
