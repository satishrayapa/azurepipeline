IF EXISTS (SELECT 1 FROM tmgGlobalCodes WHERE FieldName = 'DocType' AND Code = 'BOMSummary')
	BEGIN
		PRINT 'Global Code Already Exists... Skipping'
	END
ELSE
	BEGIN
		INSERT INTO tmgGlobalCodes
		SELECT PartnerID, GETDATE(), 'DocType', 'BOMSummary', 'Detail BOM Summary', 'Y', 'N', 'N'
		FROM tmfDefaults WITH (NOLOCK)
	END