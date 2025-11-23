#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "$SCRIPT_DIR/config.sh"

items=()

for repo_config in "${REPOS[@]}"; do
    repo=$(echo "$repo_config" | cut -d: -f1)
    repo_path="$TREEHOPPER_DIR/$repo"

    if [[ -d "$repo_path/.git" ]] || [[ -f "$repo_path/.git" ]]; then
        while IFS= read -r line; do
            wt_path=$(echo "$line" | awk '{print $1}')
            branch=$(echo "$line" | sed 's/.*\[\(.*\)\].*/\1/')

            if [[ "$wt_path" == "$repo_path" ]]; then
                display_name="$repo [root]"
            else
                display_name="$repo"
            fi

            items+=("{
                \"title\": \"$display_name / $branch\",
                \"subtitle\": \"$wt_path\",
                \"arg\": \"$wt_path\",
                \"icon\": {\"path\": \"icon.png\"},
                \"mods\": {
                    \"cmd\": {
                        \"subtitle\": \"Open in $TERMINAL_APP\",
                        \"arg\": \"terminal:$wt_path\"
                    }
                }
            }")
        done < <(cd "$repo_path" && git worktree list 2>/dev/null)
    fi
done

if [[ ${#items[@]} -eq 0 ]]; then
    if [[ ${#REPOS[@]} -eq 0 ]]; then
        echo '{"items":[{"title":"Not configured","subtitle":"Configure repos or enable auto-discover in workflow settings","valid":false}]}'
    else
        echo '{"items":[{"title":"No worktrees found","subtitle":"Use wtn to create one","valid":false}]}'
    fi
else
    json_items=$(IFS=,; echo "${items[*]}")
    echo "{\"items\":[$json_items]}"
fi
