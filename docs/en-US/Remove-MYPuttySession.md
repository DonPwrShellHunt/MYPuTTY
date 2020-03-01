---
external help file: MYPuTTY-help.xml
Module Name: MYPuTTY
online version:
schema: 2.0.0
---

# Remove-MYPuttySession

## SYNOPSIS
Removes a named Putty Session

## SYNTAX

```
Remove-MYPuttySession [-Name] <String[]> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Removes a named Putty Session

## EXAMPLES

### EXAMPLE 1
```
Remove-MYPuttySession -Name CentMagenta
```

### EXAMPLE 2
```
Get-MYPuttySession -Name 'z_*' | Remove-MYPuttySession
```

### EXAMPLE 3
```
Remove-MYPuttySession -Name 'kHost1','kHost2' -WhatIf
```

## PARAMETERS

### -Name
Wildcard string to specify which session to remove

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
