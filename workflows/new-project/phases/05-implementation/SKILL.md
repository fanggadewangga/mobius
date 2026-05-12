---
name: new-project-implementation
trigger: automatic after phase-04 approved
phase: 05
role: engineer-worker
inspired-by: Superpowers executing-plans + TDD, APM Worker, Karpathy surgical-changes
---

# Phase 05 — Implementation

## Per-Task Workflow
Refer to `roles/engineer-worker/ROLE.md` for the full per-task workflow.

## Dispatch Pattern
For every task in the Implementation Plan:
1. Engineer Lead assigns the task to a Worker (can be parallel for independent tasks).
2. Worker executes with the TDD workflow.
3. Worker reports completion + updates TASK_LOG.
4. Automatic trigger for Phase 06 (QA) for the completed task.

## Parallelism Guidelines
Tasks can be done in parallel if:
- There is no dependency between tasks.
- They touch different domains (frontend task vs backend task).
- Engineer Lead has confirmed there is no shared state involved.

## Task Assignment Format

```
ASSIGN TASK-003 to Worker
Context: [Relevant sections from SPEC.md and IMPLEMENTATION_PLAN.md]
Constraints: [platform context, naming conventions, etc.]
Do NOT: [Explicitly out-of-scope actions]
When done: Update TASK_LOG and notify QA
```
