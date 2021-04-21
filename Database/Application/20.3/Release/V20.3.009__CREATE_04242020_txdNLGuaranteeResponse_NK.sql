IF EXISTS (
		SELECT TOP 1 1
		FROM sys.tables
		WHERE Name = 'txdNLGuaranteeResponse'
			AND Type = 'U'
		)
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
	CREATE TABLE [dbo].[txdNLGuaranteeResponse] (
		[PartnerID] [int] NOT NULL,
		[EffDate] [datetime] NOT NULL,
		[GuaranteeResponseGUID] [varchar](50) NOT NULL,
		[MessageFunction] [int] NOT NULL,
		[ResponseIssuingDate] [varchar](50) NOT NULL,
		[ErrorCode] [varchar](4) NOT NULL,
		[DeclarantID] [varchar](20) NOT NULL,
		[DeletedFlag] [varchar](1) NOT NULL,
		[KeepDuringRollback] [varchar](1) NOT NULL
		) ON [PRIMARY]

	ALTER TABLE [dbo].[txdNLGuaranteeResponse] ADD CONSTRAINT [PK_txdNLGuaranteeResponse] PRIMARY KEY NONCLUSTERED (
		[PartnerID] ASC,
		[GuaranteeResponseGUID] ASC
		)
END
