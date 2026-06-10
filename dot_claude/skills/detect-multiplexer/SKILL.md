---
name: detect-multiplexer
description: When you're asked to work on multiplexer pane, you MUST use this skill to detect the type of multiplexer.
---

## Detect multiplexer

Before working on a multiplexer pane, you MUST use this skill to detect the type of multiplexer.

Detect the type of multiplexer by checking the environment variables.
The type must be either `Tmux`, `Zellij` or `Wezterm`.

If you run on Windows PowerShell, to check a environment variable with the following command:

```ps1
echo $env:ENV_VARIABLE
```

If you run on Linux or macOS (bash or zsh), to check a environment variable with the following command:

```sh
echo $ENV_VARIABLE
```

> [!NOTE]
> Replace `ENV_VARIABLE` with the actual environment variable name that indicates the multiplexer type.
> For example, `TMUX_PANE` for Tmux, `ZELLIJ_PANE_ID` for Zellij, and `WEZTERM_PANE` for Wezterm.

### Procedure

1. Check the environment variables `ZELLIJ_PANE_ID`.
   If the variable is defined, the session type is `Zellij`

2. Check the environment variables `TMUX_PANE_ID`.
   If the variable is defined, the session type is `Tmux`

3. Check the environment variables `WEZTERM_PANE`.
   If the variable is defined, the session type is `Wezterm`

> [!NOTE]
> The priority of the checks is as follows: `Zellij` > `Tmux` > `Wezterm`.
> If multiple environment variables are defined, the first one that is detected will determine the multiplexer type.

> [!CAUTION]
> You MUST verify each variable one by one in the order of priority.
> Do NOT check all variables at once, as it may lead to incorrect detection if multiple variables are defined.
>
> This is a strict requirement to ensure accurate detection of the multiplexer type.
>
> ✅ Correct:
>
> ```sh
> echo $ZELLIJ_PANE_ID
> echo $TMUX_PANE
> echo $WEZTERM_PANE
> ```
>
> ❌ Incorrect:
>
> ```sh
> echo $ZELLIJ_PANE_ID; echo $TMUX_PANE; echo $WEZTERM_PANE;
> ```
