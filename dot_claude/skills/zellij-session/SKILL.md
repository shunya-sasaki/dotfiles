---
name: zellij-session
description: When you are asked to work on zellij, you MUST use this skill to run zellij action commands.
---

## Get self pane id

Before running any other zellij tasks, you MUST run this task.
Get your current pane id from the environment variable `ZELLIJ_PANE_ID`.

If you are running on Windows PowerShell, run:

```ps1
echo $env:ZELLIJ_PANE_ID
```

If you are running on Linux or macOS (bash or zsh), run:

```sh
echo $ZELLIJ_PANE_ID
```

### Procedure

1. Get pane id with using the `echo` command.
2. Return the pane id to the user.

> [NOTE]
> Zellij pane ids accept either the bare number (e.g. `3`) or the
> qualified form (e.g. `terminal_3`, `plugin_2`). The two are equivalent.

## Get the status of windows, tabs and panes

When you are asked to get pane ids, you MUST run `zellij action list-panes`.

```sh
zellij action list-panes --json --all
```

You may also list tabs and clients:

```sh
zellij action list-tabs --json --all
zellij action list-clients
```

### Procedure

1. Run `zellij action list-panes --json --all`.
2. Parse the JSON output and analyze the status.
3. Check the position of your pane and your adjacent panes.

> [!CAUTION]
> Do NOT confuse your pane id and other pane ids.

## Get text from a pane

When you are asked to read a pane, you MUST run the following command to get pane contents:

```sh
zellij action dump-screen --pane-id <PANE_ID>
```

If you also need the scrollback buffer, add `--full`:

```sh
zellij action dump-screen --pane-id <PANE_ID> --full
```

### Procedure

1. Get pane content by using `zellij action dump-screen` command.

> [NOTE]
> Without `--path`, the dump is printed to STDOUT. Pass `--path <FILE>`
> only if you need to persist the dump to disk.

## Send text to a pane

When you are asked to send a message to other pane, you MUST use `zellij action write-chars`.

For a single line message in Windows PowerShell, run:

```ps1
zellij action write-chars --pane-id <PANE_ID> "[TEXT]"
```

For a single line message in Linux or macOS (bash or zsh), run:

```sh
zellij action write-chars --pane-id <PANE_ID> $'[TEXT]'
```

If the message contains multi line text, run:

```sh
cat<<'EOF' | xargs -0 -I {} zellij action write-chars --pane-id <PANE_ID> {}
[TEXT]
EOF
```

> [NOTE]
> `[TEXT]` is a message you create.

### Procedure

1. Create a message.
2. Send the message to the specified pane with the command.
3. If you sent the single line message, send the enter key.
   If you run on Windows PowerShell, run literally:

   ```ps1
   zellij action write --pane-id <PANE_ID> 13
   ```

   If you run on Linux or macOS (bash or zsh), run literally:

   ```sh
   zellij action write --pane-id <PANE_ID> 13
   ```

> [!CAUTION]
> Use `zellij action write <BYTES>` (not `write-chars`) to send the
> enter key. `13` is the byte value of carriage return.
>
> ✅ Correct:
>
> ```sh
> zellij action write --pane-id <PANE_ID> 13
> ```
>
> ❌ Incorrect:
>
> ```sh
> zellij action write-chars --pane-id <PANE_ID> '\r'
> ```
>
> NEVER pass the literal two characters `\r` — `write-chars` sends
> them as a backslash followed by `r`, not as an enter key.
>
> NEVER quote the byte value as a string.
>
> ✅ Correct:
>
> ```sh
> zellij action write --pane-id <PANE_ID> 13
> ```
>
> ❌ Incorrect:
>
> ```sh
> zellij action write --pane-id <PANE_ID> "13"
> ```
