# Dotfiles

![Zsh](https://img.shields.io/badge/Zsh-f15a24?logo=zsh&labelColor=gray&logoColor=white)
![GNU Bash](https://img.shields.io/badge/GNU%20Bash-4eaa25?logo=gnubash&labelColor=gray&logoColor=white)
![NixOS](https://img.shields.io/badge/NixOS-5277c3?logo=NixOS&labelColor=gray&logoColor=white)
![Neovim](https://img.shields.io/badge/Neovim-57a143?logo=Neovim&labelColor=gray&logoColor=white)
![Zed](https://img.shields.io/badge/Zed-084ccf?logo=zedindustries&labelColor=gray&logoColor=white)
![Starship](https://img.shields.io/badge/Starship-dd0b78?logo=Starship&labelColor=gray&logoColor=white)
![WezTerm](https://img.shields.io/badge/WezTerm-4e49ee?logo=WezTerm&labelColor=gray&logoColor=white)
![Ghostty](https://img.shields.io/badge/Ghostty-3551f3?logo=Ghostty&labelColor=gray&logoColor=white)

My dotfiles.

## 📦 Requirements

- nix

## ⚙️ Setup

### Install Nix

```sh
sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install)
```

To enable flakes feature, create `~/.config/nix/nix.conf` as follows:

_~/.config/nix/nix.conf_

```conf
extra-experimental-features = nix-command flakes
```

### Clone this repository

Run following command to clone this repository and apply configuration:

```sh
nix-shell -p git chezmoi --extra-experimental-features "nix-command flakes" \
  --run "export NIX_CONFIG='experimental-features = nix-command flakes'; \
  chezmoi init https://github.com/shunya-sasaki/dotfiles.git --apply"
```

### Install home manager

#### macOS (nix-darwin + home-manager)

On macOS, `home-manager` is mounted as a `nix-darwin` module so a single
command rebuilds both system and user state.

First-time bootstrap (no `darwin-rebuild` on `PATH` yet):

```sh
cd ~/.config/home-manager
nix run nix-darwin/master#darwin-rebuild -- switch --flake .#$(hostname -s)
```

Subsequent rebuilds:

```sh
darwin-rebuild switch --flake ~/.config/home-manager#$(hostname -s)
```

After the first switch, remove the legacy standalone home-manager profile
once and open a new shell:

```sh
nix profile remove '.*'
```

#### Linux (standalone home-manager)

```sh
cd ~/.config/home-manager && nix run home-manager/master -- init --switch
```

### Settings for environment variables (Optional)

Both `~/.zshrc` and `~/.bashrc` source every `*.sh` file under `~/.profile.d/`
in alphabetical order, with `before.sh` first and `after.sh` last.
Files that this repository does not manage are left untouched by
`chezmoi apply`, so `~/.profile.d/` is the place for machine local settings
and secrets.

Variables have to be exported explicitly, since the files are sourced with
auto exporting disabled.

#### Settings for AI tools

Create `~/.profile.d/agents.sh` and add variables for AI tools.
Expected variables are as follows:

| Variable Name              | Value Type                      | Explain                                                         |
| -------------------------- | ------------------------------- | --------------------------------------------------------------- |
| DISABLE_COPILOT            | {0, 1}                          | `1` to disable GitHub Copilot completion in Neovim              |
| AI_COMMIT_MESSAGE_PROVIDER | {CLAUDE, COPILOT, AZURE_OPENAI} | AI service name that is called from `ai-commit-message` command |

Example content of `~/.profile.d/agents.sh`:

```sh
export DISABLE_COPILOT=0
export AI_COMMIT_MESSAGE_PROVIDER=CLAUDE
```

#### Settings for secrets

Create `~/.profile.d/secrets.sh` and add your secret environment variables.
Example content of `~/.profile.d/secrets.sh`:

```sh
export SOME_API_KEY="*******"
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
| `<C-t>`             | Normal         | Terminal      | Toggle terminal                        |
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
