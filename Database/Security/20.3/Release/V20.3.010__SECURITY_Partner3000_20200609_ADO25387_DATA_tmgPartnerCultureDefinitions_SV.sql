DECLARE @CorrectBaselineDB AS VARCHAR(50)
SET @CorrectBaselineDB = 'SEC_3000_BASELINE'

DECLARE @CorrectProductionDB AS VARCHAR(50)
SET @CorrectProductionDB = 'SEC_3000'

DECLARE @CorrectQADB AS VARCHAR(50)
SET @CorrectQADB = 'QA_Security'

DECLARE @CurrentDB AS VARCHAR(50)
SET @CurrentDB = (Select db_name())

IF (@CurrentDB IN (@CorrectProductionDB, @CorrectQADB, @CorrectBaselineDB))
BEGIN
	IF EXISTS(select * from tmgPartnerCultureDefinitions with(nolock)  where PartnerId = 3000 and FieldName ='fmgMaintenance_aspx')
		BEGIN
			 Delete  tmgPartnerCultureDefinitions
			 where PartnerId = 3000 and FieldName ='fmgMaintenance_aspx'
		END
END

