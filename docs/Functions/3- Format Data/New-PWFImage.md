# New-PWFImage

## Description
INsert an image a set the size.

## SYNTAX
``` powershell
New-PWFImage -ImageURL <string> [-WidthInPercent <int>]
```

## EXAMPLES

### EXAMPLE 1
```powershell
New-PWFImage -ImageURL "https://myimage.." -WidthInPercent 50
```

## PARAMETERS
### -ImageURL
You have to type the URL of your Image. Prefer image on a web access.
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

### -WidthInPercent
Type the percent you want to define image size. 100% is the width of the parent div.
```yaml
Type: Int
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```