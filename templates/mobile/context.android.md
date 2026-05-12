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

## Mobius Integration
- Framework Path: {{MOBIUS_HOME}}
- **INSTRUCTION**: You are a Mobius-powered agent. Before performing any task, check for relevant skills in `{{MOBIUS_HOME}}/core/` and `{{MOBIUS_HOME}}/plugins/mobile/`.
- **TRIGGERS**: Follow the triggers defined in `{{MOBIUS_HOME}}/plugins/mobile/plugin.md`.

## Active Skills
- **Think Before Coding** (Karpathy)
- **Simplicity First** (Karpathy)
- **Brainstorming** (Superpowers)
- **Planning** (Superpowers)
- **TDD** (Superpowers)
- no-hardcoded-strings (always active)
- mvvm-pattern
- kotlin-flow-patterns
- mvi-pattern (when applicable)
- refactor-complex-function (always active)
