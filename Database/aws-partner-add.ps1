#--------------------------------------------------------------------
# Adds a Partner and Login to the Security DB
#
# Parameters:
#   server            - SQL server name or IP
#   database          - Database name
#   port              - SQL server port
#   user              - SQL user (sa)
#   password          - SQL password
#   credSecretId - AWS Secret Id for SQL credentials (overrides user and password)
#   PartnerID         - PartnerID to add
#   ShortName         - Company shortname, used for login
#   Description       - Company description
#   EnvironmentSuffix - suffix added to end of database name when
#   UserName          - username for login, email will be set to <username>@thomsonreuters.com
#--------------------------------------------------------------------
param(
    [string]$server = 'localhost\sqlexpress',
		[string]$secondaryServer,
    [Parameter(Mandatory)][string]$database = 'ReportServiceQueue',
    [string]$port,
		[string]$secondaryPort,
    [string]$user = 'sa',
    [string]$password,
    [string]$credSecretId,
    [Parameter(Mandatory)] [int]$PartnerID,
    [Parameter(Mandatory)] [string]$ShortName,
    [Parameter(Mandatory)] [string]$Description,
    [string]$EnvironmentSuffix = '',
    [Parameter(Mandatory)] [string]$UserName = 'first.last',
    [Parameter(Mandatory)] [string]$UserPassword = 'cJRC%Tm^LPN-KT2~',
    [Parameter(Mandatory)] [string]$appCredSecretId,
		[Parameter(Mandatory)] [string]$appCredSecretId2
)

$ErrorActionPreference = 'Stop'

$Script:rootDir = Split-Path $script:MyInvocation.MyCommand.Path

Import-Module -Name 'SqlServer'

[Reflection.Assembly]::LoadWithPartialName("System.Security") | Out-Null

#salt must be 8 bytes minimum
#initVector must be 16 bytes minimum

function Encrypt-String($stringToEncrypt)
{
	# Create a COM Object for RijndaelManaged Cryptography
	$rm = new-Object System.Security.Cryptography.RijndaelManaged
	$rm.Mode = [System.Security.Cryptography.CipherMode]::CBC;
	$rm.Padding = [System.Security.Cryptography.PaddingMode]::PKCS7;
	
	# Get string to encrypt in byte format
	$plainTextBytes = [Text.Encoding]::UTF8.GetBytes($stringToEncrypt)
	
	# Get initialisation vector byte format
	$initVectorBytes = [Text.Encoding]::Unicode.GetBytes("IPSECUR!")
			
	# Starts the Encryption using the Key and Initialisation Vector 
	$c = $rm.CreateEncryptor($initVectorBytes,$initVectorBytes);
	
	# Creates a MemoryStream to do the encryption in
	$ms = new-Object IO.MemoryStream
	
	# Creates the new Cryptology Stream --> Outputs to Memory Stream
	$cs = new-Object Security.Cryptography.CryptoStream $ms,$c,"Write"	
	
	#Writes the string in the Cryptology Stream
    $cs.Write($plainTextBytes, 0, $plainTextBytes.Length);
    $cs.FlushFinalBlock();
    
	#Takes the MemoryStream and puts it to an array
    [byte[]]$cipherTextBytes = $ms.ToArray();  
	
	# Stops the Cryptology Stream
	$cs.Close()
	
	# Stops writing to Memory
	$ms.Close()
	
	# Clears the IV and HASH from memory to prevent memory read attacks
	$rm.Clear()
	
	# Converts the array from Base 64 to a string and returns
	return [Convert]::ToBase64String($cipherTextBytes)
}


function EncryptAES-String($stringToEncrypt, $key = "6F011161-B24E-4363-8E29-C991C8D8F2A4")
{
	# Create a COM Object for RijndaelManaged Cryptography
	$rm = new-Object System.Security.Cryptography.RijndaelManaged
	$rm.Mode = [System.Security.Cryptography.CipherMode]::CBC;
	$rm.Padding = [System.Security.Cryptography.PaddingMode]::PKCS7;
    $rm.KeySize = 256;
	
	# Get string to encrypt in byte format
	$plainTextBytes = [Text.Encoding]::UTF8.GetBytes($stringToEncrypt)
	
	# Get initialisation vector byte format
	$initVectorBytes = [System.Guid]::NewGuid().ToByteArray()
	$keyBytes = [System.Guid]::Parse($key).ToByteArray()
			
	# Starts the Encryption using the Key and Initialisation Vector 
	$c = $rm.CreateEncryptor($keyBytes,$initVectorBytes);
	
	# Creates a MemoryStream to do the encryption in
	$ms = new-Object IO.MemoryStream

    # write IV
    $ms.WriteByte($initVectorBytes.Length);
    $ms.Write($initVectorBytes, 0, $initVectorBytes.Length);
	
	# Creates the new Cryptology Stream --> Outputs to Memory Stream
	$cs = new-Object Security.Cryptography.CryptoStream $ms,$c,"Write"	
	
	#Writes the string in the Cryptology Stream
    $cs.Write($plainTextBytes, 0, $plainTextBytes.Length);
    $cs.FlushFinalBlock();
    
	#Takes the MemoryStream and puts it to an array
    [byte[]]$cipherTextBytes = $ms.ToArray();  
	
	# Stops the Cryptology Stream
	$cs.Close()
	
	# Stops writing to Memory
	$ms.Close()
	
	# Clears the IV and HASH from memory to prevent memory read attacks
	$rm.Clear()
	
	# Converts the array from Base 64 to a string and returns
	return [Convert]::ToBase64String($cipherTextBytes)
}


#--------------------------------------------------------------------
# Main Process
#--------------------------------------------------------------------

if ([String]::IsNullOrEmpty($port)) {
    $serverInstance = $server
}
else {
    $serverInstance = "$server,$port"
}

if ([String]::IsNullOrEmpty($secondaryPort)) {
    $secondaryServerInstance = $secondaryServer
}
else {
    $secondaryServerInstance = "$secondaryServer,$secondaryPort"
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

Write-Host 'Checking if database exists...'

$sql = @"
USE master 
SELECT DB_ID(N'$database') as DbId
"@

$checkDB = Invoke-SqlCmd -ServerInstance $serverInstance -User $user -Password $password -Query $sql 

if ([string]::IsNullOrEmpty($checkDB.DbId)) {
    Write-Host 'Security database does not exist...'
    return 
}

Write-Host "Retrieving credentials for $appCredSecretId from AWS Secrets Manager..."    
$creds = Get-SECSecretValue -SecretId $appCredSecretId | Select-Object -ExpandProperty SecretString | ConvertFrom-Json
$appUser = $creds.UserName
$appPassword = $creds.Password
$appPassword = EncryptAES-String $appPassword

$UserPassword = EncryptAES-string $UserPassword

if ([string]::IsNullOrEmpty($secondaryServerInstance)) {
	$secondaryServerInstance = $serverInstance

	Write-Host "Retrieving credentials for $appCredSecretId2 from AWS Secrets Manager..."    
	$creds = Get-SECSecretValue -SecretId $appCredSecretId2 | Select-Object -ExpandProperty SecretString | ConvertFrom-Json
	$appUser = $creds.UserName
	$appPassword = $creds.Password
	$appPassword = EncryptAES-String $appPassword
}

Write-Host 'Creating Partner...'
$sql = @"
USE $database
declare @PartnerID as int = $PartnerID
declare @ShortName as varchar(80) = '$ShortName'
declare @Description as varchar(80) = '$Description'
declare @ServerName as varchar(80) = '$secondaryServerInstance'
declare @DatabaseName as varchar(80) = 'IP_' + cast(@PartnerID as varchar(30)) + '$EnvironmentSuffix' 
declare @appPassword as varchar(80) = '$appPassword'
declare @appUser as varchar(80) = '$appUser'

declare @UserLogin varchar(80) = '$UserName'
declare @UserPassword varchar(80) = '$UserPassword'
declare @userGUID varchar(36)

declare @cloneFrom int = 1999

select @userGUID = userguid
from tmgUser where userlogin = @UserLogin


if @userGUID is null
begin
  set @userGUID = NEWID()
  INSERT INTO tmgUser(UserGUID,UserLogin,UserFirstName,UserLastName,UserPassword,PasswordSalt,Enabled,EMail,MaxPasswordRetries,CurrentPasswordRetries,DefaultPartnerID,DatePasswordChanged,ForceNextLoginPasswordChange,LastUserLoginDate,DaysToChangePassword,CultureGUID,EffDate,SSOIdType,SSOId,UserCreationMethod,SSOLoginEnabled,UserEffectiveDate,UserExpirationDate,DeletedFlag,KeepDuringRollback)
  select @userGUID,@UserLogin,'root','user',@UserPassword,NEWID(),1,@UserLogin + '@thomsonreuters.com',10,0,-1,'11/13/2019',1,'12/12/2019',-1,'en-US','12/12/2019','None','','','N','1/1/1900','1/1/1900','N','N'
end

INSERT INTO tmgUserPartnerGroup(UserGUID,PartnerID,GroupGUID,EffDate,DeletedFlag,KeepDuringRollback) 
select @userGUID,@PartnerID,'1002',getdate(),'N','N'
where not exists (select top 1 1 from tmgUserPartnerGroup where UserGUID = @userGUID and PartnerID = @PartnerID)

INSERT INTO tmgPartnerDataConnection(PartnerID,PartnerTypeID,ShortName,Description,ServerName,DatabaseName,DatabaseUser,DatabasePassword,EffDate,DeletedFlag,KeepDuringRollback) 
values (@PartnerID,1,@ShortName,@Description,@ServerName,@DatabaseName,@appUser,@appPassword,getdate(),'N','N');

insert into tmgCultures 
select @PartnerID, getdate(), CultureGuid, CultureName, DeletedFlag, KeepDuringRollbackFlag
from tmgCultures
where partnerid = @cloneFrom 
and not exists (select top 1 1 from tmgCultures where PartnerId = @partnerID and CultureGuid = 'en-US')

insert into tmgPartnerCultureDefinitions
select @partnerID, getdate(), CultureGuid, FieldName, FieldTranslation, DeletedFlag, KeepDuringRollback
from tmgPartnerCultureDefinitions c
where PartnerId = @cloneFrom
and not exists (select top 1 1 from tmgPartnerCultureDefinitions where PartnerId = @partnerID and CultureGuid = c.CultureGuid and FieldName = c.FieldName)

insert into tmgMessages
select @partnerID, getdate(), CultureGuid, MessageGUID, Message, DeletedFlag, KeepDuringRollback
from tmgMessages c
where PartnerId = @cloneFrom
and not exists (select top 1 1 from tmgMessages where PartnerId = @partnerID and CultureGuid = c.CultureGuid and MessageGUID = c.MessageGUID)

select PartnerID, ShortName, u.UserLogin, u.EMail
from tmgPartnerDataConnection p
join tmgUser u on u.UserGUID = @userGUID
where p.partnerID = @PartnerID

"@

$out = Invoke-SqlCmd -ServerInstance $serverInstance -User $user -Password $password -Query $sql 
$out