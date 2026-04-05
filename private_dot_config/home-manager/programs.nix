{ pkgs, ... }:

let
    vimPlug = pkgs.vimUtils.buildVimPlugin;
in
{
  home-manager.enable = true;
  zsh.enable = false;
  vim = {
    enable = true;
    extraConfig = "source ~/.config/vim/vimrc";
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
        name = "vim-surround";
        src = pkgs.fetchFromGitHub {
          owner = "tpope";
          repo = "vim-surround";
          rev = "v2.2";
          sha256 = "sha256-zhaNsu0U+6RhalE1rDzHH8wntJM815REIzdsWmppC6w=";
        };
      })
      (vimPlug {
        name = "vim-easymotion";
        src = pkgs.fetchFromGitHub {
          owner = "easymotion";
          repo = "vim-easymotion";
          rev = "v3.0.1";
          sha256 = "sha256-yX5O7DUrIiPUpaXDli/S6hucsQckeyi2U26YLUNOth8=";
        };
      })
      # Interface -------------------------------------------------------------
      (vimPlug {
        name = "vim-floaterm";
        src = pkgs.fetchFromGitHub {
        owner = "voldikss";
        repo = "vim-floaterm";
          rev = "master";
          sha256 = "sha256-A4SpMFB1thUhF4N5I7N+HnycE/OXQQbJVMr4wo0gKUc=";
        };
      })
      (vimPlug {
        name = "vim-airline";
        src = pkgs.fetchFromGitHub {
          owner = "vim-airline";
          repo = "vim-airline";
          rev = "v0.11";
          sha256 = "sha256-8zSK98AHfXo247Efm0XxkzQxkfjN3XKY3xcRM06ueqo=";
        };
      })
      (vimPlug {
        name = "vim-airline-themes";
        src = pkgs.fetchFromGitHub {
          owner = "vim-airline";
          repo = "vim-airline-themes";
          rev = "master";
          sha256 = "sha256-xTgitX/kL8m/zjcxjCe4WWvhKfVPS284GoZjWkWc/gY=";
        };
      })
      (vimPlug {
        name = "vim-devicons";
        src = pkgs.fetchFromGitHub {
          owner = "ryanoasis";
          repo = "vim-devicons";
          rev = "master";
          sha256 = "sha256-9g3UdBcc34MR/BrKYqOki2Ge29k/QaRMsnyY+Pq9UE8=";
        };
      })
      (vimPlug {
        name = "tokyonight-vim";
        src = pkgs.fetchFromGitHub {
          owner = "ghifarit53";
          repo = "tokyonight-vim";
          rev = "master";
          sha256 = "sha256-ui/6xv8PH6KuQ4hG1FNMf6EUdF2wfWPNgG/GMXYvn/8=";
        };
      })
      # Commands --------------------------------------------------------------
      (vimPlug {
        name = "fzf";
        src = pkgs.fetchFromGitHub {
          owner = "junegunn";
          repo = "fzf";
          rev = "master";
          sha256 = "sha256-fEHNE51VTggSwNutefCg/WueaXRE1J0D/dyVPFqhTJg=";
        };
      })
      (vimPlug {
        name = "fzf.vim";
        src = pkgs.fetchFromGitHub {
          owner = "junegunn";
          repo = "fzf.vim";
          rev = "master";
          sha256 = "sha256-n0jPX5keDf9qUuqyMKosLoI42DRerky9N5moFuuPccY=";
        };
      })
      # Language --------------------------------------------------------------
      (vimPlug {
        name = "lsp";
        src = pkgs.fetchFromGitHub {
          owner = "yegappan";
          repo = "lsp";
          rev = "main";
          sha256 = "sha256-LBB77pQKKVTKCwfbIcuxDAwFsyRdcnzbtcwLxERWvzU=";
        };
      })
      (vimPlug {
        name = "vim-polyglot";
        src = pkgs.fetchFromGitHub {
          owner = "sheerun";
        repo = "vim-polyglot";
          rev = "v4.17.1";
          sha256 = "sha256-UkCKWLHh2KCK//DI62ZCyJjwMAnXRwzfzKZjFPBWQro=";
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
