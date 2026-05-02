#!/bin/bash


CYAN='\033[38;5;153m'
GREEN='\033[38;5;150m'
PEACH='\033[38;5;216m'
LAVENDER='\033[38;5;183m'
NC='\033[0m'

echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${CYAN}   Starting Vedant's Automation Tool Setup...${NC}"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"


echo -e "${LAVENDER}Fetching core components from GitHub...${NC}"
curl -sSL https://raw.githubusercontent.com/vedantttdeshmukhhh/minip_Automation/master/miniproject.sh -o ~/automate.sh


chmod +x ~/automate.sh


if ! grep -q "alias automate=" ~/.bash_profile; then
    echo "alias automate='~/automate.sh'" >> ~/.bash_profile
    echo -e "${GREEN}Successfully created 'automate' shortcut!${NC}"
else
    echo -e "${PEACH}Shortcut already exists. Updating configuration...${NC}"
fi


echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}   Installation Complete!${NC}"
echo -e "   1. Restart Git Bash (or type: ${CYAN}source ~/.bash_profile${NC})"
echo -e "   2. Type ${CYAN}automate .${NC} in any folder to start."
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
