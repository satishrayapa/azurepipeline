--------------------------------------------------------------------------------------------------------------
--CREATE TABLE
--If you don't put a primary key on it, create a clustered index named CIX_TABLENAME
--COLLATE example provided though not required. Use this when defining a column as Case Sensitive.
--------------------------------------------------------------------------------------------------------------
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdAdmissionReplaceInfo' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
	CREATE TABLE [dbo].[txdAdmissionReplaceInfo] --Your Table Here
	(
		[PartnerID] [int] NOT NULL ,
		[EffDate] [datetime] NOT NULL ,
		[ReceiptDocID] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
		[CompanyID] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
		[CompanyContactName] [varchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
		[CompanyContactPhone] [varchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS ,
		[ReasonCode1] [varchar] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
		[ReasonCode2] [varchar] (14) COLLATE SQL_Latin1_General_CP1_CI_AS ,
		[Remarks] [varchar] (780) COLLATE SQL_Latin1_General_CP1_CI_AS , 
		[DeletedFlag] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
		[KeepDuringRollback] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 
	) ON [PRIMARY]
		
		CREATE CLUSTERED INDEX [CIX_txdAdmissionReplaceInfo] ON [dbo].[txdAdmissionReplaceInfo] --Your Table Here
		(
			[EffDate] ASC
		)

		ALTER TABLE [dbo].[txdAdmissionReplaceInfo] ADD CONSTRAINT [PK_txdAdmissionReplaceInfo] PRIMARY KEY NONCLUSTERED --Your Table Here
		(
			  [PartnerID] ASC,
			  [ReceiptDocID] ASC
		)
END