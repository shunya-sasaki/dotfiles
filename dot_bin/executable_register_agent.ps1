#!/usr/bin/env pwsh

param(
    [Parameter(Position = 0, Mandatory = $true)]
    [string]$Session,
    [Parameter(Position = 1)]
    [string]$Role,
    [Parameter(Position = 2)]
    [string]$Name,
    [Alias("i")]
    [switch]$Init
)

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

$InitOption = @()
if ($Init) {
    $InitOption = @("--init")
}

if (Get-Command uv -ErrorAction SilentlyContinue) {
    uv run "$ScriptDir/register_agent.py" `
        --session $Session `
        --role $Role `
        --name $Name `
        @InitOption
}
elseif (Get-Command python3 -ErrorAction SilentlyContinue) {
    python3 "$ScriptDir/register_agent.py" `
        --session $Session `
        --role $Role `
        --name $Name `
        @InitOption
}
else {
    Write-Error "Error: neither uv nor python3 is available."
    exit 1
}
