# New-WEBTabContainer

## Description
You want to add tabs ? You need this function to build your tab's menu on the top of page.
The scriptblock Tabs must contains New-WEBTabs.

## SYNTAX
``` powershell
New-WEBTabContainer -Tabs <ScriptBlock>
```

## EXAMPLES

### EXAMPLE 1
```powershell
New-WEBTabContainer {
    New-WEBTabs -Name "Tab1" -Content {...SOMECODE...}
    New-WEBTabs -Name "Tab2" -Content {...SOMECODE...}
}
```

## PARAMETERS
### -Tabs
Your New-WEBTabs functions.
```yaml
Type: ScriptBlock
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```