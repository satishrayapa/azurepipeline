DECLARE @CorrectBaselineDB AS VARCHAR(50)
SET @CorrectBaselineDB = 'IP_3000_BASELINE'

DECLARE @CorrectProductionDB AS VARCHAR(50)
SET @CorrectProductionDB = 'IP_3000'

DECLARE @CorrectQADB AS VARCHAR(50)
SET @CorrectQADB = 'IP_3000_QA_Baseline'

DECLARE @CurrentDB AS VARCHAR(50)
SET @CurrentDB = (Select db_name())



IF (@CurrentDB IN (@CorrectProductionDB, @CorrectQADB, @CorrectBaselineDB))
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

