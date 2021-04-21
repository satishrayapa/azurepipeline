IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[tmd3CEAPICredentials]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
	BEGIN
		--Store PartnerID
		DECLARE @PartnerID AS INT = (SELECT TOP 1 PartnerID FROM tmfDefaults)

		--Re-insert AuditTrailUri record
		IF NOT EXISTS(SELECT TOP 1 Config FROM tmd3CEAPICredentials WHERE Config = 'AuditTrailUri')
			BEGIN
				INSERT INTO tmd3CEAPICredentials (PartnerID, EffDate, Config, Value, ExpirationDate, DeletedFlag, KeepDuringRollback)
				VALUES (@PartnerID, GETDATE(), 'AuditTrailUri', '/ccce/apis/audit/v1', '', 'N', 'N')
			END
	END
ELSE
	BEGIN
		PRINT 'Table [tmd3CEAPICredentials] is missing...'
	END