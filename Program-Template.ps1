<#
.SYNOPSIS
    <%=$PLASTER_PARAM_ProgramDesc%>
.DESCRIPTION
    <%=$PLASTER_PARAM_ProgramDesc%>
.PARAMETER parameter
	Indica si se envia o no parametro
.EXAMPLE 
    <%=$PLASTER_PARAM_ProgramName%>.ps1 -parameter 'dato'
.EXAMPLE 
	<%=$PLASTER_PARAM_ProgramName%>.ps1
.OUTPUTS
	[PsCustomObject] TypeName 'Processa.Management.Automation.cApp.ServerDate'
.NOTES
    -- ======================================================================================================
    -- Author       : <%=$PLASTER_PARAM_ProgramAuthor%>
    -- Create date  : <%=$PLASTER_Date%>
    -- Gemini       : <%=$PLASTER_PARAM_ProgramGemini%>   
    -- ======================================================================================================
#>
[CmdletBinding()]
Param
(
    [Parameter()]         
    [switch]
    $parameter
)

Try {  
    If (-not $PSScriptRoot) {
        Throw 'Ejecute este script utilizando la consola de Powershell.exe -File RutaDeEsteArchivo.ps1'
    }
    
    #Obtener la ruta y nombre del archivo log
    $LogFileName = Join-Path -Path $PSScriptRoot -ChildPath ('AdminLogs\Program-<%=$PLASTER_PARAM_ProgramName%>.{0:yyyy-MM-dd}.log' -f (Get-Date))
    Start-Transcript -Path $LogFileName -Force -Append

    #Importar archivo de funciones
    Import-Module -Name "$PSScriptRoot\CApp\CApp" -Force
    "Modulo de funciones importado ..." | Write-OutputMessage

    #Importar Modulos
    Import-Module PSProcessa -Force -ErrorAction Stop
    "Modulo PSProcessa importado ..." | Write-OutputMessage
    try{
        if(-not ((cApp\Get-Configuration).configured)){
            throw 
        }
        cApp\Test-Configuration
    }
    catch{
        '===== || Debe realizar la configuracion respectiva antes de continuar utilizando el Script Set-Configuration.ps1 || ====' | Write-Host -ForegroundColor Red -BackgroundColor Black
        return
    }

    if($parameter.IsPresent){
        cApp\Invoke-<%=$PLASTER_PARAM_ProgramName%> -parameter
    }
    if(-not $parameter.IsPresent){
        cApp\Invoke-<%=$PLASTER_PARAM_ProgramName%>
    }
    
    cApp\Get-ServerDate

}
Catch {
    $ErrorInfo = $Error[0]
    '='.PadRight(100, '=') | Out-Default
        [PSCustomObject]@{
            ScriptName   = $ErrorInfo.InvocationInfo.ScriptName
            ErrorMessage = $ErrorInfo.Exception.Message
            LineNumber   = $ErrorInfo.InvocationInfo.ScriptLineNumber
            ColumnNumber = $ErrorInfo.InvocationInfo.OffsetInLine
            Category     = $ErrorInfo.CategoryInfo.Category
            ErrorReason  = $ErrorInfo.CategoryInfo.Reason
            Target       = $ErrorInfo.CategoryInfo.TargetName
            StackTrace   = $ErrorInfo.Exception.StackTrace
        } | Out-Default	
        '='.PadRight(100, '=') | Out-Default
    Throw 
}
Finally {
    Trap {Continue} Stop-Transcript
}



