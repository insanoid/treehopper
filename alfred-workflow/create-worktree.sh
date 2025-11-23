#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "$SCRIPT_DIR/config.sh"

REPO_BASE="$1"      # e.g., "api:main"
BRANCH_NAME="$2"    # e.g., "feat/my-feature"

# Parse repo and base branch
REPO=$(echo "$REPO_BASE" | cut -d: -f1)
BASE_BRANCH=$(echo "$REPO_BASE" | cut -d: -f2)

REPO_PATH="$PROSPERITY_DIR/$REPO"

# Sanitize branch name for folder (replace / with -)
FOLDER_BRANCH=$(echo "$BRANCH_NAME" | tr '/' '-')
WORKTREE_PATH="$PROSPERITY_DIR/wt-$REPO-$FOLDER_BRANCH"

# Check if worktree already exists
if [[ -d "$WORKTREE_PATH" ]]; then
    echo "Worktree already exists at $WORKTREE_PATH"
    exit 1
fi

cd "$REPO_PATH" || exit 1

# Fetch latest
git fetch origin "$BASE_BRANCH" 2>/dev/null

# Create worktree with new branch from base
git worktree add -b "$BRANCH_NAME" "$WORKTREE_PATH" "origin/$BASE_BRANCH"

if [[ $? -ne 0 ]]; then
    echo "Failed to create worktree"
    exit 1
fi

cd "$WORKTREE_PATH" || exit 1

# Run setup from worktrees.json if it exists
if [[ -f "worktrees.json" ]]; then
    echo "Running wt setup scripts..."
    wt setup "$BRANCH_NAME" -e "$EDITOR_CMD" 2>/dev/null || {
        # Fallback: manual setup
        npm install 2>/dev/null
        ROOT_WORKTREE_PATH="$REPO_PATH"
        [[ -f "$ROOT_WORKTREE_PATH/.env" ]] && cp "$ROOT_WORKTREE_PATH/.env" .env
        [[ -f "$ROOT_WORKTREE_PATH/.env.test" ]] && cp "$ROOT_WORKTREE_PATH/.env.test" .env.test
    }
else
    npm install 2>/dev/null
fi

# Open in editor
$EDITOR_CMD "$WORKTREE_PATH"

echo "Created worktree: $WORKTREE_PATH"
