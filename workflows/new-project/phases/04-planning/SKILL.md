---
name: new-project-planning
trigger: automatic after phase-03 approved
phase: 04
role: engineer-lead
output: .mobius/memory/IMPLEMENTATION_PLAN.md
inspired-by: Superpowers writing-plans, APM Implementation Plan, gstack /autoplan
---

# Phase 04 — Implementation Planning

## 🛑 WORKFLOW CONSTRAINTS
- **NEVER** start coding until the `IMPLEMENTATION_PLAN.md` is approved.
- **NEVER** skip task-level breakdown. Every task must be actionable and verifiable.
- **ALWAYS** check `.mobius/memory/PROGRESS.md` to confirm you are in Phase 04.

## Rules for a Good Plan (inspired by Superpowers)
- Every task = 2-4 hours of work.
- Every task has an explicit file list.
- Every task has VERIFIABLE acceptance criteria (not "works correctly").
- Task dependencies are explicit.
- The plan is detailed enough for a "junior engineer with poor taste" to execute.

## When to use APM?
**Use APM if:**
- Project > 3 weeks of development.
- More than 1 human developer in the team.
- More than 3 domains need parallel work.

**Standard Mobius plan is enough if:**
- Solo project < 3 weeks.
- Scope is clear and static.

## Plan Format (Mobius Standard)

```markdown
# Implementation Plan
Project: [name]
Generated: YYYY-MM-DD
Approved: [approval date]
Total estimated: [X] days

## Phases

### Phase 1: Foundation ([X] days)
Tasks: TASK-001, TASK-002, TASK-003
Goal: Project scaffold + core entities functional.

### Phase 2: Core Features ([X] days)
Tasks: TASK-004 through TASK-008
Goal: F-01 and F-02 from the spec completed and tested.

### Phase 3: Polish & Integration ([X] days)
Tasks: TASK-009 through TASK-012
Goal: UI polish, error handling, integration testing.

## Task Details
[Format from roles/engineer-lead/ROLE.md]
```

## Gate: Developer reviews every task. May request breaking down large tasks.
