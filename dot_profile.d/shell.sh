# starship
if command -v starship &> /dev/null; then
    eval "$(starship init zsh)"
fi
# zoxide
if command -v zoxide &> /dev/null; then
    eval "$(zoxide init zsh)"
fi
# direnv
if command -v direnv &> /dev/null; then
    eval "$(direnv hook zsh)"
fi
# mise
if command -v mise &> /dev/null; then
    eval "$(mise activate zsh)"
fi
