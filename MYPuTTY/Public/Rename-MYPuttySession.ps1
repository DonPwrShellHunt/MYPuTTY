function Rename-MYPuttySession {
    <#
        .SYNOPSIS
           Rename a Putty Session
        .DESCRIPTION
           Rename a Putty Session
        .PARAMETER Name
           Name of Putty session to rename
           Must match exactly, including case
        .PARAMETER NewName
           New Name of Putty session
           Validates NewName is composed of letters, numbers,
           and underscore characters only.
        .EXAMPLE
           Rename-MYPuttySession -Name CentMagenta -NewName TemplateMagenta
    #>
        [CmdletBinding(SupportsShouldProcess=$true)]
        Param
        (
            [Parameter(Mandatory=$true,
                       Position=0)]
            [String]$Name,

            [Parameter(Mandatory=$true,
                       Position=1)]
            [ValidatePattern('^[\w]*$')]
            [String]$NewName
        )

        Begin {
            $SessionsDir = 'HKCU:\Software\SimonTatham\PuTTY\Sessions'

            $sessionNames = (Get-ChildItem -Path $SessionsDir).PSChildName
            # Do not clobber existing session on rename operation
            if ($sessionNames -contains $NewName) {
                Write-Warning -Message ('Session: {0} already exists.' -f $NewName)
                Return
            }

            $matchedSessions = @(Get-Item -Path "$SessionsDir\*" -Include $Name)
            if ($matchedSessions.Count -ne 1) {
                Write-Error -Message ('{0} does not uniquely identify session!' -f $Name)
            } else {
                $msg = ('{0} --> {1}' -f $Name,$NewName)
                if ($PSCmdlet.ShouldProcess($msg)) {
                    Rename-Item -Path $matchedSessions[0].PSPath -NewName $NewName
                }
            }
        }

        Process {

        }

        End {

        }
    }
