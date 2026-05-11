#!/bin/bash

# MOBIUS off
# Version: 1.1.0

set -e

echo -e "${BLUE}🔄 Disabling MOBIUS (backing up agent files)...${NC}"

AGENT_FILES=("CLAUDE.md" "AGENTS.md" "GEMINI.md" ".github/copilot-instructions.md" ".kiro/steering/mobius.md" ".cursor/rules/mobius.mdc" ".windsurf/rules/mobius.md")

for file in "${AGENT_FILES[@]}"; do
    if [ -f "$file" ]; then
        mv "$file" "$file.bak"
        echo -e "  ${GREEN}✓ $file backed up to $file.bak${NC}"
    fi
done

echo -e "${GREEN}MOBIUS disabled.${NC}"
