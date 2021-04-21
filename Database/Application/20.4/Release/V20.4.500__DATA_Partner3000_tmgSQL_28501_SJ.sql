
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
    PRINT 'running script for baseline'
  
  IF NOT EXISTS (
		SELECT TOP 1 1
		FROM tmgsql  WITH(NOLOCK) 
		WHERE SQLGUID ='EE7158B7-B56A-494B-8129-43257558E0D1'  AND PartnerID=3000
		)
BEGIN

INSERT INTO tmgsql (
	partnerid
	,effdate
	,SQLGUID
	,SQLDescription
	,SQLCmd
	,TxnDate
	,SQLLongDescription
	,DeletedFlag
	,KeepDuringRollback
	)
VALUES (
	3000
	,GETDATE()
	,'EE7158B7-B56A-494B-8129-43257558E0D1'
	,'Export Validations Global Codes Upload'
	,'UPDATE tgc SET tgc.Decode = u.ValidationCheck FROM tmgGlobalCodes tgc JOIN usrExportValidations u ON u.PartnerID = tgc.partnerID AND u.ValidationGroup = tgc.FieldName AND u.ValidationField = tgc.Code WHERE u.PartnerID = (Select PartnerID from tmfDefaults) AND u.ValidationCheck <> tgc.Decode AND u.ValidationCheck in (''Y'', ''N'')'
	,'2019-12-09 14:07'
	,'Export Validations Global Codes Upload'
	,'N'
	,'N'
	)

END
ELSE
BEGIN

UPDATE tmgsql set SQLCmd='UPDATE tgc SET tgc.Decode = u.ValidationCheck FROM tmgGlobalCodes tgc JOIN usrExportValidations u ON u.PartnerID = tgc.partnerID AND u.ValidationGroup = tgc.FieldName AND u.ValidationField = tgc.Code WHERE u.PartnerID = (Select PartnerID from tmfDefaults) AND u.ValidationCheck <> tgc.Decode AND u.ValidationCheck in (''Y'', ''N'')'
 WHERE SQLGUID ='EE7158B7-B56A-494B-8129-43257558E0D1'  AND PartnerID=3000

END

END