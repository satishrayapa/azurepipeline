IF EXISTS (
		SELECT TOP 1 1
		FROM sys.tables
		WHERE Name = 'tmgGlobalCodesHeader' --Your Table Here
			AND Type = 'U'
		)
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
	CREATE TABLE [dbo].[tmgGlobalCodesHeader] --Your Table Here
		(
		[PartnerID] [int] NOT NULL
		,[EffDate] [datetime] NOT NULL
		,[Module] [varchar](30) NOT NULL
		,[GlobalCodeDescription] [nvarchar](300) NOT NULL
		,[GlobalCodeFieldName] [nvarchar](30) NOT NULL
		,[Standard] [varchar](1) NOT NULL
		,[DeletedFlag] [varchar](1) NOT NULL
		,[KeepDuringRollback] [varchar](1) NOT NULL
		) ON [PRIMARY]

	CREATE CLUSTERED INDEX [CIX_tmgGlobalCodesHeader] ON [dbo].[tmgGlobalCodesHeader] ([EffDate] ASC)

	ALTER TABLE [dbo].[tmgGlobalCodesHeader] ADD CONSTRAINT [PK_tmgGlobalCodesHeader] PRIMARY KEY NONCLUSTERED --Your Table Here
		(
		[PartnerID] ASC
		,[Module] ASC
		,[GlobalCodeFieldName] ASC
		)
END
