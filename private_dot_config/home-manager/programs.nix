{ pkgs, ... }:

{
  home-manager.enable = true;
  zsh.enable = false;
  direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
  yazi = {
    enable = true;
    plugins = {
      mime-ext = pkgs.yaziPlugins.mime-ext;
    };
  };
}
