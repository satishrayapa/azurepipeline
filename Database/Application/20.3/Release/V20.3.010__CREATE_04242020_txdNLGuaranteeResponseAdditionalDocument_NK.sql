IF EXISTS (
		SELECT TOP 1 1
		FROM sys.tables
		WHERE Name = 'txdNLGuaranteeResponseAdditionalDocument'
			AND Type = 'U'
		)
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
	CREATE TABLE [dbo].[txdNLGuaranteeResponseAdditionalDocument] (
		[PartnerID] [int] NOT NULL,
		[EffDate] [datetime] NOT NULL,
		[GuaranteeResponseGUID] [varchar](50) NOT NULL,
		[AdditionalDocumentGUID] [varchar](50) NOT NULL,
		[AdditionalDocumentCategory] [varchar](3) NOT NULL,
		[AdditionalDocumentName] [varchar](50) NOT NULL,
		[AdditionalDocumentAmount] [numeric](38, 20) NOT NULL,
		[DeletedFlag] [varchar](1) NOT NULL,
		[KeepDuringRollback] [varchar](1) NOT NULL
		) ON [PRIMARY]

	ALTER TABLE [dbo].[txdNLGuaranteeResponseAdditionalDocument] ADD CONSTRAINT [PK_txdNLGuaranteeResponseAdditionalDocument] PRIMARY KEY NONCLUSTERED (
		[PartnerID] ASC,
		[GuaranteeResponseGUID] ASC
		)
END
