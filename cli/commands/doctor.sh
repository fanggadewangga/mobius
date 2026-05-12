#!/bin/bash

# MOBIUS doctor
# Version: 2.0.0

set -e

echo -e "${BLUE}🏥 Running MOBIUS doctor...${NC}"

# 1. Check if .mobius directory exists
if [ -d ".mobius" ]; then
    echo -e "  ${GREEN}✓ .mobius directory found${NC}"
else
    echo -e "  ${RED}✗ .mobius directory missing. Run 'mob init' first.${NC}"
fi

# 2. Check config file
if [ -f ".mobius/config/mobius.env" ]; then
    echo -e "  ${GREEN}✓ config file found${NC}"
    source ".mobius/config/mobius.env"
    echo -e "    Platform: $PLATFORM"
else
    echo -e "  ${RED}✗ config file missing${NC}"
fi

# 3. Check core files
if [ -f "$MOBIUS_HOME/core/CORE.md" ] || [ -f "$SCRIPT_DIR/../core/CORE.md" ]; then
    echo -e "  ${GREEN}✓ core/CORE.md found${NC}"
else
    echo -e "  ${RED}✗ core/CORE.md missing${NC}"
fi

# 4. Check platform plugin
PLUGIN_PATH=""
if [[ "$PLATFORM" == "android" || "$PLATFORM" == "flutter" || "$PLATFORM" == "ios" ]]; then
    PLUGIN_PATH="plugins/mobile"
elif [[ "$PLATFORM" == "go" ]]; then
    PLUGIN_PATH="plugins/backend"
else
    PLUGIN_PATH="plugins/web"
fi

if [ -d "$MOBIUS_HOME/$PLUGIN_PATH" ] || [ -d "$SCRIPT_DIR/../$PLUGIN_PATH" ]; then
    echo -e "  ${GREEN}✓ $PLUGIN_PATH plugin found${NC}"
else
    echo -e "  ${RED}✗ $PLUGIN_PATH plugin missing${NC}"
fi

# 5. Check agent files
AGENT_FILES=("CLAUDE.md" "AGENTS.md" ".cursor/rules/mobius.mdc")
for file in "${AGENT_FILES[@]}"; do
    if [ -f "$file" ]; then
        echo -e "  ${GREEN}✓ $file found${NC}"
    else
        echo -e "  ${YELLOW}⚠️ $file missing (not synced?)${NC}"
    fi
done

# 6. Check private contexts
if [ -d "$MOBIUS_HOME/contexts/private" ]; then
    if [ "$(ls -A "$MOBIUS_HOME/contexts/private" 2>/dev/null)" ]; then
        echo -e "  ${GREEN}✓ private context linked and populated${NC}"
    else
        echo -e "  ${YELLOW}⚠️ private context linked but empty (run submodule update)${NC}"
    fi
fi

echo -e "\n${BLUE}Doctor's report finished.${NC}"
