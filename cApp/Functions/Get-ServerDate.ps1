Function Get-ServerDate {
    <# 
.SYNOPSIS
    Obtiene la fecha de un servidor de bd
.DESCRIPTION
    Obtiene la fecha de un servidor de bd segun la conexion establecida en la configuracion
.EXAMPLE
    Get-ServerDate
.OUTPUTS
    PSCustomObject TypeName 'Processa.Management.Automation.cApp.ServerDate'
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
        $Config = Get-Configuration
        $CommandText = Get-Content -Path (Join-Path -Path ([System.IO.Path]::GetDirectoryName($PSScriptRoot)) -ChildPath 'SQLScripts\Get-ServerDate.sql') -Raw 
        
        Invoke-SqlCommand -ConnectionString $Config.UniqueCardCliente -CommandText $CommandText -CommandType Text | ForEach-Object {
            [PSCustomObject] @{
                PSTypeName          =   'Processa.Management.Automation.cApp.ServerDate'
                ServerDate          =   $Psitem.ServerDate
            }
        }
    }Catch{
        Throw
    }
    
}