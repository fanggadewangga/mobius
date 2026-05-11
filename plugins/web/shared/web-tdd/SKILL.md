---
name: web-tdd
trigger: "test", "testing", "vitest", "jest", "unit test"
platform: web
---

# Web TDD (Test Driven Development)

1. **Component Testing**: Use Vitest + React Testing Library (or Vue Test Utils) to verify UI behavior.
2. **Hook Testing**: Test custom hooks in isolation.
3. **Mocking**: Use MSW (Mock Service Worker) for network requests to avoid brittle mocks.
4. **Coverage**: Focus on business logic and complex UI interactions.

"Write tests that resemble how your software is used."
