# New-PWFAlert

## Description
Create an alert HTML object.
Examples: https://getbootstrap.com/docs/4.0/components/alerts/

## SYNTAX
``` powershell
New-PWFAlert -YourText <string> [-ContextualColor <string>]
```

## EXAMPLES

### EXAMPLE 1
```powershell
New-PWFAlert -YourText "Your disk capacity is under 10% free." -ContextualColor danger
```
### EXAMPLE 2
```powershell
New-PWFAlert -YourText "You're connected to Internet."
```

## PARAMETERS
### -YourText
Your text alert.
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
### -ContextualColor
A color from the defined dataset.
```yaml
Type: String
Parameter Sets: Primary, Secondary, Success, Danger, Warning, Info, Light, Dark. Default is Primary.
Aliases:

Required: False
Position: Named
Default value: default
Accept pipeline input: False
Accept wildcard characters: False
```