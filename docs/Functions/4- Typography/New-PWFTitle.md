# New-PWFTitle

## Description
New row wich contains what you want.

## SYNTAX
``` powershell
New-PWFTitle -TitleText <string> -Size <string> [-Center] [-Lightmode]
```

## EXAMPLES

### EXAMPLE 1
```powershell
New-PWFTitle -TitleText "MyTitle" -Size 1 -Center -Lightmode
```
### EXAMPLE 2
```powershell
New-PWFTitle -TitleText "MyTitle" -Size 1 -Center
```
### EXAMPLE 3
```powershell
New-PWFTitle -TitleText "MyTitle" -Size 1
```

## PARAMETERS
### -TitleText
Your title.
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
Size of your title. From 1 to 5. 1 is biggest.
```yaml
Type: Int
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```
### -Center
Use Center to center your text in the parent division.
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
### -Lightmode
The Lightmode will color your text in white.
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