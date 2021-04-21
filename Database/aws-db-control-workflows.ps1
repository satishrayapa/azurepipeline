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
    [ValidateSet('on','off', '')]
    [String]$schedule,    
    [ValidateSet('on','off', '')]
    [String]$allowedToRun,
    [switch]$finishInProgress,
    [string]$partnerID,
    [int]$sleepSeconds1 = 5,
    [int]$sleepSeconds2 = 15
)

$ErrorActionPreference = 'Stop'

if($finishInProgress -and $allowedToRun -ne "off"){
    Write-Host "finishInProgress can only be used with allowdToRun off"
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

#--------------------------------------------------------------------
# Main Process
#--------------------------------------------------------------------

Write-Host 'Getting partners...'
$sql = 'SELECT PartnerID, ServerName, DatabaseName, DatabaseUser, DatabasePassword FROM dbo.tmgPartnerDataConnection'

if($partnerID){
    $sql += " where partnerID = $partnerID"
}

$partners = Invoke-SqlCmd -ServerInstance $serverInstance -Database $database -User $user -Password $password -Query $sql

$status = @{}

foreach ($partner in $partners) {

    Write-Host "Processing partner $($partner.PartnerID)..."
    $pass = DecryptAES-String $partner.DatabasePassword

    try{

        if ($schedule){
            if($schedule -eq "off"){
                Write-Host -NoNewline "Workflow Schedule - off"
                $sql = "update tlgWorkflowSchedule set partnerID = partnerID * -1 where partnerID = $($partner.PartnerID); select @@Rowcount"
                $c = Invoke-SqlCmd -ServerInstance $partner.ServerName -Database $partner.DatabaseName -User $partner.DatabaseUser -Password $pass -Query $sql
                Write-Host " ($($c.Column1) updated)"
            }
            if($schedule -eq "on"){
                Write-Host -NoNewline "Workflow Schedule - on"
                $sql = "update tlgWorkflowSchedule set partnerID = partnerID * -1 where partnerID = -$($partner.PartnerID); select @@Rowcount"
                $c = Invoke-SqlCmd -ServerInstance $partner.ServerName -Database $partner.DatabaseName -User $partner.DatabaseUser -Password $pass -Query $sql
                Write-Host " ($($c.Column1) updated)"
            }
        }

        if ($allowedToRun){
            if($allowedToRun -eq "off"){
                Write-Host -NoNewline "Workflow Allowed to Run - off"
                $sql = "update tlgServerApplicationsAllowedToRun set serverName = '-' + serverName where servername not like '-%' and servername <> ''; select @@Rowcount"
                $c = Invoke-SqlCmd -ServerInstance $partner.ServerName -Database $partner.DatabaseName -User $partner.DatabaseUser -Password $pass -Query $sql
                Write-Host " ($($c.Column1) updated)"
            }
            if($allowedToRun -eq "on"){
                Write-Host -NoNewline "Workflow Allowed to Run - on"
                $sql = "update tlgServerApplicationsAllowedToRun set serverName = right(servername, len(servername)-1) where servername like '-%'; select @@Rowcount"
                $c = Invoke-SqlCmd -ServerInstance $partner.ServerName -Database $partner.DatabaseName -User $partner.DatabaseUser -Password $pass -Query $sql
                $c1 = $c.Column1
                $sql = "update tlgApplicationLaunchStatus set serverName = right(servername, len(servername)-1) where servername like '-%' and partnerID = $($partner.PartnerID); select @@Rowcount"
                $c = Invoke-SqlCmd -ServerInstance $partner.ServerName -Database $partner.DatabaseName -User $partner.DatabaseUser -Password $pass -Query $sql
                Write-Host " ($c1 + $($c.Column1) updated)"
            }
        }


        #get the status of this partner (how many running or launching workflows are there?)
        $sql = "declare @pending as varchar(max)
            declare @froze as varchar(max)

            select @pending = COALESCE(@pending + ',', '') + workflow  
            from (
                select distinct workflow from tlgApplicationLaunchStatus where status in ('LAUNCH', 'RUNNING') and servername not like '-%' and servername <> '' and partnerID = $($partner.PartnerID) 
                ) a 

            select @froze = COALESCE(@froze + ',', '') + workflow  
            from (
                select distinct workflow from tlgApplicationLaunchStatus where status in ('LAUNCH', 'RUNNING') and servername like '-%' and servername <> '' and partnerID = $($partner.PartnerID) 
                ) a 

            select isnull(sum(case when status = 'LAUNCH' and servername not like '-%' and servername <> '' then 1 else 0 end),0) launch,
              isnull(sum(case when status = 'LAUNCH' and servername like '-%' and servername <> '' then 1 else 0 end),0) frozen,  
              isnull(sum(case when status = 'RUNNING' then 1 else 0 end),0) running, 
              isnull(sum(case when status = 'COMPLETE' then 1 else 0 end),0) complete, 
              isnull(sum(case when status not in ('LAUNCH', 'RUNNING', 'COMPLETE') then 1 else 0 end),0) other,
              @pending pendingWorkflows, @froze frozenWorkflows
            from tlgApplicationLaunchStatus where partnerID = $($partner.PartnerID)"
        $c = Invoke-SqlCmd -ServerInstance $partner.ServerName -Database $partner.DatabaseName -User $partner.DatabaseUser -Password $pass -Query $sql
        $rec = ($c | Select-Object launch, frozen, running, complete, other, pendingWorkflows, frozenWorkflows, @{N="pending"; E={$true}} -First 1)
        $rec.pending = ($rec.launch + $rec.running -gt 0)
        $status.Add($partner.PartnerID, $rec)
    }
    catch {
        Write-Warning $Error[0]
    }
}

$str = $status | Out-String
Write-host $str
$p = @($status.GetEnumerator() | Where-Object {$_.Value.pending -eq $true}).Count
$l = @($status.GetEnumerator() | Where-Object {$_.Value.launch -gt 0}).Count
$f = @($status.GetEnumerator() | Where-Object {$_.Value.frozen -gt 0}).Count
$r = @($status.GetEnumerator() | Where-Object {$_.Value.running -gt 0}).Count
Write-Host "There are $p partners with running ($r) or launching ($l) workflows. There are $f frozen partners."

$anyChanged = $true
$oneMore = $true

if($finishInProgress -and $allowedToRun -eq "off"){
    Write-host ""
    Write-host "Finishing any in progress workflows"
    While ($anyChanged -or $oneMore){
        if(-not $anyChanged -and $oneMore){
            $oneMore = $false
            $f = 1
        }
        $anyChanged = $false
        While ($f + $r + $l -gt 0){
            foreach ($partner in $partners) {
                $pass = DecryptAES-String $partner.DatabasePassword
                $rec = $status[$partner.PartnerID]
                if($rec.frozen -gt 0 -or $rec.running -gt 0 -or $rec.launch -gt 0 -or (-not $oneMore)) #if this is the last time check everyone
                {
                    #get the status of this partner (how many running or launching workflows are there?)
                    $sql = "declare @pending as varchar(max)
                        declare @froze as varchar(max)

                        select @pending = COALESCE(@pending + ',', '') + workflow  
                        from (
                            select distinct workflow from tlgApplicationLaunchStatus where status in ('LAUNCH', 'RUNNING') and servername not like '-%' and servername <> '' and partnerID = $($partner.PartnerID) 
                            ) a 

                        select @froze = COALESCE(@froze + ',', '') + workflow  
                        from (
                            select distinct workflow from tlgApplicationLaunchStatus where status in ('LAUNCH', 'RUNNING') and servername like '-%' and servername <> '' and partnerID = $($partner.PartnerID) 
                            ) a 

                        select isnull(sum(case when status = 'LAUNCH' and servername not like '-%' and servername <> '' then 1 else 0 end),0) launch,
                          isnull(sum(case when status = 'LAUNCH' and servername like '-%' and servername <> '' and SequenceNo > 1 then 1 else 0 end),0) frozen,  
                          isnull(sum(case when status = 'RUNNING' then 1 else 0 end),0) running, 
                          isnull(sum(case when status = 'COMPLETE' then 1 else 0 end),0) complete, 
                          isnull(sum(case when status not in ('LAUNCH', 'RUNNING', 'COMPLETE') then 1 else 0 end),0) other,
                          @pending pendingWorkflows, @froze frozenWorkflows
                        from tlgApplicationLaunchStatus where partnerID = $($partner.PartnerID)"
                    $c = Invoke-SqlCmd -ServerInstance $partner.ServerName -Database $partner.DatabaseName -User $partner.DatabaseUser -Password $pass -Query $sql
                    $rec = ($c | Select-Object launch, frozen, running, complete, other, pendingWorkflows, frozenWorkflows, @{N="pending"; E={$true}} -First 1)
                    $rec.pending = ($rec.launch + $rec.running -gt 0)
                    $status[$partner.PartnerID] = $rec

                    Write-host -NoNewline "Partner $($partner.PartnerID)"
                    $sql = "update tlgApplicationLaunchStatus set serverName = right(servername, len(servername)-1) where servername like '-%' and sequenceNo > 1 and partnerID = $($partner.PartnerID); select @@Rowcount"
                    $c = Invoke-SqlCmd -ServerInstance $partner.ServerName -Database $partner.DatabaseName -User $partner.DatabaseUser -Password $pass -Query $sql
                    Write-Host " ($($c.Column1) updated)"
                    if($c.Column1 -gt 0) { 
                        $anyChanged = $true
                        $rec = $status[$partner.PartnerID]
                        if($rec.running -eq 0) {
                            $rec.running = 1 #should be at least one now
                            $status[$partner.PartnerID] = $rec
                        }
                    }
                }
            }
            $p = @($status.GetEnumerator() | Where-Object {$_.Value.pending -eq $true}).Count
            $l = @($status.GetEnumerator() | Where-Object {$_.Value.launch -gt 0}).Count
            $f = @($status.GetEnumerator() | Where-Object {$_.Value.frozen -gt 0}).Count
            $r = @($status.GetEnumerator() | Where-Object {$_.Value.running -gt 0}).Count
            Write-Host "There are $p partners with running ($r) or launching ($l) workflows. There are $f frozen partners. anyChanged=$anyChanged, oneMore=$oneMore"
            
            if($anyChanged -or ($f + $r + $l) -gt 0){
                Write-host "sleeping short to give workflow time. anyChanged=$anyChanged, oneMore=$oneMore"
                Start-Sleep -Seconds $sleepSeconds1
            }
        }
        if($anyChanged){
            $oneMore = $true
        }
        if($anyChanged -or $oneMore)
        {
            #sleep to give launcher time to insert new records after last ones complete
            Write-host "sleeping to give workflow time. anyChanged=$anyChanged, oneMore=$oneMore"
            Start-Sleep -Seconds $sleepSeconds2
        }
    }
}