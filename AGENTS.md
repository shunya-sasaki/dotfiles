# AGENTS.md

This document defines the AI agent architecture used in this repository.
Each agent encapsulates a single, well-defined responsibility,
code generation, review, documentation, or vulnerability analysis,
and operates through reproducible workflows built on LLMs and local tools.

## Project overview

This project manages dot files.

## Code style guidelines

### Git commit messages

- Create git commit messages based on the result of `git diff --cached`.
- Use the conventional commit format, the commit message should be structured as follows:

  '''
  <type>[optional scope]: <description>

  [optional body]

  [optional footer(s)]
  '''

- The first line is the commit title and should be concise.
- The length of the first line must be at most 50 characters.
- The description should start with lower letter.
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

## Testing instructions

This project needs no tests.

## Security considerations

- No passwords or secrets must not be written in any scripts.
