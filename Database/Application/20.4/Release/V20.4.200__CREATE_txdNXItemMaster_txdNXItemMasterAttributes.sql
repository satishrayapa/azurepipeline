--- txdNXItemMaster ---
IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'txdNXItemMaster' and type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.txdNXItemMaster(
	[PartnerID] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[QueueGUID] varchar(50) NOT NULL
	,[ProductCatalogNumber] varchar(50) NOT NULL
	,[PartyRoleCode] varchar(50) NOT NULL
	,[MemberId] varchar(50) NOT NULL
	,[ItemFunctionCode] varchar(50) NOT NULL
	,[ItemKey] varchar(50) NOT NULL
	,[ClassificationNumber] varchar(50) NOT NULL
	,[ClassificationDescription] varchar(250) NOT NULL
	,[CountryCode] varchar(10) NOT NULL
	,[Status] varchar(50) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	
	

) ON [PRIMARY]

ALTER TABLE dbo.txdNXItemMaster ADD CONSTRAINT [PK_txdNXItemMaster] PRIMARY KEY
(
	[PartnerID] ASC
	,[QueueGUID] ASC
)
END
GO

--- txdNXItemMasterAttributes ---
IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'txdNXItemMasterAttributes' and type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.txdNXItemMasterAttributes(
	[PartnerID] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[QueueGUID] varchar(50) NOT NULL
	,[QueueAttributeGUID] varchar(50) NOT NULL
	,[AttributeType] varchar(50) NOT NULL
	,[AttributeValue] varchar(250) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	

) ON [PRIMARY]

ALTER TABLE dbo.txdNXItemMasterAttributes ADD CONSTRAINT [PK_txdNXItemMasterAttributes] PRIMARY KEY
(
	[PartnerID] ASC
	,[QueueGUID] ASC
	,[QueueAttributeGUID] ASC
)
END
GO