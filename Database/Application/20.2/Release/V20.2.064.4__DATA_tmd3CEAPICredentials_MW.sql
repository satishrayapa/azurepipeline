--------------------------------------------------------------------------------------------------------------
--Delete ChildProfileID and Update ChildProfileUri API endpoint in tmd3CEAPICredentials
--When the API call is made using this endpoint the new ChildProfileID record will be inserted
----------------------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[tmd3CEAPICredentials]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
	BEGIN
		--Store PartnerID
		DECLARE @PartnerID AS INT = (SELECT TOP 1 PartnerID FROM tmfDefaults)

		--Delete ChildProfileID and ChildProfileUri records 
		DELETE tmd3CEAPICredentials WHERE Config = 'ChildProfileID'
		DELETE tmd3CEAPICredentials WHERE Config = 'ChildProfileUri'

		--Re-insert ChildProfileUri record
		IF NOT EXISTS(SELECT TOP 1 Config FROM tmd3CEAPICredentials WHERE Config = 'ChildProfileUri')
			BEGIN
				INSERT INTO tmd3CEAPICredentials (PartnerID, EffDate, Config, Value, ExpirationDate, DeletedFlag, KeepDuringRollback)
				VALUES (@PartnerID, GETDATE(), 'ChildProfileUri', '/ccce/apis/profile/v1/childprofile', '', 'N', 'N')
			END
	END
ELSE
	BEGIN
		PRINT 'Table [tmd3CEAPICredentials] is missing...'
	END