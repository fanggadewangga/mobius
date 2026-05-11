#!/bin/bash

# MOBIUS on
# Version: 1.1.0

set -e

echo -e "${BLUE}🔄 Enabling MOBIUS (restoring agent files)...${NC}"

AGENT_FILES=("CLAUDE.md" "AGENTS.md" "GEMINI.md" ".github/copilot-instructions.md" ".kiro/steering/mobius.md" ".cursor/rules/mobius.mdc" ".windsurf/rules/mobius.md")

for file in "${AGENT_FILES[@]}"; do
    if [ -f "$file.bak" ]; then
        mv "$file.bak" "$file"
        echo -e "  ${GREEN}✓ $file restored from $file.bak${NC}"
    elif [ -f ".mobius/config/mobius.env" ]; then
        # If no backup but initialized, suggest sync
        echo -e "  ${YELLOW}⚠️ $file.bak not found. Run 'mob sync' if you need to regenerate agent files.${NC}"
    fi
done

echo -e "${GREEN}MOBIUS enabled.${NC}"
