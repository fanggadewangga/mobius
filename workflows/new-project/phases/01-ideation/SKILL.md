---
name: new-project-ideation
trigger: "new project", "start project", "create new app", "new idea"
phase: 01
role: product-agent
inspired-by: Superpowers brainstorming, gstack /office-hours
---

# Phase 01 — Ideation

## Activation
This skill activates automatically when a developer starts a new project or mentions the triggers above in a project without a specification.

## 🛑 WORKFLOW CONSTRAINTS
- **NEVER** provide code snippets, folder structures, or implementation plans in this phase.
- **NEVER** ask more than one discovery question at a time.
- **ALWAYS** check `.mobius/memory/PROGRESS.md` to confirm you are in Phase 01.

## Process

### Step 1: Activate Product Agent Role
The agent adopts the Product Agent persona (see `roles/product-agent/ROLE.md`).

### Step 2: YC-Style Discovery Questions
Ask these one by one — **DO NOT** ask all at once. Wait for the developer's response before moving to the next question.

```
Q1: "Tell me about the problem you want to solve. Not the features — the problem."
    (wait for answer, then dig deeper)

Q2: "Who is the first person who will use this? Not 'everyone' — one specific person."

Q3: "Right now, without this app, what are they doing to solve that same problem?"

Q4: "What is the single smallest feature that would make them want to try the app?"

Q5: "In 3 months, what number will tell you that this was a success?"
```

### Step 3: Summarize and Confirm
After all questions are answered, summarize in this format:

```markdown
## Ideation Summary
Problem: [1 sentence]
User: [specific]
Current alternative: [what they use now]
MVP wedge: [smallest valuable feature]
Success metric: [concrete number]
Key risk: [one thing that could kill this project]
```

Ask: "Is this summary accurate? Approve to proceed to Phase 02?"

## Gate: You cannot proceed to Phase 02 without explicit developer approval of this summary.
