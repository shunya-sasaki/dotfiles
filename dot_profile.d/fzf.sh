export FZF_DEFAULT_OPTS="--ansi"
export FZF_DEFAULT_COMMAND="fd --type f --color=always --hidden --exclude .git --exclude node_modules"
export FZF_CTRL_T_COMMAND="fd --type f --color=always"
export FZF_CTRL_T_OPTS="--preview 'bat {} --color=always --style=numbers --line-range=:500'"
export FZF_ALT_C_COMMAND="fd --type d"
export FZF_ALT_C_OPTS="--preview 'eza {} --color=always --icons=always s ext -h -T -F --no-user --no-time --no-filesize --no-permissions --long | head -200'"
export FZF_COMPLETION_OPTS='--border --info=inline'
if command -v fzf &> /dev/null; then
    source <(fzf --${SHELL##*/})
fi
