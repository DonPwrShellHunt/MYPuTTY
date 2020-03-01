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
            [String]
            $Name,

            # PropertyHash contains the names & values of the properties to be set
            [Parameter(Mandatory=$true,
                       Position=1)]
            [hashtable]
            $PropertyHash
        )

        Begin {
            $puttypath = 'HKCU:\Software\SimonTatham\PuTTY\Sessions'
            $subkeypath = Join-Path -Path $puttypath -ChildPath $Name

            $allprops = @(Get-PuttySessionPropertySet -Name $Name)
            if ($allprops.Count -gt 1) {
                # create hash where property name is key, type is value (String, Dword)
                $pntype = @{}
                foreach ($p in $allprops) {
                    $pntype[$p.PropertyName] = $p.PropertyType
                }
            } else {
                Write-Error -Message ('Invalid Session Name: {0}' -f $Name)
                throw 'Bad session name'
            }
        }

        Process {
            foreach ($k in $PropertyHash.keys) {

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
            }

        }

        End {

        }
    }
