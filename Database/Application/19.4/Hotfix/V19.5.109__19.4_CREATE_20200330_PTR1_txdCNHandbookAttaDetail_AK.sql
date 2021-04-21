
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdCNHandbookAttaDetail' 
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN

	CREATE TABLE [dbo].[txdCNHandbookAttaDetail]  
	(
		PartnerId INT NOT NULL,
		EffDate DATETIME NOT NULL,
		CNHandbookHeaderGUID VARCHAR(50) NOT NULL,
		CNHandbookAttaDetailGUID VARCHAR(50) NOT NULL,
		AttachedFileName NVARCHAR(64) NOT NULL,
		ChangeOrConciliationTimes NVARCHAR(19) NOT NULL,
		AttachedDocFormat NVARCHAR(4) NOT NULL,
		BusinessDocType NVARCHAR(4) NOT NULL,
		AttachedDocSeqNum NUMERIC(19) NOT NULL,
		AttachedDocType NVARCHAR(25) NOT NULL,
		AttachedDocNum NVARCHAR(64) NOT NULL,
		AttachedDocFileName NVARCHAR(512) NOT NULL,
		SheetProductSeqNum NUMERIC(19) NOT NULL,
		UploaderICCardNum NVARCHAR(16) NOT NULL,
		UploaderCustomCode NVARCHAR(18) NOT NULL,
		Remark NVARCHAR(4000) NOT NULL,
		ModifyMarkCode NVARCHAR(4) NOT NULL,
		PackageID NVARCHAR(128) NOT NULL,
		CurrentPackageSeqNum NUMERIC(3) NOT NULL,
		TotalPackageQty NUMERIC(3) NOT NULL,
		DeletedFlag VARCHAR(1) NOT NULL,
		KeepDuringRollback VARCHAR(1) NOT NULL
	) ON [PRIMARY]


		ALTER TABLE [dbo].[txdCNHandbookAttaDetail] ADD CONSTRAINT [PK_txdCNHandbookAttaDetail] PRIMARY KEY NONCLUSTERED 
		(
			PartnerId ASC,
			CNHandbookHeaderGUID ASC,
			CNHandbookAttaDetailGUID ASC
		)
END



