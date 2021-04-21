
IF EXISTS (
		SELECT TOP 1 1
		FROM sys.tables
		WHERE Name = 'tmgWorkflowWebDav' --Your Table Here
			AND Type = 'U'
		)
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
	CREATE TABLE [dbo].[tmgWorkflowWebDav] --Your Table Here
		(
		[ServerName] VARCHAR(50) NOT NULL
		,[EffDate] DATETIME NOT NULL
		,[UserName] VARCHAR(50) NOT NULL
		,[Password] VARCHAR(200) NOT NULL
		,[DeletedFlag] VARCHAR(1) NOT NULL
		,[KeepDuringRollback] VARCHAR(1) NOT NULL
		) ON [PRIMARY]

	CREATE CLUSTERED INDEX [CIX_tmgWorkflowWebDav] ON [dbo].[tmgWorkflowWebDav] --Your Table Here
		([EffDate] ASC)

	--The prefix "CIX" is only for clustered indexes while the non clustered indexes just use "IX". 
	--So the clustered index name would be CIX_TABLENAME, and the unclustered indexes would be IX_TABLENAME_1, IX_TABLENAME_2, ...
	ALTER TABLE [dbo].[tmgWorkflowWebDav] ADD CONSTRAINT [PK_tmgWorkflowWebDav] PRIMARY KEY NONCLUSTERED --Your Table Here
		([ServerName] ASC)
END