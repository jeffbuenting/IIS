$PortalServer = 'rwva-custdevwgp'

$WGPRootPath = "c:\inetpub\wwwroot"

invoke-command -ComputerName $PortalServer -ArgumentList $WGPRootPath -ScriptBlock {
    
    Param(
        $WGPRootPath
    )

    # ----- Get WGP Web sites that are not deployment hosts
    $WGPSites = Get-Website #| where name -NotLike '*deploy*'
    $WGPSites | ft Name
    #foreach ( $S in $WGPSites ) {
    #    # ----- Skip Redict sites
    #    if ( $S.Name -NotLike "*Redirect*" ) {
    #        if ( "$($S.Name) Redirect" -NotIn $WGPSites.Name ) {
    #            Write-Host "$($S.Name) needs redirect"
    #           
    #        }
    #    }
   #}     
}