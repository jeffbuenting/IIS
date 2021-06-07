Function Get-IISLog {

<#
    .SYNOPSIS
        Retrieves the IIS Log and turns it into an objec to facilitate searches (and displaying)
#>

    [CmdletBinding()]
    param (
        [Parameter (Mandatory=$True,Position=0)]
        [String]$Path
    )

    

}