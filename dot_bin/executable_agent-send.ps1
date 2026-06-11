#!/usr/bin/env pwsh

param(
    [Parameter(Mandatory = $true, Position = 0)]
    [string]$PaneId,
    [Parameter(Mandatory = $true, Position = 1)]
    [string]$Message
)

$SleepSecond = 0.1

$multiplexer = detect_multiplexer.ps1

if ($multiplexer -eq "Zellij") {
    zellij action write-chars --pane-id $PaneId $Message
    Start-Sleep -Seconds $SleepSecond
    zellij action write --pane-id $PaneId 13
} elseif ($multiplexer -eq "Tmux") {
    tmux send-keys -t $PaneId $Message
    Start-Sleep -Seconds $SleepSecond
    tmux send-keys -t $PaneId Enter
} elseif ($multiplexer -eq "WezTerm") {
    wezterm cli send-text --pane-id $PaneId $Message
    Start-Sleep -Seconds $SleepSecond
    wezterm cli send-text --pane-id $PaneId --no-paste "`r"
} else {
    Write-Error "Error: Unsupported multiplexer."
    exit 1
}
