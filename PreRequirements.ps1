[CmdletBinding(DefaultParameterSetName='AllConnections')]
[OutputType([PSCustomObject])]
    Param
    (
        [Parameter(ParameterSetName='FilterConnection')]
        [Switch]
        $SmtpConnection,

        [Parameter(ParameterSetName='FilterConnection')]
        [Switch]
        $FtpConnection,

        [Parameter(ParameterSetName='FilterConnection')]
        [Switch]
        $PGPKeyStore
    )
    function New-SmtpConnection {
        $CreateSmtpConnection=Read-Host -Prompt ('Desea crear una conexion Smtp? {0} 1 = Si {0} 2 = No {0}' -f [System.Environment]::NewLine)
        switch($CreateSmtpConnection){
            '1' { $Name = Read-Host -Prompt 'Nombre de la conexion a configurar'
                  $SmtpServer = Read-Host -Prompt 'Server al cual se conectara'
                  $Port = Read-Host -Prompt 'Puerto al cual se conectara'
                  Set-SmtpConnection -Name $Name -SmtpServer $SmtpServer -Port $Port -UseSSL $true -Credential (Get-CheckedCredential)
                }
            '2' {}
            default {'Valor invalido'}            
        }
    }
    function New-FtpConnection {
        $CreateFTPConnection=Read-Host -Prompt ('Desea crear una conexion S/FTP? {0} 1 = Si {0} 2 = No {0}' -f [System.Environment]::NewLine)
        switch($CreateFTPConnection){
            '1' { $Name = Read-Host -Prompt 'Nombre de la conexion a configurar'
                  $Hostftp = Read-Host -Prompt 'Host al cual se conectara'
                  $Port = Read-Host -Prompt 'Puerto por el cual se conectara'
                  $FingerPrint = Read-Host -Prompt ('Digite el FingerPrint {0} De no ser enviado se utilizara protocolo FTP' -f [System.Environment]::NewLine)
                    if($FingerPrint){
                        Set-FtpConnection -Name $Name -Host $Hostftp -FingerPrint $FingerPrint -Port $Port -Credential (Get-CheckedCredential)
                    }
                    if(-not $FingerPrint){
                        Set-FtpConnection -Name $Name -Host $Hostftp -Port $Port -Credential (Get-CheckedCredential)
                    }
                }
            '2' {}
            default {'Valor invalido'}            
        }
    }
    function New-PGPKeyStore {
        $CreatePGPConfiguration=Read-Host -Prompt ('Desea crear una configuracion PGP? {0} 1 = Si {0} 2 = No {0}' -f [System.Environment]::NewLine)
        switch($CreatePGPConfiguration){
            '1' { $Name = Read-Host -Prompt 'Nombre de la configuracion de llaves'
                  $PublicKeyPath = Read-Host -Prompt 'Ruta de la llave publica'
                  $PrivateKeyPath = Read-Host -Prompt 'Ruta de la llave privada'
                  $Phrase = Read-Host -Prompt 'Frase de encripcion' -AsSecureString
                  Set-PGPKeyStore -Name $Name -PublicKeyPath $PublicKeyPath -PrivateKeyPath $PrivateKeyPath -Phrase $Phrase -Force
                }
            '2' {}
            default {'Valor invalido'}            
        }
    }
    Import-Module PSProcessa -Force
    if($PSCmdlet.ParameterSetName -eq 'AllConnections'){
        '=========================================================================' | Out-Default
        '       ESTE PROCESO LE MUESTRA LAS LLAVES QUE ACTUALMENTE SE  ' | Write-Host -ForegroundColor Green
        '                ENCUENTRAN CREADAS EN PSPROCESSA.  ' | Write-Host -ForegroundColor Green
        '    SI ES NECESARIO PUEDE CREAR UNAS NUEVAS O ACCEDER POR EL NOMBRE' | Write-Host -ForegroundColor Green
		'                      A CUALQUIERA DE ESTAS' | Write-Host -ForegroundColor Green
        '=========================================================================' | Out-Default
        Start-Sleep -Seconds 5
        '--------------- CONEXIONES DE SMTP ---------------' | Out-Default
        Get-SmtpConnection | Out-Default
        Start-Sleep -Seconds 2
        '{0}--------------- CONEXIONES DE S/FTP ---------------' -f [System.Environment]::NewLine | Out-Default
        Get-FtpConnection | Out-Default
        Start-Sleep -Seconds 2
        '{0}--------------- CONFIGURACIONES DE PGP ---------------' -f [System.Environment]::NewLine | Out-Default
        Get-PGPKeyStore | Out-Default
        Start-Sleep -Seconds 2

        New-SmtpConnection
        Start-Sleep -Seconds 1
        New-FtpConnection
        Start-Sleep -Seconds 1
        New-PGPKeyStore

        
    }

    if($SmtpConnection.IsPresent){
        '--------------- CONEXIONES DE SMTP ---------------' | Out-Default
        Get-SmtpConnection | Out-Default
        New-SmtpConnection
    }
    if($FtpConnection.IsPresent){
        '{0}--------------- CONEXIONES DE S/FTP ---------------' -f [System.Environment]::NewLine | Out-Default
        Get-FtpConnection | Out-Default
        New-FtpConnection
    }
    if($PGPKeyStore.IsPresent){
        '{0}--------------- CONFIGURACIONES DE PGP ---------------' -f [System.Environment]::NewLine | Out-Default
        Get-PGPKeyStore | Out-Default
        New-PGPKeyStore
    }

    