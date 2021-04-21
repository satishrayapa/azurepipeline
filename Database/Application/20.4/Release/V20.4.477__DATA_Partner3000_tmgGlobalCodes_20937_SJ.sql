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

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'CompanyTypeToDPSProfile' and Code = 'BRKR' and PartnerID= 3000)
BEGIN
	INSERT INTO tmgGlobalCodes (PartnerID,EffDate,FieldName,Code,Decode,StaticFlag,DeletedFlag,KeepDuringRollback)
	VALUES (3000,GETDATE(), 'CompanyTypeToDPSProfile', 'BRKR', '', 'Y', 'N', 'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'CompanyTypeToDPSProfile' and Code = 'CARR' and PartnerID= 3000)
BEGIN
	INSERT INTO tmgGlobalCodes (PartnerID,EffDate,FieldName,Code,Decode,StaticFlag,DeletedFlag,KeepDuringRollback)
	VALUES (3000,GETDATE(), 'CompanyTypeToDPSProfile', 'CARR', '', 'Y', 'N', 'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'CompanyTypeToDPSProfile' and Code = 'COMP' and PartnerID= 3000)
BEGIN
	INSERT INTO tmgGlobalCodes (PartnerID,EffDate,FieldName,Code,Decode,StaticFlag,DeletedFlag,KeepDuringRollback)
	VALUES (3000,GETDATE(), 'CompanyTypeToDPSProfile', 'COMP', '', 'Y', 'N', 'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'CompanyTypeToDPSProfile' and Code = 'CONS' and PartnerID= 3000)
BEGIN
	INSERT INTO tmgGlobalCodes (PartnerID,EffDate,FieldName,Code,Decode,StaticFlag,DeletedFlag,KeepDuringRollback)
	VALUES (3000,GETDATE(), 'CompanyTypeToDPSProfile', 'CONS', '', 'Y', 'N', 'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'CompanyTypeToDPSProfile' and Code = 'CUST' and PartnerID= 3000)
BEGIN
	INSERT INTO tmgGlobalCodes (PartnerID,EffDate,FieldName,Code,Decode,StaticFlag,DeletedFlag,KeepDuringRollback)
	VALUES (3000,GETDATE(), 'CompanyTypeToDPSProfile', 'CUST', '', 'Y', 'N', 'N')
END


IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'CompanyTypeToDPSProfile' and Code = 'EMPL' and PartnerID= 3000)
BEGIN
	INSERT INTO tmgGlobalCodes (PartnerID,EffDate,FieldName,Code,Decode,StaticFlag,DeletedFlag,KeepDuringRollback)
	VALUES (3000,GETDATE(), 'CompanyTypeToDPSProfile', 'EMPL', '', 'Y', 'N', 'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'CompanyTypeToDPSProfile' and Code = 'EXPTR' and PartnerID= 3000)
BEGIN
	INSERT INTO tmgGlobalCodes (PartnerID,EffDate,FieldName,Code,Decode,StaticFlag,DeletedFlag,KeepDuringRollback)
	VALUES (3000,GETDATE(), 'CompanyTypeToDPSProfile', 'EXPTR', '', 'Y', 'N', 'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'CompanyTypeToDPSProfile' and Code = 'FF' and PartnerID= 3000)
BEGIN
	INSERT INTO tmgGlobalCodes (PartnerID,EffDate,FieldName,Code,Decode,StaticFlag,DeletedFlag,KeepDuringRollback)
	VALUES (3000,GETDATE(), 'CompanyTypeToDPSProfile', 'FF', '', 'Y', 'N', 'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'CompanyTypeToDPSProfile' and Code = 'IMPTR' and PartnerID= 3000)
BEGIN
	INSERT INTO tmgGlobalCodes (PartnerID,EffDate,FieldName,Code,Decode,StaticFlag,DeletedFlag,KeepDuringRollback)
	VALUES (3000,GETDATE(), 'CompanyTypeToDPSProfile', 'IMPTR', '', 'Y', 'N', 'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'CompanyTypeToDPSProfile' and Code = 'NOTP' and PartnerID= 3000)
BEGIN
	INSERT INTO tmgGlobalCodes (PartnerID,EffDate,FieldName,Code,Decode,StaticFlag,DeletedFlag,KeepDuringRollback)
	VALUES (3000,GETDATE(), 'CompanyTypeToDPSProfile', 'NOTP', '', 'Y', 'N', 'N')
END



IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'CompanyTypeToDPSProfile' and Code = 'PRDCR' and PartnerID= 3000)
BEGIN
	INSERT INTO tmgGlobalCodes (PartnerID,EffDate,FieldName,Code,Decode,StaticFlag,DeletedFlag,KeepDuringRollback)
	VALUES (3000,GETDATE(), 'CompanyTypeToDPSProfile', 'PRDCR', '', 'Y', 'N', 'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'CompanyTypeToDPSProfile' and Code = 'PREPR' and PartnerID= 3000)
BEGIN
	INSERT INTO tmgGlobalCodes (PartnerID,EffDate,FieldName,Code,Decode,StaticFlag,DeletedFlag,KeepDuringRollback)
	VALUES (3000,GETDATE(), 'CompanyTypeToDPSProfile', 'PREPR', '', 'Y', 'N', 'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'CompanyTypeToDPSProfile' and Code = 'SALES' and PartnerID= 3000)
BEGIN
	INSERT INTO tmgGlobalCodes (PartnerID,EffDate,FieldName,Code,Decode,StaticFlag,DeletedFlag,KeepDuringRollback)
	VALUES (3000,GETDATE(), 'CompanyTypeToDPSProfile', 'SALES', '', 'Y', 'N', 'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'CompanyTypeToDPSProfile' and Code = 'SCI' and PartnerID= 3000)
BEGIN
	INSERT INTO tmgGlobalCodes (PartnerID,EffDate,FieldName,Code,Decode,StaticFlag,DeletedFlag,KeepDuringRollback)
	VALUES (3000,GETDATE(), 'CompanyTypeToDPSProfile', 'SCI', '', 'Y', 'N', 'N')
END


IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'CompanyTypeToDPSProfile' and Code = 'SHIP' and PartnerID= 3000)
BEGIN
	INSERT INTO tmgGlobalCodes (PartnerID,EffDate,FieldName,Code,Decode,StaticFlag,DeletedFlag,KeepDuringRollback)
	VALUES (3000,GETDATE(), 'CompanyTypeToDPSProfile', 'SHIP', '', 'Y', 'N', 'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'CompanyTypeToDPSProfile' and Code = 'SHPTO' and PartnerID= 3000)
BEGIN
	INSERT INTO tmgGlobalCodes (PartnerID,EffDate,FieldName,Code,Decode,StaticFlag,DeletedFlag,KeepDuringRollback)
	VALUES (3000,GETDATE(), 'CompanyTypeToDPSProfile', 'SHPTO', '', 'Y', 'N', 'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'CompanyTypeToDPSProfile' and Code = 'SIGN' and PartnerID= 3000)
BEGIN
	INSERT INTO tmgGlobalCodes (PartnerID,EffDate,FieldName,Code,Decode,StaticFlag,DeletedFlag,KeepDuringRollback)
	VALUES (3000,GETDATE(), 'CompanyTypeToDPSProfile', 'SIGN', '', 'Y', 'N', 'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'CompanyTypeToDPSProfile' and Code = 'SOLD' and PartnerID= 3000)
BEGIN
	INSERT INTO tmgGlobalCodes (PartnerID,EffDate,FieldName,Code,Decode,StaticFlag,DeletedFlag,KeepDuringRollback)
	VALUES (3000,GETDATE(), 'CompanyTypeToDPSProfile', 'SOLD', '', 'Y', 'N', 'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'CompanyTypeToDPSProfile' and Code = 'SUPID' and PartnerID= 3000)
BEGIN
	INSERT INTO tmgGlobalCodes (PartnerID,EffDate,FieldName,Code,Decode,StaticFlag,DeletedFlag,KeepDuringRollback)
	VALUES (3000,GETDATE(), 'CompanyTypeToDPSProfile', 'SUPID', '', 'Y', 'N', 'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'CompanyTypeToDPSProfile' and Code = 'SUPPL' and PartnerID= 3000)
BEGIN
	INSERT INTO tmgGlobalCodes (PartnerID,EffDate,FieldName,Code,Decode,StaticFlag,DeletedFlag,KeepDuringRollback)
	VALUES (3000,GETDATE(), 'CompanyTypeToDPSProfile', 'SUPPL', '', 'Y', 'N', 'N')
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGlobalCodes where FieldName = 'CompanyTypeToDPSProfile' and Code = 'ZUSR' and PartnerID= 3000)
BEGIN
	INSERT INTO tmgGlobalCodes (PartnerID,EffDate,FieldName,Code,Decode,StaticFlag,DeletedFlag,KeepDuringRollback)
	VALUES (3000,GETDATE(), 'CompanyTypeToDPSProfile', 'ZUSR', '', 'Y', 'N', 'N')
END


END

