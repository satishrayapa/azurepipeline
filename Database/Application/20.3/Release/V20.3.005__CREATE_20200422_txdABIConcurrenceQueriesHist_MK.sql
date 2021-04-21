--------------------------------------------------------------------------------------------------------------
--CREATE TABLE
--If you don't put a primary key on it, create a clustered index named CIX_TABLENAME
--COLLATE example provided though not required. Use this when defining a column as Case Sensitive.
--------------------------------------------------------------------------------------------------------------
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdABIConcurrenceQueriesHist' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
	CREATE TABLE [dbo].[txdABIConcurrenceQueriesHist] --Your Table Here
	(
		[PartnerID] [int] NOT NULL ,
		[EffDate] [datetime] NOT NULL ,
		[ID] [int] NOT NULL,
		[VersionID] [uniqueidentifier] NOT NULL,
		[IDQualifier] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
		[IDNum] [varchar] (35) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
		[ActionCode] [varchar] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[ReceivedQty] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
		[DeliveryCode] [varchar] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
		[IRSID] [varchar] (12) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL,
		[FIRMS] [varchar] (4) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL,
		[AirportCode] [varchar] (3) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL,
		[BTAInd] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL,
		[Containers] [ntext]   NOT NULL,
		[Remarks] [ntext]   NOT NULL,
		[AdmissionNum] [varchar] (35) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL,
		[CarrierCode] [varchar] (4) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL,
		[FlightNum] [varchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS  NOT NULL,
		[ArrivalDate] [datetime] NOT NULL ,		
		[DeletedFlag] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
		[KeepDuringRollback] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 
	) ON [PRIMARY]
		
		CREATE CLUSTERED INDEX [CIX_txdABIConcurrenceQueriesHist] ON [dbo].[txdABIConcurrenceQueriesHist] --Your Table Here
		(
			[EffDate] ASC
		)

END