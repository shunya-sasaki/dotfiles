---
name: multiplexer
description: When you are asked to send a message to or read a buffer of another multiplexer pane, you MUST use this skill to run the `mux` command.
---

# Multiplexer

`mux` is a unified wrapper over the Tmux, Zellij and WezTerm multiplexers.
It detects the backend and your self pane id automatically from the
environment, so you do NOT need to choose a backend-specific command.

> [!NOTE]
> The backend is detected from `ZELLIJ_PANE_ID`, `TMUX_PANE` or
> `WEZTERM_PANE`. Run `mux` only from inside a multiplexer pane.

## Send message to another pane

When you are asked to send a message to another pane, you MUST use `mux send`.

```sh
mux send <PANE_ID> '[TEXT]'
```

To send the message without a trailing enter key, add `--without_enter`:

```sh
mux send <PANE_ID> '[TEXT]' --without_enter
```

### Procedure

1. Create a message.
2. Send the message to the specified pane with `mux send`.

> [!NOTE]
> `<PANE_ID>` is the target pane id and `[TEXT]` is a message you create.
> `mux send` appends the enter key by default; pass `--without_enter`
> only when you intend to leave the input unsubmitted.

> [!CAUTION]
> Do NOT confuse your self pane id and other pane ids.

## Read buffer of another pane

When you are asked to read a pane, you MUST use `mux read`.

```sh
mux read <PANE_ID>
```

### Procedure

1. Read the pane content with `mux read`.
2. Parse the output and analyze the status.
