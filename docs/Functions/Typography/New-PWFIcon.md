# New-PWFIcon

## Description
Create a new icon based on Google Material icons database.

## SYNTAX
``` powershell
New-PWFIcon -IconName <string> [-SizeInPixel <string>]
```

## EXAMPLES

### EXAMPLE 1
```powershell
New-PWFIcon -IconName Settings -SizeInPixel 24
```

## PARAMETERS
### -IconName
The name of the icon. Choose it here: https://fonts.google.com/icons?selected=Material+Icons
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

### -Size
The size of the icon. (18,24,36,48 are defaults about Material guidelines)
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