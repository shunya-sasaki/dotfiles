#!/usr/bin/env pwsh

param(
    [Parameter(Position = 0, Mandatory = $true)]
    [string]$Session
)

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

if (Get-Command uv -ErrorAction SilentlyContinue) {
    uv run "$ScriptDir/resolve_agent.py" --session $Session
}
elseif (Get-Command python3 -ErrorAction SilentlyContinue) {
    python3 "$ScriptDir/resolve_agent.py" --session $Session
}
else {
    Write-Error "Error: neither uv nor python3 is available."
    exit 1
}
