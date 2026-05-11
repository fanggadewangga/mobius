# Mobius — Android Project Context

## Platform
- Type: Android Native (Kotlin/Java)
- Min SDK: {{MIN_SDK}}
- Target SDK: {{TARGET_SDK}}

## Architecture
- Pattern: {{ANDROID_ARCH}}
- DI: {{ANDROID_DI}}
- Async: {{ANDROID_ASYNC}}
- UI: {{ANDROID_UI}}

## Testing
- Unit: {{ANDROID_UNIT_TEST}}
- UI: {{ANDROID_UI_TEST}}

## Team Conventions
- {{TEAM_CONVENTIONS}}

## Rules
- ALWAYS use ViewModelScope for coroutines.
- ALWAYS handle lifecycle and avoid context leaks.
- Repository pattern for data access.
- Use sealed classes for UI state.
- DO NOT add Gradle dependencies without asking.

## Active Skills
- think-before-coding
- simplicity-first
- no-hardcoded-strings (always active)
- mvvm-pattern (when applicable)
- mvi-pattern (when applicable)
- refactor-complex-function (always active)
