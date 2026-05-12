---
name: new-project-ship
trigger: after phase-07 approved
phase: 08
inspired-by: Superpowers finishing-a-development-branch, gstack /ship
---

# Phase 08 — Ship

## Pre-Ship Checklist (MANDATORY all checked)
- [ ] All tasks in this phase are QA PASS.
- [ ] Code review APPROVED (no open critical/major findings).
- [ ] `IMPLEMENTATION_PLAN.md` updated (completed tasks marked as done).
- [ ] `TASK_LOG.md` updated with all tasks from this phase.
- [ ] No TODO/FIXME related to this feature in the code.
- [ ] Changelog updated.

## Commit Convention

```
[type]([scope]): [description]

type: feat|fix|test|refactor|docs|chore
scope: feature name or domain
description: present tense, lowercase

Example:
feat(auth): implement login with JWT token
test(auth): add unit tests for login use case
fix(transfer): prevent double debit with distributed lock
```

## Output Options (Developer Choice)
1. **Commit to current branch** — for work in progress.
2. **Create PR** — for code review by human team.
3. **Merge to main** — for direct deployment.
4. **Keep on feature branch** — for later review.

## Post-Ship
- Update `PROGRESS.md`.
- Small celebration 🎉.
- Start the next phase or conclude the project.
