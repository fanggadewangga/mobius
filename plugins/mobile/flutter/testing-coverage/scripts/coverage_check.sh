#!/bin/bash
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# Mobius Flutter Coverage Check Script
# Usage: ./coverage_check.sh [keywords_or_path] [target_%]
# Example 1 (Keywords): ./coverage_check.sh v2,totp 80
# Example 2 (Path):     ./coverage_check.sh lib/features/transfer 80
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

set -e

INPUT_PARAM="${1:-v2,totp}"
TARGET_COVERAGE="${2:-80}"
LCOV_FILE="coverage/lcov.info"
FEATURE_LCOV="coverage/feature.info"
CLEAN_LCOV="coverage/feature_clean.info"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m'

echo -e "${CYAN}🧪 Mobius Coverage Check${NC}"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo -e "  Scope:  ${YELLOW}${INPUT_PARAM}${NC}"
echo -e "  Target: ${YELLOW}${TARGET_COVERAGE}%${NC}"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# Step 1: Run tests
echo -e "\n${CYAN}[1/4]${NC} Running flutter test --coverage..."
flutter test --coverage 2>&1 | tail -5

if [ ! -f "$LCOV_FILE" ]; then
  echo -e "${RED}❌ No coverage file generated at ${LCOV_FILE}${NC}"
  exit 1
fi

# Step 2: Extract scope-specific coverage (Path vs Keywords)
if [[ "$INPUT_PARAM" == *"/"* ]]; then
  echo -e "${CYAN}[2/4]${NC} Extracting coverage for path: ${INPUT_PARAM}..."
  lcov --extract "$LCOV_FILE" "${INPUT_PARAM}/*" \
       -o "$FEATURE_LCOV" \
       --quiet 2>/dev/null || {
    echo -e "${RED}❌ Failed to extract coverage for path: ${INPUT_PARAM}${NC}"
    echo "   Ensure that tests have been executed successfully."
    exit 1
  }
else
  echo -e "${CYAN}[2/4]${NC} Extracting coverage for keywords: ${INPUT_PARAM}..."
  
  # Parse keywords by comma and build glob array
  IFS=',' read -r -a KW_ARR <<< "$INPUT_PARAM"
  GLOB_PATTERNS=()
  for kw in "${KW_ARR[@]}"; do
    # Trim whitespaces
    kw=$(echo "$kw" | xargs)
    # Match any path containing the keyword (e.g. '*v2*' or '*totp*')
    GLOB_PATTERNS+=("*$kw*")
  done
  
  lcov --extract "$LCOV_FILE" "${GLOB_PATTERNS[@]}" \
       -o "$FEATURE_LCOV" \
       --quiet 2>/dev/null || {
    echo -e "${RED}❌ Failed to extract coverage using keywords: ${INPUT_PARAM}${NC}"
    echo "   Double check if any matches exist in the test coverage report."
    exit 1
  }
fi

# Step 3: Remove generated files
echo -e "${CYAN}[3/4]${NC} Removing generated files from report..."
lcov --remove "$FEATURE_LCOV" \
     '*.g.dart' \
     '*.freezed.dart' \
     '*.config.dart' \
     '*.gen.dart' \
     '*.gr.dart' \
     '**/generated/**' \
     '**/l10n/**' \
     -o "$CLEAN_LCOV" \
     --quiet 2>/dev/null

# Step 4: Parse and display results
echo -e "${CYAN}[4/4]${NC} Analyzing results..."
echo ""

SUMMARY=$(lcov --summary "$CLEAN_LCOV" 2>&1)
LINES_PCT=$(echo "$SUMMARY" | grep "lines" | grep -oE '[0-9]+\.[0-9]+%' | head -1 | tr -d '%')
FUNCTIONS_PCT=$(echo "$SUMMARY" | grep "functions" | grep -oE '[0-9]+\.[0-9]+%' | head -1 | tr -d '%')
BRANCHES_PCT=$(echo "$SUMMARY" | grep "branches" | grep -oE '[0-9]+\.[0-9]+%' | head -1 | tr -d '%')

echo "┌─────────────────────────────────────────┐"
echo "│         📊 COVERAGE REPORT              │"
echo "├─────────────────────────────────────────┤"
printf "│  Lines:     %-10s                  │\n" "${LINES_PCT:-N/A}%"
printf "│  Functions: %-10s                  │\n" "${FUNCTIONS_PCT:-N/A}%"
printf "│  Branches:  %-10s                  │\n" "${BRANCHES_PCT:-N/A}%"
echo "├─────────────────────────────────────────┤"
printf "│  Target:    %-10s                  │\n" "${TARGET_COVERAGE}%"
echo "└─────────────────────────────────────────┘"

if [ -n "$LINES_PCT" ]; then
  PASS=$(echo "$LINES_PCT >= $TARGET_COVERAGE" | bc -l 2>/dev/null || echo "0")
  if [ "$PASS" = "1" ]; then
    echo -e "\n${GREEN}✅ PASS — Coverage meets target!${NC}"
    exit 0
  else
    DELTA=$(echo "$TARGET_COVERAGE - $LINES_PCT" | bc -l 2>/dev/null || echo "?")
    echo -e "\n${RED}❌ FAIL — Need ${DELTA}% more coverage${NC}"
    echo -e "\n${YELLOW}📋 Scoped files below 100% coverage:${NC}"
    lcov --list "$CLEAN_LCOV" 2>&1 | grep -v "100.0%" | tail -n +3 || true
    exit 1
  fi
else
  echo -e "\n${YELLOW}⚠️ Could not parse coverage percentage (no matching files found in scope)${NC}"
  exit 1
fi
