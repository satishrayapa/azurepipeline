
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdCNGT3DecResponse' 
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN

	CREATE TABLE [dbo].[txdCNGT3DecResponse]       
	(
		PartnerId INT NOT NULL,
		EffDate DATETIME NOT NULL,
		DeclarationGUID VARCHAR(50) NOT NULL,
		DeclarationDataGUID VARCHAR(50) NOT NULL,
		ResponseGUID NVARCHAR(50) NOT NULL,
		--DecResponseGUID NVARCHAR(50)NOT NULL,
		-- Common
		SeqNo NVARCHAR(18) NOT NULL,
		--DEC_DATA_Response.xsd
		EntryId NVARCHAR(18) NOT NULL,
		NoticeDate NVARCHAR(17) NOT NULL,
		Channel NVARCHAR(1) NOT NULL,
		Note NVARCHAR(255) NOT NULL,
		DeclPort NVARCHAR(4) NOT NULL,
		AgentName NVARCHAR(70) NOT NULL,
		DecNo NVARCHAR(32) NOT NULL,
		TradeCo NVARCHAR(10) NOT NULL,
		CusFie NVARCHAR(8) NOT NULL,
		BondedNo NVARCHAR(32) NOT NULL,
		IEDate NVARCHAR(17) NOT NULL,
		Pack NVARCHAR(9) NOT NULL,
		BillNo NVARCHAR(32) NOT NULL,
		TrafMode NVARCHAR(1) NOT NULL,
		VoyNo NVARCHAR(32) NOT NULL,
		NetWt NVARCHAR(13) NOT NULL,
		GrossWt NVARCHAR(13) NOT NULL,
		DDate NVARCHAR(8) NOT NULL,
		ResultInfo NVARCHAR(8) NOT NULL,
		--DecImportResponse.xsd
		ResponseCode NVARCHAR(50) NOT NULL,
		ErrorMessage NVARCHAR(MAX) NOT NULL,
		ClientSeqNo NVARCHAR(50) NOT NULL,
		TrnPreId NVARCHAR(18) NOT NULL,
		DeletedFlag VARCHAR(1) NOT NULL,
		KeepDuringRollback VARCHAR(1) NOT NULL
	) ON [PRIMARY]


		ALTER TABLE [dbo].[txdCNGT3DecResponse] ADD CONSTRAINT [PK_txdCNGT3DecResponse] PRIMARY KEY NONCLUSTERED 
		(
			PartnerId ASC,
			DeclarationGUID ASC,
			DeclarationDataGUID ASC,
			ResponseGUID ASC
		)
END


