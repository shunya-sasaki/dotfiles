---
name: git-workflow
description: When you're asked to work with Git, you MUST use this skill.
---

# Git Workflow

This skill provides instructions for Git repositories using `git` commands.
The following are tasks described in this skill:

- Generate Commit Message
- Create Worktree
- Remove Worktree
- Resolve the issue

## Common arguments

The `gh` commands share these rules for arguments:

- `<title>` is the title of a issue or a pull request.
  The title must be concise (max 50 characters) and follow:
  `<type>(scope): <description>`
  e.g. `feat(doc): add issue creation procedure`
- `<type>` must be one of: `feat`, `fix`, `docs`, `style`, `refactor`,
  `perf`, `test`, `build`, `ci`.
- `scope`
- `<body>` is the body of a issue or a pull request.
- `<label>`

## Generate Commit Message

### Procedure

1. Run `git --no-pager diff --cached --no-color` to get staged changes.
2. Based on the staged changes, generate a commit message that follows the
   **Conventional Commit** style.

### Strict Rules

- The commit message MUST follow the **Conventional Commit** style
  such as `<type>(<scope>): <subject>` or `<type>: <subject>`
  (max 50 chars, lowercase description, imperative mood).
- Types should be one of the following:
  - `feat`: A new feature
  - `fix`: A bug fix
  - `docs`: Documentation only changes
  - `style`: Changes that do not affect the meaning of the code (white-space, formatting, missing semi-colons, etc)
  - `refactor`: A code change that neither fixes a bug nor adds a feature
  - `perf`: A code change that improves performance
  - `test`: Adding missing tests or correcting existing tests
  - `chore`: Changes to the build process or auxiliary tools and libraries such as documentation generation
  - `build`: Changes that affect the build system or external dependencies (npm, cargo, make, etc)
  - `ci`: Changes to CI configuration files and scripts (GitHub Actions, GitLab CI, etc)
- Output ONLY the raw commit message with no code blocks, explanations, or fillers.

## Create issue

IF you're asked to create a issue, THEN you MUST work on this task.

### Procedure

1. Understand the user's request, problem report, or improvement idea.
2. If the repository context is needed, inspect relevant files in the repository
   to understand the current implementation, configuration, documentation,
   or behavior.
3. Create the issue title using the **Conventional Commit** style.
4. Get a label list using `gf label list` and select a label from the list.
   If the list is empty, label is None.
5. Get a body template using `gf issue template --label <label>`.
6. Create a body of the issue with following the template.
7. Run `gf issue create --title <title> --body <body> --label <label>`.

### Strict Rules

- The title and body MUST NOT contain any ANSI escape sequences,
  terminal control codes, or other non-printable characters.
  This includes, but is not limited to:
  - SGR / color codes such as `\x1b[31m`, `\033[0m`, `\u001b[1;32m`
  - Cursor and screen codes such as `\x1b[2k`, `x1b[?25l`, `x1b[H`
  - Any byte in the ranges `\x00`-`\x08`, `\x0B`-`\x1F`, or `\x7F`
- If any tool or command output you read contains such sequences,
  **strip them before** including the content in the issue body.
- After composing the body, scan it once more and remove any remaining bytes
  that match `\x1B\[`, `\x1B\]`, or other C0/C1 control characters.
- The title must be concise (max 50 characters) and follow:
  `<type>(scope): <description>`
- `<type>` must be one of: `feat`, `fix`, `docs`, `style`, `refactor`,
  `perf`, `test`, `build`, `ci`.

## Create Pull Request

IF you're asked to create a pull request (PR), THEN you MUST work on this task.

### Procedure

1. Run `git --no-pager diff --no-color <target_branch>...HEAD` to get the
   detailed changes between the current branch and the target branch.
   If `<target-branch>` is not specified, use `main` as the default.
2. Create the PR title using the **Conventional Commit** style.
3. Get a body template using `gf pr template`.
4. Create a pull request with following the template.
5. Run `gf pr create --title <title> --body <body> -B <target_branch>`
   to create a pull request on the remote server.

## Create Worktree

When you're required to create a worktree or something to edit files,
create a worktree for your task using the `git worktree add` command.

### Procedure

1. Analyze the user request to understand your task.
2. To get repository name, run `git remote get-url origin` command.
   If you run on Windows PowerShell, run:

   ```ps1
   [System.IO.Path]::GetFileNameWithoutExtension((git remote get-url origin))
   ```

   If you run on Linux or macOS (Bash or Zsh), run:

   ```sh
   basename $(git remote get-url origin) .git
   ```

3. Based on the user request, determine the branch name.
   The branch name MUST follow the conventional commit style
   or the issue tag. If user specified the tag, use the tag.
   Otherwise you determine the tag based on the user request contents.

4. Determine the worktree directory name. The worktree directory name
   MUST follow the style `<repository-name>_<branch-name>`.
   For example, if the repository name is `some-repo` and the branch name
   is `feature/auth-api`, the worktree directory name MUST be
   `some-repo_feature-auth-api`.

5. Create a worktree in the temporary directory using
   `git worktree add <temp_dir>/<worktree-directory-name> -b <branch/name>`.

### Strict Rules

- **Do NOT** create a temporary file in the project directory.
  If you run on Linux or macOS, use `/tmp/**`.
  If you run on Windows, use `~/AppData/Local/Temp/**`.

## Remove Worktree

When you're requested to remove a worktree, use this skill.

### Procedure

1. Run `git worktree remove <temp_dir>/<worktree-directory-name>`
   command to remove the worktree directory.

## Resolve the Issue

When you're required to resolve an issue or something to edit files in the project,
use this skill and follow with the instructed procedure.

### Procedure

1. Analyze the user request, and detect the remote repository forge.
   The remote repository forge should be either GitHub, GitLab or Gitea.
   If you cannot detect the repository forge from the user request,
   ask the user what is the repository forge.
2. Load skills for the repository forge.
   If the forge is GitHub, use [[github-workflow]] skill.
   If the forge is Gitea, use [[gitea-workflow]] skill.
3. If the issue number is specified in the user request, read the issue with skills.
   Otherwise, get the issue list with skills, and ask the user to select one issue to resolve.
4. If there is no issue that matches the user request, create a new issue using skills.
5. Create a worktree for the issue with skills and checkout the branch for the issue.
6. Edit files in the worktree to resolve the issue.
7. Create a commit with skills, and push the branch to the remote repository.
8. Create a pull request with skills, and link the pull request to the issue.
9. Remove the worktree with skills.

### Strict Rules

- Do NOT work on the current branch directly.
  Always create a new branch for your work
  and create a pull request to merge it into the current branch
  or the user specified branch.
