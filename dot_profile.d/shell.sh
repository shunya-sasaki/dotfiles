shell=${SHELL##*/}
# starship
if command -v starship &> /dev/null; then
    eval "$(starship init $shell)"
fi
# zoxide
if command -v zoxide &> /dev/null; then
    eval "$(zoxide init $shell)"
fi
# direnv
if command -v direnv &> /dev/null; then
    eval "$(direnv hook $shell)"
fi
# mise
if command -v mise &> /dev/null; then
    eval "$(mise activate $shell)"
fi
