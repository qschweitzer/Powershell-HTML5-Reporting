New-WEBPage -Title "Hey ! Welcome to PSReport-ng v3 !" -path ./test/out/file.html -Content {
    New-WEBTab -Name "First Tab" -Content {
        New-WEBRow {
            New-WEBStat -statNumber "95%" -statLabel "External sources free"
            new-WEBcard { New-WEBText -YourText "Thanks to **ChartJS** to power up the charts ! This is the only external resource!" }
            New-WEBCard -Title "Markdown" -Content {
                New-WEBText -YourText "You could use **Markdown** in text to ==highlight== your text or simply format it as you wish !"
                New-WEBAlert -YourText "Built with less 100 lines of code !" 
            }
        }
        New-WEBRow -Content {
            New-WEBCard -Title "Let's create some charts - ==NEW== Stacked bars chart" -Content {
                New-WEBAccordion -AccordionItems {
                    New-WEBAccordionItem -ItemTitle "Test 1" -ItemContent { New-WEBChart -Stacked -ChartTitle "Stacked Bars" -ChartType "bar" -Legends @("January", "February", "March", "April") -Horizontal -LightMode -StackedContent {
                            New-WEBChartStackedDataset -Name "Dataset1" -Values @(1, 2, 3, 4.5)
                            New-WEBChartStackedDataset -Name "Dataset2" -Values @(4, 3, 2, 1)
                            New-WEBChartStackedDataset -Name "Dataset3" -Values @(5, 12, 9, 4)
                            New-WEBChartStackedDataset -Name "Dataset4" -Values @(8, 2, 16, 2)
                        }
                    }
                    New-WEBAccordionItem -ItemTitle "Test 2" -ItemContent { New-WEBText '```
New-WEBCard -Title "Let''s create some charts - ==NEW== Stacked bars chart" -Content {
    New-WEBChart -Stacked -ChartTitle "Stacked Bars" -ChartType "bar" -Legends @("January", "February", "March", "April") -Horizontal -LightMode -StackedContent {
        New-WEBChartStackedDataset -Name "Dataset1" -Values @(1, 2, 3, 4.5)
        New-WEBChartStackedDataset -Name "Dataset2" -Values @(4, 3, 2, 1)
        New-WEBChartStackedDataset -Name "Dataset3" -Values @(5, 12, 9, 4)
        New-WEBChartStackedDataset -Name "Dataset4" -Values @(8, 2, 16, 2)
    }
}
                    ```'
                    }
                }
            }
            New-WEBCard -Title "Disks capacity" -Content {
                $DisksInfos = (Get-PSDrive | Select-Object Name, @{Name = 'Size in GB'; Expression = { [math]::Round(($_.Used / 1GB), 2) + [math]::Round(($_.Free / 1GB), 2) } })
                New-WEBChart -ChartValues $DisksInfos."Size in GB" -ChartLabels $DisksInfos.Name -ChartTitle "Disk Space in GB" -ChartType bar -LightMode -DontShowTitle
            }
        }
        New-WEBRow -Content {
            New-WEBCard -Title "Doughnut Chart" -Content {
                $Process = (Get-Process | Where-Object { $_.processname.length -lt 15 }  | Select-Object -first 5) | Group-Object Name | Select-Object Name, @{Name = "counter"; expression = { $_.count } }
                New-WEBChart -ChartValues $Process.Counter -ChartLabels $Process.Name -ChartTitle "First 5th Process" -ChartType doughnut -LightMode
            }
            New-WEBCard -Title "Pie Chart" -Content {
                $Process = Get-Process | Where-Object { $_.processname.length -lt 15 }  | Group-Object Name | Select-Object -First 5 Name, @{Name = "counter"; expression = { $_.count } }
                New-WEBChart -ChartValues $Process.Counter -ChartLabels $Process.Name -ChartTitle "First 5th Process 2" -ChartType pie -Horizontal -LightMode
            }
        }
        New-WEBRow -Content {
            New-WEBCard -Title "Line Chart" -Content {
                $Chart2Dataset = Get-Process | Where-Object { $_.processname.length -lt 15 }  | Where-Object name -notmatch "-|,|;" | Group-Object -NoElement -Property Count, Name | Sort-Object Count -Descending | Select-Object Count, Name -First 10
                New-WEBChart -ChartTitle "Line Chart 1" -ChartType "line" -ChartLabels $Chart2Dataset.Name -ChartValues ($Chart2Dataset | Select-Object -ExpandProperty count) -LightMode
            }
            New-WEBTable -title "Conditional formated table" -ToTable (Get-Process  | Where-Object { $_.processname.length -lt 15 } | Group-Object -Property Name | Sort-Object Count -Descending | Select-Object -First 5 Name, Count)
        }
        New-WEBCard -Title "Search in table" -Content {
            New-WEBText -YourText "Some options like export table, search, paginate, hide many columns and show details"
            New-WEBTable -ToTable (Get-Process | Where-Object { $_.processname.length -lt 15 } | Group-Object -Property Name | Sort-Object Count -Descending | Select-Object Name, Count -first 20) 
                
        }
    }
    New-WEBTab -Name "Second Tab" -Content {
        New-WEBRow -Content {
            New-WEBList -title "List first 20 process" -List (Get-Process | Where-Object { $_.processname.length -lt 15 } | Select-Object -First 10).Name
        }
    }
}