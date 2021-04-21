IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdGenericFileImportErrors' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[txdGenericFileImportErrors](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ErrorGUID] [uniqueidentifier] NOT NULL,
	[Workflow] [varchar](200) NOT NULL,
	[FileName] [varchar](200) NOT NULL,
	[LinesProcessed] [varchar] (10) NOT NULL,
	[Error] [varchar](max) NOT NULL,
    [DetailedError] [nvarchar] (max) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL
	)
ALTER TABLE [dbo].[txdGenericFileImportErrors] ADD CONSTRAINT [PK_txdGenericFileImportErrors] PRIMARY KEY NONCLUSTERED --Your Table Here
		(
			  [PartnerID] ASC,
			  [ErrorGUID] ASC
		)
END