#!/bin/bash

# MOBIUS audit
# Version: 1.0.0

set -e

SUBCOMMAND=$1
shift

case $SUBCOMMAND in
    generate|run)
        SERVICE=$1
        if [ -z "$SERVICE" ]; then
            echo -e "${RED}Usage: mobius audit [service-name]${NC}"
            exit 1
        fi
        echo -e "${BLUE}🛡️  Running security audit for: $SERVICE...${NC}"
        echo -e "${YELLOW}ℹ️  Please ask your AI agent to run the 'go-security-audit' workflow for this service.${NC}"
        echo "The report will be saved to .mobius/security/$SERVICE-audit-$(date +%Y-%m-%d).md"
        mkdir -p .mobius/security
        ;;
    list)
        echo -e "${BLUE}📋 Security Audit Reports:${NC}"
        if [ -d ".mobius/security" ]; then
            ls -1 .mobius/security
        else
            echo "No audit reports generated yet."
        fi
        ;;
    summary)
        echo -e "${BLUE}📊 Security Audit Summary:${NC}"
        if [ -d ".mobius/security" ]; then
            grep -h "Total findings" .mobius/security/*.md 2>/dev/null || echo "No findings found."
        else
            echo "No reports found."
        fi
        ;;
    *)
        echo "Usage: mobius audit [run|list|summary]"
        ;;
esac
