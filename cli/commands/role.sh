#!/bin/bash

# MOBIUS role command
# Version: 1.0.0

set -e

ROLE_NAME=$1

if [ -z "$ROLE_NAME" ]; then
    echo "Usage: mobius role [product|lead|worker|qa|reviewer]"
    exit 1
fi

case $ROLE_NAME in
    product|product-agent)
        echo -e "${BLUE}🎯 Activating Product Agent Role...${NC}"
        echo -e "${YELLOW}👉 INSTRUCTION: Agent, adopt the persona in $MOBIUS_HOME/workflows/new-project/roles/product-agent/ROLE.md${NC}"
        ;;
    lead|engineer-lead)
        echo -e "${BLUE}🏗️  Activating Engineer Lead Role...${NC}"
        echo -e "${YELLOW}👉 INSTRUCTION: Agent, adopt the persona in $MOBIUS_HOME/workflows/new-project/roles/engineer-lead/ROLE.md${NC}"
        ;;
    worker|engineer-worker)
        echo -e "${BLUE}⚙️  Activating Engineer Worker Role...${NC}"
        echo -e "${YELLOW}👉 INSTRUCTION: Agent, adopt the persona in $MOBIUS_HOME/workflows/new-project/roles/engineer-worker/ROLE.md${NC}"
        ;;
    qa|qa-tester)
        echo -e "${BLUE}🔍 Activating QA Tester Role...${NC}"
        echo -e "${YELLOW}👉 INSTRUCTION: Agent, adopt the persona in $MOBIUS_HOME/workflows/new-project/roles/qa-tester/ROLE.md${NC}"
        ;;
    reviewer)
        echo -e "${BLUE}📋 Activating Reviewer Role...${NC}"
        echo -e "${YELLOW}👉 INSTRUCTION: Agent, adopt the persona in $MOBIUS_HOME/workflows/new-project/roles/reviewer/ROLE.md${NC}"
        ;;
    *)
        echo -e "${RED}❌ Unknown role: $ROLE_NAME${NC}"
        exit 1
        ;;
esac
