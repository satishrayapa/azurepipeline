--Create main audit header table
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'tmgEntryDataAuditHeader' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
	CREATE TABLE [dbo].[tmgEntryDataAuditHeader] --Your Table Here
	(
		[PartnerID] [int] NOT NULL,
		[EffDate] [datetime] NOT NULL,
		[AuditGUID] [uniqueidentifier] NOT NULL,
		[CountryCode] [varchar] (2) NOT NULL,
		[Title] [nvarchar] (100) NOT NULL,
		[Description] [nvarchar] (250) NOT NULL,
		[DeletedFlag] [varchar] (1) NOT NULL,
		[KeepDuringRollback] [varchar] (1) NOT NULL 
	) ON [PRIMARY]
		
		CREATE CLUSTERED INDEX [CIX_tmgEntryDataAuditHeader] ON [dbo].[tmgEntryDataAuditHeader] --Your Table Here
		(
			[EffDate] ASC
		)

		ALTER TABLE [dbo].[tmgEntryDataAuditHeader] ADD CONSTRAINT [PK_tmgEntryDataAuditHeader] PRIMARY KEY NONCLUSTERED --Your Table Here
		(
			  [PartnerID] ASC,
			  [AuditGUID] ASC,
			  [CountryCode] ASC
		)
END


--We need to populate this table for any audits that are currently out there, it will be at max one per country.
--Use the AuditGUIDs generated in the ALTER script to add AuditGUID to all the other auditing tables to match up the GUIDs
INSERT INTO tmgEntryDataAuditHeader
SELECT a.PartnerID AS PartnerID, GETDATE() AS EffDate, a.AuditGUID AS AuditGUID, a.CountryCode AS CountryCode,
		a.CountryCode + ' Audit' AS Title, '' AS Description, 'N' AS DeletedFlag, 'N' AS KeepDuringRollback
FROM tmgEntryDataAudit a WITH (NOLOCK)
left join tmgEntryDataAuditHeader h with (nolock) on a.PartnerID = h.PartnerID and a.AuditGUID = h.AuditGUID and a.CountryCode = h.CountryCode
where h.partnerid is null
GROUP BY a.PartnerID, a.AuditGUID, a.CountryCode



--Create Hist table as well
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'tmgEntryDataAuditHeaderHist' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
	CREATE TABLE [dbo].[tmgEntryDataAuditHeaderHist] --Your Table Here
	(
		[PartnerID] [int] NOT NULL,
		[EffDate] [datetime] NOT NULL,
		[AuditGUID] [uniqueidentifier] NOT NULL,
		[CountryCode] [varchar] (2) NOT NULL,
		[Title] [nvarchar] (100) NOT NULL,
		[Description] [nvarchar] (250) NOT NULL,
		[DeletedFlag] [varchar] (1) NOT NULL,
		[KeepDuringRollback] [varchar] (1) NOT NULL 
	) ON [PRIMARY]
		
		CREATE CLUSTERED INDEX [CIX_tmgEntryDataAuditHeaderHist] ON [dbo].[tmgEntryDataAuditHeaderHist] --Your Table Here
		(
			[EffDate] ASC
		)

		ALTER TABLE [dbo].[tmgEntryDataAuditHeaderHist] ADD CONSTRAINT [PK_tmgEntryDataAuditHeaderHist] PRIMARY KEY NONCLUSTERED --Your Table Here
		(
			  [PartnerID] ASC,
			  [AuditGUID] ASC,
			  [CountryCode] ASC
		)
END