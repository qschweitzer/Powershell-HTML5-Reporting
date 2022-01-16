# New-PWFPage

## Description
Build the main code of the HTML5 page. Contains all the necessary for your next steps.
Page will **contains all next code**.  
Store it in a variable to export it at the end.  
POSHTML5 generate a **full string output**, an **HTML** page.

## SYNTAX
``` powershell
New-PWFPage -Title <string> -Content <ScriptBlock> [-Chartset <String>] [-Container]
```

## EXAMPLES

### EXAMPLE 1
```powershell
$PageVar = New-PWFPage -Title "MY FIRST TEST" -Content {
    .. SOME CODE ..
}
```
### EXAMPLE 2
```powershell
$PageVar = New-PWFPage -Title "MY FIRST TEST" -Chartset "UTF8" -Container -Content {
    .. SOME CODE ..
}
```

## PARAMETERS
### -Title
The title of your main page. That's the title on the tab of your web browser.
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
The scriptblock that contains all other code and PWF functions.
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
### -Chartset
Your HTML5 chartset. Write it like you write it for HTML code.
```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: UTF-8
Accept pipeline input: False
Accept wildcard characters: False
```
### -Container
Force your page to be centered and have large margin on each side.
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