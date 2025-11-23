#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "$SCRIPT_DIR/config.sh"

items=()

for repo_config in "${REPOS[@]}"; do
    repo=$(echo "$repo_config" | cut -d: -f1)
    default_base=$(echo "$repo_config" | cut -d: -f2)
    hotfix_base=$(echo "$repo_config" | cut -d: -f3)

    # Default branch option
    items+=("{
        \"title\": \"$repo (from $default_base)\",
        \"subtitle\": \"Create new worktree from $default_base branch\",
        \"arg\": \"$repo:$default_base\",
        \"icon\": {\"path\": \"icon-new.png\"}
    }")

    # Hotfix branch option if defined
    if [[ -n "$hotfix_base" ]]; then
        items+=("{
            \"title\": \"$repo (from $hotfix_base)\",
            \"subtitle\": \"Create hotfix worktree from $hotfix_base branch\",
            \"arg\": \"$repo:$hotfix_base\",
            \"icon\": {\"path\": \"icon-new.png\"}
        }")
    fi
done

if [[ ${#items[@]} -eq 0 ]]; then
    echo '{"items":[{"title":"Not configured","subtitle":"Configure repos or enable auto-discover in workflow settings","valid":false}]}'
else
    json_items=$(IFS=,; echo "${items[*]}")
    echo "{\"items\":[$json_items]}"
fi
