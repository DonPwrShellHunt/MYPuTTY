function Get-MYPuttySession {
    <#
        .SYNOPSIS
           Get Putty Session information
        .DESCRIPTION
           Get Putty Session information
        .PARAMETER Name
           Wildcard string to find session by session name
        .PARAMETER HostName
           Wildcard string to find session by HostName
        .PARAMETER WinTitle
           Wildcard string to find session by WinTitle
        .PARAMETER Property
           Property names of Putty session to return
           Defaults to 'HostName','WinTitle'
           Use 'All' to return all properties
        .EXAMPLE
           Get-MYPuttySession
        .EXAMPLE
           Get-MYPuttySession -Name 'k_*'
        .EXAMPLE
           Get-MYPuttySession -HostName '192.*'
        .EXAMPLE
           Get-MYPuttySession -WinTitle '*Apache*'
        .EXAMPLE
           Get-MYPuttySession -Name StdKerberos -Property All
        .NOTES
            Three parameter sets>
            ByName
            ByHost
            ByTitle

            Wildcard characters are supported in Name, HostName, and WinTitle
            parameters. Default behavior if no parameters are specified is
            to return all Putty sessions.

            ByHost and ByTitle will look in all defined Putty sessions for
            a match based on specific property. If no matches are found,
            then no sessions are returned.

            Return objects are [PSCustomObject} with properties:
            Name
            HostName
            WinTitle
            IsCentrify
            PropertySet


    #>
        [CmdletBinding(DefaultParameterSetName='ByName')]
        [OutputType([PSCustomObject])]
        Param
        (
            # Name parameter gets Putty Sessions with names that match
            [Parameter(Mandatory=$false,
                       ParameterSetName='ByName',
                       Position=0)]
            $Name='*',

            [Parameter(Mandatory=$true,
                       ParameterSetName='ByHost',
                       Position=0)]
            $HostName,

            [Parameter(Mandatory=$true,
                       ParameterSetName='ByTitle',
                       Position=0)]
            $WinTitle,

            [Parameter(Mandatory=$false)]
            [PSObject[]] $Property = ('HostName','WinTitle')
        )

        Begin {
            $SessionsDir = 'HKCU:\Software\SimonTatham\PuTTY\Sessions'
        }

        Process {
            If (!$Name) {
                # if we are searching on property match, look at all sessions
                $Name = '*'
            }
            $matchedSessions = @(Get-Item -Path "$SessionsDir\*" -Include $Name)

            if ($HostName) {
                $matchPropName = 'HostName'
                $matchPropValue = $HostName
            }
            if ($WinTitle) {
                $matchPropName = 'WinTitle'
                $matchPropValue = $WinTitle
            }

            if ($matchedSessions.Count -ne 0) {
                foreach ($ms in $matchedSessions) {
                    if ($matchPropName) {
                        if ($ms.GetValue($matchPropName) -notlike $matchPropValue) {
                            continue
                        }
                    }
                    # Determines IsCentrify based on existence of DoKerberos property
                    if ($Property[0] -eq 'All') {
                        $pset = Get-MYPuttySessionPropertySet -Name $ms.PSChildName
                    } else {
                        $pset = Get-MYPuttySessionPropertySet -Name $ms.PSChildName -Property $Property
                    }
                    $objhash = [ordered] @{
                        Name=$ms.PSChildName
                        HostName=$ms.GetValue('HostName')
                        WinTitle=$ms.GetValue('WinTitle')
                        IsCentrify=($ms.Property -contains 'DoKerberos')
                        PropertySet=$pset
                    }
                    $obj = New-Object -TypeName PSObject -Property $objhash
                    $obj.PSObject.TypeNames.Insert(0,'DonHunt.Putty.Session')
                    Write-Output -InputObject $obj
                }
            } else {
                Write-Verbose -Message ('No sessions matched with Name {0}' -f $Name)
            }
        }

        End {

        }
    }
