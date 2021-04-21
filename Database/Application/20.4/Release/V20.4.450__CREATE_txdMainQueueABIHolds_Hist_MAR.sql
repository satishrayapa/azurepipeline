IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'txdMainQueueABIHolds' and type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.txdMainQueueABIHolds(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[QueueGUID] varchar(50) NOT NULL
	,[PGAMapGUID] varchar(50) NOT NULL
	,[MessageSender] varchar(50) NOT NULL
	,[MessageRecipient] varchar(50) NOT NULL
	,[MessageID] varchar(50) NOT NULL
	,[Created] datetime NOT NULL
	,[MessageOriginator] varchar(50) NOT NULL
	,[PurposeCode] varchar(50) NOT NULL
	,[MilestoneMessageRecipient] varchar(50) NOT NULL
	,[MilestoneMessageID] varchar(50) NOT NULL
	,[MilestoneTypeCode] varchar(50) NOT NULL
	,[MilestoneTimeDateTime] datetime NOT NULL
	,[MilestoneTimeTimeZone] varchar(50) NOT NULL
	,[MilestoneTimeWhichTime] varchar(50) NOT NULL
	,[UserDefinedChar1] varchar(50) NOT NULL
	,[UserDefinedChar2] varchar(50) NOT NULL
	,[UserDefinedChar3] varchar(50) NOT NULL
	,[UserDefinedChar4] varchar(50) NOT NULL
	,[Status] varchar(50) NOT NULL
	,[ExtractType] varchar(50) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_txdMainQueueABIHolds] 
ON txdMainQueueABIHolds 
(
	[PartnerId]
	,[QueueGUID] 
	,[PGAMapGUID] 
)

ALTER TABLE dbo.txdMainQueueABIHolds ADD CONSTRAINT [PK_txdMainQueueABIHolds] PRIMARY KEY
(
	[PartnerId] ASC
	,[QueueGUID] ASC
	,[PGAMapGUID] ASC
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'txdMainQueueABIHoldsHist' AND type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.txdMainQueueABIHoldsHist(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[QueueGUID] varchar(50) NOT NULL
	,[PGAMapGUID] varchar(50) NOT NULL
	,[MessageSender] varchar(50) NOT NULL
	,[MessageRecipient] varchar(50) NOT NULL
	,[MessageID] varchar(50) NOT NULL
	,[Created] datetime NOT NULL
	,[MessageOriginator] varchar(50) NOT NULL
	,[PurposeCode] varchar(50) NOT NULL
	,[MilestoneMessageRecipient] varchar(50) NOT NULL
	,[MilestoneMessageID] varchar(50) NOT NULL
	,[MilestoneTypeCode] varchar(50) NOT NULL
	,[MilestoneTimeDateTime] datetime NOT NULL
	,[MilestoneTimeTimeZone] varchar(50) NOT NULL
	,[MilestoneTimeWhichTime] varchar(50) NOT NULL
	,[UserDefinedChar1] varchar(50) NOT NULL
	,[UserDefinedChar2] varchar(50) NOT NULL
	,[UserDefinedChar3] varchar(50) NOT NULL
	,[UserDefinedChar4] varchar(50) NOT NULL
	,[Status] varchar(50) NOT NULL
	,[ExtractType] varchar(50) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_txdMainQueueABIHoldsHist] 
ON txdMainQueueABIHoldsHist 
(
	[PartnerId]
	,[QueueGUID] 
	,[PGAMapGUID] 
)

ALTER TABLE dbo.txdMainQueueABIHoldsHist ADD CONSTRAINT [PK_txdMainQueueABIHoldsHist] PRIMARY KEY
(
	[PartnerId] ASC
	,[EffDate] ASC
	,[QueueGUID] ASC
	,[PGAMapGUID] ASC
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'txdABIHoldAttributes' and type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.txdABIHoldAttributes(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[QueueGUID] varchar(50) NOT NULL
	,[QueueAttributeGUID] varchar(50) NOT NULL
	,[ReferenceIdType] varchar(50) NOT NULL
	,[ReferenceIdReference] varchar(50) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_txdABIHoldAttributes] 
ON txdABIHoldAttributes 
(
	[PartnerId]
	,[QueueGUID] 
	,[QueueAttributeGUID] 
)

ALTER TABLE dbo.txdABIHoldAttributes ADD CONSTRAINT [PK_txdABIHoldAttributes] PRIMARY KEY
(
	[PartnerId] ASC
	,[QueueGUID] ASC 
	,[QueueAttributeGUID] ASC
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'txdABIHoldAttributesHIST' and type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.txdABIHoldAttributesHIST(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[QueueGUID] varchar(50) NOT NULL
	,[QueueAttributeGUID] varchar(50) NOT NULL
	,[ReferenceIdType] varchar(50) NOT NULL
	,[ReferenceIdReference] varchar(50) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_txdABIHoldAttributesHIST] 
ON txdABIHoldAttributesHIST 
(
	[PartnerId]
	,[QueueGUID] 
	,[QueueAttributeGUID] 
)

ALTER TABLE dbo.txdABIHoldAttributesHIST ADD CONSTRAINT [PK_txdABIHoldAttributesHIST] PRIMARY KEY
(
	[PartnerId] ASC
	,[EffDate] ASC
	,[QueueGUID] ASC
	,[QueueAttributeGUID] ASC
)
END
GO