#!/bin/bash

GREEN='\033[38;5;150m'
CYAN='\033[38;5;153m'
PEACH='\033[38;5;216m'
LAVENDER='\033[38;5;183m'
GRAY='\033[38;5;246m'
NC='\033[0m'

CONFIG_FILE="$HOME/.automate_config"

if [ ! -f "$CONFIG_FILE" ]; then
    echo -e "${PEACH}First-time Setup: Please enter your GitHub details.${NC}"
    echo -e "${GRAY}Get your token here: https://github.com/settings/tokens (Enable 'repo' permissions)${NC}"
    read -p "GitHub Username: " GH_USER
    read -sp "Personal Access Token: " GH_TOKEN
    echo ""
    echo "GH_USER=$GH_USER" > "$CONFIG_FILE"
    echo "GH_TOKEN=$GH_TOKEN" >> "$CONFIG_FILE"
else
    source "$CONFIG_FILE"
fi

INPUT_NAME=$1
if [ -z "$INPUT_NAME" ]; then
    echo -e "${PEACH}Error: Project name missing.${NC}"
    exit 1
fi

if [ "$INPUT_NAME" == "." ]; then
    PROJECT_NAME=$(basename "$PWD")
else
    PROJECT_NAME=$INPUT_NAME
    mkdir -p "$PROJECT_NAME" && cd "$PROJECT_NAME"
fi

git init

if [ ! -f "README.md" ]; then
    echo "# $PROJECT_NAME" > README.md
    echo "Automated by: Vedant Deshmukh" >> README.md
fi

echo ".env" >> .gitignore
echo "*.log" >> .gitignore
echo "node_modules/" >> .gitignore

echo -e "${LAVENDER}Any extra files to hide? (Enter names or Enter to skip):${NC}"
read EXTRA_FILES
[ ! -z "$EXTRA_FILES" ] && echo "$EXTRA_FILES" >> .gitignore

echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${PEACH}Visibility: (1) Public or (2) Private? (Enter 1 or 2):${NC}"
read PRIVACY_CHOICE
[ "$PRIVACY_CHOICE" == "2" ] && IS_PRIVATE="true" || IS_PRIVATE="false"

echo -e "${LAVENDER}Enter commit message:${NC}"
read CUSTOM_MSG
[ -z "$CUSTOM_MSG" ] && CUSTOM_MSG="Initial automated commit"

echo -e "${CYAN}Step 7: Creating GitHub repository...${NC}"

echo "{\"name\":\"$PROJECT_NAME\", \"private\": $IS_PRIVATE}" > repo_data.json
RESPONSE=$(curl -s -u "$GH_USER:$GH_TOKEN" https://api.github.com/user/repos -d @repo_data.json)
rm repo_data.json

# Improved check: If the response contains a "html_url", it definitely worked!
if [[ $RESPONSE == *"html_url"* ]]; then
    git add .
    git commit -m "$CUSTOM_MSG"
    git branch -M main
    git remote add origin "https://github.com/$GH_USER/$PROJECT_NAME.git"
    git push -u origin main
    
    echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo -e "SUCCESS! Your project '$PROJECT_NAME' is live."
    echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
else
    # If it failed because it already exists, we can still push to it!
    if [[ $RESPONSE == *"already exists"* ]]; then
        echo -e "${CYAN}Repo already exists on GitHub. Syncing files...${NC}"
        git add .
        git commit -m "$CUSTOM_MSG"
        git branch -M main
        git remote add origin "https://github.com/$GH_USER/$PROJECT_NAME.git" 2>/dev/null
        git push -u origin main
        echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        echo -e "SUCCESS! Existing project '$PROJECT_NAME' updated."
        echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    else
        echo -e "${PEACH}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        echo -e "GitHub Error: $(echo "$RESPONSE" | grep -oP '"message":\s*"\K[^"]+')"
        echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    fi
fi
