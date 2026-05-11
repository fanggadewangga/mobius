---
name: mobile-brainstorming
trigger: "new feature", "tambah fitur", "buat screen", "implement"
---

# Mobile Brainstorming

When a new mobile feature is requested, DO NOT start coding immediately.

## Step 1: Clarify the Feature

Ask (one at a time, not all at once):
- What is the user story? (As a user, I want to...)
- What platform(s)? Android only, iOS only, or both via Flutter?
- Are there existing screens/flows this connects to?
- What are the edge cases? (no internet, empty state, error state)

## Step 2: Define Success Criteria

Before implementation, state clearly:
- [ ] Unit tests pass
- [ ] Widget/UI tests pass (if applicable)
- [ ] Build succeeds on target platform(s)
- [ ] No new lint warnings introduced
- [ ] Figma/design matches (if design is provided)

## Step 3: Present Mini-Plan

Break into layers:
1. Data layer (API, local DB, repository)
2. Domain layer (use case, model)
3. Presentation layer (ViewModel/Bloc, UI)

Get approval before proceeding.
