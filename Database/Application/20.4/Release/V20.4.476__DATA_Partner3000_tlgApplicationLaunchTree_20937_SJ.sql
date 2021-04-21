declare @baselinePartner as int = 3000

-------------------boiler plate tests to determine if this is for baseline, do not change-----------------------
declare @isBaseline as bit = 0
declare @isBaselineTemp as varchar(30) = '${isBaseline}' --flyway will pass in for AWS when creating a new partner database

if not @isBaselineTemp = '$' + '{isBaseline}' and not @isBaselineTemp = '0' --either flyway passes 1 or we fallback to on-prem way of looking for 3000
	set @isBaseline = @isBaselineTemp
else
begin
	--on-prem we create new partners from 3000 so lets check for that

    --if there is only one defaults record and it is for 3000
    if exists (select TOP 1 1 from sys.tables where Name = 'tmfDefaults' AND Type = 'U') 
            exec sp_executesql N'select @isBaseline = count(*) from tmfDefaults where partnerID = @base and not exists (select top 1 1 from tmfDefaults where partnerID <> @base)', 
                    N'@isBaseline int output, @base int', @isBaseline output, @base = @baselinePartner;
       
    --based on db_name (ie IP_3000 or IP_3000_REG)
    if @isBaseline = 0
            select @isBaseline = case when DB_NAME() like '%[_]' + cast(@baselinePartner as varchar(10)) or DB_NAME() like '%[_]'+ cast(@baselinePartner as varchar(10)) +'[_]%' then 1 else 0 end
       
    --if there is only one security record and it is for 3000
    if @isBaseline = 0 and exists (select TOP 1 1 from sys.tables where Name = 'tmgPartnerDataConnection' AND Type = 'U') 
            exec sp_executesql N'select @isBaseline = count(*) from tmgPartnerDataConnection where partnerID = @base and not exists (select top 1 1 from tmgPartnerDataConnection where partnerID <> @base)', 
                    N'@isBaseline int output, @base int', @isBaseline output, @base = @baselinePartner;
end
-------------------boiler plate tests to determine if this is for baseline, do not change-----------------------


IF @isBaseline = 1
BEGIN

IF NOT EXISTS (
		SELECT TOP 1 1
		FROM tlgapplicationlaunchtree
		WHERE WorkFlow = 'STANDARD COMPANY PARTNERS INTERFACE'
			AND Command = 'MAP SCREENING PROFILE TO COMPANY'
		)
BEGIN


UPDATE tlgApplicationLaunchTree set Command='STANDARD COMPANY PARTNERS INTERFACE' where WORKFLOW like 'STANDARD COMPANY PARTNERS INTERFACE' AND ApplicationToLaunch ='dxdIntegrationDataImport.dll' AND SequenceNo=2 AND PartnerID=3000

UPDATE tlgApplicationLaunchTree set SequenceNo=5 where WORKFLOW like 'STANDARD COMPANY PARTNERS INTERFACE' AND Command='PREP COMPANY PARTNERS STAGING DATA' AND PartnerID=3000

UPDATE tlgApplicationLaunchTree set SequenceNo=6 where WORKFLOW like 'STANDARD COMPANY PARTNERS INTERFACE' AND Command='COMPANY PARTNERS - STAGING DATA TRANSFER' AND PartnerID=3000

UPDATE tlgApplicationLaunchTree set SequenceNo=7 where WORKFLOW like 'STANDARD COMPANY PARTNERS INTERFACE' AND Command='DTS Submit Batch Process' AND PartnerID=3000

UPDATE tlgApplicationLaunchTree set SequenceNo=8 where WORKFLOW like 'STANDARD COMPANY PARTNERS INTERFACE' AND Command='RESET DTS SEARCH FLAG' AND PartnerID=3000

UPDATE tlgApplicationLaunchTree set SequenceNo=9 where WORKFLOW like 'STANDARD COMPANY PARTNERS INTERFACE' AND Command='DELETE COMPANY PARTNERS STAGING' AND PartnerID=3000

UPDATE tlgApplicationLaunchTree set SequenceNo=10 where WORKFLOW like 'STANDARD COMPANY PARTNERS INTERFACE' AND Command='WORKFLOW NOTIFICATION' AND PartnerID=3000



INSERT INTO tlgapplicationlaunchtree
VALUES (
	3000
	,getdate()
	,'STANDARD COMPANY PARTNERS INTERFACE'
	,4
	,'dxdExecuteSQLBatch.dll'
	,'MAP SCREENING PROFILE TO COMPANY'
	,'N'
	,'N'
	)


END

END
