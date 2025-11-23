## Usage

### List Worktrees

Search your worktrees via the `wt` keyword.

![List worktrees](images/wt_open.png)

* <kbd>↩</kbd> Open in editor.
* <kbd>⌘</kbd><kbd>↩</kbd> Open in terminal.

### Create Worktree

Create a new worktree via the `wtn` keyword. Select a repository and base branch, then enter your new branch name.

![Create worktree](images/wt_new.png)

## Configuration

Configure the workflow via the Workflow's Configuration.

![Configuration](images/alfred_configuration.png)

* **Repos Directory** – Base path containing your git repositories.
* **Auto Discover** – Automatically find all git repos and detect default branches.
* **Repositories** – Manual list if auto-discover is off (format: `name:branch:hotfix`).
* **Editor** – CLI command to open worktrees (`cursor`, `code`, `zed`).
* **Terminal** – Terminal app for <kbd>⌘</kbd><kbd>↩</kbd> (`terminal`, `iterm`, `warp`).

## Optional

Works well with [worktree-cli](https://github.com/johnlindquist/worktree-cli) for automated setup scripts when creating worktrees.
