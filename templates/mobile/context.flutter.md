# Mobius — Flutter Project Context

## Platform
- Type: Flutter (Android + iOS)
- Flutter version: {{FLUTTER_VERSION}}
- Min Android SDK: {{MIN_ANDROID_SDK}}
- Min iOS: {{MIN_IOS}}

## Architecture
- Pattern: {{FLUTTER_ARCH}}
- DI: {{FLUTTER_DI}}
- Async: async/await + Streams
- Navigation: {{FLUTTER_NAV}}

## State Management
- {{FLUTTER_STATE_MGMT}}

## Testing
- Unit: flutter_test
- Widget: flutter_test
- Integration: integration_test

## Team Conventions
- {{TEAM_CONVENTIONS}}

## Rules
- Folder structure: feature-first.
- Naming: snake_case files, PascalCase classes.
- DO NOT add packages to pubspec.yaml without asking.
- Run `flutter analyze` before every commit.

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
- auto-route (navigation)
- const-sizing (always active)
- no-hardcoded-colors (always active)
- flutter-change-splash (multi-flavor)
- flutter-change-app-icon (multi-flavor)
