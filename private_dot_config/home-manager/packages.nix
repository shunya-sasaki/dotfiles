{ pkgs }:

with pkgs; [
  # editors
  neovim
  zed-editor
  vscode
  obsidian
  antigravity
  # vcs
  git
  delta
  lazygit
  # communication tools
  slack
  # Development tools 
  zellij
  direnv
  uv
  volta
  rustup
  # dotnet-sdk_10
  # Debugger
  lldb
  vscode-extensions.vadimcn.vscode-lldb
  # LSP/Linter/Formatter
  dprint
  clang-tools
  cmake-language-server
  bash-language-server
  markdown-oxide
  vtsls
  biome
  vscode-langservers-extracted
  tailwindcss-language-server
  taplo
  stylua
  haskell-language-server
  nil
  # terminal tools
  fastfetch
  yazi
  file
  imagemagick
  ueberzugpp
  chezmoi
  jq
  poppler
  zoxide
  bat
  eza
  fd
  ripgrep
  fzf
  tldr
  dust
  bottom
  procs
  xh
  hyperfine
  powershell
  starship
  cowsay
  fortune
  lolcat
  toilet
  # AI tools
  claude-code
  gemini-cli-bin
  github-copilot-cli
  chatgpt
  codex
  ollama
  opencode
  # GUI apps
  wezterm
  ghostty-bin
  notion-app
  # Containers
  docker
  docker-compose
  docker-buildx
  colima
  lazydocker
  # fonts
  moralerspace-hw
]
