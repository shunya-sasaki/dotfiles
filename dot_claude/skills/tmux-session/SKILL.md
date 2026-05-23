---
name: tmux-session
description: When you are asked to work on tmux, you MUST use this skill to run tmux commands.
---

## Get self pane id

Before running any other tmux tasks, you MUST run this task.
Get your current pane id from the environment variable `TMUX_PANE`.

If you are running on Windows PowerShell, run:

```ps1
echo $env:TMUX_PANE
```

If you are running on Linux or macOS (bash or zsh), run:

```sh
echo $TMUX_PANE
```

### Procedure

1. Get pane id with using the `echo` command.
2. Return the pane id to the user.

> [!NOTE]
> tmux pane ids start with `%` (e.g. `%0`, `%1`). This global pane
> id is distinct from the per-window pane index (e.g. `0`, `1`)
> shown by `tmux list-panes` without `-a`.

## Get the status of sessions, windows and panes

When you are asked to get pane ids, you MUST run `tmux list-panes`.

```sh
tmux list-panes -a -F '#{session_name}:#{window_index}.#{pane_index} #{pane_id} #{pane_current_command}'
```

You may also list sessions and windows:

```sh
tmux list-sessions
tmux list-windows -a
```

### Procedure

1. Run `tmux list-panes -a -F ...`.
2. Parse the output and analyze the status.
3. Check the position of your pane and your adjacent panes.

> [!CAUTION]
> Do NOT confuse your pane id and other pane ids.

## Get text from a pane

When you are asked to read a pane, you MUST run the following command to get pane contents:

```sh
tmux capture-pane -p -t <PANE_ID>
```

If you also need the scrollback buffer, add `-S -<N>` to capture the last `N` lines:

```sh
tmux capture-pane -p -t <PANE_ID> -S -1000
```

To capture the entire scrollback, use `-S -`:

```sh
tmux capture-pane -p -t <PANE_ID> -S -
```

### Procedure

1. Get pane content by using the `tmux capture-pane` command.

> [!NOTE]
> The `-p` flag prints to STDOUT. Without it, the capture is stored
> in a tmux paste buffer instead of being printed.

## Send text to a pane

When you are asked to send a message to other pane, you MUST use `tmux send-keys`.

For a single line message in Windows PowerShell, run:

```ps1
tmux send-keys -t <PANE_ID> "[TEXT]"
```

For a single line message in Linux or macOS (bash or zsh), run:

```sh
tmux send-keys -t <PANE_ID> $'[TEXT]'
```

If the message contains multi line text, run:

```sh
cat<<'EOF' | tmux load-buffer - && tmux paste-buffer -t <PANE_ID>
[TEXT]
EOF
```

> [!NOTE]
> `[TEXT]` is a message you create.

### Procedure

1. Create a message.
2. Send the message to the specified pane with the command.
3. If you sent the single line message, send the enter key.
   If you run on Windows PowerShell, run literally:

   ```ps1
   tmux send-keys -t <PANE_ID> Enter
   ```

   If you run on Linux or macOS (bash or zsh), run literally:

   ```sh
   tmux send-keys -t <PANE_ID> Enter
   ```

> [!CAUTION]
> Use the `Enter` key name (or the equivalent `C-m`) to send the
> enter key.
>
> ✅ Correct:
>
> ```sh
> tmux send-keys -t <PANE_ID> Enter
> ```
>
> ❌ Incorrect:
>
> ```sh
> tmux send-keys -t <PANE_ID> '\r'
> ```
>
> NEVER pass the literal two characters `\r` — `send-keys` sends
> them as a backslash followed by `r`, not as an enter key.
>
> NEVER quote the key name as part of the text payload.
>
> ✅ Correct:
>
> ```sh
> tmux send-keys -t <PANE_ID> Enter
> ```
>
> ❌ Incorrect:
>
> ```sh
> tmux send-keys -t <PANE_ID> "Enter"
> ```
