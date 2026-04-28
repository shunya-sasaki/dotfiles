{ pkgs, ... }:

let
    vimPlug = pkgs.vimUtils.buildVimPlugin;
in
{
  home-manager.enable = true;
  zsh.enable = false;
  vim = {
    enable = true;
    extraConfig = ''
      source ~/.config/vim/vimrc
      set runtimepath+=~/.config/vim
      set runtimepath+=~/.config/vim/after
      '';
    plugins = [
      (vimPlug {
        pname = "vim-commentary";
        version = "1.3";
        src = pkgs.fetchFromGitHub {
          owner = "tpope";
          repo = "vim-commentary";
          rev = "v1.3";
          sha256 = "sha256-pmADOvvMoTlJctAsfZQVuYlj7L8nk67EFvZKy9QV9Qs=";
        };
      })
      (vimPlug {
        pname = "vim-surround";
        version = "2.2";
        src = pkgs.fetchFromGitHub {
          owner = "tpope";
          repo = "vim-surround";
          rev = "v2.2";
          sha256 = "sha256-zhaNsu0U+6RhalE1rDzHH8wntJM815REIzdsWmppC6w=";
        };
      })
      (vimPlug {
        pname = "vim-easymotion";
        version = "3.0.1";
        src = pkgs.fetchFromGitHub {
          owner = "easymotion";
          repo = "vim-easymotion";
          rev = "v3.0.1";
          sha256 = "sha256-yX5O7DUrIiPUpaXDli/S6hucsQckeyi2U26YLUNOth8=";
        };
      })
      # Interface -------------------------------------------------------------
      (vimPlug {
        pname = "vim-floaterm";
        version = "unstable";
        src = pkgs.fetchFromGitHub {
        owner = "voldikss";
        repo = "vim-floaterm";
          rev = "master";
          sha256 = "sha256-A4SpMFB1thUhF4N5I7N+HnycE/OXQQbJVMr4wo0gKUc=";
        };
      })
      (vimPlug {
        pname = "vim-airline";
        version = "0.11";
        src = pkgs.fetchFromGitHub {
          owner = "vim-airline";
          repo = "vim-airline";
          rev = "v0.11";
          sha256 = "sha256-8zSK98AHfXo247Efm0XxkzQxkfjN3XKY3xcRM06ueqo=";
        };
      })
      (vimPlug {
        pname = "vim-airline-themes";
        version = "unstable";
        src = pkgs.fetchFromGitHub {
          owner = "vim-airline";
          repo = "vim-airline-themes";
          rev = "master";
          sha256 = "sha256-xTgitX/kL8m/zjcxjCe4WWvhKfVPS284GoZjWkWc/gY=";
        };
      })
      (vimPlug {
        pname = "vim-devicons";
        version = "unstable";
        src = pkgs.fetchFromGitHub {
          owner = "ryanoasis";
          repo = "vim-devicons";
          rev = "master";
          sha256 = "sha256-9g3UdBcc34MR/BrKYqOki2Ge29k/QaRMsnyY+Pq9UE8=";
        };
      })
      (vimPlug {
        pname = "tokyonight-vim";
        version = "unstable";
        src = pkgs.fetchFromGitHub {
          owner = "ghifarit53";
          repo = "tokyonight-vim";
          rev = "master";
          sha256 = "sha256-ui/6xv8PH6KuQ4hG1FNMf6EUdF2wfWPNgG/GMXYvn/8=";
        };
      })
      (vimPlug {
        pname = "molokai";
        version = "unstable";
        src = pkgs.fetchFromGitHub {
          owner = "tomasr";
          repo = "molokai";
          rev = "master";
          sha256 = "sha256-OgzU7vm046T9gmxmqO3sRKCH0E9QAheYGoT7WbL8Ot4=";
        };
      })
      (vimPlug {
        pname = "vim-monokai";
        version = "unstable";
        src = pkgs.fetchFromGitHub {
          owner = "crusoexia";
          repo = "vim-monokai";
          rev = "master";
          sha256 = "sha256-PJxHKsyinieRigMNtSa/jhCQQ5WQK8wzA9lryV7CuqQ=";
        };
      })
      (vimPlug {
        pname = "gruvbox-material";
        version = "1.2.5";
        src = pkgs.fetchFromGitHub {
          owner = "sainnhe";
          repo = "gruvbox-material";
          rev = "v1.2.5";
          sha256 = "sha256-qxblRazEDaVUPJI7xmqLE7ovTMbFVn57/XCy7WaW+Vs=";
        };
      })
      (vimPlug {
        pname = "sonokai";
        version = "0.3.3";
        src = pkgs.fetchFromGitHub {
          owner = "sainnhe";
          repo = "sonokai";
          rev = "v0.3.3";
          sha256 = "sha256-QZQzflOC6cbFt7cwqnZ+y1kKWRWq05ty0x3aj6xuBTY=";
        };
      })
      (vimPlug {
        pname = "onedark-vim";
        version = "unstable";
        src = pkgs.fetchFromGitHub {
          owner = "joshdick";
          repo = "onedark.vim";
          rev = "main";
          sha256 = "sha256-vb2wGkul/NAjeV4zcpI3e9ozd9YI1LbwK85tq+hTcLA=";
        };
      })
      # Completion -------------------------------------------------------------
      (vimPlug {
        pname = "vim-vsnip";
        version = "unstable";
        src = pkgs.fetchFromGitHub {
        owner = "hrsh7th";
          repo = "vim-vsnip";
          rev = "master";
          sha256 = "sha256-hLKtAYNenLgcVPfs0iLEzOOz1OL0oQ3WPJm1VStx9QM=";
        };
      })
      (vimPlug {
        pname = "vim-vsnip-integ";
        version = "unstable";
        src = pkgs.fetchFromGitHub {
        owner = "hrsh7th";
          repo = "vim-vsnip-integ";
          rev = "master";
          sha256 = "sha256-Ro64wc71m/SkFSPu+91tLFHuWaFfCTWH7zFPHbOg7C4=";
        };
      })
      (vimPlug {
        pname = "vimcomplete";
        version = "unstable";
        src = pkgs.fetchFromGitHub {
        owner = "girishji";
          repo = "vimcomplete";
          rev = "main";
          sha256 = "sha256-3Ux7McofptT4/oK1Nu/iPrJ/Bcl4cVx2j7790APvcUI=";
        };
      })
      (vimPlug {
        pname = "vim-table-mode";
        version = "4.8.1";
        src = pkgs.fetchFromGitHub {
        owner = "dhruvasagar";
          repo = "vim-table-mode";
          rev = "v4.8.1";
          sha256 = "sha256-2p92xLlYYl9HQjFha/qRUwiJCB2MUwbt3ADz0uWyGcw=";
        };
      })
      (vimPlug {
        pname = "copilot-vim";
        version = "unstable";
        src = pkgs.fetchFromGitHub {
        owner = "github";
          repo = "copilot.vim";
          rev = "release";
          sha256 = "sha256-McrihGscbvt2lqHil3NxHUfgx/IAFDf7tdbBkv4vTK4=";
        };
      })
      # Commands --------------------------------------------------------------
      (vimPlug {
        pname = "fzf";
        version = "unstable";
        src = pkgs.fetchFromGitHub {
          owner = "junegunn";
          repo = "fzf";
          rev = "master";
          sha256 = "sha256-fEHNE51VTggSwNutefCg/WueaXRE1J0D/dyVPFqhTJg=";
        };
      })
      (vimPlug {
        pname = "fzf-vim";
        version = "unstable";
        src = pkgs.fetchFromGitHub {
          owner = "junegunn";
          repo = "fzf.vim";
          rev = "master";
          sha256 = "sha256-VPxTYXdJaVbr2U7d6VuO4CpIyTC62uo3TAuf1MYiAXI=";
        };
      })
      # Language --------------------------------------------------------------
      (vimPlug {
        pname = "lsp";
        version = "unstable";
        src = pkgs.fetchFromGitHub {
          owner = "yegappan";
          repo = "lsp";
          rev = "main";
          sha256 = "sha256-CV0bvBVUmZnp0W5L0xpjeA5r54cCieSHKHgoYE9P8Ss=";
        };
        postPatch = ''
          substituteInPlace autoload/lsp/lspserver.vim \
            --replace-fail \
              'var msgs = newMsg->split("\n")' \
              'var msgs = newMsg->split("\n")
              if msgs->empty()
                return
              endif'
          '';
      })
      (vimPlug {
        pname = "vim-polyglot";
        version = "4.17.1";
        src = pkgs.fetchFromGitHub {
          owner = "sheerun";
        repo = "vim-polyglot";
          rev = "v4.17.1";
          sha256 = "sha256-UkCKWLHh2KCK//DI62ZCyJjwMAnXRwzfzKZjFPBWQro=";
        };
      })
      # Markdown
      (vimPlug {
        pname = "vim-markdown-toc";
        version = "unstable";
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
