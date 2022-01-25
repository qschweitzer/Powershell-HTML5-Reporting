# New-PWFColumn

## Description
New column wich contains what you want.
Column's width are auto-sized. If you have two, each of them will be 50% width of the page.

## SYNTAX
``` powershell
New-PWFColumn -Content <scriptblock>
```

## EXAMPLES

### EXAMPLE 1
```powershell
New-PWFColumn -Content {
    ...SOMECODE...
}
```

## PARAMETERS
### -Content
Your next code.
```yaml
Type: ScriptBlock
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```