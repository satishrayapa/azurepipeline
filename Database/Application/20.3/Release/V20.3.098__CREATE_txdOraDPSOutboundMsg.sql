
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdOraDPSOutboundMsg' AND Type = 'U')
BEGIN   
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[txdOraDPSOutboundMsg](
	[PartnerID] [int] NOT NULL,
	[EffDate] [DATETIME] NOT NULL,
	[QueueGUID]	[varchar](50) NOT NULL,
	[InterfaceCode]	[varchar](50) NOT NULL,
	[CompanyID]	[varchar](50) NOT NULL,
	[TimeStamp]	DATETIME	NOT NULL,
    [ScreeningStatus]	[varchar](50) NOT NULL,
    [LastScreenedDate] 	DATETIME NOT NULL,				
	[APIMethod]	varchar(10)		NOT NULL,
	[Status]	varchar(50)		NOT NULL,
	[HTTPStatus]	varchar(255)		NOT NULL,	
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,

) CREATE NONCLUSTERED INDEX [IX_txdOraDPSOutboundMsg] ON txdOraDPSOutboundMsg ( 
 [PartnerId]
,[QueueGUID]
)
 ALTER TABLE [dbo].[txdOraDPSOutboundMsg] ADD CONSTRAINT [PK_txdOraDPSOutboundMsg] PRIMARY KEY 
        (
              [PartnerID] ASC,
              [QueueGUID] ASC
        )

END