------------------------------ttdStagingGeneric_GTN_ASN_ImportASNMessage-----------------------------

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGeneric_GTN_ASN_ImportASNMessage' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTN_ASN_ImportASNMessage(
	[PartnerId] int NOT NULL
	,[EffDate] datetime NOT NULL
	,[ASNMessageGUID] varchar(50) NOT NULL
	,[MessageSender] varchar(255) NOT NULL
	,[MessageRecipient] varchar(255) NOT NULL
	,[MessageID] varchar(255) NOT NULL
	,[Created] datetime NOT NULL
	,[FileName] varchar(255) NOT NULL
	,[MessageOriginator] varchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTN_ASN_ImportASNMessage] ON ttdStagingGeneric_GTN_ASN_ImportASNMessage 
( 
	 [PartnerId]
	,[ASNMessageGUID]
)
ALTER TABLE [dbo].[ttdStagingGeneric_GTN_ASN_ImportASNMessage] ADD CONSTRAINT [PK_ttdStagingGeneric_GTN_ASN_ImportASNMessage] PRIMARY KEY 
(
     [PartnerID] ASC
    ,[ASNMessageGUID] ASC
 )
END

-------------------------------------ttdStagingGeneric_GTN_ASN_ImportASNMessageHist-----------------------------------

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGeneric_GTN_ASN_ImportASNMessageHist' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTN_ASN_ImportASNMessageHist(
	[PartnerId] int NOT NULL
	,[EffDate] datetime NOT NULL
	,[ASNMessageGUID] varchar(50) NOT NULL
	,[MessageSender] varchar(255) NOT NULL
	,[MessageRecipient] varchar(255) NOT NULL
	,[MessageID] varchar(255) NOT NULL
	,[Created] datetime NOT NULL
	,[FileName] varchar(255) NOT NULL
	,[MessageOriginator] varchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL	
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTN_ASN_ImportASNMessageHist] ON ttdStagingGeneric_GTN_ASN_ImportASNMessageHist 
( 
	 [PartnerId]
	,[ASNMessageGUID]
)
ALTER TABLE [dbo].[ttdStagingGeneric_GTN_ASN_ImportASNMessageHist] ADD CONSTRAINT [PK_ttdStagingGeneric_GTN_ASN_ImportASNMessageHist] PRIMARY KEY 
(
     [PartnerID] ASC
	,[EffDate] ASC
    ,[ASNMessageGUID] ASC
 )
END

----------------------------------------------------ttdStagingGeneric_GTN_ASN_ImportASN-----------------------------


IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGeneric_GTN_ASN_ImportASN' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTN_ASN_ImportASN(
	[PartnerId] int NOT NULL
	,[EffDate] datetime NOT NULL
	,[ASNMessageGUID] varchar(50) NOT NULL
	,[ASNGUID] varchar(50) NOT NULL
	,[ASNMessageID] varchar(255) NOT NULL
	,[PurposeCode] varchar(255) NOT NULL
	,[ShipmentID] varchar(255) NOT NULL
	,[ShipmentType] varchar(255) NOT NULL
	,[ShipmentStatus] varchar(255) NOT NULL
	,[Mode] varchar(255) NOT NULL
	,[ServiceLevel] varchar(255) NOT NULL
	,[Voyage] varchar(255) NOT NULL
	,[Vessel] varchar(255) NOT NULL
	,[Routing] varchar(255) NOT NULL
	,[PortOfDischargeTerminalNumber] varchar(255) NOT NULL
	,[EstBLDestDate] varchar(255) NOT NULL
	,[EstBLDestDateTimeZone] varchar(255) NOT NULL
	,[EstBLDestDateReportedLocalTimeZone] varchar(255) NOT NULL
	,[EstOnBoardDate] varchar(255) NOT NULL
	,[EstOnBoardDateTimeZone] varchar(255) NOT NULL
	,[EstOnBoardDateReportedLocalTimeZone] varchar(255) NOT NULL
	,[EstDepartDate] varchar(255) NOT NULL
	,[EstDepartDateTimeZone] varchar(255) NOT NULL
	,[EstDepartDateReportedLocalTimeZone] varchar(255) NOT NULL
	,[EstDischargePortDate] varchar(255) NOT NULL
	,[EstDischargePortDateTimeZone] varchar(255) NOT NULL
	,[EstDischargePortDateReportedLocalTimeZone] varchar(255) NOT NULL
	,[ChargeableWeight] varchar(255) NOT NULL
	,[ChargeableWeightUnit] varchar(255) NOT NULL
	,[ChargeableWeightANSICode] varchar(255) NOT NULL
	,[DimensionalWeight] varchar(255) NOT NULL
	,[DimensionalWeightUnit] varchar(255) NOT NULL
	,[DimensionalWeightANSICode] varchar(255) NOT NULL
	,[ActualWeight] varchar(255) NOT NULL
	,[ActualWeightUnit] varchar(255) NOT NULL
	,[ActualWeightANSICode] varchar(255) NOT NULL
	,[Volume] varchar(255) NOT NULL
	,[VolumeUnit] varchar(255) NOT NULL
	,[VolumeANSICode] varchar(255) NOT NULL
	,[LadingQuantity] varchar(255) NOT NULL
	,[ANSICodeUnit] varchar(255) NOT NULL
	,[ANSICodeANSICode] varchar(255) NOT NULL
	,[CarrierName] varchar(255) NOT NULL
	,[CarrierCode] varchar(255) NOT NULL
	,[CarrierContact] varchar(255) NOT NULL
	,[OriginCity_city_id] varchar(255) NOT NULL
	,[OriginCityCityName] varchar(255) NOT NULL
	,[OriginCityState] varchar(255) NOT NULL
	,[OriginCityCountryCode] varchar(255) NOT NULL
	,[OriginCityCountryName] varchar(255) NOT NULL
	,[PortOfLoading_city_id] varchar(255) NOT NULL
	,[PortOfLoadingCityName] varchar(255) NOT NULL
	,[PortOfLoadingState] varchar(255) NOT NULL
	,[PortOfLoadingCountryCode] varchar(255) NOT NULL
	,[PortOfLoadingCountryName] varchar(255) NOT NULL
	,[PortOfDischarge_city_id] varchar(255) NOT NULL
	,[PortOfDischargeCityName] varchar(255) NOT NULL
	,[PortOfDischargeState] varchar(255) NOT NULL
	,[PortOfDischargeCountryCode] varchar(255) NOT NULL
	,[PortOfDischargeCountryName] varchar(255) NOT NULL
	,[BLDestination_city_id] varchar(255) NOT NULL
	,[BLDestinationCityName] varchar(255) NOT NULL
	,[BLDestinationState] varchar(255) NOT NULL
	,[BLDestinationCountryCode] varchar(255) NOT NULL
	,[BLDestinationCountryName] varchar(255) NOT NULL
	,[PickUpLocationLocationCode] varchar(255) NOT NULL
	,[PickUpLocationName] varchar(255) NOT NULL
	,[PickUpLocationPostalCode] varchar(255) NOT NULL
	,[PickUpLocation_city_id] varchar(255) NOT NULL
	,[PickUpLocationCityName] varchar(255) NOT NULL
	,[PickUpLocationState] varchar(255) NOT NULL
	,[PickUpLocationCountryCode] varchar(255) NOT NULL
	,[PickUpLocationCountryName] varchar(255) NOT NULL
	,[DropOffLocationLocationCode] varchar(255) NOT NULL
	,[DropOffLocationName] varchar(255) NOT NULL
	,[DropOffLocationPostalCode] varchar(255) NOT NULL
	,[DropOffLocation_city_id] varchar(255) NOT NULL
	,[DropOffLocationCityName] varchar(255) NOT NULL
	,[DropOffLocationState] varchar(255) NOT NULL
	,[DropOffLocationCountryCode] varchar(255) NOT NULL
	,[DropOffLocationCountryName] varchar(255) NOT NULL

	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
		

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTN_ASN_ImportASN] ON ttdStagingGeneric_GTN_ASN_ImportASN ( 
		 [PartnerId]
		,[ASNMessageGUID]
		,[ASNGUID]
)
ALTER TABLE [dbo].[ttdStagingGeneric_GTN_ASN_ImportASN] ADD CONSTRAINT [PK_ttdStagingGeneric_GTN_ASN_ImportASN] PRIMARY KEY 
(
     [PartnerID] ASC
    ,[ASNMessageGUID] ASC
	,[ASNGUID] ASC
 )
END

---------------------------------------ttdStagingGeneric_GTN_ASN_ImportASNHist----------------------------------

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGeneric_GTN_ASN_ImportASNHist' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTN_ASN_ImportASNHist(
	[PartnerId] int NOT NULL
	,[EffDate] datetime NOT NULL
	,[ASNMessageGUID] varchar(50) NOT NULL
	,[ASNGUID] varchar(50) NOT NULL
	,[ASNMessageID] varchar(255) NOT NULL
	,[PurposeCode] varchar(255) NOT NULL
	,[ShipmentID] varchar(255) NOT NULL
	,[ShipmentType] varchar(255) NOT NULL
	,[ShipmentStatus] varchar(255) NOT NULL
	,[Mode] varchar(255) NOT NULL
	,[ServiceLevel] varchar(255) NOT NULL
	,[Voyage] varchar(255) NOT NULL
	,[Vessel] varchar(255) NOT NULL
	,[Routing] varchar(255) NOT NULL
	,[PortOfDischargeTerminalNumber] varchar(255) NOT NULL
	,[EstBLDestDate] varchar(255) NOT NULL
	,[EstBLDestDateTimeZone] varchar(255) NOT NULL
	,[EstBLDestDateReportedLocalTimeZone] varchar(255) NOT NULL
	,[EstOnBoardDate] varchar(255) NOT NULL
	,[EstOnBoardDateTimeZone] varchar(255) NOT NULL
	,[EstOnBoardDateReportedLocalTimeZone] varchar(255) NOT NULL
	,[EstDepartDate] varchar(255) NOT NULL
	,[EstDepartDateTimeZone] varchar(255) NOT NULL
	,[EstDepartDateReportedLocalTimeZone] varchar(255) NOT NULL
	,[EstDischargePortDate] varchar(255) NOT NULL
	,[EstDischargePortDateTimeZone] varchar(255) NOT NULL
	,[EstDischargePortDateReportedLocalTimeZone] varchar(255) NOT NULL
	,[ChargeableWeight] varchar(255) NOT NULL
	,[ChargeableWeightUnit] varchar(255) NOT NULL
	,[ChargeableWeightANSICode] varchar(255) NOT NULL
	,[DimensionalWeight] varchar(255) NOT NULL
	,[DimensionalWeightUnit] varchar(255) NOT NULL
	,[DimensionalWeightANSICode] varchar(255) NOT NULL
	,[ActualWeight] varchar(255) NOT NULL
	,[ActualWeightUnit] varchar(255) NOT NULL
	,[ActualWeightANSICode] varchar(255) NOT NULL
	,[Volume] varchar(255) NOT NULL
	,[VolumeUnit] varchar(255) NOT NULL
	,[VolumeANSICode] varchar(255) NOT NULL
	,[LadingQuantity] varchar(255) NOT NULL
	,[ANSICodeUnit] varchar(255) NOT NULL
	,[ANSICodeANSICode] varchar(255) NOT NULL
	,[CarrierName] varchar(255) NOT NULL
	,[CarrierCode] varchar(255) NOT NULL
	,[CarrierContact] varchar(255) NOT NULL
	,[OriginCity_city_id] varchar(255) NOT NULL
	,[OriginCityCityName] varchar(255) NOT NULL
	,[OriginCityState] varchar(255) NOT NULL
	,[OriginCityCountryCode] varchar(255) NOT NULL
	,[OriginCityCountryName] varchar(255) NOT NULL
	,[PortOfLoading_city_id] varchar(255) NOT NULL
	,[PortOfLoadingCityName] varchar(255) NOT NULL
	,[PortOfLoadingState] varchar(255) NOT NULL
	,[PortOfLoadingCountryCode] varchar(255) NOT NULL
	,[PortOfLoadingCountryName] varchar(255) NOT NULL
	,[PortOfDischarge_city_id] varchar(255) NOT NULL
	,[PortOfDischargeCityName] varchar(255) NOT NULL
	,[PortOfDischargeState] varchar(255) NOT NULL
	,[PortOfDischargeCountryCode] varchar(255) NOT NULL
	,[PortOfDischargeCountryName] varchar(255) NOT NULL
	,[BLDestination_city_id] varchar(255) NOT NULL
	,[BLDestinationCityName] varchar(255) NOT NULL
	,[BLDestinationState] varchar(255) NOT NULL
	,[BLDestinationCountryCode] varchar(255) NOT NULL
	,[BLDestinationCountryName] varchar(255) NOT NULL
	,[PickUpLocationLocationCode] varchar(255) NOT NULL
	,[PickUpLocationName] varchar(255) NOT NULL
	,[PickUpLocationPostalCode] varchar(255) NOT NULL
	,[PickUpLocation_city_id] varchar(255) NOT NULL
	,[PickUpLocationCityName] varchar(255) NOT NULL
	,[PickUpLocationState] varchar(255) NOT NULL
	,[PickUpLocationCountryCode] varchar(255) NOT NULL
	,[PickUpLocationCountryName] varchar(255) NOT NULL
	,[DropOffLocationLocationCode] varchar(255) NOT NULL
	,[DropOffLocationName] varchar(255) NOT NULL
	,[DropOffLocationPostalCode] varchar(255) NOT NULL
	,[DropOffLocation_city_id] varchar(255) NOT NULL
	,[DropOffLocationCityName] varchar(255) NOT NULL
	,[DropOffLocationState] varchar(255) NOT NULL
	,[DropOffLocationCountryCode] varchar(255) NOT NULL
	,[DropOffLocationCountryName] varchar(255) NOT NULL

	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTN_ASN_ImportASNHist] ON ttdStagingGeneric_GTN_ASN_ImportASNHist 
( 
	 [PartnerId]
	,[ASNMessageGUID]
	,[ASNGUID]
)
ALTER TABLE [dbo].[ttdStagingGeneric_GTN_ASN_ImportASNHist] ADD CONSTRAINT [PK_ttdStagingGeneric_GTN_ASN_ImportASNHist] PRIMARY KEY 
(
     [PartnerID] ASC
	,[EffDate] ASC
    ,[ASNMessageGUID] ASC
	,[ASNGUID] ASC
 )
END

---------------------------------------ttdStagingGeneric_GTN_ASN_Import_Trigger-------------------------------

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGeneric_GTN_ASN_Import_Trigger' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTN_ASN_Import_Trigger(
	[PartnerId] int NOT NULL
	,[EffDate] datetime NOT NULL
	,[ASNMessageGUID] varchar(50) NOT NULL
	,[ASNGUID] varchar(50) NOT NULL
	,[TriggerGUID] varchar(50) NOT NULL
	,[Trigger] varchar(255) NOT NULL
	
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTN_ASN_Import_Trigger] ON ttdStagingGeneric_GTN_ASN_Import_Trigger 
( 
	 [PartnerId]
	,[ASNMessageGUID]
	,[ASNGUID]
	,[TriggerGUID]
)
ALTER TABLE [dbo].[ttdStagingGeneric_GTN_ASN_Import_Trigger] ADD CONSTRAINT [PK_ttdStagingGeneric_GTN_ASN_Import_Trigger] PRIMARY KEY 
(
     [PartnerID] ASC
    ,[ASNMessageGUID] ASC
	,[ASNGUID] ASC
	,[TriggerGUID] ASC
 )
END

--------------------------------------------ttdStagingGeneric_GTN_ASN_Import_TriggerHist----------------------

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGeneric_GTN_ASN_Import_TriggerHist' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTN_ASN_Import_TriggerHist(
	[PartnerId] int NOT NULL
	,[EffDate] datetime NOT NULL
	,[ASNMessageGUID] varchar(50) NOT NULL
	,[ASNGUID] varchar(50) NOT NULL
	,[TriggerGUID] varchar(50) NOT NULL
	,[Trigger] varchar(255) NOT NULL
	
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTN_ASN_Import_TriggerHist] ON ttdStagingGeneric_GTN_ASN_Import_TriggerHist 
( 
	 [PartnerId]
	,[ASNMessageGUID]
	,[ASNGUID]
	,[TriggerGUID]
)
ALTER TABLE [dbo].[ttdStagingGeneric_GTN_ASN_Import_TriggerHist] ADD CONSTRAINT [PK_ttdStagingGeneric_GTN_ASN_Import_TriggerHist] PRIMARY KEY 
(
     [PartnerID] ASC
	,[EffDate] ASC
    ,[ASNMessageGUID] ASC
	,[ASNGUID] ASC
	,[TriggerGUID] ASC
 )
END

-----------------------------------------ttdStagingGeneric_GTN_ASN_Import_TriggerDetail--------------------------------

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGeneric_GTN_ASN_Import_TriggerDetail' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTN_ASN_Import_TriggerDetail(
	[PartnerId] int NOT NULL
	,[EffDate] datetime NOT NULL
	,[ASNMessageGUID] varchar(50) NOT NULL
	,[ASNGUID] varchar(50) NOT NULL
	,[TriggerDetailGUID] varchar(50) NOT NULL
	,[Type] varchar(255) NOT NULL
	,[Value] varchar(255) NOT NULL
	,[Status] varchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTN_ASN_Import_TriggerDetail] ON ttdStagingGeneric_GTN_ASN_Import_TriggerDetail 
( 
	 [PartnerId]
	,[ASNMessageGUID]
	,[ASNGUID]
	,[TriggerDetailGUID]
)
ALTER TABLE [dbo].[ttdStagingGeneric_GTN_ASN_Import_TriggerDetail] ADD CONSTRAINT [PK_ttdStagingGeneric_GTN_ASN_Import_TriggerDetail] PRIMARY KEY 
(
     [PartnerID] ASC
    ,[ASNMessageGUID] ASC
	,[ASNGUID] ASC
	,[TriggerDetailGUID] ASC
 )
END

--------------------------------------ttdStagingGeneric_GTN_ASN_Import_TriggerDetailHist-----------------------------

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGeneric_GTN_ASN_Import_TriggerDetailHist' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTN_ASN_Import_TriggerDetailHist(
	[PartnerId] int NOT NULL
	,[EffDate] datetime NOT NULL
	,[ASNMessageGUID] varchar(50) NOT NULL
	,[ASNGUID] varchar(50) NOT NULL
	,[TriggerDetailGUID] varchar(50) NOT NULL
	,[Type] varchar(255) NOT NULL
	,[Value] varchar(255) NOT NULL
	,[Status] varchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTN_ASN_Import_TriggerDetailHist] ON ttdStagingGeneric_GTN_ASN_Import_TriggerDetailHist 
( 
	 [PartnerId]
	,[ASNMessageGUID]
	,[ASNGUID]
	,[TriggerDetailGUID]
)
ALTER TABLE [dbo].[ttdStagingGeneric_GTN_ASN_Import_TriggerDetailHist] ADD CONSTRAINT [PK_ttdStagingGeneric_GTN_ASN_Import_TriggerDetailHist] PRIMARY KEY 
(
     [PartnerID] ASC
	,[EffDate] ASC
    ,[ASNMessageGUID] ASC
	,[ASNGUID] ASC
	,[TriggerDetailGUID] ASC
 )
END

-----------------------------------------------ttdStagingGeneric_GTN_ASN_Import_ProcessingInstructions--------------------------------------------

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGeneric_GTN_ASN_Import_ProcessingInstructions' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTN_ASN_Import_ProcessingInstructions(
	[PartnerId] int NOT NULL
	,[EffDate] datetime NOT NULL
	,[ASNMessageGUID] varchar(50) NOT NULL
	,[ASNGUID] varchar(50) NOT NULL
	,[ProcessingInstructionsSource] varchar(100) NOT NULL
	,[ProcessingInstructionsSourceGuid] varchar(50) NOT NULL
	,[ProcessingInstructionsGuid] varchar(50) NOT NULL
	,[ProcessingInstructions] varchar(255) NOT NULL
	
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	
)ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTN_ASN_Import_ProcessingInstructions] ON ttdStagingGeneric_GTN_ASN_Import_ProcessingInstructions 
( 
	 [PartnerId]
	,[ASNMessageGUID]
	,[ASNGUID]
	,[ProcessingInstructionsSourceGuid]
	,[ProcessingInstructionsGuid]
)
ALTER TABLE [dbo].[ttdStagingGeneric_GTN_ASN_Import_ProcessingInstructions] ADD CONSTRAINT [PK_ttdStagingGeneric_GTN_ASN_Import_ProcessingInstructions] PRIMARY KEY 
(
     [PartnerID] ASC
    ,[ASNMessageGUID] ASC
	,[ASNGUID] ASC
	,[ProcessingInstructionsSourceGuid] ASC
	,[ProcessingInstructionsGuid] ASC
 )
END

---------------------------------------------ttdStagingGeneric_GTN_ASN_Import_ProcessingInstructionsHist-----------------------------------

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGeneric_GTN_ASN_Import_ProcessingInstructionsHist' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTN_ASN_Import_ProcessingInstructionsHist(
	[PartnerId] int NOT NULL
	,[EffDate] datetime NOT NULL
	,[ASNMessageGUID] varchar(50) NOT NULL
	,[ASNGUID] varchar(50) NOT NULL
	,[ProcessingInstructionsSource] varchar(100) NOT NULL
	,[ProcessingInstructionsSourceGuid] varchar(50) NOT NULL
	,[ProcessingInstructionsGuid] varchar(50) NOT NULL
	,[ProcessingInstructions] varchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTN_ASN_Import_ProcessingInstructionsHist] ON ttdStagingGeneric_GTN_ASN_Import_ProcessingInstructionsHist ( 
	 [PartnerId]
	,[ASNMessageGUID]
	,[ASNGUID]
	,[ProcessingInstructionsSourceGuid]
	,[ProcessingInstructionsGuid])
ALTER TABLE [dbo].[ttdStagingGeneric_GTN_ASN_Import_ProcessingInstructionsHist] ADD CONSTRAINT [PK_ttdStagingGeneric_GTN_ASN_Import_ProcessingInstructionsHist] PRIMARY KEY 
(
     [PartnerID] ASC
	,[EffDate] ASC
    ,[ASNMessageGUID] ASC
	,[ASNGUID] ASC
	,[ProcessingInstructionsSourceGuid] ASC
	,[ProcessingInstructionsGuid] ASC
 )
END

--------------------------------------------ttdStagingGeneric_GTN_ASN_Import_AddressLine------------------------------

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGeneric_GTN_ASN_Import_AddressLine' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTN_ASN_Import_AddressLine(
	[PartnerId] int NOT NULL
	,[EffDate] datetime NOT NULL
	,[ASNMessageGUID] varchar(50) NOT NULL
	,[ASNGUID] varchar(50) NOT NULL
	
	,[AddressLineSource] varchar(100) NOT NULL
	,[AddressLineSourceGUID] varchar(50) NOT NULL
	,[AddressLineGUID] varchar(50) NOT NULL
	,[AddressLine] varchar(255) NOT NULL
	
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTN_ASN_Import_AddressLine] ON ttdStagingGeneric_GTN_ASN_Import_AddressLine ( 
	 [PartnerId]
	,[ASNMessageGUID]
	,[ASNGUID]
	,[AddressLineSourceGUID]
	,[AddressLineGUID])
ALTER TABLE [dbo].[ttdStagingGeneric_GTN_ASN_Import_AddressLine] ADD CONSTRAINT [PK_ttdStagingGeneric_GTN_ASN_Import_AddressLine] PRIMARY KEY 
(
     [PartnerID] ASC
    ,[ASNMessageGUID] ASC
	,[ASNGUID] ASC
	,[AddressLineSourceGUID] ASC
	,[AddressLineGUID] ASC
 )
END

--------------------------------------ttdStagingGeneric_GTN_ASN_Import_AddressLineHist---------------------------------

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGeneric_GTN_ASN_Import_AddressLineHist' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTN_ASN_Import_AddressLineHist(
	[PartnerId] int NOT NULL
	,[EffDate] datetime NOT NULL
	,[ASNMessageGUID] varchar(50) NOT NULL
	,[ASNGUID] varchar(50) NOT NULL
	,[AddressLineSource] varchar(100) NOT NULL
	,[AddressLineSourceGUID] varchar(50) NOT NULL
	,[AddressLineGUID] varchar(50) NOT NULL
	,[AddressLine] varchar(255) NOT NULL
	
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTN_ASN_Import_AddressLineHist] ON ttdStagingGeneric_GTN_ASN_Import_AddressLineHist 
( 
	 [PartnerId]
	,[ASNMessageGUID]
	,[ASNGUID]
	,[AddressLineSourceGUID]
	,[AddressLineGUID]
)
ALTER TABLE [dbo].[ttdStagingGeneric_GTN_ASN_Import_AddressLineHist] ADD CONSTRAINT [PK_ttdStagingGeneric_GTN_ASN_Import_AddressLineHist] PRIMARY KEY 
(
     [PartnerID] ASC
	,[EffDate] ASC
    ,[ASNMessageGUID] ASC
	,[ASNGUID] ASC
	,[AddressLineSourceGUID] ASC
	,[AddressLineGUID] ASC
 )
END

------------------------------------------------ttdStagingGeneric_GTN_ASN_Import_CityCode-----------------------------

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGeneric_GTN_ASN_Import_CityCode' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTN_ASN_Import_CityCode(
	[PartnerId] int NOT NULL
	,[EffDate] datetime NOT NULL
	,[ASNMessageGUID] varchar(50) NOT NULL
	,[ASNGUID] varchar(50) NOT NULL
	,[CityCodeSource] varchar(100) NOT NULL
	,[CityCodeSourceGUID] varchar(50) NOT NULL
	,[CityCodeGUID] varchar(50) NOT NULL
	,[CityCode] varchar(255) NOT NULL
	,[Qualifier] varchar(255) NOT NULL
	
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTN_ASN_Import_CityCode] ON ttdStagingGeneric_GTN_ASN_Import_CityCode 
( 
	 [PartnerId]
	,[ASNMessageGUID]
	,[ASNGUID]
	,[CityCodeSourceGUID]
	,[CityCodeGUID]
)
ALTER TABLE [dbo].[ttdStagingGeneric_GTN_ASN_Import_CityCode] ADD CONSTRAINT [PK_ttdStagingGeneric_GTN_ASN_Import_CityCode] PRIMARY KEY 
(
     [PartnerID] ASC
    ,[ASNMessageGUID] ASC
	,[ASNGUID] ASC
	,[CityCodeSourceGUID] ASC
	,[CityCodeGUID] ASC
 )
END

----------------------------------------------ttdStagingGeneric_GTN_ASN_Import_CityCodeHist------------------------

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGeneric_GTN_ASN_Import_CityCodeHist' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTN_ASN_Import_CityCodeHist(
	[PartnerId] int NOT NULL
	,[EffDate] datetime NOT NULL
	,[ASNMessageGUID] varchar(50) NOT NULL
	,[ASNGUID] varchar(50) NOT NULL
	,[CityCodeSource] varchar(100) NOT NULL
	,[CityCodeSourceGUID] varchar(50) NOT NULL
	,[CityCodeGUID] varchar(50) NOT NULL
	,[CityCode] varchar(255) NOT NULL
	,[Qualifier] varchar(255) NOT NULL
	
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTN_ASN_Import_CityCode] ON ttdStagingGeneric_GTN_ASN_Import_CityCodeHist 
( 
	 [PartnerId]
	,[ASNMessageGUID]
	,[ASNGUID]
	,[CityCodeSourceGUID]
	,[CityCodeGUID]
)
ALTER TABLE [dbo].[ttdStagingGeneric_GTN_ASN_Import_CityCodeHist] ADD CONSTRAINT [PK_ttdStagingGeneric_GTN_ASN_Import_CityCodeHist] PRIMARY KEY 
(
     [PartnerID] ASC
	,[EffDate] ASC
    ,[ASNMessageGUID] ASC
	,[ASNGUID] ASC
	,[CityCodeSourceGUID] ASC
	,[CityCodeGUID] ASC
 )
END

----------------------------------------------ttdStagingGeneric_GTN_ASN_Import_Charges--------------------------------

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGeneric_GTN_ASN_Import_Charges' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTN_ASN_Import_Charges(
	[PartnerId] int NOT NULL
	,[EffDate] datetime NOT NULL
	,[ASNMessageGUID] varchar(50) NOT NULL
	,[ASNGUID] varchar(50) NOT NULL
	,[ChargesSource] varchar(100) NOT NULL
	,[ChargesSourceGuid] varchar(50) NOT NULL
	,[ChargesGUID] varchar(50) NOT NULL
	,[Charges] varchar(255) NOT NULL
	,[Type] varchar(255) NOT NULL
	,[Currency] varchar(255) NOT NULL
	,[Purpose] varchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTN_ASN_Import_Charges] ON ttdStagingGeneric_GTN_ASN_Import_Charges 
(
 
	 [PartnerId]
	,[ASNMessageGUID]
	,[ASNGUID]
	,[ChargesSourceGuid]
	,[ChargesGUID]
)
ALTER TABLE [dbo].[ttdStagingGeneric_GTN_ASN_Import_Charges] ADD CONSTRAINT [PK_ttdStagingGeneric_GTN_ASN_Import_Charges] PRIMARY KEY 
(
     [PartnerID] ASC
    ,[ASNMessageGUID] ASC
	,[ASNGUID] ASC
	,[ChargesSourceGuid] ASC
	,[ChargesGUID] ASC
 )
END

------------------------------------ttdStagingGeneric_GTN_ASN_Import_ChargesHist-----------------------------------

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGeneric_GTN_ASN_Import_ChargesHist' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTN_ASN_Import_ChargesHist(
	[PartnerId] int NOT NULL
	,[EffDate] datetime NOT NULL
	,[ASNMessageGUID] varchar(50) NOT NULL
	,[ASNGUID] varchar(50) NOT NULL
	,[ChargesSource] varchar(100) NOT NULL
	,[ChargesSourceGuid] varchar(50) NOT NULL
	,[ChargesGUID] varchar(50) NOT NULL
	,[Charges] varchar(255) NOT NULL
	,[Type] varchar(255) NOT NULL
	,[Currency] varchar(255) NOT NULL
	,[Purpose] varchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTN_ASN_Import_ChargesHist] ON ttdStagingGeneric_GTN_ASN_Import_ChargesHist 
( 
	 [PartnerId]
	,[ASNMessageGUID]
	,[ASNGUID]
	,[ChargesSourceGuid]
	,[ChargesGUID]
)
ALTER TABLE [dbo].[ttdStagingGeneric_GTN_ASN_Import_ChargesHist] ADD CONSTRAINT [PK_ttdStagingGeneric_GTN_ASN_Import_ChargesHist] PRIMARY KEY 
(
     [PartnerID] ASC
	,[EffDate] ASC
    ,[ASNMessageGUID] ASC
	,[ASNGUID] ASC
	,[ChargesSourceGuid] ASC
	,[ChargesGUID] ASC
 )
END

------------------------------------ttdStagingGeneric_GTN_ASN_Import_PartyInfo----------------------------

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGeneric_GTN_ASN_Import_PartyInfo' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTN_ASN_Import_PartyInfo(
	[PartnerId] int NOT NULL
	,[EffDate] datetime NOT NULL
	,[ASNMessageGUID] varchar(50) NOT NULL
	,[ASNGUID] varchar(50) NOT NULL
	,[PartyInfoSourceGUID] varchar(50) NOT NULL
	
	,[PartyInfoGUID] varchar(50) NOT NULL
	,[Type] varchar(255) NOT NULL
	,[Code] varchar(255) NOT NULL
	,[Name] varchar(255) NOT NULL
	,[PostalCode] varchar(255) NOT NULL
	,[Email] varchar(255) NOT NULL
	,[city_id] varchar(255) NOT NULL
	,[CityName] varchar(255) NOT NULL
	
	,[State] varchar(255) NOT NULL
	,[CountryCode] varchar(255) NOT NULL
	,[CountryName] varchar(255) NOT NULL
	
	,[source] varchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTN_ASN_Import_PartyInfo] ON ttdStagingGeneric_GTN_ASN_Import_PartyInfo 
( 
	 [PartnerId]
	,[ASNMessageGUID]
	,[ASNGUID]
	,[PartyInfoSourceGUID]
	,[PartyInfoGUID]
)
ALTER TABLE [dbo].[ttdStagingGeneric_GTN_ASN_Import_PartyInfo] ADD CONSTRAINT [PK_ttdStagingGeneric_GTN_ASN_Import_PartyInfo] PRIMARY KEY 
(
     [PartnerID] ASC
    ,[ASNMessageGUID] ASC
	,[ASNGUID] ASC
	,[PartyInfoSourceGUID] ASC
	,[PartyInfoGUID] ASC
 )
END

-------------------------------------------ttdStagingGeneric_GTN_ASN_Import_PartyInfoHist------------------------------------

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGeneric_GTN_ASN_Import_PartyInfoHist' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTN_ASN_Import_PartyInfoHist(
	[PartnerId] int NOT NULL
	,[EffDate] datetime NOT NULL
	,[ASNMessageGUID] varchar(50) NOT NULL
	,[ASNGUID] varchar(50) NOT NULL
	,[PartyInfoSourceGUID] varchar(50) NOT NULL
	
	,[PartyInfoGUID] varchar(50) NOT NULL
	,[Type] varchar(255) NOT NULL
	,[Code] varchar(255) NOT NULL
	,[Name] varchar(255) NOT NULL
	,[PostalCode] varchar(255) NOT NULL
	,[Email] varchar(255) NOT NULL
	,[city_id] varchar(255) NOT NULL
	,[CityName] varchar(255) NOT NULL
	
	,[State] varchar(255) NOT NULL
	,[CountryCode] varchar(255) NOT NULL
	,[CountryName] varchar(255) NOT NULL
	
	,[source] varchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTN_ASN_Import_PartyInfo] ON ttdStagingGeneric_GTN_ASN_Import_PartyInfoHist 
( 
	 [PartnerId]
	,[ASNMessageGUID]
	,[ASNGUID]
	,[PartyInfoSourceGUID]
	,[PartyInfoGUID]
)
ALTER TABLE [dbo].[ttdStagingGeneric_GTN_ASN_Import_PartyInfoHist] ADD CONSTRAINT [PK_ttdStagingGeneric_GTN_ASN_Import_PartyInfoHist] PRIMARY KEY 
(
     [PartnerID] ASC
	,[EffDate] ASC
    ,[ASNMessageGUID] ASC
	,[ASNGUID] ASC
	,[PartyInfoSourceGUID] ASC
	,[PartyInfoGUID] ASC
 )
END

-----------------------------------------ttdStagingGeneric_GTN_ASN_Import_References---------------------------

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGeneric_GTN_ASN_Import_References' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTN_ASN_Import_References(
	[PartnerId] int NOT NULL
	,[EffDate] datetime NOT NULL
	,[ASNMessageGUID] varchar(50) NOT NULL
	,[ASNGUID] varchar(50) NOT NULL
	,[ReferencesSource] varchar(100) NOT NULL
	,[ReferencesSourceGUID] varchar(50) NOT NULL
	,[ReferencesGUID] varchar(50) NOT NULL
	,[Type] varchar(255) NOT NULL
	,[Value] varchar(255) NOT NULL
	
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTN_ASN_Import_References] ON ttdStagingGeneric_GTN_ASN_Import_References 
( 
	 [PartnerId]
	,[ASNMessageGUID]
	,[ASNGUID]
	,[ReferencesSourceGUID]
	,[ReferencesGUID]
)
ALTER TABLE [dbo].[ttdStagingGeneric_GTN_ASN_Import_References] ADD CONSTRAINT [PK_ttdStagingGeneric_GTN_ASN_Import_References] PRIMARY KEY 
(
     [PartnerID] ASC
    ,[ASNMessageGUID] ASC
	,[ASNGUID] ASC
	,[ReferencesSourceGUID] ASC
	,[ReferencesGUID] ASC
 )
END


---------------------------------------------ttdStagingGeneric_GTN_ASN_Import_ReferencesHist-------------------------------

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGeneric_GTN_ASN_Import_ReferencesHist' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTN_ASN_Import_ReferencesHist(
	[PartnerId] int NOT NULL
	,[EffDate] datetime NOT NULL
	,[ASNMessageGUID] varchar(50) NOT NULL
	,[ASNGUID] varchar(50) NOT NULL
	,[ReferencesRource] varchar(100) NOT NULL
	,[ReferencesSourceGUID]varchar(50) NOT NULL
	,[ReferencesGUID] varchar(50) NOT NULL
	,[Type] varchar(255) NOT NULL
	,[Value] varchar(255) NOT NULL
	
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTN_ASN_Import_ReferencesHist] ON ttdStagingGeneric_GTN_ASN_Import_ReferencesHist 
( 
	 [PartnerId]
	,[ASNMessageGUID]
	,[ASNGUID]
	,[ReferencesSourceGUID]
	,[ReferencesGUID]
)
ALTER TABLE [dbo].[ttdStagingGeneric_GTN_ASN_Import_ReferencesHist] ADD CONSTRAINT [PK_ttdStagingGeneric_GTN_ASN_Import_ReferencesHist] PRIMARY KEY 
(
     [PartnerID] ASC
	,[EffDate] ASC
    ,[ASNMessageGUID] ASC
	,[ASNGUID] ASC
	,[ReferencesSourceGUID] ASC
	,[ReferencesGUID] ASC
 )
END

---------------------------------------------------ttdStagingGeneric_GTN_ASN_Import_ReferenceDates--------------------------------------

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGeneric_GTN_ASN_Import_ReferenceDates' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTN_ASN_Import_ReferenceDates(
	[PartnerId] int NOT NULL
	,[EffDate] datetime NOT NULL
	,[ASNMessageGUID] varchar(50) NOT NULL
	,[ASNGUID] varchar(50) NOT NULL
	,[ReferenceDatesSourceGUID] varchar(50) NOT NULL
	,[ReferenceDatesGUID] varchar(50) NOT NULL
	
	,[ReferenceDatesSource] varchar(100) NOT NULL
	,[ReferenceDateType] varchar(255) NOT NULL
	,[ReferenceDate] varchar(255) NOT NULL
	,[ReferenceDateTimeZone] varchar(255) NOT NULL
	,[ReferenceDateReportedLocalTimeZone] varchar(255) NOT NULL
	
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTN_ASN_Import_ReferenceDates] ON ttdStagingGeneric_GTN_ASN_Import_ReferenceDates 
( 
	 [PartnerId]
	,[ASNMessageGUID]
	,[ASNGUID]
	,[ReferenceDatesSourceGUID]
	,[ReferenceDatesGUID]
)
ALTER TABLE [dbo].[ttdStagingGeneric_GTN_ASN_Import_ReferenceDates] ADD CONSTRAINT [PK_ttdStagingGeneric_GTN_ASN_Import_ReferenceDates] PRIMARY KEY 
(
     [PartnerID] ASC
    ,[ASNMessageGUID] ASC
	,[ASNGUID] ASC
	,[ReferenceDatesSourceGUID] ASC
	,[ReferenceDatesGUID] ASC
 )
END

-----------------------------------------------------ttdStagingGeneric_GTN_ASN_Import_ReferenceDatesHist-----------------------------------------

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGeneric_GTN_ASN_Import_ReferenceDatesHist' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTN_ASN_Import_ReferenceDatesHist(
	[PartnerId] int NOT NULL
	,[EffDate] datetime NOT NULL
	,[ASNMessageGUID] varchar(50) NOT NULL
	,[ASNGUID] varchar(50) NOT NULL
	,[ReferenceDatesSourceGUID] varchar(50) NOT NULL
	,[ReferenceDatesGUID] varchar(50) NOT NULL
	
	,[ReferenceDatesSource] varchar(100) NOT NULL
	,[ReferenceDateType] varchar(255) NOT NULL
	,[ReferenceDate] varchar(255) NOT NULL
	,[ReferenceDateTimeZone] varchar(255) NOT NULL
	,[ReferenceDateReportedLocalTimeZone] varchar(255) NOT NULL
	
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTN_ASN_Import_ReferenceDatesHist] ON ttdStagingGeneric_GTN_ASN_Import_ReferenceDatesHist 
( 
	 [PartnerId]
	,[ASNMessageGUID]
	,[ASNGUID]
	,[ReferenceDatesSourceGUID]
	,[ReferenceDatesGUID]
)
ALTER TABLE [dbo].[ttdStagingGeneric_GTN_ASN_Import_ReferenceDatesHist] ADD CONSTRAINT [PK_ttdStagingGeneric_GTN_ASN_Import_ReferenceDatesHist] PRIMARY KEY 
(
     [PartnerID] ASC
	,[EffDate] ASC
    ,[ASNMessageGUID] ASC
	,[ASNGUID] ASC
	,[ReferenceDatesSourceGUID] ASC
	,[ReferenceDatesGUID] ASC
 )
END

---------------------------------------ttdStagingGeneric_GTN_ASN_Import_Container----------------------------------------------

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGeneric_GTN_ASN_Import_Container' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTN_ASN_Import_Container(
	[PartnerId] int NOT NULL
	,[EffDate] datetime NOT NULL
	,[ASNMessageGUID] varchar(50) NOT NULL
	,[ASNGUID] varchar(50) NOT NULL
	,[ContainerGUID] varchar(50) NOT NULL
	
	
	,[LoadPlanName] varchar(255) NOT NULL
	,[ContainerNumber] varchar(255) NOT NULL
	,[ContainerType] varchar(255) NOT NULL
	,[ContainerTypeName] varchar(255) NOT NULL
	,[ContainerLoad] varchar(255) NOT NULL
	,[LoadLocation] varchar(255) NOT NULL
	,[LoadType] varchar(255) NOT NULL
	,[SealNumber] varchar(255) NOT NULL
	--,[Charges] varchar(255) NOT NULL
	,[ServiceType] varchar(255) NOT NULL
	,[ContractNumber] varchar(255) NOT NULL
	,[ReferenceNumber1] varchar(255) NOT NULL
	,[ReferenceNumber2] varchar(255) NOT NULL
	,[ReferenceNumber3] varchar(255) NOT NULL
	,[ChargeableWeight] varchar(255) NOT NULL
	,[ChargeableWeightUnit] varchar(255) NOT NULL
	,[ChargeableWeightANSICode] varchar(255) NOT NULL
	,[DimensionalWeight] varchar(255) NOT NULL
	,[DimensionalWeightUnit] varchar(255) NOT NULL
	,[DimensionalWeightANSICode] varchar(255) NOT NULL
	,[ActualWeight] varchar(255) NOT NULL
	,[ActualWeightUnit] varchar(255) NOT NULL
	,[ActualWeightANSICode] varchar(255) NOT NULL
	,[Volume] varchar(255) NOT NULL
	,[VolumeUnit] varchar(255) NOT NULL
	,[VolumeANSICode] varchar(255) NOT NULL
	,[LadingQuantity] varchar(255) NOT NULL
	,[LadingQuantityUnit] varchar(255) NOT NULL
	,[LadingQuantityANSICode] varchar(255) NOT NULL
	,[Comments] varchar(255) NOT NULL
	,[PackUnitTxnKey] varchar(255) NOT NULL
	,[ShipperRefNum] varchar(255) NOT NULL
	,[ForwarderRefNum] varchar(255) NOT NULL
	,[ConsigneeRefNum] varchar(255) NOT NULL
	,[VesselCode] varchar(255) NOT NULL
	,[Vessel2] varchar(255) NOT NULL
	,[VesselCode2] varchar(255) NOT NULL
	,[Voyage2] varchar(255) NOT NULL
	,[VesselCountry] varchar(255) NOT NULL
	,[VesselCountryCode] varchar(255) NOT NULL
	,[Vessel2Country] varchar(255) NOT NULL
	,[Vessel2CountryCode] varchar(255) NOT NULL

	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTN_ASN_Import_Container] ON ttdStagingGeneric_GTN_ASN_Import_Container 
( 
	 [PartnerId]
	,[ASNMessageGUID]
	,[ASNGUID]
	,[ContainerGUID]
)
ALTER TABLE [dbo].[ttdStagingGeneric_GTN_ASN_Import_Container] ADD CONSTRAINT [PK_ttdStagingGeneric_GTN_ASN_Import_Container] PRIMARY KEY 
(
     [PartnerID] ASC
    ,[ASNMessageGUID] ASC
	,[ASNGUID] ASC
	,[ContainerGUID] ASC
 )
END

--------------------------------------ttdStagingGeneric_GTN_ASN_Import_ContainerHist----------------------------------

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGeneric_GTN_ASN_Import_ContainerHist' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTN_ASN_Import_ContainerHist(
	[PartnerId] int NOT NULL
	,[EffDate] datetime NOT NULL
	,[ASNMessageGUID] varchar(50) NOT NULL
	,[ASNGUID] varchar(50) NOT NULL
	,[ContainerGUID] varchar(50) NOT NULL
	
	,[LoadPlanName] varchar(255) NOT NULL
	,[ContainerNumber] varchar(255) NOT NULL
	,[ContainerType] varchar(255) NOT NULL
	,[ContainerTypeName] varchar(255) NOT NULL
	,[ContainerLoad] varchar(255) NOT NULL
	,[LoadLocation] varchar(255) NOT NULL
	,[LoadType] varchar(255) NOT NULL
	,[SealNumber] varchar(255) NOT NULL
	--,[Charges] varchar(255) NOT NULL
	,[ServiceType] varchar(255) NOT NULL
	,[ContractNumber] varchar(255) NOT NULL
	,[ReferenceNumber1] varchar(255) NOT NULL
	,[ReferenceNumber2] varchar(255) NOT NULL
	,[ReferenceNumber3] varchar(255) NOT NULL
	,[ChargeableWeight] varchar(255) NOT NULL
	,[ChargeableWeightUnit] varchar(255) NOT NULL
	,[ChargeableWeightANSICode] varchar(255) NOT NULL
	,[DimensionalWeight] varchar(255) NOT NULL
	,[DimensionalWeightUnit] varchar(255) NOT NULL
	,[DimensionalWeightANSICode] varchar(255) NOT NULL
	,[ActualWeight] varchar(255) NOT NULL
	,[ActualWeightUnit] varchar(255) NOT NULL
	,[ActualWeightANSICode] varchar(255) NOT NULL
	,[Volume] varchar(255) NOT NULL
	,[VolumeUnit] varchar(255) NOT NULL
	,[VolumeANSICode] varchar(255) NOT NULL
	,[LadingQuantity] varchar(255) NOT NULL
	,[LadingQuantityUnit] varchar(255) NOT NULL
	,[LadingQuantityANSICode] varchar(255) NOT NULL
	,[Comments] varchar(255) NOT NULL
	,[PackUnitTxnKey] varchar(255) NOT NULL
	,[ShipperRefNum] varchar(255) NOT NULL
	,[ForwarderRefNum] varchar(255) NOT NULL
	,[ConsigneeRefNum] varchar(255) NOT NULL
	,[VesselCode] varchar(255) NOT NULL
	,[Vessel2] varchar(255) NOT NULL
	,[VesselCode2] varchar(255) NOT NULL
	,[Voyage2] varchar(255) NOT NULL
	,[VesselCountry] varchar(255) NOT NULL
	,[VesselCountryCode] varchar(255) NOT NULL
	,[Vessel2Country] varchar(255) NOT NULL
	,[Vessel2CountryCode] varchar(255) NOT NULL

	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTN_ASN_Import_ContainerHist] ON ttdStagingGeneric_GTN_ASN_Import_ContainerHist 
( 
	 [PartnerId]
	,[ASNMessageGUID]
	,[ASNGUID]
	,[ContainerGUID]
)
ALTER TABLE [dbo].[ttdStagingGeneric_GTN_ASN_Import_ContainerHist] ADD CONSTRAINT [PK_ttdStagingGeneric_GTN_ASN_Import_ContainerHist] PRIMARY KEY 
(
     [PartnerID] ASC
	,[EffDate] ASC
    ,[ASNMessageGUID] ASC
	,[ASNGUID] ASC
	,[ContainerGUID] ASC
 )
END

-------------------------------------------------ttdStagingGeneric_GTN_ASN_Import_ReasonCode-----------------------------------

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGeneric_GTN_ASN_Import_ReasonCode' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTN_ASN_Import_ReasonCode(
	[PartnerId] int NOT NULL
	,[EffDate] datetime NOT NULL
	,[ASNMessageGUID] varchar(50) NOT NULL
	,[ASNGUID] varchar(50) NOT NULL
	,[ReasonCodeSourceGUID] varchar(50) NOT NULL
	,[ReasonCodeGUID] varchar(50) NOT NULL
	,[ReasonCodeSource] varchar(100) NOT NULL
	,[Type] varchar(255) NOT NULL
	,[Code] varchar(255) NOT NULL
	,[Description] varchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTN_ASN_Import_ReasonCode] ON ttdStagingGeneric_GTN_ASN_Import_ReasonCode 
( 
	 [PartnerId]
	,[ASNMessageGUID]
	,[ASNGUID]
	,[ReasonCodeSourceGUID]
	,[ReasonCodeGUID]
)
ALTER TABLE [dbo].[ttdStagingGeneric_GTN_ASN_Import_ReasonCode] ADD CONSTRAINT [PK_ttdStagingGeneric_GTN_ASN_Import_ReasonCode] PRIMARY KEY 
(
     [PartnerID] ASC
    ,[ASNMessageGUID] ASC
	,[ASNGUID] ASC
	,[ReasonCodeSourceGUID] ASC
	,[ReasonCodeGUID] ASC
 )
END

----------------------------------------------ttdStagingGeneric_GTN_ASN_Import_ReasonCodeHist-----------------------------------

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGeneric_GTN_ASN_Import_ReasonCodeHist' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTN_ASN_Import_ReasonCodeHist(
	[PartnerId] int NOT NULL
	,[EffDate] datetime NOT NULL
	,[ASNMessageGUID] varchar(50) NOT NULL
	,[ASNGUID] varchar(50) NOT NULL
	,[ReasonCodeSourceGUID] varchar(50) NOT NULL
	,[ReasonCodeGUID] varchar(50) NOT NULL
	,[ReasonCodeSource] varchar(100) NOT NULL
	,[Type] varchar(255) NOT NULL
	,[Code] varchar(255) NOT NULL
	,[Description] varchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTN_ASN_Import_ReasonCodeHist] ON ttdStagingGeneric_GTN_ASN_Import_ReasonCodeHist 
( 
	 [PartnerId]
	,[ASNMessageGUID]
	,[ASNGUID]
	,[ReasonCodeSourceGUID]
	,[ReasonCodeGUID]
)
ALTER TABLE [dbo].[ttdStagingGeneric_GTN_ASN_Import_ReasonCodeHist] ADD CONSTRAINT [PK_ttdStagingGeneric_GTN_ASN_Import_ReasonCodeHist] PRIMARY KEY 
(
     [PartnerID] ASC
	,[EffDate] ASC
    ,[ASNMessageGUID] ASC
	,[ASNGUID] ASC
	,[ReasonCodeSourceGUID] ASC
	,[ReasonCodeGUID] ASC
 )
END

---------------------------------------ttdStagingGeneric_GTN_ASN_Import_ContainerLineItems-----------------------------

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGeneric_GTN_ASN_Import_ContainerLineItems' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTN_ASN_Import_ContainerLineItems(
	 [PartnerId] int NOT NULL
	,[EffDate] datetime NOT NULL
	,[ASNMessageGUID] varchar(50) NOT NULL
	,[ASNGUID] varchar(50) NOT NULL
	,[ContainerGUID] varchar(50) NOT NULL
	,[LineItemsGUID] varchar(50) NOT NULL
	
	,[LoadSequence] varchar(255) NOT NULL
	,[PONumber] varchar(255) NOT NULL
	,[OrderClassCode] varchar(255) NOT NULL
	,[OrderClassName] varchar(255) NOT NULL
	,[LineItemNumber] varchar(255) NOT NULL
	,[Quantity] varchar(255) NOT NULL
	,[QuantityUnit] varchar(255) NOT NULL
	,[QuantityANSICode] varchar(255) NOT NULL
	,[ProductCode] varchar(255) NOT NULL
	,[ProductName] varchar(255) NOT NULL
	,[DivisionIdentifier] varchar(255) NOT NULL
	,[ShipWindowStartDate] datetime NOT NULL
	,[ShipWindowEndDate] datetime NOT NULL
	,[ShipWindowCancelDate] datetime NOT NULL
	,[RequiredDeliveryDate] datetime NOT NULL
	,[RequiredDeliveryDateTimeZone] varchar(255) NOT NULL
	,[RequiredDeliveryDateReportedLocalTimeZone] varchar(255) NOT NULL
	,[BLNumber] varchar(255) NOT NULL
	,[MasterBLNumber] varchar(255) NOT NULL
	,[ProNumber] varchar(255) NOT NULL
	,[BookingNumber] varchar(255) NOT NULL
	,[InvoiceNumber] varchar(255) NOT NULL
	,[ManufacturerID] varchar(255) NOT NULL
	,[ChargeableWeight] varchar(255) NOT NULL
	,[ChargeableWeightUnit] varchar(255) NOT NULL
	,[ChargeableWeightANSICode] varchar(255) NOT NULL
	,[Weight] varchar(255) NOT NULL
	,[WeightUnit] varchar(255) NOT NULL
	,[WeightANSICode] varchar(255) NOT NULL
	,[Volume] varchar(255) NOT NULL
	,[VolumeUnit] varchar(255) NOT NULL
	,[VolumeANSICode] varchar(255) NOT NULL
	,[InnerPackQuantity] varchar(255) NOT NULL
	,[InnerPackQuantityUnit] varchar(255) NOT NULL
	,[InnerPackQuantityANSICode] varchar(255) NOT NULL
	,[MasterPackQuantity] varchar(255) NOT NULL
	,[MasterPackQuantityUnit] varchar(255) NOT NULL
	,[MasterPackQuantityANSICode] varchar(255) NOT NULL
	,[CartonRange] varchar(255) NOT NULL
	,[PackageCount] varchar(255) NOT NULL
	,[OriginCity_id] varchar(255) NOT NULL
	,[OriginCityName] varchar(255) NOT NULL
	,[OriginState] varchar(255) NOT NULL
	,[OriginCountryCode] varchar(255) NOT NULL
	,[OriginCountryName] varchar(255) NOT NULL
	,[PoLineOriginCity_id] varchar(255) NOT NULL
	,[PoLineOriginCityCityName] varchar(255) NOT NULL
	,[PoLineOriginCityState] varchar(255) NOT NULL
	,[PoLineOriginCityCountryCode] varchar(255) NOT NULL
	,[PoLineOriginCityCountryName] varchar(255) NOT NULL
	,[BLDestinationCity_id] varchar(255) NOT NULL
	,[BLDestinationCityName] varchar(255) NOT NULL
	,[BLDestinationState] varchar(255) NOT NULL
	,[BLDestinationCountryCode] varchar(255) NOT NULL
	,[BLDestinationCountryName] varchar(255) NOT NULL
	,[OriginLocationLocationCode] varchar(255) NOT NULL
	,[OriginLocationName] varchar(255) NOT NULL
	,[OriginLocationPostalCode] varchar(255) NOT NULL
	,[OriginLocationCity_id] varchar(255) NOT NULL
	,[OriginLocationCityName] varchar(255) NOT NULL
	,[OriginLocationCityState] varchar(255) NOT NULL
	,[OriginLocationCountryCode] varchar(255) NOT NULL
	,[OriginLocationCountryName] varchar(255) NOT NULL
	,[FinalDestinationLocationCode] varchar(255) NOT NULL
	,[FinalDestinationName] varchar(255) NOT NULL
	,[FinalDestinationPostalCode] varchar(255) NOT NULL
	,[FinalDestinationCity_id] varchar(255) NOT NULL
	,[FinalDestinationCityName] varchar(255) NOT NULL
	,[FinalDestinationState] varchar(255) NOT NULL
	,[FinalDestinationCountryCode] varchar(255) NOT NULL
	,[FinalDestinationCountryName] varchar(255) NOT NULL
	,[ReferenceNumber1] varchar(255) NOT NULL
	,[ReferenceNumber2] varchar(255) NOT NULL
	,[ReferenceNumber3] varchar(255) NOT NULL
	,[ReferenceNumber4] varchar(255) NOT NULL
	,[ReferenceNumber5] varchar(255) NOT NULL
	,[ReferenceNumber6] varchar(255) NOT NULL

		
	
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTN_ASN_Import_ContainerLineItems] ON ttdStagingGeneric_GTN_ASN_Import_ContainerLineItems 
( 
	 [PartnerId]
	,[ASNMessageGUID]
	,[ASNGUID]
	,[ContainerGUID]
	,[LineItemsGUID]
)
ALTER TABLE [dbo].[ttdStagingGeneric_GTN_ASN_Import_ContainerLineItems] ADD CONSTRAINT [PK_ttdStagingGeneric_GTN_ASN_Import_ContainerLineItems] PRIMARY KEY 
(
     [PartnerID] ASC
    ,[ASNMessageGUID] ASC
	,[ASNGUID] ASC
	,[ContainerGUID] ASC
	,[LineItemsGUID] ASC
 )
END

------------------------------------------ttdStagingGeneric_GTN_ASN_Import_ContainerLineItemsHist------------------------------

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGeneric_GTN_ASN_Import_ContainerLineItemsHist' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTN_ASN_Import_ContainerLineItemsHist(
	 [PartnerId] int NOT NULL
	,[EffDate] datetime NOT NULL
	,[ASNMessageGUID] varchar(50) NOT NULL
	,[ASNGUID] varchar(50) NOT NULL
	,[ContainerGUID] varchar(50) NOT NULL
	,[LineItemsGUID] varchar(50) NOT NULL
	
	,[LoadSequence] varchar(255) NOT NULL
	,[PONumber] varchar(255) NOT NULL
	,[OrderClassCode] varchar(255) NOT NULL
	,[OrderClassName] varchar(255) NOT NULL
	,[LineItemNumber] varchar(255) NOT NULL
	,[Quantity] varchar(255) NOT NULL
	,[QuantityUnit] varchar(255) NOT NULL
	,[QuantityANSICode] varchar(255) NOT NULL
	,[ProductCode] varchar(255) NOT NULL
	,[ProductName] varchar(255) NOT NULL
	,[DivisionIdentifier] varchar(255) NOT NULL
	,[ShipWindowStartDate] datetime NOT NULL
	,[ShipWindowEndDate] datetime NOT NULL
	,[ShipWindowCancelDate] datetime NOT NULL
	,[RequiredDeliveryDate] datetime NOT NULL
	,[RequiredDeliveryDateTimeZone] varchar(255) NOT NULL
	,[RequiredDeliveryDateReportedLocalTimeZone] varchar(255) NOT NULL
	,[BLNumber] varchar(255) NOT NULL
	,[MasterBLNumber] varchar(255) NOT NULL
	,[ProNumber] varchar(255) NOT NULL
	,[BookingNumber] varchar(255) NOT NULL
	,[InvoiceNumber] varchar(255) NOT NULL
	,[ManufacturerID] varchar(255) NOT NULL
	,[ChargeableWeight] varchar(255) NOT NULL
	,[ChargeableWeightUnit] varchar(255) NOT NULL
	,[ChargeableWeightANSICode] varchar(255) NOT NULL
	,[Weight] varchar(255) NOT NULL
	,[WeightUnit] varchar(255) NOT NULL
	,[WeightANSICode] varchar(255) NOT NULL
	,[Volume] varchar(255) NOT NULL
	,[VolumeUnit] varchar(255) NOT NULL
	,[VolumeANSICode] varchar(255) NOT NULL
	,[InnerPackQuantity] varchar(255) NOT NULL
	,[InnerPackQuantityUnit] varchar(255) NOT NULL
	,[InnerPackQuantityANSICode] varchar(255) NOT NULL
	,[MasterPackQuantity] varchar(255) NOT NULL
	,[MasterPackQuantityUnit] varchar(255) NOT NULL
	,[MasterPackQuantityANSICode] varchar(255) NOT NULL
	,[CartonRange] varchar(255) NOT NULL
	,[PackageCount] varchar(255) NOT NULL
	,[OriginCity_id] varchar(255) NOT NULL
	,[OriginCityName] varchar(255) NOT NULL
	,[OriginState] varchar(255) NOT NULL
	,[OriginCountryCode] varchar(255) NOT NULL
	,[OriginCountryName] varchar(255) NOT NULL
	,[PoLineOriginCity_id] varchar(255) NOT NULL
	,[PoLineOriginCityCityName] varchar(255) NOT NULL
	,[PoLineOriginCityState] varchar(255) NOT NULL
	,[PoLineOriginCityCountryCode] varchar(255) NOT NULL
	,[PoLineOriginCityCountryName] varchar(255) NOT NULL
	,[BLDestinationCity_id] varchar(255) NOT NULL
	,[BLDestinationCityName] varchar(255) NOT NULL
	,[BLDestinationState] varchar(255) NOT NULL
	,[BLDestinationCountryCode] varchar(255) NOT NULL
	,[BLDestinationCountryName] varchar(255) NOT NULL
	,[OriginLocationLocationCode] varchar(255) NOT NULL
	,[OriginLocationName] varchar(255) NOT NULL
	,[OriginLocationPostalCode] varchar(255) NOT NULL
	,[OriginLocationCity_id] varchar(255) NOT NULL
	,[OriginLocationCityName] varchar(255) NOT NULL
	,[OriginLocationCityState] varchar(255) NOT NULL
	,[OriginLocationCountryCode] varchar(255) NOT NULL
	,[OriginLocationCountryName] varchar(255) NOT NULL
	,[FinalDestinationLocationCode] varchar(255) NOT NULL
	,[FinalDestinationName] varchar(255) NOT NULL
	,[FinalDestinationPostalCode] varchar(255) NOT NULL
	,[FinalDestinationCity_id] varchar(255) NOT NULL
	,[FinalDestinationCityName] varchar(255) NOT NULL
	,[FinalDestinationState] varchar(255) NOT NULL
	,[FinalDestinationCountryCode] varchar(255) NOT NULL
	,[FinalDestinationCountryName] varchar(255) NOT NULL
	,[ReferenceNumber1] varchar(255) NOT NULL
	,[ReferenceNumber2] varchar(255) NOT NULL
	,[ReferenceNumber3] varchar(255) NOT NULL
	,[ReferenceNumber4] varchar(255) NOT NULL
	,[ReferenceNumber5] varchar(255) NOT NULL
	,[ReferenceNumber6] varchar(255) NOT NULL

		
	
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL

) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTN_ASN_Import_ContainerLineItemsHist] ON ttdStagingGeneric_GTN_ASN_Import_ContainerLineItemsHist 
( 
	 [PartnerId]
	,[ASNMessageGUID]
	,[ASNGUID]
	,[ContainerGUID]
	,[LineItemsGUID]
)
ALTER TABLE [dbo].[ttdStagingGeneric_GTN_ASN_Import_ContainerLineItemsHist] ADD CONSTRAINT [PK_ttdStagingGeneric_GTN_ASN_Import_ContainerLineItemsHist] PRIMARY KEY 
(
     [PartnerID] ASC
	,[EffDate] ASC
    ,[ASNMessageGUID] ASC
	,[ASNGUID] ASC
	,[ContainerGUID] ASC
	,[LineItemsGUID] ASC
 )
END

----------------------------------------------ttdStagingGeneric_GTN_ASN_Import_LineItemsHarmonizedCode-------------------------------------

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGeneric_GTN_ASN_Import_LineItemsHarmonizedCode' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTN_ASN_Import_LineItemsHarmonizedCode(
	[PartnerId] int NOT NULL
	,[EffDate] datetime NOT NULL
	,[ASNMessageGUID] varchar(50) NOT NULL
	,[ASNGUID] varchar(50) NOT NULL
	,[ContainerGUID] varchar(50) NOT NULL
	,[LineItemsGUID] varchar(50) NOT NULL
	
	,[HarmonizedCodeGUID] varchar(50) NOT NULL
	,[HarmonizedCode] varchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTN_ASN_Import_LineItemsHarmonizedCode] ON ttdStagingGeneric_GTN_ASN_Import_LineItemsHarmonizedCode 
( 
	 [PartnerId]
	,[ASNMessageGUID]
	,[ASNGUID]
	,[ContainerGUID]
	,[LineItemsGUID]
	,[HarmonizedCodeGUID]
)
ALTER TABLE [dbo].[ttdStagingGeneric_GTN_ASN_Import_LineItemsHarmonizedCode] ADD CONSTRAINT [PK_ttdStagingGeneric_GTN_ASN_Import_LineItemsHarmonizedCode] PRIMARY KEY 
(
     [PartnerID] ASC
    ,[ASNMessageGUID] ASC
	,[ASNGUID] ASC
	,[ContainerGUID] ASC
	,[LineItemsGUID] ASC
	,[HarmonizedCodeGUID] ASC
 )
END

-----------------------------------------ttdStagingGeneric_GTN_ASN_Import_LineItemsHarmonizedCodeHist------------------------------


IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGeneric_GTN_ASN_Import_LineItemsHarmonizedCodeHist' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTN_ASN_Import_LineItemsHarmonizedCodeHist(
	[PartnerId] int NOT NULL
	,[EffDate] datetime NOT NULL
	,[ASNMessageGUID] varchar(50) NOT NULL
	,[ASNGUID] varchar(50) NOT NULL
	,[ContainerGUID] varchar(50) NOT NULL
	,[LineItemsGUID] varchar(50) NOT NULL
	
	,[HarmonizedCodeGUID] varchar(50) NOT NULL
	,[HarmonizedCode] varchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTN_ASN_Import_LineItemsHarmonizedCodeHist] ON ttdStagingGeneric_GTN_ASN_Import_LineItemsHarmonizedCodeHist 
( 
	 [PartnerId]
	,[ASNMessageGUID]
	,[ASNGUID]
	,[ContainerGUID]
	,[LineItemsGUID]
	,[HarmonizedCodeGUID]
)
ALTER TABLE [dbo].[ttdStagingGeneric_GTN_ASN_Import_LineItemsHarmonizedCodeHist] ADD CONSTRAINT [PK_ttdStagingGeneric_GTN_ASN_Import_LineItemsHarmonizedCodeHist] PRIMARY KEY 
(
     [PartnerID] ASC
	,[EffDate] ASC
    ,[ASNMessageGUID] ASC
	,[ASNGUID] ASC
	,[ContainerGUID] ASC
	,[LineItemsGUID] ASC
	,[HarmonizedCodeGUID] ASC
 )
END

------------------------------------------------------ttdStagingGeneric_GTN_ASN_Import_Assortment------------------------------------


IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGeneric_GTN_ASN_Import_Assortment' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTN_ASN_Import_Assortment(
	[PartnerId] int NOT NULL
	,[EffDate] datetime NOT NULL
	,[ASNMessageGUID] varchar(50) NOT NULL
	,[ASNGUID] varchar(50) NOT NULL
	,[ContainerGUID] varchar(50) NOT NULL
	,[LineItemsGUID] varchar(50) NOT NULL
	,[AssortmentGUID] varchar(50) NOT NULL	
	,[Sku] varchar(255) NOT NULL
	,[UPC] varchar(255) NOT NULL
	,[Quantity] varchar(255) NOT NULL
	,[QuantityUnit] varchar(255) NOT NULL
	,[QuantityANSICode] varchar(255) NOT NULL
	,[MasterPackQuantity] varchar(255) NOT NULL
	,[MasterPackQuantityUnit] varchar(255) NOT NULL
	,[MasterPackQuantityANSICode] varchar(255) NOT NULL
	,[InnerPackQuantity] varchar(255) NOT NULL
	,[InnerPackQuantityyUnit] varchar(255) NOT NULL
	,[InnerPackQuantityANSICode] varchar(255) NOT NULL
	,[InnersPerMaster] varchar(255) NOT NULL
	,[CartonCount] varchar(255) NOT NULL
	,[CartonRange] varchar(255) NOT NULL
	,[TotalWeight] varchar(255) NOT NULL
	,[TotalWeightUnit] varchar(255) NOT NULL
	,[TotalWeightANSICode] varchar(255) NOT NULL
	,[TotalVolume] varchar(255) NOT NULL
	,[TotalVolumeUnit] varchar(255) NOT NULL
	,[TotalVolumeANSICode] varchar(255) NOT NULL
	,[FirstCostPrice] varchar(255) NOT NULL
	,[FirstCostPriceCurrency] varchar(255) NOT NULL
	,[LandedCostPrice] varchar(255) NOT NULL
	,[LandedCostPriceCurrency] varchar(255) NOT NULL
	,[RetailCostPrice] varchar(255) NOT NULL
	,[RetailCostPriceCurrency] varchar(255) NOT NULL
	,[ColorCode] varchar(255) NOT NULL
	,[ColorDescription] varchar(255) NOT NULL
	,[SizeCode] varchar(255) NOT NULL
	,[SizeDescription] varchar(255) NOT NULL
	,[StyleCode] varchar(255) NOT NULL
	,[StyleDescription] varchar(255) NOT NULL

	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTN_ASN_Import_Assortment] ON ttdStagingGeneric_GTN_ASN_Import_Assortment 
( 
	 [PartnerId]
	,[ASNMessageGUID]
	,[ASNGUID]
	,[ContainerGUID]
	,[LineItemsGUID]
	,[AssortmentGUID]
)
ALTER TABLE [dbo].[ttdStagingGeneric_GTN_ASN_Import_Assortment] ADD CONSTRAINT [PK_ttdStagingGeneric_GTN_ASN_Import_Assortment] PRIMARY KEY 
(
     [PartnerID] ASC
    ,[ASNMessageGUID] ASC
	,[ASNGUID] ASC
	,[ContainerGUID] ASC
	,[LineItemsGUID] ASC
	,[AssortmentGUID] ASC
 )
END

----------------------------------------ttdStagingGeneric_GTN_ASN_Import_AssortmentHist--------------------------------


IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGeneric_GTN_ASN_Import_AssortmentHist' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTN_ASN_Import_AssortmentHist(
	[PartnerId] int NOT NULL
	,[EffDate] datetime NOT NULL
	,[ASNMessageGUID] varchar(50) NOT NULL
	,[ASNGUID] varchar(50) NOT NULL
	,[ContainerGUID] varchar(50) NOT NULL
	,[LineItemsGUID] varchar(50) NOT NULL
	,[AssortmentGUID] varchar(50) NOT NULL	
	,[Sku] varchar(255) NOT NULL
	,[UPC] varchar(255) NOT NULL
	,[Quantity] varchar(255) NOT NULL
	,[QuantityUnit] varchar(255) NOT NULL
	,[QuantityANSICode] varchar(255) NOT NULL
	,[MasterPackQuantity] varchar(255) NOT NULL
	,[MasterPackQuantityUnit] varchar(255) NOT NULL
	,[MasterPackQuantityANSICode] varchar(255) NOT NULL
	,[InnerPackQuantity] varchar(255) NOT NULL
	,[InnerPackQuantityyUnit] varchar(255) NOT NULL
	,[InnerPackQuantityANSICode] varchar(255) NOT NULL
	,[InnersPerMaster] varchar(255) NOT NULL
	,[CartonCount] varchar(255) NOT NULL
	,[CartonRange] varchar(255) NOT NULL
	,[TotalWeight] varchar(255) NOT NULL
	,[TotalWeightUnit] varchar(255) NOT NULL
	,[TotalWeightANSICode] varchar(255) NOT NULL
	,[TotalVolume] varchar(255) NOT NULL
	,[TotalVolumeUnit] varchar(255) NOT NULL
	,[TotalVolumeANSICode] varchar(255) NOT NULL
	,[FirstCostPrice] varchar(255) NOT NULL
	,[FirstCostPriceCurrency] varchar(255) NOT NULL
	,[LandedCostPrice] varchar(255) NOT NULL
	,[LandedCostPriceCurrency] varchar(255) NOT NULL
	,[RetailCostPrice] varchar(255) NOT NULL
	,[RetailCostPriceCurrency] varchar(255) NOT NULL
	,[ColorCode] varchar(255) NOT NULL
	,[ColorDescription] varchar(255) NOT NULL
	,[SizeCode] varchar(255) NOT NULL
	,[SizeDescription] varchar(255) NOT NULL
	,[StyleCode] varchar(255) NOT NULL
	,[StyleDescription] varchar(255) NOT NULL
	
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTN_ASN_Import_AssortmentHist] ON ttdStagingGeneric_GTN_ASN_Import_AssortmentHist 
( 
	 [PartnerId]
	,[ASNMessageGUID]
	,[ASNGUID]
	,[ContainerGUID]
	,[LineItemsGUID]
	,[AssortmentGUID]
)
ALTER TABLE [dbo].[ttdStagingGeneric_GTN_ASN_Import_AssortmentHist] ADD CONSTRAINT [PK_ttdStagingGeneric_GTN_ASN_Import_AssortmentHist] PRIMARY KEY 
(
     [PartnerID] ASC
	,[EffDate] ASC
    ,[ASNMessageGUID] ASC
	,[ASNGUID] ASC
	,[ContainerGUID] ASC
	,[LineItemsGUID] ASC
	,[AssortmentGUID] ASC
 )
END


-----------------------------------------ttdStagingGeneric_GTN_ASN_Import_AssortmentDescription------------------------------

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGeneric_GTN_ASN_Import_AssortmentDescription' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTN_ASN_Import_AssortmentDescription(
	 [PartnerId] int NOT NULL
	,[EffDate] datetime NOT NULL
	,[ASNMessageGUID] varchar(50) NOT NULL
	,[ASNGUID] varchar(50) NOT NULL
	,[ContainerGUID] varchar(50) NOT NULL
	,[LineItemsGUID] varchar(50) NOT NULL
	,[AssortmentGUID] varchar(50) NOT NULL	
	,[AssortmentDescriptionGUID] varchar(50) NOT NULL	
	,[AssortmentDescription] varchar(255) NOT NULL
		
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTN_ASN_Import_AssortmentHist] ON ttdStagingGeneric_GTN_ASN_Import_AssortmentDescription 
( 
	 [PartnerId]
	,[ASNMessageGUID]
	,[ASNGUID]
	,[ContainerGUID]
	,[LineItemsGUID]
	,[AssortmentGUID]
	,[AssortmentDescriptionGUID]
)
ALTER TABLE [dbo].[ttdStagingGeneric_GTN_ASN_Import_AssortmentDescription] ADD CONSTRAINT [PK_ttdStagingGeneric_GTN_ASN_Import_AssortmentDescription] PRIMARY KEY 
(
     [PartnerID] ASC
    ,[ASNMessageGUID] ASC
	,[ASNGUID] ASC
	,[ContainerGUID] ASC
	,[LineItemsGUID] ASC
	,[AssortmentGUID] ASC
	,[AssortmentDescriptionGUID] ASC
 )
END

-------------------------------------------ttdStagingGeneric_GTN_ASN_Import_AssortmentDescriptionHist----------------------------------

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGeneric_GTN_ASN_Import_AssortmentDescriptionHist' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTN_ASN_Import_AssortmentDescriptionHist(
	[PartnerId] int NOT NULL
	,[EffDate] datetime NOT NULL
	,[ASNMessageGUID] varchar(50) NOT NULL
	,[ASNGUID] varchar(50) NOT NULL
	,[ContainerGUID] varchar(50) NOT NULL
	,[LineItemsGUID] varchar(50) NOT NULL
	,[AssortmentGUID] varchar(50) NOT NULL	
	,[AssortmentDescriptionGUID] varchar(50) NOT NULL	
	,[AssortmentDescription] varchar(255) NOT NULL
		
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTN_ASN_Import_AssortmentDescriptionHist] ON ttdStagingGeneric_GTN_ASN_Import_AssortmentDescriptionHist ( 
	 [PartnerId]
	,[ASNMessageGUID]
	,[ASNGUID]
	,[ContainerGUID]
	,[LineItemsGUID]
	,[AssortmentGUID]
	,[AssortmentDescriptionGUID])
ALTER TABLE [dbo].[ttdStagingGeneric_GTN_ASN_Import_AssortmentDescriptionHist] ADD CONSTRAINT [PK_ttdStagingGeneric_GTN_ASN_Import_AssortmentDescriptionHist] PRIMARY KEY 
(
     [PartnerID] ASC
	,[EffDate] ASC
    ,[ASNMessageGUID] ASC
	,[ASNGUID] ASC
	,[ContainerGUID] ASC
	,[LineItemsGUID] ASC
	,[AssortmentGUID] ASC
	,[AssortmentDescriptionGUID] ASC
 )
END

---------------------------------------------ttdStagingGeneric_GTN_ASN_Import_HarmonizedCodeInfo-----------------------------------

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGeneric_GTN_ASN_Import_HarmonizedCodeInfo' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTN_ASN_Import_HarmonizedCodeInfo(
	[PartnerId] int NOT NULL
	,[EffDate] datetime NOT NULL
	,[ASNMessageGUID] varchar(50) NOT NULL
	,[ASNGUID] varchar(50) NOT NULL
	,[ContainerGUID] varchar(50) NOT NULL
	,[LineItemsGUID] varchar(50) NOT NULL
	,[AssortmentGUID] varchar(50) NOT NULL	
	,[HarmonizedCodeInfoGUID] varchar(50) NOT NULL	
	
		
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL

) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTN_ASN_Import_HarmonizedCodeInfo] ON ttdStagingGeneric_GTN_ASN_Import_HarmonizedCodeInfo 
( 
	 [PartnerId]
	,[ASNMessageGUID]
	,[ASNGUID]
	,[ContainerGUID]
	,[LineItemsGUID]
	,[AssortmentGUID]
	,[HarmonizedCodeInfoGUID]
)
ALTER TABLE [dbo].[ttdStagingGeneric_GTN_ASN_Import_HarmonizedCodeInfo] ADD CONSTRAINT [PK_ttdStagingGeneric_GTN_ASN_Import_HarmonizedCodeInfo] PRIMARY KEY 
(
     [PartnerID] ASC
    ,[ASNMessageGUID] ASC
	,[ASNGUID] ASC
	,[ContainerGUID] ASC
	,[LineItemsGUID] ASC
	,[AssortmentGUID] ASC
	,[HarmonizedCodeInfoGUID] ASC
 )
END

-------------------------------------------ttdStagingGeneric_GTN_ASN_Import_HarmonizedCodeInfoHist--------------------------------------

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGeneric_GTN_ASN_Import_HarmonizedCodeInfoHist' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTN_ASN_Import_HarmonizedCodeInfoHist(
	 [PartnerId] int NOT NULL
	,[EffDate] datetime NOT NULL
	,[ASNMessageGUID] varchar(50) NOT NULL
	,[ASNGUID] varchar(50) NOT NULL
	,[ContainerGUID] varchar(50) NOT NULL
	,[LineItemsGUID] varchar(50) NOT NULL
	,[AssortmentGUID] varchar(50) NOT NULL	
	,[HarmonizedCodeInfoGUID] varchar(50) NOT NULL	
		
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTN_ASN_Import_HarmonizedCodeInfoHist] ON ttdStagingGeneric_GTN_ASN_Import_HarmonizedCodeInfoHist ( 
	 [PartnerId]
	,[ASNMessageGUID]
	,[ASNGUID]
	,[ContainerGUID]
	,[LineItemsGUID]
	,[AssortmentGUID]
	,[HarmonizedCodeInfoGUID])
ALTER TABLE [dbo].[ttdStagingGeneric_GTN_ASN_Import_HarmonizedCodeInfoHist] ADD CONSTRAINT [PK_ttdStagingGeneric_GTN_ASN_Import_HarmonizedCodeInfoHist] PRIMARY KEY 
(
     [PartnerID] ASC
	,[EffDate] ASC
    ,[ASNMessageGUID] ASC
	,[ASNGUID] ASC
	,[ContainerGUID] ASC
	,[LineItemsGUID] ASC
	,[AssortmentGUID] ASC
	,[HarmonizedCodeInfoGUID] ASC
 )
END

--------------------------------------------------------ttdStagingGeneric_GTN_ASN_Import_PackUnitItemIdentifier-------------------------------------


IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGeneric_GTN_ASN_Import_PackUnitItemIdentifier' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTN_ASN_Import_PackUnitItemIdentifier(
	[PartnerId] int NOT NULL
	,[EffDate] datetime NOT NULL
	,[ASNMessageGUID] varchar(50) NOT NULL
	,[ASNGUID] varchar(50) NOT NULL
	,[PackUnitItemIdentifier] varchar(255) NOT NULL
	,[PackUnitItemIdentifierSource] varchar(100) NOT NULL
	,[PackUnitItemIdentifierSourceGUID] varchar(50) NOT NULL	
	,[PackUnitItemIdentifierGUID] varchar(50) NOT NULL	
			
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTN_ASN_Import_PackUnitItemIdentifier] ON ttdStagingGeneric_GTN_ASN_Import_PackUnitItemIdentifier 
( 
	 [PartnerId]
	,[ASNMessageGUID]
	,[ASNGUID]
	,[PackUnitItemIdentifierSourceGUID]
	,[PackUnitItemIdentifierGUID]
)
ALTER TABLE [dbo].[ttdStagingGeneric_GTN_ASN_Import_PackUnitItemIdentifier] ADD CONSTRAINT [PK_ttdStagingGeneric_GTN_ASN_Import_PackUnitItemIdentifier] PRIMARY KEY 
(
     [PartnerID] ASC
    ,[ASNMessageGUID] ASC
	,[ASNGUID] ASC
	,[PackUnitItemIdentifierSourceGUID] ASC
	,[PackUnitItemIdentifierGUID] ASC
 )
END

---------------------------------------------------ttdStagingGeneric_GTN_ASN_Import_PackUnitItemIdentifierHist--------------------------------

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGeneric_GTN_ASN_Import_PackUnitItemIdentifierHist' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTN_ASN_Import_PackUnitItemIdentifierHist(
	 [PartnerId] int NOT NULL
	,[EffDate] datetime NOT NULL
	,[ASNMessageGUID] varchar(50) NOT NULL
	,[ASNGUID] varchar(50) NOT NULL
	,[PackUnitItemIdentifier] varchar(255) NOT NULL
	,[PackUnitItemIdentifierSource] varchar(100) NOT NULL
	,[PackUnitItemIdentifierSourceGUID] varchar(50) NOT NULL	
	,[PackUnitItemIdentifierGUID] varchar(50) NOT NULL	
		
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTN_ASN_Import_PackUnitItemIdentifierHist] ON ttdStagingGeneric_GTN_ASN_Import_PackUnitItemIdentifierHist 
( 
	 [PartnerId]
	,[ASNMessageGUID]
	,[ASNGUID]
	,[PackUnitItemIdentifierSourceGUID]
	,[PackUnitItemIdentifierGUID]
)
ALTER TABLE [dbo].[ttdStagingGeneric_GTN_ASN_Import_PackUnitItemIdentifierHist] ADD CONSTRAINT [PK_ttdStagingGeneric_GTN_ASN_Import_PackUnitItemIdentifierHist] PRIMARY KEY 
(
     [PartnerID] ASC
	,[EffDate] ASC
    ,[ASNMessageGUID] ASC
	,[ASNGUID] ASC
	,[PackUnitItemIdentifierSourceGUID] ASC
	,[PackUnitItemIdentifierGUID] ASC
 )
END

---------------------------------------------------ttdStagingGeneric_GTN_ASN_Import_LineItemsShippingOrderNumber---------------------------------------

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGeneric_GTN_ASN_Import_LineItemsShippingOrderNumber' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTN_ASN_Import_LineItemsShippingOrderNumber(
	 [PartnerId] int NOT NULL
	,[EffDate] datetime NOT NULL
	,[ASNMessageGUID] varchar(50) NOT NULL
	,[ASNGUID] varchar(50) NOT NULL
	,[ContainerGUID] varchar(50) NOT NULL
	,[LineItemsGUID] varchar(50) NOT NULL
	,[ShippingOrderNumberGUID] varchar(50) NOT NULL	
	
	,[ShippingOrderNumber] varchar(255) NOT NULL	
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTN_ASN_Import_LineItemsShippingOrderNumber] ON ttdStagingGeneric_GTN_ASN_Import_LineItemsShippingOrderNumber 
( 
	 [PartnerId]
	,[ASNMessageGUID]
	,[ASNGUID]
	,[ContainerGUID]
	,[LineItemsGUID]
	,[ShippingOrderNumberGUID]
)
ALTER TABLE [dbo].[ttdStagingGeneric_GTN_ASN_Import_LineItemsShippingOrderNumber] ADD CONSTRAINT [PK_ttdStagingGeneric_GTN_ASN_Import_LineItemsShippingOrderNumber] PRIMARY KEY 
(
     [PartnerID] ASC
    ,[ASNMessageGUID] ASC
	,[ASNGUID] ASC
	,[ContainerGUID] ASC
	,[LineItemsGUID] ASC
	,[ShippingOrderNumberGUID] ASC
 )
END

---------------------------------------------------ttdStagingGeneric_GTN_ASN_Import_LineItemsShippingOrderNumberHist---------------------------------------

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGeneric_GTN_ASN_Import_LineItemsShippingOrderNumberHist' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTN_ASN_Import_LineItemsShippingOrderNumberHist(
	[PartnerId] int NOT NULL
	,[EffDate] datetime NOT NULL
	,[ASNMessageGUID] varchar(50) NOT NULL
	,[ASNGUID] varchar(50) NOT NULL
	,[ContainerGUID] varchar(50) NOT NULL
	,[LineItemsGUID] varchar(50) NOT NULL
	,[ShippingOrderNumberGUID] varchar(50) NOT NULL	
	
	,[ShippingOrderNumber] varchar(255) NOT NULL	
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTN_ASN_Import_LineItemsShippingOrderNumberHist] ON ttdStagingGeneric_GTN_ASN_Import_LineItemsShippingOrderNumberHist ( 
	 [PartnerId]
	,[ASNMessageGUID]
	,[ASNGUID]
	,[ContainerGUID]
	,[LineItemsGUID]
	,[ShippingOrderNumberGUID])
ALTER TABLE [dbo].[ttdStagingGeneric_GTN_ASN_Import_LineItemsShippingOrderNumberHist] ADD CONSTRAINT [PK_ttdStagingGeneric_GTN_ASN_Import_LineItemsShippingOrderNumberHist] PRIMARY KEY 
(
     [PartnerID] ASC
	,[EffDate] ASC
    ,[ASNMessageGUID] ASC
	,[ASNGUID] ASC
	,[ContainerGUID] ASC
	,[LineItemsGUID] ASC
	,[ShippingOrderNumberGUID] ASC
 )
END

--------------------------------------------------ttdStagingGeneric_GTN_ASN_Import_PackUnit----------------------------------------------

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGeneric_GTN_ASN_Import_PackUnit' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTN_ASN_Import_PackUnit(
	[PartnerId] int NOT NULL
	,[EffDate] datetime NOT NULL
	,[ASNMessageGUID] varchar(50) NOT NULL
	,[ASNGUID] varchar(50) NOT NULL
	
	,[PackUnitSource] varchar(100) NOT NULL
	,[PackUnitSourceGUID] varchar(50) NOT NULL	
	,[PackUnitGUID] varchar(50) NOT NULL	
	
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTN_ASN_Import_PackUnit] ON ttdStagingGeneric_GTN_ASN_Import_PackUnit 
( 
	 [PartnerId]
	,[ASNMessageGUID]
	,[ASNGUID]
	,[PackUnitSourceGUID]
	,[PackUnitGUID]
)
ALTER TABLE [dbo].[ttdStagingGeneric_GTN_ASN_Import_PackUnit] ADD CONSTRAINT [PK_ttdStagingGeneric_GTN_ASN_Import_PackUnit] PRIMARY KEY 
(
     [PartnerID] ASC
    ,[ASNMessageGUID] ASC
	,[ASNGUID] ASC
	,[PackUnitSourceGUID] ASC
	,[PackUnitGUID] ASC
 )
END

------------------------------------------ttdStagingGeneric_GTN_ASN_Import_PackUnitHist--------------------------------------

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGeneric_GTN_ASN_Import_PackUnitHist' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTN_ASN_Import_PackUnitHist(
	 [PartnerId] int NOT NULL
	,[EffDate] datetime NOT NULL
	,[ASNMessageGUID] varchar(50) NOT NULL
	,[ASNGUID] varchar(50) NOT NULL
	,[PackUnitSource] varchar(100) NOT NULL
	,[PackUnitSourceGUID] varchar(50) NOT NULL	
	,[PackUnitGUID] varchar(50) NOT NULL	
	
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTN_ASN_Import_PackUnitHist] ON ttdStagingGeneric_GTN_ASN_Import_PackUnitHist ( 
	 [PartnerId]
	,[ASNMessageGUID]
	,[ASNGUID]
	,[PackUnitSourceGUID]
	,[PackUnitGUID]
	)
ALTER TABLE [dbo].[ttdStagingGeneric_GTN_ASN_Import_PackUnitHist] ADD CONSTRAINT [PK_ttdStagingGeneric_GTN_ASN_Import_PackUnitHist] PRIMARY KEY 
(
     [PartnerID] ASC
	,[EffDate] ASC
    ,[ASNMessageGUID] ASC
	,[ASNGUID] ASC
	,[PackUnitSourceGUID] ASC
	,[PackUnitGUID] ASC
 )
END

---------------------------------------------------------ttdStagingGeneric_GTN_ASN_Import_PackUnitHeader-------------------------------------

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGeneric_GTN_ASN_Import_PackUnitHeader' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTN_ASN_Import_PackUnitHeader(
	 [PartnerId] int NOT NULL
	,[EffDate] datetime NOT NULL
	,[ASNMessageGUID] varchar(50) NOT NULL
	,[ASNGUID] varchar(50) NOT NULL
	,[PackUnitGUID] varchar(50) NOT NULL
	,[PackUnitHeaderGUID] varchar(50) NOT NULL
		
	,[LPN] varchar(255) NOT NULL
	,[PackUnitNo] varchar(255) NOT NULL
	,[PalletId] varchar(255) NOT NULL
	,[LOTNumber] varchar(255) NOT NULL
	,[PackUnitType] varchar(255) NOT NULL
	,[PackUnitSizeType] varchar(255) NOT NULL
	,[LastPackUnit] varchar(255) NOT NULL
	,[MixedPackUnit] varchar(255) NOT NULL
	,[Archive] varchar(255) NOT NULL
	,[DimensionUnit] varchar(255) NOT NULL
	,[DimensionANSICode] varchar(255) NOT NULL
	,[DimensionInfoLength] varchar(255) NOT NULL
	,[DimensionInfoWidth] varchar(255) NOT NULL
	,[DimensionInfoHeight] varchar(255) NOT NULL
	,[Quantity] varchar(255) NOT NULL
	,[QuantityUnit] varchar(255) NOT NULL
	,[QuantityANSICode] varchar(255) NOT NULL
	,[Weight] varchar(255) NOT NULL
	,[WeightUnit] varchar(255) NOT NULL
	,[WeightANSICode] varchar(255) NOT NULL
	,[Volume] varchar(255) NOT NULL
	,[VolumeUnit] varchar(255) NOT NULL
	,[VolumeANSICode] varchar(255) NOT NULL
	,[LabelStatus] varchar(255) NOT NULL
	,[PackUnitStatus] varchar(255) NOT NULL
	,[ContainerNumber] varchar(255) NOT NULL
	,[SealNumber] varchar(255) NOT NULL
	,[ContainerWeight] varchar(255) NOT NULL
	,[ContainerWeightUnit] varchar(255) NOT NULL
	,[ContainerWeightANSICode] varchar(255) NOT NULL
	,[NetWeight] varchar(255) NOT NULL
	,[NetWeightUnit] varchar(255) NOT NULL
	,[NetWeightANSICode] varchar(255) NOT NULL
	,[EmptyWeight] varchar(255) NOT NULL
	,[EmptyWeightUnit] varchar(255) NOT NULL
	,[EmptyWeightANSICode] varchar(255) NOT NULL
	,[Radius] varchar(255) NOT NULL
	,[SortCode] varchar(255) NOT NULL

	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTN_ASN_Import_PackUnitHeader] ON ttdStagingGeneric_GTN_ASN_Import_PackUnitHeader 
( 
	 [PartnerId]
	,[ASNMessageGUID]
	,[ASNGUID]
	,[PackUnitGUID]
	,[PackUnitHeaderGUID]
)
ALTER TABLE [dbo].[ttdStagingGeneric_GTN_ASN_Import_PackUnitHeader] ADD CONSTRAINT [PK_ttdStagingGeneric_GTN_ASN_Import_PackUnitHeader] PRIMARY KEY 
(
     [PartnerID] ASC
    ,[ASNMessageGUID] ASC
	,[ASNGUID] ASC
	,[PackUnitGUID] ASC
	,[PackUnitHeaderGUID] ASC
 )
END

--------------------------------------------------ttdStagingGeneric_GTN_ASN_Import_PackUnitHeaderHist-------------------------------------

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGeneric_GTN_ASN_Import_PackUnitHeaderHist' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTN_ASN_Import_PackUnitHeaderHist(
	 [PartnerId] int NOT NULL
	,[EffDate] datetime NOT NULL
	,[ASNMessageGUID] varchar(50) NOT NULL
	,[ASNGUID] varchar(50) NOT NULL
	,[PackUnitGUID] varchar(50) NOT NULL
	,[PackUnitHeaderGUID] varchar(50) NOT NULL
	
	,[LPN] varchar(255) NOT NULL
	,[PackUnitNo] varchar(255) NOT NULL
	,[PalletId] varchar(255) NOT NULL
	,[LOTNumber] varchar(255) NOT NULL
	,[PackUnitType] varchar(255) NOT NULL
	,[PackUnitSizeType] varchar(255) NOT NULL
	,[LastPackUnit] varchar(255) NOT NULL
	,[MixedPackUnit] varchar(255) NOT NULL
	,[Archive] varchar(255) NOT NULL
	,[DimensionUnit] varchar(255) NOT NULL
	,[DimensionANSICode] varchar(255) NOT NULL
	,[DimensionInfoLength] varchar(255) NOT NULL
	,[DimensionInfoWidth] varchar(255) NOT NULL
	,[DimensionInfoHeight] varchar(255) NOT NULL
	,[Quantity] varchar(255) NOT NULL
	,[QuantityUnit] varchar(255) NOT NULL
	,[QuantityANSICode] varchar(255) NOT NULL
	,[Weight] varchar(255) NOT NULL
	,[WeightUnit] varchar(255) NOT NULL
	,[WeightANSICode] varchar(255) NOT NULL
	,[Volume] varchar(255) NOT NULL
	,[VolumeUnit] varchar(255) NOT NULL
	,[VolumeANSICode] varchar(255) NOT NULL
	,[LabelStatus] varchar(255) NOT NULL
	,[PackUnitStatus] varchar(255) NOT NULL
	,[ContainerNumber] varchar(255) NOT NULL
	,[SealNumber] varchar(255) NOT NULL
	,[ContainerWeight] varchar(255) NOT NULL
	,[ContainerWeightUnit] varchar(255) NOT NULL
	,[ContainerWeightANSICode] varchar(255) NOT NULL
	,[NetWeight] varchar(255) NOT NULL
	,[NetWeightUnit] varchar(255) NOT NULL
	,[NetWeightANSICode] varchar(255) NOT NULL
	,[EmptyWeight] varchar(255) NOT NULL
	,[EmptyWeightUnit] varchar(255) NOT NULL
	,[EmptyWeightANSICode] varchar(255) NOT NULL
	,[Radius] varchar(255) NOT NULL
	,[SortCode] varchar(255) NOT NULL

	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTN_ASN_Import_PackUnitHeaderHist] ON ttdStagingGeneric_GTN_ASN_Import_PackUnitHeaderHist 
( 
	 [PartnerId]
	,[ASNMessageGUID]
	,[ASNGUID]
	,[PackUnitGUID]
	,[PackUnitHeaderGUID]
)
ALTER TABLE [dbo].[ttdStagingGeneric_GTN_ASN_Import_PackUnitHeaderHist] ADD CONSTRAINT [PK_ttdStagingGeneric_GTN_ASN_Import_PackUnitHeaderHist] PRIMARY KEY 
(
     [PartnerID] ASC
	,[EffDate] ASC
    ,[ASNMessageGUID] ASC
	,[ASNGUID] ASC
	,[PackUnitGUID] ASC
	,[PackUnitHeaderGUID] ASC
 )
END

---------------------------------------------ttdStagingGeneric_GTN_ASN_Import_PackUnitItem-----------------------------------

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGeneric_GTN_ASN_Import_PackUnitItem' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTN_ASN_Import_PackUnitItem(
	[PartnerId] int NOT NULL
	,[EffDate] datetime NOT NULL
	,[ASNMessageGUID] varchar(50) NOT NULL
	,[ASNGUID] varchar(50) NOT NULL
	,[PackUnitGUID] varchar(50) NOT NULL
	--,[PackUnitHeaderGUID] varchar(50) NOT NULL
	,[PackUnitItemGUID] varchar(50) NOT NULL
	
	,[PackUnitItemIdentifier] varchar(255) NOT NULL
	,[PONumber] varchar(255) NOT NULL
	,[POReference] varchar(255) NOT NULL
	,[POUserDefCharFld1] varchar(255) NOT NULL
	,[POUserDefCharFld2] varchar(255) NOT NULL
	,[POObjIdKey] varchar(255) NOT NULL
	,[POLineNum] varchar(255) NOT NULL
	,[ProductCode] varchar(255) NOT NULL
	,[ProductRefNum] varchar(255) NOT NULL
	,[POLineUserDefCharFld1] varchar(255) NOT NULL
	,[POLineUserDefCharFld2] varchar(255) NOT NULL
	,[FinalDestinationCode] varchar(255) NOT NULL
	,[ShipWindowEnd] varchar(255) NOT NULL
	,[POLineObjIdKey] varchar(255) NOT NULL
	,[DivisionCode] varchar(255) NOT NULL
	,[Color] varchar(255) NOT NULL
	,[Size] varchar(255) NOT NULL
	,[SizeCategory] varchar(255) NOT NULL
	,[Dimension] varchar(255) NOT NULL
	,[UPC] varchar(255) NOT NULL
	,[AssortmentUserDefChar1] varchar(255) NOT NULL
	,[AssortmentUserDefChar2] varchar(255) NOT NULL
	,[AssortmentUserDefChar3] varchar(255) NOT NULL
	,[AssortmentUserDefChar4] varchar(255) NOT NULL
	,[AssortmentUserDefChar5] varchar(255) NOT NULL
	,[EAN] varchar(255) NOT NULL
	,[PackType] varchar(255) NOT NULL
	,[QuotaCategoryNum] varchar(255) NOT NULL
	,[Quantity] varchar(255) NOT NULL
	,[QuantityUnit] varchar(255) NOT NULL
	,[QuantityANSICode] varchar(255) NOT NULL
	,[Weight] varchar(255) NOT NULL
	,[WeightUnit] varchar(255) NOT NULL
	,[WeightANSICode] varchar(255) NOT NULL
	,[NetWeight] varchar(255) NOT NULL
	,[NetWeightUnit] varchar(255) NOT NULL
	,[NetWeightANSICode] varchar(255) NOT NULL
	,[NetNetWeight] varchar(255) NOT NULL
	,[NetNetWeightUnit] varchar(255) NOT NULL
	,[NetNetWeightANSICode] varchar(255) NOT NULL
	,[Volume] varchar(255) NOT NULL
	,[VolumeUnit] varchar(255) NOT NULL
	,[VolumeANSICode] varchar(255) NOT NULL
	,[BLNumber] varchar(255) NOT NULL
	,[PackQuantity] varchar(255) NOT NULL
	,[PackQuantityUnit] varchar(255) NOT NULL
	,[PackQuantityANSICode] varchar(255) NOT NULL
	,[PackingNum] varchar(255) NOT NULL
	,[PackFactor] varchar(255) NOT NULL
	,[PackFactorUnit] varchar(255) NOT NULL
	,[PackFactorANSICode] varchar(255) NOT NULL
	,[OrderClassCode] varchar(255) NOT NULL
	,[OrderClassName] varchar(255) NOT NULL
		
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTN_ASN_Import_PackUnitItem] ON ttdStagingGeneric_GTN_ASN_Import_PackUnitItem 
( 
	 [PartnerId]
	,[ASNMessageGUID]
	,[ASNGUID]
	,[PackUnitGUID]
	--,[PackUnitHeaderGUID]
	,[PackUnitItemGUID]
)
ALTER TABLE [dbo].[ttdStagingGeneric_GTN_ASN_Import_PackUnitItem] ADD CONSTRAINT [PK_ttdStagingGeneric_GTN_ASN_Import_PackUnitItem] PRIMARY KEY 
(
     [PartnerID] ASC
    ,[ASNMessageGUID] ASC
	,[ASNGUID] ASC
	,[PackUnitGUID] ASC
	--,[PackUnitHeaderGUID] ASC
	,[PackUnitItemGUID] ASC
 )
END

------------------------------------------------ttdStagingGeneric_GTN_ASN_Import_PackUnitItemHist------------------------------

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGeneric_GTN_ASN_Import_PackUnitItemHist' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTN_ASN_Import_PackUnitItemHist(
	 [PartnerId] int NOT NULL
	,[EffDate] datetime NOT NULL
	,[ASNMessageGUID] varchar(50) NOT NULL
	,[ASNGUID] varchar(50) NOT NULL
	,[PackUnitGUID] varchar(50) NOT NULL
	--,[PackUnitHeaderGUID] varchar(50) NOT NULL
	,[PackUnitItemGUID] varchar(50) NOT NULL
	
	,[PackUnitItemIdentifier] varchar(255) NOT NULL
	,[PONumber] varchar(255) NOT NULL
	,[POReference] varchar(255) NOT NULL
	,[POUserDefCharFld1] varchar(255) NOT NULL
	,[POUserDefCharFld2] varchar(255) NOT NULL
	,[POObjIdKey] varchar(255) NOT NULL
	,[POLineNum] varchar(255) NOT NULL
	,[ProductCode] varchar(255) NOT NULL
	,[ProductRefNum] varchar(255) NOT NULL
	,[POLineUserDefCharFld1] varchar(255) NOT NULL
	,[POLineUserDefCharFld2] varchar(255) NOT NULL
	,[FinalDestinationCode] varchar(255) NOT NULL
	,[ShipWindowEnd] varchar(255) NOT NULL
	,[POLineObjIdKey] varchar(255) NOT NULL
	,[DivisionCode] varchar(255) NOT NULL
	,[Color] varchar(255) NOT NULL
	,[Size] varchar(255) NOT NULL
	,[SizeCategory] varchar(255) NOT NULL
	,[Dimension] varchar(255) NOT NULL
	,[UPC] varchar(255) NOT NULL
	,[AssortmentUserDefChar1] varchar(255) NOT NULL
	,[AssortmentUserDefChar2] varchar(255) NOT NULL
	,[AssortmentUserDefChar3] varchar(255) NOT NULL
	,[AssortmentUserDefChar4] varchar(255) NOT NULL
	,[AssortmentUserDefChar5] varchar(255) NOT NULL
	,[EAN] varchar(255) NOT NULL
	,[PackType] varchar(255) NOT NULL
	,[QuotaCategoryNum] varchar(255) NOT NULL
	,[Quantity] varchar(255) NOT NULL
	,[QuantityUnit] varchar(255) NOT NULL
	,[QuantityANSICode] varchar(255) NOT NULL
	,[Weight] varchar(255) NOT NULL
	,[WeightUnit] varchar(255) NOT NULL
	,[WeightANSICode] varchar(255) NOT NULL
	,[NetWeight] varchar(255) NOT NULL
	,[NetWeightUnit] varchar(255) NOT NULL
	,[NetWeightANSICode] varchar(255) NOT NULL
	,[NetNetWeight] varchar(255) NOT NULL
	,[NetNetWeightUnit] varchar(255) NOT NULL
	,[NetNetWeightANSICode] varchar(255) NOT NULL
	,[Volume] varchar(255) NOT NULL
	,[VolumeUnit] varchar(255) NOT NULL
	,[VolumeANSICode] varchar(255) NOT NULL
	,[BLNumber] varchar(255) NOT NULL
	,[PackQuantity] varchar(255) NOT NULL
	,[PackQuantityUnit] varchar(255) NOT NULL
	,[PackQuantityANSICode] varchar(255) NOT NULL
	,[PackingNum] varchar(255) NOT NULL
	,[PackFactor] varchar(255) NOT NULL
	,[PackFactorUnit] varchar(255) NOT NULL
	,[PackFactorANSICode] varchar(255) NOT NULL
	,[OrderClassCode] varchar(255) NOT NULL
	,[OrderClassName] varchar(255) NOT NULL

	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTN_ASN_Import_PackUnitItemHist] ON ttdStagingGeneric_GTN_ASN_Import_PackUnitItemHist 
( 
	 [PartnerId]
	,[ASNMessageGUID]
	,[ASNGUID]
	,[PackUnitGUID]
	--,[PackUnitHeaderGUID]
	,[PackUnitItemGUID])
ALTER TABLE [dbo].[ttdStagingGeneric_GTN_ASN_Import_PackUnitItemHist] ADD CONSTRAINT [PK_ttdStagingGeneric_GTN_ASN_Import_PackUnitItemHist] PRIMARY KEY 
(
     [PartnerID] ASC
	,[EffDate] ASC
    ,[ASNMessageGUID] ASC
	,[ASNGUID] ASC
	,[PackUnitGUID] ASC
	--,[PackUnitHeaderGUID] ASC
	,[PackUnitItemGUID] ASC
 )
END

-----------------------------------------------ttdStagingGeneric_GTN_ASN_Import_MilestoneMessageTransaction-----------------------------

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGeneric_GTN_ASN_Import_MilestoneMessageTransaction' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTN_ASN_Import_MilestoneMessageTransaction(
	 [PartnerId] int NOT NULL
	,[EffDate] datetime NOT NULL
	,[ASNMessageGUID] varchar(50) NOT NULL
	,[ASNGUID] varchar(50) NOT NULL
	,[MilestoneMessageSourceGUID] varchar(50) NOT NULL
	,[MilestoneMessageGUID] varchar(50) NOT NULL
	
	,[Source] varchar(100) NOT NULL
	,[MessageSender] varchar(255) NOT NULL
	,[MessageRecipient] varchar(255) NOT NULL
	,[MessageID] varchar(255) NOT NULL
	,[Created] datetime NOT NULL
	,[FileName] varchar(255) NOT NULL
	,[MessageOriginator] varchar(255) NOT NULL

	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTN_ASN_ImportExtraReferencesHist] ON ttdStagingGeneric_GTN_ASN_Import_MilestoneMessageTransaction 
( 
	 [PartnerId]
	,[ASNMessageGUID]
	,[ASNGUID]
	,[MilestoneMessageSourceGUID]  
	,[MilestoneMessageGUID]
)
ALTER TABLE [dbo].[ttdStagingGeneric_GTN_ASN_Import_MilestoneMessageTransaction] ADD CONSTRAINT [PK_ttdStagingGeneric_GTN_ASN_Import_MilestoneMessageTransaction] PRIMARY KEY 
(
     [PartnerID] ASC
    ,[ASNMessageGUID] ASC
	,[ASNGUID] ASC
	,[MilestoneMessageSourceGUID] ASC
	,[MilestoneMessageGUID] ASC
 )
END

---------------------------------------------------ttdStagingGeneric_GTN_ASN_Import_MilestoneMessageTransactionHist------------------------------------

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGeneric_GTN_ASN_Import_MilestoneMessageTransactionHist' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTN_ASN_Import_MilestoneMessageTransactionHist(
	 [PartnerId] int NOT NULL
	,[EffDate] datetime NOT NULL
	,[ASNMessageGUID] varchar(50) NOT NULL
	,[ASNGUID] varchar(50) NOT NULL
	,[MilestoneMessageSourceGUID]  varchar(50) NOT NULL
	,[MilestoneMessageGUID] varchar(50) NOT NULL
	
	,[Source] varchar(100) NOT NULL
	,[MessageSender] varchar(255) NOT NULL
	,[MessageRecipient] varchar(255) NOT NULL
	,[MessageID] varchar(255) NOT NULL
	,[Created] datetime NOT NULL
	,[FileName] varchar(255) NOT NULL
	,[MessageOriginator] varchar(255) NOT NULL

	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTN_ASN_Import_MilestoneMessageTransactionHist] ON ttdStagingGeneric_GTN_ASN_Import_MilestoneMessageTransactionHist 
( 
	 [PartnerId]
	,[ASNMessageGUID]
	,[ASNGUID]
	,[MilestoneMessageSourceGUID] 
	,[MilestoneMessageGUID]
)
ALTER TABLE [dbo].[ttdStagingGeneric_GTN_ASN_Import_MilestoneMessageTransactionHist] ADD CONSTRAINT [PK_ttdStagingGeneric_GTN_ASN_Import_MilestoneMessageTransactionHist] PRIMARY KEY 
(
     [PartnerID] ASC
	,[EffDate] ASC
    ,[ASNMessageGUID] ASC
	,[ASNGUID] ASC
	,[MilestoneMessageSourceGUID] ASC
	,[MilestoneMessageGUID] ASC
 )
END

---------------------------------------------------------ttdStagingGeneric_GTN_ASN_Import_MilestoneByType-----------------------------------

--OneMilestoneMultipleReferences
--OneReferenceMultipleMilestones

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGeneric_GTN_ASN_Import_MilestoneByType' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTN_ASN_Import_MilestoneByType(
	[PartnerId] int NOT NULL
	,[EffDate] datetime NOT NULL
	,[ASNMessageGUID] varchar(50) NOT NULL
	,[ASNGUID] varchar(50) NOT NULL
	,[MilestoneMessageGUID] varchar(50) NOT NULL
	,[MilestoneType] varchar(100) NOT NULL
	,[MilestoneTypeGUID] varchar(50) NOT NULL
	
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTN_ASN_Import_MilestoneByType] ON ttdStagingGeneric_GTN_ASN_Import_MilestoneByType 
( 
	 [PartnerId]
	,[ASNMessageGUID]
	,[ASNGUID]
	,[MilestoneMessageGUID] 
	,[MilestoneTypeGUID]
)
ALTER TABLE [dbo].[ttdStagingGeneric_GTN_ASN_Import_MilestoneByType] ADD CONSTRAINT [PK_ttdStagingGeneric_GTN_ASN_Import_MilestoneByType] PRIMARY KEY 
(
     [PartnerID] ASC
    ,[ASNMessageGUID] ASC
	,[ASNGUID] ASC
	,[MilestoneMessageGUID] ASC
	,[MilestoneTypeGUID] ASC
 )
END

---------------------------------------------ttdStagingGeneric_GTN_ASN_Import_MilestoneByTypeHIst----------------------------


IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGeneric_GTN_ASN_Import_MilestoneByTypeHist' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTN_ASN_Import_MilestoneByTypeHist(
	 [PartnerId] int NOT NULL
	,[EffDate] datetime NOT NULL
	,[ASNMessageGUID] varchar(50) NOT NULL
	,[ASNGUID] varchar(50) NOT NULL
	,[MilestoneMessageGUID] varchar(50) NOT NULL
	,[MilestoneType] varchar(100) NOT NULL
	,[MilestoneTypeGUID] varchar(50) NOT NULL
	
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTN_ASN_Import_MilestoneByTypeHIst] ON ttdStagingGeneric_GTN_ASN_Import_MilestoneByTypeHIst 
( 
	 [PartnerId]
	,[ASNMessageGUID]
	,[ASNGUID]
	,[MilestoneMessageGUID] 
	,[MilestoneTypeGUID]
)
ALTER TABLE [dbo].[ttdStagingGeneric_GTN_ASN_Import_MilestoneByTypeHIst] ADD CONSTRAINT [PK_ttdStagingGeneric_GTN_ASN_Import_MilestoneByTypeHIst] PRIMARY KEY 
(
     [PartnerID] ASC
	,[EffDate] ASC
    ,[ASNMessageGUID] ASC
	,[ASNGUID] ASC
	,[MilestoneMessageGUID] ASC
	,[MilestoneTypeGUID] ASC
 )
END

---------------------------------------------------------ttdStagingGeneric_GTN_ASN_Import_MilestoneInfo------------------------------------------

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGeneric_GTN_ASN_Import_MilestoneInfo' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTN_ASN_Import_MilestoneInfo(
	 [PartnerId] int NOT NULL
	,[EffDate] datetime NOT NULL
	,[ASNMessageGUID] varchar(50) NOT NULL
	,[ASNGUID] varchar(50) NOT NULL
	,[MilestoneMessageGUID] varchar(50) NOT NULL
	,[MilestoneInfoSource] varchar(100) NOT NULL
	,[MilestoneTypeGUID] varchar(150) NOT NULL
	,[MilestoneInfoGuid] varchar(150) NOT NULL

	,[MilestoneInfoPurposeCode] varchar(255) NOT NULL
	,[ProcessingStatus] varchar(255) NOT NULL
	,[MilestoneMessageRecipient] varchar(255) NOT NULL
	,[MilestoneMessageID] varchar(255) NOT NULL
	,[MilestoneTypeCode] varchar(255) NOT NULL
	,[MilestoneTypeName] varchar(255) NOT NULL
	,[MilestoneSource] varchar(255) NOT NULL
	,[MilestoneFormatId] varchar(255) NOT NULL
	,[MilestoneReasonCode] varchar(255) NOT NULL
	,[Comments] varchar(255) NOT NULL
	,[UserDefinedChar1] varchar(255) NOT NULL
	,[UserDefinedChar2] varchar(255) NOT NULL
	,[UserDefinedChar3] varchar(255) NOT NULL
	,[UserDefinedChar4] varchar(255) NOT NULL
	,[UserDefinedChar5] varchar(255) NOT NULL
	,[UserDefinedInt1] varchar(255) NOT NULL
	,[UserDefinedInt2] varchar(255) NOT NULL
	,[UserDefinedInt3] varchar(255) NOT NULL
	,[UserDefinedInt4] varchar(255) NOT NULL
	,[UserDefinedInt5] varchar(255) NOT NULL
	,[UserDefinedFloat1] varchar(255) NOT NULL
	,[UserDefinedFloat2] varchar(255) NOT NULL
	,[UserDefinedFloat3] varchar(255) NOT NULL
	,[UserDefinedFloat4] varchar(255) NOT NULL
	,[UserDefinedFloat5] varchar(255) NOT NULL
	,[UserDefinedDate1] datetime NOT NULL
	,[UserDefinedDate2] datetime NOT NULL
	,[UserDefinedDate3] datetime NOT NULL
	,[UserDefinedDate4] datetime  NOT NULL
	,[UserDefinedDate5] datetime NOT NULL
	,[PortOfDischargeTerminalNumber] varchar(255) NOT NULL
	,[ContainerType] varchar(255) NOT NULL
	,[ContainerTypeName] varchar(255) NOT NULL
	,[PackageCount] varchar(255) NOT NULL
	,[EstBLDestDate] datetime NOT NULL
	,[EstBLDestDateTimeZone] varchar(255) NOT NULL
	,[EstBLDestDateReportedLocalTimeZone] varchar(255) NOT NULL
	,[ShipmentPieces] varchar(255) NOT NULL
	,[ShipmentPiecesUnit] varchar(255) NOT NULL
	,[ShipmentPiecesANSICode] varchar(255) NOT NULL
	,[ShipmentWeight] varchar(255) NOT NULL
	,[ShipmentWeightUnit] varchar(255) NOT NULL
	,[ShipmentWeightANSICode] varchar(255) NOT NULL
	,[ShipmentVolume] varchar(255) NOT NULL
	,[ShipmentVolumeUnit] varchar(255) NOT NULL
	,[ShipmentVolumeANSICode] varchar(255) NOT NULL
	,[CityName_city_id] varchar(255) NOT NULL
	,[CityName] varchar(255) NOT NULL
	,[CityState] varchar(255) NOT NULL
	,[CityCountryCode] varchar(255) NOT NULL
	,[CityCountryName] varchar(255) NOT NULL
	,[PortOfLoading_city_id] varchar(255) NOT NULL
	,[PortOfLoadingCityName] varchar(255) NOT NULL
	,[PortOfLoadingState] varchar(255) NOT NULL
	,[PortOfLoadingCountryCode] varchar(255) NOT NULL
	,[PortOfLoadingCountryName] varchar(255) NOT NULL
	,[PortOfDischarge_city_id] varchar(255) NOT NULL
	,[PortOfDischargeCityName] varchar(255) NOT NULL
	,[PortOfDischargeState] varchar(255) NOT NULL
	,[PortOfDischargeCountryCode] varchar(255) NOT NULL
	,[PortOfDischargeCountryName] varchar(255) NOT NULL
	,[OriginCity_city_id] varchar(255) NOT NULL
	,[OriginCityCityName] varchar(255) NOT NULL
	,[OriginCityState] varchar(255) NOT NULL
	,[OriginCityCountryCode] varchar(255) NOT NULL
	,[OriginCityCountryName] varchar(255) NOT NULL
	,[BLDestination_city_id] varchar(255) NOT NULL
	,[BLDestinationCityName] varchar(255) NOT NULL
	,[BLDestinationState] varchar(255) NOT NULL
	,[BLDestinationCountryCode] varchar(255) NOT NULL
	,[BLDestinationCountryName] varchar(255) NOT NULL
	
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL

) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTN_ASN_Import_MilestoneInfo] ON ttdStagingGeneric_GTN_ASN_Import_MilestoneInfo 
( 
	 [PartnerId]
	,[ASNMessageGUID]
	,[ASNGUID]
	,[MilestoneMessageGUID] 
	,[MilestoneTypeGUID]
	,[MilestoneInfoGuid]
)
ALTER TABLE [dbo].[ttdStagingGeneric_GTN_ASN_Import_MilestoneInfo] ADD CONSTRAINT [PK_ttdStagingGeneric_GTN_ASN_Import_MilestoneInfo] PRIMARY KEY 
(
     [PartnerID] ASC
    ,[ASNMessageGUID] ASC
	,[ASNGUID] ASC
	,[MilestoneMessageGUID] ASC
	,[MilestoneTypeGUID] ASC
	,[MilestoneInfoGuid] ASC
 )
END

----------------------------------------------ttdStagingGeneric_GTN_ASN_Import_MilestoneInfoHist----------------------------------------

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGeneric_GTN_ASN_Import_MilestoneInfoHist' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTN_ASN_Import_MilestoneInfoHist(
	 [PartnerId] int NOT NULL
	,[EffDate] datetime NOT NULL
	,[ASNMessageGUID] varchar(50) NOT NULL
	,[ASNGUID] varchar(50) NOT NULL
	,[MilestoneMessageGUID] varchar(50) NOT NULL
	,[MilestoneInfoSource] varchar(100) NOT NULL
	,[MilestoneTypeGUID] varchar(150) NOT NULL
	,[MilestoneInfoGuid] varchar(150) NOT NULL

	,[MilestoneInfoPurposeCode] varchar(255) NOT NULL
	,[ProcessingStatus] varchar(255) NOT NULL
	,[MilestoneMessageRecipient] varchar(255) NOT NULL
	,[MilestoneMessageID] varchar(255) NOT NULL
	,[MilestoneTypeCode] varchar(255) NOT NULL
	,[MilestoneTypeName] varchar(255) NOT NULL
	,[MilestoneSource] varchar(255) NOT NULL
	,[MilestoneFormatId] varchar(255) NOT NULL
	,[MilestoneReasonCode] varchar(255) NOT NULL
	,[Comments] varchar(255) NOT NULL
	,[UserDefinedChar1] varchar(255) NOT NULL
	,[UserDefinedChar2] varchar(255) NOT NULL
	,[UserDefinedChar3] varchar(255) NOT NULL
	,[UserDefinedChar4] varchar(255) NOT NULL
	,[UserDefinedChar5] varchar(255) NOT NULL
	,[UserDefinedInt1] varchar(255) NOT NULL
	,[UserDefinedInt2] varchar(255) NOT NULL
	,[UserDefinedInt3] varchar(255) NOT NULL
	,[UserDefinedInt4] varchar(255) NOT NULL
	,[UserDefinedInt5] varchar(255) NOT NULL
	,[UserDefinedFloat1] varchar(255) NOT NULL
	,[UserDefinedFloat2] varchar(255) NOT NULL
	,[UserDefinedFloat3] varchar(255) NOT NULL
	,[UserDefinedFloat4] varchar(255) NOT NULL
	,[UserDefinedFloat5] varchar(255) NOT NULL
	,[UserDefinedDate1] datetime NOT NULL
	,[UserDefinedDate2] datetime NOT NULL
	,[UserDefinedDate3] datetime NOT NULL
	,[UserDefinedDate4] datetime  NOT NULL
	,[UserDefinedDate5] datetime NOT NULL
	,[PortOfDischargeTerminalNumber] varchar(255) NOT NULL
	,[ContainerType] varchar(255) NOT NULL
	,[ContainerTypeName] varchar(255) NOT NULL
	,[PackageCount] varchar(255) NOT NULL
	,[EstBLDestDate] datetime NOT NULL
	,[EstBLDestDateTimeZone] varchar(255) NOT NULL
	,[EstBLDestDateReportedLocalTimeZone] varchar(255) NOT NULL
	,[ShipmentPieces] varchar(255) NOT NULL
	,[ShipmentPiecesUnit] varchar(255) NOT NULL
	,[ShipmentPiecesANSICode] varchar(255) NOT NULL
	,[ShipmentWeight] varchar(255) NOT NULL
	,[ShipmentWeightUnit] varchar(255) NOT NULL
	,[ShipmentWeightANSICode] varchar(255) NOT NULL
	,[ShipmentVolume] varchar(255) NOT NULL
	,[ShipmentVolumeUnit] varchar(255) NOT NULL
	,[ShipmentVolumeANSICode] varchar(255) NOT NULL
	,[CityName_city_id] varchar(255) NOT NULL
	,[CityName] varchar(255) NOT NULL
	,[CityState] varchar(255) NOT NULL
	,[CityCountryCode] varchar(255) NOT NULL
	,[CityCountryName] varchar(255) NOT NULL
	,[PortOfLoading_city_id] varchar(255) NOT NULL
	,[PortOfLoadingCityName] varchar(255) NOT NULL
	,[PortOfLoadingState] varchar(255) NOT NULL
	,[PortOfLoadingCountryCode] varchar(255) NOT NULL
	,[PortOfLoadingCountryName] varchar(255) NOT NULL
	,[PortOfDischarge_city_id] varchar(255) NOT NULL
	,[PortOfDischargeCityName] varchar(255) NOT NULL
	,[PortOfDischargeState] varchar(255) NOT NULL
	,[PortOfDischargeCountryCode] varchar(255) NOT NULL
	,[PortOfDischargeCountryName] varchar(255) NOT NULL
	,[OriginCity_city_id] varchar(255) NOT NULL
	,[OriginCityCityName] varchar(255) NOT NULL
	,[OriginCityState] varchar(255) NOT NULL
	,[OriginCityCountryCode] varchar(255) NOT NULL
	,[OriginCityCountryName] varchar(255) NOT NULL
	,[BLDestination_city_id] varchar(255) NOT NULL
	,[BLDestinationCityName] varchar(255) NOT NULL
	,[BLDestinationState] varchar(255) NOT NULL
	,[BLDestinationCountryCode] varchar(255) NOT NULL
	,[BLDestinationCountryName] varchar(255) NOT NULL
	
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTN_ASN_Import_MilestoneInfoHist] ON ttdStagingGeneric_GTN_ASN_Import_MilestoneInfoHist 
( 
	 [PartnerId]
	,[ASNMessageGUID]
	,[ASNGUID]
	,[MilestoneMessageGUID] 
	,[MilestoneTypeGUID]
	,[MilestoneInfoGuid]
)
ALTER TABLE [dbo].[ttdStagingGeneric_GTN_ASN_Import_MilestoneInfoHist] ADD CONSTRAINT [PK_ttdStagingGeneric_GTN_ASN_Import_MilestoneInfoHist] PRIMARY KEY 
(
     [PartnerID] ASC
	,[EffDate] ASC
    ,[ASNMessageGUID] ASC
	,[ASNGUID] ASC
	,[MilestoneMessageGUID] ASC
	,[MilestoneTypeGUID] ASC
	,[MilestoneInfoGuid] ASC
 )
END

----------------------------------------------------ttdStagingGeneric_GTN_ASN_Import_MilestoneTime-------------------------


IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGeneric_GTN_ASN_Import_MilestoneTime' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTN_ASN_Import_MilestoneTime(
	 [PartnerId] int NOT NULL
	,[EffDate] datetime NOT NULL
	,[ASNMessageGUID] varchar(50) NOT NULL
	,[ASNGUID] varchar(50) NOT NULL
	,[MilestoneMessageGUID] varchar(50) NOT NULL
	,[MilestoneTypeGUID] varchar(50) NOT NULL
	,[MilestoneInfoGuid] varchar(50) NOT NULL
	,[MilestoneTimeGUID] varchar(50) NOT NULL
	
	,[dateTime] varchar(250) NOT NULL
	,[timeZone] varchar(250) NOT NULL
	,[whichTime] varchar(250) NOT NULL
	
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTN_ASN_Import_MilestoneTime] ON ttdStagingGeneric_GTN_ASN_Import_MilestoneTime 
( 
	 [PartnerId]
	,[ASNMessageGUID]
	,[ASNGUID]
	,[MilestoneMessageGUID] 
	,[MilestoneTypeGUID]
	,[MilestoneInfoGuid] 
	,[MilestoneTimeGUID] 
)
ALTER TABLE [dbo].[ttdStagingGeneric_GTN_ASN_Import_MilestoneTime] ADD CONSTRAINT [PK_ttdStagingGeneric_GTN_ASN_Import_MilestoneTime] PRIMARY KEY 
(
     [PartnerID] ASC
    ,[ASNMessageGUID] ASC
	,[ASNGUID] ASC
	,[MilestoneMessageGUID] ASC
	,[MilestoneTypeGUID] ASC
	,[MilestoneInfoGuid] ASC
	,[MilestoneTimeGUID] ASC
 )
END

------------------------------------------ttdStagingGeneric_GTN_ASN_Import_MilestoneTimeHist-------------------------


IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGeneric_GTN_ASN_Import_MilestoneTimeHist' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTN_ASN_Import_MilestoneTimeHist(
	 [PartnerId] int NOT NULL
	,[EffDate] datetime NOT NULL
	,[ASNMessageGUID] varchar(50) NOT NULL
	,[ASNGUID] varchar(50) NOT NULL
	,[MilestoneMessageGUID] varchar(50) NOT NULL
	,[MilestoneTypeGUID] varchar(50) NOT NULL
	,[MilestoneInfoGuid] varchar(50) NOT NULL
	,[MilestoneTimeGUID] varchar(50) NOT NULL
	
	,[dateTime] varchar(250) NOT NULL
	,[timeZone] varchar(250) NOT NULL
	,[whichTime] varchar(250) NOT NULL
	
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	
) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTN_ASN_Import_MilestoneTimeHist] ON ttdStagingGeneric_GTN_ASN_Import_MilestoneTimeHist 
( 
	 [PartnerId]
	,[ASNMessageGUID]
	,[ASNGUID]
	,[MilestoneMessageGUID] 
	,[MilestoneTypeGUID]
	,[MilestoneInfoGuid] 
	,[MilestoneTimeGUID] 
)
ALTER TABLE [dbo].[ttdStagingGeneric_GTN_ASN_Import_MilestoneTimeHist] ADD CONSTRAINT [PK_ttdStagingGeneric_GTN_ASN_Import_MilestoneTimeHist] PRIMARY KEY 
(
     [PartnerID] ASC
	,[EffDate] ASC
    ,[ASNMessageGUID] ASC
	,[ASNGUID] ASC
	,[MilestoneMessageGUID] ASC
	,[MilestoneTypeGUID] ASC
	,[MilestoneInfoGuid] ASC
	,[MilestoneTimeGUID] ASC
 )
END

------------------------------------------------ttdStagingGeneric_GTN_ASN_Import_CustomMilestone---------------------------


IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGeneric_GTN_ASN_Import_CustomMilestone' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTN_ASN_Import_CustomMilestone(
	 [PartnerId] int NOT NULL
	,[EffDate] datetime NOT NULL
	,[ASNMessageGUID] varchar(50) NOT NULL
	,[ASNGUID] varchar(50) NOT NULL
	,[MilestoneMessageGUID] varchar(50) NOT NULL
	,[MilestoneTypeGUID] varchar(50) NOT NULL
	,[MilestoneInfoGuid] varchar(50) NOT NULL
	,[CustomMilestoneFieldGUID] varchar(50) NOT NULL
	
	,[info] varchar(250) NOT NULL
	,[infoType] varchar(250) NOT NULL
		
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTN_ASN_Import_CustomMilestone] ON ttdStagingGeneric_GTN_ASN_Import_CustomMilestone 
( 
	 [PartnerId]
	,[ASNMessageGUID]
	,[ASNGUID]
	,[MilestoneMessageGUID] 
	,[MilestoneTypeGUID]
	,[MilestoneInfoGuid] 
	,[CustomMilestoneFieldGUID] 
)
ALTER TABLE [dbo].[ttdStagingGeneric_GTN_ASN_Import_CustomMilestone] ADD CONSTRAINT [PK_ttdStagingGeneric_GTN_ASN_Import_CustomMilestone] PRIMARY KEY 
(
     [PartnerID] ASC
    ,[ASNMessageGUID] ASC
	,[ASNGUID] ASC
	,[MilestoneMessageGUID] ASC
	,[MilestoneTypeGUID] ASC
	,[MilestoneInfoGuid] ASC
	,[CustomMilestoneFieldGUID] ASC
 )
END

----------------------------------------------ttdStagingGeneric_GTN_ASN_Import_CustomMilestoneHist-----------------------------------

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGeneric_GTN_ASN_Import_CustomMilestoneHist' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTN_ASN_Import_CustomMilestoneHist(
	 [PartnerId] int NOT NULL
	,[EffDate] datetime NOT NULL
	,[ASNMessageGUID] varchar(50) NOT NULL
	,[ASNGUID] varchar(50) NOT NULL
	,[MilestoneMessageGUID] varchar(50) NOT NULL
	,[MilestoneTypeGUID] varchar(50) NOT NULL
	,[MilestoneInfoGuid] varchar(50) NOT NULL
	,[CustomMilestoneFieldGUID] varchar(50) NOT NULL
	
	,[info] varchar(250) NOT NULL
	,[infoType] varchar(250) NOT NULL
		
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTN_ASN_Import_CustomMilestoneHist] ON ttdStagingGeneric_GTN_ASN_Import_CustomMilestoneHist 
( 
	 [PartnerId]
	,[ASNMessageGUID]
	,[ASNGUID]
	,[MilestoneMessageGUID] 
	,[MilestoneTypeGUID]
	,[MilestoneInfoGuid] 
	,[CustomMilestoneFieldGUID] 
)
ALTER TABLE [dbo].[ttdStagingGeneric_GTN_ASN_Import_CustomMilestoneHist] ADD CONSTRAINT [PK_ttdStagingGeneric_GTN_ASN_Import_CustomMilestoneHist] PRIMARY KEY 
(
     [PartnerID] ASC
	,[EffDate] ASC
    ,[ASNMessageGUID] ASC
	,[ASNGUID] ASC
	,[MilestoneMessageGUID] ASC
	,[MilestoneTypeGUID] ASC
	,[MilestoneInfoGuid] ASC
	,[CustomMilestoneFieldGUID] ASC
 )
END

---------------------------------------------ttdStagingGeneric_GTN_ASN_Import_ExtraMilestoneInfoId-----------------------------------


IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGeneric_GTN_ASN_Import_ExtraMilestoneInfoId' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTN_ASN_Import_ExtraMilestoneInfoId(
	 [PartnerId] int NOT NULL
	,[EffDate] datetime NOT NULL
	,[ASNMessageGUID] varchar(50) NOT NULL
	,[ASNGUID] varchar(50) NOT NULL
	,[MilestoneMessageGUID] varchar(50) NOT NULL
	,[MilestoneTypeGUID] varchar(50) NOT NULL
	,[MilestoneInfoGuid] varchar(50) NOT NULL
	,[ExtraMilestoneInfoIdGUID] varchar(50) NOT NULL
	
	,[info] varchar(250) NOT NULL
	,[type] varchar(250) NOT NULL
		
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTN_ASN_Import_ExtraMilestoneInfoId] ON ttdStagingGeneric_GTN_ASN_Import_ExtraMilestoneInfoId 
( 
	 [PartnerId]
	,[ASNMessageGUID]
	,[ASNGUID]
	,[MilestoneMessageGUID] 
	,[MilestoneTypeGUID]
	,[MilestoneInfoGuid] 
	,[ExtraMilestoneInfoIdGUID] 
)
ALTER TABLE [dbo].[ttdStagingGeneric_GTN_ASN_Import_ExtraMilestoneInfoId] ADD CONSTRAINT [PK_ttdStagingGeneric_GTN_ASN_Import_ExtraMilestoneInfoId] PRIMARY KEY 
(
     [PartnerID] ASC
    ,[ASNMessageGUID] ASC
	,[ASNGUID] ASC
	,[MilestoneMessageGUID] ASC
	,[MilestoneTypeGUID] ASC
	,[MilestoneInfoGuid] ASC
	,[ExtraMilestoneInfoIdGUID] ASC
 )
END

-------------------------------------------------ttdStagingGeneric_GTN_ASN_Import_ExtraMilestoneInfoIdHist------------------------------------

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGeneric_GTN_ASN_Import_ExtraMilestoneInfoIdHist' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTN_ASN_Import_ExtraMilestoneInfoIdHist(
	 [PartnerId] int NOT NULL
	,[EffDate] datetime NOT NULL
	,[ASNMessageGUID] varchar(50) NOT NULL
	,[ASNGUID] varchar(50) NOT NULL
	,[MilestoneMessageGUID] varchar(50) NOT NULL
	,[MilestoneTypeGUID] varchar(50) NOT NULL
	,[MilestoneInfoGuid] varchar(50) NOT NULL
	,[ExtraMilestoneInfoIdGUID] varchar(50) NOT NULL
	
	,[info] varchar(250) NOT NULL
	,[type] varchar(250) NOT NULL
		
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTN_ASN_Import_ExtraMilestoneInfoIdHist] ON ttdStagingGeneric_GTN_ASN_Import_ExtraMilestoneInfoIdHist 
( 
	 [PartnerId]
	,[ASNMessageGUID]
	,[ASNGUID]
	,[MilestoneMessageGUID] 
	,[MilestoneTypeGUID]
	,[MilestoneInfoGuid] 
	,[ExtraMilestoneInfoIdGUID] 
)
ALTER TABLE [dbo].[ttdStagingGeneric_GTN_ASN_Import_ExtraMilestoneInfoIdHist] ADD CONSTRAINT [PK_ttdStagingGeneric_GTN_ASN_Import_ExtraMilestoneInfoIdHist] PRIMARY KEY 
(
     [PartnerID] ASC
	,[EffDate] ASC
    ,[ASNMessageGUID] ASC
	,[ASNGUID] ASC
	,[MilestoneMessageGUID] ASC
	,[MilestoneTypeGUID] ASC
	,[MilestoneInfoGuid] ASC
	,[ExtraMilestoneInfoIdGUID] ASC
 )
END

---------------------------------------------ttdStagingGeneric_GTN_ASN_Import_MilestoneReferenceInfo------------------------------------

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGeneric_GTN_ASN_Import_MilestoneReferenceInfo' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTN_ASN_Import_MilestoneReferenceInfo(

	 [PartnerId] int NOT NULL
	,[EffDate] datetime NOT NULL
	,[ASNMessageGUID] varchar(50) NOT NULL
	,[ASNGUID] varchar(50) NOT NULL
	,[MilestoneMessageGUID] varchar(50) NOT NULL
	,[MilestoneReferenceInfoSource] varchar(100) NOT NULL
	,[MilestoneTypeGUID] varchar(50) NOT NULL
	,[MilestoneReferenceInfoGUID] varchar(50) NOT NULL

	,[OrderClassCode] varchar(255) NOT NULL
	,[OrderClassName] varchar(255) NOT NULL
	,[ShipWindowStartDate] varchar(255) NOT NULL
	,[ShipWindowEndDate] varchar(255) NOT NULL
	,[ShipWindowCancelDate] varchar(255) NOT NULL
	,[Quantity] varchar(255) NOT NULL
	,[QuantityAddQuantity] varchar(255) NOT NULL
	,[QuantityAutoFillQuantity] varchar(255) NOT NULL
	,[Unit] varchar(255) NOT NULL
	,[ANSICode] varchar(255) NOT NULL
	,[QuantityUnit] varchar(255) NOT NULL
	,[PackUnitTxnKey] varchar(255) NOT NULL
	,[MilestoneMapToObject] varchar(255) NOT NULL
	
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTN_ASN_Import_MilestoneReferenceInfo] ON ttdStagingGeneric_GTN_ASN_Import_MilestoneReferenceInfo 
( 
	 [PartnerId]
	,[ASNMessageGUID]
	,[ASNGUID]
	,[MilestoneMessageGUID] 
	,[MilestoneTypeGUID]
	,[MilestoneReferenceInfoGUID] 
)
ALTER TABLE [dbo].[ttdStagingGeneric_GTN_ASN_Import_MilestoneReferenceInfo] ADD CONSTRAINT [PK_ttdStagingGeneric_GTN_ASN_Import_MilestoneReferenceInfo] PRIMARY KEY 
(
     [PartnerID] ASC
    ,[ASNMessageGUID] ASC
	,[ASNGUID] ASC
	,[MilestoneMessageGUID] ASC
	,[MilestoneTypeGUID] ASC
	,[MilestoneReferenceInfoGUID] ASC

 )
END

-------------------------------------------------ttdStagingGeneric_GTN_ASN_Import_MilestoneReferenceInfoHist--------------------------------

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGeneric_GTN_ASN_Import_MilestoneReferenceInfoHist' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTN_ASN_Import_MilestoneReferenceInfoHist(

	 [PartnerId] int NOT NULL
	,[EffDate] datetime NOT NULL
	,[ASNMessageGUID] varchar(50) NOT NULL
	,[ASNGUID] varchar(50) NOT NULL
	,[MilestoneMessageGUID] varchar(50) NOT NULL
	,[MilestoneReferenceInfoSource] varchar(100) NOT NULL
	,[MilestoneTypeGUID] varchar(50) NOT NULL
	,[MilestoneReferenceInfoGUID] varchar(50) NOT NULL

	,[OrderClassCode] varchar(255) NOT NULL
	,[OrderClassName] varchar(255) NOT NULL
	,[ShipWindowStartDate] varchar(255) NOT NULL
	,[ShipWindowEndDate] varchar(255) NOT NULL
	,[ShipWindowCancelDate] varchar(255) NOT NULL
	,[Quantity] varchar(255) NOT NULL
	,[QuantityAddQuantity] varchar(255) NOT NULL
	,[QuantityAutoFillQuantity] varchar(255) NOT NULL
	,[Unit] varchar(255) NOT NULL
	,[ANSICode] varchar(255) NOT NULL
	,[QuantityUnit] varchar(255) NOT NULL
	,[PackUnitTxnKey] varchar(255) NOT NULL
	,[MilestoneMapToObject] varchar(255) NOT NULL
	
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL

) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTN_ASN_Import_MilestoneReferenceInfoHist] ON ttdStagingGeneric_GTN_ASN_Import_MilestoneReferenceInfoHist 
( 
	 [PartnerId]
	,[ASNMessageGUID]
	,[ASNGUID]
	,[MilestoneMessageGUID] 
	,[MilestoneTypeGUID]
	,[MilestoneReferenceInfoGUID]	
)
ALTER TABLE [dbo].[ttdStagingGeneric_GTN_ASN_Import_MilestoneReferenceInfoHist] ADD CONSTRAINT [PK_ttdStagingGeneric_GTN_ASN_Import_MilestoneReferenceInfoHist] PRIMARY KEY 
(
     [PartnerID] ASC
	,[EffDate] ASC
    ,[ASNMessageGUID] ASC
	,[ASNGUID] ASC
	,[MilestoneMessageGUID] ASC
	,[MilestoneTypeGUID] ASC
	,[MilestoneReferenceInfoGUID] ASC

 )
END

--------------------------------------------------ttdStagingGeneric_GTN_ASN_Import_MilestoneReferenceId-------------------------------------

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGeneric_GTN_ASN_Import_MilestoneReferenceId' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTN_ASN_Import_MilestoneReferenceId(

	 [PartnerId] int NOT NULL
	,[EffDate] datetime NOT NULL
	,[ASNMessageGUID] varchar(50) NOT NULL
	,[ASNGUID] varchar(50) NOT NULL
	,[MilestoneMessageGUID] varchar(50) NOT NULL
	,[MilestoneTypeGUID] varchar(50) NOT NULL
	,[MilestoneReferenceInfoGUID] varchar(50) NOT NULL
	,[ReferenceIdGUID]varchar(50) NOT NULL

	,[reference] varchar(255) NOT NULL
	,[type] varchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	
) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTN_ASN_Import_MilestoneReferenceId] ON ttdStagingGeneric_GTN_ASN_Import_MilestoneReferenceId 
( 
	 [PartnerId]
	,[ASNMessageGUID]
	,[ASNGUID]
	,[MilestoneMessageGUID] 
	,[MilestoneTypeGUID]
	,[MilestoneReferenceInfoGUID] 
	,[ReferenceIdGUID]
)
ALTER TABLE [dbo].[ttdStagingGeneric_GTN_ASN_Import_MilestoneReferenceId] ADD CONSTRAINT [PK_ttdStagingGeneric_GTN_ASN_Import_MilestoneReferenceId] PRIMARY KEY 
(
     [PartnerID] ASC
    ,[ASNMessageGUID] ASC
	,[ASNGUID] ASC
	,[MilestoneMessageGUID] ASC
	,[MilestoneTypeGUID] ASC
	,[MilestoneReferenceInfoGUID] ASC
	,[ReferenceIdGUID] ASC

 )
END

--------------------------------------ttdStagingGeneric_GTN_ASN_Import_MilestoneReferenceIdHist-------------------------

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingGeneric_GTN_ASN_Import_MilestoneReferenceIdHist' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingGeneric_GTN_ASN_Import_MilestoneReferenceIdHist(

	 [PartnerId] int NOT NULL
	,[EffDate] datetime NOT NULL
	,[ASNMessageGUID] varchar(50) NOT NULL
	,[ASNGUID] varchar(50) NOT NULL
	,[MilestoneMessageGUID] varchar(50) NOT NULL
	,[MilestoneTypeGUID] varchar(50) NOT NULL
	,[MilestoneReferenceInfoGUID] varchar(50) NOT NULL
	,[ReferenceIdGUID]varchar(50) NOT NULL

	,[reference] varchar(255) NOT NULL
	,[type] varchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	
) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_ttdStagingGeneric_GTN_ASN_Import_MilestoneReferenceIdHist] ON ttdStagingGeneric_GTN_ASN_Import_MilestoneReferenceIdHist 
( 
	 [PartnerId]
	,[ASNMessageGUID]
	,[ASNGUID]
	,[MilestoneMessageGUID] 
	,[MilestoneTypeGUID]
	,[MilestoneReferenceInfoGUID] 
	,[ReferenceIdGUID]
)
ALTER TABLE [dbo].[ttdStagingGeneric_GTN_ASN_Import_MilestoneReferenceIdHist] ADD CONSTRAINT [PK_ttdStagingGeneric_GTN_ASN_Import_MilestoneReferenceIdHist] PRIMARY KEY 
(
     [PartnerID] ASC
	,[EffDate] ASC
    ,[ASNMessageGUID] ASC
	,[ASNGUID] ASC
	,[MilestoneMessageGUID] ASC
	,[MilestoneTypeGUID] ASC
	,[MilestoneReferenceInfoGUID] ASC
	,[ReferenceIdGUID] ASC

 )
END