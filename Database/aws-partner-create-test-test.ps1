#--------------------------------------------------------------------
# Creates and / or Migrates all partners DBs defined in Security DB
#
# Parameters:
#   server       - SQL server name or IP (Security DB)
#   database     - Database name (Security DB)
#   port         - SQL server port (Security DB)
#   user         - SQL user (sa) (Security DB)
#   password     - SQL password (Security DB)
#   credSecretId - AWS Secret Id for SQL credentials (overrides user and password)
#   sqlPath      - Relative path to SQL scripts home folder for Partner DB
#   partnerId    - If specified, migrates this partner only
#   baseVer      - Baseline version to use if DB exist, not empty,
#                  and has no flyway_schema_history table.
#                  If this parameter is not specified then migration step
#                  is ignored.
#   repair       - Repairs flyway schema history table
#--------------------------------------------------------------------
param(
    [string]$server = 'localhost\sqlexpress',
    [Parameter(Mandatory)][string]$database = 'SEC',
    [string]$port,
    [string]$user = 'sa',
    [string]$password,
    [string]$credSecretId,
    [string]$secondaryCredSecretId,
    [Parameter(Mandatory)] [string]$sqlPath,
    [string]$partnerId,
    [string]$baseVer,
    [switch]$repair,
    [switch]$outoforder,
    [switch]$newPartner,
    [ValidateSet('MSSQL','PostgreSQL', '')]
    [string]$EngineType = ''
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
$sql = 'SELECT PartnerID, ServerName, DatabaseName, DatabaseUser, DatabasePassword, EngineType FROM dbo.tmgPartnerDataConnection'

if (-not [string]::IsNullOrEmpty($partnerId)) {
    $sql += " WHERE PartnerID = $partnerId"
    if (-not [string]::IsNullOrEmpty($EngineType)) {
        $sql += " AND EngineType = '$EngineType'"
    }
}
else
{
    if (-not [string]::IsNullOrEmpty($EngineType)) {
        $sql += " WHERE EngineType = '$EngineType'"
    }
}

$partners = Invoke-SqlCmd -ServerInstance $serverInstance -Database $database -User $user -Password $password -Query $sql
Write-Host $partners
[System.Collections.ArrayList]$arr=@()
foreach ($partner in $partners) {
    $arr.Add($($partner.PartnerID))
    Write-Host "Processing partner $($partner.PartnerID)..."
}
$partids = $arr -join ', '
$partids
$name = "tr"
#Write-Host "##vso[task.setvariable variable=mypartids;]$partids"
Write-Host "##vso[task.setvariable variable=mypartids;isOutput=true]$name"
#Write-Host "##vso[task.setvariable variable=testvar;]testvalue"
#echo "##vso[task.setvariable variable=MYPARTIDS]$partids"
Write-Host "================"
#Write-Host "$(MYPARTIDS)"
#Write-Host "MY VARIABLE IS $env:MYPARTIDS"
#Write-Host " some $MYPARTIDS"
#Write-Host " so $partids"
#$env:MYPARTIDS

Write-Host "================"
