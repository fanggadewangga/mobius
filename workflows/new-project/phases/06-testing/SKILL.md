---
name: new-project-testing
trigger: automatic after each task completion
phase: 06
role: qa-tester
inspired-by: Superpowers test-driven-development + verification-before-completion, gstack /qa
---

# Phase 06 — Testing & QA

## Workflow
Refer to `roles/qa-tester/ROLE.md` for the full checklist and report format.

## Principle: Verify Before Declaring Done (inspired by Superpowers)
NEVER declare a task "done" just because the code has been written.
"Done" = Tests pass + Coverage threshold met + QA Report PASS.

## TDD Enforcement
If the Worker DID NOT write tests before implementation:
1. QA flags as ❌ FAIL.
2. Worker must write tests first.
3. Verify test failure (RED) then implementation (GREEN).
4. Only then can QA approve.

## Platform-Specific Test Commands

```bash
# Flutter
flutter test --coverage
flutter analyze

# Android
./gradlew test
./gradlew lint

# Go
go test -race -cover ./...
golangci-lint run

# React/Next.js
npm run test -- --coverage
npm run lint
tsc --noEmit

# Vue/Nuxt
npm run test:unit
npm run lint
```
