IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[tmgglobalcodesheader]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
	BEGIN

		DECLARE @PartnerID AS INT = (SELECT TOP 1 PartnerID FROM tmfDefaults)
		
		IF NOT EXISTS(SELECT TOP 1 * from tmgglobalcodesheader where GlobalCodeFieldName ='GCCRNoteReasonCode')
			BEGIN
				INSERT INTO tmgglobalcodesheader (PartnerID, EffDate, Module, GlobalCodeDescription, GlobalCodeFieldName,Standard, DeletedFlag, KeepDuringRollback)
				VALUES(@PartnerID,GETDATE(),'GC','These codes are used within GC Classification Request’s “Notes” pop up and used to organize “note reason codes”','GCCRNoteReasonCode','Y','N','N')
			END
	END
ELSE
	BEGIN
		PRINT 'Table [tmgglobalcodesheader] is missing...'
	END