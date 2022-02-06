# New-PWFBadge

## Description
Create an alert HTML object.
Examples: https://getbootstrap.com/docs/4.0/components/badge/

## SYNTAX
``` powershell
New-PWFBadge -YourText <string> [-Type <string>] [-PillMode <switch>]
```

## EXAMPLES

### EXAMPLE 1
```powershell
New-PWFBadge -YourText "1" -Type Success
```
### EXAMPLE 2
```powershell
New-PWFBadge -YourText "5" -Type Danger -PillMode
```

## PARAMETERS
### -YourText
Your badge's text.
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
### -Type
A color from the defined dataset.
```yaml
Type: String
Parameter Sets: Primary, Secondary, Success, Danger, Warning, Info, Light, Dark.
Aliases:
Required: False
Position: Named
Default value: default
Accept pipeline input: False
Accept wildcard characters: False
```
### -PillMode
PillMode (rounded badge).
```yaml
Type: String
Parameter Sets: (All)
Aliases:
Required: False
Position: Named
Default value: default
Accept pipeline input: False
Accept wildcard characters: False
```