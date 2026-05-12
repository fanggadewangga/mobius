#!/bin/bash

# MOBIUS context
# Version: 1.0.0

set -e

COMMAND=$1
shift

case $COMMAND in
    list)
        echo -e "${BLUE}📋 Available Contexts:${NC}"
        echo "Public:"
        ls "$MOBIUS_HOME/templates/mobile" | grep "context"
        ls "$MOBIUS_HOME/templates/web" | grep "context"
        ls "$MOBIUS_HOME/templates/backend" | grep "context" 2>/dev/null || true
        
        if [ -d "$MOBIUS_HOME/contexts/private" ]; then
            echo -e "\n${YELLOW}🔒 Private Contexts:${NC}"
            find "$MOBIUS_HOME/contexts/private" -name "context.*.md" | xargs -n 1 basename
        fi
        ;;
    add-private)
        URL=$1
        if [ -z "$URL" ]; then
            echo -e "${RED}Usage: mobius context add-private [git-url]${NC}"
            exit 1
        fi
        echo -e "${BLUE}🔗 Adding private context submodule...${NC}"
        git submodule add "$URL" contexts/private
        echo -e "${GREEN}✓ Private context added!${NC}"
        ;;
    sync-private)
        echo -e "${BLUE}🔄 Syncing private context...${NC}"
        git submodule update --remote contexts/private
        echo -e "${GREEN}✓ Private context synced!${NC}"
        ;;
    status)
        if [ -d "$MOBIUS_HOME/contexts/private" ]; then
            echo -e "${GREEN}✅ Private context is linked.${NC}"
            cd "$MOBIUS_HOME/contexts/private" && git status -s
        else
            echo -e "${YELLOW}ℹ️ No private context linked.${NC}"
        fi
        ;;
    *)
        echo "Usage: mobius context [list|add-private|sync-private|status]"
        ;;
esac
