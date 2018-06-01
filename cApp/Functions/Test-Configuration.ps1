function Test-Configuration {
    <#
.SYNOPSIS
    Verifica la información de los datos de configuración del módulo.
.DESCRIPTION
    Verifica la información de los datos de configuración del módulo, Segun la configuracion establecida por el Set-Configuration.
.PARAMETER SaveFlag
    Indica si se debe crear la llave configured en el archivo de configuracion.
.EXAMPLE
    Test-Configuration
.EXAMPLE
    Test-Configuration -SaveFlag
.OUTPUTS
    No genera ningun tipo de salida                
.NOTES
    -- ======================================================================================================
    -- Author       : <%=$PLASTER_PARAM_ProgramAuthor%>
    -- Create date  : <%=$PLASTER_Date%>
    -- Gemini       : <%=$PLASTER_PARAM_ProgramGemini%>   
    -- ======================================================================================================
                
  #>
    [CmdletBinding()]
    [OutputType([System.Void])]
    Param
    (
        [switch]
        $SaveFlag
    )
    try {
        $MessageFormat = "[INFO] => {0}"

        $Config = Get-Configuration

        if(-not (Test-SqlConnection -ConnectionString $config.UniqueCardCliente)){
            throw 'No se logro realizar la conexion a la base de datos.'
        }

            
        if ($SaveFlag.IsPresent) {
            Remove-AppSetting -Path $Script:AppConfig -Key 'configured' -ErrorAction SilentlyContinue
            Set-AppSetting -Path $Script:AppConfig -Key 'configured' -Value '1'
        }
    }
    catch {
        Remove-AppSetting -Path $Script:AppConfig -Key 'configured'
        throw
    }
}