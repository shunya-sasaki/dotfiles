---
name: detect-multiplexer
description: When you're asked to work on multiplexer pane, you MUST use this skill to detect the type of multiplexer.
---

## Detect multiplexer

Before working on a multiplexer pane, you MUST use this skill to detect the type of multiplexer.

Detect the type of multiplexer by checking the environment variables.
The type must be either `Tmux`, `Zellij` or `WezTerm`.

### Procedure

1. Run command `detect_multiplexer`, and the output will be
   the type of multiplexer, which must be either `Tmux`, `Zellij` or `WezTerm`.
