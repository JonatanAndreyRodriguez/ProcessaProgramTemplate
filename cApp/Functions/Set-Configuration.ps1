Function Set-Configuration {
    <# 
.SYNOPSIS
    realiza la configuracion del modulo cApp
.DESCRIPTION
    realiza la configuracion del modulo cApp segun los parametros de configuracion para el funcionamiento requerido.
.EXAMPLE
    Set-Configuration
.OUTPUTS
    String indicando que fue satisfactorio.
.NOTES
    -- ======================================================================================================
    -- Author       : <%=$PLASTER_PARAM_ProgramAuthor%>
    -- Create date  : <%=$PLASTER_Date%>
    -- Gemini       : <%=$PLASTER_PARAM_ProgramGemini%>      
    -- ======================================================================================================
#>
    [CmdletBinding()]
    [OutputType([void])]
    Param
    (
    )
    try {
        $InformationAction = $PSBoundParameters | Get-DictionaryKey -Key 'InformationAction' -DefaultValue 'Continue'
        $ConfigInfo = @(
	    New-ConfigurationItem -Type 'ConnectionString' -ConfigKey 'SQL:Connection' -FriendlyName 'UniqueCardCliente' -DataType String -Description 'Cadena de conexion a la base de datos UniqueCardCliente en caso de utilizar autenticacion integrada reemplazar User Id=Usuario;Password=contraseña; por Integrated Security=True;' 
            New-ConfigurationItem -Type 'AppSetting' -ConfigKey 'TestValue' -FriendlyName 'TestValue' -DataType String -Description ('Description TestValue') -Category 'Configuraciones generales'
        )
        
        if (Set-ConfigurationFile -Path $Script:AppConfig -ConfigurationInfo $ConfigInfo) {
            Write-Information -MessageData 'Starting testing phase...' -InformationAction $InformationAction
            $Script:ConfigurationCache = $null
            Test-Configuration -SaveFlag
			'Configuration saved' | Write-Verbose		
        }
    }
    catch {
        throw
    }
    finally {
        $Script:ConfigurationCache = $null
    }
    
}