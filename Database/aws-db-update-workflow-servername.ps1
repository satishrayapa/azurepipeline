#--------------------------------------------------------------------
# Freezes scheduled workflows by setting partnerID = -partnerID.
# Changes serverName that is allowed to run a workflow step so workflow is frozen.
# Reports overall status of how many partners have workflows running/pending vs how many are frozen. Once all
# workflows are frozen it is safe to upgrade the app server role.
#
# Note: This should not be used if there are changes to workflow steps (code or order of worklow steps) as
#       it could result in unpredictable results (data loss/corruption). If there are workflow changes don't use
#       the allowedToRun parameter and allow all in-progress workflows to finish using the finishInProgress param.
#
# Parameters:
#   server           - SQL server name or IP (Security DB)
#   database         - Database name (Security DB)
#   port             - SQL server port (Security DB)
#   user             - SQL user (sa) (Security DB)
#   password         - SQL password (Security DB)
#   credSecretId     - AWS Secret Id for SQL credentials (overrides user and password)
#   schedule         - when set to off it will change partnerID in tlgWorkflowSchedule to -partnerID
#                    - when set to on it will remove the - prefix
#   allowedToRun     - when set to off it will change serverName in tlgServerApplicationsAllowedToRun to -serverName
#                    - when set to on it will remove the - prefix (tlgApplicationLaunchStatus is also updated if needed so new records there will run)
#   finishInProgress - when specified with allowedToRun=off this will run in a loop and let in-progress workflows finish, but new ones will not start
#   partnerId        - If specified, migrates this partner only
#--------------------------------------------------------------------
param(
    [string]$server = 'localhost\sqlexpress',
    [Parameter(Mandatory)][string]$database = 'SEC',
    [string]$port,
    [string]$user = 'sa',
    [string]$password,
    [string]$credSecretId,    
    [String]$wfServerName,   
    [string]$partnerID
)

$ErrorActionPreference = 'Stop'

$rootDir = Split-Path $script:MyInvocation.MyCommand.Path

Import-Module -Name 'SqlServer'

if ([String]::IsNullOrEmpty($port)) {
    $serverInstance = $server
}
else {
    $serverInstance = "$server,$port"
}

Write-Host "Server: $serverInstance"
Write-Host "Database: $database"
Write-Host "Scripts Directory: $sqlRootDir"

if (-not [String]::IsNullOrEmpty($credSecretId)) {
    Write-Host "Retrieving credentials for $credSecretId from AWS Secrets Manager..."    
    $creds = Get-SECSecretValue -SecretId $credSecretId | Select-Object -ExpandProperty SecretString | ConvertFrom-Json
    $user = $creds.UserName
    $password = $creds.Password
}

function DecryptAES-String($stringToDecrypt, $key = "6F011161-B24E-4363-8E29-C991C8D8F2A4")
{
    # Create a COM Object for RijndaelManaged Cryptography
    $rm = new-Object System.Security.Cryptography.RijndaelManaged
    $rm.Mode = [System.Security.Cryptography.CipherMode]::CBC;
    $rm.Padding = [System.Security.Cryptography.PaddingMode]::PKCS7;
    $rm.KeySize = 256;

    $b = [Convert]::FromBase64String($stringToDecrypt)
    $ms = new-Object IO.MemoryStream @(,$b)
    [int]$ivLength = $ms.ReadByte()
    [byte[]]$iv = [System.Byte[]]::CreateInstance([System.Byte],$ivLength)
    $i = $ms.Read($iv, 0, $ivLength)
    
    # Get string to encrypt in byte format
    $cipherTextBytes = [Text.Encoding]::UTF8.GetBytes($stringToDecrypt)
    
    # Get initialisation vector byte format
    $keyBytes = [System.Guid]::Parse($key).ToByteArray()
            
    # Starts the Encryption using the Key and Initialisation Vector 
    $d = $rm.CreateDecryptor($keyBytes,$iv)
    
    # Read the new memory stream and read it in the cryptology stream
    $cs = new-Object Security.Cryptography.CryptoStream $ms,$d,"Read"

    $decryptedByteCount = 0;
    
    [byte[]]$res = [System.Byte[]]::CreateInstance([System.Byte],$b.Length - $ivLength - 1)
    $decryptedByteCount = $cs.Read($res, 0, $res.Length);
    $cs.Close();
    
    # Stops the cryptology stream
    $cs.Close()

    # Stops the memory stream
    $ms.Close()

    # Clears the RijndaelManaged Cryptology IV and Key
    $rm.Clear()    
    
    return [Text.Encoding]::UTF8.GetString($res, 0, $decryptedByteCount).TrimEnd([char]0x0000); 
}

#--------------------------------------------------------------------
# Main Process
#--------------------------------------------------------------------

Write-Host 'Getting partners...'
$sql = 'SELECT PartnerID, ServerName, DatabaseName, DatabaseUser, DatabasePassword FROM dbo.tmgPartnerDataConnection'

if($partnerID){
    $sql += " where partnerID = $partnerID"
}

$partners = Invoke-SqlCmd -ServerInstance $serverInstance -Database $database -User $user -Password $password -Query $sql

foreach ($partner in $partners) {

    Write-Host "Processing partner $($partner.PartnerID)..."

    try{
        $pass = DecryptAES-String $partner.DatabasePassword

        #get the status of this partner (how many running or launching workflows are there?)
        $sql = "declare @wfServerName as varchar(100) = '$wfServerName'

            update tlgServerApplicationsAllowedToRun set serverName = @wfServerName

            update tlgApplicationLaunchStatus set serverName = @wfServerName
            where partnerID = $($partner.PartnerID)
            
            select @@Rowcount"
        $c = Invoke-SqlCmd -ServerInstance $partner.ServerName -Database $partner.DatabaseName -User $partner.DatabaseUser -Password $pass -Query $sql
        Write-Host "ServerName update for $($partner.PartnerID)."
    }
    catch {
        Write-Error $Error[0]
    }
}
