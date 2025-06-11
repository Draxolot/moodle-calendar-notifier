#!/bin/bash

# Modify REPO_PATH variable with the absolute repository path
REPO_PATH="/repoPath"

PYTHON_PATH=$(which python3)

AUTOSTART_DIR="$HOME/.config/autostart"
DESKTOP_FILE="$AUTOSTART_DIR/moodle-calendar-notifier.desktop"

mkdir -p "$AUTOSTART_DIR"

cat > "$DESKTOP_FILE" <<EOL
[Desktop Entry]
Type=Application
Exec=$PYTHON_PATH $REPO_PATH/linux/main.py
Hidden=false
NoDisplay=false
X-GNOME-Autostart-enabled=true
Name=Moodle Calendar Notifier
Comment=Launches moodle calendar notifier at startup
EOL

echo "Script successfully added to startup programs at $DESKTOP_FILE"
