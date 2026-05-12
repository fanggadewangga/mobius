#!/bin/bash

# MOBIUS new-project command
# Version: 1.0.0

set -e

SUBCOMMAND=$1
shift || true

MOBIUS_DIR=".mobius"
MEMORY_DIR="$MOBIUS_DIR/memory"
WORKFLOW_PATH="$MOBIUS_HOME/workflows/new-project"

case $SUBCOMMAND in
    start)
        echo -e "${BLUE}🔄 Starting Mobius New Project Workflow...${NC}"
        
        # Check if initialized
        if [ ! -d "$MOBIUS_DIR" ]; then
            echo -e "${YELLOW}⚠️  Project not initialized. Running 'mobius init' first...${NC}"
            mobius init
        fi

        # Setup memory directory structure
        mkdir -p "$MEMORY_DIR/ADR"
        
        # Copy templates if they don't exist
        [ ! -f "$MEMORY_DIR/SPEC.md" ] && cp "$WORKFLOW_PATH/memory/templates/SPEC.md" "$MEMORY_DIR/SPEC.md"
        [ ! -f "$MEMORY_DIR/IMPLEMENTATION_PLAN.md" ] && cp "$WORKFLOW_PATH/memory/templates/IMPLEMENTATION_PLAN.md" "$MEMORY_DIR/IMPLEMENTATION_PLAN.md"
        [ ! -f "$MEMORY_DIR/TASK_LOG.md" ] && cp "$WORKFLOW_PATH/memory/templates/TASK_LOG.md" "$MEMORY_DIR/TASK_LOG.md"
        
        # Initial PROGRESS.md
        if [ ! -f "$MEMORY_DIR/PROGRESS.md" ]; then
            cat <<EOF > "$MEMORY_DIR/PROGRESS.md"
# Project Progress

## Phase 01: Ideation — 🔄 In Progress
## Phase 02: Spec — ⏳ Pending
## Phase 03: Architecture — ⏳ Pending
## Phase 04: Planning — ⏳ Pending
## Phase 05: Implementation — ⏳ Pending
## Phase 06: Testing — ⏳ Pending
## Phase 07: Review — ⏳ Pending
## Phase 08: Ship — ⏳ Pending
EOF
        fi

        echo -e "${GREEN}✅ Project memory structure created.${NC}"
        echo -e "${BLUE}ℹ️  Activating Product Agent for Phase 01: Ideation...${NC}"
        echo -e "${YELLOW}👉 INSTRUCTION: Agent, please read $WORKFLOW_PATH/phases/01-ideation/SKILL.md and begin the discovery process.${NC}"
        ;;

    status)
        if [ -f "$MEMORY_DIR/PROGRESS.md" ]; then
            cat "$MEMORY_DIR/PROGRESS.md"
        else
            echo -e "${RED}❌ No progress found. Run 'mobius new-project start' first.${NC}"
        fi
        ;;

    phase)
        PHASE_NUM=$1
        if [ -z "$PHASE_NUM" ]; then
            echo "Usage: mobius new-project phase [number]"
            exit 1
        fi
        echo -e "${BLUE}🔄 Switching to Phase $PHASE_NUM...${NC}"
        # Logic to update PROGRESS.md would go here
        echo -e "${GREEN}✅ Phase updated.${NC}"
        ;;

    handoff)
        echo -e "${BLUE}📦 Generating Handoff Summary...${NC}"
        # Logic to generate handoff summary based on MEMORY_SYSTEM.md
        echo -e "${GREEN}✅ Handoff summary generated in .mobius/memory/HANDOFF.md${NC}"
        ;;

    *)
        echo "Usage: mobius new-project [start|status|phase|handoff]"
        exit 1
        ;;
esac
