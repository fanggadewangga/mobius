# Mobius New Project Workflow

## Prerequisites
Before running this workflow, ensure you have:
- A rough idea or requirement (details not necessary yet)
- A clear target platform (mobile/web/backend)
- Mobius installed and initialized in the new project folder

## Execution Guide

```bash
# 1. Create a new project folder
mkdir MyNewProject && cd MyNewProject

# 2. Initialize Mobius (generates all agent context files)
mobius init

# 3. Start the new project workflow from scratch
mobius new-project start

# → Mobius will ask:
#   - Which platform? (mobile/web/backend)
#   - Any deadlines or specific constraints?
#   - Do you have design/mockups? (optional upload)
#   - Optional dependencies to activate?
#     [ ] Superpowers (recommended)
#     [ ] APM (for large projects/teams)
#     [ ] gstack (for solo devs)

# 4. Follow the prompts for each phase
```

## Phase Transition Rules

**NO phase can be skipped.**
**EVERY transition requires explicit approval from the developer.**

```
Phase 01 Ideation  → Required: Developer approves idea summary
Phase 02 Spec      → Required: Developer signs off on PRD/spec document
Phase 03 Arch      → Required: Developer approves ADR and architecture diagram
Phase 04 Planning  → Required: Developer reviews implementation plan per task
Phase 05 Implement → Required: Each task completion → trigger QA (Phase 06)
Phase 06 Testing   → Required: All tests pass, coverage threshold met
Phase 07 Review    → Required: No critical findings from the Reviewer
Phase 08 Ship      → Required: Developer confirms final check before commit/PR
```

## Optional Dependencies

If **Superpowers** is enabled:
- Phase 01 uses the `brainstorming` skill from Superpowers.
- Phase 04 uses `writing-plans` from Superpowers.
- Phase 05 uses `subagent-driven-development` from Superpowers.
- Phase 06 uses `test-driven-development` from Superpowers.

If **APM** is enabled:
- Phase 04 generates an APM-compatible Implementation Plan.
- Phase 05 can use the APM Manager → Worker dispatch pattern.

If **gstack** is enabled:
- Phase 02 uses `/office-hours` for idea validation.
- Phase 03 uses `/plan-eng-review` and `/plan-design-review`.
- Phase 07 uses `/review` from gstack.
- Phase 08 uses `/ship` from gstack.
