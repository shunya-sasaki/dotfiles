#!/usr/bin/env pwsh

if ($env:ZELLIJ_PANE_ID) {
    Write-Output "Zellij"
} elseif ($env:TMUX_PANE) {
    Write-Output "Tmux"
} elseif ($env:WEZTERM_PANE) {
    Write-Output "WezTerm"
} else {
    Write-Output "None"
}
