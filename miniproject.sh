#!/bin/bash


GREEN='\033[38;5;150m'
CYAN='\033[38;5;153m'
PEACH='\033[38;5;216m'
LAVENDER='\033[38;5;183m'
GRAY='\033[38;5;246m'
NC='\033[0m'


INPUT_NAME=$1
if [ -z "$INPUT_NAME" ]; then
    echo -e "${PEACH}Error: Oops!, you forgot to enter the project name.${NC}"
    echo -e "${GRAY}Usage: automate [NAME] or automate . (for current folder)${NC}"
    exit 1
fi


if [ "$INPUT_NAME" == "." ]; then
    PROJECT_NAME=$(basename "$PWD") 
    echo -e "${LAVENDER}Step 3: Automating current folder: '$PROJECT_NAME'...${NC}"
else
    PROJECT_NAME=$INPUT_NAME
    if [ -d "$PROJECT_NAME" ]; then
        echo -e "${LAVENDER}Step 3: Existing folder '$PROJECT_NAME' detected. Moving inside...${NC}"
        cd "$PROJECT_NAME"
    else
        echo -e "${CYAN}Step 3: Building your new workspace '$PROJECT_NAME'...${NC}"
        mkdir "$PROJECT_NAME"
        cd "$PROJECT_NAME"
    fi
fi


echo -e "${GRAY}Step 4: Initializing Git Tracking...${NC}"
git init


if [ ! -f "README.md" ]; then
    echo -e "${CYAN}Step 5: Writing README.md...${NC}"
    echo "# $PROJECT_NAME" > README.md
    echo "Automated by: Vedant Deshmukh" >> README.md
    echo "Created on: $(date)" >> README.md
else
    echo -e "${GRAY}Step 5: README.md already exists. Skipping...${NC}"
fi


echo -e "${GRAY}Step 6: Setting up security shield (.gitignore)...${NC}"
echo ".env" >> .gitignore
echo "*.log" >> .gitignore
echo "node_modules/" >> .gitignore


echo -e "${LAVENDER}Any extra files to hide? (Enter names or press Enter to skip):${NC}"
read EXTRA_FILES
if [ ! -z "$EXTRA_FILES" ]; then
    echo "$EXTRA_FILES" >> .gitignore
    echo -e "${GRAY}Added $EXTRA_FILES to the shield.${NC}"
fi


echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"

echo -e "${PEACH}Visibility: (1) Public or (2) Private? (Enter 1 or 2):${NC}"
read PRIVACY_CHOICE
if [ "$PRIVACY_CHOICE" == "2" ]; then
    VISIBILITY="--private"
else
    VISIBILITY="--public"
fi

echo -e "${LAVENDER}Enter commit message (or press Enter for default):${NC}"
read CUSTOM_MSG
if [ -z "$CUSTOM_MSG" ]; then
    CUSTOM_MSG="Initial automated commit"
fi

echo -e "${CYAN}Step 7: Creating Github repository and pushing...${NC}"
git add .
git commit -m "$CUSTOM_MSG"


if gh repo create "$PROJECT_NAME" $VISIBILITY --source=. --remote=origin --push; then
    echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo -e "SUCCESS! Your project '$PROJECT_NAME' is ready and live."
    echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    ls -a
else
    echo -e "${PEACH}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo -e "Wait! GitHub upload failed. (Check if the name already exists)."
    echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
fi
