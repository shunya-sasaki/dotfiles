# Dotfiles

![gnubash](https://img.shields.io/badge/bash-gray?logo=gnubash&labelColor=gray&logoColor=white)
![zsh](https://img.shields.io/badge/zsh-gray?logo=zsh&labelColor=gray&logoColor=white)

My dotfiles.

## 📦 Requirements

- chezmoi

## ⚙️ Setup

### Install chezmoi

**Option 1. Homebrew**:

```zsh
brew install chezmoi
```

### Setup chezmoi

```sh
chezmoi init https://github.com/shunya-sasaki/dotfiles.git
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

### Initialize chezmoi

After installing nix, initialize your dotfiles with chezmoi by running the following command:

```sh
nix-shell -p chezmoi --run "chezmoi init https://github.com/shunya-sasaki/dotfiles.git"
```

### Update dotfiles

```zsh
chezmoi apply
```

## 📚 Reference

- [chezmoi officia web page](https://www.chezmoi.io)

## 📄 License

[MIT License](./LICENSE)
