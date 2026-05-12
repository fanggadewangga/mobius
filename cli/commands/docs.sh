#!/bin/bash

# MOBIUS docs
# Version: 1.0.0

set -e

SUBCOMMAND=$1
shift

case $SUBCOMMAND in
    generate)
        SERVICE=$1
        if [ -z "$SERVICE" ]; then
            echo -e "${RED}Usage: mobius docs generate [service-name]${NC}"
            exit 1
        fi
        echo -e "${BLUE}🔍 Analyzing service: $SERVICE...${NC}"
        echo -e "${YELLOW}ℹ️  Please ask your AI agent to run the 'go-understand-codebase' workflow for this service.${NC}"
        echo "The output will be saved to .mobius/docs/$SERVICE-deep-dive-$(date +%Y-%m).md"
        mkdir -p .mobius/docs
        ;;
    list)
        echo -e "${BLUE}📋 Generated Documentation:${NC}"
        if [ -d ".mobius/docs" ]; then
            ls -1 .mobius/docs
        else
            echo "No documentation generated yet."
        fi
        ;;
    open)
        DOC=$1
        if [ -z "$DOC" ] || [ ! -f ".mobius/docs/$DOC" ]; then
            echo -e "${RED}Usage: mobius docs open [doc-name]${NC}"
            exit 1
        fi
        open ".mobius/docs/$DOC"
        ;;
    *)
        echo "Usage: mobius docs [generate|list|open]"
        ;;
esac
