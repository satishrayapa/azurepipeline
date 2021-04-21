IF EXISTS (select * from dbo.sysobjects where id = object_id(N'dbo.tmgPartnerConfig') 
AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
	PRINT 'Creating table...'
CREATE TABLE [dbo].[tmgPartnerConfig](
	[PartnerID] [int] NOT NULL,
	[Config] [xml] NULL,
	[LastWriteTime] [datetime] NULL,
 CONSTRAINT [PK_tmgPartnerConfig] PRIMARY KEY CLUSTERED 
(
	[PartnerID] ASC
) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

END