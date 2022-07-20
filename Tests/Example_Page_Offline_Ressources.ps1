######################
#####  EXAMPLES  #####
######################
Import-Module $PSScriptRoot+"\..\public\new-pwftable.ps1" -Force
Import-Module $PSScriptRoot+"\..\public\new-pwftabcontainer.ps1" -Force
Import-Module $PSScriptRoot+"\..\public\new-pwftab.ps1" -Force
Import-Module $PSScriptRoot+"\..\public\new-pwfcarouselcontainer.ps1" -Force
Import-Module $PSScriptRoot+"\..\public\new-pwfcarouselitem.ps1" -Force
$TestPage = New-PWFPage -Title "MY FIRST TEST" -Content {
  New-PWFTabContainer -Tabs {
    New-PWFTab -Name "First Tab" -Content {
      New-PWFCardHeader -BackgroundColor "#fff" -Center -Content {
        New-PWFTitle -TitleText "Hi, I'm generated on a Windows PC with a Powershell script." -Size 1 -Center
      }
      New-PWFRow -Content {
        New-PWFColumn -Content {
          New-PWFCard -Content {
            New-PWFTitle -Size 2 -TitleText "This HTML skin is based on $(New-PWFTextFormat -Bold "PicoCSS framework") and $(New-PWFTextFormat -Bold "Bootstrap!") For the $(New-PWFTextFormat -ColorHexa "#BF0413" -Highlight "charts"), it's $(New-PWFTextFormat -Bold "ChartJS!") And for dynamic tables POSHTML5 use $(New-PWFTextFormat -Bold "Bootstrap-tables.")."
            New-PWFText -YourText "Lorem ipsum dolor sit amet, consectetur adipiscing elit. $(New-PWFTextFormat -Highlight -YourText "You could highlight a text") Nullam ut fermentum lorem, in facilisis ex. Sed nec tristique ex, a posuere tortor.
            Integer laoreet rutrum ante eget ultrices. $(New-PWFTextFormat -Bold "Write a bold text") Proin mi quam, pulvinar eget magna eu, tristique euismod orci."
            New-PWFBlockQuote -YourText "You could now use 'tabs' to create multi page content !"
            New-PWFAlert -YourText "Built with less 100 lines of code !" -ContextualColor info
          }
        }
      }
      New-PWFRow -Content {
        New-PWFColumn -Content {
          New-PWFCard -BackgroundColor "#F2EADF" -Content {
            New-PWFTitle -Size 3 -TitleText "That's a card" -Center
            New-PWFText -YourText "You could include some text, or another PWF function. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam ut malesuada lectus, non semper tellus. Proin faucibus ornare erat nec vestibulum.
            Integer laoreet rutrum ante eget ultrices. $(New-PWFTextFormat -Bold "Proin mi quam"), pulvinar eget magna eu, tristique euismod orci.
            Vestibulum nec mauris a ante lobortis molestie vel id tellus"
            New-PWFImage -ImageURL "https://cdn.britannica.com/71/103171-050-BD1B685A/Bill-Gates-Microsoft-Corporation-operating-system-press-2001.jpg" -WidthInPercent 30
            New-PWFTextFormat -YourText "Yup, you could insert image. Hey, Bill !" -Bold
          }
        }
        New-PWFColumn -Content {
          New-PWFCard -BackgroundColor "#355070" -Content {
            New-PWFTitle -Size 3 -TitleText "Let's create some charts - NEW Stacked bars chart" -LightMode -Center
            New-PWFChart -Stacked -ChartTitle "Stacked Bars" -ChartType "bar" -Legends "January;February;March;April" -Horizontal -LightMode -StackedContent {
              New-PWFChartStackedDataset -Name "Dataset1" -Values "1;2;3;4"
              New-PWFChartStackedDataset -Name "Dataset2" -Values "4;3;2;1"
              New-PWFChartStackedDataset -Name "Dataset3" -Values "5;12;9;4"
              New-PWFChartStackedDataset -Name "Dataset4" -Values "8;2;16;2"
            }
          }
        }
      }
      New-PWFRow -Content {
        New-PWFColumn -Content {
          New-PWFCard -BackgroundColor "#6d597a" -Content {
            New-PWFTitle -Size 3 -TitleText "Disks capacity" -LightMode -Center
            $DisksInfos = (Get-Disk | Select-Object FriendlyName, @{Name = 'Size in GB'; Expression = { [math]::Round(($_.Size / 1GB), 2) } })
            New-PWFChart -ChartValues $DisksInfos."Size in GB" -ChartLabels $DisksInfos.FriendlyName -ChartTitle "Disk Space in GB" -ChartType bar -LightMode -DontShowTitle
          }
        }
        New-PWFColumn -Content {
          New-PWFCard -BackgroundColor "#b56576" -Content {
            New-PWFTitle -Size 3 -TitleText "Doughnut Chart" -LightMode -Center
            $Process = (Get-Process | Select-Object -first 15) | Group-Object Name | select Name, @{Name = "counter"; expression = { $_.count } }
            New-PWFChart -ChartValues $Process.Counter -ChartLabels $Process.Name -ChartTitle "First 15th Process" -ChartType doughnut -LightMode
          }
        }
        New-PWFColumn -Content {
          New-PWFCard -BackgroundColor "#e56b6f" -Content {
            New-PWFTitle -Size 3 -TitleText "Pie Chart" -LightMode -Center
            $Process = Get-Process | Group-Object Name | select -First 15 Name, @{Name = "counter"; expression = { $_.count } }
            New-PWFChart -ChartValues $Process.Counter -ChartLabels $Process.Name -ChartTitle "First 15th Process 2" -ChartType pie -Horizontal -LightMode
          }
        }
      }
      New-PWFRow -Content {
        New-PWFColumn -Content {
          New-PWFCard -BackgroundColor "#F2935C" -Content {
            New-PWFTitle -Size 3 -TitleText "Line Chart" -LightMode -Center
            $Chart2Dataset = Get-Process | Group-Object -NoElement -Property Count, Name | Sort-Object Count -Descending | Select-Object -First 10
            New-PWFChart -ChartTitle "Line Chart 1" -ChartType "line" -ChartLabels $Chart2Dataset.Name -ChartValues ($Chart2Dataset | select -ExpandProperty count) -LightMode
          }
        }
        New-PWFColumn -Content {
          New-PWFCard -BackgroundColor "#eaac8b" -Content {
            New-PWFTitle -Size 3 -TitleText "Table with conditionnal format" -Center -LightMode
            New-PWFTable -ToTable (Get-Process | Group-Object -Property Name | Sort-Object Count -Descending | Select-Object -First 10 Name, Count) -SelectProperties "Name,Count" -SortByColumn -ConditionProperties "Count,Name" -EnableConditionnalFormat -ConditionOperators ">,match" -ConditionValues "10,conhost" -ConditionBackgroundColors "#e63946,#94d2bd" -Small
          }
        }
      }
      New-PWFRow -Content {
        New-PWFColumn -Content {
          New-PWFCard -BackgroundColor "#fff" -Content {
            New-PWFTitle -Size 3 -TitleText "Search in a table" -Center
            New-PWFText -YourText "Some options now like export table, search, paginate, hide many columns and show details by clicking on the row..."
            New-PWFTable -ToTable (Get-Process | Select-Object ProcessName, Handles, NPM, PM, WS, PeakWorkingSet64, Description, CPU, ProductVersion, PagedMemorySize64, PagedSystemMemorySize, PeakVirtualMemorySize, Responding) -SelectProperties ProcessName, Handles -DetailsOnClick -EnableConditionnalFormat -ConditionProperties "ProcessName,Handles" -EnableSearch -Exportbuttons -Pagination -ShowTooltip -ConditionOperators "match,>=" -ConditionValues "3CX,100" -ConditionBackgroundColors "#e63946,#94d2bd"
          }
        }
      }
    }
    New-PWFTab -Name "Second Tab" -Content {
      New-PWFColumn -Content {
        New-PWFCard -BackgroundColor "#DFF2F2" -Content {
          New-PWFTitle -Size 3 -TitleText "List first 10 process"
          New-PWFList -List (Get-Process | Select-Object -First 10).Name
        }
      }
      New-PWFColumn -Content {
        New-PWFCarouselContainer -content {
          New-PWFCarouselItem -Content {
            New-PWFImage -ImageURL "https://cdn.britannica.com/71/103171-050-BD1B685A/Bill-Gates-Microsoft-Corporation-operating-system-press-2001.jpg" -WidthInPercent 30
          }
          New-PWFCarouselItem -content {
            $Process2 = Get-Process | Group-Object Name | Select-Object -First 15 Name, @{Name = "counter"; expression = { $_.count } }
            New-PWFChart -ChartValues $Process2.Counter -ChartLabels $Process2.Name -ChartTitle "First 15th" -ChartType pie -Horizontal -LightMode

          }
        }
      }
    }
  }
}
$ExportFile = $PSScriptRoot + "\TestFramework.html"
$TestPage | out-file -Encoding UTF8 -FilePath $ExportFile
Start-Process $ExportFile
