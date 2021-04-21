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
