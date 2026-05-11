# Contributing to MOBIUS

We welcome contributions from the team! Mobius is a living framework that grows with our expertise.

## How to Add a New Skill

1. Create a new directory in `skills/` (e.g., `skills/flutter/my-new-skill/`).
2. Create a `SKILL.md` file in that directory.
3. Follow the standard format:
   ```markdown
   ---
   name: skill-name
   trigger: "keywords", "for", "ai"
   ---
   # Skill Title
   ... content ...
   ```
4. Test the skill by running `mobius skill skill-name`.

## How to Update Context Templates

1. Edit the files in `templates/`.
2. Add placeholders in `{{UPPERCASE_VARIABLE}}` format.
3. Ensure `cli/commands/init.sh` is updated to ask for the new variable if needed.

## Reporting Issues

If Mobius suggests a wrong pattern or ignores a convention, please update the corresponding skill or context template.
