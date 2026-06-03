# System
export EDITOR="nvim"
export VISUAL="nvim"
export XDG_CONFIG_HOME="$HOME/.config"
export PATH="/usr/local/bin${PATH:+:$PATH}"
export PATH="$HOME/.local/bin${PATH:+:$PATH}"
export PATH=$HOME/.bin:/Library/Apple/usr/bin${PATH:+:$PATH}

# Nix
if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
  source '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi
if [ -e "$HOME/.nix-profile/etc/profile.d/nix.sh" ]; then
  source "$HOME/.nix-profile/etc/profile.d/nix.sh"
fi
export PATH="$HOME/.nix-profile/bin:$PATH"

# Zellij
if [[ -n $ZELLIJ_PANE_ID ]]; then
    zellij action rename-pane "[$ZELLIJ_PANE_ID]"
fi
