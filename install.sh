#!/bin/bash

# --- AESTHETIC COLOR PALETTE (256-bit) ---
CYAN='\033[38;5;153m'    # Light Sky Blue
GREEN='\033[38;5;150m'   # Sage/Soft Green
PEACH='\033[38;5;216m'   # Soft Peach/Orange
LAVENDER='\033[38;5;183m' # Light Lavender
NC='\033[0m'             # Reset

echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${CYAN}   Starting Vedant's Automation Tool Setup...${NC}"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"

# 1. Download the main script to the home directory
# It pulls the raw code from your GitHub repository
echo -e "${LAVENDER}Fetching core components from GitHub...${NC}"
curl -sSL https://raw.githubusercontent.com/vedantttdeshmukhhh/minip_Automation/master/miniproject.sh -o ~/automate.sh

# 2. Make it executable
chmod +x ~/automate.sh

# 3. Add the alias to .bash_profile automatically
if ! grep -q "alias automate=" ~/.bash_profile; then
    echo "alias automate='~/automate.sh'" >> ~/.bash_profile
    echo -e "${GREEN}Successfully created 'automate' shortcut!${NC}"
else
    echo -e "${PEACH}Shortcut already exists. Updating configuration...${NC}"
fi

# 4. Success Message
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}   Installation Complete!${NC}"
echo -e "   1. Restart Git Bash (or type: ${CYAN}source ~/.bash_profile${NC})"
echo -e "   2. Type ${CYAN}automate .${NC} in any folder to start."
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"