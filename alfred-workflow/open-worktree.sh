#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "$SCRIPT_DIR/config.sh"

ARG="$1"

if [[ "$ARG" == terminal:* ]]; then
    PATH_TO_OPEN="${ARG#terminal:}"

    case "$TERMINAL_APP" in
        iterm)
            osascript << EOF
tell application "iTerm"
    activate
    create window with default profile
    tell current session of current window
        write text "cd '$PATH_TO_OPEN'"
    end tell
end tell
EOF
            ;;
        warp)
            osascript << EOF
tell application "Warp"
    activate
    tell application "System Events"
        keystroke "t" using command down
        delay 0.2
        keystroke "cd '$PATH_TO_OPEN'"
        key code 36
    end tell
end tell
EOF
            ;;
        terminal|*)
            osascript << EOF
tell application "Terminal"
    activate
    do script "cd '$PATH_TO_OPEN'"
end tell
EOF
            ;;
    esac
else
    $EDITOR_CMD "$ARG"
fi
