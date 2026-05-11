#!/bin/bash
# mobius skill create — interactive skill creation wizard
# Version: 2.1.0

set -e

# Load colors if available
BLUE='\033[0;34m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${BLUE}🔄 MOBIUS — Skill Creator${NC}"
echo "──────────────────────────────────────────────"
echo ""

# Step 1: Skill name
read -p "Skill name (kebab-case, e.g., flutter-no-hardcoded-colors): " SKILL_NAME

if [[ -z "$SKILL_NAME" ]]; then
    echo -e "${RED}❌ Skill name cannot be empty.${NC}"
    exit 1
fi

# Step 2: Platform
echo -e "\nPlatform:"
echo "  1) all (universal)"
echo "  2) mobile/flutter"
echo "  3) mobile/android"
echo "  4) mobile/shared"
echo "  5) web/react"
echo "  6) web/vue"
echo "  7) web/tanstack"
echo "  8) web/shared"
read -p "Select [1-8]: " PLATFORM_CHOICE

case $PLATFORM_CHOICE in
  1) PLATFORM="all"; DIR="core/skills/$SKILL_NAME" ;;
  2) PLATFORM="mobile/flutter"; DIR="plugins/mobile/flutter/$SKILL_NAME" ;;
  3) PLATFORM="mobile/android"; DIR="plugins/mobile/android/$SKILL_NAME" ;;
  4) PLATFORM="mobile/shared"; DIR="plugins/mobile/shared/$SKILL_NAME" ;;
  5) PLATFORM="web/react"; DIR="plugins/web/react/$SKILL_NAME" ;;
  6) PLATFORM="web/vue"; DIR="plugins/web/vue/$SKILL_NAME" ;;
  7) PLATFORM="web/tanstack"; DIR="plugins/web/tanstack/$SKILL_NAME" ;;
  8) PLATFORM="web/shared"; DIR="plugins/web/shared/$SKILL_NAME" ;;
  *) echo -e "${RED}❌ Invalid choice.${NC}"; exit 1 ;;
esac

# Step 3: Trigger words
read -p "Trigger words/phrases (comma separated): " TRIGGERS

# Step 4: Generate from template
FULL_DIR="$MOBIUS_HOME/$DIR"
if [ -z "$MOBIUS_HOME" ]; then
    # Fallback to relative path if MOBIUS_HOME not set (for local dev)
    FULL_DIR="./$DIR"
fi

mkdir -p "$FULL_DIR"
cat > "$FULL_DIR/SKILL.md" << EOF
---
name: $SKILL_NAME
trigger: $TRIGGERS
platform: $PLATFORM
---

# [Skill Title]

<!-- Explain the problem this skill solves -->

## FORBIDDEN Patterns

\`\`\`
// ❌ WRONG
// [add code examples of what NOT to do]
\`\`\`

## CORRECT Patterns

\`\`\`
// ✅ CORRECT
// [add code examples of what to do instead]
\`\`\`

## Checklist
- [ ] [verification item 1]
- [ ] [verification item 2]
EOF

echo ""
echo -e "${GREEN}✅ Skill template created at: $DIR/SKILL.md${NC}"
echo ""
echo "Next steps:"
echo "  1. Edit the file — fill in the skill content."
echo "  2. Read core/workflow/writing-skills/SKILL.md for a full guide."
echo "  3. Test the skill: ask an AI agent if the response matches expectations."
echo "  4. Run: mobius doctor — verify no formatting errors."
echo "  5. Commit to the team repository."
