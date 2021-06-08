Function Get-IISLog {

<#
    .SYNOPSIS
        Retrieves the IIS Log and turns it into an objec to facilitate searches (and displaying)

    .DESCRIPTION
        Reading IIS logs is a pain as the amount of data, while immense, is not formated very well.  This function turns each entry into an object which can then be furtur processed.

    .PARAMETER Path
        Full path and name to the log file you want to read.

    .EXAMPLE
        Open and read a IIS Log

        $IISLog = Get-IISLog -Path c:\Inetpub\Logs\u_ex210511_x.log 
        $IISLog | FT *

    .LINK
        Modified from: https://social.technet.microsoft.com/Forums/scriptcenter/en-US/46bc6859-d9e3-47c3-b1a6-5132281df18b/howto-use-powershell-to-parse-iis-logs-files
#>

    [CmdletBinding()]
    param (
        [Parameter (Mandatory=$True,Position=0)]
        [String]$Path
    )

    # TODO: ----- find where the IIS logs are located (this could be different depending on website?)

    $LOG = Get-Content $Path | Where-Object { $_ -NotLike "#[D,S-V]*" }

    # ----- Replace unwanted text in the coloums line
    $Columns = (($Log[0].TrimEnd()) -replace "#Fields: ", "" -replace "\(","" -replace "\)","").Split(" ")  #-replace "-",""
    $Count = $Columns.Length

    # Create an instance of a System.Data.DataTable
    $IISLog = New-Object System.Data.DataTable "IISLog"

    # Loop through each Column, create a new column through Data.DataColumn and add it to the DataTable
    foreach ($Column in $Columns) {
        $NewColumn = New-Object System.Data.DataColumn $Column, ([string])
        $IISLog.Columns.Add($NewColumn)
    }

    # Loop Through each Row and add the Rows.
    foreach ($Row in $Log) {
        # ----- Remove periodic Header rows
        if ( $Row | Select-String -Pattern '#Fields:' -NotMatch -Quiet ) {
            $Row = $Row.Split(" ")
            
            $AddRow = $IISLog.newrow()
            for($i=0;$i -lt $Count; $i++) {
                $ColumnName = $Columns[$i]
                $AddRow.$ColumnName = $Row[$i]
            }
            $IISLog.Rows.Add($AddRow)
        }
    }

    Write-Output $IISLog
}