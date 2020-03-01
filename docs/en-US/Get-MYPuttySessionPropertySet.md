---
external help file: MYPuTTY-help.xml
Module Name: MYPuTTY
online version:
schema: 2.0.0
---

# Get-MYPuttySessionPropertySet

## SYNOPSIS
Get properties associated with a Putty session

## SYNTAX

### All (Default)
```
Get-MYPuttySessionPropertySet -Name <String> [<CommonParameters>]
```

### Subset
```
Get-MYPuttySessionPropertySet -Name <String> -Property <String[]> [<CommonParameters>]
```

## DESCRIPTION
Get properties associated with a Putty session.
All properties or a subset of properties can be returned.

## EXAMPLES

### EXAMPLE 1
```
Get-MYPuttySessionPropertySet -Name krbExample
```

### EXAMPLE 2
```
Get-MYPuttySession -Name *mgt01 | Get-MYPuttySessionPropertySet
```

### EXAMPLE 3
```
Get-MYPuttySessionPropertySet -Name krbExample -Property 'TermWidth','TermHeight'
```

PropertyName PropertyType PropertyValue
------------ ------------ -------------
TermWidth           Dword            80
TermHeight          Dword            24

## PARAMETERS

### -Name
Session Name that properties should belong to

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Property
Array of property names whose properties will be returned

```yaml
Type: String[]
Parameter Sets: Subset
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### PSCustomObject with properties of
### PropertyName, PropertyType, PropertyValue
## NOTES
Requires Registry module
Returns PSCustomObject collection

## RELATED LINKS
