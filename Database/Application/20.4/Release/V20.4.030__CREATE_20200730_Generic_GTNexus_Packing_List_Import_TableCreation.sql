IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportPackingList' and type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportPackingList(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[functionalAcknowledgeRequestTypeCode] varchar(255) NOT NULL
	,[isIncludeOriginalMessage] varchar(1) NOT NULL
	,[version] varchar(255) NOT NULL
	,[documentType] varchar(255) NOT NULL
	,[messageId] varchar(255) NOT NULL
	,[senderId] varchar(255) NOT NULL
	,[receiverId] varchar(255) NOT NULL
	,[count] NUMERIC(38, 20) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportPackingList] ON ttdStagingGeneric_GTNexus_Packing_List_ImportPackingList ( 
	 [PartnerId]
	,[PackingListGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportPackingList ADD CONSTRAINT [PK_ttdStagingGeneric_GTNexus_Packing_List_ImportPackingList] PRIMARY KEY
(
	[PartnerId] ASC
	,[PackingListGUID] ASC
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportPackingListHist' AND type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportPackingListHist(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[functionalAcknowledgeRequestTypeCode] varchar(255) NOT NULL
	,[isIncludeOriginalMessage] varchar(1) NOT NULL
	,[version] varchar(255) NOT NULL
	,[documentType] varchar(255) NOT NULL
	,[messageId] varchar(255) NOT NULL
	,[senderId] varchar(255) NOT NULL
	,[receiverId] varchar(255) NOT NULL
	,[count] NUMERIC(38, 20) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportPackingListHist] ON ttdStagingGeneric_GTNexus_Packing_List_ImportPackingListHist ( 
	 [PartnerId]
	,[PackingListGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportPackingListHist ADD CONSTRAINT [PK_ttdStagingGeneric_GTNexus_Packing_List_ImportPackingListHist] PRIMARY KEY
(
	[PartnerId] ASC
	,[EffDate] ASC
	,[PackingListGUID] ASC
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportpackingListDetail' AND type = 'U')
	BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportpackingListDetail(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[subMessageId] varchar(255) NOT NULL
	,[messageFunctionCode] varchar(255) NOT NULL
	,[redirectUrl] varchar(255) NOT NULL
	,[packingListNumber] varchar(255) NOT NULL
	,[packingListUid] NUMERIC(38, 20) NOT NULL
	,[revisionNumber] varchar(255) NOT NULL
	,[reopenCount] NUMERIC(38, 20) NOT NULL
	,[packingListFunctionCode] varchar(255) NOT NULL
	,[notes] varchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportpackingListDetail] ON ttdStagingGeneric_GTNexus_Packing_List_ImportpackingListDetail ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportpackingListDetail ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportpackingListDetail PRIMARY KEY
(
	[PartnerId] ASC
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportpackingListDetailHist' AND TYPE ='U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportpackingListDetailHist(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[subMessageId] varchar(255) NOT NULL
	,[messageFunctionCode] varchar(255) NOT NULL
	,[redirectUrl] varchar(255) NOT NULL
	,[packingListNumber] varchar(255) NOT NULL
	,[packingListUid] NUMERIC(38, 20) NOT NULL
	,[revisionNumber] varchar(255) NOT NULL
	,[reopenCount] NUMERIC(38, 20) NOT NULL
	,[packingListFunctionCode] varchar(255) NOT NULL
	,[notes] varchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportpackingListDetailHist] ON ttdStagingGeneric_GTNexus_Packing_List_ImportpackingListDetailHist ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportpackingListDetailHist ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportpackingListDetailHist PRIMARY KEY
(
	[PartnerId] ASC
	,[EffDate] ASC
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportsubscriptionEvent' AND TYPE ='U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportsubscriptionEvent(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL

	,[eventTypeCode] varchar(255) NOT NULL
	,[eventRoleCode] varchar(255) NOT NULL
	,[eventDate] datetime NOT NULL
	,[eventDateTime] datetime NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportsubscriptionEvent] ON ttdStagingGeneric_GTNexus_Packing_List_ImportsubscriptionEvent ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID])

ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportsubscriptionEvent ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportsubscriptionEvent PRIMARY KEY
(
	[PartnerId] ASC
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportsubscriptionEventHist' AND type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportsubscriptionEventHist(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL

	,[eventTypeCode] varchar(255) NOT NULL
	,[eventRoleCode] varchar(255) NOT NULL
	,[eventDate] datetime NOT NULL
	,[eventDateTime] datetime NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportsubscriptionEventHist] ON ttdStagingGeneric_GTNexus_Packing_List_ImportsubscriptionEventHist ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportsubscriptionEventHist ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportsubscriptionEventHist PRIMARY KEY
(
	[PartnerId] ASC
	,[EffDate] ASC
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportvalidationError' AND type ='U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportvalidationError(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[validationErrorGUID] varchar(50) NOT NULL
	,[text] varchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportvalidationError] ON ttdStagingGeneric_GTNexus_Packing_List_ImportvalidationError ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[validationErrorGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportvalidationError ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportvalidationError PRIMARY KEY
(
	[PartnerId] ASC
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[validationErrorGUID] ASC
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportvalidationErrorHist' AND TYPE ='U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportvalidationErrorHist(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[validationErrorGUID] varchar(50) NOT NULL
	,[text] varchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportvalidationErrorHist] ON ttdStagingGeneric_GTNexus_Packing_List_ImportvalidationErrorHist ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[validationErrorGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportvalidationErrorHist ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportvalidationErrorHist PRIMARY KEY
(
	[PartnerId] ASC
	,[EffDate] ASC
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[validationErrorGUID] ASC
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentDocumentDate' AND TYPE ='U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentDocumentDate(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[shipmentDocumentDateGUID] varchar(50) NOT NULL
	,[shipmentDocumentDateTypeCode] varchar(255) NOT NULL
	,[shipmentDocumentDateValue] datetime NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentDocumentDate] ON ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentDocumentDate ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[shipmentDocumentDateGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentDocumentDate ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentDocumentDate PRIMARY KEY
(
	[PartnerId] ASC
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[shipmentDocumentDateGUID] ASC)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentDocumentDateHist' AND TYPE ='U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentDocumentDateHist(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[shipmentDocumentDateGUID] varchar(50) NOT NULL
	,[shipmentDocumentDateTypeCode] varchar(255) NOT NULL
	,[shipmentDocumentDateValue] datetime NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentDocumentDateHist] ON ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentDocumentDateHist ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[shipmentDocumentDateGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentDocumentDateHist ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentDocumentDateHist PRIMARY KEY
(
	[PartnerId]
	,[EffDate] ASC
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[shipmentDocumentDateGUID] ASC
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportattachedNotes' AND TYPE = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportattachedNotes(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[attachedNotesGUID] varchar(50) NOT NULL
	,[notes] varchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportattachedNotes] ON ttdStagingGeneric_GTNexus_Packing_List_ImportattachedNotes ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[attachedNotesGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportattachedNotes ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportattachedNotes PRIMARY KEY
(
	[PartnerId] ASC
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[attachedNotesGUID] ASC
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportattachedNotesHist' AND TYPE ='U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportattachedNotesHist(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[attachedNotesGUID] varchar(50) NOT NULL
	,[notes] varchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportattachedNotesHist] ON ttdStagingGeneric_GTNexus_Packing_List_ImportattachedNotesHist ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[attachedNotesGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportattachedNotesHist ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportattachedNotesHist PRIMARY KEY
(
	[PartnerId] ASC
	,[EffDate] ASC
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[attachedNotesGUID] ASC
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportpackingListDetailReference' AND TYPE ='U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportpackingListDetailReference(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[packingListDetailReferenceGUID] varchar(50) NOT NULL
	,[type] varchar(255) NOT NULL
	,[value] varchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportpackingListDetailReference] ON ttdStagingGeneric_GTNexus_Packing_List_ImportpackingListDetailReference ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[packingListDetailReferenceGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportpackingListDetailReference ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportpackingListDetailReference PRIMARY KEY
(
	[PartnerId] ASC
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[packingListDetailReferenceGUID] ASC
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportpackingListDetailReferenceHist' AND TYPE ='U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportpackingListDetailReferenceHist(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[packingListDetailReferenceGUID] varchar(50) NOT NULL
	,[type] varchar(255) NOT NULL
	,[value] varchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportpackingListDetailReferenceHist] ON ttdStagingGeneric_GTNexus_Packing_List_ImportpackingListDetailReferenceHist ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[packingListDetailReferenceGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportpackingListDetailReferenceHist ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportpackingListDetailReferenceHist PRIMARY KEY
(
	[PartnerId] ASC
	,[EffDate] ASC
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[packingListDetailReferenceGUID] ASC
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportpackingListDetailParty' AND TYPE ='U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportpackingListDetailParty(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[packingListDetailPartyGUID] varchar(50) NOT NULL
	,[partyUid] NUMERIC(38, 20) NOT NULL
	,[partyRoleCode] varchar(255) NOT NULL
	,[memberId] NUMERIC(38, 20) NOT NULL
	,[divisionUid] NUMERIC(38, 20) NOT NULL
	,[name] varchar(255) NOT NULL
	,[longName] varchar(255) NOT NULL
	,[ContactName] varchar(255) NOT NULL
	,[emailAddress] varchar(255) NOT NULL
	,[phone] varchar(255) NOT NULL
	,[fax] varchar(255) NOT NULL
	,[department] varchar(255) NOT NULL
	,[region] varchar(255) NOT NULL
	,[addressUid] NUMERIC(38, 20) NOT NULL
	,[addressLine1] varchar(255) NOT NULL
	,[addressLine2] varchar(255) NOT NULL
	,[city] varchar(255) NOT NULL
	,[stateOrProvince] varchar(255) NOT NULL
	,[postalCodeNumber] varchar(255) NOT NULL
	,[countryCode] varchar(255) NOT NULL
	,[locationQualifierCode] varchar(255) NOT NULL
	,[locationCode] varchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportpackingListDetailParty] ON ttdStagingGeneric_GTNexus_Packing_List_ImportpackingListDetailParty ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[packingListDetailPartyGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportpackingListDetailParty ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportpackingListDetailParty PRIMARY KEY
(
	[PartnerId] ASC
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[packingListDetailPartyGUID] ASC
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportpackingListDetailPartyHist' AND TYPE ='U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportpackingListDetailPartyHist(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[packingListDetailPartyGUID] varchar(50) NOT NULL
	,[partyUid] NUMERIC(38, 20) NOT NULL
	,[partyRoleCode] varchar(255) NOT NULL
	,[memberId] NUMERIC(38, 20) NOT NULL
	,[divisionUid] NUMERIC(38, 20) NOT NULL
	,[name] varchar(255) NOT NULL
	,[longName] varchar(255) NOT NULL
	,[ContactName] varchar(255) NOT NULL
	,[emailAddress] varchar(255) NOT NULL
	,[phone] varchar(255) NOT NULL
	,[fax] varchar(255) NOT NULL
	,[department] varchar(255) NOT NULL
	,[region] varchar(255) NOT NULL
	,[addressUid] NUMERIC(38, 20) NOT NULL
	,[addressLine1] varchar(255) NOT NULL
	,[addressLine2] varchar(255) NOT NULL
	,[city] varchar(255) NOT NULL
	,[stateOrProvince] varchar(255) NOT NULL
	,[postalCodeNumber] varchar(255) NOT NULL
	,[countryCode] varchar(255) NOT NULL
	,[locationQualifierCode] varchar(255) NOT NULL
	,[locationCode] varchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportpackingListDetailPartyHist] ON ttdStagingGeneric_GTNexus_Packing_List_ImportpackingListDetailPartyHist ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[packingListDetailPartyGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportpackingListDetailPartyHist ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportpackingListDetailPartyHist PRIMARY KEY
(
	[PartnerId] ASC
	,[EffDate] ASC
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[packingListDetailPartyGUID] ASC
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportpackingListDetailPartyIdentification' AND TYPE ='U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportpackingListDetailPartyIdentification(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[packingListDetailPartyGUID] varchar(50) NOT NULL
	,[packingListDetailPartyIdentificationGUID] varchar(50) NOT NULL
	,[type] varchar(255) NOT NULL
	,[value] varchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportpackingListDetailPartyIdentification] ON ttdStagingGeneric_GTNexus_Packing_List_ImportpackingListDetailPartyIdentification ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[packingListDetailPartyGUID]
	,[packingListDetailPartyIdentificationGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportpackingListDetailPartyIdentification ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportpackingListDetailPartyIdentification PRIMARY KEY
(
	[PartnerId] ASC
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[packingListDetailPartyGUID] ASC
	,[packingListDetailPartyIdentificationGUID] ASC
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportpackingListDetailPartyIdentificationHist' AND TYPE ='U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportpackingListDetailPartyIdentificationHist(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[packingListDetailPartyGUID] varchar(50) NOT NULL
	,[packingListDetailPartyIdentificationGUID] varchar(50) NOT NULL
	,[type] varchar(255) NOT NULL
	,[value] varchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportpackingListDetailPartyIdentificationHist] ON ttdStagingGeneric_GTNexus_Packing_List_ImportpackingListDetailPartyIdentificationHist ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[packingListDetailPartyGUID]
	,[packingListDetailPartyIdentificationGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportpackingListDetailPartyIdentificationHist ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportpackingListDetailPartyIdentificationHist PRIMARY KEY
(
	[PartnerId] ASC
	,[EffDate] ASC
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[packingListDetailPartyGUID] ASC
	,[packingListDetailPartyIdentificationGUID] ASC
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportpackingListDetailPartyReference' AND TYPE ='U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportpackingListDetailPartyReference(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[packingListDetailPartyGUID] varchar(50) NOT NULL
	,[packingListDetailPartyReferenceGUID] varchar(50) NOT NULL
	,[type] varchar(255) NOT NULL
	,[value] varchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportpackingListDetailPartyReference] ON ttdStagingGeneric_GTNexus_Packing_List_ImportpackingListDetailPartyReference ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[packingListDetailPartyGUID]
	,[packingListDetailPartyReferenceGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportpackingListDetailPartyReference ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportpackingListDetailPartyReference PRIMARY KEY
(
	[PartnerId] ASC
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[packingListDetailPartyGUID] ASC 
	,[packingListDetailPartyReferenceGUID] ASC
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportpackingListDetailPartyReferenceHist' AND TYPE ='U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportpackingListDetailPartyReferenceHist(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[packingListDetailPartyGUID] varchar(50) NOT NULL
	,[packingListDetailPartyReferenceGUID] varchar(50) NOT NULL
	,[type] varchar(255) NOT NULL
	,[value] varchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportpackingListDetailPartyReferenceHist] ON ttdStagingGeneric_GTNexus_Packing_List_ImportpackingListDetailPartyReferenceHist ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[packingListDetailPartyGUID]
	,[packingListDetailPartyReferenceGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportpackingListDetailPartyReferenceHist ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportpackingListDetailPartyReferenceHist PRIMARY KEY
(
	[PartnerId] ASC
	,[EffDate] ASC
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[packingListDetailPartyGUID] ASC 
	,[packingListDetailPartyReferenceGUID] ASC
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_Importshipment' AND TYPE ='U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_Importshipment(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[shipmentGUID] varchar(50) NOT NULL
	,[shipmentNumber] varchar(255) NOT NULL
	,[shipmentUid] NUMERIC(38, 20) NOT NULL
	,[carrierBookingNumber] varchar(255) NOT NULL
	,[cargoReceiptNumber] varchar(255) NOT NULL
	,[masterBillOfLadingNumber] varchar(255) NOT NULL
	,[houseBillOfLadingNumber] varchar(255) NOT NULL
	,[authorizationNumber] varchar(255) NOT NULL
	,[freightPaymentCode] varchar(255) NOT NULL
	,[equipmentLoadTypeCode] varchar(255) NOT NULL
	,[notes] varchar(255) NOT NULL
	,[totalPackageQuantity] NUMERIC(38, 20) NOT NULL
	,[packMethodCode] varchar(255) NOT NULL
	,[weightUnitCode] varchar(255) NOT NULL
	,[totalGrossWeight] numeric(38,20) NOT NULL
	,[totalNetWeight] numeric(38,20) NOT NULL
	,[totalNetNetWeight] numeric(38,20) NOT NULL
	,[volumeUnitCode] varchar(255) NOT NULL
	,[totalGrossVolume] numeric(38,20) NOT NULL
	,[volumeWeightUnitCode] varchar(255) NOT NULL
	,[totalVolumeWeight] numeric(38,20) NOT NULL
	,[SummaryTotalPackageQuantity] NUMERIC(38, 20) NOT NULL
	,[SummaryPackMethodCode] varchar(255) NOT NULL
	,[SummaryWeightUnitCode] varchar(255) NOT NULL
	,[SummaryTotalGrossWeight] numeric(38,20) NOT NULL
	,[SummaryTotalNetWeight] numeric(38,20) NOT NULL
	,[SummaryTotalNetNetWeight] numeric(38,20) NOT NULL
	,[SummaryVolumeUnitCode] varchar(255) NOT NULL
	,[SummaryTotalGrossVolume] numeric(38,20) NOT NULL
	,[SummaryVolumeWeightUnitCode] varchar(255) NOT NULL
	,[SummaryTotalVolumeWeight] numeric(38,20) NOT NULL
	,[totalAllowanceChargeAmount] numeric(38,20) NOT NULL
	,[totalMerchandiseAmount] numeric(38,20) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_Importshipment] ON ttdStagingGeneric_GTNexus_Packing_List_Importshipment ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[shipmentGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_Importshipment ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_Importshipment PRIMARY KEY
(
	[PartnerId] ASC
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[shipmentGUID] ASC
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentHist' AND TYPE ='U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentHist(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[shipmentGUID] varchar(50) NOT NULL
	,[shipmentNumber] varchar(255) NOT NULL
	,[shipmentUid] NUMERIC(38, 20) NOT NULL
	,[carrierBookingNumber] varchar(255) NOT NULL
	,[cargoReceiptNumber] varchar(255) NOT NULL
	,[masterBillOfLadingNumber] varchar(255) NOT NULL
	,[houseBillOfLadingNumber] varchar(255) NOT NULL
	,[authorizationNumber] varchar(255) NOT NULL
	,[freightPaymentCode] varchar(255) NOT NULL
	,[equipmentLoadTypeCode] varchar(255) NOT NULL
	,[notes] varchar(255) NOT NULL
	,[totalPackageQuantity] NUMERIC(38, 20) NOT NULL
	,[packMethodCode] varchar(255) NOT NULL
	,[weightUnitCode] varchar(255) NOT NULL
	,[totalGrossWeight] numeric(38,20) NOT NULL
	,[totalNetWeight] numeric(38,20) NOT NULL
	,[totalNetNetWeight] numeric(38,20) NOT NULL
	,[volumeUnitCode] varchar(255) NOT NULL
	,[totalGrossVolume] numeric(38,20) NOT NULL
	,[volumeWeightUnitCode] varchar(255) NOT NULL
	,[totalVolumeWeight] numeric(38,20) NOT NULL
	,[SummaryTotalPackageQuantity] NUMERIC(38, 20) NOT NULL
	,[SummaryPackMethodCode] varchar(255) NOT NULL
	,[SummaryWeightUnitCode] varchar(255) NOT NULL
	,[SummaryTotalGrossWeight] numeric(38,20) NOT NULL
	,[SummaryTotalNetWeight] numeric(38,20) NOT NULL
	,[SummaryTotalNetNetWeight] numeric(38,20) NOT NULL
	,[SummaryVolumeUnitCode] varchar(255) NOT NULL
	,[SummaryTotalGrossVolume] numeric(38,20) NOT NULL
	,[SummaryVolumeWeightUnitCode] varchar(255) NOT NULL
	,[SummaryTotalVolumeWeight] numeric(38,20) NOT NULL
	,[totalAllowanceChargeAmount] numeric(38,20) NOT NULL
	,[totalMerchandiseAmount] numeric(38,20) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentHist] ON ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentHist ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[shipmentGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentHist ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentHist PRIMARY KEY
(
	[PartnerId] ASC
	,[EffDate] ASC
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[shipmentGUID] ASC
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentReference' AND TYPE ='U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentReference(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[shipmentGUID] varchar(50) NOT NULL
	,[shipmentReferenceGUID] varchar(50) NOT NULL
	,[type] varchar(255) NOT NULL
	,[value] varchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentReference] ON ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentReference ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[shipmentGUID]
	,[shipmentReferenceGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentReference ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentReference PRIMARY KEY
(
	[PartnerId] ASC
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[shipmentGUID] asc
	,[shipmentReferenceGUID] asc
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentReferenceHist' AND TYPE ='U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentReferenceHist(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[shipmentGUID] varchar(50) NOT NULL
	,[shipmentReferenceGUID] varchar(50) NOT NULL
	,[type] varchar(255) NOT NULL
	,[value] varchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentReferenceHist] ON ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentReferenceHist ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[shipmentGUID]
	,[shipmentReferenceGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentReferenceHist ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentReferenceHist PRIMARY KEY
(
	[PartnerId] ASC
	,[EffDate] asc
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[shipmentGUID] asc
	,[shipmentReferenceGUID] asc
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportinvoiceReference' AND TYPE ='U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportinvoiceReference(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[shipmentGUID] varchar(50) NOT NULL
	,[invoiceReferenceGUID] varchar(50) NOT NULL
	,[invoiceNumber] varchar(255) NOT NULL
	,[invoiceUid] NUMERIC(38, 20) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportinvoiceReference] ON ttdStagingGeneric_GTNexus_Packing_List_ImportinvoiceReference ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[shipmentGUID]
	,[invoiceReferenceGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportinvoiceReference ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportinvoiceReference PRIMARY KEY
(
	[PartnerId] ASC
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[shipmentGUID] asc
	,[invoiceReferenceGUID] asc
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportinvoiceReferenceHist' AND type ='U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportinvoiceReferenceHist(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[shipmentGUID] varchar(50) NOT NULL
	,[invoiceReferenceGUID] varchar(50) NOT NULL
	,[invoiceNumber] varchar(255) NOT NULL
	,[invoiceUid] NUMERIC(38, 20) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportinvoiceReferenceHist] ON ttdStagingGeneric_GTNexus_Packing_List_ImportinvoiceReferenceHist ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[shipmentGUID]
	,[invoiceReferenceGUID])
	ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportinvoiceReferenceHist ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportinvoiceReferenceHist PRIMARY KEY
(
	[PartnerId] ASC
	,[EffDate] asc
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[shipmentGUID] asc
	,[invoiceReferenceGUID] asc
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportShipmentInvoiceReference' AND TYPE ='U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportShipmentInvoiceReference(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[shipmentGUID] varchar(50) NOT NULL
	,[invoiceReferenceGUID] varchar(50) NOT NULL
	,[ShipmentInvoiceReferenceGUID] varchar(50) NOT NULL
	,[type] varchar(255) NOT NULL
	,[value] varchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportShipmentInvoiceReference] ON ttdStagingGeneric_GTNexus_Packing_List_ImportShipmentInvoiceReference ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[shipmentGUID]
	,[invoiceReferenceGUID]
	,[ShipmentInvoiceReferenceGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportShipmentInvoiceReference ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportShipmentInvoiceReference PRIMARY KEY
(
	[PartnerId] ASC
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[shipmentGUID] asc
	,[invoiceReferenceGUID] asc
	,[ShipmentInvoiceReferenceGUID] asc
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportShipmentInvoiceReferenceHist' AND TYPE ='U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportShipmentInvoiceReferenceHist(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[shipmentGUID] varchar(50) NOT NULL
	,[invoiceReferenceGUID] varchar(50) NOT NULL
	,[ShipmentInvoiceReferenceGUID] varchar(50) NOT NULL
	,[type] varchar(255) NOT NULL
	,[value] varchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportShipmentInvoiceReferenceHist] ON ttdStagingGeneric_GTNexus_Packing_List_ImportShipmentInvoiceReferenceHist ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[shipmentGUID]
	,[invoiceReferenceGUID]
	,[ShipmentInvoiceReferenceGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportShipmentInvoiceReferenceHist ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportShipmentInvoiceReferenceHist PRIMARY KEY
(
	[PartnerId] ASC
	,[EffDate] asc
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[shipmentGUID] asc
	,[invoiceReferenceGUID] asc
	,[ShipmentInvoiceReferenceGUID] asc
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentParty' AND TYPE ='U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentParty(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[shipmentGUID] varchar(50) NOT NULL
	,[shipmentPartyGUID] varchar(50) NOT NULL
	,[partyUid] NUMERIC(38, 20) NOT NULL
	,[partyRoleCode] varchar(255) NOT NULL
	,[memberId] NUMERIC(38, 20) NOT NULL
	,[divisionUid] NUMERIC(38, 20) NOT NULL
	,[name] varchar(255) NOT NULL
	,[longName] varchar(255) NOT NULL
	,[ContactName] varchar(255) NOT NULL
	,[emailAddress] varchar(255) NOT NULL
	,[phone] varchar(255) NOT NULL
	,[fax] varchar(255) NOT NULL
	,[department] varchar(255) NOT NULL
	,[region] varchar(255) NOT NULL
	,[addressUid] NUMERIC(38, 20) NOT NULL
	,[addressLine1] varchar(255) NOT NULL
	,[addressLine2] varchar(255) NOT NULL
	,[city] varchar(255) NOT NULL
	,[stateOrProvince] varchar(255) NOT NULL
	,[postalCodeNumber] varchar(255) NOT NULL
	,[countryCode] varchar(255) NOT NULL
	,[locationQualifierCode] varchar(255) NOT NULL
	,[locationCode] varchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentParty] ON ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentParty ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[shipmentGUID]
	,[shipmentPartyGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentParty ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentParty PRIMARY KEY
(
	[PartnerId] ASC
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[shipmentGUID] asc 
	,[shipmentPartyGUID] asc
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentPartyHist' AND TYPE ='U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentPartyHist(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[shipmentGUID] varchar(50) NOT NULL
	,[shipmentPartyGUID] varchar(50) NOT NULL
	,[partyUid] NUMERIC(38, 20) NOT NULL
	,[partyRoleCode] varchar(255) NOT NULL
	,[memberId] NUMERIC(38, 20) NOT NULL
	,[divisionUid] NUMERIC(38, 20) NOT NULL
	,[name] varchar(255) NOT NULL
	,[longName] varchar(255) NOT NULL
	,[ContactName] varchar(255) NOT NULL
	,[emailAddress] varchar(255) NOT NULL
	,[phone] varchar(255) NOT NULL
	,[fax] varchar(255) NOT NULL
	,[department] varchar(255) NOT NULL
	,[region] varchar(255) NOT NULL
	,[addressUid] NUMERIC(38, 20) NOT NULL
	,[addressLine1] varchar(255) NOT NULL
	,[addressLine2] varchar(255) NOT NULL
	,[city] varchar(255) NOT NULL
	,[stateOrProvince] varchar(255) NOT NULL
	,[postalCodeNumber] varchar(255) NOT NULL
	,[countryCode] varchar(255) NOT NULL
	,[locationQualifierCode] varchar(255) NOT NULL
	,[locationCode] varchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentPartyHist] ON ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentPartyHist ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[shipmentGUID]
	,[shipmentPartyGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentPartyHist ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentPartyHist PRIMARY KEY
(
	[PartnerId] ASC
	,[EffDate] asc
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[shipmentGUID] asc 
	,[shipmentPartyGUID] asc
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentPartyIdentification' AND TYPE ='U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentPartyIdentification(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[shipmentGUID] varchar(50) NOT NULL
	,[shipmentPartyGUID] varchar(50) NOT NULL
	,[shipmentPartyIdentificationGUID] varchar(50) NOT NULL
	,[type] varchar(255) NOT NULL
	,[value] varchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentPartyIdentification] ON ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentPartyIdentification ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[shipmentGUID]
	,[shipmentPartyGUID]
	,[shipmentPartyIdentificationGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentPartyIdentification ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentPartyIdentification PRIMARY KEY
(
	[PartnerId] ASC
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[shipmentGUID] asc 
	,[shipmentPartyGUID] asc 
	,[shipmentPartyIdentificationGUID] asc

)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentPartyIdentificationHist' AND type ='U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentPartyIdentificationHist(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[shipmentGUID] varchar(50) NOT NULL
	,[shipmentPartyGUID] varchar(50) NOT NULL
	,[shipmentPartyIdentificationGUID] varchar(50) NOT NULL
	,[type] varchar(255) NOT NULL
	,[value] varchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentPartyIdentificationHist] ON ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentPartyIdentificationHist ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[shipmentGUID]
	,[shipmentPartyGUID]
	,[shipmentPartyIdentificationGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentPartyIdentificationHist ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentPartyIdentificationHist PRIMARY KEY
(
	[PartnerId] ASC
	,[EffDate] asc
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[shipmentGUID] asc 
	,[shipmentPartyGUID] asc 
	,[shipmentPartyIdentificationGUID] asc

)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentPartyReference' AND type ='U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentPartyReference(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[shipmentGUID] varchar(50) NOT NULL
	,[shipmentPartyGUID] varchar(50) NOT NULL
	,[shipmentPartyReferenceGUID] varchar(50) NOT NULL
	,[type] varchar(255) NOT NULL
	,[value] varchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentPartyReference] ON ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentPartyReference ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[shipmentGUID]
	,[shipmentPartyGUID]
	,[shipmentPartyReferenceGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentPartyReference ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentPartyReference PRIMARY KEY
(
	[PartnerId] ASC
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[shipmentGUID] asc
	,[shipmentPartyGUID] asc
	,[shipmentPartyReferenceGUID] asc
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentPartyReferenceHist' AND type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentPartyReferenceHist(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[shipmentGUID] varchar(50) NOT NULL
	,[shipmentPartyGUID] varchar(50) NOT NULL
	,[shipmentPartyReferenceGUID] varchar(50) NOT NULL
	,[type] varchar(255) NOT NULL
	,[value] varchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentPartyReferenceHist] ON ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentPartyReferenceHist ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[shipmentGUID]
	,[shipmentPartyGUID]
	,[shipmentPartyReferenceGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentPartyReferenceHist ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentPartyReferenceHist PRIMARY KEY
(
	[PartnerId] ASC
	,[EffDate] asc
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[shipmentGUID] asc
	,[shipmentPartyGUID] asc
	,[shipmentPartyReferenceGUID] asc
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentyOrderXref' AND type ='U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentyOrderXref(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[shipmentGUID] varchar(50) NOT NULL
	,[shipmentyOrderXrefGUID] varchar(50) NOT NULL
	,[shipmentOrderKey] varchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentyOrderXref] ON ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentyOrderXref ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[shipmentGUID]
	,[shipmentyOrderXrefGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentyOrderXref ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentyOrderXref PRIMARY KEY
(
	[PartnerId] ASC
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[shipmentGUID] asc
	,[shipmentyOrderXrefGUID] asc
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentyOrderXrefHist' AND type ='U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentyOrderXrefHist(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[shipmentGUID] varchar(50) NOT NULL
	,[shipmentyOrderXrefGUID] varchar(50) NOT NULL
	,[shipmentOrderKey] varchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentyOrderXrefHist] ON ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentyOrderXrefHist ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[shipmentGUID]
	,[shipmentyOrderXrefGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentyOrderXrefHist ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentyOrderXrefHist PRIMARY KEY
(
	[PartnerId] ASC
	,[EffDate] asc
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[shipmentGUID] asc
	,[shipmentyOrderXrefGUID] asc
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentItemXref' AND type ='U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentItemXref(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[shipmentGUID] varchar(50) NOT NULL
	,[shipmentItemXrefGUID] varchar(50) NOT NULL
	,[poNumber] varchar(255) NOT NULL
	,[itemKey] varchar(255) NOT NULL
	,[itemTypeCode] varchar(255) NOT NULL
	,[quantity] numeric(38,20) NOT NULL
	,[packInstructionReference] varchar(255) NOT NULL
	,[packageType] varchar(255) NOT NULL
	,[packMethodCode] varchar(255) NOT NULL
	,[quantityPerInnerPackage] NUMERIC(38, 20) NOT NULL
	,[quantityPerOuterPackage] NUMERIC(38, 20) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentItemXref] ON ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentItemXref ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[shipmentGUID]
	,[shipmentItemXrefGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentItemXref ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentItemXref PRIMARY KEY
(
	[PartnerId] ASC
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[shipmentGUID] asc
	,[shipmentItemXrefGUID] asc
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentItemXrefHist' AND type ='U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentItemXrefHist(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[shipmentGUID] varchar(50) NOT NULL
	,[shipmentItemXrefGUID] varchar(50) NOT NULL
	,[poNumber] varchar(255) NOT NULL
	,[itemKey] varchar(255) NOT NULL
	,[itemTypeCode] varchar(255) NOT NULL
	,[quantity] numeric(38,20) NOT NULL
	,[packInstructionReference] varchar(255) NOT NULL
	,[packageType] varchar(255) NOT NULL
	,[packMethodCode] varchar(255) NOT NULL
	,[quantityPerInnerPackage] NUMERIC(38, 20) NOT NULL
	,[quantityPerOuterPackage] NUMERIC(38, 20) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentItemXrefHist] ON ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentItemXrefHist ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[shipmentGUID]
	,[shipmentItemXrefGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentItemXrefHist ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentItemXrefHist PRIMARY KEY
(
	[PartnerId] ASC
	,[EffDate] asc
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[shipmentGUID] asc
	,[shipmentItemXrefGUID] asc
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentDate' AND type ='U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentDate(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[shipmentGUID] varchar(50) NOT NULL
	,[shipmentDateGUID] varchar(50) NOT NULL
	,[shipmentDateTypeCode] varchar(255) NOT NULL
	,[shipmentDateValue] datetime NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentDate] ON ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentDate ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[shipmentGUID]
	,[shipmentDateGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentDate ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentDate PRIMARY KEY
(
	[PartnerId] ASC
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[shipmentGUID] asc
	,[shipmentDateGUID] asc
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentDateHist' AND type ='U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentDateHist(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[shipmentGUID] varchar(50) NOT NULL
	,[shipmentDateGUID] varchar(50) NOT NULL
	,[shipmentDateTypeCode] varchar(255) NOT NULL
	,[shipmentDateValue] datetime NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentDateHist] ON ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentDateHist ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[shipmentGUID]
	,[shipmentDateGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentDateHist ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentDateHist PRIMARY KEY
(
	[PartnerId] ASC
	,[EffDate] asc
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[shipmentGUID] asc
	,[shipmentDateGUID] asc
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentRoute' and type ='U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentRoute(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[shipmentGUID] varchar(50) NOT NULL
	,[shipmentRouteGUID] varchar(50) NOT NULL
	,[shipmentStageTypeCode] varchar(255) NOT NULL
	,[shipmentMethodCode] varchar(255) NOT NULL
	,[transitDirection] varchar(255) NOT NULL
	,[transitUnitCode] varchar(255) NOT NULL
	,[transitUnitValue] numeric(38,20) NOT NULL
	,[notes] varchar(255) NOT NULL
	,[shipmentDateTypeCode] varchar(255) NOT NULL
	,[shipmentDateValue] datetime NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentRoute] ON ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentRoute ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[shipmentGUID]
	,[shipmentRouteGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentRoute ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentRoute PRIMARY KEY
(
	[PartnerId] ASC
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[shipmentGUID] asc
	,[shipmentRouteGUID] asc
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentRouteHist' AND type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentRouteHist(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[shipmentGUID] varchar(50) NOT NULL
	,[shipmentRouteGUID] varchar(50) NOT NULL
	,[shipmentStageTypeCode] varchar(255) NOT NULL
	,[shipmentMethodCode] varchar(255) NOT NULL
	,[transitDirection] varchar(255) NOT NULL
	,[transitUnitCode] varchar(255) NOT NULL
	,[transitUnitValue] numeric(38,20) NOT NULL
	,[notes] varchar(255) NOT NULL
	,[shipmentDateTypeCode] varchar(255) NOT NULL
	,[shipmentDateValue] datetime NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentRouteHist] ON ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentRouteHist ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[shipmentGUID]
	,[shipmentRouteGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentRouteHist ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentRouteHist PRIMARY KEY
(
	[PartnerId] ASC
	,[EffDate] asc
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[shipmentGUID] asc
	,[shipmentRouteGUID] asc
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentRoutLocation' AND type ='U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentRoutLocation(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[shipmentGUID] varchar(50) NOT NULL
	,[shipmentRouteGUID] varchar(50) NOT NULL
	,[shipmentRoutLocationGUID] varchar(50) NOT NULL
	,[partyUid] NUMERIC(38, 20) NOT NULL
	,[partyRoleCode] varchar(255) NOT NULL
	,[memberId] NUMERIC(38, 20) NOT NULL
	,[divisionUid] NUMERIC(38, 20) NOT NULL
	,[name] varchar(255) NOT NULL
	,[longName] varchar(255) NOT NULL
	,[ContactName] varchar(255) NOT NULL
	,[emailAddress] varchar(255) NOT NULL
	,[phone] varchar(255) NOT NULL
	,[fax] varchar(255) NOT NULL
	,[department] varchar(255) NOT NULL
	,[region] varchar(255) NOT NULL
	,[addressUid] NUMERIC(38, 20) NOT NULL
	,[addressLine1] varchar(255) NOT NULL
	,[addressLine2] varchar(255) NOT NULL
	,[city] varchar(255) NOT NULL
	,[stateOrProvince] varchar(255) NOT NULL
	,[postalCodeNumber] varchar(255) NOT NULL
	,[countryCode] varchar(255) NOT NULL
	,[locationQualifierCode] varchar(255) NOT NULL
	,[locationCode] varchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentRoutLocation] ON ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentRoutLocation ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[shipmentGUID]
	,[shipmentRouteGUID]
	,[shipmentRoutLocationGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentRoutLocation ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentRoutLocation PRIMARY KEY
(
	[PartnerId] ASC
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[shipmentGUID] asc
	,[shipmentRouteGUID] asc
	,[shipmentRoutLocationGUID] asc
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentRoutLocationHist' AND type ='U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentRoutLocationHist(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[shipmentGUID] varchar(50) NOT NULL
	,[shipmentRouteGUID] varchar(50) NOT NULL
	,[shipmentRoutLocationGUID] varchar(50) NOT NULL
	,[partyUid] NUMERIC(38, 20) NOT NULL
	,[partyRoleCode] varchar(255) NOT NULL
	,[memberId] NUMERIC(38, 20) NOT NULL
	,[divisionUid] NUMERIC(38, 20) NOT NULL
	,[name] varchar(255) NOT NULL
	,[longName] varchar(255) NOT NULL
	,[ContactName] varchar(255) NOT NULL
	,[emailAddress] varchar(255) NOT NULL
	,[phone] varchar(255) NOT NULL
	,[fax] varchar(255) NOT NULL
	,[department] varchar(255) NOT NULL
	,[region] varchar(255) NOT NULL
	,[addressUid] NUMERIC(38, 20) NOT NULL
	,[addressLine1] varchar(255) NOT NULL
	,[addressLine2] varchar(255) NOT NULL
	,[city] varchar(255) NOT NULL
	,[stateOrProvince] varchar(255) NOT NULL
	,[postalCodeNumber] varchar(255) NOT NULL
	,[countryCode] varchar(255) NOT NULL
	,[locationQualifierCode] varchar(255) NOT NULL
	,[locationCode] varchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentRoutLocationHist] ON ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentRoutLocationHist ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[shipmentGUID]
	,[shipmentRouteGUID]
	,[shipmentRoutLocationGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentRoutLocationHist ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentRoutLocationHist PRIMARY KEY
(
	[PartnerId] ASC
	,[EffDate] asc
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[shipmentGUID] asc
	,[shipmentRouteGUID] asc
	,[shipmentRoutLocationGUID] asc
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportRoutIdentification' AND type ='U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportRoutIdentification(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[shipmentGUID] varchar(50) NOT NULL
	,[shipmentRouteGUID] varchar(50) NOT NULL
	,[shipmentRoutLocationGUID] varchar(50) NOT NULL
	,[RoutIdentificationGUID] varchar(50) NOT NULL
	,[type] varchar(255) NOT NULL
	,[value] varchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportRoutIdentification] ON ttdStagingGeneric_GTNexus_Packing_List_ImportRoutIdentification ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[shipmentGUID]
	,[shipmentRouteGUID]
	,[shipmentRoutLocationGUID]
	,[RoutIdentificationGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportRoutIdentification ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportRoutIdentification PRIMARY KEY
(
	[PartnerId] ASC
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[shipmentGUID] asc
	,[shipmentRouteGUID] asc
	,[shipmentRoutLocationGUID] asc
	,[RoutIdentificationGUID] asc
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportRoutIdentificationHist' AND type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportRoutIdentificationHist(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[shipmentGUID] varchar(50) NOT NULL
	,[shipmentRouteGUID] varchar(50) NOT NULL
	,[shipmentRoutLocationGUID] varchar(50) NOT NULL
	,[RoutIdentificationGUID] varchar(50) NOT NULL
	,[type] varchar(255) NOT NULL
	,[value] varchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportRoutIdentificationHist] ON ttdStagingGeneric_GTNexus_Packing_List_ImportRoutIdentificationHist ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[shipmentGUID]
	,[shipmentRouteGUID]
	,[shipmentRoutLocationGUID]
	,[RoutIdentificationGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportRoutIdentificationHist ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportRoutIdentificationHist PRIMARY KEY
(
	[PartnerId] ASC
	,[EffDate] asc
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[shipmentGUID] asc
	,[shipmentRouteGUID] asc
	,[shipmentRoutLocationGUID] asc
	,[RoutIdentificationGUID] asc
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportShipmentRoutReference' AND type ='U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportShipmentRoutReference(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[shipmentGUID] varchar(50) NOT NULL
	,[shipmentRouteGUID] varchar(50) NOT NULL
	,[shipmentRoutLocationGUID] varchar(50) NOT NULL
	,[ShipmentRoutReferenceGUID] varchar(50) NOT NULL
	,[type] varchar(255) NOT NULL
	,[value] varchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportShipmentRoutReference] ON ttdStagingGeneric_GTNexus_Packing_List_ImportShipmentRoutReference ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[shipmentGUID]
	,[shipmentRouteGUID]
	,[shipmentRoutLocationGUID]
	,[ShipmentRoutReferenceGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportShipmentRoutReference ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportShipmentRoutReference PRIMARY KEY
(
	[PartnerId] ASC
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[shipmentGUID] asc
	,[shipmentRouteGUID] asc
	,[shipmentRoutLocationGUID] asc
	,[ShipmentRoutReferenceGUID] asc
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportShipmentRoutReferenceHist' AND type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportShipmentRoutReferenceHist(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[shipmentGUID] varchar(50) NOT NULL
	,[shipmentRouteGUID] varchar(50) NOT NULL
	,[shipmentRoutLocationGUID] varchar(50) NOT NULL
	,[ShipmentRoutReferenceGUID] varchar(50) NOT NULL
	,[type] varchar(255) NOT NULL
	,[value] varchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportShipmentRoutReferenceHist] ON ttdStagingGeneric_GTNexus_Packing_List_ImportShipmentRoutReferenceHist ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[shipmentGUID]
	,[shipmentRouteGUID]
	,[shipmentRoutLocationGUID]
	,[ShipmentRoutReferenceGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportShipmentRoutReferenceHist ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportShipmentRoutReferenceHist PRIMARY KEY
(
	[PartnerId] ASC
	,[EffDate] asc
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[shipmentGUID] asc
	,[shipmentRouteGUID] asc
	,[shipmentRoutLocationGUID] asc
	,[ShipmentRoutReferenceGUID] asc
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentPartyCarrier' AND type ='U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentPartyCarrier(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[shipmentGUID] varchar(50) NOT NULL
	,[shipmentRouteGUID] varchar(50) NOT NULL
	,[shipmentPartyCarrierGUID] varchar(50) NOT NULL
	,[partyUid] NUMERIC(38, 20) NOT NULL
	,[partyRoleCode] varchar(255) NOT NULL
	,[memberId] NUMERIC(38, 20) NOT NULL
	,[divisionUid] NUMERIC(38, 20) NOT NULL
	,[name] varchar(255) NOT NULL
	,[longName] varchar(255) NOT NULL
	,[ContactName] varchar(255) NOT NULL
	,[emailAddress] varchar(255) NOT NULL
	,[phone] varchar(255) NOT NULL
	,[fax] varchar(255) NOT NULL
	,[department] varchar(255) NOT NULL
	,[region] varchar(255) NOT NULL
	,[addressUid] NUMERIC(38, 20) NOT NULL
	,[addressLine1] varchar(255) NOT NULL
	,[addressLine2] varchar(255) NOT NULL
	,[city] varchar(255) NOT NULL
	,[stateOrProvince] varchar(255) NOT NULL
	,[postalCodeNumber] varchar(255) NOT NULL
	,[countryCode] varchar(255) NOT NULL
	,[locationQualifierCode] varchar(255) NOT NULL
	,[locationCode] varchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentPartyCarrier] ON ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentPartyCarrier ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[shipmentGUID]
	,[shipmentRouteGUID]
	,[shipmentPartyCarrierGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentPartyCarrier ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentPartyCarrier PRIMARY KEY
(
	[PartnerId] ASC
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[shipmentGUID] asc
	,[shipmentRouteGUID] asc
	,[shipmentPartyCarrierGUID] asc
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentPartyCarrierHist' AND type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentPartyCarrierHist(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[shipmentGUID] varchar(50) NOT NULL
	,[shipmentRouteGUID] varchar(50) NOT NULL
	,[shipmentPartyCarrierGUID] varchar(50) NOT NULL
	,[partyUid] NUMERIC(38, 20) NOT NULL
	,[partyRoleCode] varchar(255) NOT NULL
	,[memberId] NUMERIC(38, 20) NOT NULL
	,[divisionUid] NUMERIC(38, 20) NOT NULL
	,[name] varchar(255) NOT NULL
	,[longName] varchar(255) NOT NULL
	,[ContactName] varchar(255) NOT NULL
	,[emailAddress] varchar(255) NOT NULL
	,[phone] varchar(255) NOT NULL
	,[fax] varchar(255) NOT NULL
	,[department] varchar(255) NOT NULL
	,[region] varchar(255) NOT NULL
	,[addressUid] NUMERIC(38, 20) NOT NULL
	,[addressLine1] varchar(255) NOT NULL
	,[addressLine2] varchar(255) NOT NULL
	,[city] varchar(255) NOT NULL
	,[stateOrProvince] varchar(255) NOT NULL
	,[postalCodeNumber] varchar(255) NOT NULL
	,[countryCode] varchar(255) NOT NULL
	,[locationQualifierCode] varchar(255) NOT NULL
	,[locationCode] varchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentPartyCarrierHist] ON ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentPartyCarrierHist ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[shipmentGUID]
	,[shipmentRouteGUID]
	,[shipmentPartyCarrierGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentPartyCarrierHist ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentPartyCarrierHist PRIMARY KEY
(
	[PartnerId] ASC
	,[EffDate] asc
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[shipmentGUID] asc
	,[shipmentRouteGUID] asc
	,[shipmentPartyCarrierGUID] asc
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportCarrierIdentification' AND type ='U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportCarrierIdentification(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[shipmentGUID] varchar(50) NOT NULL
	,[shipmentRouteGUID] varchar(50) NOT NULL
	,[shipmentPartyCarrierGUID] varchar(50) NOT NULL
	,[CarrierIdentificationGUID] varchar(50) NOT NULL
	,[type] varchar(255) NOT NULL
	,[value] varchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportCarrierIdentification] ON ttdStagingGeneric_GTNexus_Packing_List_ImportCarrierIdentification ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[shipmentGUID]
	,[shipmentRouteGUID]
	,[shipmentPartyCarrierGUID]
	,[CarrierIdentificationGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportCarrierIdentification ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportCarrierIdentification PRIMARY KEY
(
	[PartnerId] ASC
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[shipmentGUID] asc
	,[shipmentRouteGUID] asc
	,[shipmentPartyCarrierGUID] asc
	,[CarrierIdentificationGUID] asc
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportCarrierIdentificationHist' AND type ='U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportCarrierIdentificationHist(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[shipmentGUID] varchar(50) NOT NULL
	,[shipmentRouteGUID] varchar(50) NOT NULL
	,[shipmentPartyCarrierGUID] varchar(50) NOT NULL
	,[CarrierIdentificationGUID] varchar(50) NOT NULL
	,[type] varchar(255) NOT NULL
	,[value] varchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportCarrierIdentificationHist] ON ttdStagingGeneric_GTNexus_Packing_List_ImportCarrierIdentificationHist ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[shipmentGUID]
	,[shipmentRouteGUID]
	,[shipmentPartyCarrierGUID]
	,[CarrierIdentificationGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportCarrierIdentificationHist ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportCarrierIdentificationHist PRIMARY KEY
(
	[PartnerId] ASC
	,[EffDate] asc
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[shipmentGUID] asc
	,[shipmentRouteGUID] asc
	,[shipmentPartyCarrierGUID] asc
	,[CarrierIdentificationGUID] asc
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportCarrierReference' AND type ='U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportCarrierReference(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[shipmentGUID] varchar(50) NOT NULL
	,[shipmentRouteGUID] varchar(50) NOT NULL
	,[shipmentPartyCarrierGUID] varchar(50) NOT NULL
	,[CarrierReferenceGUID] varchar(50) NOT NULL
	,[type] varchar(255) NOT NULL
	,[value] varchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportCarrierReference] ON ttdStagingGeneric_GTNexus_Packing_List_ImportCarrierReference ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[shipmentGUID]
	,[shipmentRouteGUID]
	,[shipmentPartyCarrierGUID]
	,[CarrierReferenceGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportCarrierReference ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportCarrierReference PRIMARY KEY
(
	[PartnerId] ASC
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[shipmentGUID] asc
	,[shipmentRouteGUID] asc
	,[shipmentPartyCarrierGUID] asc
	,[CarrierReferenceGUID] asc
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportCarrierReferenceHist' AND type ='U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportCarrierReferenceHist(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[shipmentGUID] varchar(50) NOT NULL
	,[shipmentRouteGUID] varchar(50) NOT NULL
	,[shipmentPartyCarrierGUID] varchar(50) NOT NULL
	,[CarrierReferenceGUID] varchar(50) NOT NULL
	,[type] varchar(255) NOT NULL
	,[value] varchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportCarrierReferenceHist] ON ttdStagingGeneric_GTNexus_Packing_List_ImportCarrierReferenceHist ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[shipmentGUID]
	,[shipmentRouteGUID]
	,[shipmentPartyCarrierGUID]
	,[CarrierReferenceGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportCarrierReferenceHist ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportCarrierReferenceHist PRIMARY KEY
(
	[PartnerId] ASC
	,[EffDate] asc
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[shipmentGUID] asc
	,[shipmentRouteGUID] asc
	,[shipmentPartyCarrierGUID] asc
	,[CarrierReferenceGUID] asc
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportRoutReference' AND type ='U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportRoutReference(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[shipmentGUID] varchar(50) NOT NULL
	,[shipmentRouteGUID] varchar(50) NOT NULL
	,[RoutReferenceGUID] varchar(50) NOT NULL
	,[type] varchar(255) NOT NULL
	,[value] varchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportRoutReference] ON ttdStagingGeneric_GTNexus_Packing_List_ImportRoutReference ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[shipmentGUID]
	,[shipmentRouteGUID]
	,[RoutReferenceGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportRoutReference ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportRoutReference PRIMARY KEY
(
	[PartnerId] ASC
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[shipmentGUID] asc
	,[shipmentRouteGUID] asc
	,[RoutReferenceGUID] asc
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportRoutReferenceHist' AND type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportRoutReferenceHist(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[shipmentGUID] varchar(50) NOT NULL
	,[shipmentRouteGUID] varchar(50) NOT NULL
	,[RoutReferenceGUID] varchar(50) NOT NULL
	,[type] varchar(255) NOT NULL
	,[value] varchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportRoutReferenceHist] ON ttdStagingGeneric_GTNexus_Packing_List_ImportRoutReferenceHist ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[shipmentGUID]
	,[shipmentRouteGUID]
	,[RoutReferenceGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportRoutReferenceHist ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportRoutReferenceHist PRIMARY KEY
(
	[PartnerId] ASC
	,[EffDate] asc
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[shipmentGUID] asc
	,[shipmentRouteGUID] asc
	,[RoutReferenceGUID] asc
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentStage' AND type ='U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentStage(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[shipmentGUID] varchar(50) NOT NULL
	,[shipmentStageGUID] varchar(50) NOT NULL
	,[shipmentStageTypeCode] varchar(255) NOT NULL
	,[shipmentMethodCode] varchar(255) NOT NULL
	,[transportMeansVehicleId] varchar(255) NOT NULL
	,[transportMeansVehicleName] varchar(255) NOT NULL
	,[transportMeansTripId] varchar(255) NOT NULL
	,[ladingQuantity] numeric(38,20) NOT NULL
	,[notes] varchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentStage] ON ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentStage ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[shipmentGUID]
	,[shipmentStageGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentStage ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentStage PRIMARY KEY
(
	[PartnerId] ASC
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[shipmentGUID] asc
	,[shipmentStageGUID] asc
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentStageHist' AND type ='U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentStageHist(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[shipmentGUID] varchar(50) NOT NULL
	,[shipmentStageGUID] varchar(50) NOT NULL
	,[shipmentStageTypeCode] varchar(255) NOT NULL
	,[shipmentMethodCode] varchar(255) NOT NULL
	,[transportMeansVehicleId] varchar(255) NOT NULL
	,[transportMeansVehicleName] varchar(255) NOT NULL
	,[transportMeansTripId] varchar(255) NOT NULL
	,[ladingQuantity] numeric(38,20) NOT NULL
	,[notes] varchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentStageHist] ON ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentStageHist ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[shipmentGUID]
	,[shipmentStageGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentStageHist ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentStageHist PRIMARY KEY
(
	[PartnerId] ASC
	,[EffDate] asc
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[shipmentGUID] asc
	,[shipmentStageGUID] asc
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentStageLocation' AND type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentStageLocation(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[shipmentGUID] varchar(50) NOT NULL
	,[shipmentStageGUID] varchar(50) NOT NULL
	,[shipmentStageLocationGUID] varchar(50) NOT NULL
	,[partyUid] NUMERIC(38, 20) NOT NULL
	,[partyRoleCode] varchar(255) NOT NULL
	,[memberId] NUMERIC(38, 20) NOT NULL
	,[divisionUid] NUMERIC(38, 20) NOT NULL
	,[name] varchar(255) NOT NULL
	,[longName] varchar(255) NOT NULL
	,[ContactName] varchar(255) NOT NULL
	,[emailAddress] varchar(255) NOT NULL
	,[phone] varchar(255) NOT NULL
	,[fax] varchar(255) NOT NULL
	,[department] varchar(255) NOT NULL
	,[region] varchar(255) NOT NULL
	,[addressUid] NUMERIC(38, 20) NOT NULL
	,[addressLine1] varchar(255) NOT NULL
	,[addressLine2] varchar(255) NOT NULL
	,[city] varchar(255) NOT NULL
	,[stateOrProvince] varchar(255) NOT NULL
	,[postalCodeNumber] varchar(255) NOT NULL
	,[countryCode] varchar(255) NOT NULL
	,[locationQualifierCode] varchar(255) NOT NULL
	,[locationCode] varchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentStageLocation] ON ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentStageLocation ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[shipmentGUID]
	,[shipmentStageGUID]
	,[shipmentStageLocationGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentStageLocation ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentStageLocation PRIMARY KEY
(
	[PartnerId] ASC
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[shipmentGUID] asc
	,[shipmentStageGUID] asc
	,[shipmentStageLocationGUID] asc
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentStageLocationHist' AND type ='U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentStageLocationHist(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[shipmentGUID] varchar(50) NOT NULL
	,[shipmentStageGUID] varchar(50) NOT NULL
	,[shipmentStageLocationGUID] varchar(50) NOT NULL
	,[partyUid] NUMERIC(38, 20) NOT NULL
	,[partyRoleCode] varchar(255) NOT NULL
	,[memberId] NUMERIC(38, 20) NOT NULL
	,[divisionUid] NUMERIC(38, 20) NOT NULL
	,[name] varchar(255) NOT NULL
	,[longName] varchar(255) NOT NULL
	,[ContactName] varchar(255) NOT NULL
	,[emailAddress] varchar(255) NOT NULL
	,[phone] varchar(255) NOT NULL
	,[fax] varchar(255) NOT NULL
	,[department] varchar(255) NOT NULL
	,[region] varchar(255) NOT NULL
	,[addressUid] NUMERIC(38, 20) NOT NULL
	,[addressLine1] varchar(255) NOT NULL
	,[addressLine2] varchar(255) NOT NULL
	,[city] varchar(255) NOT NULL
	,[stateOrProvince] varchar(255) NOT NULL
	,[postalCodeNumber] varchar(255) NOT NULL
	,[countryCode] varchar(255) NOT NULL
	,[locationQualifierCode] varchar(255) NOT NULL
	,[locationCode] varchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentStageLocationHist] ON ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentStageLocationHist ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[shipmentGUID]
	,[shipmentStageGUID]
	,[shipmentStageLocationGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentStageLocationHist ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentStageLocationHist PRIMARY KEY
(
	[PartnerId] ASC
	,[EffDate] asc
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[shipmentGUID] asc
	,[shipmentStageGUID] asc
	,[shipmentStageLocationGUID] asc
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentStageLocationIdentification' AND type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentStageLocationIdentification(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[shipmentGUID] varchar(50) NOT NULL
	,[shipmentStageGUID] varchar(50) NOT NULL
	,[shipmentStageLocationGUID] varchar(50) NOT NULL
	,[shipmentStageLocationIdentificationGUID] varchar(50) NOT NULL
	,[type] varchar(255) NOT NULL
	,[value] varchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentStageLocationIdentification] ON ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentStageLocationIdentification ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[shipmentGUID]
	,[shipmentStageGUID]
	,[shipmentStageLocationGUID]
	,[shipmentStageLocationIdentificationGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentStageLocationIdentification ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentStageLocationIdentification PRIMARY KEY
(
	[PartnerId] ASC
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[shipmentGUID] asc
	,[shipmentStageGUID] asc
	,[shipmentStageLocationGUID] asc
	,[shipmentStageLocationIdentificationGUID] asc
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentStageLocationIdentificationHist' AND type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentStageLocationIdentificationHist(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[shipmentGUID] varchar(50) NOT NULL
	,[shipmentStageGUID] varchar(50) NOT NULL
	,[shipmentStageLocationGUID] varchar(50) NOT NULL
	,[shipmentStageLocationIdentificationGUID] varchar(50) NOT NULL
	,[type] varchar(255) NOT NULL
	,[value] varchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentStageLocationIdentificationHist] ON ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentStageLocationIdentificationHist ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[shipmentGUID]
	,[shipmentStageGUID]
	,[shipmentStageLocationGUID]
	,[shipmentStageLocationIdentificationGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentStageLocationIdentificationHist ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentStageLocationIdentificationHist PRIMARY KEY
(
	[PartnerId] ASC
	,[EffDate] asc
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[shipmentGUID] asc
	,[shipmentStageGUID] asc
	,[shipmentStageLocationGUID] asc
	,[shipmentStageLocationIdentificationGUID] asc
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentStageLocationReference' AND type ='U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentStageLocationReference(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[shipmentGUID] varchar(50) NOT NULL
	,[shipmentStageGUID] varchar(50) NOT NULL
	,[shipmentStageLocationGUID] varchar(50) NOT NULL
	,[shipmentStageLocationReferenceGUID] varchar(50) NOT NULL
	,[type] varchar(255) NOT NULL
	,[value] varchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentStageLocationReference] ON ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentStageLocationReference ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[shipmentGUID]
	,[shipmentStageGUID]
	,[shipmentStageLocationGUID]
	,[shipmentStageLocationReferenceGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentStageLocationReference ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentStageLocationReference PRIMARY KEY
(
	[PartnerId] ASC
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[shipmentGUID] asc
	,[shipmentStageGUID] asc
	,[shipmentStageLocationGUID] asc
	,[shipmentStageLocationReferenceGUID] asc
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentStageLocationReferenceHist' AND type ='U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentStageLocationReferenceHist(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[shipmentGUID] varchar(50) NOT NULL
	,[shipmentStageGUID] varchar(50) NOT NULL
	,[shipmentStageLocationGUID] varchar(50) NOT NULL
	,[shipmentStageLocationReferenceGUID] varchar(50) NOT NULL
	,[type] varchar(255) NOT NULL
	,[value] varchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentStageLocationReferenceHist] ON ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentStageLocationReferenceHist ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[shipmentGUID]
	,[shipmentStageGUID]
	,[shipmentStageLocationGUID]
	,[shipmentStageLocationReferenceGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentStageLocationReferenceHist ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentStageLocationReferenceHist PRIMARY KEY
(
	[PartnerId] ASC
	,[EffDate] asc
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[shipmentGUID] asc
	,[shipmentStageGUID] asc
	,[shipmentStageLocationGUID] asc
	,[shipmentStageLocationReferenceGUID] asc
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportStageShipmentDate' AND TYPE ='U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportStageShipmentDate(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[shipmentGUID] varchar(50) NOT NULL
	,[shipmentStageGUID] varchar(50) NOT NULL
	,[StageShipmentDateGUID] varchar(50) NOT NULL
	,[shipmentDateTypeCode] varchar(255) NOT NULL
	,[shipmentDateValue] datetime NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportStageShipmentDate] ON ttdStagingGeneric_GTNexus_Packing_List_ImportStageShipmentDate ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[shipmentGUID]
	,[shipmentStageGUID]
	,[StageShipmentDateGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportStageShipmentDate ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportStageShipmentDate PRIMARY KEY
(
	[PartnerId] ASC
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[shipmentGUID] asc
	,[shipmentStageGUID] asc
	,[StageShipmentDateGUID] asc
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportStageShipmentDateHist' AND type ='U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportStageShipmentDateHist(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[shipmentGUID] varchar(50) NOT NULL
	,[shipmentStageGUID] varchar(50) NOT NULL
	,[StageShipmentDateGUID] varchar(50) NOT NULL
	,[shipmentDateTypeCode] varchar(255) NOT NULL
	,[shipmentDateValue] datetime NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportStageShipmentDateHist] ON ttdStagingGeneric_GTNexus_Packing_List_ImportStageShipmentDateHist ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[shipmentGUID]
	,[shipmentStageGUID]
	,[StageShipmentDateGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportStageShipmentDateHist ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportStageShipmentDateHist PRIMARY KEY
(
	[PartnerId] ASC
	,[EffDate] asc
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[shipmentGUID] asc
	,[shipmentStageGUID] asc
	,[StageShipmentDateGUID] asc
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_Importcarrier' AND type ='U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_Importcarrier(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[shipmentGUID] varchar(50) NOT NULL
	,[shipmentStageGUID] varchar(50) NOT NULL
	,[carrierGUID] varchar(50) NOT NULL
	,[partyUid] NUMERIC(38, 20) NOT NULL
	,[partyRoleCode] varchar(255) NOT NULL
	,[memberId] NUMERIC(38, 20) NOT NULL
	,[divisionUid] NUMERIC(38, 20) NOT NULL
	,[name] varchar(255) NOT NULL
	,[longName] varchar(255) NOT NULL
	,[ContactName] varchar(255) NOT NULL
	,[emailAddress] varchar(255) NOT NULL
	,[phone] varchar(255) NOT NULL
	,[fax] varchar(255) NOT NULL
	,[department] varchar(255) NOT NULL
	,[region] varchar(255) NOT NULL
	,[addressUid] NUMERIC(38, 20) NOT NULL
	,[addressLine1] varchar(255) NOT NULL
	,[addressLine2] varchar(255) NOT NULL
	,[city] varchar(255) NOT NULL
	,[stateOrProvince] varchar(255) NOT NULL
	,[postalCodeNumber] varchar(255) NOT NULL
	,[countryCode] varchar(255) NOT NULL
	,[locationQualifierCode] varchar(255) NOT NULL
	,[locationCode] varchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_Importcarrier] ON ttdStagingGeneric_GTNexus_Packing_List_Importcarrier ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[shipmentGUID]
	,[shipmentStageGUID]
	,[carrierGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_Importcarrier ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_Importcarrier PRIMARY KEY
(
	[PartnerId] ASC
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[shipmentGUID] asc
	,[shipmentStageGUID] asc
	,[carrierGUID] asc
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportcarrierHist' AND type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportcarrierHist(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[shipmentGUID] varchar(50) NOT NULL
	,[shipmentStageGUID] varchar(50) NOT NULL
	,[carrierGUID] varchar(50) NOT NULL
	,[partyUid] NUMERIC(38, 20) NOT NULL
	,[partyRoleCode] varchar(255) NOT NULL
	,[memberId] NUMERIC(38, 20) NOT NULL
	,[divisionUid] NUMERIC(38, 20) NOT NULL
	,[name] varchar(255) NOT NULL
	,[longName] varchar(255) NOT NULL
	,[ContactName] varchar(255) NOT NULL
	,[emailAddress] varchar(255) NOT NULL
	,[phone] varchar(255) NOT NULL
	,[fax] varchar(255) NOT NULL
	,[department] varchar(255) NOT NULL
	,[region] varchar(255) NOT NULL
	,[addressUid] NUMERIC(38, 20) NOT NULL
	,[addressLine1] varchar(255) NOT NULL
	,[addressLine2] varchar(255) NOT NULL
	,[city] varchar(255) NOT NULL
	,[stateOrProvince] varchar(255) NOT NULL
	,[postalCodeNumber] varchar(255) NOT NULL
	,[countryCode] varchar(255) NOT NULL
	,[locationQualifierCode] varchar(255) NOT NULL
	,[locationCode] varchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportcarrierHist] ON ttdStagingGeneric_GTNexus_Packing_List_ImportcarrierHist ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[shipmentGUID]
	,[shipmentStageGUID]
	,[carrierGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportcarrierHist ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportcarrierHist PRIMARY KEY
(
	[PartnerId] ASC
	,[EffDate] asc
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[shipmentGUID] asc
	,[shipmentStageGUID] asc
	,[carrierGUID] asc
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentStageCarrierIdentification' AND type ='U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentStageCarrierIdentification(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[shipmentGUID] varchar(50) NOT NULL
	,[shipmentStageGUID] varchar(50) NOT NULL
	,[carrierGUID] varchar(50) NOT NULL
	,[shipmentStageCarrierIdentificationGUID] varchar(50) NOT NULL
	,[type] varchar(255) NOT NULL
	,[value] varchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentStageCarrierIdentification] ON ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentStageCarrierIdentification ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[shipmentGUID]
	,[shipmentStageGUID]
	,[carrierGUID]
	,[shipmentStageCarrierIdentificationGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentStageCarrierIdentification ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentStageCarrierIdentification PRIMARY KEY
(
	[PartnerId] ASC
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[shipmentGUID] asc
	,[shipmentStageGUID] asc
	,[carrierGUID] asc
	,[shipmentStageCarrierIdentificationGUID] asc
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentStageCarrierIdentificationHist' AND TYPE ='U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentStageCarrierIdentificationHist(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[shipmentGUID] varchar(50) NOT NULL
	,[shipmentStageGUID] varchar(50) NOT NULL
	,[carrierGUID] varchar(50) NOT NULL
	,[shipmentStageCarrierIdentificationGUID] varchar(50) NOT NULL
	,[type] varchar(255) NOT NULL
	,[value] varchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentStageCarrierIdentificationHist] ON ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentStageCarrierIdentificationHist ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[shipmentGUID]
	,[shipmentStageGUID]
	,[carrierGUID]
	,[shipmentStageCarrierIdentificationGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentStageCarrierIdentificationHist ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentStageCarrierIdentificationHist PRIMARY KEY
(
	[PartnerId] ASC
	,[EffDate] asc
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[shipmentGUID] asc
	,[shipmentStageGUID] asc
	,[carrierGUID] asc
	,[shipmentStageCarrierIdentificationGUID] asc
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentStageCarrierReference' AND type ='U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentStageCarrierReference(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[shipmentGUID] varchar(50) NOT NULL
	,[shipmentStageGUID] varchar(50) NOT NULL
	,[carrierGUID] varchar(50) NOT NULL
	,[shipmentStageCarrierReferenceGUID] varchar(50) NOT NULL
	,[type] varchar(255) NOT NULL
	,[value] varchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentStageCarrierReference] ON ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentStageCarrierReference ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[shipmentGUID]
	,[shipmentStageGUID]
	,[carrierGUID]
	,[shipmentStageCarrierReferenceGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentStageCarrierReference ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentStageCarrierReference PRIMARY KEY
(
	[PartnerId] ASC
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[shipmentGUID] asc
	,[shipmentStageGUID] asc
	,[carrierGUID] asc
	,[shipmentStageCarrierReferenceGUID] asc
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentStageCarrierReferenceHist' AND type ='U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentStageCarrierReferenceHist(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[shipmentGUID] varchar(50) NOT NULL
	,[shipmentStageGUID] varchar(50) NOT NULL
	,[carrierGUID] varchar(50) NOT NULL
	,[shipmentStageCarrierReferenceGUID] varchar(50) NOT NULL
	,[type] varchar(255) NOT NULL
	,[value] varchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentStageCarrierReferenceHist] ON ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentStageCarrierReferenceHist ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[shipmentGUID]
	,[shipmentStageGUID]
	,[carrierGUID]
	,[shipmentStageCarrierReferenceGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentStageCarrierReferenceHist ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentStageCarrierReferenceHist PRIMARY KEY
(
	[PartnerId] ASC
	,[EffDate] asc
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[shipmentGUID] asc
	,[shipmentStageGUID] asc
	,[carrierGUID] asc
	,[shipmentStageCarrierReferenceGUID] asc
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentStageReference' AND type ='U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentStageReference(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[shipmentGUID] varchar(50) NOT NULL
	,[shipmentStageGUID] varchar(50) NOT NULL
	,[shipmentStageReferenceGUID] varchar(50) NOT NULL
	,[type] varchar(255) NOT NULL
	,[value] varchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentStageReference] ON ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentStageReference ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[shipmentGUID]
	,[shipmentStageGUID]
	,[shipmentStageReferenceGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentStageReference ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentStageReference PRIMARY KEY
(
	[PartnerId] ASC
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[shipmentGUID] asc
	,[shipmentStageGUID] asc
	,[shipmentStageReferenceGUID] asc
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentStageReferenceHist' AND type ='U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentStageReferenceHist(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[shipmentGUID] varchar(50) NOT NULL
	,[shipmentStageGUID] varchar(50) NOT NULL
	,[shipmentStageReferenceGUID] varchar(50) NOT NULL
	,[type] varchar(255) NOT NULL
	,[value] varchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentStageReferenceHist] ON ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentStageReferenceHist ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[shipmentGUID]
	,[shipmentStageGUID]
	,[shipmentStageReferenceGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentStageReferenceHist ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentStageReferenceHist PRIMARY KEY
(
	[PartnerId] ASC
	,[EffDate] asc
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[shipmentGUID] asc
	,[shipmentStageGUID] asc
	,[shipmentStageReferenceGUID] asc
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImporttransportEquipment' AND type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImporttransportEquipment(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[shipmentGUID] varchar(50) NOT NULL
	,[transportEquipmentGUID] varchar(50) NOT NULL
	,[transportEquipmentTypeCode] varchar(255) NOT NULL
	,[equipmentLoadTypeCode] varchar(255) NOT NULL
	,[equipmentNumberPrefix] varchar(255) NOT NULL
	,[equipmentNumber] varchar(255) NOT NULL
	,[equipmentCheckDigit] NUMERIC(38, 20) NOT NULL
	,[sealNumber] varchar(255) NOT NULL
	,[isPartialLoadIndicator] varchar(1) NOT NULL
	,[notes] varchar(255) NOT NULL
	,[totalPackageQuantity] NUMERIC(38, 20) NOT NULL
	,[packMethodCode] varchar(255) NOT NULL
	,[weightUnitCode] varchar(255) NOT NULL
	,[totalGrossWeight] numeric(38,20) NOT NULL
	,[totalNetWeight] numeric(38,20) NOT NULL
	,[totalNetNetWeight] numeric(38,20) NOT NULL
	,[volumeUnitCode] varchar(255) NOT NULL
	,[totalGrossVolume] numeric(38,20) NOT NULL
	,[volumeWeightUnitCode] varchar(255) NOT NULL
	,[totalVolumeWeight] numeric(38,20) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImporttransportEquipment] ON ttdStagingGeneric_GTNexus_Packing_List_ImporttransportEquipment ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[shipmentGUID]
	,[transportEquipmentGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImporttransportEquipment ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImporttransportEquipment PRIMARY KEY
(
	[PartnerId] ASC
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[shipmentGUID] asc
	,[transportEquipmentGUID] asc
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImporttransportEquipmentHist' AND type ='U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImporttransportEquipmentHist(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[shipmentGUID] varchar(50) NOT NULL
	,[transportEquipmentGUID] varchar(50) NOT NULL
	,[transportEquipmentTypeCode] varchar(255) NOT NULL
	,[equipmentLoadTypeCode] varchar(255) NOT NULL
	,[equipmentNumberPrefix] varchar(255) NOT NULL
	,[equipmentNumber] varchar(255) NOT NULL
	,[equipmentCheckDigit] NUMERIC(38, 20) NOT NULL
	,[sealNumber] varchar(255) NOT NULL
	,[isPartialLoadIndicator] varchar(1) NOT NULL
	,[notes] varchar(255) NOT NULL
	,[totalPackageQuantity] NUMERIC(38, 20) NOT NULL
	,[packMethodCode] varchar(255) NOT NULL
	,[weightUnitCode] varchar(255) NOT NULL
	,[totalGrossWeight] numeric(38,20) NOT NULL
	,[totalNetWeight] numeric(38,20) NOT NULL
	,[totalNetNetWeight] numeric(38,20) NOT NULL
	,[volumeUnitCode] varchar(255) NOT NULL
	,[totalGrossVolume] numeric(38,20) NOT NULL
	,[volumeWeightUnitCode] varchar(255) NOT NULL
	,[totalVolumeWeight] numeric(38,20) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImporttransportEquipmentHist] ON ttdStagingGeneric_GTNexus_Packing_List_ImporttransportEquipmentHist ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[shipmentGUID]
	,[transportEquipmentGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImporttransportEquipmentHist ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImporttransportEquipmentHist PRIMARY KEY
(
	[PartnerId] ASC
	,[EffDate] asc
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[shipmentGUID] asc
	,[transportEquipmentGUID] asc
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportEquipmentShipmentOrderXref' AND type ='U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportEquipmentShipmentOrderXref(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[shipmentGUID] varchar(50) NOT NULL
	,[transportEquipmentGUID] varchar(50) NOT NULL
	,[EquipmentShipmentOrderXrefGUID] varchar(50) NOT NULL
	,[shipmentOrderKey] varchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportEquipmentShipmentOrderXref] ON ttdStagingGeneric_GTNexus_Packing_List_ImportEquipmentShipmentOrderXref ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[shipmentGUID]
	,[transportEquipmentGUID]
	,[EquipmentShipmentOrderXrefGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportEquipmentShipmentOrderXref ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportEquipmentShipmentOrderXref PRIMARY KEY
(
	[PartnerId] ASC
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[shipmentGUID] asc
	,[transportEquipmentGUID] asc
	,[EquipmentShipmentOrderXrefGUID] asc
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportEquipmentShipmentOrderXrefHist' AND type ='U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportEquipmentShipmentOrderXrefHist(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[shipmentGUID] varchar(50) NOT NULL
	,[transportEquipmentGUID] varchar(50) NOT NULL
	,[EquipmentShipmentOrderXrefGUID] varchar(50) NOT NULL
	,[shipmentOrderKey] varchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportEquipmentShipmentOrderXrefHist] ON ttdStagingGeneric_GTNexus_Packing_List_ImportEquipmentShipmentOrderXrefHist ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[shipmentGUID]
	,[transportEquipmentGUID]
	,[EquipmentShipmentOrderXrefGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportEquipmentShipmentOrderXrefHist ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportEquipmentShipmentOrderXrefHist PRIMARY KEY
(
	[PartnerId] ASC
	,[EffDate] asc
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[shipmentGUID] asc
	,[transportEquipmentGUID] asc
	,[EquipmentShipmentOrderXrefGUID] asc
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportEquipmentPackageDetailXref' AND type ='U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportEquipmentPackageDetailXref(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[shipmentGUID] varchar(50) NOT NULL
	,[transportEquipmentGUID] varchar(50) NOT NULL
	,[EquipmentPackageDetailXrefGUID] varchar(50) NOT NULL
	,[packageKey] varchar(255) NOT NULL
	,[packageQuantity] NUMERIC(38, 20) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportEquipmentPackageDetailXref] ON ttdStagingGeneric_GTNexus_Packing_List_ImportEquipmentPackageDetailXref ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[shipmentGUID]
	,[transportEquipmentGUID]
	,[EquipmentPackageDetailXrefGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportEquipmentPackageDetailXref ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportEquipmentPackageDetailXref PRIMARY KEY
(
	[PartnerId] ASC
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[shipmentGUID] asc
	,[transportEquipmentGUID] asc
	,[EquipmentPackageDetailXrefGUID] asc
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportEquipmentPackageDetailXrefHist' AND type ='U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportEquipmentPackageDetailXrefHist(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[shipmentGUID] varchar(50) NOT NULL
	,[transportEquipmentGUID] varchar(50) NOT NULL
	,[EquipmentPackageDetailXrefGUID] varchar(50) NOT NULL
	,[packageKey] varchar(255) NOT NULL
	,[packageQuantity] NUMERIC(38, 20) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportEquipmentPackageDetailXrefHist] ON ttdStagingGeneric_GTNexus_Packing_List_ImportEquipmentPackageDetailXrefHist ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[shipmentGUID]
	,[transportEquipmentGUID]
	,[EquipmentPackageDetailXrefGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportEquipmentPackageDetailXrefHist ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportEquipmentPackageDetailXrefHist PRIMARY KEY
(
	[PartnerId] ASC
	,[EffDate] asc
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[shipmentGUID] asc
	,[transportEquipmentGUID] asc
	,[EquipmentPackageDetailXrefGUID] asc
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportadditionalDocumentPresented' AND type ='U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportadditionalDocumentPresented(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[shipmentGUID] varchar(50) NOT NULL
	,[additionalDocumentPresentedGUID] varchar(50) NOT NULL
	,[documentReferenceTypeCode] varchar(255) NOT NULL
	,[documentReferenceStatusCode] varchar(255) NOT NULL
	,[partyRoleCode] varchar(255) NOT NULL
	,[name] varchar(255) NOT NULL
	,[number] varchar(255) NOT NULL
	,[notes] varchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportadditionalDocumentPresented] ON ttdStagingGeneric_GTNexus_Packing_List_ImportadditionalDocumentPresented ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[shipmentGUID]
	,[additionalDocumentPresentedGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportadditionalDocumentPresented ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportadditionalDocumentPresented PRIMARY KEY
(
	[PartnerId] ASC
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[shipmentGUID] asc
	,[additionalDocumentPresentedGUID] asc
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportadditionalDocumentPresentedHist' AND type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportadditionalDocumentPresentedHist(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[shipmentGUID] varchar(50) NOT NULL
	,[additionalDocumentPresentedGUID] varchar(50) NOT NULL
	,[documentReferenceTypeCode] varchar(255) NOT NULL
	,[documentReferenceStatusCode] varchar(255) NOT NULL
	,[partyRoleCode] varchar(255) NOT NULL
	,[name] varchar(255) NOT NULL
	,[number] varchar(255) NOT NULL
	,[notes] varchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportadditionalDocumentPresentedHist] ON ttdStagingGeneric_GTNexus_Packing_List_ImportadditionalDocumentPresentedHist ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[shipmentGUID]
	,[additionalDocumentPresentedGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportadditionalDocumentPresentedHist ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportadditionalDocumentPresentedHist PRIMARY KEY
(
	[PartnerId] ASC
	,[EffDate] asc
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[shipmentGUID] asc
	,[additionalDocumentPresentedGUID] asc
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportallowanceCharge' AND type ='U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportallowanceCharge(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[shipmentGUID] varchar(50) NOT NULL
	,[allowanceChargeGUID] varchar(50) NOT NULL
	,[allowanceChargeUid] NUMERIC(38, 20) NOT NULL
	,[allowanceChargeNumber] varchar(255) NOT NULL
	,[allowanceChargeIndicatorCode] varchar(255) NOT NULL
	,[allowanceChargeType] varchar(255) NOT NULL
	,[reasonType] varchar(255) NOT NULL
	,[reasonDescription] varchar(255) NOT NULL
	,[calculatedAllowanceChargeValue] numeric(38,20) NOT NULL
	,[allowanceChargeValue] numeric(38,20) NOT NULL
	,[isFlatAmount] varchar(1) NOT NULL
	,[quantity] numeric(38,20) NOT NULL
	,[perUnit] numeric(38,20) NOT NULL
	,[allowanceChargeHandlingCode] varchar(255) NOT NULL
	,[allowanceChargePercentBasisCode] varchar(255) NOT NULL
	,[taxRate] numeric(38,20) NOT NULL
	,[notes] varchar(255) NOT NULL
	,[priceTypeCode] varchar(255) NOT NULL
	,[priceValue] numeric(38,20) NOT NULL
	,[currencyCode] varchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportallowanceCharge] ON ttdStagingGeneric_GTNexus_Packing_List_ImportallowanceCharge ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[shipmentGUID]
	,[allowanceChargeGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportallowanceCharge ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportallowanceCharge PRIMARY KEY
(
	[PartnerId] ASC
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[shipmentGUID] asc
	,[allowanceChargeGUID] asc
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportallowanceChargeHist' AND type ='U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportallowanceChargeHist(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[shipmentGUID] varchar(50) NOT NULL
	,[allowanceChargeGUID] varchar(50) NOT NULL
	,[allowanceChargeUid] NUMERIC(38, 20) NOT NULL
	,[allowanceChargeNumber] varchar(255) NOT NULL
	,[allowanceChargeIndicatorCode] varchar(255) NOT NULL
	,[allowanceChargeType] varchar(255) NOT NULL
	,[reasonType] varchar(255) NOT NULL
	,[reasonDescription] varchar(255) NOT NULL
	,[calculatedAllowanceChargeValue] numeric(38,20) NOT NULL
	,[allowanceChargeValue] numeric(38,20) NOT NULL
	,[isFlatAmount] varchar(1) NOT NULL
	,[quantity] numeric(38,20) NOT NULL
	,[perUnit] numeric(38,20) NOT NULL
	,[allowanceChargeHandlingCode] varchar(255) NOT NULL
	,[allowanceChargePercentBasisCode] varchar(255) NOT NULL
	,[taxRate] numeric(38,20) NOT NULL
	,[notes] varchar(255) NOT NULL
	,[priceTypeCode] varchar(255) NOT NULL
	,[priceValue] numeric(38,20) NOT NULL
	,[currencyCode] varchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportallowanceChargeHist] ON ttdStagingGeneric_GTNexus_Packing_List_ImportallowanceChargeHist ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[shipmentGUID]
	,[allowanceChargeGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportallowanceChargeHist ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportallowanceChargeHist PRIMARY KEY
(
	[PartnerId] ASC
	,[EffDate] asc
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[shipmentGUID] asc
	,[allowanceChargeGUID] asc
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportAllowChargeReference' AND type ='U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportAllowChargeReference(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[shipmentGUID] varchar(50) NOT NULL
	,[allowanceChargeGUID] varchar(50) NOT NULL
	,[AllowChargeReferenceGUID] varchar(50) NOT NULL
	,[type] varchar(255) NOT NULL
	,[value] varchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportAllowChargeReference] ON ttdStagingGeneric_GTNexus_Packing_List_ImportAllowChargeReference ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[shipmentGUID]
	,[allowanceChargeGUID]
	,[AllowChargeReferenceGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportAllowChargeReference ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportAllowChargeReference PRIMARY KEY
(
	[PartnerId] ASC
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[shipmentGUID] asc
	,[allowanceChargeGUID] asc
	,[AllowChargeReferenceGUID] asc
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportAllowChargeReferenceHist' AND type ='U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportAllowChargeReferenceHist(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[shipmentGUID] varchar(50) NOT NULL
	,[allowanceChargeGUID] varchar(50) NOT NULL
	,[AllowChargeReferenceGUID] varchar(50) NOT NULL
	,[type] varchar(255) NOT NULL
	,[value] varchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportAllowChargeReferenceHist] ON ttdStagingGeneric_GTNexus_Packing_List_ImportAllowChargeReferenceHist ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[shipmentGUID]
	,[allowanceChargeGUID]
	,[AllowChargeReferenceGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportAllowChargeReferenceHist ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportAllowChargeReferenceHist PRIMARY KEY
(
	[PartnerId] ASC
	,[EffDate] asc
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[shipmentGUID] asc
	,[allowanceChargeGUID] asc
	,[AllowChargeReferenceGUID] asc
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportShipmentPackageDetailXref' AND type ='U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportShipmentPackageDetailXref(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[shipmentGUID] varchar(50) NOT NULL
	,[ShipmentPackageDetailXrefGUID] varchar(50) NOT NULL
	,[packageKey] varchar(255) NOT NULL
	,[packageQuantity] NUMERIC(38, 20) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportShipmentPackageDetailXref] ON ttdStagingGeneric_GTNexus_Packing_List_ImportShipmentPackageDetailXref ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[shipmentGUID]
	,[ShipmentPackageDetailXrefGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportShipmentPackageDetailXref ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportShipmentPackageDetailXref PRIMARY KEY
(
	[PartnerId] ASC
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[shipmentGUID] asc
	,[ShipmentPackageDetailXrefGUID] asc
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportShipmentPackageDetailXrefHist' AND type ='U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportShipmentPackageDetailXrefHist(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[shipmentGUID] varchar(50) NOT NULL
	,[ShipmentPackageDetailXrefGUID] varchar(50) NOT NULL
	,[packageKey] varchar(255) NOT NULL
	,[packageQuantity] NUMERIC(38, 20) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportShipmentPackageDetailXrefHist] ON ttdStagingGeneric_GTNexus_Packing_List_ImportShipmentPackageDetailXrefHist ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[shipmentGUID]
	,[ShipmentPackageDetailXrefGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportShipmentPackageDetailXrefHist ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportShipmentPackageDetailXrefHist PRIMARY KEY
(
	[PartnerId] ASC
	,[EffDate] asc
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[shipmentGUID] asc
	,[ShipmentPackageDetailXrefGUID] asc
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportpackageDetail' AND type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportpackageDetail(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[packageDetailGUID] varchar(50) NOT NULL

	,[shipmentNumber] varchar(255) NOT NULL
	,[packageKey] varchar(255) NOT NULL
	,[packageUid] NUMERIC(38, 20) NOT NULL
	,[packMethodCode] varchar(255) NOT NULL
	,[packageQuantity] NUMERIC(38, 20) NOT NULL
	,[packageItemQuantity] NUMERIC(38, 20) NOT NULL
	,[totalPackageItemQuantity] NUMERIC(38, 20) NOT NULL
	,[packageType] varchar(255) NOT NULL
	,[instruction] varchar(255) NOT NULL
	,[weightUnitCode] varchar(255) NOT NULL
	,[grossWeight] numeric(38,20) NOT NULL
	,[netWeight] numeric(38,20) NOT NULL
	,[netNetWeight] numeric(38,20) NOT NULL
	,[volumeUnitCode] varchar(255) NOT NULL
	,[grossVolume] numeric(38,20) NOT NULL
	,[volumeWeightUnitCode] varchar(255) NOT NULL
	,[volumeWeight] numeric(38,20) NOT NULL
	,[dimensionUnitCode] varchar(255) NOT NULL
	,[length] numeric(38,20) NOT NULL
	,[width] numeric(38,20) NOT NULL
	,[height] numeric(38,20) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportpackageDetail] ON ttdStagingGeneric_GTNexus_Packing_List_ImportpackageDetail ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[packageDetailGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportpackageDetail ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportpackageDetail PRIMARY KEY
(
	[PartnerId] ASC
	,[PackingListGUID] ASC
	,[packingListDetailGUID] asc
	,[packageDetailGUID] asc
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportpackageDetailHist' AND type ='U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportpackageDetailHist(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[packageDetailGUID] varchar(50) NOT NULL

	,[shipmentNumber] varchar(255) NOT NULL
	,[packageKey] varchar(255) NOT NULL
	,[packageUid] NUMERIC(38, 20) NOT NULL
	,[packMethodCode] varchar(255) NOT NULL
	,[packageQuantity] NUMERIC(38, 20) NOT NULL
	,[packageItemQuantity] NUMERIC(38, 20) NOT NULL
	,[totalPackageItemQuantity] NUMERIC(38, 20) NOT NULL
	,[packageType] varchar(255) NOT NULL
	,[instruction] varchar(255) NOT NULL
	,[weightUnitCode] varchar(255) NOT NULL
	,[grossWeight] numeric(38,20) NOT NULL
	,[netWeight] numeric(38,20) NOT NULL
	,[netNetWeight] numeric(38,20) NOT NULL
	,[volumeUnitCode] varchar(255) NOT NULL
	,[grossVolume] numeric(38,20) NOT NULL
	,[volumeWeightUnitCode] varchar(255) NOT NULL
	,[volumeWeight] numeric(38,20) NOT NULL
	,[dimensionUnitCode] varchar(255) NOT NULL
	,[length] numeric(38,20) NOT NULL
	,[width] numeric(38,20) NOT NULL
	,[height] numeric(38,20) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportpackageDetailHist] ON ttdStagingGeneric_GTNexus_Packing_List_ImportpackageDetailHist ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[packageDetailGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportpackageDetailHist ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportpackageDetailHist PRIMARY KEY
(
	[PartnerId] ASC
	,[EffDate] asc
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[packageDetailGUID] asc
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentOrderXref' AND type ='U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentOrderXref(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[packageDetailGUID] varchar(50) NOT NULL
	,[shipmentOrderXrefGUID] varchar(50) NOT NULL

	,[shipmentOrderKey] varchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentOrderXref] ON ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentOrderXref ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[packageDetailGUID]
	,[shipmentOrderXrefGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentOrderXref ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentOrderXref PRIMARY KEY
(
	[PartnerId] ASC
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[packageDetailGUID] asc
	,[shipmentOrderXrefGUID] asc
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentOrderXrefHist' AND type ='U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentOrderXrefHist(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[packageDetailGUID] varchar(50) NOT NULL
	,[shipmentOrderXrefGUID] varchar(50) NOT NULL

	,[shipmentOrderKey] varchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentOrderXrefHist] ON ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentOrderXrefHist ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[packageDetailGUID]
	,[shipmentOrderXrefGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentOrderXrefHist ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentOrderXrefHist PRIMARY KEY
(
	[PartnerId] ASC
	,[EffDate] asc
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[packageDetailGUID] asc
	,[shipmentOrderXrefGUID] asc
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportpackageDetailItemXref' AND type ='U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportpackageDetailItemXref(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[packageDetailGUID] varchar(50) NOT NULL
	,[packageDetailItemXrefGUID] varchar(50) NOT NULL

	,[poNumber] varchar(255) NOT NULL
	,[itemKey] varchar(255) NOT NULL
	,[itemTypeCode] varchar(255) NOT NULL
	,[quantity] numeric(38,20) NOT NULL
	,[packInstructionReference] varchar(255) NOT NULL
	,[packageType] varchar(255) NOT NULL
	,[packMethodCode] varchar(255) NOT NULL
	,[quantityPerInnerPackage] NUMERIC(38, 20) NOT NULL
	,[quantityPerOuterPackage] NUMERIC(38, 20) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportpackageDetailItemXref] ON ttdStagingGeneric_GTNexus_Packing_List_ImportpackageDetailItemXref ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[packageDetailGUID]
	,[packageDetailItemXrefGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportpackageDetailItemXref ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportpackageDetailItemXref PRIMARY KEY
(
	[PartnerId] ASC
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[packageDetailGUID] asc
	,[packageDetailItemXrefGUID] asc
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportpackageDetailItemXrefHist' AND type ='U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportpackageDetailItemXrefHist(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[packageDetailGUID] varchar(50) NOT NULL
	,[packageDetailItemXrefGUID] varchar(50) NOT NULL

	,[poNumber] varchar(255) NOT NULL
	,[itemKey] varchar(255) NOT NULL
	,[itemTypeCode] varchar(255) NOT NULL
	,[quantity] numeric(38,20) NOT NULL
	,[packInstructionReference] varchar(255) NOT NULL
	,[packageType] varchar(255) NOT NULL
	,[packMethodCode] varchar(255) NOT NULL
	,[quantityPerInnerPackage] NUMERIC(38, 20) NOT NULL
	,[quantityPerOuterPackage] NUMERIC(38, 20) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportpackageDetailItemXrefHist] ON ttdStagingGeneric_GTNexus_Packing_List_ImportpackageDetailItemXrefHist ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[packageDetailGUID]
	,[packageDetailItemXrefGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportpackageDetailItemXrefHist ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportpackageDetailItemXrefHist PRIMARY KEY
(
	[PartnerId] ASC
	,[EffDate] asc
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[packageDetailGUID] asc
	,[packageDetailItemXrefGUID] asc
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportpackageMark' AND type ='U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportpackageMark(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[packageDetailGUID] varchar(50) NOT NULL
	,[packageMarkGUID] varchar(50) NOT NULL

	,[markNumberTypeCode] varchar(255) NOT NULL
	,[markNumberFrom] varchar(255) NOT NULL
	,[markNumberTo] varchar(255) NOT NULL
	,[mark] varchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportpackageMark] ON ttdStagingGeneric_GTNexus_Packing_List_ImportpackageMark ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[packageDetailGUID]
	,[packageMarkGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportpackageMark ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportpackageMark PRIMARY KEY
(
	[PartnerId] ASC
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[packageDetailGUID] asc
	,[packageMarkGUID] asc
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportpackageMarkHist' AND type ='U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportpackageMarkHist(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[packageDetailGUID] varchar(50) NOT NULL
	,[packageMarkGUID] varchar(50) NOT NULL

	,[markNumberTypeCode] varchar(255) NOT NULL
	,[markNumberFrom] varchar(255) NOT NULL
	,[markNumberTo] varchar(255) NOT NULL
	,[mark] varchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportpackageMarkHist] ON ttdStagingGeneric_GTNexus_Packing_List_ImportpackageMarkHist ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[packageDetailGUID]
	,[packageMarkGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportpackageMarkHist ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportpackageMarkHist PRIMARY KEY
(
	[PartnerId] ASC
	,[EffDate] asc
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[packageDetailGUID] asc
	,[packageMarkGUID] asc
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportpackageDetailReference' AND type ='U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportpackageDetailReference(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[packageDetailGUID] varchar(50) NOT NULL
	,[packageDetailReferenceGUID] varchar(50) NOT NULL

	,[type] varchar(255) NOT NULL
	,[value] varchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportpackageDetailReference] ON ttdStagingGeneric_GTNexus_Packing_List_ImportpackageDetailReference ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[packageDetailGUID]
	,[packageDetailReferenceGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportpackageDetailReference ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportpackageDetailReference PRIMARY KEY
(
	[PartnerId] ASC
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[packageDetailGUID] asc
	,[packageDetailReferenceGUID] asc
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportpackageDetailReferenceHist' AND type ='U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportpackageDetailReferenceHist(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[packageDetailGUID] varchar(50) NOT NULL
	,[packageDetailReferenceGUID] varchar(50) NOT NULL

	,[type] varchar(255) NOT NULL
	,[value] varchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportpackageDetailReferenceHist] ON ttdStagingGeneric_GTNexus_Packing_List_ImportpackageDetailReferenceHist ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[packageDetailGUID]
	,[packageDetailReferenceGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportpackageDetailReferenceHist ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportpackageDetailReferenceHist PRIMARY KEY
(
	[PartnerId] ASC
	,[EffDate] asc
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[packageDetailGUID] asc
	,[packageDetailReferenceGUID] asc
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentOrder' AND type ='U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentOrder(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[shipmentOrderGUID] varchar(50) NOT NULL
	,[shipmentOrderKey] varchar(255) NOT NULL
	,[poNumber] varchar(255) NOT NULL
	,[totalPackageQuantity] NUMERIC(38, 20) NOT NULL
	,[packMethodCode] varchar(255) NOT NULL
	,[weightUnitCode] varchar(255) NOT NULL
	,[totalGrossWeight] numeric(38,20) NOT NULL
	,[totalNetWeight] numeric(38,20) NOT NULL
	,[totalNetNetWeight] numeric(38,20) NOT NULL
	,[volumeUnitCode] varchar(255) NOT NULL
	,[totalGrossVolume] numeric(38,20) NOT NULL
	,[volumeWeightUnitCode] varchar(255) NOT NULL
	,[totalVolumeWeight] numeric(38,20) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentOrder] ON ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentOrder ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[shipmentOrderGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentOrder ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentOrder PRIMARY KEY
(
	[PartnerId] ASC
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[shipmentOrderGUID] asc
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentOrderHist' AND type ='U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentOrderHist(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[shipmentOrderGUID] varchar(50) NOT NULL
	,[shipmentOrderKey] varchar(255) NOT NULL
	,[poNumber] varchar(255) NOT NULL
	,[totalPackageQuantity] NUMERIC(38, 20) NOT NULL
	,[packMethodCode] varchar(255) NOT NULL
	,[weightUnitCode] varchar(255) NOT NULL
	,[totalGrossWeight] numeric(38,20) NOT NULL
	,[totalNetWeight] numeric(38,20) NOT NULL
	,[totalNetNetWeight] numeric(38,20) NOT NULL
	,[volumeUnitCode] varchar(255) NOT NULL
	,[totalGrossVolume] numeric(38,20) NOT NULL
	,[volumeWeightUnitCode] varchar(255) NOT NULL
	,[totalVolumeWeight] numeric(38,20) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentOrderHist] ON ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentOrderHist ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[shipmentOrderGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentOrderHist ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentOrderHist PRIMARY KEY
(
	[PartnerId] ASC
	,[EffDate] asc
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[shipmentOrderGUID] asc
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentOrderFinalDestination' AND type ='U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentOrderFinalDestination(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[shipmentOrderGUID] varchar(50) NOT NULL
	,[shipmentOrderFinalDestinationGUID] varchar(50) NOT NULL
	,[partyUid] NUMERIC(38, 20) NOT NULL
	,[partyRoleCode] varchar(255) NOT NULL
	,[memberId] NUMERIC(38, 20) NOT NULL
	,[divisionUid] NUMERIC(38, 20) NOT NULL
	,[name] varchar(255) NOT NULL
	,[longName] varchar(255) NOT NULL
	,[ContactName] varchar(255) NOT NULL
	,[emailAddress] varchar(255) NOT NULL
	,[phone] varchar(255) NOT NULL
	,[fax] varchar(255) NOT NULL
	,[department] varchar(255) NOT NULL
	,[region] varchar(255) NOT NULL
	,[addressUid] NUMERIC(38, 20) NOT NULL
	,[addressLine1] varchar(255) NOT NULL
	,[addressLine2] varchar(255) NOT NULL
	,[city] varchar(255) NOT NULL
	,[stateOrProvince] varchar(255) NOT NULL
	,[postalCodeNumber] varchar(255) NOT NULL
	,[countryCode] varchar(255) NOT NULL
	,[locationQualifierCode] varchar(255) NOT NULL
	,[locationCode] varchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentOrderFinalDestination] ON ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentOrderFinalDestination ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[shipmentOrderGUID]
	,[shipmentOrderFinalDestinationGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentOrderFinalDestination ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentOrderFinalDestination PRIMARY KEY
(
	[PartnerId] ASC
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[shipmentOrderGUID] asc
	,[shipmentOrderFinalDestinationGUID] asc
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentOrderFinalDestinationHist' AND type ='U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentOrderFinalDestinationHist(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[shipmentOrderGUID] varchar(50) NOT NULL
	,[shipmentOrderFinalDestinationGUID] varchar(50) NOT NULL
	,[partyUid] NUMERIC(38, 20) NOT NULL
	,[partyRoleCode] varchar(255) NOT NULL
	,[memberId] NUMERIC(38, 20) NOT NULL
	,[divisionUid] NUMERIC(38, 20) NOT NULL
	,[name] varchar(255) NOT NULL
	,[longName] varchar(255) NOT NULL
	,[ContactName] varchar(255) NOT NULL
	,[emailAddress] varchar(255) NOT NULL
	,[phone] varchar(255) NOT NULL
	,[fax] varchar(255) NOT NULL
	,[department] varchar(255) NOT NULL
	,[region] varchar(255) NOT NULL
	,[addressUid] NUMERIC(38, 20) NOT NULL
	,[addressLine1] varchar(255) NOT NULL
	,[addressLine2] varchar(255) NOT NULL
	,[city] varchar(255) NOT NULL
	,[stateOrProvince] varchar(255) NOT NULL
	,[postalCodeNumber] varchar(255) NOT NULL
	,[countryCode] varchar(255) NOT NULL
	,[locationQualifierCode] varchar(255) NOT NULL
	,[locationCode] varchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentOrderFinalDestinationHist] ON ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentOrderFinalDestinationHist ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[shipmentOrderGUID]
	,[shipmentOrderFinalDestinationGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentOrderFinalDestinationHist ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentOrderFinalDestinationHist PRIMARY KEY
(
	[PartnerId] ASC
	,[EffDate] asc
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[shipmentOrderGUID] asc
	,[shipmentOrderFinalDestinationGUID] asc
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportFInalDestanationIdentification' AND type ='U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportFInalDestanationIdentification(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[shipmentOrderGUID] varchar(50) NOT NULL
	,[shipmentOrderFinalDestinationGUID] varchar(50) NOT NULL
	,[FInalDestanationIdentificationGUID] varchar(50) NOT NULL
	,[type] varchar(255) NOT NULL
	,[value] varchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportFInalDestanationIdentification] ON ttdStagingGeneric_GTNexus_Packing_List_ImportFInalDestanationIdentification ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[shipmentOrderGUID]
	,[shipmentOrderFinalDestinationGUID]
	,[FInalDestanationIdentificationGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportFInalDestanationIdentification ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportFInalDestanationIdentification PRIMARY KEY
(
	[PartnerId] ASC
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[shipmentOrderGUID] asc
	,[shipmentOrderFinalDestinationGUID] asc
	,[FInalDestanationIdentificationGUID] asc
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportFInalDestanationIdentificationHist' AND type ='U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportFInalDestanationIdentificationHist(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[shipmentOrderGUID] varchar(50) NOT NULL
	,[shipmentOrderFinalDestinationGUID] varchar(50) NOT NULL
	,[FInalDestanationIdentificationGUID] varchar(50) NOT NULL
	,[type] varchar(255) NOT NULL
	,[value] varchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportFInalDestanationIdentificationHist] ON ttdStagingGeneric_GTNexus_Packing_List_ImportFInalDestanationIdentificationHist ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[shipmentOrderGUID]
	,[shipmentOrderFinalDestinationGUID]
	,[FInalDestanationIdentificationGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportFInalDestanationIdentificationHist ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportFInalDestanationIdentificationHist PRIMARY KEY
(
	[PartnerId] ASC
	,[EffDate] asc
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[shipmentOrderGUID] asc
	,[shipmentOrderFinalDestinationGUID] asc
	,[FInalDestanationIdentificationGUID] asc
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_Importreference' AND type ='U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_Importreference(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[shipmentOrderGUID] varchar(50) NOT NULL
	,[shipmentOrderFinalDestinationGUID] varchar(50) NOT NULL
	,[referenceGUID] varchar(50) NOT NULL
	,[type] varchar(255) NOT NULL
	,[value] varchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_Importreference] ON ttdStagingGeneric_GTNexus_Packing_List_Importreference ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[shipmentOrderGUID]
	,[shipmentOrderFinalDestinationGUID]
	,[referenceGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_Importreference ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_Importreference PRIMARY KEY
(
	[PartnerId] ASC
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[shipmentOrderGUID] asc
	,[shipmentOrderFinalDestinationGUID] asc
	,[referenceGUID] asc
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportreferenceHist' AND type ='U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportreferenceHist(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[shipmentOrderGUID] varchar(50) NOT NULL
	,[shipmentOrderFinalDestinationGUID] varchar(50) NOT NULL
	,[referenceGUID] varchar(50) NOT NULL
	,[type] varchar(255) NOT NULL
	,[value] varchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportreferenceHist] ON ttdStagingGeneric_GTNexus_Packing_List_ImportreferenceHist ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[shipmentOrderGUID]
	,[shipmentOrderFinalDestinationGUID]
	,[referenceGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportreferenceHist ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportreferenceHist PRIMARY KEY
(
	[PartnerId] ASC
	,[EffDate] asc
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[shipmentOrderGUID] asc
	,[shipmentOrderFinalDestinationGUID] asc
	,[referenceGUID] asc
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportorderReference' AND type ='U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportorderReference(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[shipmentOrderGUID] varchar(50) NOT NULL
	,[orderReferenceGUID] varchar(50) NOT NULL
	,[poNumber] varchar(255) NOT NULL
	,[orderUid] NUMERIC(38, 20) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportorderReference] ON ttdStagingGeneric_GTNexus_Packing_List_ImportorderReference ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[shipmentOrderGUID]
	,[orderReferenceGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportorderReference ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportorderReference PRIMARY KEY
(
	[PartnerId] ASC
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[shipmentOrderGUID] asc
	,[orderReferenceGUID] asc
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportorderReferenceHist' AND type ='U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportorderReferenceHist(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[shipmentOrderGUID] varchar(50) NOT NULL
	,[orderReferenceGUID] varchar(50) NOT NULL
	,[poNumber] varchar(255) NOT NULL
	,[orderUid] NUMERIC(38, 20) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportorderReferenceHist] ON ttdStagingGeneric_GTNexus_Packing_List_ImportorderReferenceHist ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[shipmentOrderGUID]
	,[orderReferenceGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportorderReferenceHist ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportorderReferenceHist PRIMARY KEY
(
	[PartnerId] ASC
	,[EffDate] asc
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[shipmentOrderGUID] asc
	,[orderReferenceGUID] asc
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportorderReferenceReference' AND type ='U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportorderReferenceReference(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[shipmentOrderGUID] varchar(50) NOT NULL
	,[orderReferenceGUID] varchar(50) NOT NULL
	,[orderReferenceReferenceGUID] varchar(50) NOT NULL
	,[type] varchar(255) NOT NULL
	,[value] varchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportorderReferenceReference] ON ttdStagingGeneric_GTNexus_Packing_List_ImportorderReferenceReference ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[shipmentOrderGUID]
	,[orderReferenceGUID]
	,[orderReferenceReferenceGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportorderReferenceReference ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportorderReferenceReference PRIMARY KEY
(
	[PartnerId] ASC
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[shipmentOrderGUID] asc
	,[orderReferenceGUID] asc
	,[orderReferenceReferenceGUID] asc
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportorderReferenceReferenceHist' AND type ='U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportorderReferenceReferenceHist(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[shipmentOrderGUID] varchar(50) NOT NULL
	,[orderReferenceGUID] varchar(50) NOT NULL
	,[orderReferenceReferenceGUID] varchar(50) NOT NULL
	,[type] varchar(255) NOT NULL
	,[value] varchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportorderReferenceReferenceHist] ON ttdStagingGeneric_GTNexus_Packing_List_ImportorderReferenceReferenceHist ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[shipmentOrderGUID]
	,[orderReferenceGUID]
	,[orderReferenceReferenceGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportorderReferenceReferenceHist ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportorderReferenceReferenceHist PRIMARY KEY
(
	[PartnerId] ASC
	,[EffDate] asc
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[shipmentOrderGUID] asc
	,[orderReferenceGUID] asc
	,[orderReferenceReferenceGUID] asc
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportitemXref' AND type ='U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportitemXref(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[shipmentOrderGUID] varchar(50) NOT NULL
	,[itemXrefGUID] varchar(50) NOT NULL

	,[poNumber] varchar(255) NOT NULL
	,[itemKey] varchar(255) NOT NULL
	,[itemTypeCode] varchar(255) NOT NULL
	,[quantity] numeric(38,20) NOT NULL
	,[packInstructionReference] varchar(255) NOT NULL
	,[packageType] varchar(255) NOT NULL
	,[packMethodCode] varchar(255) NOT NULL
	,[quantityPerInnerPackage] NUMERIC(38, 20) NOT NULL
	,[quantityPerOuterPackage] NUMERIC(38, 20) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportitemXref] ON ttdStagingGeneric_GTNexus_Packing_List_ImportitemXref ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[shipmentOrderGUID]
	,[itemXrefGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportitemXref ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportitemXref PRIMARY KEY
(
	[PartnerId] ASC
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[shipmentOrderGUID] asc
	,[itemXrefGUID] asc
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportitemXrefHist' AND type ='U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportitemXrefHist(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[shipmentOrderGUID] varchar(50) NOT NULL
	,[itemXrefGUID] varchar(50) NOT NULL

	,[poNumber] varchar(255) NOT NULL
	,[itemKey] varchar(255) NOT NULL
	,[itemTypeCode] varchar(255) NOT NULL
	,[quantity] numeric(38,20) NOT NULL
	,[packInstructionReference] varchar(255) NOT NULL
	,[packageType] varchar(255) NOT NULL
	,[packMethodCode] varchar(255) NOT NULL
	,[quantityPerInnerPackage] NUMERIC(38, 20) NOT NULL
	,[quantityPerOuterPackage] NUMERIC(38, 20) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportitemXrefHist] ON ttdStagingGeneric_GTNexus_Packing_List_ImportitemXrefHist ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[shipmentOrderGUID]
	,[itemXrefGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportitemXrefHist ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportitemXrefHist PRIMARY KEY
(
	[PartnerId] ASC
	,[EffDate] asc
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[shipmentOrderGUID] asc
	,[itemXrefGUID] asc
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportpackageDetailXref' AND type ='U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportpackageDetailXref(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[shipmentOrderGUID] varchar(50) NOT NULL
	,[packageDetailXrefGUID] varchar(50) NOT NULL
	,[packageKey] varchar(255) NOT NULL
	,[packageQuantity] NUMERIC(38, 20) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportpackageDetailXref] ON ttdStagingGeneric_GTNexus_Packing_List_ImportpackageDetailXref ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[shipmentOrderGUID]
	,[packageDetailXrefGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportpackageDetailXref ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportpackageDetailXref PRIMARY KEY
(
	[PartnerId] ASC
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[shipmentOrderGUID] asc
	,[packageDetailXrefGUID] asc
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportpackageDetailXrefHist' AND type ='U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportpackageDetailXrefHist(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[shipmentOrderGUID] varchar(50) NOT NULL
	,[packageDetailXrefGUID] varchar(50) NOT NULL
	,[packageKey] varchar(255) NOT NULL
	,[packageQuantity] NUMERIC(38, 20) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportpackageDetailXrefHist] ON ttdStagingGeneric_GTNexus_Packing_List_ImportpackageDetailXrefHist ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[shipmentOrderGUID]
	,[packageDetailXrefGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportpackageDetailXrefHist ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportpackageDetailXrefHist PRIMARY KEY
(
	[PartnerId] ASC
	,[EffDate] asc
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[shipmentOrderGUID] asc
	,[packageDetailXrefGUID] asc
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentItem' AND type ='U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentItem(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[shipmentItemGUID] varchar(50) NOT NULL

	,[poNumber] varchar(255) NOT NULL
	,[itemKey] varchar(255) NOT NULL
	,[orderedQuantity] numeric(38,20) NOT NULL
	,[totalPackageQuantity] NUMERIC(38, 20) NOT NULL
	,[packMethodCode] varchar(255) NOT NULL
	,[weightUnitCode] varchar(255) NOT NULL
	,[totalGrossWeight] numeric(38,20) NOT NULL
	,[totalNetWeight] numeric(38,20) NOT NULL
	,[totalNetNetWeight] numeric(38,20) NOT NULL
	,[volumeUnitCode] varchar(255) NOT NULL
	,[totalGrossVolume] numeric(38,20) NOT NULL
	,[volumeWeightUnitCode] varchar(255) NOT NULL
	,[totalVolumeWeight] numeric(38,20) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentItem] ON ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentItem ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[shipmentItemGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentItem ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentItem PRIMARY KEY
(
	[PartnerId] ASC
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[shipmentItemGUID] asc
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentItemHist' AND type ='U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentItemHist(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[shipmentItemGUID] varchar(50) NOT NULL

	,[poNumber] varchar(255) NOT NULL
	,[itemKey] varchar(255) NOT NULL
	,[orderedQuantity] numeric(38,20) NOT NULL
	,[totalPackageQuantity] NUMERIC(38, 20) NOT NULL
	,[packMethodCode] varchar(255) NOT NULL
	,[weightUnitCode] varchar(255) NOT NULL
	,[totalGrossWeight] numeric(38,20) NOT NULL
	,[totalNetWeight] numeric(38,20) NOT NULL
	,[totalNetNetWeight] numeric(38,20) NOT NULL
	,[volumeUnitCode] varchar(255) NOT NULL
	,[totalGrossVolume] numeric(38,20) NOT NULL
	,[volumeWeightUnitCode] varchar(255) NOT NULL
	,[totalVolumeWeight] numeric(38,20) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentItemHist] ON ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentItemHist ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[shipmentItemGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentItemHist ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentItemHist PRIMARY KEY
(
	[PartnerId] ASC
	,[EffDate] asc
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[shipmentItemGUID] asc
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentItemBaseItem' AND type ='U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentItemBaseItem(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[shipmentItemGUID] varchar(50) NOT NULL
	,[shipmentItemBaseItemGUID] varchar(50) NOT NULL

	,[itemUid] NUMERIC(38, 20) NOT NULL
	,[itemFunctionCode] varchar(255) NOT NULL
	,[itemTypeCode] varchar(255) NOT NULL
	,[quantity] numeric(38,20) NOT NULL
	,[unitOfMeasureCode] varchar(255) NOT NULL
	,[isInspectionRequired] varchar(1) NOT NULL
	,[shipmentMethodCode] varchar(255) NOT NULL
	,[packInstructionReference] varchar(255) NOT NULL
	,[packageType] varchar(255) NOT NULL
	,[packMethodCode] varchar(255) NOT NULL
	,[quantityPerInnerPackage] NUMERIC(38, 20) NOT NULL
	,[quantityPerOuterPackage] NUMERIC(38, 20) NOT NULL
	,[upperVariance] numeric(38,20) NOT NULL
	,[lowerVariance] numeric(38,20) NOT NULL
	,[varianceTypeCode] varchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentItemBaseItem] ON ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentItemBaseItem ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[shipmentItemGUID]
	,[shipmentItemBaseItemGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentItemBaseItem ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentItemBaseItem PRIMARY KEY
(
	[PartnerId] ASC
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[shipmentItemGUID] asc
	,[shipmentItemBaseItemGUID] asc
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentItemBaseItemHist' AND type ='U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentItemBaseItemHist(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[shipmentItemGUID] varchar(50) NOT NULL
	,[shipmentItemBaseItemGUID] varchar(50) NOT NULL

	,[itemUid] NUMERIC(38, 20) NOT NULL
	,[itemFunctionCode] varchar(255) NOT NULL
	,[itemTypeCode] varchar(255) NOT NULL
	,[quantity] numeric(38,20) NOT NULL
	,[unitOfMeasureCode] varchar(255) NOT NULL
	,[isInspectionRequired] varchar(1) NOT NULL
	,[shipmentMethodCode] varchar(255) NOT NULL
	,[packInstructionReference] varchar(255) NOT NULL
	,[packageType] varchar(255) NOT NULL
	,[packMethodCode] varchar(255) NOT NULL
	,[quantityPerInnerPackage] NUMERIC(38, 20) NOT NULL
	,[quantityPerOuterPackage] NUMERIC(38, 20) NOT NULL
	,[upperVariance] numeric(38,20) NOT NULL
	,[lowerVariance] numeric(38,20) NOT NULL
	,[varianceTypeCode] varchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentItemBaseItemHist] ON ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentItemBaseItemHist ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[shipmentItemGUID]
	,[shipmentItemBaseItemGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentItemBaseItemHist ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentItemBaseItemHist PRIMARY KEY
(
	[PartnerId] ASC
	,[EffDate] asc
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[shipmentItemGUID] asc
	,[shipmentItemBaseItemGUID] asc
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportitemIdentifier' AND type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportitemIdentifier(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[shipmentItemGUID] varchar(50) NOT NULL
	,[itemIdentifierGUID] varchar(50) NOT NULL
	,[shipmentItemBaseItemGUID] varchar(50) NOT NULL
	,[itemIdentifierTypeCode] varchar(255) NOT NULL
	,[itemIdentifierValue] varchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportitemIdentifier] ON ttdStagingGeneric_GTNexus_Packing_List_ImportitemIdentifier ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[shipmentItemGUID]
	,[shipmentItemBaseItemGUID]
	,[itemIdentifierGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportitemIdentifier ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportitemIdentifier PRIMARY KEY
(
	[PartnerId] ASC
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[shipmentItemGUID] asc
	,[shipmentItemBaseItemGUID] asc
	,[itemIdentifierGUID] asc
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportitemIdentifierHist' AND type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportitemIdentifierHist(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[shipmentItemGUID] varchar(50) NOT NULL
	,[itemIdentifierGUID] varchar(50) NOT NULL
	,[shipmentItemBaseItemGUID] varchar(50) NOT NULL
	,[itemIdentifierTypeCode] varchar(255) NOT NULL
	,[itemIdentifierValue] varchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportitemIdentifierHist] ON ttdStagingGeneric_GTNexus_Packing_List_ImportitemIdentifierHist ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[shipmentItemGUID]
	,[shipmentItemBaseItemGUID]
	,[itemIdentifierGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportitemIdentifierHist ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportitemIdentifierHist PRIMARY KEY
(
	[PartnerId] ASC
	,[EffDate] asc
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[shipmentItemGUID] asc
	,[shipmentItemBaseItemGUID] asc
	,[itemIdentifierGUID] asc
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportitemDescriptor' AND type ='U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportitemDescriptor(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[shipmentItemGUID] varchar(50) NOT NULL
	,[itemDescriptorGUID] varchar(50) NOT NULL
	,[shipmentItemBaseItemGUID] varchar(50) NOT NULL
	,[itemDescriptorTypeCode] varchar(255) NOT NULL
	,[itemDescriptorValue] varchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportitemDescriptor] ON ttdStagingGeneric_GTNexus_Packing_List_ImportitemDescriptor ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[shipmentItemGUID]
	,[shipmentItemBaseItemGUID]
	,[itemDescriptorGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportitemDescriptor ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportitemDescriptor PRIMARY KEY
(
	[PartnerId] ASC
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[shipmentItemGUID] asc
	,[shipmentItemBaseItemGUID] asc
	,[itemDescriptorGUID] asc
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportitemDescriptorHist' AND type ='U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportitemDescriptorHist(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[shipmentItemGUID] varchar(50) NOT NULL
	,[itemDescriptorGUID] varchar(50) NOT NULL
	,[shipmentItemBaseItemGUID] varchar(50) NOT NULL
	,[itemDescriptorTypeCode] varchar(255) NOT NULL
	,[itemDescriptorValue] varchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportitemDescriptorHist] ON ttdStagingGeneric_GTNexus_Packing_List_ImportitemDescriptorHist ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[shipmentItemGUID]
	,[shipmentItemBaseItemGUID]
	,[itemDescriptorGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportitemDescriptorHist ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportitemDescriptorHist PRIMARY KEY
(
	[PartnerId] ASC
	,[EffDate] asc
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[shipmentItemGUID] asc
	,[shipmentItemBaseItemGUID] asc
	,[itemDescriptorGUID] asc
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportcustomsClassification' AND type ='U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportcustomsClassification(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[shipmentItemGUID] varchar(50) NOT NULL
	,[customsClassificationGUID] varchar(50) NOT NULL
	,[shipmentItemBaseItemGUID] varchar(50) NOT NULL
	,[classificationNumber] varchar(255) NOT NULL
	,[classificationDescription] varchar(255) NOT NULL
	,[countryCode] varchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportcustomsClassification] ON ttdStagingGeneric_GTNexus_Packing_List_ImportcustomsClassification ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[shipmentItemGUID]
	,[shipmentItemBaseItemGUID]
	,[customsClassificationGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportcustomsClassification ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportcustomsClassification PRIMARY KEY
(
	[PartnerId] ASC
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[shipmentItemGUID] asc
	,[shipmentItemBaseItemGUID] asc
	,[customsClassificationGUID] asc
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportcustomsClassificationHist' AND type ='U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportcustomsClassificationHist(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[shipmentItemGUID] varchar(50) NOT NULL
	,[customsClassificationGUID] varchar(50) NOT NULL
	,[shipmentItemBaseItemGUID] varchar(50) NOT NULL
	,[classificationNumber] varchar(255) NOT NULL
	,[classificationDescription] varchar(255) NOT NULL
	,[countryCode] varchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportcustomsClassificationHist] ON ttdStagingGeneric_GTNexus_Packing_List_ImportcustomsClassificationHist ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[shipmentItemGUID]
	,[shipmentItemBaseItemGUID]
	,[customsClassificationGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportcustomsClassificationHist ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportcustomsClassificationHist PRIMARY KEY
(
	[PartnerId] ASC
	,[EffDate] asc
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[shipmentItemGUID] asc
	,[shipmentItemBaseItemGUID] asc
	,[customsClassificationGUID] asc
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentItemBaseItemReference' AND type ='U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentItemBaseItemReference(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[shipmentItemGUID] varchar(50) NOT NULL
	,[shipmentItemBaseItemReferenceGUID] varchar(50) NOT NULL
	,[shipmentItemBaseItemGUID] varchar(50) NOT NULL
	,[type] varchar(255) NOT NULL
	,[value] varchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentItemBaseItemReference] ON ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentItemBaseItemReference ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[shipmentItemGUID]
	,[shipmentItemBaseItemGUID]
	,[shipmentItemBaseItemReferenceGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentItemBaseItemReference ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentItemBaseItemReference PRIMARY KEY
(
	[PartnerId] ASC
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[shipmentItemGUID] asc
	,[shipmentItemBaseItemGUID] asc
	,[shipmentItemBaseItemReferenceGUID] asc
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentItemBaseItemReferenceHist' AND type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentItemBaseItemReferenceHist(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[shipmentItemGUID] varchar(50) NOT NULL
	,[shipmentItemBaseItemGUID] varchar(50) NOT NULL
	,[shipmentItemBaseItemReferenceGUID] varchar(50) NOT NULL
	,[type] varchar(255) NOT NULL
	,[value] varchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentItemBaseItemReferenceHist] ON ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentItemBaseItemReferenceHist ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[shipmentItemGUID]
	,[shipmentItemBaseItemGUID]
	,[shipmentItemBaseItemReferenceGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentItemBaseItemReferenceHist ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentItemBaseItemReferenceHist PRIMARY KEY
(
	[PartnerId] ASC
	,[EffDate] asc
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[shipmentItemGUID] asc
	,[shipmentItemBaseItemGUID] asc
	,[shipmentItemBaseItemReferenceGUID] asc
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportdestinationQuantity' AND type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportdestinationQuantity(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[shipmentItemGUID] varchar(50) NOT NULL
	,[destinationQuantityGUID] varchar(50) NOT NULL
	,[shipmentItemBaseItemGUID] varchar(50) NOT NULL
	,[finalDestinationName] varchar(255) NOT NULL
	,[quantity] numeric(38,20) NOT NULL
	,[unitOfMeasureCode] varchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportdestinationQuantity] ON ttdStagingGeneric_GTNexus_Packing_List_ImportdestinationQuantity ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[shipmentItemGUID]
	,[shipmentItemBaseItemGUID]
	,[destinationQuantityGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportdestinationQuantity ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportdestinationQuantity PRIMARY KEY
(
	[PartnerId] ASC
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[shipmentItemGUID] asc
	,[shipmentItemBaseItemGUID] asc
	,[destinationQuantityGUID] asc
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportdestinationQuantityHist' AND type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportdestinationQuantityHist(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[shipmentItemGUID] varchar(50) NOT NULL
	,[destinationQuantityGUID] varchar(50) NOT NULL
	,[shipmentItemBaseItemGUID] varchar(50) NOT NULL
	,[finalDestinationName] varchar(255) NOT NULL
	,[quantity] numeric(38,20) NOT NULL
	,[unitOfMeasureCode] varchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportdestinationQuantityHist] ON ttdStagingGeneric_GTNexus_Packing_List_ImportdestinationQuantityHist ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[shipmentItemGUID]
	,[shipmentItemBaseItemGUID]
	,[destinationQuantityGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportdestinationQuantityHist ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportdestinationQuantityHist PRIMARY KEY
(
	[PartnerId] ASC
	,[EffDate] asc
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[shipmentItemGUID] asc
	,[shipmentItemBaseItemGUID] asc
	,[destinationQuantityGUID] asc
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportitemDate' AND type ='U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportitemDate(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[shipmentItemGUID] varchar(50) NOT NULL
	,[itemDateGUID] varchar(50) NOT NULL
	,[shipmentItemBaseItemGUID] varchar(50) NOT NULL
	,[itemDateTypeCode] varchar(255) NOT NULL
	,[itemDateValue] datetime NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportitemDate] ON ttdStagingGeneric_GTNexus_Packing_List_ImportitemDate ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[shipmentItemGUID]
	,[shipmentItemBaseItemGUID]
	,[itemDateGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportitemDate ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportitemDate PRIMARY KEY
(
	[PartnerId] ASC
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[shipmentItemGUID] asc
	,[shipmentItemBaseItemGUID] asc
	,[itemDateGUID] asc
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportitemDateHist' AND type ='U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportitemDateHist(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[shipmentItemGUID] varchar(50) NOT NULL
	,[itemDateGUID] varchar(50) NOT NULL
	,[shipmentItemBaseItemGUID] varchar(50) NOT NULL
	,[itemDateTypeCode] varchar(255) NOT NULL
	,[itemDateValue] datetime NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportitemDateHist] ON ttdStagingGeneric_GTNexus_Packing_List_ImportitemDateHist ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[shipmentItemGUID]
	,[shipmentItemBaseItemGUID]
	,[itemDateGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportitemDateHist ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportitemDateHist PRIMARY KEY
(
	[PartnerId] ASC
	,[EffDate] asc
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[shipmentItemGUID] asc
	,[shipmentItemBaseItemGUID] asc
	,[itemDateGUID] asc
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_Importmeasurement' AND type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_Importmeasurement(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[shipmentItemGUID] varchar(50) NOT NULL
	,[measurementGUID] varchar(50) NOT NULL
	,[shipmentItemBaseItemGUID] varchar(50) NOT NULL
	,[measurementTypeCode] varchar(255) NOT NULL
	,[measurementValue] numeric(38,20) NOT NULL
	,[unitOfMeasureCode] varchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_Importmeasurement] ON ttdStagingGeneric_GTNexus_Packing_List_Importmeasurement ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[shipmentItemGUID]
	,[shipmentItemBaseItemGUID]
	,[measurementGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_Importmeasurement ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_Importmeasurement PRIMARY KEY
(
	[PartnerId] ASC
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[shipmentItemGUID] asc
	,[shipmentItemBaseItemGUID] asc
	,[measurementGUID] asc
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportmeasurementHist' AND type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportmeasurementHist(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[shipmentItemGUID] varchar(50) NOT NULL
	,[measurementGUID] varchar(50) NOT NULL
	,[shipmentItemBaseItemGUID] varchar(50) NOT NULL
	,[measurementTypeCode] varchar(255) NOT NULL
	,[measurementValue] numeric(38,20) NOT NULL
	,[unitOfMeasureCode] varchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportmeasurementHist] ON ttdStagingGeneric_GTNexus_Packing_List_ImportmeasurementHist ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[shipmentItemGUID]
	,[shipmentItemBaseItemGUID]
	,[measurementGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportmeasurementHist ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportmeasurementHist PRIMARY KEY
(
	[PartnerId] ASC
	,[EffDate] asc
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[shipmentItemGUID] asc
	,[shipmentItemBaseItemGUID] asc
	,[measurementGUID] asc
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportbaseItemParty' AND type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportbaseItemParty(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[shipmentItemGUID] varchar(50) NOT NULL
	,[baseItemPartyGUID] varchar(50) NOT NULL
	,[shipmentItemBaseItemGUID] varchar(50) NOT NULL
	,[partyUid] NUMERIC(38, 20) NOT NULL
	,[partyRoleCode] varchar(255) NOT NULL
	,[memberId] NUMERIC(38, 20) NOT NULL
	,[divisionUid] NUMERIC(38, 20) NOT NULL
	,[name] varchar(255) NOT NULL
	,[longName] varchar(255) NOT NULL
	,[ContactName] varchar(255) NOT NULL
	,[emailAddress] varchar(255) NOT NULL
	,[phone] varchar(255) NOT NULL
	,[fax] varchar(255) NOT NULL
	,[department] varchar(255) NOT NULL
	,[region] varchar(255) NOT NULL
	,[addressUid] NUMERIC(38, 20) NOT NULL
	,[addressLine1] varchar(255) NOT NULL
	,[addressLine2] varchar(255) NOT NULL
	,[city] varchar(255) NOT NULL
	,[stateOrProvince] varchar(255) NOT NULL
	,[postalCodeNumber] varchar(255) NOT NULL
	,[countryCode] varchar(255) NOT NULL
	,[locationQualifierCode] varchar(255) NOT NULL
	,[locationCode] varchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportbaseItemParty] ON ttdStagingGeneric_GTNexus_Packing_List_ImportbaseItemParty ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[shipmentItemGUID]
	,[shipmentItemBaseItemGUID]
	,[baseItemPartyGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportbaseItemParty ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportbaseItemParty PRIMARY KEY
(
	[PartnerId] ASC
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[shipmentItemGUID] asc
	,[shipmentItemBaseItemGUID] asc
	,[baseItemPartyGUID] asc
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportbaseItemPartyHist' AND type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportbaseItemPartyHist(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[shipmentItemGUID] varchar(50) NOT NULL
	,[baseItemPartyGUID] varchar(50) NOT NULL
	,[shipmentItemBaseItemGUID] varchar(50) NOT NULL
	,[partyUid] NUMERIC(38, 20) NOT NULL
	,[partyRoleCode] varchar(255) NOT NULL
	,[memberId] NUMERIC(38, 20) NOT NULL
	,[divisionUid] NUMERIC(38, 20) NOT NULL
	,[name] varchar(255) NOT NULL
	,[longName] varchar(255) NOT NULL
	,[ContactName] varchar(255) NOT NULL
	,[emailAddress] varchar(255) NOT NULL
	,[phone] varchar(255) NOT NULL
	,[fax] varchar(255) NOT NULL
	,[department] varchar(255) NOT NULL
	,[region] varchar(255) NOT NULL
	,[addressUid] NUMERIC(38, 20) NOT NULL
	,[addressLine1] varchar(255) NOT NULL
	,[addressLine2] varchar(255) NOT NULL
	,[city] varchar(255) NOT NULL
	,[stateOrProvince] varchar(255) NOT NULL
	,[postalCodeNumber] varchar(255) NOT NULL
	,[countryCode] varchar(255) NOT NULL
	,[locationQualifierCode] varchar(255) NOT NULL
	,[locationCode] varchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportbaseItemPartyHist] ON ttdStagingGeneric_GTNexus_Packing_List_ImportbaseItemPartyHist ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[shipmentItemGUID]
	,[shipmentItemBaseItemGUID]
	,[baseItemPartyGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportbaseItemPartyHist ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportbaseItemPartyHist PRIMARY KEY
(
	[PartnerId] ASC
	,[EffDate] asc
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[shipmentItemGUID] asc
	,[shipmentItemBaseItemGUID] asc
	,[baseItemPartyGUID] asc
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportbaseItemIdentification' AND type ='U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportbaseItemIdentification(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[shipmentItemGUID] varchar(50) NOT NULL
	,[shipmentItemBaseItemGUID] varchar(50) NOT NULL
	,[baseItemPartyGUID] varchar(50) NOT NULL
	,[baseItemIdentificationGUID] varchar(50) NOT NULL
	,[type] varchar(255) NOT NULL
	,[value] varchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportbaseItemIdentification] ON ttdStagingGeneric_GTNexus_Packing_List_ImportbaseItemIdentification ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[shipmentItemGUID]
	,[shipmentItemBaseItemGUID]
	,[baseItemPartyGUID]
	,[baseItemIdentificationGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportbaseItemIdentification ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportbaseItemIdentification PRIMARY KEY
(
	[PartnerId] ASC
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[shipmentItemGUID] asc
	,[shipmentItemBaseItemGUID] asc
	,[baseItemPartyGUID] asc
	,[baseItemIdentificationGUID] asc
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportbaseItemIdentificationHist' AND type ='U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportbaseItemIdentificationHist(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[shipmentItemGUID] varchar(50) NOT NULL
	,[shipmentItemBaseItemGUID] varchar(50) NOT NULL
	,[baseItemPartyGUID] varchar(50) NOT NULL
	,[baseItemIdentificationGUID] varchar(50) NOT NULL
	,[type] varchar(255) NOT NULL
	,[value] varchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportbaseItemIdentificationHist] ON ttdStagingGeneric_GTNexus_Packing_List_ImportbaseItemIdentificationHist ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[shipmentItemGUID]
	,[shipmentItemBaseItemGUID]
	,[baseItemPartyGUID]
	,[baseItemIdentificationGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportbaseItemIdentificationHist ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportbaseItemIdentificationHist PRIMARY KEY
(
	[PartnerId] ASC
	,[EffDate] asc
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[shipmentItemGUID] asc
	,[shipmentItemBaseItemGUID] asc
	,[baseItemPartyGUID] asc
	,[baseItemIdentificationGUID] asc
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportbaseItemReference' AND type ='U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportbaseItemReference(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[shipmentItemGUID] varchar(50) NOT NULL
	,[shipmentItemBaseItemGUID] varchar(50) NOT NULL
	,[baseItemPartyGUID] varchar(50) NOT NULL
	,[baseItemReferenceGUID] varchar(50) NOT NULL
	,[type] varchar(255) NOT NULL
	,[value] varchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportbaseItemReference] ON ttdStagingGeneric_GTNexus_Packing_List_ImportbaseItemReference ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[shipmentItemGUID]
	,[shipmentItemBaseItemGUID]
	,[baseItemPartyGUID]
	,[baseItemReferenceGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportbaseItemReference ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportbaseItemReference PRIMARY KEY
(
	[PartnerId] ASC
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[shipmentItemGUID] asc
	,[shipmentItemBaseItemGUID] asc
	,[baseItemPartyGUID] asc
	,[baseItemReferenceGUID] asc
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportbaseItemReferenceHist' AND type ='U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportbaseItemReferenceHist(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[shipmentItemGUID] varchar(50) NOT NULL
	,[shipmentItemBaseItemGUID] varchar(50) NOT NULL
	,[baseItemPartyGUID] varchar(50) NOT NULL
	,[baseItemReferenceGUID] varchar(50) NOT NULL
	,[type] varchar(255) NOT NULL
	,[value] varchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportbaseItemReferenceHist] ON ttdStagingGeneric_GTNexus_Packing_List_ImportbaseItemReferenceHist ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[shipmentItemGUID]
	,[shipmentItemBaseItemGUID]
	,[baseItemPartyGUID]
	,[baseItemReferenceGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportbaseItemReferenceHist ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportbaseItemReferenceHist PRIMARY KEY
(
	[PartnerId] ASC
	,[EffDate] asc
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[shipmentItemGUID] asc
	,[shipmentItemBaseItemGUID] asc
	,[baseItemPartyGUID] asc
	,[baseItemReferenceGUID] asc
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportBaseItemShipmentOrderXref' AND type ='U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportBaseItemShipmentOrderXref(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[shipmentItemGUID] varchar(50) NOT NULL
	,[BaseItemShipmentOrderXrefGUID] varchar(50) NOT NULL

	,[shipmentOrderKey] varchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportBaseItemShipmentOrderXref] ON ttdStagingGeneric_GTNexus_Packing_List_ImportBaseItemShipmentOrderXref ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[shipmentItemGUID]
	,[BaseItemShipmentOrderXrefGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportBaseItemShipmentOrderXref ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportBaseItemShipmentOrderXref PRIMARY KEY
(
	[PartnerId] ASC
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[shipmentItemGUID] asc
	,[BaseItemShipmentOrderXrefGUID] asc
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportBaseItemShipmentOrderXrefHist' AND type ='U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportBaseItemShipmentOrderXrefHist(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[shipmentItemGUID] varchar(50) NOT NULL
	,[BaseItemShipmentOrderXrefGUID] varchar(50) NOT NULL

	,[shipmentOrderKey] varchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportBaseItemShipmentOrderXrefHist] ON ttdStagingGeneric_GTNexus_Packing_List_ImportBaseItemShipmentOrderXrefHist ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[shipmentItemGUID]
	,[BaseItemShipmentOrderXrefGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportBaseItemShipmentOrderXrefHist ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportBaseItemShipmentOrderXrefHist PRIMARY KEY
(
	[PartnerId] ASC
	,[EffDate] asc
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[shipmentItemGUID] asc
	,[BaseItemShipmentOrderXrefGUID] asc
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportBaseItemPackageDetailXref' AND type ='U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportBaseItemPackageDetailXref(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[shipmentItemGUID] varchar(50) NOT NULL
	,[BaseItemPackageDetailXrefGUID] varchar(50) NOT NULL

	,[packageKey] varchar(255) NOT NULL
	,[packageQuantity] NUMERIC(38, 20) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportBaseItemPackageDetailXref] ON ttdStagingGeneric_GTNexus_Packing_List_ImportBaseItemPackageDetailXref ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[shipmentItemGUID]
	,[BaseItemPackageDetailXrefGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportBaseItemPackageDetailXref ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportBaseItemPackageDetailXref PRIMARY KEY
(
	[PartnerId] ASC
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[shipmentItemGUID] asc
	,[BaseItemPackageDetailXrefGUID] asc
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportBaseItemPackageDetailXrefHist' AND type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportBaseItemPackageDetailXrefHist(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[shipmentItemGUID] varchar(50) NOT NULL
	,[BaseItemPackageDetailXrefGUID] varchar(50) NOT NULL

	,[packageKey] varchar(255) NOT NULL
	,[packageQuantity] NUMERIC(38, 20) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportBaseItemPackageDetailXrefHist] ON ttdStagingGeneric_GTNexus_Packing_List_ImportBaseItemPackageDetailXrefHist ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[shipmentItemGUID]
	,[BaseItemPackageDetailXrefGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportBaseItemPackageDetailXrefHist ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportBaseItemPackageDetailXrefHist PRIMARY KEY
(
	[PartnerId] ASC
	,[EffDate] asc
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[shipmentItemGUID] asc
	,[BaseItemPackageDetailXrefGUID] asc
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_Importattachment' AND type ='U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_Importattachment(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[attachmentGUID] varchar(50) NOT NULL
	,[attachmentUid] varchar(255) NOT NULL
	,[revisionNumber] varchar(255) NOT NULL
	,[name] varchar(255) NOT NULL
	,[functionCode] varchar(255) NOT NULL
	,[description] varchar(255) NOT NULL
	,[encodingCode] varchar(255) NOT NULL
	,[mimeType] varchar(255) NOT NULL
	,[createUserId] varchar(255) NOT NULL
	,[contentSize] NUMERIC(38, 20) NOT NULL
	,[content] varchar(255) NOT NULL
	,[self] varchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_Importattachment] ON ttdStagingGeneric_GTNexus_Packing_List_Importattachment ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[attachmentGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_Importattachment ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_Importattachment PRIMARY KEY
(
	[PartnerId] ASC
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[attachmentGUID] asc
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportattachmentHist' AND type ='U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportattachmentHist(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[attachmentGUID] varchar(50) NOT NULL
	,[attachmentUid] varchar(255) NOT NULL
	,[revisionNumber] varchar(255) NOT NULL
	,[name] varchar(255) NOT NULL
	,[functionCode] varchar(255) NOT NULL
	,[description] varchar(255) NOT NULL
	,[encodingCode] varchar(255) NOT NULL
	,[mimeType] varchar(255) NOT NULL
	,[createUserId] varchar(255) NOT NULL
	,[contentSize] NUMERIC(38, 20) NOT NULL
	,[content] varchar(255) NOT NULL
	,[self] varchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportattachmentHist] ON ttdStagingGeneric_GTNexus_Packing_List_ImportattachmentHist ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[attachmentGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportattachmentHist ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportattachmentHist PRIMARY KEY
(
	[PartnerId] ASC
	,[EffDate] asc
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[attachmentGUID] asc
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentDocumentTotals' AND type ='U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentDocumentTotals(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[shipmentDocumentTotalsGUID] varchar(50) NOT NULL
	,[totalDocumentAmount] numeric(38,20) NOT NULL
	,[packagesTotalQuantity] numeric(38,20) NOT NULL
	,[itemsTotalQuantity] numeric(38,20) NOT NULL
	,[totalAllowanceChargeAmount] numeric(38,20) NOT NULL
	,[totalMerchandiseAmount] numeric(38,20) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentDocumentTotals] ON ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentDocumentTotals ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[shipmentDocumentTotalsGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentDocumentTotals ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentDocumentTotals PRIMARY KEY
(
	[PartnerId] ASC
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[shipmentDocumentTotalsGUID] asc
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentDocumentTotalsHist' AND type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentDocumentTotalsHist(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[shipmentDocumentTotalsGUID] varchar(50) NOT NULL
	,[totalDocumentAmount] numeric(38,20) NOT NULL
	,[packagesTotalQuantity] numeric(38,20) NOT NULL
	,[itemsTotalQuantity] numeric(38,20) NOT NULL
	,[totalAllowanceChargeAmount] numeric(38,20) NOT NULL
	,[totalMerchandiseAmount] numeric(38,20) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentDocumentTotalsHist] ON ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentDocumentTotalsHist ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[shipmentDocumentTotalsGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentDocumentTotalsHist ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentDocumentTotalsHist PRIMARY KEY
(
	[PartnerId] ASC
	,[EffDate] asc
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[shipmentDocumentTotalsGUID] asc
)
END
GO



IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportsubscriptionEvent' AND type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportsubscriptionEvent(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[subscriptionEventGUID] varchar(50) NOT NULL
	,[eventTypeCode] varchar(255) NOT NULL
	,[eventRoleCode] varchar(255) NOT NULL
	,[eventDate] datetime NOT NULL
	,[eventDateTime] datetime NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportsubscriptionEvent] ON ttdStagingGeneric_GTNexus_Packing_List_ImportsubscriptionEvent ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[subscriptionEventGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportsubscriptionEvent ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportsubscriptionEvent PRIMARY KEY
(
	[PartnerId] ASC
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[subscriptionEventGUID] asc
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportsubscriptionEventHist' AND type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportsubscriptionEventHist(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[subscriptionEventGUID] varchar(50) NOT NULL
	,[eventTypeCode] varchar(255) NOT NULL
	,[eventRoleCode] varchar(255) NOT NULL
	,[eventDate] datetime NOT NULL
	,[eventDateTime] datetime NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportsubscriptionEventHist] ON ttdStagingGeneric_GTNexus_Packing_List_ImportsubscriptionEventHist ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[subscriptionEventGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportsubscriptionEventHist ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportsubscriptionEventHist PRIMARY KEY
(
	[PartnerId] ASC
	,[EffDate] asc
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[subscriptionEventGUID] asc
)
END
GO


IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentItemBaseItemReference' AND type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentItemBaseItemReference(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[shipmentItemGUID] varchar(50) NOT NULL
	,[shipmentItemBaseItemGUID] varchar(50) NOT NULL
	,[shipmentItemBaseItemReferenceGUID] varchar(50) NOT NULL
	,[type] varchar(255) NOT NULL
	,[value] varchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentItemBaseItemReference] ON ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentItemBaseItemReference ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[shipmentItemGUID]
	,[shipmentItemBaseItemGUID]
	,[shipmentItemBaseItemReferenceGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentItemBaseItemReference ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentItemBaseItemReference PRIMARY KEY
(
	[PartnerId] ASC
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[shipmentItemGUID] asc
	,[shipmentItemBaseItemGUID] asc
	,[shipmentItemBaseItemReferenceGUID] asc
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentItemBaseItemReferenceHist' AND type ='U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentItemBaseItemReferenceHist(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[PackingListGUID] varchar(50) NOT NULL
	,[packingListDetailGUID] varchar(50) NOT NULL
	,[shipmentItemGUID] varchar(50) NOT NULL
	,[shipmentItemBaseItemGUID] varchar(50) NOT NULL
	,[shipmentItemBaseItemReferenceGUID] varchar(50) NOT NULL
	,[type] varchar(255) NOT NULL
	,[value] varchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentItemBaseItemReferenceHist] ON ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentItemBaseItemReferenceHist ( 
	 [PartnerId]
	,[PackingListGUID]
	,[packingListDetailGUID]
	,[shipmentItemGUID]
	,[shipmentItemBaseItemGUID]
	,[shipmentItemBaseItemReferenceGUID])
ALTER TABLE dbo.ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentItemBaseItemReferenceHist ADD CONSTRAINT PK_ttdStagingGeneric_GTNexus_Packing_List_ImportshipmentItemBaseItemReferenceHist PRIMARY KEY
(
	[PartnerId] ASC
	,[EffDate] asc
	,[PackingListGUID] ASC
	,[packingListDetailGUID] ASC
	,[shipmentItemGUID] asc
	,[shipmentItemBaseItemGUID] asc
	,[shipmentItemBaseItemReferenceGUID] asc
)
END
GO
