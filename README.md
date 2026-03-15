# Dotfiles

![gnubash](https://img.shields.io/badge/bash-gray?logo=gnubash&labelColor=gray&logoColor=white)
![zsh](https://img.shields.io/badge/zsh-gray?logo=zsh&labelColor=gray&logoColor=white)

My dotfiles.

## 📦 Requirements

- nix

## ⚙️ Setup

### Install Nix

```sh
sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install)
```

### Clone this repository

```sh
nix-shell -p git chezmoi --run "chezmoi init  https://github.com/shunya-sasaki/dotfiles.git"
```

### Install home manager

Create `~/.config/home-manager/home.nix` file containing something like:

```nix
{ config, pkgs, ...}:

{
  nixpkgs.config.allowUnfree = true;
  fonts.fontconfig.enable = true;

  home.username = "YOUR_NAME";
  home.homeDirectory = "YOUR_HOME_DIRECTORY";
  home.stateVersion = "25.11";
  home.packages = import ./packages.nix { inherit pkgs; };
  programs = import ./programs.nix;
}
```

### Settings for AI tools (Optional)

Create `~/.env.agents` and add variables for AI tools.
Expected variables are as follows:

| Variable Name               | Value Type                       | Explain                                                        |
| --------------------------- | -------------------------------- | -------------------------------------------------------------- |
| DISABLE_COPILOT             | {0, 1}                           | `1` to dispable GitHub Copilot predictions in Neovim and Zed.  |
| NVIM_AGENT                  | {gemini, copilot}                | AI tool command that is called from Neovim                     |
| AI_COMMMIT_MESSAGE_PROVIDER | {GEMINI, COPILOT, AZURE_OPEN_AI} | AI service name that is called from `ai-commit-message` cmmand |

Example content of `~/.env.agents`:

```env
DISABLE_COPILOT=0
NVIM_AGENT=gemini
AI_COMMMIT_MESSAGE_PROVIDER=GEMINI
```

### Settings for secrets (Optional)

Create `~/.env.secrets` and add your secret environment variables.
Example content of `~/.env.secrets`:

```env
SOME_API_KEY="*******"
```

## 🚀 Usage

### Chezmoi

```zsh
chezmoi apply
```

### Neovim keybindings

| Keybinding          | Mode           | Category      | Description                            |
| ------------------- | -------------- | ------------- | -------------------------------------- |
| `Space`             | -              | General       | Leader key                             |
| `Y`                 | Normal         | General       | Yank entire line                       |
| `<C-n>`             | Normal         | General       | Next buffer                            |
| `<C-p>`             | Normal         | General       | Previous buffer                        |
| `<Esc><Esc>`        | Normal         | General       | Clear search highlight                 |
| `<Leader>x`         | Normal         | General       | Open float diagnostics                 |
| `<Leader>?`         | Normal         | General       | Show buffer local keymaps (which-key)  |
| `<Leader><Leader>s` | Normal         | General       | Hop hint char1                         |
| `gd`                | Normal         | LSP           | Go to definition                       |
| `gr`                | Normal         | LSP           | Rename symbol                          |
| `gh`                | Normal         | LSP           | Hover information                      |
| `<Leader>cs`        | Normal         | LSP           | Symbols (Trouble)                      |
| `<Leader>cl`        | Normal         | LSP           | LSP Definitions / references (Trouble) |
| `<Leader>ff`        | Normal         | Fuzzy Finder  | Find files                             |
| `<Leader>fg`        | Normal         | Fuzzy Finder  | Live grep                              |
| `<Leader>fb`        | Normal         | Fuzzy Finder  | Buffers                                |
| `<Leader>fh`        | Normal         | Fuzzy Finder  | Help tags                              |
| `<Leader>e`         | Normal, Visual | File Explorer | Open yazi at current file              |
| `<Leader>cw`        | Normal         | File Explorer | Open file manager in cwd               |
| `<C-Up>`            | Normal         | File Explorer | Resume last yazi session               |
| `]c`                | Normal         | Git           | Next hunk                              |
| `[c`                | Normal         | Git           | Previous hunk                          |
| `<Leader>hs`        | Normal, Visual | Git           | Stage hunk                             |
| `<Leader>hr`        | Normal, Visual | Git           | Reset hunk                             |
| `<Leader>hS`        | Normal         | Git           | Stage buffer                           |
| `<Leader>hR`        | Normal         | Git           | Reset buffer                           |
| `<Leader>hp`        | Normal         | Git           | Preview hunk                           |
| `<Leader>hi`        | Normal         | Git           | Preview hunk inline                    |
| `<Leader>hb`        | Normal         | Git           | Blame line                             |
| `<Leader>hd`        | Normal         | Git           | Diff this                              |
| `<Leader>hD`        | Normal         | Git           | Diff this (~)                          |
| `<Leader>hQ`        | Normal         | Git           | Set quickfix list (all)                |
| `<Leader>hq`        | Normal         | Git           | Set quickfix list                      |
| `<Leader>tb`        | Normal         | Git           | Toggle current line blame              |
| `<Leader>tw`        | Normal         | Git           | Toggle word diff                       |
| `<Leader>g`         | Normal         | Terminal      | Toggle lazygit                         |
| `<Leader>i`         | Normal         | Terminal      | Toggle agent terminal                  |
| `<C-t>`             | Normal         | Terminal      | Toggle terminal                        |
| `<C-A-i>`           | Normal         | Terminal      | Open terminal with agent               |
| `<Leader>xx`        | Normal         | Diagnostics   | Toggle diagnostics (Trouble)           |
| `<Leader>xX`        | Normal         | Diagnostics   | Toggle buffer diagnostics (Trouble)    |
| `<Leader>xL`        | Normal         | Diagnostics   | Location list (Trouble)                |
| `<Leader>xQ`        | Normal         | Diagnostics   | Quickfix list (Trouble)                |
| `<F5>`              | Normal         | Debugging     | Continue                               |
| `<F10>`             | Normal         | Debugging     | Step over                              |
| `<F11>`             | Normal         | Debugging     | Step into                              |
| `<F12>`             | Normal         | Debugging     | Step out                               |
| `<Leader>b`         | Normal         | Debugging     | Toggle breakpoint                      |
| `<Leader>B`         | Normal         | Debugging     | Set breakpoint                         |
| `<Leader>lp`        | Normal         | Debugging     | Set log point                          |
| `<Leader>d`         | Normal         | Debugging     | Toggle DAP UI                          |
| `<Leader>dr`        | Normal         | Debugging     | Open REPL                              |
| `<Leader>dl`        | Normal         | Debugging     | Run last                               |
| `<Leader>dh`        | Normal, Visual | Debugging     | Hover widget                           |
| `<Leader>dp`        | Normal, Visual | Debugging     | Preview widget                         |
| `<Leader>df`        | Normal         | Debugging     | Show frames                            |
| `<Leader>ds`        | Normal         | Debugging     | Show scopes                            |
| `<C-n>`             | Insert         | Completion    | Select next item                       |
| `<C-p>`             | Insert         | Completion    | Select previous item                   |
| `<C-b>`             | Insert         | Completion    | Scroll docs up                         |
| `<C-f>`             | Insert         | Completion    | Scroll docs down                       |
| `<C-w>`             | Insert         | Completion    | Abort completion                       |
| `<C-Space>`         | Insert         | Completion    | Trigger completion                     |
| `<CR>`              | Insert         | Completion    | Confirm selection                      |
| `<C-J>`             | Insert         | Completion    | Snippet jump forward                   |
| `<C-K>`             | Insert         | Completion    | Snippet jump backward                  |

## 📚 Reference

- [chezmoi officia web page](https://www.chezmoi.io)

## 📄 License

[MIT License](./LICENSE)
