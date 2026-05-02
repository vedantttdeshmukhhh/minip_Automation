# minip_Automation
# Automate Tool
**By Atharv Deshmukh**

Here is the full list of features and actions your automate tool performs.
>Universal Folder Detection: Automatically detects if you are inside an existing project folder or if you need to create a new workspace from scratch.
>Automatic Git Initialization: Executes git init to start tracking your project files without manual setup.
>Smart README Generation: Checks if a README.md exists; if not, it creates one with the project name, your name, and the creation timestamp.
>Security Shield (.gitignore): Automatically hides sensitive files like .env (API keys), *.log files, and heavy node_modules folders from being uploaded to GitHub.
>Interactive Manual Shield: Prompts the user to enter any additional specific files or folders they want to keep private.
>Privacy Control: Allows you to choose between a Public or Private repository directly from the terminal.
>Automated Remote Linking: Handles the complex gh repo create process, linking your local folder to a new GitHub repository and setting the "origin" remote automatically.
>One-Command Sync: Bundles git add, git commit, and git push into a single automated step.
>Aesthetic User Interface: Uses soft, muted 256-bit ANSI colors (Sage, Sky Blue, Lavender) to provide a modern and professional terminal experience.
>Smart Error Handling: Verifies if the GitHub upload was successful and warns the user if a repository name is already taken.
>Global Distribution: Includes an install.sh script that allows any user to install the tool globally on their system with a single curl command.

### How to Install
Run this command in your Git Bash:
`curl -sSL https://raw.githubusercontent.com/vedantttdeshmukhhh/minip_Automation/master/install.sh | bash`

### Refresh
Run this command in your Git Bash:
`source ~/.bash_profile`

### How to Use
Type `automate .` in any folder to upload it to GitHub.
if you want to upload the current exisiting folder then type this command.
If you want a to add a new folder in which you are not currrently present in then type 
`automate file_name`
example -> `automate demo_repo`
