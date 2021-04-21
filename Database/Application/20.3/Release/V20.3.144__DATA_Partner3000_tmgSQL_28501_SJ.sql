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
		FROM tmgsql WITH(NOLOCK) 
		WHERE SQLGUID ='6C26569E-A037-454A-B98D-AAC5075F420E' AND PartnerID=3000
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
	,'6C26569E-A037-454A-B98D-AAC5075F420E'
	,'Export Sourcing SS Upload Logic'
	,'UPDATE tgc SET tgc.Decode = u.SourcingEntity FROM tmgGlobalCodes tgc JOIN usrExportSourcing u ON u.PartnerID = tgc.partnerID AND u.SourcingGroup = tgc.FieldName AND u.SourcingField = tgc.Code WHERE u.PartnerID = (Select PartnerID from tmfDefaults) AND u.SourcingEntity <> tgc.Decode AND u.SourcingEntity in (''I'', ''GC'', ''BL'', ''CO'') AND u.SourcingGroup <> '''''
	,'2019-12-09 14:07'
	,'Export Sourcing SS Upload Logic'
	,'N'
	,'N'
	)
	
END
BEGIN

UPDATE tmgsql set SQLCmd='UPDATE tgc SET tgc.Decode = u.SourcingEntity FROM tmgGlobalCodes tgc JOIN usrExportSourcing u ON u.PartnerID = tgc.partnerID AND u.SourcingGroup = tgc.FieldName AND u.SourcingField = tgc.Code WHERE u.PartnerID = (Select PartnerID from tmfDefaults) AND u.SourcingEntity <> tgc.Decode AND u.SourcingEntity in (''I'', ''GC'', ''BL'', ''CO'') AND u.SourcingGroup <> '''''
 WHERE SQLGUID ='6C26569E-A037-454A-B98D-AAC5075F420E'  AND PartnerID=3000

END


END