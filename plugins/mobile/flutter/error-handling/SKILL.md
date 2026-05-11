---
name: flutter-error-handling
trigger: "error", "exception", "try catch", "failure", "result"
platform: mobile/flutter
---

# Flutter Error Handling

## Recommended Pattern: Result / Either

```dart
// ✅ CORRECT — use Either / Result, do not throw exceptions to UI
// With dartz or fpdart:
Future<Either<Failure, User>> login(String email, String password);

// Or custom Result:
sealed class Result<T> {
  const Result();
}
class Success<T> extends Result<T> {
  final T data;
  const Success(this.data);
}
class Failure<T> extends Result<T> {
  final String message;
  final Exception? exception;
  const Failure(this.message, {this.exception});
}
```

## Do Not Let Exceptions Bubble to UI

```dart
// ❌ WRONG — UI has to try-catch?
Future<void> onLoginPressed() async {
  try {
    final user = await loginUseCase(email, password); // can throw
    // navigate
  } catch (e) {
    // handle in UI — wrong
  }
}

// ✅ CORRECT — Repository/UseCase already handles, returns Result
Future<void> onLoginPressed() async {
  final result = await loginUseCase(email, password);
  result.fold(
    (failure) => emit(LoginError(failure.message)),
    (user) => emit(LoginSuccess(user)),
  );
}
```

## Failure Types
```dart
sealed class Failure {
  final String message;
  const Failure(this.message);
}
class NetworkFailure extends Failure {
  const NetworkFailure(super.message);
}
class ServerFailure extends Failure {
  const ServerFailure(super.message);
}
class CacheFailure extends Failure {
  const CacheFailure(super.message);
}
class ValidationFailure extends Failure {
  const ValidationFailure(super.message);
}
```
