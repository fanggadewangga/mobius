---
name: mobile-tdd
trigger: "test", "testing", "unit test"
---

# Mobile TDD (Test Driven Development)

In mobile apps, logic is often spread across layers. Enforce quality by writing tests first.

1. **Unit Tests First**: Write tests for repositories, use cases, and ViewModels/BLoCs before implementation.
2. **Mocking**: Use appropriate mocking libraries (Mocktail, Mockito, XCTest Mock) for external dependencies.
3. **Edge Case Coverage**: Test for empty data, network errors, and invalid inputs.
4. **Widget/UI Tests**: For critical UI components, write tests that verify interaction and rendering.

"Red → Green → Refactor"
- Write a failing test.
- Write the minimum code to make it pass.
- Clean up the code.
