# New-PWFCard

## Description
Create a card wich can contains differents types of data.

## SYNTAX
``` powershell
New-PWFCard -Content <scriptblock> [-BackgroundColor <string>]
```

## EXAMPLES

### EXAMPLE 1
```powershell
New-PWFCard -Content { ... } -BackgroundColor "#f9fafb"
```
### EXAMPLE 2
```powershell
New-PWFCard -Content { ... }
```

## PARAMETERS
### -Content
The content of the card.
```yaml
Type: Scriptblock
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```
### -BackgroundColor
An hexadecimal color with sharp.
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