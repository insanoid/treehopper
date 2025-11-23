#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "$SCRIPT_DIR/config.sh"

# Input: "repo:branch" (e.g., "api:main")
INPUT="$1"

REPO=$(echo "$INPUT" | cut -d: -f1)
BASE_BRANCH=$(echo "$INPUT" | cut -d: -f2)

# Show dialog to get branch name
RESULT=$(osascript -e "tell application \"Alfred 5\"
    activate
end tell
set theResponse to display dialog \"Enter new branch name for $REPO (from $BASE_BRANCH):\" default answer \"feat/\" with title \"Create Worktree\" buttons {\"Cancel\", \"Create\"} default button \"Create\"
set btnPressed to button returned of theResponse
set txtEntered to text returned of theResponse
return btnPressed & \"|\" & txtEntered" 2>/dev/null)

if [[ -z "$RESULT" ]]; then
    exit 0
fi

# Parse result
BUTTON=$(echo "$RESULT" | cut -d'|' -f1)
BRANCH_NAME=$(echo "$RESULT" | cut -d'|' -f2)

if [[ "$BUTTON" == "Cancel" ]] || [[ -z "$BRANCH_NAME" ]]; then
    exit 0
fi

# Build the command to run in terminal (include env vars from Alfred)
# Add 'exit' at end to close terminal tab/window after script completes
CMD="export treehopper_dir='$TREEHOPPER_DIR' treehopper_editor='$EDITOR_CMD' treehopper_terminal='$TERMINAL_APP' && cd '$SCRIPT_DIR' && ./create-worktree.sh '$REPO:$BASE_BRANCH' '$BRANCH_NAME'; exit"

# Run in terminal based on preference
case "$TERMINAL_APP" in
    iterm)
        osascript -e "tell application \"iTerm\"
            activate
            set newWindow to (create window with default profile)
            tell current session of newWindow
                write text \"$CMD\"
            end tell
        end tell"
        ;;
    warp)
        osascript -e "tell application \"Warp\"
            activate
        end tell"
        sleep 0.5
        osascript -e "tell application \"System Events\"
            keystroke \"$CMD\"
            keystroke return
        end tell"
        ;;
    *)
        # Default: Terminal.app
        osascript -e "tell application \"Terminal\"
            activate
            do script \"$CMD\"
        end tell"
        ;;
esac
