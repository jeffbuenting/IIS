# ----- Get the module name
if ( -Not $PSScriptRoot ) { $PSScriptRoot = Split-Path $MyInvocation.MyCommand.Path -Parent }

$ModulePath = $PSScriptRoot.substring(0,$PSScriptRoot.LastIndexOf('\'))

$FunctionName = $MyInvocation.MyCommand.Name -Replace '\.Tests\.ps1',''

# ----- Dot source Function
. $ModulePath\Functions\$FunctionName.ps1

#-------------------------------------------------------------------------------------

Describe "$FunctionName" {
    

    It 'Should return an IIS Log Object.' {
        Get-IISLog | Should -BeOfType  [System.Data.DataRow]
    }

}