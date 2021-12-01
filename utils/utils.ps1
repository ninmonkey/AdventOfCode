#Requires -Version 7

$AppConfig = @{
    Root = Get-Item -ea stop $PSScriptRoot
}
goto $AppConfig.Root


$AppConfig = Join-Hashtable $AppConfig @{
    'other' = $false
}
New-Alias 'wi' -Value Write-Information -ea ignore
$PSDefaultParameterValues['New-DayPath:wi'] = 'Continue'
$PSDefaultParameterValues['ensureRelativePathExists:wi'] = 'Continue'
$PSDefaultParameterValues['*:wi'] = 'Continue'



$AppConfig | Format-Dict

function Assert-PathExists {
    <#
    .synopsis
        create if not existing, else do nothing
    #>
    [Alias('ensurePathExists')]
    [cmdletbinding(DefaultParameterSetName = 'relativePath')]
    param(
        [parameter(Mandatory, ParameterSetName = 'relativePath')]
        [validatenotNull()]
        [string]$RelativePath,

        [Alias('FullName')]
        [validatenotNull()]
        [parameter(Mandatory, ParameterSetName = 'fullPath')]
        [string]$AbsolutePath
    )

    if ($PSCmdlet.ParameterSetName -eq 'relativePath') {
        $FullPath = Join-Path $AppConfig.Root $RelativePath
    } else {
        $FullPath = $AbsolutePath
    }
    if (! (Test-Path $FullPath -ea ignore)) {
        mkdir -Path $FullPath -Confirm
        Write-Information "Created: '$FullPath'"
    }
}



# function New-DayPath {
function Test-DayPathExists {
    param(
        [object]$DayPath
    )
    if ( ! ( $DayPath -is 'day.FilePath')) {
        Write-Error -ea stop "[$($_.GetType().Name)] is not '[Day.FilePath]" -Category 'InvalidType'
        return
    }

}
function New-DayPath {
    param(
        [parameter(Mandatory)]
        [validaterange(1, 31)]
        [int]$Day,

        [parameter(Mandatory, ValueFromPipeline)]
        [string]$RelativePath
    )

    $DateLabel = 'Day{0}' -f @($Day)
    $FullRelativePath = Join-Path $AppConfig.Root (Join-Path $DateLabel $RelativePath)
    $maybeItem = Get-Item -ea ignore $FullRelativePath

    $meta = [pscustomobject]@{
        PSTypeName       = 'day.Filepath'
        Day              = $Day
        RelativeDayPath  = $RelativePath
        RelativeRootPath = $fullRelativePath
        AbsolutePath     = $MaybeItem ?? $FullRelativePath
    }

    $meta
    $meta | format-dict | wi
}

$noteMd = New-DayPath 1 'test.md'
hr
$noteMD | format-dict

function ensureDirExists {
    <#
    .synopsis
        Setup day subdirectories
    .link
        Utility\New-PathEntry
    #>
    [cmdletbinding()]
    param(
        [parameter(Mandatory)]
        [validaterange(1, 31)]
        [int]$Day
    )

    h1 'Day' | wi
    $DateLabel = 'Day{0}' -f @($Day)


    $DayRoot = Join-Path $AppConfig.Root $DateLabel
    $DayRoot | wi

    ensureDirExists -RelativePath $DateLabel

}

function Test-CachedIsStale {
    <#
    .synopsis
        Stuff
    .description
       .
    .example
          .
    .outputs
          [string | None]

    #>
    [CmdletBinding(PositionalBinding = $false)]
    param(
        [Parameter(Mandatory, Position = 0)]
        [string]$Label
    )

    begin {
    }
    process {

    }
    end {
    }
}

function Invoke-CachedWebRequest {
    <#
    .synopsis
        Stuff
    .description
        .

    #>
    [CmdletBinding(PositionalBinding = $false)]

    param(
        [parameter(Mandatory)]
        [string]$Label,

        [parameter(Mandatory)]
        [string]$Url
    )

    process {
        # https://adventofcode.com/2021/day/1/input
        # if (! (Test-Path $FullPath -ea ignore)) {
    }
}


# New-DayPath 1

# $Config = @{ https: / / adventofcode.com / 2021 / day / 1 / input


$PSDefaultParameterValues.Remove('*:wi')
