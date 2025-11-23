# Treehopper

<img src="alfred-workflow/icon.png" width="128" alt="Treehopper icon">

Hop between git worktrees with ease.

## Alfred Workflow

Navigate and create git worktrees directly from Alfred.

<img src="alfred-workflow/images/wt_open.png" width="600" alt="Treehopper Alfred workflow">

**[Download Latest Release](../../releases/latest)** | [Full Documentation](alfred-workflow/README.md)

### Features

- `wt` - List and open existing worktrees
- `wtn` - Create new worktrees from any branch
- Auto-discover repos or configure manually
- Customizable editor and terminal

---

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

## License

MIT
