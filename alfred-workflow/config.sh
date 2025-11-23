#!/bin/bash

# Treehopper Configuration
# These are read from Alfred workflow variables (Configure in Alfred UI)
# Fallback to environment variables or defaults

# Base directory containing repos
TREEHOPPER_DIR="${treehopper_dir:-${TREEHOPPER_DIR:-$HOME/Code}}"

# Repos: "name:default_branch:hotfix_branch" (comma-separated)
# Example: "api:main:production,frontend:main,backend:main"
REPOS_RAW="${treehopper_repos:-${TREEHOPPER_REPOS:-}}"

# Parse repos into array
IFS=',' read -ra REPOS <<< "$REPOS_RAW"

# Editor command
EDITOR_CMD="${treehopper_editor:-${TREEHOPPER_EDITOR:-cursor}}"

# Terminal app (iterm or terminal)
TERMINAL_APP="${treehopper_terminal:-${TREEHOPPER_TERMINAL:-iterm}}"
