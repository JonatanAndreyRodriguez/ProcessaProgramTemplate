Function Get-Configuration {
    <# 
.SYNOPSIS
    Obtiene la configuracion del modulo cApp
.DESCRIPTION
    Obtiene la configuracion del modulo cApp previamente configurada con la funcion Set-Configuration.
.EXAMPLE
    Get-Configuration
.OUTPUTS
    PSCustomObject TypeName 'Processa.Management.Automation.cApp.Configuration'
.NOTES
    -- ======================================================================================================
    -- Author       : <%=$PLASTER_PARAM_ProgramAuthor%>
    -- Create date  : <%=$PLASTER_Date%>
    -- Gemini       : <%=$PLASTER_PARAM_ProgramGemini%>   
    -- ======================================================================================================
#>
    [CmdletBinding()]
    [OutputType([PSCustomObject])]
    Param
    (
    )
    Try{
        
    $Script:ConfigurationCache = [PSCustomObject] @{
        PSTypeName          =   'Processa.Management.Automation.cApp.Configuration'
        AppConfig           =   $Script:AppConfig
        Configured          =   if((Get-AppSetting -Path $Script:AppConfig -Key 'configured') -eq 1) { $true} else {$false}
        UniqueCardCliente   =   Get-ConnectionString -Path $Script:AppConfig -Name 'SQL:Connection'
    }

    $Script:ConfigurationCache | Write-Output 
    }Catch{
        Throw
    }
    
}