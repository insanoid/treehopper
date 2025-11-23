# Treehopper Alfred Workflow

Navigate and create git worktrees from Alfred.

## Install

1. Download `Treehopper.alfredworkflow` from [Releases](https://github.com/insanoid/treehopper/releases)
2. Double-click to install
3. Click the `[x]` icon in Alfred to configure

## Configuration

After installing, configure via Alfred's workflow settings:

| Setting | Description | Example |
|---------|-------------|---------|
| **Repos Directory** | Base path containing repos | `/Users/you/Code` |
| **Repositories** | Comma-separated list | `api:main:production,frontend:main` |
| **Editor** | Command to open worktrees | `cursor`, `code`, `webstorm` |
| **Terminal** | Terminal for Cmd+Enter | iTerm or Terminal |

### Repository Format

```
name:default_branch:hotfix_branch
```

- `name` - folder name in repos directory
- `default_branch` - branch for new worktrees (usually `main`)
- `hotfix_branch` - (optional) alternate base branch for hotfixes

**Examples:**
```
api:main:production     # api with main + production branches
frontend:main           # frontend with just main
backend:develop         # backend branching from develop
```

## Usage

| Keyword | Action |
|---------|--------|
| `wt` | List all worktrees |
| `wtn` | Create new worktree |

**Modifiers:**
- `Enter` - Open in editor
- `Cmd+Enter` - Open in terminal

## Prerequisites

- macOS
- [Alfred](https://alfredapp.com) with Powerpack
- Git
- [worktree-cli](https://github.com/johnlindquist/worktree-cli) (optional, for setup scripts)

```bash
pnpm install -g @johnlindquist/worktree
```

## Development

```bash
# Symlink for live editing
./link.sh

# Build .alfredworkflow
./build.sh
```
