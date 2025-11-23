#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "$SCRIPT_DIR/config.sh"

ARG="$1"

if [[ "$ARG" == terminal:* ]]; then
    PATH_TO_OPEN="${ARG#terminal:}"

    if [[ "$TERMINAL_APP" == "iterm" ]]; then
        osascript << EOF
tell application "iTerm"
    activate
    create window with default profile
    tell current session of current window
        write text "cd '$PATH_TO_OPEN'"
    end tell
end tell
EOF
    else
        osascript << EOF
tell application "Terminal"
    activate
    do script "cd '$PATH_TO_OPEN'"
end tell
EOF
    fi
else
    $EDITOR_CMD "$ARG"
fi
