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