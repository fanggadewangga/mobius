#!/bin/bash

# MOBIUS review
# Version: 1.0.0

set -e

SUBCOMMAND=$1
shift

case $SUBCOMMAND in
    run)
        SERVICE=$1
        if [ -z "$SERVICE" ]; then
            echo -e "${RED}Usage: mobius review run [service-name]${NC}"
            exit 1
        fi
        echo -e "${BLUE}📈 Running improvement review for: $SERVICE...${NC}"
        echo -e "${YELLOW}ℹ️  Please ask your AI agent to run the 'go-improvement-review' workflow for this service.${NC}"
        echo "The review will be saved to .mobius/reviews/$SERVICE-improvement-$(date +%Y-%m-%d).md"
        mkdir -p .mobius/reviews
        ;;
    list)
        echo -e "${BLUE}📋 Improvement Reviews:${NC}"
        if [ -d ".mobius/reviews" ]; then
            ls -1 .mobius/reviews
        else
            echo "No reviews generated yet."
        fi
        ;;
    *)
        echo "Usage: mobius review [run|list]"
        ;;
esac
