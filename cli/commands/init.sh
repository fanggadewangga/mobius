#!/bin/bash

# MOBIUS init
# Version: 2.0.0 (Modular + Web)

set -e

echo -e "${BLUE}🔄 Initializing MOBIUS in current project...${NC}"

# 1. Detect Platform
detect_platform() {
    # Mobile Detection
    if [ -f "pubspec.yaml" ]; then echo "flutter"; return; fi
    if [ -f "build.gradle" ] || [ -f "build.gradle.kts" ]; then echo "android"; return; fi
    if [ -f "Package.swift" ] || ls *.xcodeproj &> /dev/null || ls *.xcworkspace &> /dev/null; then echo "ios"; return; fi
    
    # Web Detection
    if [ -f "package.json" ]; then
        if grep -q "\"next\":" package.json; then echo "nextjs"; return; fi
        if grep -q "\"nuxt\":" package.json; then echo "nuxt"; return; fi
        if grep -q "\"react\":" package.json; then echo "react"; return; fi
        if grep -q "\"vue\":" package.json; then echo "vue"; return; fi
        echo "web-generic"; return
    fi
    
    echo "unknown"
}

PLATFORM=$(detect_platform)

if [ "$PLATFORM" == "unknown" ]; then
    echo -e "${YELLOW}⚠️ Platform not automatically detected.${NC}"
    echo -n "Select platform (android/flutter/ios/react/nextjs/vue/nuxt/other): "
    read PLATFORM
fi

echo -e "${GREEN}✓ Detected platform: $PLATFORM${NC}"

# Detect Plugins
HAS_TANSTACK="no"
if [ -f "package.json" ] && grep -q "@tanstack" package.json; then
    HAS_TANSTACK="yes"
    echo -e "${GREEN}✓ Detected TanStack plugin${NC}"
fi

# 2. Setup Mobius Directory
MOBIUS_DIR=".mobius"
mkdir -p "$MOBIUS_DIR/skills"
mkdir -p "$MOBIUS_DIR/config"

# 3. Questionnaire
echo -e "\n${BLUE}📝 Configuration Questionnaire:${NC}"

# Load default common variables
echo "PLATFORM=\"$PLATFORM\"" > "$MOBIUS_DIR/config/mobius.env"
echo "HAS_TANSTACK=\"$HAS_TANSTACK\"" >> "$MOBIUS_DIR/config/mobius.env"

case $PLATFORM in
    android)
        echo -n "Architecture (default: MVVM): " && read ARCH && ARCH=${ARCH:-MVVM}
        echo -n "DI Framework (default: Hilt): " && read DI && DI=${DI:-Hilt}
        echo "ANDROID_ARCH=\"$ARCH\"" >> "$MOBIUS_DIR/config/mobius.env"
        echo "ANDROID_DI=\"$DI\"" >> "$MOBIUS_DIR/config/mobius.env"
        echo "MIN_SDK=\"24\"" >> "$MOBIUS_DIR/config/mobius.env"
        echo "TARGET_SDK=\"34\"" >> "$MOBIUS_DIR/config/mobius.env"
        echo "ANDROID_ASYNC=\"Coroutines\"" >> "$MOBIUS_DIR/config/mobius.env"
        echo "ANDROID_UI=\"Jetpack Compose\"" >> "$MOBIUS_DIR/config/mobius.env"
        TEMPLATE_TYPE="mobile"
        TEMPLATE_NAME="android"
        ;;
    flutter)
        echo -n "State Management (default: BLoC): " && read STATE && STATE=${STATE:-BLoC}
        echo "FLUTTER_STATE_MGMT=\"$STATE\"" >> "$MOBIUS_DIR/config/mobius.env"
        echo "FLUTTER_VERSION=\"3.x\"" >> "$MOBIUS_DIR/config/mobius.env"
        echo "MIN_ANDROID_SDK=\"24\"" >> "$MOBIUS_DIR/config/mobius.env"
        echo "MIN_IOS=\"15.0\"" >> "$MOBIUS_DIR/config/mobius.env"
        echo "FLUTTER_ARCH=\"Clean Architecture\"" >> "$MOBIUS_DIR/config/mobius.env"
        echo "FLUTTER_DI=\"get_it\"" >> "$MOBIUS_DIR/config/mobius.env"
        echo "FLUTTER_NAV=\"go_router\"" >> "$MOBIUS_DIR/config/mobius.env"
        TEMPLATE_TYPE="mobile"
        TEMPLATE_NAME="flutter"
        ;;
    ios)
        echo -n "UI Framework (default: SwiftUI): " && read UI && UI=${UI:-SwiftUI}
        echo "IOS_UI=\"$UI\"" >> "$MOBIUS_DIR/config/mobius.env"
        echo "MIN_IOS=\"15.0\"" >> "$MOBIUS_DIR/config/mobius.env"
        echo "IOS_ARCH=\"MVVM\"" >> "$MOBIUS_DIR/config/mobius.env"
        echo "IOS_ASYNC=\"Swift Concurrency\"" >> "$MOBIUS_DIR/config/mobius.env"
        TEMPLATE_TYPE="mobile"
        TEMPLATE_NAME="ios"
        ;;
    react|nextjs)
        echo -n "Rendering Strategy (default: App Router): " && read REND && REND=${REND:-App Router}
        echo -n "Global State (default: Zustand): " && read STATE && STATE=${STATE:-Zustand}
        echo -n "Styling (default: Tailwind): " && read STYLE && STYLE=${STYLE:-Tailwind}
        echo "WEB_FRAMEWORK=\"$PLATFORM\"" >> "$MOBIUS_DIR/config/mobius.env"
        echo "RENDERING_STRATEGY=\"$REND\"" >> "$MOBIUS_DIR/config/mobius.env"
        echo "STATE_MGMT=\"$STATE\"" >> "$MOBIUS_DIR/config/mobius.env"
        echo "STYLING=\"$STYLE\"" >> "$MOBIUS_DIR/config/mobius.env"
        echo "FRAMEWORK_VERSION=\"latest\"" >> "$MOBIUS_DIR/config/mobius.env"
        echo "USE_TYPESCRIPT=\"yes\"" >> "$MOBIUS_DIR/config/mobius.env"
        TEMPLATE_TYPE="web"
        TEMPLATE_NAME="react"
        ;;
    vue|nuxt)
        echo "WEB_FRAMEWORK=\"$PLATFORM\"" >> "$MOBIUS_DIR/config/mobius.env"
        echo "VUE_VERSION=\"3.x\"" >> "$MOBIUS_DIR/config/mobius.env"
        echo "STATE_MGMT=\"Pinia\"" >> "$MOBIUS_DIR/config/mobius.env"
        echo "USE_COMPOSITION=\"yes\"" >> "$MOBIUS_DIR/config/mobius.env"
        TEMPLATE_TYPE="web"
        TEMPLATE_NAME="vue"
        ;;
    *)
        TEMPLATE_TYPE="mobile"
        TEMPLATE_NAME="flutter" # Fallback
        ;;
esac

echo "TEAM_CONVENTIONS=\"Standard $PLATFORM conventions\"" >> "$MOBIUS_DIR/config/mobius.env"

# 4. Copy Template to Local
TEMPLATE_FILE="$MOBIUS_HOME/templates/$TEMPLATE_TYPE/context.$TEMPLATE_NAME.md"
if [ -z "$MOBIUS_HOME" ]; then
    TEMPLATE_FILE="$SCRIPT_DIR/../templates/$TEMPLATE_TYPE/context.$TEMPLATE_NAME.md"
fi

if [ -f "$TEMPLATE_FILE" ]; then
    cp "$TEMPLATE_FILE" "$MOBIUS_DIR/context.$TEMPLATE_NAME.md"
    echo -e "${GREEN}✓ Created $MOBIUS_DIR/context.$TEMPLATE_NAME.md${NC}"
else
    echo -e "${RED}❌ Template not found: $TEMPLATE_FILE${NC}"
    exit 1
fi

# 5. Generate Agent Files
if [ -f "$COMMANDS_DIR/sync.sh" ]; then
    source "$COMMANDS_DIR/sync.sh"
fi

echo -e "\n${GREEN}✓ MOBIUS v2.0 initialized successfully!${NC}"
