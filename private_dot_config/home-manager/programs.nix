{ pkgs, ... }:

let
    vimPlug = pkgs.vimUtils.buildVimPlugin;
in
{
  home-manager.enable = true;
  zsh.enable = false;
  vim = {
    enable = true;
    plugins = [
      (vimPlug {
        name = "vim-commentary";
        src = pkgs.fetchFromGitHub {
          owner = "tpope";
          repo = "vim-commentary";
          rev = "v1.3";
          sha256 = "sha256-pmADOvvMoTlJctAsfZQVuYlj7L8nk67EFvZKy9QV9Qs=";
        };
      })
      (vimPlug {
        name = "lsp";
        src = pkgs.fetchFromGitHub {
          owner = "yegappan";
          repo = "lsp";
          rev = "main";
          sha256 = "sha256-LBB77pQKKVTKCwfbIcuxDAwFsyRdcnzbtcwLxERWvzU=";
        };
      })
    ];
  };
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
