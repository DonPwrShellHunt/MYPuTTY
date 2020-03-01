function New-MYPuttySession {
    [CmdletBinding(SupportsShouldProcess=$true)]
    Param
    (
        # Name of new putty session
        [Parameter(Mandatory=$true,
                   Position=0)]
        [String]$Name,

        # HostName that putty session will connect to
        [Parameter(Mandatory=$true,
                   Position=1)]
        [String]$HostName,

        # Template session name used as basis for new one
        [Parameter(Mandatory=$true,
                   Position=2)]
        [String]$Template,

        # Title is WindowTitle content in session
        [Parameter(Mandatory=$false)]
        [String]$WinTitle=''
    )

    Begin {
        $SessionsDir = 'HKCU:\Software\SimonTatham\PuTTY\Sessions'

        $sessionNames = (Get-ChildItem -Path $SessionsDir).PSChildName

        if ($sessionNames -contains $Name) {
            Write-Warning -Message ('Session: {0} already exists.' -f $Name)
            Return
        }

        if ($sessionNames -notcontains $Template) {
            Write-Warning -Message ('Template: {0} does not exist.' -f $Template)
            Return
        }

        $srcSession = Get-Item -Path "$SessionsDir\$Template"
        $newSessionPath = "$SessionsDir\$Name"

        Write-Verbose -Message $srcSession.PSPath
        Write-Verbose -Message $newSessionPath

        if ($PSCmdlet.ShouldProcess($Name)) {
            Copy-Item -LiteralPath $srcSession.PSPath -Destination $newSessionPath
            Set-ItemProperty -Path $newSessionPath -Name HostName -Value $HostName
            Set-ItemProperty -Path $newSessionPath -Name WinTitle -Value $WinTitle
        }
    }

    End {

    }
}
