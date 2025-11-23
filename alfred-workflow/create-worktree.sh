#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "$SCRIPT_DIR/config.sh"

REPO_BASE="$1"      # e.g., "api:main"
BRANCH_NAME="$2"    # e.g., "feat/my-feature"

# Parse repo and base branch
REPO=$(echo "$REPO_BASE" | cut -d: -f1)
BASE_BRANCH=$(echo "$REPO_BASE" | cut -d: -f2)

REPO_PATH="$TREEHOPPER_DIR/$REPO"

# Sanitize branch name for folder (replace / with -)
FOLDER_NAME=$(echo "$BRANCH_NAME" | tr '/' '-')
WORKTREE_PATH="$TREEHOPPER_DIR/wt-$REPO-$FOLDER_NAME"

# Check if worktree already exists
if [[ -d "$WORKTREE_PATH" ]]; then
    echo "Worktree already exists at $WORKTREE_PATH"
    # Still open it
    $EDITOR_CMD "$WORKTREE_PATH"
    exit 0
fi

cd "$REPO_PATH" || exit 1

# Fetch latest
echo "Fetching latest from origin/$BASE_BRANCH..."
git fetch origin "$BASE_BRANCH" 2>/dev/null

# Create worktree with new branch from base
echo "Creating worktree with new branch $BRANCH_NAME from $BASE_BRANCH..."
git worktree add -b "$BRANCH_NAME" "$WORKTREE_PATH" "origin/$BASE_BRANCH"

if [[ $? -ne 0 ]]; then
    echo "Failed to create worktree"
    exit 1
fi

cd "$WORKTREE_PATH" || exit 1

# Set ROOT_WORKTREE_PATH for worktrees.json commands
export ROOT_WORKTREE_PATH="$REPO_PATH"

# Run setup from worktrees.json if it exists (check root repo, not new worktree)
if [[ -f "$ROOT_WORKTREE_PATH/worktrees.json" ]]; then
    echo "Found worktrees.json, running setup commands..."

    # Parse setup-worktree array and run each command
    if command -v jq &>/dev/null; then
        # Use jq if available
        jq -r '.["setup-worktree"][]' "$ROOT_WORKTREE_PATH/worktrees.json" 2>/dev/null | while read -r cmd; do
            echo "Running: $cmd"
            eval "$cmd"
        done
    else
        # Fallback: simple parsing without jq
        grep -oP '(?<="setup-worktree":\s*\[)[^\]]+' "$ROOT_WORKTREE_PATH/worktrees.json" 2>/dev/null | \
        tr ',' '\n' | sed 's/^[[:space:]]*"//;s/"[[:space:]]*$//' | while read -r cmd; do
            [[ -n "$cmd" ]] && echo "Running: $cmd" && eval "$cmd"
        done
    fi
else
    echo "No worktrees.json found, skipping setup."
    echo "Add worktrees.json to your repo with setup-worktree commands if needed."
fi

echo ""
echo "Created worktree: $WORKTREE_PATH"
echo "Opening in $EDITOR_CMD..."

# Open in editor
$EDITOR_CMD "$WORKTREE_PATH"

# Exit to close terminal
exit 0
