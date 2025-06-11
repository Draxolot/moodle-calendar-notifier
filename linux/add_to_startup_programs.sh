#!/bin/bash

# Modify here the script path
SCRIPT_PATH="/repoPath/linux/main.py"

PYTHON_PATH=$(which python3)

AUTOSTART_DIR="$HOME/.config/autostart"
DESKTOP_FILE="$AUTOSTART_DIR/moodle-calendar-notifier.desktop"

mkdir -p "$AUTOSTART_DIR"

cat > "$DESKTOP_FILE" <<EOL
[Desktop Entry]
Type=Application
Exec=$PYTHON_PATH $SCRIPT_PATH
Hidden=false
NoDisplay=false
X-GNOME-Autostart-enabled=true
Name=MonScriptPython
Comment=Launches moodle calendar notifier at boot
EOL

echo "Script successfully added to boot programs at $DESKTOP_FILE"
