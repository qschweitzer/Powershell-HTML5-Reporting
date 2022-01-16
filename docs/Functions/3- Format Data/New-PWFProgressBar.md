# New-PWFProgressBar

## Description
Insert a progress bar.

## SYNTAX
``` powershell
New-PWFProgressBar -CurrentValue <int> [-MaxValue <int>]
```

## EXAMPLES

### EXAMPLE 1
```powershell
New-PWFProgressBar -CurrentValue 25 -MaxValue 200
```

## PARAMETERS
### -CurrentValue
The value of the progress.
```yaml
Type: int
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```
### -MaxValue
The maximum value. Max value is 100% of the progress.
```yaml
Type: int
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```