<#
.SYNOPSIS
    Realiza el proceso de configuracion para la ejecucion del program Program-<%=$PLASTER_PARAM_ProgramName%>.ps1
.DESCRIPTION
    Realiza el proceso de configuracion para la ejecucion del program Program-<%=$PLASTER_PARAM_ProgramName%>.ps1
.EXAMPLE 
    Set-Configuration.ps1
.OUTPUTS 
	No retorna ningun Valor
.NOTES
    -- ======================================================================================================
    -- Author       : <%=$PLASTER_PARAM_ProgramAuthor%>
    -- Create date  : <%=$PLASTER_Date%>
    -- Gemini       : <%=$PLASTER_PARAM_ProgramGemini%>    
    -- ======================================================================================================
#>
[CmdletBinding()]
Param
()

Try {  
    If (-not $PSScriptRoot) {
        Throw 'Ejecute este script utilizando la consola de Powershell.exe -File RutaDeEsteArchivo.ps1'
    }
    Import-Module -Name "$PSScriptRoot\CApp\CApp" -Force
    cApp\Set-Configuration 
    
}
Catch{
    throw
}