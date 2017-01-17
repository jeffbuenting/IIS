function Get-WebAppPool 
{

    <#
        .Synopsys 
            Returns a list of Application Pool Objects

        .Parameter ComputerName
            Web Server Name

        .Parameter Name
            Name of the application pool to retrieve.  If this is blank it will retun all application pools

        .Output
            PSCustom Object
    #>

    [CmdletBinding()]
    Param
    (
        [Parameter ( ValueFromPipeLine = $True ) ]
        [String[]]$ComputerName = $env:COMPUTERNAME,

        [String[]]$Name
    )

    Process 
    {
        Foreach ( $C in $ComputerName ) 
        {
            Write-Verbose "Returning Application Pool objects for $C"
            Get-ChildItem IIS:\AppPools
        }
    }
}
