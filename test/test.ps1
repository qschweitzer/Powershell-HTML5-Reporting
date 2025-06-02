New-PWFPage -Title "Hey ! Welcome in POSHTML5 v3 !" -path ./test/out/file.html -Content {
    New-PWFTab -Name "First Tab" -Content {
        New-PWFRow {
            New-PWFStat -statNumber "95%" -statLabel "External sources free"
            new-pwfcard { New-PWFText -YourText "Thanks to **ChartJS** to power up the charts ! This is the only external resource!" }
            New-PWFCard -Title "Markdown" -Content {
                New-PWFText -YourText "You could use **Markdown** in text to ==highlight== your text or simply format it as you wish !"
                New-PWFAlert -YourText "Built with less 100 lines of code !" 
            }
        }
        New-PWFRow -Content {
            New-PWFCard -Title "Let's create some charts - ==NEW== Stacked bars chart" -Content {
                New-PWFAccordion -AccordionItems {
                    New-PWFAccordionItem -ItemTitle "Test 1" -ItemContent { New-PWFChart -Stacked -ChartTitle "Stacked Bars" -ChartType "bar" -Legends @("January", "February", "March", "April") -Horizontal -LightMode -StackedContent {
                            New-PWFChartStackedDataset -Name "Dataset1" -Values @(1, 2, 3, 4.5)
                            New-PWFChartStackedDataset -Name "Dataset2" -Values @(4, 3, 2, 1)
                            New-PWFChartStackedDataset -Name "Dataset3" -Values @(5, 12, 9, 4)
                            New-PWFChartStackedDataset -Name "Dataset4" -Values @(8, 2, 16, 2)
                        }
                    }
                    New-PWFAccordionItem -ItemTitle "Test 2" -ItemContent { New-PWFText '```
New-PWFCard -Title "Let''s create some charts - ==NEW== Stacked bars chart" -Content {
    New-PWFChart -Stacked -ChartTitle "Stacked Bars" -ChartType "bar" -Legends @("January", "February", "March", "April") -Horizontal -LightMode -StackedContent {
        New-PWFChartStackedDataset -Name "Dataset1" -Values @(1, 2, 3, 4.5)
        New-PWFChartStackedDataset -Name "Dataset2" -Values @(4, 3, 2, 1)
        New-PWFChartStackedDataset -Name "Dataset3" -Values @(5, 12, 9, 4)
        New-PWFChartStackedDataset -Name "Dataset4" -Values @(8, 2, 16, 2)
    }
}
                    ```'
                    }
                }
            }
            New-PWFCard -Title "Disks capacity" -Content {
                $DisksInfos = (Get-PSDrive | Select-Object Name, @{Name = 'Size in GB'; Expression = { [math]::Round(($_.Used / 1GB), 2) + [math]::Round(($_.Free / 1GB), 2) } })
                New-PWFChart -ChartValues $DisksInfos."Size in GB" -ChartLabels $DisksInfos.Name -ChartTitle "Disk Space in GB" -ChartType bar -LightMode -DontShowTitle
            }
        }
        New-PWFRow -Content {
            New-PWFCard -Title "Doughnut Chart" -Content {
                $Process = (Get-Process | Where-Object { $_.processname.length -lt 15 }  | Select-Object -first 5) | Group-Object Name | Select-Object Name, @{Name = "counter"; expression = { $_.count } }
                New-PWFChart -ChartValues $Process.Counter -ChartLabels $Process.Name -ChartTitle "First 5th Process" -ChartType doughnut -LightMode
            }
            New-PWFCard -Title "Pie Chart" -Content {
                $Process = Get-Process | Where-Object { $_.processname.length -lt 15 }  | Group-Object Name | Select-Object -First 5 Name, @{Name = "counter"; expression = { $_.count } }
                New-PWFChart -ChartValues $Process.Counter -ChartLabels $Process.Name -ChartTitle "First 5th Process 2" -ChartType pie -Horizontal -LightMode
            }
        }
        New-PWFRow -Content {
            New-PWFCard -Title "Line Chart" -Content {
                $Chart2Dataset = Get-Process | Where-Object { $_.processname.length -lt 15 }  | Where-Object name -notmatch "-|,|;" | Group-Object -NoElement -Property Count, Name | Sort-Object Count -Descending | Select-Object Count, Name -First 10
                New-PWFChart -ChartTitle "Line Chart 1" -ChartType "line" -ChartLabels $Chart2Dataset.Name -ChartValues ($Chart2Dataset | Select-Object -ExpandProperty count) -LightMode
            }
            New-PWFTable -title "Conditional formated table" -ToTable (Get-Process  | Where-Object { $_.processname.length -lt 15 } | Group-Object -Property Name | Sort-Object Count -Descending | Select-Object -First 5 Name, Count)
        }
        New-PWFCard -Title "Search in table" -Content {
            New-PWFText -YourText "Some options like export table, search, paginate, hide many columns and show details"
            New-PWFTable -ToTable (Get-Process | Where-Object { $_.processname.length -lt 15 } | Group-Object -Property Name | Sort-Object Count -Descending | Select-Object Name, Count -first 20) 
                
        }
    }
    New-PWFTab -Name "Second Tab" -Content {
        New-PWFRow -Content {
            New-PWFList -title "List first 20 process" -List (Get-Process | Where-Object { $_.processname.length -lt 15 } | Select-Object -First 10).Name
        }
    }
}