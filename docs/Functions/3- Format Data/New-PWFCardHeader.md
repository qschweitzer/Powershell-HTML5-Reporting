# New-WEBCardHeader

## Description
Create a card header.

## SYNTAX
``` powershell
New-WEBCardHeader -Content <scriptblock> [-BackgroundColor <string>] [-Center <switch>]
```

## EXAMPLES

### EXAMPLE 1
```powershell
New-WEBCardHeader -Content { ... } -BackgroundColor "#f9fafb"
```
### EXAMPLE 2
```powershell
New-WEBCardHeader -Content { ... } -Center
```

## PARAMETERS
### -Content
The content of the card's header.
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
An hexadecimal color with hash mark.
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
### -Center
Center.
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