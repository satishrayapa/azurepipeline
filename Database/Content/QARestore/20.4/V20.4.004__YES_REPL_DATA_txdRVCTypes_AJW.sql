USE [FTA_InProcess]

IF NOT EXISTS (SELECT 1 FROM txdRVCTypes WHERE PartnerID = 6000 AND RVCType = 'option1')
BEGIN
	INSERT INTO txdRVCTypes
	VALUES (6000, GETDATE(), 'option1', 'Option 1', 'N', 'N', 'N')
END