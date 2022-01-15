# New-PWFList

## Description
Create a list of data, numbered or not.

## SYNTAX
``` powershell
New-PWFList -List [-Numbered <switch>]
```

## EXAMPLES

### EXAMPLE 1
```powershell
New-PWFList -List "Test1","Test2"
```
### EXAMPLE 2
```powershell
New-PWFList -List $myarray -Numbered
```

## PARAMETERS
### -List
Your list from an object or manually created.
```yaml
Type: Array
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```
### -Numbered
Change to a numbered list
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