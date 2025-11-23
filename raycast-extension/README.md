# Treehopper Raycast Extension

Navigate and create git worktrees from Raycast.

## Install

```bash
cd raycast-extension
npm install
npm run dev
```

This opens Raycast with the extension in dev mode.

## Commands

### List Worktrees

List all worktrees across your repos.

- `Enter` - Open in editor
- `Cmd+Enter` - Open in terminal
- `Cmd+C` - Copy path
- `Cmd+Shift+F` - Show in Finder

### Create Worktree

Select a repo/branch, enter new branch name, creates worktree and opens in editor.

## Configuration

Configure via Raycast preferences:

| Setting | Description | Example |
|---------|-------------|---------|
| **Repos Directory** | Base path containing repos | `/Users/you/Code` |
| **Auto Discover** | Scan all git repos in directory | Checkbox |
| **Repositories** | Manual list (if auto-discover off) | `api:main:production,frontend:main` |
| **Editor** | CLI command to open worktrees | `cursor`, `code`, `zed` |
| **Terminal** | Terminal app | Terminal, iTerm, Warp |

## Development

```bash
npm run dev    # Start dev mode
npm run build  # Build extension
npm run lint   # Lint code
```
