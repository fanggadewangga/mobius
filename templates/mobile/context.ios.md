# Mobius — iOS Project Context

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
