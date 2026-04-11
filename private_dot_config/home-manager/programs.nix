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
      (vimPlug {
        name = "molokai";
        src = pkgs.fetchFromGitHub {
          owner = "tomasr";
          repo = "molokai";
          rev = "master";
          sha256 = "sha256-OgzU7vm046T9gmxmqO3sRKCH0E9QAheYGoT7WbL8Ot4=";
        };
      })
      (vimPlug {
        name = "vim-monokai";
        src = pkgs.fetchFromGitHub {
          owner = "crusoexia";
          repo = "vim-monokai";
          rev = "master";
          sha256 = "sha256-PJxHKsyinieRigMNtSa/jhCQQ5WQK8wzA9lryV7CuqQ=";
        };
      })
      (vimPlug {
        name = "gruvbox-material";
        src = pkgs.fetchFromGitHub {
          owner = "sainnhe";
          repo = "gruvbox-material";
          rev = "v1.2.5";
          sha256 = "sha256-qxblRazEDaVUPJI7xmqLE7ovTMbFVn57/XCy7WaW+Vs=";
        };
      })
      (vimPlug {
        name = "sonokai";
        src = pkgs.fetchFromGitHub {
          owner = "sainnhe";
          repo = "sonokai";
          rev = "v0.3.3";
          sha256 = "sha256-QZQzflOC6cbFt7cwqnZ+y1kKWRWq05ty0x3aj6xuBTY=";
        };
      })
      (vimPlug {
        name = "onedark.vim";
        src = pkgs.fetchFromGitHub {
          owner = "joshdick";
          repo = "onedark.vim";
          rev = "main";
          sha256 = "sha256-vb2wGkul/NAjeV4zcpI3e9ozd9YI1LbwK85tq+hTcLA=";
        };
      })
      # Completion -------------------------------------------------------------
      (vimPlug {
        name = "vim-vsnip";
        src = pkgs.fetchFromGitHub {
        owner = "hrsh7th";
          repo = "vim-vsnip";
          rev = "master";
          sha256 = "sha256-hLKtAYNenLgcVPfs0iLEzOOz1OL0oQ3WPJm1VStx9QM=";
        };
      })
      (vimPlug {
        name = "vim-vsnip-integ";
        src = pkgs.fetchFromGitHub {
        owner = "hrsh7th";
          repo = "vim-vsnip-integ";
          rev = "master";
          sha256 = "sha256-Ro64wc71m/SkFSPu+91tLFHuWaFfCTWH7zFPHbOg7C4=";
        };
      })
      (vimPlug {
        name = "vimcomplete";
        src = pkgs.fetchFromGitHub {
        owner = "girishji";
          repo = "vimcomplete";
          rev = "main";
          sha256 = "sha256-3Ux7McofptT4/oK1Nu/iPrJ/Bcl4cVx2j7790APvcUI=";
        };
      })
      (vimPlug {
        name = "vim-table-mode";
        src = pkgs.fetchFromGitHub {
        owner = "dhruvasagar";
          repo = "vim-table-mode";
          rev = "v4.8.1";
          sha256 = "sha256-2p92xLlYYl9HQjFha/qRUwiJCB2MUwbt3ADz0uWyGcw=";
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
      # Markdown
      (vimPlug {
        name = "vim-markdown-toc";
        src = pkgs.fetchFromGitHub {
          owner = "mzlogin";
        repo = "vim-markdown-toc";
          rev = "master";
          sha256 = "sha256-OqbBNR2AER4KMYOfF3w8OmBC07U3RVMUFaPUE7HBO3U=";
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
