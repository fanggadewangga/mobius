#!/bin/bash

# MOBIUS diff
# Version: 1.2.0 (v2.0 continuation)

set -e

ACTION=$1
MOBIUS_DIR=".mobius"
DIFF_FILE="$MOBIUS_DIR/diff.json"

if [ ! -d "$MOBIUS_DIR" ]; then
    echo -e "${RED}❌ Mobius not initialized. Run 'mob init' first.${NC}"
    exit 1
fi

# Initialize JSON if not exists
if [ ! -f "$DIFF_FILE" ]; then
    echo "{\"project\": \"$(basename "$PWD")\", \"sessions\": []}" > "$DIFF_FILE"
fi

case $ACTION in
    baseline)
        echo -e "${BLUE}📊 Recording Baseline (Before Mobius)${NC}"
        echo "Please answer a few questions about your LAST task WITHOUT Mobius:"
        
        echo -n "Task description: "
        read TASK
        echo -n "Files touched (count): "
        read FILES
        echo -n "AI assumptions/wrong patterns (count): "
        read ASSUMPTIONS
        echo -n "Rework iterations needed (count): "
        read REWORK
        echo -n "Were tests written? (y/n): "
        read TESTS
        echo -n "Did the build pass on first try? (y/n): "
        read BUILD
        
        NEW_ENTRY="{\"date\":\"$(date +%Y-%m-%d)\", \"phase\":\"before\", \"task\":\"$TASK\", \"files_touched\":$FILES, \"ai_assumptions\":$ASSUMPTIONS, \"rework_count\":$REWORK, \"test_written\":\"$TESTS\", \"build_passed\":\"$BUILD\"}"
        
        # Robust append
        if grep -q "\"sessions\": \[\]" "$DIFF_FILE"; then
            sed -i '' "s|\[\]|\[$NEW_ENTRY\]|" "$DIFF_FILE" 2>/dev/null || sed -i "s|\[\]|\[$NEW_ENTRY\]|" "$DIFF_FILE"
        else
            sed -i '' "s|\]\}|,$NEW_ENTRY\]\}|" "$DIFF_FILE" 2>/dev/null || sed -i "s|\]\}|,$NEW_ENTRY\]\}|" "$DIFF_FILE"
        fi
        echo -e "${GREEN}✓ Baseline recorded!${NC}"
        ;;
        
    record)
        echo -e "${BLUE}📊 Recording Impact (With Mobius Active)${NC}"
        echo "Please answer a few questions about your RECENT task WITH Mobius:"
        
        echo -n "Task description: "
        read TASK
        echo -n "Files touched (count): "
        read FILES
        echo -n "AI assumptions/wrong patterns (count): "
        read ASSUMPTIONS
        echo -n "Rework iterations needed (count): "
        read REWORK
        echo -n "Were tests written? (y/n): "
        read TESTS
        echo -n "Did the build pass on first try? (y/n): "
        read BUILD
        
        # Web-specific questions
        USE_EFFECT="n/a"
        WRONG_STRAT="n/a"
        if [[ "$PLATFORM" == "react" || "$PLATFORM" == "nextjs" || "$PLATFORM" == "vue" || "$PLATFORM" == "nuxt" ]]; then
            echo -n "Did AI misuse useEffect/lifecycle for server data? (y/n): "
            read USE_EFFECT
            echo -n "Did AI use the wrong rendering strategy (SSR/CSR)? (y/n): "
            read WRONG_STRAT
        fi
        
        NEW_ENTRY="{\"date\":\"$(date +%Y-%m-%d)\", \"phase\":\"after\", \"task\":\"$TASK\", \"files_touched\":$FILES, \"ai_assumptions\":$ASSUMPTIONS, \"rework_count\":$REWORK, \"test_written\":\"$TESTS\", \"build_passed\":\"$BUILD\", \"use_effect_misuse\":\"$USE_EFFECT\", \"wrong_rendering\":\"$WRONG_STRAT\"}"
        
        if grep -q "\"sessions\": \[\]" "$DIFF_FILE"; then
            sed -i '' "s|\[\]|\[$NEW_ENTRY\]|" "$DIFF_FILE" 2>/dev/null || sed -i "s|\[\]|\[$NEW_ENTRY\]|" "$DIFF_FILE"
        else
            sed -i '' "s|\]\}|,$NEW_ENTRY\]\}|" "$DIFF_FILE" 2>/dev/null || sed -i "s|\]\}|,$NEW_ENTRY\]\}|" "$DIFF_FILE"
        fi
        echo -e "${GREEN}✓ Impact recorded!${NC}"
        ;;
        
    report)
        echo -e "${BLUE}📊 MOBIUS IMPACT REPORT${NC}"
        echo "──────────────────────────────────────────────────────"
        
        # Simple stats calculation using grep and awk
        calc_avg() {
            local phase=$1
            local field=$2
            # Extract the number after the colon for the specific field in the specific phase
            grep -o "\"phase\":\"$phase\"[^{}]*\"$field\":[0-9]*" "$DIFF_FILE" | rev | cut -d: -f1 | rev | awk '{ sum += $1; n++ } END { if (n > 0) printf "%.1f", sum / n; else print "0" }'
        }
        
        calc_count() {
            local phase=$1
            local field=$2
            local val=$3
            grep -o "\"phase\":\"$phase\"[^{}]*\"$field\":\"$val\"" "$DIFF_FILE" | wc -l | tr -d ' '
        }
        
        TOTAL_BEFORE=$(grep -o "\"phase\":\"before\"" "$DIFF_FILE" | wc -l | tr -d ' ')
        TOTAL_AFTER=$(grep -o "\"phase\":\"after\"" "$DIFF_FILE" | wc -l | tr -d ' ')
        
        if [ "$TOTAL_BEFORE" -eq 0 ] || [ "$TOTAL_AFTER" -eq 0 ]; then
            echo -e "${YELLOW}⚠️ Need at least one 'baseline' and one 'record' to show report.${NC}"
            echo "Current sessions: Before: $TOTAL_BEFORE, After: $TOTAL_AFTER"
            exit 0
        fi
        
        FILES_B=$(calc_avg "before" "files_touched")
        FILES_A=$(calc_avg "after" "files_touched")
        ASSUMP_B=$(calc_avg "before" "ai_assumptions")
        ASSUMP_A=$(calc_avg "after" "ai_assumptions")
        REWORK_B=$(calc_avg "before" "rework_count")
        REWORK_A=$(calc_avg "after" "rework_count")
        TEST_B=$(calc_count "before" "test_written" "y")
        TEST_A=$(calc_count "after" "test_written" "y")
        BUILD_B=$(calc_count "before" "build_passed" "y")
        BUILD_A=$(calc_count "after" "build_passed" "y")
        
        calc_delta() {
            local b=$1
            local a=$2
            local lower_is_better=$3
            if (( $(echo "$b == 0" | bc -l) )); then
                echo "N/A"
                return
            fi
            local delta=$(echo "($a - $b) / $b * 100" | bc -l)
            if (( $(echo "$delta < 0" | bc -l) )); then
                if [ "$lower_is_better" == "true" ]; then echo "↓ $(printf "%.0f" ${delta#-})% ✅"; else echo "↓ $(printf "%.0f" ${delta#-})% ⚠️"; fi
            else
                if [ "$lower_is_better" == "true" ]; then echo "↑ $(printf "%.0f" $delta)% ⚠️"; else echo "↑ $(printf "%.0f" $delta)% ✅"; fi
            fi
        }

        echo -e "METRIC              BEFORE     AFTER      DELTA"
        echo "──────────────────────────────────────────────────────"
        printf "Files touched/task  %-10s %-10s %s\n" "$FILES_B" "$FILES_A" "$(calc_delta $FILES_B $FILES_A true)"
        printf "AI assumptions/task %-10s %-10s %s\n" "$ASSUMP_B" "$ASSUMP_A" "$(calc_delta $ASSUMP_B $ASSUMP_A true)"
        printf "Rework iterations   %-10s %-10s %s\n" "$REWORK_B" "$REWORK_A" "$(calc_delta $REWORK_B $REWORK_A true)"
        printf "Tests written       %s/%-8d %s/%-8d %s\n" "$TEST_B" "$TOTAL_BEFORE" "$TEST_A" "$TOTAL_AFTER" "$(calc_delta $(echo "$TEST_B/$TOTAL_BEFORE" | bc -l) $(echo "$TEST_A/$TOTAL_AFTER" | bc -l) false)"
        printf "Build pass (1st try) %s/%-8d %s/%-8d %s\n" "$BUILD_B" "$TOTAL_BEFORE" "$BUILD_A" "$TOTAL_AFTER" "$(calc_delta $(echo "$BUILD_B/$TOTAL_BEFORE" | bc -l) $(echo "$BUILD_A/$TOTAL_AFTER" | bc -l) false)"
        
        # Web-specific metrics in report
        if [[ "$PLATFORM" == "react" || "$PLATFORM" == "nextjs" || "$PLATFORM" == "vue" || "$PLATFORM" == "nuxt" ]]; then
            EFFECT_A=$(calc_count "after" "use_effect_misuse" "y")
            STRAT_A=$(calc_count "after" "wrong_rendering" "y")
            printf "useEffect misuse    %-10s %-10d %s\n" "N/A" "$EFFECT_A" "$(if [ "$EFFECT_A" -eq 0 ]; then echo "✅ Perfect"; else echo "⚠️ $EFFECT_A issues"; fi)"
            printf "Wrong rendering strat %-10s %-10d %s\n" "N/A" "$STRAT_A" "$(if [ "$STRAT_A" -eq 0 ]; then echo "✅ Perfect"; else echo "⚠️ $STRAT_A issues"; fi)"
        fi
        echo "──────────────────────────────────────────────────────"
        ;;
        
    *)
        echo "Usage: mobius diff [baseline|record|report]"
        ;;
esac
