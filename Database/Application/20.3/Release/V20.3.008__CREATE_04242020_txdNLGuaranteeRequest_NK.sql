IF EXISTS (
		SELECT TOP 1 1
		FROM sys.tables
		WHERE Name = 'txdNLGuaranteeRequest'
			AND Type = 'U'
		)
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
	CREATE TABLE [dbo].[txdNLGuaranteeRequest] (
		[PartnerID] [int] NOT NULL,
		[EffDate] [datetime] NOT NULL,
		[GuaranteeRequestGUID] [varchar](50) NOT NULL,
		[MessageFunction] [int] NOT NULL,
		[DeclarantID] [varchar](20) NOT NULL,
		[DeletedFlag] [varchar](1) NOT NULL,
		[KeepDuringRollback] [varchar](1) NOT NULL
		) ON [PRIMARY]

	ALTER TABLE [dbo].[txdNLGuaranteeRequest] ADD CONSTRAINT [PK_txdNLGuaranteeRequest] PRIMARY KEY NONCLUSTERED 
		(
		[PartnerID] ASC,
		[GuaranteeRequestGUID] ASC
		)
END
