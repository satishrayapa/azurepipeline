IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[tmdABIResponseLookup]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN	
	DECLARE @PartnerID AS INT
	SELECT @PartnerID=  partnerID FROM dbo.tmfDefaults

	IF EXISTS(SELECT * FROM [tmdABIResponseLookup] WHERE MSGIDCode LIKE 'CRELSC%')
		BEGIN
			DELETE FROM tmdABIResponseLookup WHERE MSGIDCode LIKE 'CRELSC%'		
		END

	INSERT INTO dbo.tmdABIResponseLookup VALUES (@PartnerID, Getdate(), 'CRELSC01', 'Data Under PGA Review', '', 'N', 'N' )
	INSERT INTO dbo.tmdABIResponseLookup VALUES (@PartnerID, Getdate(), 'CRELSC02', 'Hold Intact', '', 'N', 'N' )
	INSERT INTO dbo.tmdABIResponseLookup VALUES (@PartnerID, Getdate(), 'CRELSC04', 'Data Rejected Per PGA Review', '', 'N', 'N' )
	INSERT INTO dbo.tmdABIResponseLookup VALUES (@PartnerID, Getdate(), 'CRELSC06', 'Do Not Devan', '', 'N', 'N' )
	INSERT INTO dbo.tmdABIResponseLookup VALUES (@PartnerID, Getdate(), 'CRELSC07', 'May Proceed', '', 'N', 'N' )
	INSERT INTO dbo.tmdABIResponseLookup VALUES (@PartnerID, Getdate(), 'CRELSC08', 'Move To Secure Holding Facility', '', 'N', 'N' )
	INSERT INTO dbo.tmdABIResponseLookup VALUES (@PartnerID, Getdate(), 'CRELSC10', 'Documents Required', '', 'N', 'N' )
	INSERT INTO dbo.tmdABIResponseLookup VALUES (@PartnerID, Getdate(), 'CRELSC11', 'Intensive - Exam/Sample', '', 'N', 'N' )
	INSERT INTO dbo.tmdABIResponseLookup VALUES (@PartnerID, Getdate(), 'CRELSC12', 'Docs Required - Satisfied', '', 'N', 'N' )
	INSERT INTO dbo.tmdABIResponseLookup VALUES (@PartnerID, Getdate(), 'CRELSC13', 'Exam-Resolved', '', 'N', 'N' )
	


	IF EXISTS(SELECT * FROM [tmdABIResponseLookup] WHERE MSGIDCode LIKE 'CRSRC%')
	BEGIN
		DELETE FROM tmdABIResponseLookup WHERE MSGIDCode LIKE 'CRSRC%'	
	END

	INSERT INTO dbo.tmdABIResponseLookup VALUES (@PartnerID, Getdate(), 'CRSRC11','GENERAL', '', 'N', 'N' )
	INSERT INTO dbo.tmdABIResponseLookup VALUES (@PartnerID, Getdate(), 'CRSRC12','EXAM/SAMPLE', '', 'N', 'N' )
	INSERT INTO dbo.tmdABIResponseLookup VALUES (@PartnerID, Getdate(), 'CRSRC14','DATA REJECTED PER PGA REVIEW', '', 'N', 'N' )
	INSERT INTO dbo.tmdABIResponseLookup VALUES (@PartnerID, Getdate(), 'CRSRC15','DATA INACCURATE - CONTACT PGA', '', 'N', 'N' )
	INSERT INTO dbo.tmdABIResponseLookup VALUES (@PartnerID, Getdate(), 'CRSRC21','EXAM DO NOT DEVAN', '', 'N', 'N' )
	INSERT INTO dbo.tmdABIResponseLookup VALUES (@PartnerID, Getdate(), 'CRSRC22','GENERAL', '', 'N', 'N' )
	INSERT INTO dbo.tmdABIResponseLookup VALUES (@PartnerID, Getdate(), 'CRSRC23','RELEASED', '', 'N', 'N' )
	INSERT INTO dbo.tmdABIResponseLookup VALUES (@PartnerID, Getdate(), 'CRSRC24','RELEASED WITH COMMENTS', '', 'N', 'N' )
	INSERT INTO dbo.tmdABIResponseLookup VALUES (@PartnerID, Getdate(), 'CRSRC25','ADDITIONAL VERIFICATION NEEDED', '', 'N', 'N' )
	INSERT INTO dbo.tmdABIResponseLookup VALUES (@PartnerID, Getdate(), 'CRSRC26','PN DATA REJECTED', '', 'N', 'N' )
	INSERT INTO dbo.tmdABIResponseLookup VALUES (@PartnerID, Getdate(), 'CRSRC28','LAB RESULTS PENDING', '', 'N', 'N' )
	INSERT INTO dbo.tmdABIResponseLookup VALUES (@PartnerID, Getdate(), 'CRSRC29','LAB RESULTS FAILED', '', 'N', 'N' )
	INSERT INTO dbo.tmdABIResponseLookup VALUES (@PartnerID, Getdate(), 'CRSRC30','PN REFUSED PN NOT SUBMITTED', '', 'N', 'N' )
	INSERT INTO dbo.tmdABIResponseLookup VALUES (@PartnerID, Getdate(), 'CRSRC31','PN REG HOLD MANUF NOT RGSTRD', '', 'N', 'N' )
	INSERT INTO dbo.tmdABIResponseLookup VALUES (@PartnerID, Getdate(), 'CRSRC34','EXAM', '', 'N', 'N' )
	INSERT INTO dbo.tmdABIResponseLookup VALUES (@PartnerID, Getdate(), 'CRSRC35','FWS CLEARANCE REFUSED', '', 'N', 'N' )
	INSERT INTO dbo.tmdABIResponseLookup VALUES (@PartnerID, Getdate(), 'CRSRC36','PARTIAL RELEASE AND REFUSED', '', 'N', 'N' )
	INSERT INTO dbo.tmdABIResponseLookup VALUES (@PartnerID, Getdate(), 'CRSRC40','REFUSED', '', 'N', 'N' )
	INSERT INTO dbo.tmdABIResponseLookup VALUES (@PartnerID, Getdate(), 'CRSRC44','FAILURE TO PRESENT', '', 'N', 'N' )
	INSERT INTO dbo.tmdABIResponseLookup VALUES (@PartnerID, Getdate(), 'CRSRC45','PGA EXPECTS THAT ITS DATA HAS NOT CHANGED ON THIS VERSION. THEREFORE A MAY PROCEED IS GRANTED.', '', 'N', 'N' )
	INSERT INTO dbo.tmdABIResponseLookup VALUES (@PartnerID, Getdate(), 'CRSRC50','FWS CLEARED', '', 'N', 'N' )
	INSERT INTO dbo.tmdABIResponseLookup VALUES (@PartnerID, Getdate(), 'CRSRC51','FWS CONDITIONAL RELEASE', '', 'N', 'N' )
	INSERT INTO dbo.tmdABIResponseLookup VALUES (@PartnerID, Getdate(), 'CRSRC52','PN REFUSED INACCURATE PN', '', 'N', 'N' )
	INSERT INTO dbo.tmdABIResponseLookup VALUES (@PartnerID, Getdate(), 'CRSRC53','PN REFUSED UNTIMELY PN', '', 'N', 'N' )
	INSERT INTO dbo.tmdABIResponseLookup VALUES (@PartnerID, Getdate(), 'CRSRC60','DOCS REQUIRED - SATISFIED', '', 'N', 'N' )
	INSERT INTO dbo.tmdABIResponseLookup VALUES (@PartnerID, Getdate(), 'CRSRC65','RESOLVED - GENERAL', '', 'N', 'N' )
	INSERT INTO dbo.tmdABIResponseLookup VALUES (@PartnerID, Getdate(), 'CRSRC66','NO THREAT FOUND', '', 'N', 'N' )
	INSERT INTO dbo.tmdABIResponseLookup VALUES (@PartnerID, Getdate(), 'CRSRC90','ADDITIONAL INFORMATION NEEDED', '', 'N', 'N' )
END