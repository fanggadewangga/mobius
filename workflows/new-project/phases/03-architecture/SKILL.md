---
name: new-project-architecture
trigger: automatic after phase-02 approved
phase: 03
role: engineer-lead
output: .mobius/memory/ADR/, architecture diagram
inspired-by: gstack /plan-eng-review, APM Planner, Karpathy think-before-coding
---

# Phase 03 — Architecture & Technical Design

## 🛑 WORKFLOW CONSTRAINTS
- **NEVER** write actual feature code. Focus ONLY on the structure, patterns, and technical decisions.
- **NEVER** skip to Phase 04 without an explicitly approved `ADR` and folder structure.
- **ALWAYS** check `.mobius/memory/PROGRESS.md` to confirm you are in Phase 03.

## Engineer Lead Tasks

### Step 1: Read Spec Thoroughly
Identify:
- Required data entities.
- User flows to support.
- Integrations (third party, API, etc.).
- Non-functional requirements (performance, offline, etc.).

### Step 2: Architecture Decision (YAGNI First)
**Principle: Build the simplest thing that works.**
- Start with a monolith unless there is a strong reason for microservices.
- Start with one database unless more are necessary.
- Add complexity ONLY if the spec requires it.

### Step 3: Generate Output

**ADR-001-initial-architecture.md** (Save in `.mobius/memory/ADR/`)

**Architecture Diagram** (Mermaid):
```mermaid
graph TD
    [diagram based on selected platform]
```

**Tech Stack Decisions** — For every choice, explain WHY:
```markdown
## Tech Stack Decisions

### State Management: BLoC
Why: Team is familiar, project complexity is medium → BLoC is appropriate.
Why not Riverpod: No significant advantage for this scope.
Why not Provider: Too simple for the existing business logic.

### Navigation: auto_route
Why: Type-safe, code-gen reduces boilerplate, already used in other projects.
```

**Folder Structure**:
```
lib/
├── core/
├── features/
│   └── [feature]/
│       ├── data/
│       ├── domain/
│       └── presentation/
└── main.dart
```

## Gate: Developer approves ADR + diagram + folder structure before Phase 04.

## Anti-Over-Engineering Checklist
- [ ] Is every layer in this architecture actually required by the spec?
- [ ] Does the added complexity solve a real problem or a theoretical one?
- [ ] Can a junior engineer understand this architecture?
- [ ] Can this be built in a reasonable amount of time?
