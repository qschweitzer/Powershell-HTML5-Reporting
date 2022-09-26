# New-PWFAccordionItem

## Description
Create a new Accordion Item (new collapse item).

## SYNTAX
``` powershell
New-PWFAccordionItem -ItemTitle <string> -ItemContent <string>
```

## EXAMPLES

### EXAMPLE 1
```powershell
New-PWFAccordionItem -ItemTitle "Test 1" -ItemContent "SubHeading 1"
```

## PARAMETERS
### -ItemTitle
The primary title of the item.
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
### -ItemContent
The content of your item.
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