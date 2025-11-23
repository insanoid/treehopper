#!/bin/bash

# Configuration for Prosperity Worktrees
# Edit these values to customize for your setup

# Base directory containing all repos
PROSPERITY_DIR="${PROSPERITY_DIR:-/Users/karthikeyaudupa/Code/Prosperity}"

# Repos to scan for worktrees: "name:default_base:hotfix_base"
# - name: folder name in PROSPERITY_DIR
# - default_base: branch for normal worktrees
# - hotfix_base: (optional) branch for hotfix worktrees, omit if not needed
REPOS=(
    "api:main:production"
    "prosperity.app:main"
    "partner.life.li:main"
)

# Editor command
EDITOR_CMD="${EDITOR_CMD:-cursor}"

# Terminal app (iterm or terminal)
TERMINAL_APP="${TERMINAL_APP:-iterm}"
