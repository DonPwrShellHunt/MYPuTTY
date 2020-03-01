function Remove-MYPuttySession {
    <#
        .SYNOPSIS
           Removes a named Putty Session
        .DESCRIPTION
           Removes a named Putty Session
        .PARAMETER Name
           Wildcard string to specify which session to remove
        .EXAMPLE
           Remove-MYPuttySession -Name CentMagenta
        .EXAMPLE
           Get-MYPuttySession -Name 'z_*' | Remove-MYPuttySession
        .EXAMPLE
           Remove-MYPuttySession -Name 'kHost1','kHost2' -WhatIf
    #>
        [CmdletBinding(SupportsShouldProcess=$true)]
        Param
        (
            # Name of session to remove
            [Parameter(Mandatory=$true,
                       ValueFromPipelineByPropertyName=$true,
                       Position=0)]
            [String[]]$Name
        )

        Begin {
            $SessionsDir = 'HKCU:\Software\SimonTatham\PuTTY\Sessions'
        }

        Process {
            foreach ($n in $Name) {
                $matchedSessions = @(Get-Item -Path "$SessionsDir\*" -Include $n)
                foreach ($ms in $matchedSessions) {
                    $msg = 'Session: {0}' -f $ms.PSChildName
                    if ($PSCmdlet.ShouldProcess($msg)) {
                        Remove-Item -Path $ms.PSPath
                        Write-Verbose -Message "Removed Putty $msg"
                    }
                }
            }
        }

        End {

        }
    }
