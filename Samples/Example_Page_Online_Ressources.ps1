######################
#####  EXAMPLES  #####
######################
$TestPage = New-WEBPage -Title "MY FIRST TEST" -OnlineCSS -OnlineJS -Content {
  New-WEBTabContainer -Tabs {
    New-WEBTab -Name "First Tab" -Content {
      New-WEBCardHeader -BackgroundColor "#fff" -Center -Content {
        New-WEBTitle -TitleText "Hi, I'm generated on a Windows PC with a Powershell script." -Size 1 -Center
      }
      New-WEBRow -Content {
        New-WEBColumn -Content {
          New-WEBCard -Content {
            New-WEBTitle -Size 2 -TitleText "This HTML skin is based on $(New-WEBTextFormat -Bold "PicoCSS framework") and $(New-WEBTextFormat -Bold "Bootstrap!") For the $(New-WEBTextFormat -ColorHexa "#BF0413" -Highlight "charts"), it's $(New-WEBTextFormat -Bold "ChartJS!") And for dynamic tables PSReport use $(New-WEBTextFormat -Bold "Bootstrap-tables.")."
            New-WEBText -YourText "Lorem ipsum dolor sit amet, consectetur adipiscing elit. $(New-WEBTextFormat -Highlight -YourText "You could highlight a text") Nullam ut fermentum lorem, in facilisis ex. Sed nec tristique ex, a posuere tortor.
            Integer laoreet rutrum ante eget ultrices. $(New-WEBTextFormat -Bold "Write a bold text") Proin mi quam, pulvinar eget magna eu, tristique euismod orci."
            New-WEBBlockQuote -YourText "You could now use 'tabs' to create multi page content !"
            New-WEBAlert -YourText "Built with less 100 lines of code !" -ContextualColor info
          }
        }
      }
      New-WEBRow -Content {
        New-WEBColumn -Content {
          New-WEBCard -BackgroundColor "#F2EADF" -Content {
            New-WEBTitle -Size 3 -TitleText "That's a card" -Center
            New-WEBText -YourText "You could include some text, or another PWF function. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam ut malesuada lectus, non semper tellus. Proin faucibus ornare erat nec vestibulum.
            Integer laoreet rutrum ante eget ultrices. $(New-WEBTextFormat -Bold "Proin mi quam"), pulvinar eget magna eu, tristique euismod orci.
            Vestibulum nec mauris a ante lobortis molestie vel id tellus"
            New-WEBImage -ImageURL "https://cdn.britannica.com/71/103171-050-BD1B685A/Bill-Gates-Microsoft-Corporation-operating-system-press-2001.jpg" -WidthInPercent 30
            New-WEBTextFormat -YourText "Yup, you could insert image. Hey, Bill !" -Bold
          }
        }
        New-WEBColumn -Content {
          New-WEBCard -BackgroundColor "#355070" -Content {
            New-WEBTitle -Size 3 -TitleText "Let's create some charts - NEW Stacked bars chart" -LightMode -Center
            New-WEBChart -Stacked -ChartTitle "Stacked Bars" -ChartType "bar" -Legends "January;February;March;April" -Horizontal -LightMode -StackedContent {
              New-WEBChartStackedDataset -Name "Dataset1" -Values "1;2;3;4"
              New-WEBChartStackedDataset -Name "Dataset2" -Values "4;3;2;1"
              New-WEBChartStackedDataset -Name "Dataset3" -Values "5;12;9;4"
              New-WEBChartStackedDataset -Name "Dataset4" -Values "8;2;16;2"
            }
          }
        }
      }
      New-WEBRow -Content {
        New-WEBColumn -Content {
          New-WEBCard -BackgroundColor "#6d597a" -Content {
            New-WEBTitle -Size 3 -TitleText "Disks capacity" -LightMode -Center
            $DisksInfos = (Get-Disk | Select-Object FriendlyName, @{Name = 'Size in GB'; Expression = { [math]::Round(($_.Size / 1GB), 2) } })
            New-WEBChart -ChartValues $DisksInfos."Size in GB" -ChartLabels $DisksInfos.FriendlyName -ChartTitle "Disk Space in GB" -ChartType bar -LightMode -DontShowTitle
          }
        }
        New-WEBColumn -Content {
          New-WEBCard -BackgroundColor "#b56576" -Content {
            New-WEBTitle -Size 3 -TitleText "Doughnut Chart" -LightMode -Center
            $Process = (Get-Process | Select-Object -first 15) | Group-Object Name | select Name, @{Name = "counter"; expression = { $_.count } }
            New-WEBChart -ChartValues $Process.Counter -ChartLabels $Process.Name -ChartTitle "First 15th Process" -ChartType doughnut -LightMode
          }
        }
        New-WEBColumn -Content {
          New-WEBCard -BackgroundColor "#e56b6f" -Content {
            New-WEBTitle -Size 3 -TitleText "Pie Chart" -LightMode -Center
            $Process = Get-Process | Group-Object Name | select -First 15 Name, @{Name = "counter"; expression = { $_.count } }
            New-WEBChart -ChartValues $Process.Counter -ChartLabels $Process.Name -ChartTitle "First 15th Process 2" -ChartType pie -Horizontal -LightMode
          }
        }
      }
      New-WEBRow -Content {
        New-WEBColumn -Content {
          New-WEBCard -BackgroundColor "#F2935C" -Content {
            New-WEBTitle -Size 3 -TitleText "Line Chart" -LightMode -Center
            $Chart2Dataset = Get-Process | Group-Object -NoElement -Property Count, Name | Sort-Object Count -Descending | Select-Object -First 10
            New-WEBChart -ChartTitle "Line Chart 1" -ChartType "line" -ChartLabels $Chart2Dataset.Name -ChartValues ($Chart2Dataset | select -ExpandProperty count) -LightMode
          }
        }
        New-WEBColumn -Content {
          New-WEBCard -BackgroundColor "#eaac8b" -Content {
            New-WEBTitle -Size 3 -TitleText "Table with conditionnal format" -Center -LightMode
            New-WEBTable -ToTable (Get-Process | Group-Object -Property Name | Sort-Object Count -Descending | Select-Object -First 10 Name, Count) -SelectProperties "Name,Count" -SortByColumn -EnableConditionnalFormat -ConditionProperties "Count,Name" -ConditionOperators ">,match" -ConditionValues "10,conhost" -ConditionBackgroundColors "#e63946,#94d2bd" -Small
          }
        }
      }
      New-WEBRow -Content {
        New-WEBColumn -Content {
          New-WEBCard -BackgroundColor "#fff" -Content {
            New-WEBTitle -Size 3 -TitleText "Search in a table" -Center
            New-WEBText -YourText "Some options now like export table, search, paginate, hide many columns and show details by clicking on the row..."
            New-WEBTable -ToTable (Get-Process | Select-Object -First 50) -SelectProperties ProcessName, Handles -DetailsOnClick -EnableConditionnalFormat -ConditionProperties "ProcessName,Handles" -EnableSearch -Exportbuttons -Pagination -ShowTooltip -ConditionOperators "match,>=" -ConditionValues "conhost,100" -ConditionBackgroundColors "#e63946,#94d2bd"
          }
        }
      }
      New-WEBRow -Content {
        New-WEBColumn -Content {
          New-WEBCard -BackgroundColor "#fff" -Content {
            New-WEBTitle -Size 3 -TitleText "Collapsed items (New!)" -Center
            New-WEBAccordion -AccordionItems {
              Get-Service | Select-Object -First 3 | ForEach-Object {
                New-WEBAccordionItem -ItemTitle $_.DisplayName -ItemContent { "$([string]$_.DisplayName) is $($_.Status)" }
              }
            }
          } 
        }
      }
    }
    New-WEBTab -Name "Second Tab" -Content {
      New-WEBColumn -Content {
        New-WEBCard -BackgroundColor "#DFF2F2" -Content {
          New-WEBTitle -Size 3 -TitleText "List first 10 process"
          New-WEBList -List (Get-Process | Select-Object -First 10).Name
        }
      }
    }
  }
}
$TestPage | out-file -Encoding UTF8 -FilePath "C:\Windows\Temp\TestFramework.html"
Start-Process "C:\Windows\Temp\TestFramework.html"
