
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdCNPTR2CheckInfo' 
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
		
	CREATE TABLE [dbo].[txdCNPTR2CheckInfo] 
	(
		PartnerId INT NOT NULL,
		EffDate DATETIME NOT NULL,
		CNHeaderGUID VARCHAR(50) NOT NULL,
		CNCheckInfoGUID VARCHAR(50) NOT NULL,
		note NVARCHAR (255) NOT NULL,
		DeletedFlag VARCHAR(1) NOT NULL,
		KeepDuringRollback VARCHAR(1) NOT NULL
	) ON [PRIMARY]

		ALTER TABLE [dbo].[txdCNPTR2CheckInfo] ADD CONSTRAINT [PK_txdCNPTR2CheckInfo] PRIMARY KEY NONCLUSTERED 
		(
			PartnerId ASC,
			CNHeaderGUID ASC,
			CNCheckInfoGUID ASC
		)
END
