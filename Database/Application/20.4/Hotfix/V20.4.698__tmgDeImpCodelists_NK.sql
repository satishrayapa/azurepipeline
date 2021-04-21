IF EXISTS (
		SELECT TOP 1 1
		FROM sys.tables
		WHERE Name = 'tmgDEImpCodelists'
			AND Type = 'U'
		)
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
	CREATE TABLE [dbo].[tmgDEImpCodelists] (
		PartnerID INT NOT NULL,
		EffDate DATETIME NOT NULL,
		FieldName VARCHAR(50) NOT NULL,
		Code NVARCHAR(36) NOT NULL,
		Decode NVARCHAR(2000) NOT NULL,
		StaticFlag VARCHAR(1) NOT NULL,
		DeletedFlag VARCHAR(1) NOT NULL,
		KeepDuringRollback VARCHAR(1) NOT NULL
		) ON [PRIMARY]

	ALTER TABLE [dbo].[tmgDEImpCodelists] ADD CONSTRAINT [PK_tmgDEImpCodelists] PRIMARY KEY NONCLUSTERED (
		PartnerID ASC,
		Code ASC,
		FieldName ASC
		)
END