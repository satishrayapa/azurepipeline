IF EXISTS (select TOP 1 1 from sys.tables where Name = 'tmgSpreadsheetUploadInstances'
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
	CREATE TABLE [dbo].[tmgSpreadsheetUploadInstances]
	(
		[PartnerID] [int] NOT NULL ,
		[EffDate] [datetime] NOT NULL ,
		[UploadGUID] [uniqueidentifier] NOT NULL ,
		[UserName] [varchar](50) NOT NULL,
		[FileName] [varchar](300) NOT NULL,
		[WorkflowName] [varchar](300) NOT NULL,
		[Status] [varchar] (25) NOT NULL ,
		[FileGUID] [uniqueidentifier] NOT NULL,
        [TriggeredSqlGUID] [varchar](50) NOT NULL,
		[DeletedFlag] [varchar] (1) NOT NULL ,
		[KeepDuringRollback] [varchar] (1) NOT NULL 
	) ON [PRIMARY]
		
		CREATE CLUSTERED INDEX [CIX_tmgSpreadsheetUploadInstances] ON [dbo].[tmgSpreadsheetUploadInstances] (
			[EffDate] ASC
		)

		ALTER TABLE [dbo].[tmgSpreadsheetUploadInstances] ADD CONSTRAINT [PK_tmgSpreadsheetUploadInstances] PRIMARY KEY NONCLUSTERED
		(
			  [PartnerID] ASC,
			  [UploadGUID] ASC
		)
END