import { execSync } from "node:child_process";
import * as fs from "node:fs";
import * as path from "node:path";
import type { RepoConfig, Worktree } from "../types";
import { getPreferences, getRepoPath } from "./config";

export function getWorktrees(repos: RepoConfig[]): Worktree[] {
  const worktrees: Worktree[] = [];
  const seen = new Set<string>();

  for (const repo of repos) {
    const repoPath = getRepoPath(repo.name);

    // Check if repo exists
    const gitPath = path.join(repoPath, ".git");
    if (!fs.existsSync(gitPath)) continue;

    try {
      const output = execSync("git worktree list", {
        cwd: repoPath,
        encoding: "utf-8",
      });

      const lines = output.trim().split("\n");
      for (const line of lines) {
        // Parse: /path/to/worktree  abc1234 [branch-name]
        const match = line.match(/^(.+?)\s+\w+\s+\[(.+?)\]/);
        if (match) {
          const wtPath = match[1].trim();
          const branch = match[2];
          // Dedupe by path
          if (seen.has(wtPath)) continue;
          seen.add(wtPath);
          worktrees.push({
            path: wtPath,
            branch,
            repoName: repo.name,
            isRoot: wtPath === repoPath,
          });
        }
      }
    } catch (e) {
      console.error(`Failed to list worktrees for ${repo.name}:`, e);
    }
  }

  return worktrees;
}

export function createWorktree(
  repoName: string,
  baseBranch: string,
  newBranch: string,
): { success: boolean; path?: string; error?: string } {
  const prefs = getPreferences();
  const repoPath = getRepoPath(repoName);

  // Sanitize branch name for folder
  const folderBranch = newBranch.replace(/\//g, "-");
  const worktreePath = path.join(
    prefs.reposDirectory,
    `wt-${repoName}-${folderBranch}`,
  );

  // Check if already exists
  if (fs.existsSync(worktreePath)) {
    return {
      success: false,
      error: `Worktree already exists at ${worktreePath}`,
    };
  }

  try {
    // Fetch latest
    try {
      execSync(`git fetch origin ${baseBranch}`, {
        cwd: repoPath,
        encoding: "utf-8",
      });
    } catch {
      // Ignore fetch errors
    }

    // Create worktree with new branch
    execSync(
      `git worktree add -b "${newBranch}" "${worktreePath}" "origin/${baseBranch}"`,
      {
        cwd: repoPath,
        encoding: "utf-8",
      },
    );

    // Run setup if worktrees.json exists
    const worktreesJson = path.join(worktreePath, "worktrees.json");
    if (fs.existsSync(worktreesJson)) {
      try {
        execSync(`wt setup "${newBranch}" -e "${prefs.editor}"`, {
          cwd: worktreePath,
          encoding: "utf-8",
        });
      } catch {
        // Fallback: npm install + copy env files
        try {
          execSync("npm install", { cwd: worktreePath, encoding: "utf-8" });
        } catch {
          // Ignore npm errors
        }
        copyEnvFiles(repoPath, worktreePath);
      }
    } else {
      // No worktrees.json, just npm install
      try {
        execSync("npm install", { cwd: worktreePath, encoding: "utf-8" });
      } catch {
        // Ignore npm errors
      }
      copyEnvFiles(repoPath, worktreePath);
    }

    return { success: true, path: worktreePath };
  } catch (e) {
    return { success: false, error: String(e) };
  }
}

function copyEnvFiles(srcDir: string, destDir: string) {
  const envFiles = [".env", ".env.test", ".env.local"];
  for (const file of envFiles) {
    const src = path.join(srcDir, file);
    const dest = path.join(destDir, file);
    if (fs.existsSync(src) && !fs.existsSync(dest)) {
      try {
        fs.copyFileSync(src, dest);
      } catch {
        // Ignore copy errors
      }
    }
  }
}
