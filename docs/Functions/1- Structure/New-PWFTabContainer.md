# New-PWFTabContainer

## Description
You want to add tabs ? You need this function to build your tab's menu on the top of page.
The scriptblock Tabs must contains New-PWFTabs.

## SYNTAX
``` powershell
New-PWFTabContainer -Tabs <ScriptBlock>
```

## EXAMPLES

### EXAMPLE 1
```powershell
New-PWFTabContainer {
    New-PWFTabs -Name "Tab1" -Content {...SOMECODE...}
    New-PWFTabs -Name "Tab2" -Content {...SOMECODE...}
}
```

## PARAMETERS
### -Tabs
Your New-PWFTabs functions.
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