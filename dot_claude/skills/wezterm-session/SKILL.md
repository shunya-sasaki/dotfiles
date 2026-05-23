---
name: wezterm-session
description: When you are asked to work on wezterm, you MUST use this skill to run wezterm cli commands.
---

## Get self pane id

Before running any other wezterm tasks, you MUST run this task.
Get your current pane id from the environment variable `WEZTERM_PANE`.

If you are running on Windows PowerShell, run:

```ps1
echo $env:WEZTERM_PANE
```

If you are running on Linux or macOS (bash or zsh), run:

```sh
echo $WEZTERM_PANE
```

### Procedure

1. Get pane id with using the `echo` command.
2. Return the pane id to the user.

## Get the status of windows, tabs and panes

When you are asked to get pane ids, you MUST run `wezterm cli list`.

```sh
wezterm cli list --format json
```

### Procedure

1. Run `wezterm cli list --format json`.
2. Parse the JSON output and anlysis the status.
3. Check the position of your pane and your adjacent panes.

> [!CAUTION]
> Do NOT confuse your pane id and other pane ids.

## Get text from a pane

When you are asked to read a pane, you MUST run the following command to get pane contents:

```sh
wezterm cli get-text --pane-id <PANE_ID>
```

### Procedure

1. Get pane content by using `wezterm cli get-text` command.

## Send text to a pane

When you are asked to send a message to other pane, you MUST use `wezterm cli send-text`.

For a single line message in Windows PowerShell, run:

```ps1
wezterm cli send-text --pane-id <PANE_ID> "[TEXT]"
```

For a single line message in Linux or macOS (bash or zsh), run:

```sh
wezterm cli send-text --pane-id <PANE_ID> $'[TEXT]'
```

If the message contains multi line text, run:

```sh
cat<<'EOF' | wezterm cli send-text --pane-id <PANE_ID>
[TEXT]
EOF
```

> [NOTE]
> `[TEXT]` is a message you create.

### Procedure

1. Create a message.
2. Send the message to the specified pane with the command.
3. If you sent the sigle line message, send the enter key.
   If you run on Windows PowerShell, run literally:

   ```ps1
   wezterm cli send-text --pane-id <PANE_ID> --no-paste `r
   ```

   If you run on Linux or macOS (bash or zsh), run literally:

   ```sh
   wezterm cli send-text --pane-id <PANE_ID> --no-paste \n
   ```

> [!CAUTION]
> NEVER include any extra `"`.
>
> ✅ Correct:
>
> ```ps1
> wezterm cli send-text --pane-id <PANE_ID> --no-paste `r
> ```
>
> ❌ Incorrect:
>
> ```ps1
> wezterm cli send-text --pane-id <PANE_ID> --no-paste "`r"
> ```
>
> NEVER confuse the character to send a the enter key.
>
> ✅ Correct:
>
> ```ps1
> wezterm cli send-text --pane-id <PANE_ID> --no-paste `r
> ```
>
> ❌ Incorrect:
>
> ```ps1
> wezterm cli send-text --pane-id <PANE_ID> --no-paste \r
> ```
