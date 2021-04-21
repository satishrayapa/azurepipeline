PRINT 'Create table txdDashboardInformation if not exists already '
IF EXISTS (
        SELECT TOP 1 1
        FROM sys.tables
        WHERE Name = 'txdDashboardInformation'
	AND Type = 'U'
        )
BEGIN
    PRINT 'Table txdDashboardInformation Already Exists....Skipping'
END
ELSE
BEGIN
    CREATE TABLE [dbo].[txdDashboardInformation]
        (
         [PartnerID] [int] NOT NULL
	,[Effdate] [Datetime] NOT NULL
        ,[DashboardName] [nvarchar](50) NOT NULL
        ,[DashboardGUID] [UNIQUEIDENTIFIER] NOT NULL
        ,[DeletedFlag] [nvarchar](1) NOT NULL
        ,[KeepDuringRollback] [nvarchar](1) NOT NULL
        )
    ALTER TABLE [dbo].[txdDashboardInformation] ADD CONSTRAINT [PK_txdDashboardInformation] PRIMARY KEY NONCLUSTERED ([DashboardGUID])
    PRINT 'Table txdDashboardInformation created'
END