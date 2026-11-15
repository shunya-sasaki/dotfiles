---
name: git-workflow
description: >
  Use this skill for any Git or forge task. IF you are asked to create a commit,
  create an issue, create or update a pull request, create a branch, create or
  remove a worktree, write a commit message, or resolve an issue,
  you MUST use this skill.
---

# Git Workflow

This skill provides instructions for working with Git repositories and their
forges. Use `git` for local operations and `gitforge` for forge operations
(issues, pull requests, labels) and worktree management. `gitforge` auto-detects
the forge (GitHub or Gitea), so the same commands work regardless of the remote.

Tasks described in this skill:

- Generate Commit Message
- Create Issue
- Create Pull Request
- Create Worktree
- Remove Worktree
- Resolve the Issue

## Common arguments

`gitforge` commands share these arguments:

- `<title>`: Title of an issue or pull request. Must be concise (max 50
  characters) and follow the **Conventional Commit** style,
  `<type>(<scope>): <description>` or `<type>: <description>`, with a lowercase
  description in the imperative mood.
  e.g. `feat(doc): add issue creation procedure`
- `<type>`: One of the following:
  - `feat`: A new feature
  - `fix`: A bug fix
  - `docs`: Documentation only changes
  - `style`: Changes that do not affect meaning (formatting, white-space, etc.)
  - `refactor`: A code change that neither fixes a bug nor adds a feature
  - `perf`: A code change that improves performance
  - `test`: Adding or correcting tests
  - `chore`: Auxiliary tools, e.g. documentation generation
  - `build`: Changes to the build system or external dependencies
  - `ci`: Changes to CI configuration files and scripts
  - `revert`: Reverts a previous commit
- `<scope>`: Optional area of the change, e.g. `doc`, `api`, `workflow`.
- `<body>`: Body of an issue or pull request, composed from its template.
- `<label>`: Label name. Get the available labels with `gitforge label list`.
- `<target_branch>`: Base branch of a pull request. Defaults to `main`.
- `<number>`: Issue or pull request number.
- `<branch_name>`: Name of the branch to work on, following the **Conventional
  Commit** style or the issue tag, e.g. `feat/add-login`.

### Strict Rules

- The title and body MUST NOT contain any ANSI escape sequences, terminal
  control codes, or other non-printable characters, including:
  - SGR / color codes such as `\x1b[31m`, `\033[0m`, `[1;32m`
  - Cursor and screen codes such as `\x1b[2k`, `\x1b[?25l`, `\x1b[H`
  - Any byte in the ranges `\x00`-`\x08`, `\x0B`-`\x1F`, or `\x7F`
- If any command output you read contains such sequences, strip them before
  including the content. After composing the body, scan it once more and remove
  any remaining bytes that match `\x1B\[`, `\x1B\]`, or other C0/C1 control
  characters.

## Generate Commit Message

### Procedure

1. Run `git --no-pager diff --cached --no-color` to get staged changes.
2. Based on the staged changes, generate a commit message following the
   **Conventional Commit** style (see [Common arguments](#common-arguments)).
3. Output ONLY the raw commit message with no code blocks, explanations,
   or fillers.

## Create Commit

IF you're asked to create a commit, THEN you MUST work on this task.

### Procedure

1. Create commit title and body (see [Generate Commit Message](#generate-commit-message)).
2. Run `gitforge commit --title <title> --body <body>` to create a commit.

## Create Issue

IF you're asked to create an issue, THEN you MUST work on this task.

### Procedure

1. Understand the user's request, problem report, or improvement idea.
2. If the repository context is needed, inspect relevant files to understand the
   current implementation, configuration, documentation, or behavior.
3. Create the `<title>` using the **Conventional Commits** style.
4. Get the available labels with `gitforge label list` and select appropriate
   `<labels>` from the list. If the list is empty or none match, proceed without
   labels.
5. Compose the `<body>` following the **Template** below.
6. Run `gitforge issue create --title "<title>" --body "<body>" --label "<labels>"`
   (pass multiple labels as comma-separated values or repeated `--label` flags;
   omit `--label` if no labels were selected).

### Issue Template

Compose the `<body>` using the following structure.
Note: Sections marked as `(Optional)` MUST be omitted entirely (or marked as `N/A`) if not applicable.
Do not include the `(Optional)` tag in the final output.

```md
## Summary

<!-- 1-3 sentences summarizing the issue, problem, or feature request. -->

## Description

<!-- Detailed explanation of the background, problem statement, reproduction steps (if bug), or proposed specifications. -->

## Objective

<!-- State the goal and expected outcome of resolving this issue. -->

## Investigation / Context (Optional)

<!-- Preliminary findings from Step 2 (relevant files, current behavior, root cause, constraints).
     Omit this section if no preliminary investigation was conducted. -->

## Included Scope

<!-- Bullet points of specific changes, components, or tasks included in this issue. -->

-

## Excluded Scope

<!-- Bullet points of items explicitly out of scope to prevent scope creep (write "None" if nothing specific). -->

-

## Acceptance Criteria

<!-- Concrete, verifiable conditions that must be met to close this issue. -->

- [ ]

## Phase Plan

<!-- Omit for simple issues that do not require phased execution. -->

<!-- Break down into sequential implementation phases if the task requires multiple steps.
     Omit this section for simple, single-step fixes or tasks. -->

### Phase 1: Investigation & Detailed Planning

### Phase 2: ...

### Phase N: Final Validation

## Related Issues (Optional)

<!-- Links or references to related issues, PRs, or discussions (e.g., #123). Omit if none. -->
```

## Create Phase Closing Comment

IF all tasks of a Phase are completed (or you're asked to close a phase), THEN you MUST create a phase closing comment on the issue.

### Procedure

1. Review the completed work for the current phase:
   - Check recent commits and changes (`git --no-pager log` / `git --no-pager diff`) to gather accurate commit hashes, changed files, and validation results.
   - Review the phase plan and any decisions made during the phase.
2. Compose the `<comment_body>` following the **Template** below. Ensure that the reasoning behind decisions and file changes is clear for anyone reviewing the history later.
3. Post the comment to the target issue using `gitforge` (or output the comment if posting is handled manually).

### Phase Closing Comment Template

```md
## Phase N Closing: <phase title>

<!-- 1-3 sentences summarizing the completion of this phase. -->

### Phase History

| Phase | Title | Difficulty | Accepted Commit or Evidence | Status    |
| ----- | ----- | ---------- | --------------------------- | --------- |
| 1     | ...   | High       | `<hash>` / link             | Completed |
| 2     | ...   | Medium     | -                           | Planned   |

### Objective

<!-- State the goal of this phase. -->

### Result

<!-- Summarize what was achieved, implemented, or investigated in this phase. -->

### Key Decisions

<!-- Document developer judgments, architectural choices, trade-offs, and why specific approaches were selected. -->

-

### Plan Revision (Optional)

<!-- Document any updates, newly added sub-phases (e.g., Phase 2.1), or adjustments to subsequent phases. Omit if no changes to the plan. -->

### Changed Files

<!-- List modified/added/deleted files with a brief explanation of what changed and why. -->

- `path/to/file`:

### Validation

<!-- Concrete commands run and their outcomes (e.g., pytest results, linter checks, manual verification). -->

-

### Deviations

<!-- Any departures from the phase plan and the reason why. Write "None" if executed strictly as planned. -->

### Compatibility Impact

<!-- Breaking changes, config updates, or migration steps required. Write "None" if fully backward-compatible. -->

### Remaining Constraints

<!-- Known limitations, technical debt, or edge cases deferred to later phases. Write "None" if none. -->

### Next Action

<!-- Clear, actionable summary of what will be tackled in the next phase. -->
```

> [!NOTE]
>
> - **Difficulty Tier**: Use the standard difficulty tiers (`Low`, `Medium`, `High`, `Xhigh`)
>   in the `Phase History` table.
> - **Clarity for Reviewers**: Write Key Decisions and Changed Files clearly
>   so that less experienced developers can easily understand
>   why a decision was made and how the code changed.
> - **Optional & Empty Sections**: Omit sections marked `(Optional)`
>   if not applicable. For `Deviations`, `Compatibility Impact`,
>   and `Remaining Constraints`, explicitly write `None` when not applicable
>   rather than leaving them blank.
>   Never include the `(Optional)` label or HTML comments in the final output.

## Read Issue

IF you're asked to read an issue, THEN you MUST work on this task.

### Procedure

1. Run `gitforge issue view <number>` to fetch the issue.
2. Read the issue and understand what it asks for: the problem it reports, the
   change it requests, and any acceptance criteria or context it provides.

## Create Pull Request

IF you're asked to create a pull request (PR), THEN you MUST work on this task.

### Procedure

1. Determine the `<target_branch>` (default to `main` if not specified).
   - Run `git --no-pager diff --no-color <target_branch>...HEAD` to inspect all
     changes. Read the ENTIRE diff and identify every meaningful change; this
     diff is the single source of truth for the `<title>` and `<body>`.
   - Run `git --no-pager log --no-color --format="%s : %h" <target_branch>..HEAD`
     to retrieve the commit titles and hashes for the template.
2. Create the `<title>` using the **Conventional Commits** style, derived strictly
   from the changes in the diff.
3. Get the available labels with `gitforge label list` and select appropriate
   `<labels>` from the list. If the list is empty or none match, proceed without
   labels.
4. Compose the `<body>` by filling the **Template** below with the actual changes
   from step 1. Every claim in the body MUST correspond to a change present in
   the diff; do NOT invent, omit, or generalize changes, and do NOT describe
   work that is not in the diff.
5. Before creating the PR, verify the `<body>` against the diff: confirm each
   described change appears in the diff and no significant change is missing.
   Ensure the current branch is pushed to the remote repository.
6. Run `gitforge pr create --title "<title>" --body "<body>" -B "<target_branch>" --label "<labels>"`
   (omit `--label` if no labels were selected).

### Template

```md
## Summary

<!-- High-level overview (1-3 sentences) of what this PR accomplishes and why. -->

## Changes

<!-- Detailed bullet points of all meaningful changes present in the diff. -->

-

## Related Issues (Optional)

<!-- e.g., Closes #N, Refs #N. Omit if no related issue exists. -->

Closes #N

## Related Commits

<!-- List of commits from `<target_branch>..HEAD` in `<commit title> : <hash>` format. -->

- <commit title> : <hash>

## Testing

<!-- Describe how these changes were verified (e.g., pytest, manual verification, CI checks). -->

-
```

## Create Worktree

When you're required to create a worktree or an isolated copy to edit files,
create one with `gitforge worktree create`.

### Procedure

1. Analyze the user request to understand your task.
2. Determine the `<branch_name>`. Use the tag the user specified; otherwise
   derive it from the request.
3. Run `gitforge worktree add <branch_name>`. It creates the worktree at
   `~/.tmp/<repository-name>_<branch-name>` (the repository name is detected
   from the remote) and prints the path. Work in that directory.

### Notes

- `gitforge` reuses the branch if it already exists; otherwise it creates a new
  one.
- `gitforge` places the worktree under `~/.tmp/`, never in the project
  directory.

## Remove Worktree

When you're requested to remove a worktree, use this skill.

### Procedure

1. Run `gitforge worktree remove <branch_name>` to remove the worktree.

### Notes

- This removes only the worktree directory; the branch is kept.

## Resolve the Issue

When you're required to resolve an issue or something to edit files in the
project, use this skill and follow the instructed procedure.

### Procedure

1. Analyze the user request.
2. If the issue number is specified, view it with
   `gitforge issue view <number>`. Otherwise list issues with
   `gitforge issue list` and ask the user which to resolve.
3. If no issue matches the user request, create a new issue
   (see [Create Issue](#create-issue)).
4. Edit files in the worktree to resolve the issue.
5. Commit your changes (see [Generate Commit Message](#generate-commit-message))
   and push the branch to the remote repository.
6. Create a pull request linked to the issue
   (see [Create Pull Request](#create-pull-request)).

### Strict Rules

- Do NOT work on the `main` branch directly.
