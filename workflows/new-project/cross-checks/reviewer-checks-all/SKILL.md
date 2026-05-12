---
name: reviewer-checks-all
trigger: automatic during phase-07-review
role: reviewer
---

# Cross-Check: Reviewer verifies Project Integrity

## Overview
The Reviewer checks the strategic alignment of the project, ensuring that the architecture, product spec, and implementation are in sync.

## Verification Checklist

### 1. Strategic Alignment
- Does the implementation still solve the problem defined in `SPEC.md`?
- Has there been "feature creep" that wasn't approved?
- Does the final code match the initial `ADR` decisions?

### 2. Consistency across Roles
- Are the `Product Agent`, `Engineer Lead`, and `Worker` communicating clearly through memory files?
- Are the QA Reports thorough, or are they skipping difficult checks?
- Is the `PROGRESS.md` accurate and up to date?

### 3. Maintainability & Standards
- Is the code clean and understandable for future agents?
- Are the naming conventions consistent across all features?
- Is the error handling strategy unified across the project?

## Feedback Loop
- **APPROVE**: "Reviewer approved Phase X. Architecture is sound, and implementation follows standards."
- **REQUEST CHANGES**: "Reviewer requested changes for Phase X. Code violates ADR-002 regarding layer isolation."
