#!/bin/bash

# MOBIUS sync
# Version: 1.1.0

set -e

MOBIUS_DIR=".mobius"
CONFIG_FILE="$MOBIUS_DIR/config/mobius.env"

if [ ! -f "$CONFIG_FILE" ]; then
    echo -e "${RED}❌ Mobius not initialized. Run 'mobius init' first.${NC}"
    exit 1
fi

# Load variables
source "$CONFIG_FILE"

# Find source context file
SOURCE_FILE=$(ls "$MOBIUS_DIR"/context.*.md | head -n 1)

if [ ! -f "$SOURCE_FILE" ]; then
    echo -e "${RED}❌ Source context file not found in $MOBIUS_DIR${NC}"
    exit 1
fi

echo -e "${BLUE}🔄 Syncing context to agent files...${NC}"

# Create a temporary file for processing
TEMP_CONTEXT=$(mktemp)
cp "$SOURCE_FILE" "$TEMP_CONTEXT"

# Simple placeholder replacement using sed
while IFS='=' read -r key value; do
    # Skip comments and empty lines
    [[ "$key" =~ ^#.*$ ]] && continue
    [[ -z "$key" ]] && continue
    
    # Strip quotes from value
    clean_value=$(echo "$value" | sed -e 's/^"//' -e 's/"$//')
    
    # Replace {{KEY}} with clean_value in TEMP_CONTEXT
    sed -i '' "s|{{$key}}|$clean_value|g" "$TEMP_CONTEXT" 2>/dev/null || sed -i "s|{{$key}}|$clean_value|g" "$TEMP_CONTEXT"
done < "$CONFIG_FILE"

# Propagation Logic
HEADER_MDC="---\ndescription: Mobius mobile context\nglobs: **/*\n---\n"

# 1. Claude Code
cp "$TEMP_CONTEXT" CLAUDE.md && echo -e "  ${GREEN}✓ CLAUDE.md updated${NC}"

# 2. AGENTS.md (Universal)
cp "$TEMP_CONTEXT" AGENTS.md && echo -e "  ${GREEN}✓ AGENTS.md updated${NC}"

# 3. Gemini CLI
cp "$TEMP_CONTEXT" GEMINI.md && echo -e "  ${GREEN}✓ GEMINI.md updated${NC}"

# 4. GitHub Copilot
mkdir -p .github && cp "$TEMP_CONTEXT" .github/copilot-instructions.md && echo -e "  ${GREEN}✓ .github/copilot-instructions.md updated${NC}"

# 5. Amazon Kiro
mkdir -p .kiro/steering && cp "$TEMP_CONTEXT" .kiro/steering/mobius.md && echo -e "  ${GREEN}✓ .kiro/steering/mobius.md updated${NC}"

# 6. Cursor (MDC format)
mkdir -p .cursor/rules && echo -e "$HEADER_MDC" | cat - "$TEMP_CONTEXT" > .cursor/rules/mobius.mdc && echo -e "  ${GREEN}✓ .cursor/rules/mobius.mdc updated${NC}"

# 7. Windsurf
mkdir -p .windsurf/rules && cp "$TEMP_CONTEXT" .windsurf/rules/mobius.md && echo -e "  ${GREEN}✓ .windsurf/rules/mobius.md updated${NC}"

rm "$TEMP_CONTEXT"

echo -e "${GREEN}✨ Sync complete!${NC}"
