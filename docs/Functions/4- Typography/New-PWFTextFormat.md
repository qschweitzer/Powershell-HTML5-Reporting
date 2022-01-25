# New-PWFTextFormat

## Description
Create a new HTML text with customized format. You can use multiple format options at the same time.

## SYNTAX
``` powershell
New-PWFTextFormat -YourText <string> [-ColorHexa <string>] [[-Abbreviation <switch>] [-HighLight <switch>] [-Bold <switch>] [-Strikethrough <switch>] [-Italic <switch>] [-Deleted <switch>] [-Subtext <switch>] [-Suptext <switch>] [-Inserted <switch>] [-Keyboard <switch>] [-Underline <switch>]
```

## EXAMPLES

### EXAMPLE 1
```powershell
New-PWFTextFormat -YourText "My Text is Awesome" -ColorHexa "#D94020" -Bold -Underline
 
```
### EXAMPLE 2
```powershell
New-PWFTextFormat -YourText "My Text is Awesome" -Italic
 ```

## PARAMETERS
### -YourText
Your text.
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
### -ColorHexa
Your hexa color, include sharp.
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
### -Abbreviation
Abbreviation format. Look at https://picocss.com/docs/#typography for examples.
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

### -Highlight
Highlight format. Look at https://picocss.com/docs/#typography for examples.
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
### -Bold
Bold format. Look at https://picocss.com/docs/#typography for examples.
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
### -Strikethrough
Strikethrough format. Look at https://picocss.com/docs/#typography for examples.
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
### -Italic
Italic format. Look at https://picocss.com/docs/#typography for examples.
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
### -Deleted
Deleted format. Look at https://picocss.com/docs/#typography for examples.
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
### -Subtext
Subtext format. Look at https://picocss.com/docs/#typography for examples.
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
### -Suptext
Suptext format. Look at https://picocss.com/docs/#typography for examples.
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
### -Inserted
Inserted format. Look at https://picocss.com/docs/#typography for examples.
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
### -Keyboard
Keyboard format. Look at https://picocss.com/docs/#typography for examples.
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
### -Underline
Underline format. Look at https://picocss.com/docs/#typography for examples.
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