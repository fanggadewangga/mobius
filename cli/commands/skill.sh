#!/bin/bash
# MOBIUS skill
# Version: 2.1.0

set -e

SUBCOMMAND=$1

if [ -z "$SUBCOMMAND" ]; then
    echo "Usage: mobius skill [list|create|<skill-name>]"
    exit 0
fi

case $SUBCOMMAND in
    create)
        shift
        source "$COMMANDS_DIR/skill-create.sh" "$@"
        ;;
    list)
        echo -e "${BLUE}🔄 MOBIUS Skills List${NC}"
        echo "──────────────────────────────────────────────"
        
        # Core Skills
        echo -e "${YELLOW}Core Skills:${NC}"
        find "$MOBIUS_HOME/core" -name "SKILL.md" | xargs dirname | xargs -n1 basename | sort | sed 's/^/  - /'
        
        # Mobile Plugins
        echo -e "\n${YELLOW}Mobile Skills:${NC}"
        find "$MOBIUS_HOME/plugins/mobile" -name "SKILL.md" | xargs dirname | xargs -n1 basename | sort | sed 's/^/  - /'
        
        # Web Plugins
        echo -e "\n${YELLOW}Web Skills:${NC}"
        find "$MOBIUS_HOME/plugins/web" -name "SKILL.md" | xargs dirname | xargs -n1 basename | sort | sed 's/^/  - /'
        
        # Backend Plugins
        echo -e "\n${YELLOW}Backend Skills:${NC}"
        find "$MOBIUS_HOME/plugins/backend" -name "SKILL.md" | xargs dirname | xargs -n1 basename | sort | sed 's/^/  - /'
        
        echo "──────────────────────────────────────────────"
        ;;
    *)
        # Search for skill in modular structure
        SKILL_NAME=$SUBCOMMAND
        SKILL_PATH=""
        POSSIBLE_PATHS=(
            ".mobius/skills/$SKILL_NAME/SKILL.md"
            "$MOBIUS_HOME/core/skills/$SKILL_NAME/SKILL.md"
            "$MOBIUS_HOME/core/workflow/$SKILL_NAME/SKILL.md"
            "$MOBIUS_HOME/plugins/mobile/flutter/$SKILL_NAME/SKILL.md"
            "$MOBIUS_HOME/plugins/mobile/android/$SKILL_NAME/SKILL.md"
            "$MOBIUS_HOME/plugins/mobile/shared/$SKILL_NAME/SKILL.md"
            "$MOBIUS_HOME/plugins/web/react/$SKILL_NAME/SKILL.md"
            "$MOBIUS_HOME/plugins/web/vue/$SKILL_NAME/SKILL.md"
            "$MOBIUS_HOME/plugins/web/tanstack/$SKILL_NAME/SKILL.md"
            "$MOBIUS_HOME/plugins/web/shared/$SKILL_NAME/SKILL.md"
            "$MOBIUS_HOME/plugins/backend/go/$SKILL_NAME/SKILL.md"
            "$MOBIUS_HOME/plugins/backend/go/understand-codebase/SKILL.md"
            "$MOBIUS_HOME/plugins/backend/go/security-audit/SKILL.md"
            "$MOBIUS_HOME/plugins/backend/go/improvement-review/SKILL.md"
        )
        
        for path in "${POSSIBLE_PATHS[@]}"; do
            if [ -f "$path" ]; then
                SKILL_PATH="$path"
                break
            fi
        done
        
        if [ -n "$SKILL_PATH" ]; then
            echo -e "${BLUE}📖 Displaying skill: $SKILL_NAME${NC}"
            echo "─────────────────────────────────────────────"
            cat "$SKILL_PATH"
            echo -e "\n─────────────────────────────────────────────"
        else
            echo -e "${RED}❌ Skill not found: $SKILL_NAME${NC}"
        fi
        ;;
esac
