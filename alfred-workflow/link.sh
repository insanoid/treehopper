#!/bin/bash

# Symlink workflow for development (changes apply immediately)

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
WORKFLOW_DIR="$HOME/Library/Application Support/Alfred/Alfred.alfredpreferences/workflows"
LINK_NAME="user.workflow.treehopper"

if [[ ! -d "$WORKFLOW_DIR" ]]; then
    echo "Error: Alfred workflows directory not found"
    echo "Expected: $WORKFLOW_DIR"
    exit 1
fi

TARGET="$WORKFLOW_DIR/$LINK_NAME"

if [[ -L "$TARGET" ]] || [[ -d "$TARGET" ]]; then
    rm -rf "$TARGET"
    echo "Removed existing: $TARGET"
fi

ln -s "$SCRIPT_DIR" "$TARGET"

echo "Linked: $SCRIPT_DIR -> $TARGET"
echo "Workflow active. Edits apply immediately."
