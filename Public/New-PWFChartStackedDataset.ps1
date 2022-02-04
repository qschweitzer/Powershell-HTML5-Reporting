Function New-PWFChartStackedDataset{
<#
.SYNOPSIS
Create a new chart Dataset for stacked chart only.
.DESCRIPTION
Create a new chart Dataset for stacked chart only.
.PARAMETER Name
The name of your data set.
.PARAMETER Values
The [int] values of your dataset. You could use an object/array or type values as a string, separated by semi-colon like "1;9;3"
.PARAMETER Color
The color to color your data set in the chart. Default is colors generated automatically from thecolorapi.com.
.EXAMPLE
New-PWFChartStackedDataset -Name "January" -Values 1..31
.LINK
https://github.com/qschweitzer/Powershell-HTML5-Reporting
#>
param(
    [Parameter(Mandatory = $true,Position = 0)]
    $Name,
    $Values,
    [Parameter(Mandatory = $false,Position = 1)]
    $Color
)
if($Values.gettype().name -eq "String"){
    $Values = $Values.split(";")
}
if(!$Color){
    $ColorGenerated = $script:ChartColorsPalette
}

$Script:StackedChartName += $Name
Write-Output @"
    {
        label: '$($Name)',
        data: ['$($Values -join "','")'],
        backgroundColor: '$(if($ColorGenerated){$ColorGenerated[($Script:StackedColorsCount)]}else{$Color})',
    },
"@
$Script:StackedColorsCount++
}