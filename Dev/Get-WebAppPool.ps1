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
        [String[]]$ComputerName = @($env:COMPUTERNAME),

        [String[]]$Name
    )

    Process 
    {
        Foreach ( $C in $ComputerName ) 
        {
            Write-Verbose "Returning Application Pool objects for $C"
            invoke-command -ComputerName $C -ScriptBlock {
                
                Import-Module WebAdministration
                
                # ----- Set Verbose on remote connection if it is set in calling cmdlet: http://stackoverflow.com/questions/16197021/how-to-write-verbose-from-invoke-command
                $VerbosePreference=$Using:VerbosePreference  

                if ( $Using:Name.count -gt 0 ) {
                    Foreach ( $N in $Using:Name ) 
                    {
                        Write-Verbose "Finding $N"
                        write-output (Get-ChildItem IIS:\AppPools\$N)
                    }
                }
                Else {
                    Write-Verbose "Finding All AppPools"
                    Write-Output (Get-ChildItem IIS:\AppPools)
                }
            }
        }
    }
}


#Get-Webapppool -ComputerName jeffb-iis03.stratuslivedemo.com -Name 'Jeffb03' -Verbose | Gm


