{ pkgs }:

with pkgs; [
  uv
  volta
  rustup
  dotnet-sdk_10
  lldb
  vscode-extensions.vadimcn.vscode-lldb
]
