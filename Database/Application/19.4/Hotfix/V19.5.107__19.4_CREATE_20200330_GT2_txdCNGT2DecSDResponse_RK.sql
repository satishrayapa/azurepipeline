
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdCNGT2DecSDResponse' 
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN

	CREATE TABLE [dbo].[txdCNGT2DecSDResponse]  
	(
		PartnerId INT NOT NULL,
		EffDate DATETIME NOT NULL,
		DeclarationGUID VARCHAR(50) NOT NULL,
		DeclarationDataGUID VARCHAR(50) NOT NULL,
		ResponseGUID NVARCHAR(50) NOT NULL,
		SDResponseGUID NVARCHAR(50) NOT NULL,
		PreSupId NVARCHAR(18) NOT NULL,
		GNo NVARCHAR(2) NOT NULL,
		SupType NVARCHAR(1) NOT NULL,
		DeletedFlag VARCHAR(1) NOT NULL,
		KeepDuringRollback VARCHAR(1) NOT NULL
	) ON [PRIMARY]


		ALTER TABLE [dbo].[txdCNGT2DecSDResponse] ADD CONSTRAINT [PK_txdCNGT2DecSDResponse] PRIMARY KEY NONCLUSTERED 
		(
			PartnerId ASC,
			DeclarationGUID ASC,
			DeclarationDataGUID ASC,
			ResponseGUID ASC,
			SDResponseGUID ASC
		)
END

