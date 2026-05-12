---
name: lead-reviews-worker
trigger: automatic after Worker reports completion
role: engineer-lead
---

# Cross-Check: Lead verifies Worker Task

## Overview
The Engineer Lead ensures that the Worker has executed the task according to the plan and standards before handing it over to QA.

## Verification Checklist

### 1. Task Fidelity
- Did the Worker implement all sub-tasks defined in the Implementation Plan?
- Are the created/modified files exactly as requested?
- Are the acceptance criteria actually addressed in the code?

### 2. Technical Quality
- Does the implementation follow the established patterns (BLoC, Clean Arch, etc.)?
- Is there any over-engineering beyond what the task required?
- Is the code readable and well-structured?

### 3. Readiness for QA
- Has the Worker provided enough context in the `TASK_LOG.md`?
- Are the tests relevant and covering the logic correctly?
- Is the environment ready for the QA/Tester to run?

## Feedback Loop
- **PROCEED**: "Lead verified TASK-XXX. Ready for QA."
- **REVISE**: "Lead rejected TASK-XXX. Implementation of [X] is missing. Please fix before QA."
