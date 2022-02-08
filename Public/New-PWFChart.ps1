Function New-PWFChart {
    <#
.SYNOPSIS
Create a new ChartJS chart.
.DESCRIPTION
Create a new Chart. Enter your data and tadaaa.
.PARAMETER ChartTitle
Your chart title.
.PARAMETER ChartType
"bar", "doughnut", "pie", "line", "radar", "polar"
.PARAMETER ChartLabels,
Your labels, from an object/array or in a string format separate by semi-colon: "Label1;Label2;LabelRouge"
.PARAMETER ChartValues
Your data [int], from an object/array or in a string format separate by semi-colon: "1;2;3"
.PARAMETER Stacked
Enable the stacked chart format.
.PARAMETER StackedContent
Use when Stacked selected. Scriptblock that contains the New-PWFChartStackedDataset functions
.PARAMETER Legends
Use when Stacked selected. Your legends, from an object/array or in a string format separate by semi-colon: "Label1;Label2;LabelRouge"
.PARAMETER HideLegend
Hide the legend.
.PARAMETER LegendPosition
Select position of legend: top,bottom,left,right
.PARAMETER Horizontal
The color to color y
.PARAMETER ChartColors
The color to color your data set in the chart. Default is colors generated automatically from a custom defined list with flat colours.
.PARAMETER LightMode
In lightmode all the chart text's color is white.
.PARAMETER DontShowTitle
Hide the chart's title.
.EXAMPLE
New-PWFChart -ChartTitle "Line Chart 1" -ChartType "line" -ChartLabels $ChartDataset.Name -ChartValues ($ChartDataset | select -ExpandProperty count)
New-PWFChart -Stacked -ChartTitle "Stacked Bars" -ChartType "bar" -Legends "Janvier;Fevrier;Mars;Avril" -StackedContent {
    New-PWFChartStackedDataset -Name "Dataset1" -Values "1;2;3;4"
    New-PWFChartStackedDataset -Name "Dataset2" -Values "4;3;2;1"
}
.LINK
https://github.com/qschweitzer/Powershell-HTML5-Reporting
#>
    param(
        [Parameter(Mandatory = $true, ParameterSetName = 'Stacked', Position = 0)]
        [Parameter(Mandatory = $true, ParameterSetName = 'NotStacked', Position = 0)]
        $ChartTitle,
        [ValidateSet("bar", "doughnut", "pie", "line", "radar", "polar", IgnoreCase = $false)]
        $ChartType,

        [Parameter(
            ParameterSetName = 'Stacked',
            HelpMessage = 'If Stacked selected, you have to create a hashtable with datasets.',
            Position = 1)]
        [switch]$Stacked,

        [Parameter(
            ParameterSetName = 'NotStacked',
            HelpMessage = 'Classic chart.',
            Position = 2)]
        $ChartLabels,

        [Parameter(Mandatory = $true, ParameterSetName = 'NotStacked', Position = 3)]
        $ChartValues,

        [Parameter(Mandatory = $true, ParameterSetName = 'Stacked', Position = 2)]
        $Legends,

        [Parameter(Mandatory = $false, ParameterSetName = 'Stacked', Position = 3)]
        [Parameter(Mandatory = $false, ParameterSetName = 'NotStacked', Position = 4)]
        [switch]$HideLegend,
        [ValidateSet("top", "right", "bottom", "left", IgnoreCase = $false)]
        [string]$LegendPosition = "top",
        [switch]$Horizontal,
        $ChartColors,
        [switch]$LightMode,
        [switch]$DontShowTitle,

        [Parameter(Mandatory = $true, ParameterSetName = 'Stacked', Position = 2)]
        $StackedContent
    )
    if (!$Stacked) {
        #Switch ChartLabels from string to array, splitted by semi-colon
        if ($ChartLabels.gettype().Name -eq "String") {
            $ChartLabels = $ChartLabels.split(";")
        }
        #Switch ChartValues from string to array, splitted by semi-colon
        if ($ChartValues.gettype().Name -eq "String") {
            $ChartValues = $ChartValues.split(";")
        }
        #Switch ChartColors from string to array, splitted by semi-colon
        if ($ChartColors -and ($ChartColors.gettype().Name -eq "String")) {
            $ChartColors = $ChartColors.split(";")
        }
    }

    if (!$Stacked) {
        $ChartCount = ($ChartValues | Measure-Object).count
        $ChartDatasets = $ChartLabels
    }
    else {
        if ($Legends.gettype().Name -eq "String") {
            $Legends = $Legends.split(";s")
        }
    }

    if ($null -eq $ChartColors) {
        $ChartColors = $script:ChartColorsPalette
    }

    $ID = "ID$(Get-Random -Maximum 9999)"
    $data = "data$(Get-Random -Maximum 9999)"
    $config = "config$(Get-Random -Maximum 9999)"
    $labels = "labels$(Get-Random -Maximum 9999)"
    $Script:StackedColorsCount = 0
    $output = @"
    <div>
        <canvas id="$($ID)"></canvas>
    </div>

    <script>
"@
    if ($Stacked) {
        $Script:StackedChartName = @()
        $StackedContent = .$StackedContent
        $output += @"
            const $($labels) = ['$($Legends -join "','")'];
            const $($data) = {
            labels: $($labels),
            datasets: [
                $(try{ $StackedContent }catch{ })
            ]
            };
"@
        $Script:StackedChartName = @()
    }
    else {
        $output += @"
            const $($data) = {
            labels: [
            $(
                For ($i = 0; $i -lt ($ChartLabels | Measure-Object).count; $i++) {
                    Write-Output "'$($ChartLabels[$i])'$(if($i -ne (($ChartLabels | Measure-Object).count)-1){","})"
                }
            )
            ],
            datasets: [{
            label: '$($ChartTitle)',
            data: [$(
                For ($j = 0; $j -lt ($ChartValues | Measure-Object).count; $j++) {
                    Write-Output "'$($ChartValues[$j])'$(if($j -ne (($ChartValues | Measure-Object).count)-1){","})"
                })
            ],
            backgroundColor: [
                $(For ($k = 0; $k -lt ($ChartColors | Measure-Object).count; $k++) {
                    Write-Output "'$($ChartColors[$k])'$(if($k -lt (($ChartColors | Measure-Object).count)){","})"
                })
            ],
            hoverOffset: 5,
            tension: 0.5
            }]
        };
"@
    }
    $output += @"
        const $($config) = {
        type: '$(if("" -ne $ChartType){write-output $ChartType}else{write-output "doughnut"})',
        data: $($data),
        options: {
            $(if($Horizontal -and ($ChartType -eq "bar")){
            "indexAxis: 'y',"
            })
            plugins: {
            legend: {
                display: $(if($HideLegend){"false"}else{"true"}),
                $(if($LegendPosition){"position: '$($LegendPosition)',"})
                labels: {
                $(if($LightMode){"color: '#fff',"})
                }
            },
            title: {
                display: $(if($DontShowTitle){"false"}else{"true"}),
                $(if($LightMode){"color: '#fff',"})
                text: '$($ChartTitle)'
            }
            },
            responsive: true,
            maintainAspectRatio: false,
            scales: {
            x: {
                $(if($Stacked){"stacked: true,"})
                ticks: {
                $(if($LightMode){"color: '#fff'"})
                }
            },
            y: {
                $(if($Stacked){"stacked: true,"})
                ticks: {
                $(if($LightMode){"color: '#fff'"})
                }
            }
            }
        }
        };

        var $($ID) = new Chart(
            document.getElementById('$($ID)'),
            $($config)
        );
        $($ID).canvas.parentNode.style.height = '80vh';
    </script>
"@
    return $output
}