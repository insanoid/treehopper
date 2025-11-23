/// <reference types="@raycast/api">

/* 🚧 🚧 🚧
 * This file is auto-generated from the extension's manifest.
 * Do not modify manually. Instead, update the `package.json` file.
 * 🚧 🚧 🚧 */

/* eslint-disable @typescript-eslint/ban-types */

type ExtensionPreferences = {
  /** Repos Directory - Base directory containing your git repositories */
  "reposDirectory": string,
  /** Auto Discover - Automatically scan all git repos in directory */
  "autoDiscover": boolean,
  /** Repositories - Manual list (ignored if auto-discover on). Format: name:branch:hotfix */
  "repositories"?: string,
  /** Editor - Editor command to open worktrees */
  "editor": string,
  /** Terminal - Terminal app for opening directories */
  "terminal": "terminal" | "iterm" | "warp"
}

/** Preferences accessible in all the extension's commands */
declare type Preferences = ExtensionPreferences

declare namespace Preferences {
  /** Preferences accessible in the `list-worktrees` command */
  export type ListWorktrees = ExtensionPreferences & {}
  /** Preferences accessible in the `create-worktree` command */
  export type CreateWorktree = ExtensionPreferences & {}
}

declare namespace Arguments {
  /** Arguments passed to the `list-worktrees` command */
  export type ListWorktrees = {}
  /** Arguments passed to the `create-worktree` command */
  export type CreateWorktree = {}
}

