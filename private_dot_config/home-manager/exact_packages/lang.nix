{ pkgs }:

with pkgs; [
  uv
  mise
  rustup
  dotnet-sdk_10
  lldb
  tex-fmt
  vscode-extensions.vadimcn.vscode-lldb
]
