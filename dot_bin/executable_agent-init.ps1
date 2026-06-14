#!/usr/bin/env pwsh

param(
    [Parameter(Position = 0, Mandatory = $true)]
    [string]$Session,
    [Parameter(Position = 1)]
    [string]$Role,
    [Parameter(Position = 2)]
    [string]$Name
)

$env:PYTHONPATH = "$HOME/.bin"

$ScriptArgs = @("init", "--session", $Session)
if ($Role) { $ScriptArgs += @("--role", $Role) }
if ($Name) { $ScriptArgs += @("--name", $Name) }

if (Get-Command uv -ErrorAction SilentlyContinue) {
    uv run "$HOME/.bin/agent/main.py" @ScriptArgs
}
elseif (Get-Command python3 -ErrorAction SilentlyContinue) {
    python3 "$HOME/.bin/agent/main.py" @ScriptArgs
}
else {
    Write-Error "Error: neither uv nor python3 is available."
    exit 1
}
