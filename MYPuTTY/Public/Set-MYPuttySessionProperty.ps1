function Set-MYPuttySessionProperty {
    <#
        .SYNOPSIS
            Set specific properties in a Putty Session
        .DESCRIPTION
            Set specific properties in a Putty Session
        .PARAMETER Name
            The name of the Putty Session to change
        .PARAMETER PropertyHash
            A hash table that contains Session property names and values
            to set. Dword properties should be numeric.
        .EXAMPLE
            Set-MYPuttySessionProperty -Name KerberosMagenta -PropertyHash @{WinTitle='Magenta';TermWidth=150;TermHeight=50}
    #>
        [CmdletBinding(SupportsShouldProcess=$true)]
        Param
        (
            # Name is the Putty Session to be updated
            [Parameter(Mandatory=$true,
                       ValueFromPipelineByPropertyName=$true,
                       Position=0)]
            [String[]]
            $Name,

            # PropertyHash contains the names & values of the properties to be set
            [Parameter(Mandatory=$true,
                       Position=1)]
            [hashtable]
            $PropertyHash
        )

        Begin {
            $puttypath = 'HKCU:\Software\SimonTatham\PuTTY\Sessions'
        }

        Process {
            foreach ($sessionName in $Name) {
                $subkeypath = Join-Path -Path $puttypath -ChildPath $sessionName
                # get all the properties for this session, for validation of incoming hash & registry data type
                $allprops = @(Get-MYPuttySessionPropertySet -Name $sessionName)
                if ($allprops.Count -gt 1) {
                    # create hash where property name is key, type is value (String, Dword)
                    $pntype = @{}
                    foreach ($p in $allprops) {
                        $pntype[$p.PropertyName] = $p.PropertyType
                    }
                } else {
                    Write-Error -Message ('Invalid Session Name: {0}' -f $sessionName)
                    throw 'Bad session name'
                }

                foreach ($k in $PropertyHash.keys) {
                    # would be nice to check each key (property name) is valid
                    # in current logic this could be done by testing existance in $pntype hash
                    if ( $pntype.ContainsKey($k) ) {
                        switch ($pntype[$k])
                        {
                            'String'  {
                                [String]$value = $PropertyHash[$k]
                                if ($PSCmdlet.ShouldProcess($k)) {
                                    Set-ItemProperty -Path $subkeypath -Name $k -Value $value -Verbose
                                }
                            }

                            'Dword'   {
                                if ($PSCmdlet.ShouldProcess($k)) {
                                    Set-ItemProperty -Path $subkeypath -Name $k -Value $PropertyHash[$k] -Verbose
                                }
                            }

                            default   {
                                Write-Warning -Message ('For PropertyName: {0} Unhandled Type: {1}' -f $k,$pntype[$k])
                            }
                        }
                    } else {
                        Write-Warning -Message ('PropertyName: {0} does not exist in Session: {1}' -f $k,$sessionName)
                    }
                }
            }

        }

        End {

        }
    }
