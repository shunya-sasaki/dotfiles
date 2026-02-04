---
name: generate-commit-message
description: Generate a concise and informative git commit message based on the provided code changes.
---

Run `git --no-pager diff --cached --no-color` to get staged changes, then generate a commit message using:

**Format**: `<type>[scope]: <description>` (max 50 chars, lowercase description, imperative mood)

**Types**: feat, fix, docs, style, refactor, perf, test, build, ci

**Example**: `feat(zed): add setting files for Zed`

## OUTPUT

Output ONLY the raw commit message with no code blocks, explanations, or fillers.
