# New-PWFChart

## Description
Create a new Chart. Enter your data and tadaaa.

## SYNTAX
``` powershell
New-PWFChart -ChartTitle <string> -ChartType <string> [-Stacked <switch>] [-ChartLabels <array>] [-ChartValues <array>] [-Legends <array>] [-Horizontal <switch>] [-ChartColors <array>] [-LightMode <switch>] [-DontShowTitle <switch>] [-StackedContent <scriptblock>]
```

## EXAMPLES

### EXAMPLE 1
```powershell
New-PWFChart -ChartTitle "Line Chart 1" -ChartType "line" -ChartLabels $ChartDataset.Name -ChartValues ($ChartDataset | select -ExpandProperty count)
```
### EXAMPLE 2
```powershell
New-PWFChart -Stacked -ChartTitle "Stacked Bars" -ChartType "bar" -Legends "Janvier;Fevrier;Mars;Avril" -StackedContent {
  New-PWFChartStackedDataset -Name "Dataset1" -Values "1;2;3;4"
  New-PWFChartStackedDataset -Name "Dataset2" -Values "4;3;2;1"
}
```

## PARAMETERS
### -ChartTitle
Title of your chart. For Stacked and NotStacked chart.
```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ChartType
Type of your chart. Select from set. For Stacked and NotStacked chart.
```yaml
Type: String
Parameter Sets: ("bar", "doughnut", "pie", "line", "radar", "polar")
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```
### -Stacked
Enable Stacked chart. For Stacked chart.
```yaml
Type: switch
Parameter Sets: (Stacked)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```
### -ChartLabels
Array of values to use to build chart. For NotStacked chart.
```yaml
Type: array
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```
### -Legends
Array of legends to use. For Stacked chart.
```yaml
Type: array
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```
### -Horizontal
Chart in horizontal mode, if compatible. For Stacked and NotStacked chart.
```yaml
Type: Switch
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```
### -ChartColors
Array of hexadecimal colors to use in your charts. Use it to create your own colors palette. For Stacked and NotStacked chart.
```yaml
Type: Array
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```
### -LightMode
Light mode for your chart. Use it with dark background/card.
```yaml
Type: Switch
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```
### -DontShowTitle
Hide the chart title.
```yaml
Type: Switch
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```
### -StackedContent
Scriptblock to use PWFChartStackedDataset and build content of Stacked Chart.
```yaml
Type: ScriptBlock
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```