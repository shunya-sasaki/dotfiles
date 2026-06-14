#!/usr/bin/env pwsh

$env:PYTHONPATH = "$HOME/.bin"

if (Get-Command uv -ErrorAction SilentlyContinue) {
    uv run "$HOME/.bin/agent/gitforge.py" @args
}
elseif (Get-Command python3 -ErrorAction SilentlyContinue) {
    python3 "$HOME/.bin/agent/gitforge.py" @args
}
else {
    Write-Error "Error: neither uv nor python3 is available."
    exit 1
}
