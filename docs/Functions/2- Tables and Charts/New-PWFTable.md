# New-PWFTable

## Description
Create a table from a powershell object.

## SYNTAX
``` powershell
New-PWFTable -ToTable <object> [-SelectProperties <array>] [-EnableSearch <switch>] [-Exportbuttons <switch>] [-EnableConditionnalFormat <switch>] [-ConditionProperties <array>] [-ConditionOperators <array>] [-ConditionValues <array>] [-ConditionBackgroundColors <array>] [-Pagination <switch>] [-ShowTooltip <switch>] [-DetailsOnClick <switch>] [-SortByColumn <switch>] [-Striped <switch>] [-Dark <switch>] [-Small <switch>] [-ContextualColor <string> ValidateSet]
```

## EXAMPLES

### EXAMPLE 1
```powershell
New-PWFTable -ToTable (Get-Process | Group-Object -Property Name -NoElement | Sort-Object Count -Descending) -SelectProperties "Name,Count" -EnableConditionnalFormat -ConditionProperties "Count,Name" -ConditionOperators ">,match" -ConditionValues "2,svchost" -ConditionBackgroundColors "#ff0000,yellow"
```

## PARAMETERS
### -ToTable
The object you want to convert to an HTML table.
```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SelectProperties
Array or string (separate by comma) entries. Select certain properties to not use the totality of the object's properties.
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
### -EnableSearch
Enable a search bar that helps you to find any word on the table.
```yaml
Type: switch
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```
### -Exportbuttons
Add a XLSX button to export table to XLSX file.
```yaml
Type: switch
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```
### -EnableConditionnalFormat
Enable addition of condition with next parameters ConditionProperties,COnditionOperators,ConditionValues,ConditionBackgroundColors. Each of them nedd to have same number of properties,operators,values.
```yaml
Type: switch
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```
### -ConditionProperties
Add the different properties where you want to add a condition, in a string format and joined by comma: "Property1,Property2"
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
### -ConditionOperators
Add the different operators of the conditions, like ">=",">" for numbers compare. To match specific text, use "match".
```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```
### -ConditionValues
Add the different values to control condition: "1,8"
```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```
### -ConditionBackgroundColors
Add a background color if the condition match
```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```
### -Pagination
Limit the size of your table and add pagination system.
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
### -ShowTooltip
Add a toolbar with some options like fullscreen your tab, enable/disable pagination...
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
### -DetailsOnClick
Use it to large objects, it will limit the width size of your table and add all other properties in a details pane. Just click on the row to display details.
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
### -SortByColumn
Add option to sort by column on click.
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
### -Striped
Striped table.
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
### -Dark
Dark mode.
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
### -Small
Reduce height of each row to have a more condensed table.
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
### -ContextualColor
Use a contextual color in the set to change color of the table.
```yaml
Type: Switch
Parameter Sets: ("default", "primary", "secondary", "success", "danger", "warning","info","light","dark")
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```