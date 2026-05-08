---
name: generate-pull-request
description: Generate a concise and informative pull request title and description based on the provided code changes.
---

# Generate Pull Request

## Procedure

1. Run `git --no-pager diff --no-color <target-branch>...HEAD` to get the
   detailed changes between the current branch and the target branch.
   If `<target-branch>` is not specified, use `main` as the default.
2. Always pass `--no-color` (and prefer `--no-pager`) to any `git` command
   whose output you read. If a command does not support `--no-color`, run it
   with `TERM=dumb` and `GIT_PAGER=cat` so colors are not embedded as
   ANSI escape sequences in captured output.
3. Create the PR title using the **Conventional Commit** style.
4. If `.github/pull_request_template.md` (or any PR template file) exists in
   the repository, use it as the description template.
5. Otherwise, generate a description that includes:
   - **Summary**: A brief summary of the changes.
   - **Related Issue**: Any related issue numbers (e.g., `Closes #123`).
   - **How Has This Been Tested**: A brief explanation of how the changes were tested.
   - **Checklist**: Items to complete before merging
     (e.g., `- [ ] Code compiles correctly`, `- [ ] Tests cover new code`).

## Output

Output ONLY the title and the raw message body, as plain UTF-8 text.

## Constraints

- **Plain text only.** The title and body MUST NOT contain any ANSI escape
  sequences, terminal control codes, or other non-printable characters.
  This includes, but is not limited to:
  - SGR / color codes such as `\x1b[31m`, `\033[0m`, `\u001b[1;32m`
  - Cursor and screen codes such as `\x1b[2K`, `\x1b[?25l`, `\x1b[H`
  - Any byte in the ranges `\x00`–`\x08`, `\x0B`–`\x1F`, or `\x7F`
- If any tool or command output you read contains such sequences,
  **strip them before** including the content in the PR body. Example:
  `<command> | sed -E 's/\x1B\[[0-9;]*[a-zA-Z]//g; s/\x1B\][^\x07]*\x07//g'`
- After composing the body, scan it once more and remove any remaining
  bytes that match `\x1B\[`, `\x1B\]`, or other C0/C1 control characters.
- The title must be concise (max 50 characters) and follow:
  `<type>[scope]: <description>`
- `<type>` must be one of: `feat`, `fix`, `docs`, `style`, `refactor`,
  `perf`, `test`, `build`, `ci`.
- When invoking `gh pr create`, pass the body via `--body-file <tmpfile>`
  with a temporary plain-text file rather than `--body "..."`. This avoids
  the shell expanding `\e`, `\033`, or other escape sequences during
  interpolation.
