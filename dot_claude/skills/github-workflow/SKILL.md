---
name: github-workflow
description: When you're asked to work with GitHub, you MUST use this skill.
---

# GitHub Workflow

This skill provides instructions for GitHub repositories
using the official `gh` CLI.

## Create Issue

When you're asked to create a issue, use this skill.

### Procedure

1. Understand the user's request, problem report, or improvement idea.
2. If the repository context is needed, inspect relevant files in the repository
   to understand the current implementation, configuration, documentation,
   or behavior.
3. Create the issue title using the **Conventional Commit** style.
4. If `.github/ISSUE_TEMPLATE/bug_report.md`
   or `.github/ISSUE_TEMPLATE/feature_request.md`
   (or any issue template file) exists in the repository,
   use it as the description template.
5. Otherwise, generate a description that includes:

   ```markdown
   ## Summary

   <!-- A brief summary of the changes. -->

   ## Motivation Issue

   <!-- Why is this issue to resolved? -->

   ## Proposed Solution

   <!-- Describe your preferred solution. -->

   ## Scope

   <!-- Check or describe the expected scope. -->

   - [ ] UI / frontend
   - [ ] API / backend
   - [ ] Database
   - [ ] Infrastructure
   - [ ] Documentation
   - [ ] Other:

   ## Acceptance Criteria

   <!-- Define what should be true when this issue is completed. -->
   ```

6. Use **Write tool** to write the issue body to temporary Markdown file.
7. Get labels for the project with `gh label list` and select one for this issue.
8. Use **Read tool** to get the contents of temporary Markdown file.
9. Run `gh issue create --title <title> --body <body> --label <label>`
   to create the issue on GitHub server.
10. Remove the temporary Markdown file.

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
- **Do NOT** create a temporary file in the project directory.
  If you run on Linux or macOS, use `/tmp/**`.
  If you run on Windows, use `~/AppData/Local/Temp/**`.

## Create Pull Request

When you're asked to create a PR (pull-request), use this skill.

### Procedure

1. Run `git --no-pager diff --no-color <target-branch>...HEAD` to get the
   detailed changes between the current branch and the target branch.
   If `<target-branch>` is not specified, use `main` as the default.
2. Create the PR title using the **Conventional Commit** style.
3. If `.github/pull_request_template.md` (or any PR template file) exists in
   the repository, use it as the description template.
4. Otherwise, generate a description that includes:

   ```markdown
   <!-- Title should follow Conventional Commit style, e.g.
   feat(workflow): Add workflow to build docker container image -->

   ## Summary

   <!-- What does this PR do, and why? Keep it short. -->

   ## Related Issues

   <!-- e.g. Closes #123, Fixes #456 -->

   ## How Has This Been Tested?

   <!-- e.g.
   - Ran `pytest` (including any new tests) - all tests passed
   - Verified functionality locally (e.g. CLI / FastAPI endpoints / scripts)
   - Ran `ruff check` and `ruff format` (or `black`) - no issues
   - Ran `mypy` for type checking (if enabled)
   - Confirmed behavior with representative inputs and edge cases
   -->

   ## Checklist

   - [ ] Self-reviewed the diff
   - [ ] Added/updated test
   - [ ] Updated documentation if needed
   - [ ] Linter and tests pass locally
   ```

5. Use **Write tool** to write the PR body to temporary Markdown file.
6. Get labels for the project with `gh label list` and select one for this PR.
7. Use **Read tool** to read the description of the PR from the Markdown file.
8. Run `gh pr create --title <title> --body $description --label <label> -B <target-branch>`
   to create a PR on the GitHub server.
9. Remove the temporary Markdown file.

### Strict Rules

- The title and body MUST NOT contain any ANSI escape sequences,
  terminal control codes, or other non-printable characters.
  This includes, but is not limited to:
  - SGR / color codes such as `\x1b[31m`, `\033[0m`, `\u001b[1;32m`
  - Cursor and screen codes such as `\x1b[2k`, `\x1b[?25l`, `\x1b[H`
  - Any byte in the ranges `\x00`-`\x08`, `\x0B`-`\x1F`, or `\x7F`
- If any tool or command output you read contains such sequences,
  **strip them before** including the content in the PR body.
- After composing the body, scan it once more and remove any remaining bytes
  that match `\x1B\[`, `\x1B\]`, or other C0/C1 control characters.
- The title must be concise (max 50 characters) and follow:
  `<type>(scope): <description>`
- `<type>` must be one of: `feat`, `fix`, `docs`, `style`, `refactor`,
  `perf`, `test`, `build`, `ci`.
- **Do NOT** create a temporary file in the project directory.
  If you run on Linux or macOS, use `/tmp/**`.
  If you run on Windows, use `~/AppData/Local/Temp/**`.

## Create templates

### Procedure

#### Create GitHub directory in the project

1. If `.github` directory does not exist, create it.

#### Create template for pull request

1. Check the file `.github/pull_request_template.md` exist.
2. If the target file does not exist, create it using the following template.
   If the target template file has already existed, do nothing, do NOT overwrite it.

_.github/pull_request_template.md_

```markdown
<!-- Title should follow Conventional Commit style, e.g.
feat(workflow): Add workflow to build docker container image -->

## Summary

<!-- What does this PR do, and why? Keep it short. -->

## Related Issues

<!-- e.g. Closes #123, Fixes #456 -->

## How Has This Been Tested?

<!-- e.g.
- Ran `pytest` (including any new tests) - all tests passed
- Verified functionality locally (e.g. CLI / FastAPI endpoints / scripts)
- Ran `ruff check` and `ruff format` (or `black`) - no issues
- Ran `mypy` for type checking (if enabled)
- Confirmed behavior with representative inputs and edge cases
-->

## Checklist

- [ ] Self-reviewed the diff
- [ ] Added/updated test
- [ ] Updated documentation if needed
- [ ] Linter and tests pass locally
```

### Create templates for issues

1. If `.github/ISSUE_TEMPLATE` does not exist in the project, create it.
2. If `.github/ISSUE_TEMPLATE/bug_report.md` doesn't exist, create as the following:

_.github/ISSUE_TEMPLATE/bug_report.md_

```markdown
---
name: Bug report
about: Report a reproducible bug or unexpected behavior
title: "fix: "
labels: bug
assignees: ""
---

## Summary

<!-- Briefly describe the bug. -->

## Current behavior

<!-- What is currently happening? -->

## Expected behavior

<!-- What did you expect to happen? -->

## Steps to reproduce

<!-- Provide clear steps so that others can reproduce the issue. -->

1.
2.
3.

## Environment

<!-- Fill in the relevant items. Remove items that are not applicable. -->

- OS:
- Browser:
- Version:
- Runtime:
- Package manager:
- Related service/application:

## Logs or screenshots

<!-- Paste logs, error messages, screenshots, or stack traces if available. -->
```

3. If `.github/ISSUE_TEMPLATE/feature_request.md` doesn't exist, create as the following:

```markdown
---
name: Feature request
about: Suggest an idea or improvement
title: "feat: "
labels: enhancement
assignees: ""
---

## Summary

<!-- Briefly describe the feature or improvement. -->

## Motivation

<!-- Why is this feature needed? What problem does it solve? -->

## Proposed solution

<!-- Describe your preferred solution. -->

## Alternatives considered

<!-- Describe alternative solutions or workarounds you have considered. -->

## Scope

<!-- Check or describe the expected scope. -->

- [ ] UI / frontend
- [ ] API / backend
- [ ] Database
- [ ] Infrastructure
- [ ] Documentation
- [ ] Other:

## Acceptance criteria

<!-- Define what should be true when this issue is completed. -->

- [ ]
- [ ]
- [ ]

## Additional context

<!-- Add screenshots, links, references, or related issues if available. -->
```
