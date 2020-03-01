function Start-PuttySession {
    <#
        .SYNOPSIS
            Launch putty loading specific Session
        .DESCRIPTION
            Launch putty loading specific Session
        .PARAMETER Name
            Array of Session names to be started
            Can accept from the pipeline
        .EXAMPLE
            Get-MYPuttySession -Name 'krb*' | Start-MYPuttySession
        .EXAMPLE
            Start-MYPuttySession -Name ApacheWeb01
        .NOTES
            Requires 'putty' to be in your path or
            defined as an alias which points to putty
    #>
        [CmdletBinding()]
        Param
        (
            # Param1 help description
            [Parameter(Mandatory=$true,
                       ValueFromPipelineByPropertyName=$true,
                       Position=0)]
            [String[]]$Name
        )

        Begin {
            # if putty command is available, we can just use it
            # if not available, an error will be thrown
            $puttycmd = Get-Command -Name putty -ErrorAction Stop
            Write-Verbose -Message ('{0}' -f $puttycmd)
        }

        Process {
            foreach ($n in $Name) {
                putty -load $n
            }
        }

        End {

        }
    }
