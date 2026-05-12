#!/bin/bash

# MOBIUS CLI
# Version: 1.1.0

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Determine the directory of the script
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
MOBIUS_HOME="${MOBIUS_HOME:-$(dirname "$SCRIPT_DIR")}"
export MOBIUS_HOME

# Check if command is provided
if [ $# -eq 0 ]; then
    echo -e "${BLUE}🔄 MOBIUS — Mobile AI Skills Framework${NC}"
    echo "Usage: mobius [command] [options]"
    echo ""
    echo "Commands:"
    echo "  init      Initialize Mobius in current project"
    echo "  sync      Sync context from template to agent files"
    echo "  on        Enable Mobius (restore agent files)"
    echo "  off       Disable Mobius (backup agent files)"
    echo "  skill     Manage or display skills"
    echo "  context   Manage public and private contexts"
    echo "  docs      Generate/manage service documentation"
    echo "  audit     Run security audit on services"
    echo "  review    Run improvement review on services"
    echo "  doctor    Check Mobius health"
    echo "  diff      Measure AI impact (baseline/record/report)"
    echo "  status    Show current Mobius state"
    echo "  update    Update Mobius to latest version"
    exit 1
fi

COMMAND=$1
shift

COMMANDS_DIR="$SCRIPT_DIR/commands"

# Execute command if it exists
if [ -f "$COMMANDS_DIR/$COMMAND.sh" ]; then
    source "$COMMANDS_DIR/$COMMAND.sh" "$@"
else
    echo -e "${RED}Unknown command: $COMMAND${NC}"
    exit 1
fi
