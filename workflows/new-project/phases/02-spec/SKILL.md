---
name: new-project-spec
trigger: automatic after phase-01 approved
phase: 02
role: product-agent
output: .mobius/memory/SPEC.md
inspired-by: APM Spec document, gstack /plan-ceo-review
---

# Phase 02 — Product Specification

## 🛑 WORKFLOW CONSTRAINTS
- **NEVER** write feature code or propose implementation plans. Focus ONLY on the "WHAT" (Product), not the "HOW" (Technical).
- **NEVER** skip to Phase 03 without an explicitly approved `SPEC.md`.
- **ALWAYS** check `.mobius/memory/PROGRESS.md` to confirm you are in Phase 02.

## Product Agent Tasks
Transform the ideation summary into an actionable specification document for engineers.

## Output: SPEC.md

```markdown
# Product Specification
Project: [name]
Version: 1.0 (MVP)
Date: YYYY-MM-DD
Author: Product Agent

## Problem Statement
[1-2 paragraphs — the problem being solved, not the solution]

## Target User
Primary: [specific persona]
Secondary: [optional]

## Core Features (MVP)
All features below are MANDATORY for the MVP.
Order = priority.

### F-01: [Feature Name]
Description: [what the user can do]
User story: As a [user], I want to [action] so that [benefit]
Acceptance criteria:
- [ ] [criteria 1 — verifiable]
- [ ] [criteria 2 — verifiable]

### F-02: [Feature Name]
...

## Out of Scope (MVP)
The following features are NOT in the MVP — to be considered for v2:
- [feature A] — reason for deferral
- [feature B] — reason for deferral

## Technical Constraints
- Platform: [mobile/web/backend]
- Must work offline: [yes/no]
- Performance requirement: [specific]
- Security requirement: [specific]

## Success Metrics
Within [timeframe]:
- Metric 1: [target number]
- Metric 2: [target number]

## Risks & Mitigations
| Risk | Likelihood | Impact | Mitigation |
|------|------------|--------|------------|
| [risk] | H/M/L | H/M/L | [mitigation] |
```

## Gate: Developer must review and sign off on SPEC.md before Phase 03.
