---
name: tmux-session
description: A skill to work with tmux sessions, allowing you to create, manage, and switch between tmux sessions.
---

## Read pane

When I ask you to read a tmux pane, you can use the following command:

```bash
tmux capture-pane -p -t <target pane> -S -1000
```

- `<target pane>` should be replaced with the identifier of the tmux pane you want to read from.
- The `-S -1000` option captures the last 1000 lines of the pane's history. You can adjust this number as needed.

If I scpecify the window and pane, you can use:

```bash
tmux capture-pane -p -t <target window>.<target pane> -S -1000
```

- `<target window>` should be replaced with the identifier of the tmux window,
  and `<target pane>` should be replaced with the identifier of the tmux pane within that window.

If I specify the session, window, and pane, you can use:

```bash
tmux capture-pane -p -t <target session>:<target window>.<target pane> -S -1000
```

- `<target session>` should be replaced with the identifier of the tmux session,
  `<target window>` should be replaced with the identifier of the tmux window,
  and `<target pane>` should be replaced with the identifier of the tmux pane within that window.
