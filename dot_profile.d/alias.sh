if [ $SHELL = "/bin/zsh" ]; then
    bindkey -e
fi

if command -v bat &> /dev/null; then
    alias cat='bat --color=always --style=numbers --line-range=:500'
fi
if command -v eza &> /dev/null; then
    alias ls='eza --color=always --icons=always --group-directories-first --time-style long-iso -L 1 -g -s ext -h -T -F --long'
fi
if command -v zeditor &> /dev/null; then
    alias zed="zeditor"
fi

alias activate="source activate.sh"
