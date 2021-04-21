IF EXISTS (select TOP 1 1 from sys.tables where Name = 'tlgAppServerIpAddress' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE tlgAppServerIpAddress(
[EffDate] DATETIME NOT NULL,
[ServerName] varchar(50) NOT NULL,
[MachineName] VARCHAR(50) NOT NULL,
[IpAddress] varchar(50) NOT NULL,
[DeletedFlag] varchar(1) NOT NULL,
[KeepDuringRollback] varchar(1) NOT NULL
)
ALTER TABLE [dbo].[tlgAppServerIpAddress] ADD CONSTRAINT [PK_tlgAppServerIpAddress] PRIMARY KEY NONCLUSTERED --Your Table Here
		(
			  [ServerName] ASC,
			  [MachineName] ASC
		)
END 