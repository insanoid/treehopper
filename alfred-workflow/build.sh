#!/bin/bash

# Build Treehopper Alfred Workflow

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR"

OUTPUT="Treehopper.alfredworkflow"

rm -f "$OUTPUT"

zip -r "$OUTPUT" \
    info.plist \
    config.sh \
    list-worktrees.sh \
    new-worktree-options.sh \
    create-worktree.sh \
    open-worktree.sh \
    icon.png

echo "Built: $SCRIPT_DIR/$OUTPUT"
echo ""
echo "Install: open $OUTPUT"
echo "Dev mode: ./link.sh"
