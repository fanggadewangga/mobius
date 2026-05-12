---
name: new-project-review
trigger: after all tasks in a phase are complete + QA pass
phase: 07
role: reviewer
inspired-by: gstack /review, Superpowers requesting-code-review + receiving-code-review
---

# Phase 07 — Code Review

## Workflow
Refer to `roles/reviewer/ROLE.md` for the full checklist and report format.

## Cross-Model Review (Optional)
For critical features, cross-agent review can be performed:
- Primary review: Main agent used.
- Secondary review: Different agent (e.g., using GPT-4 to cross-check Claude).
- Cross-analysis: Compare findings from both reviews.

## When to Block vs When to Note
Block (cannot proceed to the next phase):
- There are 🔴 CRITICAL findings not yet resolved.
- There are 🟠 MAJOR findings with no plan to fix.

May proceed with notes:
- All findings are 🟡 MINOR or 💡 SUGGESTION.
- Developer acknowledges and creates tickets for 🟡 findings.
