#!/usr/bin/env pwsh

param(
    [Parameter(Position = 0, Mandatory = $true)]
    [string]$TargetPaneId,
    [Parameter(Position = 1, Mandatory = $true)]
    [string]$Message
)

$env:PYTHONPATH = "$HOME/.bin"

if (Get-Command uv -ErrorAction SilentlyContinue) {
    uv run "$HOME/.bin/agent/multiplexer.py" send $TargetPaneId $Message
}
elseif (Get-Command python3 -ErrorAction SilentlyContinue) {
    python3 "$HOME/.bin/agent/multiplexer.py" send $TargetPaneId $Message
}
else {
    Write-Error "Error: neither uv nor python3 is available."
    exit 1
}
