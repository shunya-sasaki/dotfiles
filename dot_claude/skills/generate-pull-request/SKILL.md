---
name: generate-pull-request
description: Generate a concise and informative pull request title and description based on the provided code changes.
---

# Generate Pull Request

## Procedure

- Run `git --no-pager diff --no-color <target-branch>...HEAD`
  to get detailed changes between the current branch and the target branch.
  If `<target-branch>` is not specified, use `main` as the default target branch.
- Create the title of the pull request using the **Conventional Commit** style.
- If there is `.github/pull_request_template.md` or any template files
  for PR in the repository, use it as a template for the description.
- If there is no template, generate a description that includes:
  - **Summmary**: A brief summary of the changes.
  - **Related Issue**: Any related issue numbers (e.g., `Closes #123`).
  - **How Has This Been Tested**: A brief explanation of how the changes were tested.
  - **Checklist**: A checklist of items to be completed before merging
    (e.g., "-[ ] Code compiles correctly", "-[ ] Tests cover new code").

## Output

Output ONLY the title and raw message.

## Strictions

- **Do NOT** output any ansy escape characters.
- The title should be concise (max 50 characters) and
  follow the Conventional Commit format:
  `<type>[scope]: <description>`
- `<type>` should be one of: feat, fix, docs, style, refactor, perf, test, build, ci.
