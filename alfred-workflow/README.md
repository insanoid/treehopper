# Treehopper Alfred Workflow

Navigate and create git worktrees from Alfred.

## Install

1. Download `Treehopper.alfredworkflow` from [Releases](../../../releases)
2. Double-click to install
3. Edit `config.sh` in Alfred's workflow folder

**Dev mode:** `./link.sh` - edits apply immediately.

## Usage

| Keyword | Action |
|---------|--------|
| `wt` | List worktrees |
| `wtn` | Create new worktree |

- `Enter` - Open in editor
- `Cmd+Enter` - Open in terminal

## Config

Edit `config.sh`:

```bash
PROSPERITY_DIR="/path/to/repos"

REPOS=(
    "api:main:production"    # name:default:hotfix
    "frontend:main"
)

EDITOR_CMD="cursor"
TERMINAL_APP="iterm"
```

## Build

```bash
./build.sh
```

## Requirements

- macOS
- [Alfred](https://alfredapp.com) with Powerpack
- Git
