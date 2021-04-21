IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdBOMAveragingVolume'
			AND Type = 'U')
BEGIN
	IF OBJECT_ID('UQ_txdBOMAveragingVolume') IS NULL 
	BEGIN
		ALTER TABLE dbo.txdBOMAveragingVolume
		ADD CONSTRAINT UQ_txdBOMAveragingVolume UNIQUE
		(
			Value ASC,
			ShipDate ASC,
			PartnerId ASC
		)
	END
	ELSE
	BEGIN
		PRINT 'Key Already Exists... Skipping'
	END
END
ELSE
BEGIN
	PRINT 'Table Not Exists... Skipping'
END

