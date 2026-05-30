# Nix
if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
  source '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi
export PATH="$HOME/.nix-profile/bin:$PATH"

if [[ -n $ZELLIJ_PANE_ID ]]; then
    zellij action rename-pane "[$ZELLIJ_PANE_ID]"
fi
