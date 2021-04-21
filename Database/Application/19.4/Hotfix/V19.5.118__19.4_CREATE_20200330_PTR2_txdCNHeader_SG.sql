
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdCNHeader' 
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN

	CREATE TABLE [dbo].[txdCNHeader]  
	(
		PartnerId INT NOT NULL,
		EffDate DATETIME NOT NULL,
		CNHeaderGUID VARCHAR(50) NOT NULL,
		etpsPreentNo NVARCHAR (64) NOT NULL,
		businessId NVARCHAR (64) NOT NULL,
		tmsCnt NUMERIC (19) NOT NULL,
		typecd NVARCHAR (1) NOT NULL,
		manageResult NVARCHAR (1) NOT NULL,
		manageDate DATETIME NOT NULL,
		rmk NVARCHAR (255) NOT NULL,
		Pocket_id NVARCHAR(128)	NOT NULL,
		Total_pocket_qty INT NOT NULL,
		Cur_pocket_no INT NOT NULL,
		Is_unstructured NVARCHAR(1) NOT NULL,
		DeletedFlag VARCHAR(1) NOT NULL,
		KeepDuringRollback VARCHAR(1) NOT NULL
	) ON [PRIMARY]


		ALTER TABLE [dbo].[txdCNHeader] ADD CONSTRAINT [PK_txdCNHeader] PRIMARY KEY NONCLUSTERED 
		(
			PartnerId ASC,
			CNHeaderGUID ASC
		)
END


