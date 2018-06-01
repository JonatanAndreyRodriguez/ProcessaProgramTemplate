Function Invoke-<%=$PLASTER_PARAM_ProgramName%>{
    <# 
.SYNOPSIS
    <%=$PLASTER_PARAM_ProgramDesc%>
.DESCRIPTION
	<%=$PLASTER_PARAM_ProgramDesc%>
.PARAMETER parameter    
    Indica si se ejecuco o no con parametro
.EXAMPLE 
    Invoke-<%=$PLASTER_PARAM_ProgramName%>
.EXAMPLE
    Invoke-<%=$PLASTER_PARAM_ProgramName%> -parameter
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
    [OutputType([String])]
    Param
    (   
        [Parameter()]         
        [switch]
        $parameter    
    )
    Try{
        $TextOutput = 'Ejecutado sin Parametro'
        if($parameter.IsPresent){
            $TextOutput='Ejecutado con Parametro' 
        }

        $TextOutput | Write-OutputMessage

    }Catch{
        ('Ocurrio un erro durante la ejecucion del proceso ') | Write-OutputMessage
        Throw
    }
    
}