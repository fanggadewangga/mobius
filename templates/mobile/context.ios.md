# Mobius — iOS Project Context

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
- mvvm-pattern

## Platform
- Type: iOS Native (Swift)
- Min iOS: {{MIN_IOS}}

## Architecture
- Pattern: {{IOS_ARCH}}
- DI: {{IOS_DI}}
- Async: {{IOS_ASYNC}} (Swift Concurrency / Combine)
- UI: {{IOS_UI}} (SwiftUI / UIKit)

## Testing
- Unit: XCTest
- UI: XCUITest

## Team Conventions
- {{TEAM_CONVENTIONS}}

## Rules
- ALWAYS use weak self in closures to avoid retain cycles.
- Preference for Swift Concurrency (async/await) over GCD where possible.
- Use protocols for dependency injection.
- DO NOT change project settings or build phases without asking.
