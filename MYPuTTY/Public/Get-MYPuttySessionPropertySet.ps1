function Get-MYPuttySessionPropertySet {
    <#
        .SYNOPSIS
            Get properties associated with a Putty session
        .DESCRIPTION
            Get properties associated with a Putty session.
            All properties or a subset of properties can be returned.
        .PARAMETER Name
            Session Name that properties should belong to
        .PARAMETER Property
            Array of property names whose properties will be returned
        .OUTPUTS
            PSCustomObject with properties of
            PropertyName, PropertyType, PropertyValue
        .EXAMPLE
            Get-MYPuttySessionPropertySet -Name krbExample
        .EXAMPLE
            Get-MYPuttySession -Name *mgt01 | Get-MYPuttySessionPropertySet
        .EXAMPLE
            Get-MYPuttySessionPropertySet -Name krbExample -Property 'TermWidth','TermHeight'

            PropertyName PropertyType PropertyValue
            ------------ ------------ -------------
            TermWidth           Dword            80
            TermHeight          Dword            24
        .NOTES
            Requires Registry module
            Returns PSCustomObject collection
    #>
        [CmdletBinding(DefaultParameterSetName='All')]
        param
        (
            [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true)]
            [System.String]
            $Name,
            [Parameter(Mandatory=$true,ParameterSetName='Subset')]
            [System.String[]]
            $Property
        )

        Begin {
            Write-Verbose -Message ('In Begin Block, Processing ParameterSetName: {0}' -f $PSCmdlet.ParameterSetName)
            $nofilter = $PSCmdlet.ParameterSetName -eq 'All'
            $puttypath = 'HKCU:\Software\SimonTatham\PuTTY\Sessions'

        }

        Process {
            Write-Verbose -Message ('In Process Block, ParameterSetName: {0}' -f $PSCmdlet.ParameterSetName)

            # get the Sessions that are defined in the HKCU hive
            $slist = (Get-Item -Path $puttypath).GetSubKeyNames()
            if ($slist -contains $Name) {
                $subkeypath = Join-Path -Path $puttypath -ChildPath $Name
                # Following gets all property names and types associated with session
                $pi = Get-Item -Path $subkeypath

                # loop through all properties via parallel names,types getting property values
                foreach ($propname in $pi.GetValueNames() ) {
                    $propType = $pi.GetValueKind($propname)
                    $pv = $pi.GetValue($propname)

                    if ($nofilter -or ($Property -contains $propName)) {

                        $objhash = @{
                            PropertyName = $propName
                            PropertyType = $propType
                            PropertyValue = $pv
                        }
                        $obj = New-Object -TypeName PSObject -Property $objhash
                        $obj.PSObject.TypeNames.Insert(0,'DonHunt.Putty.Session.PropertySetItem')
                        Write-Output -InputObject $obj
                    }

                }

            } else {
                Write-Warning -Message ('{0} is an invalid session name' -f $Name)
            }
        }

        End {
            Write-Verbose -Message ('In End Block, ParameterSetName: {0}' -f $PSCmdlet.ParameterSetName)

        }
}
