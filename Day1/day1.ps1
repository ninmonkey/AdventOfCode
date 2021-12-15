$App = @{ Root = Get-Item $PSScriptRoot }
$App += @{
    Utils = Join-Path $App.Root 'utils'
}
# goto  'C:\Users\cppmo_000\SkyDrive\Documents\2021\My_Github\AdventOfCode'
# $root = 'C:\Users\cppmo_000\SkyDrive\Documents\2021\My_Github\AdventOfCode\utils'
$root = $App.Utils
if (!($env:PSModulePath -split ';' -match (relit $root)) ) {
    $env:PSModulePath += ';', $root
    $root | Label 'Added to $Env:PSModulePath'
}
