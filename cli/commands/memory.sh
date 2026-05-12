#!/bin/bash

# MOBIUS memory command
# Version: 1.0.0

set -e

SUBCOMMAND=$1
shift || true

MOBIUS_DIR=".mobius"
MEMORY_DIR="$MOBIUS_DIR/memory"

case $SUBCOMMAND in
    show)
        echo -e "${BLUE}🧠 Project Memory Summary:${NC}"
        [ -f "$MEMORY_DIR/SPEC.md" ] && echo "  - Spec: $(head -n 1 "$MEMORY_DIR/SPEC.md")"
        [ -f "$MEMORY_DIR/IMPLEMENTATION_PLAN.md" ] && echo "  - Plan: $(grep -c "TASK-" "$MEMORY_DIR/IMPLEMENTATION_PLAN.md") tasks defined"
        [ -f "$MEMORY_DIR/PROGRESS.md" ] && echo "  - Progress: $(grep "✅" "$MEMORY_DIR/PROGRESS.md" | wc -l) phases completed"
        ;;
    
    adr)
        ADR_SUB=$1
        case $ADR_SUB in
            list)
                ls "$MEMORY_DIR/ADR"
                ;;
            new)
                TITLE=$2
                [ -z "$TITLE" ] && echo "Usage: mobius memory adr new [title]" && exit 1
                FILE_NAME="ADR-$(printf "%03d" $(ls "$MEMORY_DIR/ADR" | wc -l | xargs expr 1 +))-$(echo "$TITLE" | tr ' ' '-').md"
                cp "$MOBIUS_HOME/workflows/new-project/memory/templates/ADR.md" "$MEMORY_DIR/ADR/$FILE_NAME"
                echo -e "${GREEN}✅ New ADR created: $MEMORY_DIR/ADR/$FILE_NAME${NC}"
                ;;
            *)
                echo "Usage: mobius memory adr [list|new]"
                exit 1
                ;;
        esac
        ;;

    *)
        echo "Usage: mobius memory [show|adr]"
        exit 1
        ;;
esac
