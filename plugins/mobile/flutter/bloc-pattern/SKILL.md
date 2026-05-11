---
name: flutter-bloc-pattern
trigger: "bloc", "cubit", "state", "event", "create feature"
platform: mobile/flutter
---

# Flutter BLoC Pattern

## Cubit vs BLoC
- Use **Cubit** if: state changes are simple, no complex event stream transformations needed.
- Use **BLoC** if: there are event transformations (debounce, switchMap), or logic is more complex.

## Cubit Template
```dart
class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._loginUseCase) : super(LoginInitial());

  final LoginUseCase _loginUseCase;

  Future<void> login(String email, String password) async {
    emit(LoginLoading());
    final result = await _loginUseCase(email, password);
    result.fold(
      (failure) => emit(LoginFailure(failure.message)),
      (user) => emit(LoginSuccess(user)),
    );
  }
}
```

## BLoC Template
```dart
class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc(this._searchUseCase) : super(SearchInitial()) {
    on<SearchQueryChanged>(_onQueryChanged);
  }

  Future<void> _onQueryChanged(
    SearchQueryChanged event,
    Emitter<SearchState> emit,
  ) async {
    if (event.query.isEmpty) return emit(SearchInitial());
    emit(SearchLoading());
    final result = await _searchUseCase(event.query);
    result.fold(
      (failure) => emit(SearchFailure(failure.message)),
      (results) => emit(SearchSuccess(results)),
    );
  }
}
```

## State Structure
```dart
// ✅ CORRECT — sealed class for state
sealed class LoginState {}
class LoginInitial extends LoginState {}
class LoginLoading extends LoginState {}
class LoginSuccess extends LoginState {
  final User user;
  LoginSuccess(this.user);
}
class LoginFailure extends LoginState {
  final String message;
  LoginFailure(this.message);
}
```

## Checklist
- [ ] Cubit/BLoC is provided via `BlocProvider` above the widget tree that needs it.
- [ ] No `BlocProvider.of(context)` outside the proper widget tree.
- [ ] State is immutable (use `copyWith` or new sealed class instances).
- [ ] No business logic in Widgets — delegate to Cubit/BLoC.
