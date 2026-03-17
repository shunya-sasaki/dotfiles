{ pkgs }:

with pkgs; [
  uv
  mise
  rustup
  dotnet-sdk_10
  lldb
  vscode-extensions.vadimcn.vscode-lldb
]
