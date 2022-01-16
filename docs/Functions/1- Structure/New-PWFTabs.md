# New-PWFTabs

## Description
A new tab to add to your main TabContainer with your content.

## SYNTAX
``` powershell
New-PWFTabs -Name <string> -Content <scriptblock>
```

## EXAMPLES

### EXAMPLE 1
```powershell
New-PWFTabs -Name "Tab1" -Content {
    ...SOMECODE...
}
```

## PARAMETERS
### -Name
Your tab's name. This name will be show on the main tab menu on top of page.
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
### -Content
The scriptblock with the content of the tab.
```yaml
Type: SCriptBlock
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```