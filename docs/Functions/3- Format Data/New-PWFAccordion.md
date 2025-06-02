# New-WEBAccordion

## Description
Create a new Accordion element to organize your content.

## SYNTAX
``` powershell
New-WEBAccordion -AccordionItems {
    <scriptblock>
} [-Alwaysopen <switch>]
```

## EXAMPLES

### EXAMPLE 1
```powershell
New-WEBAccordion -AccordionItems {
    New-WEBAccordionItem -ItemTitle "Test 1" -ItemContent "SubHeading 1"
    New-WEBAccordionItem -ItemTitle "Test 2" -ItemContent "SubHeading 2"
    New-WEBAccordionItem -ItemTitle "Test 3" -ItemContent "SubHeading 3"
}
```

## PARAMETERS
### -AccordionItems
ScriptBlock containing PWF-AccordionItems.
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
### -Alwaysopen
When you click on first and then second title, the first stay open.
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