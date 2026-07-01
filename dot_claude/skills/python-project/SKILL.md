---
name: python-project
description: >
  Use this skill for any Python work: writing or changing Python code, and
  setting up or configuring a Python project. It defines the preferred tech
  stack (uv, ruff, ty, pytest, pydantic), project layout, and code-style
  conventions. IF you write, change, lint, format, type-check, test, or scaffold
  Python, you MUST use this skill.
---

# Python Project

This skill is the single entry point for Python work. It defines the preferred
tech stack, project layout, and code-style conventions. Prefer these defaults;
do not introduce alternatives without a clear reason.

## Tech Stack

Use these tools by default. Do NOT reach for alternatives (poetry, black, isort,
flake8, mypy, unittest) unless the project already uses them or there is a
specific reason (argparse, click, poetry, black, isort, flake8, mypy,
unittest).

| Tool       | Role                                         |
| ---------- | -------------------------------------------- |
| `uv`       | Dependency and project management            |
| `ruff`     | Linting, formatting, and import sorting      |
| `ty`       | Static type checking                         |
| `pytest`   | Testing                                      |
| `pydantic` | Data models and validation (`BaseModel`)     |
| `typer`    | Command-line interfaces and argument parsing |

## Project Layout

- Keep all configuration in `pyproject.toml`.
- Use a `src/<package>/` layout for the package source.
- Place tests under `tests/`.
- Keep shared helpers (e.g. the alias generator below) in the package `utils`
  module.

## Dependency Management (uv)

Use `uv` for everything; do NOT call `pip` directly.

- `uv add <pkg>` / `uv add --dev <pkg>`: add runtime or dev dependencies.
- `uv sync`: install dependencies from the lockfile.
- `uv lock`: update the lockfile.
- `uv run <command>`: run a command in the project environment.

Commit `uv.lock` to the repository.

## Lint / Format / Imports

Use `ruff` to lint, format, and organize imports. Use absolute imports.

## Type Checking

- Use `ty` for static type checking.
- Annotate all function parameters and return types.
- Code MUST be type-check clean before it is considered done; do not use
  unchecked `Any` escape hatches without justification.

## Testing (pytest)

- Use `pytest` as the testing framework.
- Name test files `test_*.py` under `tests/` and test functions `test_*`.
- Run tests with `uv run pytest`.

## CLI (typer)

- Use `typer` to build command-line interfaces and parse arguments; do NOT use
  `argparse` or `click` directly.
- Define each command as a function with type-annotated parameters; typer
  derives options and arguments from the annotations.
- Use `typer.Argument(...)` and `typer.Option(...)` to attach help text,
  defaults, and validation; give every argument and option a `help` string.
- Keep CLI entry points thin: parse and validate with typer, then delegate to
  library functions so the logic stays testable without the CLI.
- Register the entry point via `pyproject.toml` `[project.scripts]` and run it
  with `uv run`.

## Naming

- Use snake_case for variables and functions, PascalCase for classes.
- Use snake_case for packages and modules.
- Use UPPER_SNAKE_CASE for constants.
- Use _leading_underscore for private variables, classes and methods.

## Line Length

- Limit lines to 79 characters for better readability.

## Docstrings

- Use google style docstrings for all public modules, functions, classes, and
  methods.

## Type annotations

- Use type annotations for all function parameters and return types.

## User types

- Use `BaseModel` from pydantic to define user types for data validation and
  settings management.
- Define a helper function in [package]/utils module and use it as an alias
  generator for user types. The helper function should convert snake_case to
  camelCase.
