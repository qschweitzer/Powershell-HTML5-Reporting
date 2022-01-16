# New-PWFChartStackedDataset

## Description
Create a new chart Dataset for stacked chart only.

## SYNTAX
``` powershell
New-PWFChartStackedDataset -Name <string> -Values <object> [-Color <string>]
```

## EXAMPLES

### EXAMPLE 1
```powershell
New-PWFChartStackedDataset -Name "January" -Values 1..31
```

## PARAMETERS
### -Name
The name of your data set.
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
### -Values
The [int] values of your dataset. You could use an object/array or type values as a string, separated by semi-colon like "1;9;3"
```yaml
Type: object
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```
### -Color
The color to color your data set in the chart. Default is colors generated automatically from thecolorapi.com.
```yaml
Type: string
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```