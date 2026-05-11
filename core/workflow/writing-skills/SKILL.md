---
name: writing-skills
trigger: "add skill", "create new skill", "skill for", "buat skill baru"
platform: all
---

# Writing Mobius Skills

When asked to create a new skill for Mobius, follow this process.

## Step 1 — Identify a Real Problem

Before writing a skill, answer:
- **What problem happens frequently?** (e.g., "AI uses Navigator.push while project uses auto_route")
- **How often does it happen?** (If rare, it might not need to be a skill)
- **What should the AI do instead?**
- **Which platform / framework is affected?**

If you cannot answer the first question specifically, **it is not time to create a skill yet** — collect more examples first.

## Step 2 — Choose the Right Location

```
Universal problem (all platforms)?
  → core/skills/ or core/workflow/

Mobile-specific problem (Android + Flutter)?
  → plugins/mobile/shared/

Android-specific problem?
  → plugins/mobile/android/

Flutter-specific problem?
  → plugins/mobile/flutter/

Web-specific problem?
  → plugins/web/shared/ or plugins/web/react/ / vue/ / tanstack/
```

## Step 3 — Write SKILL.md using this Template

```markdown
---
name: [skill-name-kebab-case]
trigger: [words/phrases that trigger this skill — comma separated]
platform: [mobile/flutter | mobile/android | web/react | all | etc.]
---

# [Skill Title]

## [Context — optional, explain why this skill exists]

## [FORBIDDEN Patterns — with code examples]

## [CORRECT Patterns — with code examples]

## [Notes / Exceptions — optional]

## Checklist
- [ ] [verifiable item]
- [ ] [verifiable item]
```

## Step 4 — Rules for Writing Good Skills

**DO:**
- Include concrete code examples (`❌ WRONG` vs `✅ CORRECT`).
- Create actionable checklists that can be verified one by one.
- Write specific triggers — the more specific, the better.
- Include brief reasons *why* this rule exists (context helps the AI agent).
- Ideal size: 50-150 lines. If larger — split into two skills.

**DON'T:**
- Do not write overly general rules ("write good code").
- Do not duplicate rules existing in other skills — link to those instead.
- Do not include rules applicable only to a specific file/class (that's for project-level instructions, not a skill).
- Do not write skills for extremely rare cases (< 1x per sprint).

## Step 5 — Register Skill in Plugin Manifest

After the SKILL.md file is created, add an entry to the relevant `plugin.md`:

```markdown
## Skills
- [skill-name]: [one-line description] | trigger: [main trigger]
```

## Step 6 — Test the Skill

Before committing:
1. Read the skill from an AI perspective — are the instructions clear and unambiguous?
2. Create sample prompts that should trigger this skill — does the trigger match?
3. Ask the AI agent: "Based on this skill, how would you handle [sample case]?" — verify the response matches expectations.
4. Run `mobius doctor` — check for formatting errors.
