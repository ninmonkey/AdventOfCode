#Requires -Version 7

$moduleNames = @(
    'base.ps1'
)

$moduleNames | ForEach-Object {
    "Import: $_" | wi
    "Import: $_" | debug
    "Import: $_" | verbose
    "Import: $_" | Write-Warning
    $src = Join-Path $PSScriptRoot $_
    . (Get-Item -ea stop $src)
}
