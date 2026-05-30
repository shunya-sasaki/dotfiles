#!/bin/bash
function set_wezterm_user_var(){
    if [[ -n "$WEZTERM_PANE" || -n "$SSH_CONNECTION" ]]; then
        printf "\033]1337;SetUserVar=%s=%s\007" "$1" "$(echo -n "$2" | base64)"
    fi
}
function zellij() {
    set_wezterm_user_var "TMUX_MODE" "1"
    command zellij "$@"
    set_wezterm_user_var "TMUX_MODE" "0"
}
# Tmux
function tmux() {
    set_wezterm_user_var "TMUX_MODE" "1"
    command tmux "$@"
    set_wezterm_user_var "TMUX_MODE" "0"
}

if command -v zellij &> /dev/null; then
    function za() {
        if [[ -n "$ZELLIJ" ]]; then
            zellij action switch-session "$@"
        else
            zellij attach "$@"
        fi
    }

    function zd(){
        zellij d --force "$@"
    }

    function zl(){
        zellij ls
    }

    function zk(){
        zellij k "$@"
    }

    function zs(){
        if [[ -n "$ZELLIJ" ]]; then
            zellij attach --create-background "$@"
        else
            zellij -s "$@"
        fi
    }
fi


if command -v tmux &> /dev/null; then
    alias ta="tmux a -t"
    alias tk="tmux kill-session -t"
    alias tl="tmux ls"
    alias ts="tmux new -d -s"
fi
