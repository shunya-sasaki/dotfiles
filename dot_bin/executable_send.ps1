#!/usr/bin/env pwsh

param(
    [Parameter(Position = 0, Mandatory = $true)]
    [string]$TargetPaneId,
    [Parameter(Position = 1, Mandatory = $true)]
    [string]$Message
)

mux send $TargetPaneId $Message
