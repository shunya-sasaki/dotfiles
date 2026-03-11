{ pkgs }:

with pkgs; [
  neovim
  zellij
  direnv
  ollama
  opencode
  lazydocker
  bat
  bottom
  chezmoi
  cowsay
  dust
  eza
  fastfetch
  fd
  file
  fortune
  fzf
  gnupg
  hyperfine
  imagemagick
  jq
  lolcat
  poppler
  powershell
  procs
  ripgrep
  starship
  tldr
  toilet
  ueberzugpp
  xh
  yazi
  zoxide
  # Package managers
  uv
  volta
  rustup
  # LSP/Linter/Formatter
  nixd
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
  fortls
]
