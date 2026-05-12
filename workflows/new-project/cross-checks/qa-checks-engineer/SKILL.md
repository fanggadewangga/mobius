---
name: qa-checks-engineer
trigger: automatic during phase-06-testing
role: qa-tester
---

# Cross-Check: QA verifies Engineer Worker

## Overview
This check ensures that the Engineer Worker is following standards and providing sufficient evidence of correctness before a task is considered finished.

## Verification Checklist

### 1. TDD Adherence
- Did the Worker write tests before implementation?
- Is there evidence that tests failed (RED) before they passed (GREEN)?
- *If not: Flag as FAIL and request TDD workflow.*

### 2. Implementation Accuracy
- Does the code exactly match the files listed in the task assignment?
- Were there any unauthorized file changes? (Surgical Changes check)
- Do all acceptance criteria from the assignment have corresponding tests?

### 3. Log Integrity
- Is the `TASK_LOG.md` entry complete?
- Does the reported coverage match actual test execution results?
- Are decisions made during implementation documented?

## Feedback Loop
- **PASS**: "QA verified TASK-XXX. All criteria met. High test quality confirmed."
- **FAIL**: "QA rejected TASK-XXX. Missing edge case tests for [X]. TDD workflow not followed."
