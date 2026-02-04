---
name: generate-commit-message
description: Generate a concise and informative git commit message based on the provided code changes.
---

When generating a git commit message, please follow these guidelines:

1. **Get diff**: Run `git --no-pager diff --cached --no-color` to get the staged changes.
2. **Analyze changes**: Review the diff output to understand what changes have been made.
3. **Summarize changes**: Create a concise summary of the changes, focusing on the main purpose and impact of the modifications.
4. **Use imperative mood**: Write the commit message along with the conventional commit message style,
   using the imperative mood (e.g., "Add feature" instead of "Added feature" or "Adding feature").
5. **Limit length**: Keep the commit message brief, ideally under 50 characters for the summary line, and provide additional details in the body if necessary.

## Git commit message guildelines

- Use the conventional commit format, the commit message should be structured as follows:

  ```
  <type>[optional scope]: <description>

  [optional body]

  [optional footer(s)]
  ```

- The first line is the commit title and should be concise.
- The length of the first line must be at most 50 characters.
- The description should start with lower letter.
- The all message should be written in English.
- The third line is optional and can provide additional context or details about the change.
- The type in the first line must be one of the following:
  - build: Changes that affect the build system or external dependencies
  - ci: Changes to our CI configuration files and scripts
  - docs: Documentation only changes
  - feat: A new feature
  - fix: A bug fix
  - perf: A code change that improves performance
  - refactor: A code change that neither fixes a bug nor adds a feature
  - style: Changes that do not affect the meaning of the code
  - test: Adding missing tests or correcting existing tests
- The example is as follows:

  ```
  feat(zed): add setting files for Zed
  ```

## STRICT OUTPUT RULES (CRITICAL)

- **Output ONLY the raw commit message.**
- **Do NOT** output markdown code blocks (no \`\`\`).
- **Do NOT** include conversational fillers like "Here is the commit message" or "Based on the diff".
- **Do NOT** include explanations or a breakdown of why you chose the message.
- Your output will be piped directly to a file; any extra text will break the build.
