$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
. "$here\$sut"

import-module webadministration

$TestCases = @(
    @{
        TestName = 'All App Pools from one Server'
        ComputerName = 'jeffb-iis03.stratuslivedemo.com'
    }

    @{
        TestName = 'App pools from local server, no computername passed'
        
    }


)

Describe "Get-WebAppPool" {
    context "Input" {
        
    }

    Context "Execution" {
        It "Get application pool object Test : <TestName>" -TestCases $TestCases {
            param
            (
                $ComputerName
            )

            if ( $ComputerName ) 
            {
                # ----- Test if a ComputerName is passed to function
                $Output = Get-WebAppPool -ComputerName $ComputerName -verbose 
            }
            Else
            {
                # ----- Test if no computername is passed
                $Output = Get-WebAppPool -Verbose
            }
        }
    }

    Context "Output" {
        IT "Output Should be Deserialized NodeCollection <TestName>" -TestCases $TestCases {
            $Output | Should BeofType Deserialized.Microsoft.IIs.PowerShell.Framework.NodeCollection
        }
    }

    
}
