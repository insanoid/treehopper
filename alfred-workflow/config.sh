#!/bin/bash

# Treehopper Configuration
# Read from Alfred workflow variables (Configure in Alfred UI)

# Base directory containing repos
TREEHOPPER_DIR="${treehopper_dir:-${TREEHOPPER_DIR:-$HOME/Code}}"

# Auto-discover all repos in directory (1 = enabled)
AUTO_DISCOVER="${treehopper_auto_discover:-0}"

# Manual repos: "name:default_branch:hotfix_branch" (comma-separated)
REPOS_RAW="${treehopper_repos:-${TREEHOPPER_REPOS:-}}"

# Build REPOS array
REPOS=()

if [[ "$AUTO_DISCOVER" == "1" ]]; then
    # Auto-discover git repos in TREEHOPPER_DIR
    for dir in "$TREEHOPPER_DIR"/*/; do
        if [[ -d "$dir/.git" ]] || [[ -f "$dir/.git" ]]; then
            repo_name=$(basename "$dir")
            # Get default branch (usually main or master)
            default_branch=$(cd "$dir" && git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed 's@^refs/remotes/origin/@@')
            if [[ -z "$default_branch" ]]; then
                # Fallback: check for main or master
                if git -C "$dir" show-ref --verify --quiet refs/heads/main 2>/dev/null; then
                    default_branch="main"
                elif git -C "$dir" show-ref --verify --quiet refs/heads/master 2>/dev/null; then
                    default_branch="master"
                else
                    default_branch="main"
                fi
            fi
            REPOS+=("$repo_name:$default_branch")
        fi
    done
else
    # Use manual config
    IFS=',' read -ra REPOS <<< "$REPOS_RAW"
fi

# Editor command
EDITOR_CMD="${treehopper_editor:-${TREEHOPPER_EDITOR:-cursor}}"

# Terminal app (iterm or terminal)
TERMINAL_APP="${treehopper_terminal:-${TREEHOPPER_TERMINAL:-iterm}}"
