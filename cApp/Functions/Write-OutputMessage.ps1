Function Write-OutputMessage {
    <# 
.SYNOPSIS
    Escribe un mensaje de texto en la salida estandar.
.DESCRIPTION
    Escribe un mensaje de texto en la salida estandar, adicionando la hora minuto y segundo
.PARAMETER Message
    Texto del mensaje.
.EXAMPLE
    'Hola Mundo' | Write-OutputMessage
.EXAMPLE
    Write-OutputMessage -Message 'Hola Mundo'
.OUTPUTS 
    String
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
        [Parameter(Mandatory,ValueFromPipeline)]         
        [ValidateNotNullOrEmpty()]
        [string]
        $Message
    )
    "$(Get-Date -Format 'HH:mm:ss') => $Message" | Out-Default
}