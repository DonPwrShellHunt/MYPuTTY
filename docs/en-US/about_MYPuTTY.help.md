# MYPuTTY

## about_MYPuTTY

# SHORT DESCRIPTION
MYPuTTY is a PowerShell module which implements PuTTY session configuration

# LONG DESCRIPTION
MYPuTTY supports PuTTYSession operations of get, new, rename, remove, and start. A PuTTYSession object represents an instance that maps to a stored session in HKCU, which contains over 200 properties and values. The Start-MYPuttySession can be thought of as starting a PuTTY process from the referenced stored session configuration.

PuttySessionPropertySet object operations include get & set. Initially, the PuttySessionPropertySet functions were going to be private, but exporting them makes it easier for PowerShell scripters to manipulate configuration sets to extend functionality. This could take the form of persisting property sets in files, defining color themes, or possibly authentication options.

The New-MYPuttySession function uses an existing stored session as the template for creating a new one. The primary properties given to New-MYPuttySession overwrite the corresponding template properties.

 When storing a new session via the PuTTY GUI it is common to use the hostname as the name of the session, but the matching ability of Get-PuttySession allows the name (and Title) to convey any additional information you might find useful. So, in addition to finding and starting up sessions where hostnames match a certain pattern, you can extend that to matching session names, or matching Titles.

By incorporating the WinTitle as a PuttySession property, you can easily map running PuTTY processes via the MainWindowTitle in a System.Diagnostics.Process.

```
PS> Get-Process -Name Putty | where MainWindowTitle -like '*created by DHPutty*'
```

## PuTTY VERSIONS
In addition to the standard PuTTY versions, this module can also handle Centrify PuTTY. Centrify adds an extra set of properties relating to Kerboros connectivity. The IsCentrify property denotes whether this is a Centrify or standard PuTTY session configuration.

# EXAMPLES
```
PS> Get-MYPuttySession -Hostname "*apache*" | Start-MYPuttySession
PS> Get-MYPuttySession -Name BlackOnPink -Property All
```

# TROUBLESHOOTING NOTE
Either an executable or PowerShell alias by the name of putty must be available in order for the Start-MYPuttySession
cmdlet to function properly. To confirm this, make sure PuTTY is output when the following command is run>
```
Get-Command putty
```

# NOTE
The PlatyPS module is used on the markdown file in Docs to produce the actual external documentaion in the en-us folder of the module. Comment based help in MYPuTTY functions will be removed in the near future. From with the MYPuTTY folder the following command is used to refresh the external help files>

```
New-ExternalHelp .\Docs -OutputPath en-US\ -Force
```

# SEE ALSO
Various other PuTTY modules are in the PowerShellGallery which may be of interest.

# KEYWORDS

- PuTTY
- Registry
