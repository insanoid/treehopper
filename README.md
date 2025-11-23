# Treehopper

Hop between git worktrees.

## What are Git Worktrees?

Git worktrees let you check out multiple branches simultaneously in separate directories. Instead of stashing changes or committing WIP to switch branches, you can have each branch in its own folder and switch instantly.

```bash
# Traditional workflow (painful)
git stash
git checkout feature-b
# work on feature-b
git checkout feature-a
git stash pop

# Worktree workflow (smooth)
cd ../project-feature-b   # just switch directories
```

**Benefits:**
- Work on multiple features/fixes simultaneously
- No stashing, no WIP commits
- Keep long-running tasks (tests, builds) running while switching context
- Review PRs without disrupting your current work

## Prerequisites

- [worktree-cli](https://github.com/johnlindquist/worktree-cli) (optional but recommended)

```bash
pnpm install -g @johnlindquist/worktree
```

## Alfred Workflow

Navigate and create git worktrees from Alfred.

[Download from Releases](../../releases) | [Setup Guide](alfred-workflow/README.md)

## License

MIT
