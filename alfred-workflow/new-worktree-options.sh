#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "$SCRIPT_DIR/config.sh"

items=()
seen_repos=""

for repo_config in "${REPOS[@]}"; do
    repo=$(echo "$repo_config" | cut -d: -f1)
    default_base=$(echo "$repo_config" | cut -d: -f2)
    hotfix_base=$(echo "$repo_config" | cut -d: -f3)

    # Skip if repo:branch already seen (deduplication)
    if echo "$seen_repos" | grep -qF "|$repo:$default_base|"; then
        continue
    fi
    seen_repos="$seen_repos|$repo:$default_base|"

    # Default branch option
    items+=("{
        \"title\": \"$repo (from $default_base)\",
        \"subtitle\": \"Create worktree from $default_base branch\",
        \"arg\": \"$repo:$default_base\",
        \"icon\": {\"path\": \"icon-new.png\"}
    }")

    # Hotfix branch option if defined and not already added
    if [[ -n "$hotfix_base" ]]; then
        if ! echo "$seen_repos" | grep -qF "|$repo:$hotfix_base|"; then
            seen_repos="$seen_repos|$repo:$hotfix_base|"
            items+=("{
                \"title\": \"$repo (from $hotfix_base)\",
                \"subtitle\": \"Create hotfix worktree from $hotfix_base branch\",
                \"arg\": \"$repo:$hotfix_base\",
                \"icon\": {\"path\": \"icon-new.png\"}
            }")
        fi
    fi
done

if [[ ${#items[@]} -eq 0 ]]; then
    echo '{"items":[{"title":"Not configured","subtitle":"Configure repos or enable auto-discover in workflow settings","valid":false}]}'
else
    json_items=$(IFS=,; echo "${items[*]}")
    echo "{\"items\":[$json_items]}"
fi
