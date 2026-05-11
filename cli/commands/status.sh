#!/bin/bash

# MOBIUS status
# Version: 2.0.0

set -e

if [ ! -d ".mobius" ]; then
    echo -e "${YELLOW}🔄 MOBIUS not initialized in this project.${NC}"
    exit 0
fi

source ".mobius/config/mobius.env"

echo -e "${BLUE}🔄 MOBIUS v2.0 active — $PLATFORM project${NC}"
echo "─────────────────────────────────────────────"
echo -e "Context    : ${GREEN}✅ .mobius/context.*.md${NC}"

# Detect active plugins based on platform
echo -e "Plugins    : @mobius/core"
if [[ "$PLATFORM" == "android" || "$PLATFORM" == "flutter" || "$PLATFORM" == "ios" ]]; then
    echo -e "             @mobius/plugin-mobile"
else
    echo -e "             @mobius/plugin-web"
    if [ "$HAS_TANSTACK" == "yes" ]; then
        echo -e "             @mobius/plugin-web/tanstack"
    fi
fi

# Check sync status
AGENT_FILES=("CLAUDE.md" "AGENTS.md" ".cursor/rules/mobius.mdc")
echo -n "Agent sync : "
for file in "${AGENT_FILES[@]}"; do
    if [ -f "$file" ]; then
        echo -ne "${GREEN}✅ $(basename "$file" .mdc) ${NC}"
    else
        echo -ne "${RED}✗ $(basename "$file" .mdc) ${NC}"
    fi
done
echo ""

echo "─────────────────────────────────────────────"
if [ -f ".mobius/diff.json" ]; then
    SESSIONS=$(grep -o "\"task\"" ".mobius/diff.json" | wc -l | tr -d ' ')
    echo -e "📊 Diff tracking: ON  ($SESSIONS sessions recorded)"
else
    echo -e "📊 Diff tracking: OFF"
fi
echo "─────────────────────────────────────────────"
