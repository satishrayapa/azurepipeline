PRINT N'Creating [dbo].[AllAttributionConfiguration]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'AllAttributionConfiguration' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[AllAttributionConfiguration] (
    [PartnerID]                      INT            NOT NULL,
    [EffDate]                        DATETIME       NOT NULL,
    [StepCategory]                   VARCHAR (255)  NOT NULL,
    [StepID]                         INT            NOT NULL,
    [StepName]                       VARCHAR (255)  NOT NULL,
    [AllowPartialShipmentAllocation] VARCHAR (1)    NOT NULL,
    [LayerUseWarning]                VARCHAR (1)    NOT NULL,
    [LayerUseWarningDescription]     VARCHAR (255)  NOT NULL,
    [ShipSQL]                        VARCHAR (2048) NOT NULL,
    [LayerSQL]                       VARCHAR (2048) NOT NULL
);
END


GO
PRINT N'Creating [dbo].[AllAttributionConfiguration].[CIX_AllAttributionConfiguration]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_AllAttributionConfiguration' AND object_id = object_id('AllAttributionConfiguration'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_AllAttributionConfiguration]
    ON [dbo].[AllAttributionConfiguration]([EffDate] ASC);
END


GO
PRINT N'Creating [dbo].[sheet2]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'sheet2' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[sheet2] (
    [PartnerID]           FLOAT (53)     NULL,
    [EffDate]             DATETIME       NULL,
    [Workflow]            NVARCHAR (255) NULL,
    [SequenceNo]          FLOAT (53)     NULL,
    [ApplicationToLaunch] NVARCHAR (255) NULL,
    [Command]             NVARCHAR (255) NULL,
    [KeepDuringRollback]  NVARCHAR (255) NULL,
    [DeletedFlag]         NVARCHAR (255) NULL
);
END


GO
PRINT N'Creating [dbo].[TEMP_INDEXES_Test]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'TEMP_INDEXES_Test' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[TEMP_INDEXES_Test] (
    [TableName]            [sysname]      NOT NULL,
    [IndexName]            [sysname]      NULL,
    [ColumnName]           [sysname]      NULL,
    [key_ordinal]          TINYINT        NOT NULL,
    [is_descending_key]    BIT            NULL,
    [is_included_column]   BIT            NULL,
    [allow_page_locks]     BIT            NULL,
    [allow_row_locks]      BIT            NULL,
    [fill_factor]          TINYINT        NOT NULL,
    [has_filter]           BIT            NULL,
    [filter_definition]    NVARCHAR (MAX) NULL,
    [is_primary_key]       BIT            NULL,
    [is_unique]            BIT            NULL,
    [is_unique_constraint] BIT            NULL,
    [type]                 TINYINT        NOT NULL,
    [type_desc]            NVARCHAR (60)  COLLATE Latin1_General_CI_AS_KS_WS NULL,
    [is_padded]            BIT            NULL,
    [is_disabled]          BIT            NULL,
    [ignore_dup_key]       BIT            NULL
);
END


GO
PRINT N'Creating [dbo].[TEMP_INDEXES_txdUSCargoReleaseDetailHist]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'TEMP_INDEXES_txdUSCargoReleaseDetailHist' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[TEMP_INDEXES_txdUSCargoReleaseDetailHist] (
    [TableName]            [sysname]      NOT NULL,
    [IndexName]            [sysname]      NULL,
    [ColumnName]           [sysname]      NULL,
    [key_ordinal]          TINYINT        NOT NULL,
    [is_descending_key]    BIT            NULL,
    [is_included_column]   BIT            NULL,
    [allow_page_locks]     BIT            NULL,
    [allow_row_locks]      BIT            NULL,
    [fill_factor]          TINYINT        NOT NULL,
    [has_filter]           BIT            NULL,
    [filter_definition]    NVARCHAR (MAX) NULL,
    [is_primary_key]       BIT            NULL,
    [is_unique]            BIT            NULL,
    [is_unique_constraint] BIT            NULL,
    [type]                 TINYINT        NOT NULL,
    [type_desc]            NVARCHAR (60)  COLLATE Latin1_General_CI_AS_KS_WS NULL,
    [is_padded]            BIT            NULL,
    [is_disabled]          BIT            NULL,
    [ignore_dup_key]       BIT            NULL
);
END


GO
PRINT N'Creating [dbo].[tmd_200021_DEProductClassificationSupplemental]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'tmd_200021_DEProductClassificationSupplemental' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[tmd_200021_DEProductClassificationSupplemental] (
    [PartnerID]          INT              NOT NULL,
    [EffDate]            DATETIME         NOT NULL,
    [ProductGuid]        UNIQUEIDENTIFIER NOT NULL,
    [RegionOfOrigin]     VARCHAR (2)      NOT NULL,
    [DeletedFlag]        VARCHAR (1)      NOT NULL,
    [KeepDuringRollback] VARCHAR (1)      NOT NULL,
    CONSTRAINT [PK_tmd_200021_DEProductClassificationSupplemental] PRIMARY KEY NONCLUSTERED ([ProductGuid] ASC)
);
END


GO
PRINT N'Creating [dbo].[tmd_200021_DEProductClassificationSupplemental].[CIX_tmd_200021_DEProductClassificationSupplemental]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_tmd_200021_DEProductClassificationSupplemental' AND object_id = object_id('tmd_200021_DEProductClassificationSupplemental'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
    if not exists (SELECT top 1 1 FROM sys.indexes i WHERE i.object_id = object_id('tmd_200021_DEProductClassificationSupplemental') and i.type_desc = 'CLUSTERED')
	BEGIN
		CREATE CLUSTERED INDEX [CIX_tmd_200021_DEProductClassificationSupplemental]
			ON [dbo].[tmd_200021_DEProductClassificationSupplemental]([EffDate] ASC);
	END
END


GO
PRINT N'Creating [dbo].[tmd_200021_DEProductClassificationSupplemental].[IX_tmd_200021_DEProductClassificationSupplemental_PKC]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='IX_tmd_200021_DEProductClassificationSupplemental_PKC' AND object_id = object_id('tmd_200021_DEProductClassificationSupplemental'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE NONCLUSTERED INDEX [IX_tmd_200021_DEProductClassificationSupplemental_PKC]
    ON [dbo].[tmd_200021_DEProductClassificationSupplemental]([ProductGuid] ASC)
    INCLUDE([EffDate], [PartnerID], [RegionOfOrigin]);
END


GO
PRINT N'Creating [dbo].[tmd_200021_NLProductClassificationSupplemental]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'tmd_200021_NLProductClassificationSupplemental' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[tmd_200021_NLProductClassificationSupplemental] (
    [PartnerID]          INT              NOT NULL,
    [EffDate]            DATETIME         NOT NULL,
    [ProductGuid]        UNIQUEIDENTIFIER NOT NULL,
    [RegionOfOrigin]     VARCHAR (2)      NOT NULL,
    [DeletedFlag]        VARCHAR (1)      NOT NULL,
    [KeepDuringRollback] VARCHAR (1)      NOT NULL,
    CONSTRAINT [PK_tmd_200021_NLProductClassificationSupplemental] PRIMARY KEY NONCLUSTERED ([ProductGuid] ASC)
);
END


GO
PRINT N'Creating [dbo].[tmd_200021_NLProductClassificationSupplemental].[CIX_tmd_200021_NLProductClassificationSupplemental]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_tmd_200021_NLProductClassificationSupplemental' AND object_id = object_id('tmd_200021_NLProductClassificationSupplemental'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
    if not exists (SELECT top 1 1 FROM sys.indexes i WHERE i.object_id = object_id('tmd_200021_NLProductClassificationSupplemental') and i.type_desc = 'CLUSTERED')
	BEGIN
		CREATE CLUSTERED INDEX [CIX_tmd_200021_NLProductClassificationSupplemental]
			ON [dbo].[tmd_200021_NLProductClassificationSupplemental]([EffDate] ASC);
	END
END


GO
PRINT N'Creating [dbo].[tmd_200021_NLProductClassificationSupplemental].[IX_tmd_200021_NLProductClassificationSupplemental_PKC]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='IX_tmd_200021_NLProductClassificationSupplemental_PKC' AND object_id = object_id('tmd_200021_NLProductClassificationSupplemental'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
    if not exists (SELECT top 1 1 FROM sys.indexes i WHERE i.object_id = object_id('tmd_200021_NLProductClassificationSupplemental') and i.type_desc = 'CLUSTERED')
	BEGIN
		CREATE NONCLUSTERED INDEX [IX_tmd_200021_NLProductClassificationSupplemental_PKC]
			ON [dbo].[tmd_200021_NLProductClassificationSupplemental]([ProductGuid] ASC)
			INCLUDE([EffDate], [PartnerID], [RegionOfOrigin]);
	END
END


GO
PRINT N'Creating [dbo].[tmd_200024_DEProductClassificationSupplemental]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'tmd_200024_DEProductClassificationSupplemental' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[tmd_200024_DEProductClassificationSupplemental] (
    [PartnerID]          INT              NOT NULL,
    [EffDate]            DATETIME         NOT NULL,
    [ProductGuid]        UNIQUEIDENTIFIER NOT NULL,
    [RegionOfOrigin]     VARCHAR (2)      NOT NULL,
    [DeletedFlag]        VARCHAR (1)      NOT NULL,
    [KeepDuringRollback] VARCHAR (1)      NOT NULL,
    CONSTRAINT [PK_tmd_200024_DEProductClassificationSupplemental] PRIMARY KEY NONCLUSTERED ([ProductGuid] ASC)
);
END


GO
PRINT N'Creating [dbo].[tmd_200024_DEProductClassificationSupplemental].[CIX_tmd_200024_DEProductClassificationSupplemental]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_tmd_200024_DEProductClassificationSupplemental' AND object_id = object_id('tmd_200024_DEProductClassificationSupplemental'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
    if not exists (SELECT top 1 1 FROM sys.indexes i WHERE i.object_id = object_id('tmd_200024_DEProductClassificationSupplemental') and i.type_desc = 'CLUSTERED')
	BEGIN
		CREATE CLUSTERED INDEX [CIX_tmd_200024_DEProductClassificationSupplemental]
			ON [dbo].[tmd_200024_DEProductClassificationSupplemental]([EffDate] ASC);
	END
END


GO
PRINT N'Creating [dbo].[tmd_200024_DEProductClassificationSupplemental].[IX_tmd_200024_DEProductClassificationSupplemental_PKC]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='IX_tmd_200024_DEProductClassificationSupplemental_PKC' AND object_id = object_id('tmd_200024_DEProductClassificationSupplemental'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE NONCLUSTERED INDEX [IX_tmd_200024_DEProductClassificationSupplemental_PKC]
    ON [dbo].[tmd_200024_DEProductClassificationSupplemental]([ProductGuid] ASC)
    INCLUDE([EffDate], [PartnerID], [RegionOfOrigin]);
END


GO
PRINT N'Creating [dbo].[tmd_200025_NLProductClassificationSupplemental]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'tmd_200025_NLProductClassificationSupplemental' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[tmd_200025_NLProductClassificationSupplemental] (
    [PartnerID]          INT              NOT NULL,
    [EffDate]            DATETIME         NOT NULL,
    [ProductGuid]        UNIQUEIDENTIFIER NOT NULL,
    [RegionOfOrigin]     VARCHAR (2)      NOT NULL,
    [DeletedFlag]        VARCHAR (1)      NOT NULL,
    [KeepDuringRollback] VARCHAR (1)      NOT NULL,
    CONSTRAINT [PK_tmd_200025_NLProductClassificationSupplemental] PRIMARY KEY NONCLUSTERED ([ProductGuid] ASC)
);
END


GO
PRINT N'Creating [dbo].[tmd_200025_NLProductClassificationSupplemental].[CIX_tmd_200025_NLProductClassificationSupplemental]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_tmd_200025_NLProductClassificationSupplemental' AND object_id = object_id('tmd_200025_NLProductClassificationSupplemental'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
    if not exists (SELECT top 1 1 FROM sys.indexes i WHERE i.object_id = object_id('tmd_200025_NLProductClassificationSupplemental') and i.type_desc = 'CLUSTERED')
	BEGIN
		CREATE CLUSTERED INDEX [CIX_tmd_200025_NLProductClassificationSupplemental]
			ON [dbo].[tmd_200025_NLProductClassificationSupplemental]([EffDate] ASC);
	end
END


GO
PRINT N'Creating [dbo].[tmd_200025_NLProductClassificationSupplemental].[IX_tmd_200025_NLProductClassificationSupplemental_PKC]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='IX_tmd_200025_NLProductClassificationSupplemental_PKC' AND object_id = object_id('tmd_200025_NLProductClassificationSupplemental'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE NONCLUSTERED INDEX [IX_tmd_200025_NLProductClassificationSupplemental_PKC]
    ON [dbo].[tmd_200025_NLProductClassificationSupplemental]([ProductGuid] ASC)
    INCLUDE([EffDate], [PartnerID], [RegionOfOrigin]);
END


GO
PRINT N'Creating [dbo].[tmd_200026_DEProductClassificationSupplemental]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'tmd_200026_DEProductClassificationSupplemental' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[tmd_200026_DEProductClassificationSupplemental] (
    [PartnerID]          INT              NOT NULL,
    [EffDate]            DATETIME         NOT NULL,
    [ProductGuid]        UNIQUEIDENTIFIER NOT NULL,
    [RegionOfOrigin]     VARCHAR (2)      NOT NULL,
    [DeletedFlag]        VARCHAR (1)      NOT NULL,
    [KeepDuringRollback] VARCHAR (1)      NOT NULL,
    CONSTRAINT [PK_tmd_200026_DEProductClassificationSupplemental] PRIMARY KEY NONCLUSTERED ([ProductGuid] ASC)
);
END


GO
PRINT N'Creating [dbo].[tmd_200026_DEProductClassificationSupplemental].[CIX_tmd_200026_DEProductClassificationSupplemental]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_tmd_200026_DEProductClassificationSupplemental' AND object_id = object_id('tmd_200026_DEProductClassificationSupplemental'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
    if not exists (SELECT top 1 1 FROM sys.indexes i WHERE i.object_id = object_id('tmd_200026_DEProductClassificationSupplemental') and i.type_desc = 'CLUSTERED')
	BEGIN
		CREATE CLUSTERED INDEX [CIX_tmd_200026_DEProductClassificationSupplemental]
			ON [dbo].[tmd_200026_DEProductClassificationSupplemental]([EffDate] ASC);
	end
END


GO
PRINT N'Creating [dbo].[tmd_200026_DEProductClassificationSupplemental].[IX_tmd_200026_DEProductClassificationSupplemental_PKC]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='IX_tmd_200026_DEProductClassificationSupplemental_PKC' AND object_id = object_id('tmd_200026_DEProductClassificationSupplemental'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE NONCLUSTERED INDEX [IX_tmd_200026_DEProductClassificationSupplemental_PKC]
    ON [dbo].[tmd_200026_DEProductClassificationSupplemental]([ProductGuid] ASC)
    INCLUDE([EffDate], [PartnerID], [RegionOfOrigin]);
END


GO
PRINT N'Creating [dbo].[tmdContentSubscriptionExtract]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'tmdContentSubscriptionExtract' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[tmdContentSubscriptionExtract] (
    [PartnerID]                 INT           NOT NULL,
    [EffDate]                   DATETIME      NOT NULL,
    [ProdClassificationGuid]    VARCHAR (50)  NOT NULL,
    [ProdClassificationName]    VARCHAR (200) NOT NULL,
    [CountryGroupGuid]          VARCHAR (50)  NULL,
    [CountryGroupCode]          VARCHAR (20)  NULL,
    [CountryCode]               VARCHAR (20)  NULL,
    [ExtractType]               VARCHAR (50)  NULL,
    [QueueGUID]                 VARCHAR (50)  NULL,
    [ExtractStatus]             VARCHAR (50)  NULL,
    [ExtractPriority]           VARCHAR (10)  NULL,
    [ExtractRequestDate]        DATETIME      NULL,
    [ExtractItemEffectiveDate]  DATETIME      NULL,
    [ExtractItemExpirationDate] DATETIME      NULL,
    [QueueEffectiveDate]        DATETIME      NULL,
    [QueueExpirationDate]       DATETIME      NULL,
    [DailyExtractEnabled]       VARCHAR (1)   NULL,
    [DeletedFlag]               VARCHAR (1)   NOT NULL,
    [KeepDuringRollback]        VARCHAR (1)   NOT NULL
);
END


GO
PRINT N'Creating [dbo].[tmdFullBindingRulingsExtractToday]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'tmdFullBindingRulingsExtractToday' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[tmdFullBindingRulingsExtractToday] (
    [BindingRulingGUID]          VARCHAR (50)   NOT NULL,
    [ProdClassificationGUID]     VARCHAR (50)   NOT NULL,
    [EffectivityDate]            DATETIME       NOT NULL,
    [ExpirationDate]             DATETIME       NOT NULL,
    [BindingRulingReferenceCode] VARCHAR (1000) NOT NULL,
    [IssueCountry]               VARCHAR (5)    NOT NULL,
    [Number]                     VARCHAR (50)   NOT NULL,
    [DescriptionType]            VARCHAR (50)   NOT NULL,
    [CultureCode]                VARCHAR (3)    NOT NULL,
    [Description]                NVARCHAR (MAX) NOT NULL,
    [BindingRulingType]          VARCHAR (500)  NOT NULL,
    [HashSum]                    VARBINARY (42) NULL
);
END


GO
PRINT N'Creating [dbo].[tmdFullBindingRulingsExtractToday].[CIX_tmdFullBindingRulingsExtractToday]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_tmdFullBindingRulingsExtractToday' AND object_id = object_id('tmdFullBindingRulingsExtractToday'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_tmdFullBindingRulingsExtractToday]
    ON [dbo].[tmdFullBindingRulingsExtractToday]([BindingRulingGUID] ASC, [ProdClassificationGUID] ASC, [IssueCountry] ASC, [Number] ASC, [DescriptionType] ASC, [CultureCode] ASC);
END


GO
PRINT N'Creating [dbo].[tmdFullBindingRulingsExtractYesterday]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'tmdFullBindingRulingsExtractYesterday' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[tmdFullBindingRulingsExtractYesterday] (
    [BindingRulingGUID]          VARCHAR (50)   NOT NULL,
    [ProdClassificationGUID]     VARCHAR (50)   NOT NULL,
    [EffectivityDate]            DATETIME       NOT NULL,
    [ExpirationDate]             DATETIME       NOT NULL,
    [BindingRulingReferenceCode] VARCHAR (1000) NOT NULL,
    [IssueCountry]               VARCHAR (5)    NOT NULL,
    [Number]                     VARCHAR (50)   NOT NULL,
    [DescriptionType]            VARCHAR (50)   NOT NULL,
    [CultureCode]                VARCHAR (3)    NOT NULL,
    [Description]                NVARCHAR (MAX) NOT NULL,
    [BindingRulingType]          VARCHAR (500)  NOT NULL,
    [HashSum]                    VARBINARY (42) NULL
);
END


GO
PRINT N'Creating [dbo].[tmdFullBindingRulingsExtractYesterday].[CIX_tmdFullBindingRulingsExtractYesterday]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_tmdFullBindingRulingsExtractYesterday' AND object_id = object_id('tmdFullBindingRulingsExtractYesterday'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_tmdFullBindingRulingsExtractYesterday]
    ON [dbo].[tmdFullBindingRulingsExtractYesterday]([BindingRulingGUID] ASC, [ProdClassificationGUID] ASC, [IssueCountry] ASC, [Number] ASC, [DescriptionType] ASC, [CultureCode] ASC);
END


GO
PRINT N'Creating [dbo].[tmdFullCommercialDocumentsExtractToday]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'tmdFullCommercialDocumentsExtractToday' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[tmdFullCommercialDocumentsExtractToday] (
    [Country]             VARCHAR (20)   NOT NULL,
    [ImportCountryCode]   VARCHAR (20)   NOT NULL,
    [ExportCountryCode]   VARCHAR (20)   NOT NULL,
    [DocumentTransaction] VARCHAR (50)   NOT NULL,
    [DocumentType]        VARCHAR (50)   NOT NULL,
    [DocumentName]        NVARCHAR (300) NOT NULL,
    [Requirement]         VARCHAR (50)   NOT NULL,
    [Description]         NVARCHAR (MAX) NOT NULL,
    [Identifier1]         VARCHAR (50)   NOT NULL,
    [Identifier3]         VARCHAR (50)   NOT NULL,
    [Link]                NVARCHAR (MAX) NOT NULL,
    [EffectivityDate]     DATETIME       NOT NULL,
    [ExpirationDate]      DATETIME       NOT NULL,
    [HashSum]             VARBINARY (42) NULL
);
END


GO
PRINT N'Creating [dbo].[tmdFullCommercialDocumentsExtractToday].[CIX_tmdFullCommercialDocumentsExtractToday]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_tmdFullCommercialDocumentsExtractToday' AND object_id = object_id('tmdFullCommercialDocumentsExtractToday'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_tmdFullCommercialDocumentsExtractToday]
    ON [dbo].[tmdFullCommercialDocumentsExtractToday]([Country] ASC, [DocumentTransaction] ASC, [DocumentType] ASC, [DocumentName] ASC, [Identifier1] ASC);
END


GO
PRINT N'Creating [dbo].[tmdFullCommercialDocumentsExtractYesterday]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'tmdFullCommercialDocumentsExtractYesterday' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[tmdFullCommercialDocumentsExtractYesterday] (
    [Country]             VARCHAR (20)   NOT NULL,
    [ImportCountryCode]   VARCHAR (20)   NOT NULL,
    [ExportCountryCode]   VARCHAR (20)   NOT NULL,
    [DocumentTransaction] VARCHAR (50)   NOT NULL,
    [DocumentType]        VARCHAR (50)   NOT NULL,
    [DocumentName]        NVARCHAR (300) NOT NULL,
    [Requirement]         VARCHAR (50)   NOT NULL,
    [Description]         NVARCHAR (MAX) NOT NULL,
    [Identifier1]         VARCHAR (50)   NOT NULL,
    [Identifier3]         VARCHAR (50)   NOT NULL,
    [Link]                NVARCHAR (MAX) NOT NULL,
    [EffectivityDate]     DATETIME       NOT NULL,
    [ExpirationDate]      DATETIME       NOT NULL,
    [HashSum]             VARBINARY (42) NULL
);
END


GO
PRINT N'Creating [dbo].[tmdFullCommercialDocumentsExtractYesterday].[CIX_tmdFullCommercialDocumentsExtractYesterday]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_tmdFullCommercialDocumentsExtractYesterday' AND object_id = object_id('tmdFullCommercialDocumentsExtractYesterday'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_tmdFullCommercialDocumentsExtractYesterday]
    ON [dbo].[tmdFullCommercialDocumentsExtractYesterday]([Country] ASC, [DocumentTransaction] ASC, [DocumentType] ASC, [DocumentName] ASC, [Identifier1] ASC);
END


GO
PRINT N'Creating [dbo].[tmdFullCountryGroupCodeExtractToday]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'tmdFullCountryGroupCodeExtractToday' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[tmdFullCountryGroupCodeExtractToday] (
    [CountryGroupGUID] VARCHAR (50)   NOT NULL,
    [CountryGroupCode] VARCHAR (20)   NOT NULL,
    [CountryCode]      VARCHAR (3)    NOT NULL,
    [Allowable]        VARCHAR (1)    NOT NULL,
    [EffectivityDate]  DATETIME       NOT NULL,
    [ExpirationDate]   DATETIME       NOT NULL,
    [HashSum]          VARBINARY (42) NULL
);
END


GO
PRINT N'Creating [dbo].[tmdFullCountryGroupCodeExtractToday].[CIX_tmdFullCountryGroupCodeExtractToday]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_tmdFullCountryGroupCodeExtractToday' AND object_id = object_id('tmdFullCountryGroupCodeExtractToday'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_tmdFullCountryGroupCodeExtractToday]
    ON [dbo].[tmdFullCountryGroupCodeExtractToday]([CountryGroupGUID] ASC, [CountryGroupCode] ASC, [CountryCode] ASC);
END


GO
PRINT N'Creating [dbo].[tmdFullCountryGroupCodeExtractYesterday]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'tmdFullCountryGroupCodeExtractYesterday' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[tmdFullCountryGroupCodeExtractYesterday] (
    [CountryGroupGUID] VARCHAR (50)   NOT NULL,
    [CountryGroupCode] VARCHAR (20)   NOT NULL,
    [CountryCode]      VARCHAR (3)    NOT NULL,
    [Allowable]        VARCHAR (1)    NOT NULL,
    [EffectivityDate]  DATETIME       NOT NULL,
    [ExpirationDate]   DATETIME       NOT NULL,
    [HashSum]          VARBINARY (42) NULL
);
END


GO
PRINT N'Creating [dbo].[tmdFullCountryGroupCodeExtractYesterday].[CIX_tmdFullCountryGroupCodeExtractYesterday]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_tmdFullCountryGroupCodeExtractYesterday' AND object_id = object_id('tmdFullCountryGroupCodeExtractYesterday'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_tmdFullCountryGroupCodeExtractYesterday]
    ON [dbo].[tmdFullCountryGroupCodeExtractYesterday]([CountryGroupGUID] ASC, [CountryGroupCode] ASC, [CountryCode] ASC);
END


GO
PRINT N'Creating [dbo].[tmdFullDPSSanctionsExtractToday]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'tmdFullDPSSanctionsExtractToday' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[tmdFullDPSSanctionsExtractToday] (
    [RegListId]           INT            NOT NULL,
    [RegListName]         VARCHAR (100)  NOT NULL,
    [RegulatoryCountry]   VARCHAR (2)    NOT NULL,
    [RegEntityID]         INT            NOT NULL,
    [AltFullName]         NVARCHAR (350) NOT NULL,
    [SanctionedCountry]   VARCHAR (2)    NOT NULL,
    [RegEntityStatusDate] DATETIME       NOT NULL,
    [RegEntityExpDate]    DATETIME       NOT NULL,
    [Reason]              VARCHAR (300)  NOT NULL,
    [Website]             VARCHAR (300)  NOT NULL,
    [ReasonDate]          DATETIME       NOT NULL,
    [ReasonExpDate]       DATETIME       NOT NULL,
    [HashSum]             VARBINARY (42) NULL
);
END


GO
PRINT N'Creating [dbo].[tmdFullDPSSanctionsExtractToday].[CIX_tmdFullDPSSanctionsExtractToday]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_tmdFullDPSSanctionsExtractToday' AND object_id = object_id('tmdFullDPSSanctionsExtractToday'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_tmdFullDPSSanctionsExtractToday]
    ON [dbo].[tmdFullDPSSanctionsExtractToday]([RegListId] ASC, [RegEntityID] ASC, [Reason] ASC);
END


GO
PRINT N'Creating [dbo].[tmdFullDPSSanctionsExtractYesterday]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'tmdFullDPSSanctionsExtractYesterday' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[tmdFullDPSSanctionsExtractYesterday] (
    [RegListId]           INT            NOT NULL,
    [RegListName]         VARCHAR (100)  NOT NULL,
    [RegulatoryCountry]   VARCHAR (2)    NOT NULL,
    [RegEntityID]         INT            NOT NULL,
    [AltFullName]         NVARCHAR (350) NOT NULL,
    [SanctionedCountry]   VARCHAR (2)    NOT NULL,
    [RegEntityStatusDate] DATETIME       NOT NULL,
    [RegEntityExpDate]    DATETIME       NOT NULL,
    [Reason]              VARCHAR (300)  NOT NULL,
    [Website]             VARCHAR (300)  NOT NULL,
    [ReasonDate]          DATETIME       NOT NULL,
    [ReasonExpDate]       DATETIME       NOT NULL,
    [HashSum]             VARBINARY (42) NULL
);
END


GO
PRINT N'Creating [dbo].[tmdFullDPSSanctionsExtractYesterday].[CIX_tmdFullDPSSanctionsExtractYesterday]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_tmdFullDPSSanctionsExtractYesterday' AND object_id = object_id('tmdFullDPSSanctionsExtractYesterday'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_tmdFullDPSSanctionsExtractYesterday]
    ON [dbo].[tmdFullDPSSanctionsExtractYesterday]([RegListId] ASC, [RegEntityID] ASC, [Reason] ASC);
END


GO
PRINT N'Creating [dbo].[tmdFullECNControlReasonsExtractToday]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'tmdFullECNControlReasonsExtractToday' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[tmdFullECNControlReasonsExtractToday] (
    [RegListId]               INT             NOT NULL,
    [RegListDetailNum]        VARCHAR (50)    NOT NULL,
    [GroupCodeName]           VARCHAR (40)    NOT NULL,
    [ProductGroupDescription] NVARCHAR (1250) NOT NULL,
    [RegEffDate]              DATETIME        NOT NULL,
    [RegExpDate]              DATETIME        NOT NULL,
    [HashSum]                 VARBINARY (42)  NULL
);
END


GO
PRINT N'Creating [dbo].[tmdFullECNControlReasonsExtractToday].[CIX_tmdFullECNControlReasonsExtractToday]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_tmdFullECNControlReasonsExtractToday' AND object_id = object_id('tmdFullECNControlReasonsExtractToday'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_tmdFullECNControlReasonsExtractToday]
    ON [dbo].[tmdFullECNControlReasonsExtractToday]([RegListId] ASC, [RegListDetailNum] ASC, [GroupCodeName] ASC);
END


GO
PRINT N'Creating [dbo].[tmdFullECNControlReasonsExtractYesterday]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'tmdFullECNControlReasonsExtractYesterday' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[tmdFullECNControlReasonsExtractYesterday] (
    [RegListId]               INT             NOT NULL,
    [RegListDetailNum]        VARCHAR (50)    NOT NULL,
    [GroupCodeName]           VARCHAR (40)    NOT NULL,
    [ProductGroupDescription] NVARCHAR (1250) NOT NULL,
    [RegEffDate]              DATETIME        NOT NULL,
    [RegExpDate]              DATETIME        NOT NULL,
    [HashSum]                 VARBINARY (42)  NULL
);
END


GO
PRINT N'Creating [dbo].[tmdFullECNControlReasonsExtractYesterday].[CIX_tmdFullECNControlReasonsExtractYesterday]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_tmdFullECNControlReasonsExtractYesterday' AND object_id = object_id('tmdFullECNControlReasonsExtractYesterday'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_tmdFullECNControlReasonsExtractYesterday]
    ON [dbo].[tmdFullECNControlReasonsExtractYesterday]([RegListId] ASC, [RegListDetailNum] ASC, [GroupCodeName] ASC);
END


GO
PRINT N'Creating [dbo].[tmdFullECNExtractToday]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'tmdFullECNExtractToday' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[tmdFullECNExtractToday] (
    [RegListID]                         INT             NOT NULL,
    [CategoryID]                        INT             NOT NULL,
    [RegDenyID]                         INT             NOT NULL,
    [RegProductExceptionID]             INT             NOT NULL,
    [RegListName]                       VARCHAR (100)   NOT NULL,
    [Description]                       VARCHAR (1000)  NOT NULL,
    [Organization]                      VARCHAR (250)   NOT NULL,
    [RegCategoryID]                     VARCHAR (12)    NOT NULL,
    [CategoryName]                      VARCHAR (100)   NOT NULL,
    [SortOrder]                         INT             NOT NULL,
    [CategoryEffDate]                   DATETIME        NOT NULL,
    [CategoryExpDate]                   DATETIME        NOT NULL,
    [CategoryModifyDate]                DATETIME        NOT NULL,
    [RegListDetailNum]                  VARCHAR (50)    NOT NULL,
    [Denial]                            NVARCHAR (4000) NOT NULL,
    [RegEffDate]                        DATETIME        NOT NULL,
    [RegExpDate]                        DATETIME        NOT NULL,
    [ModifyDate]                        DATETIME        NOT NULL,
    [RegProductExceptionCode]           VARCHAR (50)    NOT NULL,
    [RegProductExceptionNote]           NVARCHAR (MAX)  NULL,
    [RegProductExceptionNoteEffDate]    DATETIME        NOT NULL,
    [RegProductExceptionNoteExpDate]    DATETIME        NOT NULL,
    [RegProductExceptionNoteModifyDate] DATETIME        NOT NULL,
    [CountryCode]                       VARCHAR (2)     NOT NULL,
    [ListCountryEffectiveDate]          DATETIME        NOT NULL,
    [ListCountryExpirationDate]         DATETIME        NOT NULL,
    [CountryModifyDate]                 DATETIME        NOT NULL,
    [HashSum]                           VARBINARY (42)  NULL
);
END


GO
PRINT N'Creating [dbo].[tmdFullECNExtractToday].[CIX_tmdFullECNExtractToday]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_tmdFullECNExtractToday' AND object_id = object_id('tmdFullECNExtractToday'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_tmdFullECNExtractToday]
    ON [dbo].[tmdFullECNExtractToday]([RegListID] ASC, [CategoryID] ASC, [RegDenyID] ASC, [RegProductExceptionID] ASC);
END


GO
PRINT N'Creating [dbo].[tmdFullECNExtractYesterday]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'tmdFullECNExtractYesterday' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[tmdFullECNExtractYesterday] (
    [RegListID]                         INT             NOT NULL,
    [CategoryID]                        INT             NOT NULL,
    [RegDenyID]                         INT             NOT NULL,
    [RegProductExceptionID]             INT             NOT NULL,
    [RegListName]                       VARCHAR (100)   NOT NULL,
    [Description]                       VARCHAR (1000)  NOT NULL,
    [Organization]                      VARCHAR (250)   NOT NULL,
    [RegCategoryID]                     VARCHAR (12)    NOT NULL,
    [CategoryName]                      VARCHAR (100)   NOT NULL,
    [SortOrder]                         INT             NOT NULL,
    [CategoryEffDate]                   DATETIME        NOT NULL,
    [CategoryExpDate]                   DATETIME        NOT NULL,
    [CategoryModifyDate]                DATETIME        NOT NULL,
    [RegListDetailNum]                  VARCHAR (50)    NOT NULL,
    [Denial]                            NVARCHAR (4000) NOT NULL,
    [RegEffDate]                        DATETIME        NOT NULL,
    [RegExpDate]                        DATETIME        NOT NULL,
    [ModifyDate]                        DATETIME        NOT NULL,
    [RegProductExceptionCode]           VARCHAR (50)    NOT NULL,
    [RegProductExceptionNote]           NVARCHAR (MAX)  NULL,
    [RegProductExceptionNoteEffDate]    DATETIME        NOT NULL,
    [RegProductExceptionNoteExpDate]    DATETIME        NOT NULL,
    [RegProductExceptionNoteModifyDate] DATETIME        NOT NULL,
    [CountryCode]                       VARCHAR (2)     NOT NULL,
    [ListCountryEffectiveDate]          DATETIME        NOT NULL,
    [ListCountryExpirationDate]         DATETIME        NOT NULL,
    [CountryModifyDate]                 DATETIME        NOT NULL,
    [HashSum]                           VARBINARY (42)  NOT NULL
);
END


GO
PRINT N'Creating [dbo].[tmdFullECNExtractYesterday].[CIX_tmdFullECNExtractYesterday]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_tmdFullECNExtractYesterday' AND object_id = object_id('tmdFullECNExtractYesterday'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_tmdFullECNExtractYesterday]
    ON [dbo].[tmdFullECNExtractYesterday]([RegListID] ASC, [CategoryID] ASC, [RegDenyID] ASC, [RegProductExceptionID] ASC);
END


GO
PRINT N'Creating [dbo].[tmdFullECNRegulationGroupsExtractToday]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'tmdFullECNRegulationGroupsExtractToday' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[tmdFullECNRegulationGroupsExtractToday] (
    [RegListId]        INT            NOT NULL,
    [GroupCodeName]    VARCHAR (40)   NOT NULL,
    [GroupDescription] NVARCHAR (500) NOT NULL,
    [Allowable]        VARCHAR (1)    NOT NULL,
    [CountryCode]      VARCHAR (2)    NOT NULL,
    [RegEffDate]       DATETIME       NOT NULL,
    [RegExpDate]       DATETIME       NOT NULL,
    [HashSum]          VARBINARY (42) NULL
);
END


GO
PRINT N'Creating [dbo].[tmdFullECNRegulationGroupsExtractToday].[CIX_tmdFullECNRegulationGroupsExtractToday]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_tmdFullECNRegulationGroupsExtractToday' AND object_id = object_id('tmdFullECNRegulationGroupsExtractToday'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_tmdFullECNRegulationGroupsExtractToday]
    ON [dbo].[tmdFullECNRegulationGroupsExtractToday]([RegListId] ASC, [GroupCodeName] ASC);
END


GO
PRINT N'Creating [dbo].[tmdFullECNRegulationGroupsExtractYesterday]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'tmdFullECNRegulationGroupsExtractYesterday' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[tmdFullECNRegulationGroupsExtractYesterday] (
    [RegListId]        INT            NOT NULL,
    [GroupCodeName]    VARCHAR (40)   NOT NULL,
    [GroupDescription] NVARCHAR (500) NOT NULL,
    [Allowable]        VARCHAR (1)    NOT NULL,
    [CountryCode]      VARCHAR (2)    NOT NULL,
    [RegEffDate]       DATETIME       NOT NULL,
    [RegExpDate]       DATETIME       NOT NULL,
    [HashSum]          VARBINARY (42) NULL
);
END


GO
PRINT N'Creating [dbo].[tmdFullECNRegulationGroupsExtractYesterday].[CIX_tmdFullECNRegulationGroupsExtractYesterday]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_tmdFullECNRegulationGroupsExtractYesterday' AND object_id = object_id('tmdFullECNRegulationGroupsExtractYesterday'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_tmdFullECNRegulationGroupsExtractYesterday]
    ON [dbo].[tmdFullECNRegulationGroupsExtractYesterday]([RegListId] ASC, [GroupCodeName] ASC);
END


GO
PRINT N'Creating [dbo].[tmdFullHSDescUOMExtractToday]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'tmdFullHSDescUOMExtractToday' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[tmdFullHSDescUOMExtractToday] (
    [ProdClassificationDetailGUID] VARCHAR (50)   NOT NULL,
    [ProdClassificationGUID]       VARCHAR (50)   NOT NULL,
    [Number]                       NVARCHAR (50)  NOT NULL,
    [CustomsDeclarable]            VARCHAR (1)    NOT NULL,
    [SortOrder]                    INT            NOT NULL,
    [CultureCode]                  VARCHAR (3)    NOT NULL,
    [Description]                  NVARCHAR (MAX) NOT NULL,
    [UOM1]                         VARCHAR (100)  NOT NULL,
    [UOM2]                         VARCHAR (100)  NOT NULL,
    [UOM3]                         VARCHAR (100)  NOT NULL,
    [EffectivityDate]              DATETIME       NOT NULL,
    [ExpirationDate]               DATETIME       NOT NULL,
    [InactivatedDate]              DATETIME       NOT NULL,
    [HashSum]                      VARBINARY (42) NULL
);
END


GO
PRINT N'Creating [dbo].[tmdFullHSDescUOMExtractToday].[CIX_tmdFullHSDescUOMExtractToday]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_tmdFullHSDescUOMExtractToday' AND object_id = object_id('tmdFullHSDescUOMExtractToday'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_tmdFullHSDescUOMExtractToday]
    ON [dbo].[tmdFullHSDescUOMExtractToday]([ProdClassificationDetailGUID] ASC, [ProdClassificationGUID] ASC, [Number] ASC) WITH (FILLFACTOR = 75);
END


GO
PRINT N'Creating [dbo].[tmdFullHSDescUOMExtractYesterday]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'tmdFullHSDescUOMExtractYesterday' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[tmdFullHSDescUOMExtractYesterday] (
    [ProdClassificationDetailGUID] VARCHAR (50)   NOT NULL,
    [ProdClassificationGUID]       VARCHAR (50)   NOT NULL,
    [Number]                       NVARCHAR (50)  NOT NULL,
    [CustomsDeclarable]            VARCHAR (1)    NOT NULL,
    [SortOrder]                    INT            NOT NULL,
    [CultureCode]                  VARCHAR (3)    NOT NULL,
    [Description]                  NVARCHAR (MAX) NOT NULL,
    [UOM1]                         VARCHAR (100)  NOT NULL,
    [UOM2]                         VARCHAR (100)  NOT NULL,
    [UOM3]                         VARCHAR (100)  NOT NULL,
    [EffectivityDate]              DATETIME       NOT NULL,
    [ExpirationDate]               DATETIME       NOT NULL,
    [InactivatedDate]              DATETIME       NOT NULL,
    [HashSum]                      VARBINARY (42) NULL
);
END


GO
PRINT N'Creating [dbo].[tmdFullHSDescUOMExtractYesterday].[CIX_tmdFullHSDescUOMExtractYesterday]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_tmdFullHSDescUOMExtractYesterday' AND object_id = object_id('tmdFullHSDescUOMExtractYesterday'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_tmdFullHSDescUOMExtractYesterday]
    ON [dbo].[tmdFullHSDescUOMExtractYesterday]([ProdClassificationDetailGUID] ASC, [ProdClassificationGUID] ASC, [Number] ASC) WITH (FILLFACTOR = 75);
END


GO
PRINT N'Creating [dbo].[tmdFullRelatedControlsExtractToday]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'tmdFullRelatedControlsExtractToday' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[tmdFullRelatedControlsExtractToday] (
    [ProdClassificationGUID]         VARCHAR (50)   NOT NULL,
    [ProdClassificationName]         VARCHAR (50)   NOT NULL,
    [ControlCountry]                 NVARCHAR (50)  NOT NULL,
    [Number]                         NVARCHAR (50)  NOT NULL,
    [Control]                        NVARCHAR (50)  NOT NULL,
    [ControlType]                    NVARCHAR (50)  NOT NULL,
    [CultureCode]                    VARCHAR (3)    NOT NULL,
    [TranslationValue]               NVARCHAR (MAX) NOT NULL,
    [EffectivityDate]                DATETIME       NOT NULL,
    [ExpirationDate]                 DATETIME       NOT NULL,
    [AgencyCultureCode]              VARCHAR (3)    NOT NULL,
    [AgencyCode]                     VARCHAR (50)   NOT NULL,
    [AgencyDescription]              NVARCHAR (MAX) NOT NULL,
    [CountryIsExcluded]              VARCHAR (1)    NOT NULL,
    [ApplicableCountryCode]          NVARCHAR (MAX) NOT NULL,
    [CountrySpecificEffectivityDate] VARCHAR (50)   NOT NULL,
    [CountrySpecificExpirationDate]  VARCHAR (50)   NOT NULL,
    [HashSum]                        VARBINARY (42) NULL
);
END


GO
PRINT N'Creating [dbo].[tmdFullRelatedControlsExtractToday].[CIX_tmdFullRelatedControlsExtractToday]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_tmdFullRelatedControlsExtractToday' AND object_id = object_id('tmdFullRelatedControlsExtractToday'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_tmdFullRelatedControlsExtractToday]
    ON [dbo].[tmdFullRelatedControlsExtractToday]([ProdClassificationGUID] ASC, [ControlType] ASC, [Number] ASC, [CultureCode] ASC, [AgencyCultureCode] ASC);
END


GO
PRINT N'Creating [dbo].[tmdFullRelatedControlsExtractToday].[IX_tmdFullRelatedControlsExtractToday_GUIDsNumber]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='IX_tmdFullRelatedControlsExtractToday_GUIDsNumber' AND object_id = object_id('tmdFullRelatedControlsExtractToday'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE NONCLUSTERED INDEX [IX_tmdFullRelatedControlsExtractToday_GUIDsNumber]
    ON [dbo].[tmdFullRelatedControlsExtractToday]([ProdClassificationGUID] ASC, [Number] ASC);
END


GO
PRINT N'Creating [dbo].[tmdFullRelatedControlsExtractYesterday]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'tmdFullRelatedControlsExtractYesterday' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[tmdFullRelatedControlsExtractYesterday] (
    [ProdClassificationGUID]         VARCHAR (50)   NOT NULL,
    [ProdClassificationName]         VARCHAR (50)   NOT NULL,
    [ControlCountry]                 NVARCHAR (50)  NOT NULL,
    [Number]                         NVARCHAR (50)  NOT NULL,
    [Control]                        NVARCHAR (50)  NOT NULL,
    [ControlType]                    NVARCHAR (50)  NOT NULL,
    [CultureCode]                    VARCHAR (3)    NOT NULL,
    [TranslationValue]               NVARCHAR (MAX) NOT NULL,
    [EffectivityDate]                DATETIME       NOT NULL,
    [ExpirationDate]                 DATETIME       NOT NULL,
    [AgencyCultureCode]              VARCHAR (3)    NOT NULL,
    [AgencyCode]                     VARCHAR (50)   NOT NULL,
    [AgencyDescription]              NVARCHAR (MAX) NOT NULL,
    [CountryIsExcluded]              VARCHAR (1)    NOT NULL,
    [ApplicableCountryCode]          NVARCHAR (MAX) NOT NULL,
    [CountrySpecificEffectivityDate] VARCHAR (50)   NOT NULL,
    [CountrySpecificExpirationDate]  VARCHAR (50)   NOT NULL,
    [HashSum]                        VARBINARY (42) NULL
);
END


GO
PRINT N'Creating [dbo].[tmdFullRelatedControlsExtractYesterday].[CIX_tmdFullRelatedControlsExtractYesterday]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_tmdFullRelatedControlsExtractYesterday' AND object_id = object_id('tmdFullRelatedControlsExtractYesterday'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_tmdFullRelatedControlsExtractYesterday]
    ON [dbo].[tmdFullRelatedControlsExtractYesterday]([ProdClassificationGUID] ASC, [ControlType] ASC, [Number] ASC, [CultureCode] ASC, [AgencyCultureCode] ASC);
END


GO
PRINT N'Creating [dbo].[tmdFullStandardDPSExtractToday]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'tmdFullStandardDPSExtractToday' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[tmdFullStandardDPSExtractToday] (
    [RegListID]            INT             NOT NULL,
    [ListCountryCode]      VARCHAR (2)     NOT NULL,
    [ListCountryName]      VARCHAR (100)   NOT NULL,
    [RegListName]          VARCHAR (100)   NOT NULL,
    [Organization]         VARCHAR (250)   NOT NULL,
    [Website]              VARCHAR (300)   NOT NULL,
    [RegEntityID]          INT             NOT NULL,
    [RegEffDate]           DATETIME        NOT NULL,
    [RegExpDate]           DATETIME        NOT NULL,
    [RegEntityStatusID]    VARCHAR (5)     NOT NULL,
    [AltNameType]          VARCHAR (8)     NOT NULL,
    [AltFullName]          NVARCHAR (350)  NOT NULL,
    [Address]              NVARCHAR (375)  NOT NULL,
    [City]                 NVARCHAR (50)   NOT NULL,
    [SubCountryCode]       VARCHAR (10)    NOT NULL,
    [SubCountry]           NVARCHAR (100)  NOT NULL,
    [PostalCode]           NVARCHAR (15)   NOT NULL,
    [CountryCode]          VARCHAR (2)     NOT NULL,
    [CountryName]          VARCHAR (100)   NOT NULL,
    [Reason]               VARCHAR (200)   NOT NULL,
    [ReasonEffDate]        DATETIME        NOT NULL,
    [ReasonExpDate]        DATETIME        NOT NULL,
    [ReasonRemarks]        NVARCHAR (2500) NOT NULL,
    [ExceptionName]        NVARCHAR (100)  NOT NULL,
    [ExceptionDescription] NVARCHAR (2000) NOT NULL,
    [ExceptionEffDate]     DATETIME        NOT NULL,
    [ExceptionExpDate]     DATETIME        NOT NULL,
    [HashSum]              VARBINARY (42)  NULL
);
END


GO
PRINT N'Creating [dbo].[tmdFullStandardDPSExtractToday].[CIX_tmdFullStandardDPSExtractToday]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_tmdFullStandardDPSExtractToday' AND object_id = object_id('tmdFullStandardDPSExtractToday'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_tmdFullStandardDPSExtractToday]
    ON [dbo].[tmdFullStandardDPSExtractToday]([RegListID] ASC, [RegEntityID] ASC, [City] ASC);
END


GO
PRINT N'Creating [dbo].[tmdFullStandardDPSExtractYesterday]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'tmdFullStandardDPSExtractYesterday' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[tmdFullStandardDPSExtractYesterday] (
    [RegListID]            INT             NOT NULL,
    [ListCountryCode]      VARCHAR (2)     NOT NULL,
    [ListCountryName]      VARCHAR (100)   NOT NULL,
    [RegListName]          VARCHAR (100)   NOT NULL,
    [Organization]         VARCHAR (250)   NOT NULL,
    [Website]              VARCHAR (300)   NOT NULL,
    [RegEntityID]          INT             NOT NULL,
    [RegEffDate]           DATETIME        NOT NULL,
    [RegExpDate]           DATETIME        NOT NULL,
    [RegEntityStatusID]    VARCHAR (5)     NOT NULL,
    [AltNameType]          VARCHAR (8)     NOT NULL,
    [AltFullName]          NVARCHAR (350)  NOT NULL,
    [Address]              NVARCHAR (375)  NOT NULL,
    [City]                 NVARCHAR (50)   NOT NULL,
    [SubCountryCode]       VARCHAR (10)    NOT NULL,
    [SubCountry]           NVARCHAR (100)  NOT NULL,
    [PostalCode]           NVARCHAR (15)   NOT NULL,
    [CountryCode]          VARCHAR (2)     NOT NULL,
    [CountryName]          VARCHAR (100)   NOT NULL,
    [Reason]               VARCHAR (200)   NOT NULL,
    [ReasonEffDate]        DATETIME        NOT NULL,
    [ReasonExpDate]        DATETIME        NOT NULL,
    [ReasonRemarks]        NVARCHAR (2500) NOT NULL,
    [ExceptionName]        NVARCHAR (100)  NOT NULL,
    [ExceptionDescription] NVARCHAR (2000) NOT NULL,
    [ExceptionEffDate]     DATETIME        NOT NULL,
    [ExceptionExpDate]     DATETIME        NOT NULL,
    [HashSum]              VARBINARY (42)  NULL
);
END


GO
PRINT N'Creating [dbo].[tmdFullStandardDPSExtractYesterday].[CIX_tmdFullStandardDPSExtractYesterday]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_tmdFullStandardDPSExtractYesterday' AND object_id = object_id('tmdFullStandardDPSExtractYesterday'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_tmdFullStandardDPSExtractYesterday]
    ON [dbo].[tmdFullStandardDPSExtractYesterday]([RegListID] ASC, [RegEntityID] ASC, [City] ASC);
END


GO
PRINT N'Creating [dbo].[tmdGVBrokerCharges]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'tmdGVBrokerCharges' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[tmdGVBrokerCharges] (
    [PartnerID]          INT              NOT NULL,
    [EffDate]            DATETIME         NOT NULL,
    [CountryCode]        VARCHAR (2)      NOT NULL,
    [BrokerID]           VARCHAR (30)     NOT NULL,
    [PerEntryChargeAmt]  NUMERIC (38, 20) NOT NULL,
    [PerLineChargeAmt]   NUMERIC (38, 20) NOT NULL,
    [DeletedFlag]        VARCHAR (1)      NOT NULL,
    [KeepDuringRollback] VARCHAR (1)      NOT NULL,
    CONSTRAINT [PK_tmdGVBrokerCharges] PRIMARY KEY CLUSTERED ([PartnerID] ASC, [CountryCode] ASC, [BrokerID] ASC)
);
END


GO
PRINT N'Creating [dbo].[tmdHTSPGA]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'tmdHTSPGA' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[tmdHTSPGA] (
    [PartnerID]          INT           NULL,
    [EffDate]            DATETIME      NULL,
    [HTSCode]            VARCHAR (15)  NULL,
    [PGAIndicator]       VARCHAR (20)  NULL,
    [Agency]             VARCHAR (20)  NULL,
    [Description]        VARCHAR (200) NULL,
    [KeepDuringRollback] VARCHAR (2)   NULL,
    [DeletedFlag]        VARCHAR (2)   NULL
);
END


GO
PRINT N'Creating [dbo].[tmdMXHTSAudit]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'tmdMXHTSAudit' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[tmdMXHTSAudit] (
    [PartnerID]          INT              NOT NULL,
    [EffDate]            DATETIME         NOT NULL,
    [HtsGuid]            VARCHAR (50)     NOT NULL,
    [AltHtsIndex]        VARCHAR (15)     NOT NULL,
    [AltHtsNum]          VARCHAR (10)     NOT NULL,
    [AltHtsDesc]         VARCHAR (500)    NOT NULL,
    [Program1]           VARCHAR (10)     NOT NULL,
    [Program2]           VARCHAR (10)     NOT NULL,
    [RptQtyUom]          VARCHAR (3)      NOT NULL,
    [AddlRptQtyUom]      VARCHAR (3)      NOT NULL,
    [AdValoremRate]      NUMERIC (38, 20) NOT NULL,
    [SpecificRate]       NUMERIC (38, 20) NOT NULL,
    [AddlSpecificRate]   NUMERIC (38, 20) NOT NULL,
    [Annex30Flag]        CHAR (1)         NOT NULL,
    [MonthsOfExpiration] INT              NOT NULL,
    [DeletedFlag]        VARCHAR (1)      NOT NULL,
    [KeepDuringRollback] VARCHAR (1)      NOT NULL,
    CONSTRAINT [PK_tmdMXHTSAudit] PRIMARY KEY CLUSTERED ([PartnerID] ASC, [AltHtsIndex] ASC, [HtsGuid] ASC)
);
END


GO
PRINT N'Creating [dbo].[tmdSAProductClassificationAddlFields]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'tmdSAProductClassificationAddlFields' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[tmdSAProductClassificationAddlFields] (
    [PartnerID]          INT              NOT NULL,
    [EffDate]            DATETIME         NOT NULL,
    [ProductGuid]        UNIQUEIDENTIFIER NOT NULL,
    [SAGCS01]            NVARCHAR (50)    NOT NULL,
    [SAGCS02]            NVARCHAR (50)    NOT NULL,
    [SAGCS03]            NVARCHAR (50)    NOT NULL,
    [SAGCS04]            NVARCHAR (50)    NOT NULL,
    [SAGCS05]            NVARCHAR (50)    NOT NULL,
    [SAGCS06]            NVARCHAR (50)    NOT NULL,
    [SAGCS07]            NVARCHAR (50)    NOT NULL,
    [SAGCS08]            NVARCHAR (50)    NOT NULL,
    [SAGCS09]            NVARCHAR (50)    NOT NULL,
    [SAGCS10]            NVARCHAR (50)    NOT NULL,
    [SAGCS11]            NVARCHAR (50)    NOT NULL,
    [SAGCS12]            NVARCHAR (50)    NOT NULL,
    [SAGCS13]            NVARCHAR (50)    NOT NULL,
    [SAGCS14]            NVARCHAR (50)    NOT NULL,
    [SAGCS15]            NVARCHAR (50)    NOT NULL,
    [SAGCL01]            NVARCHAR (500)   NOT NULL,
    [SAGCL02]            NVARCHAR (500)   NOT NULL,
    [SAGCL03]            NVARCHAR (500)   NOT NULL,
    [SAGCL04]            NVARCHAR (500)   NOT NULL,
    [SAGCL05]            NVARCHAR (500)   NOT NULL,
    [SAGCN01]            NUMERIC (38, 20) NOT NULL,
    [SAGCN02]            NUMERIC (38, 20) NOT NULL,
    [SAGCN03]            NUMERIC (38, 20) NOT NULL,
    [SAGCN04]            NUMERIC (38, 20) NOT NULL,
    [SAGCN05]            NUMERIC (38, 20) NOT NULL,
    [SAGCD01]            DATETIME         NOT NULL,
    [SAGCD02]            DATETIME         NOT NULL,
    [SAGCD03]            DATETIME         NOT NULL,
    [SAGCD04]            DATETIME         NOT NULL,
    [SAGCD05]            DATETIME         NOT NULL,
    [DeletedFlag]        VARCHAR (1)      NOT NULL,
    [KeepDuringRollback] VARCHAR (1)      NOT NULL,
    CONSTRAINT [PK_tmdSAProductClassificationAddlFields] PRIMARY KEY NONCLUSTERED ([PartnerID] ASC, [ProductGuid] ASC)
);
END


GO
PRINT N'Creating [dbo].[tmdSAProductClassificationAddlFields].[CIX_tmdSAProductClassificationAddlFields]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_tmdSAProductClassificationAddlFields' AND object_id = object_id('tmdSAProductClassificationAddlFields'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_tmdSAProductClassificationAddlFields]
    ON [dbo].[tmdSAProductClassificationAddlFields]([EffDate] ASC);
END


GO
PRINT N'Creating [dbo].[tmdSAProductClassificationAddlFields].[IX_tmdSAProductClassificationAddlFields_PKC]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='IX_tmdSAProductClassificationAddlFields_PKC' AND object_id = object_id('tmdSAProductClassificationAddlFields'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE NONCLUSTERED INDEX [IX_tmdSAProductClassificationAddlFields_PKC]
    ON [dbo].[tmdSAProductClassificationAddlFields]([PartnerID] ASC, [ProductGuid] ASC);
END


GO
PRINT N'Creating [dbo].[tmdTRProductClassificationAddlFields]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'tmdTRProductClassificationAddlFields' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[tmdTRProductClassificationAddlFields] (
    [PartnerID]          INT              NOT NULL,
    [EffDate]            DATETIME         NOT NULL,
    [ProductGuid]        UNIQUEIDENTIFIER NOT NULL,
    [TRGCS01]            NVARCHAR (50)    NOT NULL,
    [TRGCS02]            NVARCHAR (50)    NOT NULL,
    [TRGCS03]            NVARCHAR (50)    NOT NULL,
    [TRGCS04]            NVARCHAR (50)    NOT NULL,
    [TRGCS05]            NVARCHAR (50)    NOT NULL,
    [TRGCS06]            NVARCHAR (50)    NOT NULL,
    [TRGCS07]            NVARCHAR (50)    NOT NULL,
    [TRGCS08]            NVARCHAR (50)    NOT NULL,
    [TRGCS09]            NVARCHAR (50)    NOT NULL,
    [TRGCS10]            NVARCHAR (50)    NOT NULL,
    [TRGCS11]            NVARCHAR (50)    NOT NULL,
    [TRGCS12]            NVARCHAR (50)    NOT NULL,
    [TRGCS13]            NVARCHAR (50)    NOT NULL,
    [TRGCS14]            NVARCHAR (50)    NOT NULL,
    [TRGCS15]            NVARCHAR (50)    NOT NULL,
    [TRGCL01]            NVARCHAR (500)   NOT NULL,
    [TRGCL02]            NVARCHAR (500)   NOT NULL,
    [TRGCL03]            NVARCHAR (500)   NOT NULL,
    [TRGCL04]            NVARCHAR (500)   NOT NULL,
    [TRGCL05]            NVARCHAR (500)   NOT NULL,
    [TRGCN01]            NUMERIC (38, 20) NOT NULL,
    [TRGCN02]            NUMERIC (38, 20) NOT NULL,
    [TRGCN03]            NUMERIC (38, 20) NOT NULL,
    [TRGCN04]            NUMERIC (38, 20) NOT NULL,
    [TRGCN05]            NUMERIC (38, 20) NOT NULL,
    [TRGCD01]            DATETIME         NOT NULL,
    [TRGCD02]            DATETIME         NOT NULL,
    [TRGCD03]            DATETIME         NOT NULL,
    [TRGCD04]            DATETIME         NOT NULL,
    [TRGCD05]            DATETIME         NOT NULL,
    [DeletedFlag]        VARCHAR (1)      NOT NULL,
    [KeepDuringRollback] VARCHAR (1)      NOT NULL,
    CONSTRAINT [PK_tmdTRProductClassificationAddlFields] PRIMARY KEY NONCLUSTERED ([PartnerID] ASC, [ProductGuid] ASC)
);
END


GO
PRINT N'Creating [dbo].[tmdTRProductClassificationAddlFields].[CIX_tmdTRProductClassificationAddlFields]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_tmdTRProductClassificationAddlFields' AND object_id = object_id('tmdTRProductClassificationAddlFields'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_tmdTRProductClassificationAddlFields]
    ON [dbo].[tmdTRProductClassificationAddlFields]([EffDate] ASC);
END


GO
PRINT N'Creating [dbo].[tmdTRProductClassificationAddlFields].[IX_tmdTRProductClassificationAddlFields_PKC]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='IX_tmdTRProductClassificationAddlFields_PKC' AND object_id = object_id('tmdTRProductClassificationAddlFields'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE NONCLUSTERED INDEX [IX_tmdTRProductClassificationAddlFields_PKC]
    ON [dbo].[tmdTRProductClassificationAddlFields]([PartnerID] ASC, [ProductGuid] ASC);
END


GO
PRINT N'Creating [dbo].[tmdVNProductClassificationAddlFields]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'tmdVNProductClassificationAddlFields' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[tmdVNProductClassificationAddlFields] (
    [PartnerID]          INT              NOT NULL,
    [EffDate]            DATETIME         NOT NULL,
    [ProductGuid]        UNIQUEIDENTIFIER NOT NULL,
    [VNGCS01]            NVARCHAR (50)    NOT NULL,
    [VNGCS02]            NVARCHAR (50)    NOT NULL,
    [VNGCS03]            NVARCHAR (50)    NOT NULL,
    [VNGCS04]            NVARCHAR (50)    NOT NULL,
    [VNGCS05]            NVARCHAR (50)    NOT NULL,
    [VNGCS06]            NVARCHAR (50)    NOT NULL,
    [VNGCS07]            NVARCHAR (50)    NOT NULL,
    [VNGCS08]            NVARCHAR (50)    NOT NULL,
    [VNGCS09]            NVARCHAR (50)    NOT NULL,
    [VNGCS10]            NVARCHAR (50)    NOT NULL,
    [VNGCS11]            NVARCHAR (50)    NOT NULL,
    [VNGCS12]            NVARCHAR (50)    NOT NULL,
    [VNGCS13]            NVARCHAR (50)    NOT NULL,
    [VNGCS14]            NVARCHAR (50)    NOT NULL,
    [VNGCS15]            NVARCHAR (50)    NOT NULL,
    [VNGCL01]            NVARCHAR (500)   NOT NULL,
    [VNGCL02]            NVARCHAR (500)   NOT NULL,
    [VNGCL03]            NVARCHAR (500)   NOT NULL,
    [VNGCL04]            NVARCHAR (500)   NOT NULL,
    [VNGCL05]            NVARCHAR (500)   NOT NULL,
    [VNGCN01]            NUMERIC (38, 20) NOT NULL,
    [VNGCN02]            NUMERIC (38, 20) NOT NULL,
    [VNGCN03]            NUMERIC (38, 20) NOT NULL,
    [VNGCN04]            NUMERIC (38, 20) NOT NULL,
    [VNGCN05]            NUMERIC (38, 20) NOT NULL,
    [VNGCD01]            DATETIME         NOT NULL,
    [VNGCD02]            DATETIME         NOT NULL,
    [VNGCD03]            DATETIME         NOT NULL,
    [VNGCD04]            DATETIME         NOT NULL,
    [VNGCD05]            DATETIME         NOT NULL,
    [DeletedFlag]        VARCHAR (1)      NOT NULL,
    [KeepDuringRollback] VARCHAR (1)      NOT NULL,
    CONSTRAINT [PK_tmdVNProductClassificationAddlFields] PRIMARY KEY NONCLUSTERED ([PartnerID] ASC, [ProductGuid] ASC)
);
END


GO
PRINT N'Creating [dbo].[tmdVNProductClassificationAddlFields].[CIX_tmdVNProductClassificationAddlFields]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_tmdVNProductClassificationAddlFields' AND object_id = object_id('tmdVNProductClassificationAddlFields'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_tmdVNProductClassificationAddlFields]
    ON [dbo].[tmdVNProductClassificationAddlFields]([EffDate] ASC);
END


GO
PRINT N'Creating [dbo].[tmdVNProductClassificationAddlFields].[IX_tmdVNProductClassificationAddlFields_PKC]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='IX_tmdVNProductClassificationAddlFields_PKC' AND object_id = object_id('tmdVNProductClassificationAddlFields'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE NONCLUSTERED INDEX [IX_tmdVNProductClassificationAddlFields_PKC]
    ON [dbo].[tmdVNProductClassificationAddlFields]([PartnerID] ASC, [ProductGuid] ASC);
END


GO
PRINT N'Creating [dbo].[tmdZAProductClassificationAddlFields]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'tmdZAProductClassificationAddlFields' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[tmdZAProductClassificationAddlFields] (
    [PartnerID]          INT              NOT NULL,
    [EffDate]            DATETIME         NOT NULL,
    [ProductGuid]        UNIQUEIDENTIFIER NOT NULL,
    [ZAGCS01]            NVARCHAR (50)    NOT NULL,
    [ZAGCS02]            NVARCHAR (50)    NOT NULL,
    [ZAGCS03]            NVARCHAR (50)    NOT NULL,
    [ZAGCS04]            NVARCHAR (50)    NOT NULL,
    [ZAGCS05]            NVARCHAR (50)    NOT NULL,
    [ZAGCS06]            NVARCHAR (50)    NOT NULL,
    [ZAGCS07]            NVARCHAR (50)    NOT NULL,
    [ZAGCS08]            NVARCHAR (50)    NOT NULL,
    [ZAGCS09]            NVARCHAR (50)    NOT NULL,
    [ZAGCS10]            NVARCHAR (50)    NOT NULL,
    [ZAGCS11]            NVARCHAR (50)    NOT NULL,
    [ZAGCS12]            NVARCHAR (50)    NOT NULL,
    [ZAGCS13]            NVARCHAR (50)    NOT NULL,
    [ZAGCS14]            NVARCHAR (50)    NOT NULL,
    [ZAGCS15]            NVARCHAR (50)    NOT NULL,
    [ZAGCL01]            NVARCHAR (500)   NOT NULL,
    [ZAGCL02]            NVARCHAR (500)   NOT NULL,
    [ZAGCL03]            NVARCHAR (500)   NOT NULL,
    [ZAGCL04]            NVARCHAR (500)   NOT NULL,
    [ZAGCL05]            NVARCHAR (500)   NOT NULL,
    [ZAGCN01]            NUMERIC (38, 20) NOT NULL,
    [ZAGCN02]            NUMERIC (38, 20) NOT NULL,
    [ZAGCN03]            NUMERIC (38, 20) NOT NULL,
    [ZAGCN04]            NUMERIC (38, 20) NOT NULL,
    [ZAGCN05]            NUMERIC (38, 20) NOT NULL,
    [ZAGCD01]            DATETIME         NOT NULL,
    [ZAGCD02]            DATETIME         NOT NULL,
    [ZAGCD03]            DATETIME         NOT NULL,
    [ZAGCD04]            DATETIME         NOT NULL,
    [ZAGCD05]            DATETIME         NOT NULL,
    [DeletedFlag]        VARCHAR (1)      NOT NULL,
    [KeepDuringRollback] VARCHAR (1)      NOT NULL,
    CONSTRAINT [PK_tmdZAProductClassificationAddlFields] PRIMARY KEY NONCLUSTERED ([PartnerID] ASC, [ProductGuid] ASC)
);
END


GO
PRINT N'Creating [dbo].[tmdZAProductClassificationAddlFields].[CIX_tmdZAProductClassificationAddlFields]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_tmdZAProductClassificationAddlFields' AND object_id = object_id('tmdZAProductClassificationAddlFields'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_tmdZAProductClassificationAddlFields]
    ON [dbo].[tmdZAProductClassificationAddlFields]([EffDate] ASC);
END


GO
PRINT N'Creating [dbo].[tmdZAProductClassificationAddlFields].[IX_tmdZAProductClassificationAddlFields_PKC]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='IX_tmdZAProductClassificationAddlFields_PKC' AND object_id = object_id('tmdZAProductClassificationAddlFields'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE NONCLUSTERED INDEX [IX_tmdZAProductClassificationAddlFields_PKC]
    ON [dbo].[tmdZAProductClassificationAddlFields]([PartnerID] ASC, [ProductGuid] ASC);
END


GO
PRINT N'Creating [dbo].[tmgEmailNotificationQueries_OLD_173]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'tmgEmailNotificationQueries_OLD_173' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[tmgEmailNotificationQueries_OLD_173] (
    [PartnerID]          INT          NOT NULL,
    [EffDate]            DATETIME     NOT NULL,
    [NotificationGUID]   VARCHAR (50) NOT NULL,
    [SQLGUID]            VARCHAR (50) NOT NULL,
    [DeletedFlag]        VARCHAR (1)  NOT NULL,
    [KeepDuringRollback] VARCHAR (1)  NOT NULL
);
END


GO
PRINT N'Creating [dbo].[tmgEmailNotificationQueries_OLD_173].[CIX_tmgEmailNotificationQueries]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_tmgEmailNotificationQueries' AND object_id = object_id('tmgEmailNotificationQueries_OLD_173'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_tmgEmailNotificationQueries]
    ON [dbo].[tmgEmailNotificationQueries_OLD_173]([EffDate] ASC);
END


GO
PRINT N'Creating [dbo].[tmgEmailNotificationQueries_OLD_173].[IX_tmgEmailNotificationQueries_PKC]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='IX_tmgEmailNotificationQueries_PKC' AND object_id = object_id('tmgEmailNotificationQueries_OLD_173'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE NONCLUSTERED INDEX [IX_tmgEmailNotificationQueries_PKC]
    ON [dbo].[tmgEmailNotificationQueries_OLD_173]([PartnerID] ASC, [NotificationGUID] ASC, [SQLGUID] ASC)
    INCLUDE([EffDate]);
END


GO
PRINT N'Creating [dbo].[tmgGVImportPrefProgramCodes]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'tmgGVImportPrefProgramCodes' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[tmgGVImportPrefProgramCodes] (
    [PartnerID]                  INT              NOT NULL,
    [EffDate]                    DATETIME         NOT NULL,
    [ContentPrefProgramCode]     VARCHAR (20)     NOT NULL,
    [IndicatorCodeGUID]          UNIQUEIDENTIFIER NOT NULL,
    [PrefProgramIndicatorCode]   VARCHAR (20)     NOT NULL,
    [PrefProgramIndicatorDecode] VARCHAR (50)     NOT NULL,
    [DeletedFlag]                VARCHAR (1)      NOT NULL,
    [KeepDuringRollback]         VARCHAR (1)      NOT NULL,
    CONSTRAINT [PK_tmgGVImportPrefProgramCodes] PRIMARY KEY NONCLUSTERED ([PartnerID] ASC, [ContentPrefProgramCode] ASC, [PrefProgramIndicatorCode] ASC)
);
END


GO
PRINT N'Creating [dbo].[tmgGVImportPrefProgramCodes].[CIX_tmgGVImportPrefProgramCodes]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_tmgGVImportPrefProgramCodes' AND object_id = object_id('tmgGVImportPrefProgramCodes'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_tmgGVImportPrefProgramCodes]
    ON [dbo].[tmgGVImportPrefProgramCodes]([EffDate] ASC);
END


GO
PRINT N'Creating [dbo].[tmp_IDTable]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'tmp_IDTable' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[tmp_IDTable] (
    [NewID] INT IDENTITY (1, 1) NOT NULL,
    [oldID] INT NOT NULL
);
END


GO
PRINT N'Creating [dbo].[tmpTestVV]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'tmpTestVV' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[tmpTestVV] (
    [PartnerID]          INT          NOT NULL,
    [EffDate]            DATETIME     NOT NULL,
    [Number]             VARCHAR (50) NOT NULL,
    [DeletedFlag]        VARCHAR (1)  NOT NULL,
    [KeepDuringRollback] VARCHAR (1)  NOT NULL,
    CONSTRAINT [PK_tmpTestVV] PRIMARY KEY NONCLUSTERED ([PartnerID] ASC, [EffDate] ASC) WITH (FILLFACTOR = 90)
);
END


GO
PRINT N'Creating [dbo].[tmpTestVV].[CIX_tmpTestVV]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_tmpTestVV' AND object_id = object_id('tmpTestVV'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_tmpTestVV]
    ON [dbo].[tmpTestVV]([EffDate] ASC) WITH (FILLFACTOR = 100);
END


GO
PRINT N'Creating [dbo].[tmpTestVV].[IX_tmpTestVV]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='IX_tmpTestVV' AND object_id = object_id('tmpTestVV'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE NONCLUSTERED INDEX [IX_tmpTestVV]
    ON [dbo].[tmpTestVV]([PartnerID] ASC, [EffDate] ASC, [DeletedFlag] ASC, [KeepDuringRollback] ASC) WITH (FILLFACTOR = 100);
END


GO
PRINT N'Creating [dbo].[ttdStagingDEAESDeclarationData]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingDEAESDeclarationData' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingDEAESDeclarationData] (
    [PartnerID]                           INT              NOT NULL,
    [EffDate]                             DATETIME         NOT NULL,
    [DeclarationGUID]                     VARCHAR (50)     NOT NULL,
    [DeclarationDataGUID]                 VARCHAR (50)     NOT NULL,
    [SequenceNum]                         INT              NOT NULL,
    [Type]                                VARCHAR (6)      NOT NULL,
    [DeclarationType1]                    VARCHAR (2)      NOT NULL,
    [DeclarationType2]                    VARCHAR (2)      NOT NULL,
    [DeclarationType3]                    VARCHAR (1)      NOT NULL,
    [MRN]                                 VARCHAR (18)     NOT NULL,
    [ExportCountry]                       VARCHAR (2)      NOT NULL,
    [DestinationCountry]                  VARCHAR (2)      NOT NULL,
    [DeclarationDate]                     DATETIME         NOT NULL,
    [ApplicableDate]                      DATETIME         NOT NULL,
    [ExitDate]                            DATETIME         NOT NULL,
    [CancellationDate]                    DATETIME         NOT NULL,
    [CancellationType]                    VARCHAR (2)      NOT NULL,
    [CancellationReason]                  VARCHAR (350)    NOT NULL,
    [SupplementaryDeclarationDate]        DATETIME         NOT NULL,
    [NoticeDate]                          DATETIME         NOT NULL,
    [ReleaseDate]                         DATETIME         NOT NULL,
    [Watermark]                           VARCHAR (2)      NOT NULL,
    [SmallQuantityFlag]                   VARCHAR (1)      NOT NULL,
    [AlternativeProof]                    VARCHAR (1)      NOT NULL,
    [ReceiptDate]                         DATETIME         NOT NULL,
    [AcceptanceDate]                      VARCHAR (2)      NOT NULL,
    [IntendedExitDate]                    DATETIME         NOT NULL,
    [ExitType]                            VARCHAR (1)      NOT NULL,
    [SpecialCircumstances]                VARCHAR (1)      NOT NULL,
    [TransportCostsMethodOfPayment]       VARCHAR (1)      NOT NULL,
    [PartiesStatus]                       VARCHAR (4)      NOT NULL,
    [AddresseeStatus]                     VARCHAR (1)      NOT NULL,
    [CountainerFlag]                      VARCHAR (1)      NOT NULL,
    [StatisticalMessageFlag]              VARCHAR (1)      NOT NULL,
    [TotalGrossWeight]                    NUMERIC (38, 20) NOT NULL,
    [ExternalIdentifier]                  VARCHAR (70)     NOT NULL,
    [Note]                                VARCHAR (350)    NOT NULL,
    [UCR]                                 VARCHAR (70)     NOT NULL,
    [LRN]                                 VARCHAR (22)     NOT NULL,
    [TotalItems]                          INT              NOT NULL,
    [TotalPackages]                       INT              NOT NULL,
    [BIN]                                 VARCHAR (25)     NOT NULL,
    [OPLocalClearanceAuthorizationNumber] VARCHAR (35)     NOT NULL,
    [OPAuthorizationNumber]               VARCHAR (35)     NOT NULL,
    [TrustedExporterNumber]               VARCHAR (35)     NOT NULL,
    [AuthorizedExporterNumber]            VARCHAR (35)     NOT NULL,
    [InlandModeOfTransport]               VARCHAR (2)      NOT NULL,
    [DepartureTypeOfTransport]            VARCHAR (2)      NOT NULL,
    [DepartureTransportMeansID]           VARCHAR (27)     NOT NULL,
    [DepartureTransportMeansNationality]  VARCHAR (2)      NOT NULL,
    [BorderModeOfTransport]               VARCHAR (2)      NOT NULL,
    [BorderTypeOfTransport]               VARCHAR (2)      NOT NULL,
    [BorderTransportMeansID]              VARCHAR (27)     NOT NULL,
    [BorderTransportMeansNationality]     VARCHAR (2)      NOT NULL,
    [PlaceOfLoading]                      VARCHAR (4)      NOT NULL,
    [PlaceOfLoadingAddress]               VARCHAR (35)     NOT NULL,
    [PlaceOfLoadingPostCode]              VARCHAR (5)      NOT NULL,
    [PlaceOfLoadingCity]                  VARCHAR (35)     NOT NULL,
    [PlaceOfLoadingAdditionalInformation] VARCHAR (35)     NOT NULL,
    [DeclarationOffice]                   VARCHAR (8)      NOT NULL,
    [SupplementaryDeclarationOffice]      VARCHAR (8)      NOT NULL,
    [ExitOffice]                          VARCHAR (8)      NOT NULL,
    [ActualExitOffice]                    VARCHAR (8)      NOT NULL,
    [TransactionNature]                   VARCHAR (2)      NOT NULL,
    [TotalInvoice]                        NUMERIC (38, 20) NOT NULL,
    [TotalInvoiceCurrency]                VARCHAR (3)      NOT NULL,
    [SealType]                            VARCHAR (1)      NOT NULL,
    [TotalSeals]                          INT              NOT NULL,
    [StartLoadingDate]                    DATETIME         NOT NULL,
    [EndLoadingDate]                      DATETIME         NOT NULL,
    [ExporterIDType]                      VARCHAR (1)      NOT NULL,
    [ExporterID]                          VARCHAR (17)     NOT NULL,
    [ExporterBranch]                      VARCHAR (4)      NOT NULL,
    [ExporterName]                        VARCHAR (120)    NOT NULL,
    [ExporterAddress]                     VARCHAR (70)     NOT NULL,
    [ExporterCity]                        VARCHAR (35)     NOT NULL,
    [ExporterPostCode]                    VARCHAR (9)      NOT NULL,
    [ExporterCountry]                     VARCHAR (2)      NOT NULL,
    [ExporterContactPosition]             VARCHAR (35)     NOT NULL,
    [ExporterContactName]                 VARCHAR (35)     NOT NULL,
    [ExporterContactTel]                  VARCHAR (35)     NOT NULL,
    [ExporterContactFax]                  VARCHAR (35)     NOT NULL,
    [ExporterContactEmail]                VARCHAR (256)    NOT NULL,
    [DeclarantIDType]                     VARCHAR (1)      NOT NULL,
    [DeclarantID]                         VARCHAR (17)     NOT NULL,
    [DeclarantBranch]                     VARCHAR (4)      NOT NULL,
    [DeclarantName]                       VARCHAR (120)    NOT NULL,
    [DeclarantAddress]                    VARCHAR (70)     NOT NULL,
    [DeclarantCity]                       VARCHAR (35)     NOT NULL,
    [DeclarantPostCode]                   VARCHAR (9)      NOT NULL,
    [DeclarantCountry]                    VARCHAR (2)      NOT NULL,
    [DeclarantContactPosition]            VARCHAR (35)     NOT NULL,
    [DeclarantContactName]                VARCHAR (35)     NOT NULL,
    [DeclarantContactTel]                 VARCHAR (35)     NOT NULL,
    [DeclarantContactFax]                 VARCHAR (35)     NOT NULL,
    [DeclarantContactEmail]               VARCHAR (256)    NOT NULL,
    [AgentIDType]                         VARCHAR (1)      NOT NULL,
    [AgentID]                             VARCHAR (17)     NOT NULL,
    [AgentBranch]                         VARCHAR (4)      NOT NULL,
    [AgentName]                           VARCHAR (120)    NOT NULL,
    [AgentAddress]                        VARCHAR (70)     NOT NULL,
    [AgentCity]                           VARCHAR (35)     NOT NULL,
    [AgentPostCode]                       VARCHAR (9)      NOT NULL,
    [AgentCountry]                        VARCHAR (2)      NOT NULL,
    [AgentContactPosition]                VARCHAR (35)     NOT NULL,
    [AgentContactName]                    VARCHAR (35)     NOT NULL,
    [AgentContactTel]                     VARCHAR (35)     NOT NULL,
    [AgentContactFax]                     VARCHAR (35)     NOT NULL,
    [AgentContactEmail]                   VARCHAR (256)    NOT NULL,
    [SubContractorIDType]                 VARCHAR (1)      NOT NULL,
    [SubContractorID]                     VARCHAR (17)     NOT NULL,
    [SubContractorBranch]                 VARCHAR (4)      NOT NULL,
    [SubContractorName]                   VARCHAR (120)    NOT NULL,
    [SubContractorAddress]                VARCHAR (70)     NOT NULL,
    [SubContractorCity]                   VARCHAR (35)     NOT NULL,
    [SubContractorPostCode]               VARCHAR (5)      NOT NULL,
    [SubContractorCountry]                VARCHAR (2)      NOT NULL,
    [SubContractorContactPosition]        VARCHAR (35)     NOT NULL,
    [SubContractorContactName]            VARCHAR (35)     NOT NULL,
    [SubContractorContactTel]             VARCHAR (35)     NOT NULL,
    [SubContractorContactFax]             VARCHAR (35)     NOT NULL,
    [SubContractorContactEmail]           VARCHAR (256)    NOT NULL,
    [ConsigneeIDType]                     VARCHAR (1)      NOT NULL,
    [ConsigneeID]                         VARCHAR (17)     NOT NULL,
    [ConsigneeBranch]                     VARCHAR (4)      NOT NULL,
    [ConsigneeName]                       VARCHAR (120)    NOT NULL,
    [ConsigneeAddress]                    VARCHAR (70)     NOT NULL,
    [ConsigneeCity]                       VARCHAR (35)     NOT NULL,
    [ConsigneePostCode]                   VARCHAR (9)      NOT NULL,
    [ConsigneeCountry]                    VARCHAR (2)      NOT NULL,
    [EndUserIDType]                       VARCHAR (1)      NOT NULL,
    [EndUserID]                           VARCHAR (17)     NOT NULL,
    [EndUserBranch]                       VARCHAR (4)      NOT NULL,
    [EndUserName]                         VARCHAR (120)    NOT NULL,
    [EndUserAddress]                      VARCHAR (70)     NOT NULL,
    [EndUserCity]                         VARCHAR (35)     NOT NULL,
    [EndUserPostCode]                     VARCHAR (9)      NOT NULL,
    [EndUserCountry]                      VARCHAR (2)      NOT NULL,
    [IncotermCode]                        VARCHAR (3)      NOT NULL,
    [IncotermText]                        VARCHAR (140)    NOT NULL,
    [IncotermLocation]                    VARCHAR (35)     NOT NULL,
    [ReImportDate]                        DATETIME         NOT NULL,
    [StandardExchange]                    VARCHAR (1)      NOT NULL,
    [ExportAuthorizationNumber]           VARCHAR (12)     NOT NULL,
    [RefundDestinationCountry]            VARCHAR (2)      NOT NULL,
    [RefundTextualStatement]              VARCHAR (350)    NOT NULL,
    [RefundRequestType]                   VARCHAR (2)      NOT NULL,
    [RefundPaymentMethod]                 VARCHAR (2)      NOT NULL,
    [RefundRegisteredAgent]               VARCHAR (2)      NOT NULL,
    [RefundSecurityAccount]               VARCHAR (4)      NOT NULL,
    [RefundDeclarationIsRequest]          VARCHAR (1)      NOT NULL,
    [DeletedFlag]                         VARCHAR (1)      NOT NULL,
    [KeepDuringRollback]                  VARCHAR (1)      NOT NULL
);
END


GO
PRINT N'Creating [dbo].[ttdStagingDEAESDeclarationDataHist]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingDEAESDeclarationDataHist' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingDEAESDeclarationDataHist] (
    [PartnerID]                             INT              NOT NULL,
    [EffDate]                               DATETIME         NOT NULL,
    [DeclarationGUID]                       VARCHAR (50)     NOT NULL,
    [DeclarationDataGUID]                   VARCHAR (50)     NOT NULL,
    [SequenceNum]                           INT              NOT NULL,
    [Type]                                  VARCHAR (20)     NOT NULL,
    [Name]                                  VARCHAR (6)      NOT NULL,
    [DeclarationType1]                      VARCHAR (2)      NOT NULL,
    [DeclarationType2]                      VARCHAR (2)      NOT NULL,
    [DeclarationType3]                      VARCHAR (1)      NOT NULL,
    [MRN]                                   VARCHAR (18)     NOT NULL,
    [ExportCountry]                         VARCHAR (2)      NOT NULL,
    [DestinationCountry]                    VARCHAR (2)      NOT NULL,
    [DeclarationDate]                       DATETIME         NOT NULL,
    [ApplicableDate]                        DATETIME         NOT NULL,
    [ExitDate]                              DATETIME         NOT NULL,
    [CancellationDate]                      DATETIME         NOT NULL,
    [CancellationType]                      VARCHAR (2)      NOT NULL,
    [CancellationReason]                    VARCHAR (350)    NOT NULL,
    [SupplementaryDeclarationDate]          DATETIME         NOT NULL,
    [NoticeDate]                            DATETIME         NOT NULL,
    [ReleaseDate]                           DATETIME         NOT NULL,
    [Watermark]                             VARCHAR (2)      NOT NULL,
    [SmallQuantityFlag]                     VARCHAR (1)      NOT NULL,
    [AlternativeProof]                      VARCHAR (1)      NOT NULL,
    [ReceiptDate]                           DATETIME         NOT NULL,
    [AcceptanceDate]                        VARCHAR (2)      NOT NULL,
    [IntendedExitDate]                      DATETIME         NOT NULL,
    [ExitType]                              VARCHAR (1)      NOT NULL,
    [SpecialCircumstances]                  VARCHAR (1)      NOT NULL,
    [TransportCostsMethodOfPayment]         VARCHAR (1)      NOT NULL,
    [PartiesStatus]                         VARCHAR (4)      NOT NULL,
    [AddresseeStatus]                       VARCHAR (1)      NOT NULL,
    [CountainerFlag]                        VARCHAR (1)      NOT NULL,
    [StatisticalMessageFlag]                VARCHAR (1)      NOT NULL,
    [TotalGrossWeight]                      NUMERIC (38, 20) NOT NULL,
    [ExternalIdentifier]                    VARCHAR (70)     NOT NULL,
    [Note]                                  VARCHAR (350)    NOT NULL,
    [UCR]                                   VARCHAR (70)     NOT NULL,
    [LRN]                                   VARCHAR (22)     NOT NULL,
    [TotalItems]                            INT              NOT NULL,
    [TotalPackages]                         INT              NOT NULL,
    [BIN]                                   VARCHAR (25)     NOT NULL,
    [OPLocalClearanceAuthorizationNumber]   VARCHAR (12)     NOT NULL,
    [OPAuthorizationNumber]                 VARCHAR (12)     NOT NULL,
    [TrustedExporterNumber]                 VARCHAR (12)     NOT NULL,
    [AuthorizedExporterNumber]              VARCHAR (12)     NOT NULL,
    [InlandModeOfTransport]                 VARCHAR (2)      NOT NULL,
    [DepartureTypeOfTransport]              VARCHAR (2)      NOT NULL,
    [DepartureTransportMeansID]             VARCHAR (27)     NOT NULL,
    [DepartureTransportMeansNationality]    VARCHAR (2)      NOT NULL,
    [BorderModeOfTransport]                 VARCHAR (2)      NOT NULL,
    [BorderTypeOfTransport]                 VARCHAR (2)      NOT NULL,
    [BorderTransportMeansID]                VARCHAR (27)     NOT NULL,
    [BorderTransportMeansNationality]       VARCHAR (2)      NOT NULL,
    [PlaceOfLoading]                        VARCHAR (4)      NOT NULL,
    [PlaceOfLoadingAddress]                 VARCHAR (35)     NOT NULL,
    [PlaceOfLoadingPostCode]                VARCHAR (5)      NOT NULL,
    [PlaceOfLoadingCity]                    VARCHAR (35)     NOT NULL,
    [PlaceOfLoadingAdditionalInformation]   VARCHAR (35)     NOT NULL,
    [DeclarationOffice]                     VARCHAR (8)      NOT NULL,
    [SupplementaryDeclarationOffice]        VARCHAR (8)      NOT NULL,
    [ExitOffice]                            VARCHAR (8)      NOT NULL,
    [ActualExitOffice]                      VARCHAR (8)      NOT NULL,
    [TransactionNature]                     VARCHAR (2)      NOT NULL,
    [TotalInvoice]                          NUMERIC (38, 20) NOT NULL,
    [TotalInvoiceCurrency]                  VARCHAR (3)      NOT NULL,
    [SealType]                              VARCHAR (1)      NOT NULL,
    [TotalSeals]                            INT              NOT NULL,
    [StartLoadingDate]                      DATETIME         NOT NULL,
    [EndLoadingDate]                        DATETIME         NOT NULL,
    [ExporterIDType]                        VARCHAR (1)      NOT NULL,
    [ExporterID]                            VARCHAR (17)     NOT NULL,
    [ExporterBranch]                        VARCHAR (4)      NOT NULL,
    [ExporterName]                          VARCHAR (120)    NOT NULL,
    [ExporterAddress]                       VARCHAR (70)     NOT NULL,
    [ExporterCity]                          VARCHAR (35)     NOT NULL,
    [ExporterPostCode]                      VARCHAR (9)      NOT NULL,
    [ExporterCountry]                       VARCHAR (2)      NOT NULL,
    [ExporterContactPosition]               VARCHAR (35)     NOT NULL,
    [ExporterContactName]                   VARCHAR (35)     NOT NULL,
    [ExporterContactTel]                    VARCHAR (35)     NOT NULL,
    [ExporterContactFax]                    VARCHAR (35)     NOT NULL,
    [ExporterContactEmail]                  VARCHAR (256)    NOT NULL,
    [DeclarantIDType]                       VARCHAR (1)      NOT NULL,
    [DeclarantID]                           VARCHAR (17)     NOT NULL,
    [DeclarantBranch]                       VARCHAR (4)      NOT NULL,
    [DeclarantName]                         VARCHAR (120)    NOT NULL,
    [DeclarantAddress]                      VARCHAR (70)     NOT NULL,
    [DeclarantCity]                         VARCHAR (35)     NOT NULL,
    [DeclarantPostCode]                     VARCHAR (9)      NOT NULL,
    [DeclarantCountry]                      VARCHAR (2)      NOT NULL,
    [DeclarantContactPosition]              VARCHAR (35)     NOT NULL,
    [DeclarantContactName]                  VARCHAR (35)     NOT NULL,
    [DeclarantContactTel]                   VARCHAR (35)     NOT NULL,
    [DeclarantContactFax]                   VARCHAR (35)     NOT NULL,
    [DeclarantContactEmail]                 VARCHAR (256)    NOT NULL,
    [AgentIDType]                           VARCHAR (1)      NOT NULL,
    [AgentID]                               VARCHAR (17)     NOT NULL,
    [AgentBranch]                           VARCHAR (4)      NOT NULL,
    [AgentName]                             VARCHAR (120)    NOT NULL,
    [AgentAddress]                          VARCHAR (70)     NOT NULL,
    [AgentCity]                             VARCHAR (35)     NOT NULL,
    [AgentPostCode]                         VARCHAR (9)      NOT NULL,
    [AgentCountry]                          VARCHAR (2)      NOT NULL,
    [AgentContactPosition]                  VARCHAR (35)     NOT NULL,
    [AgentContactName]                      VARCHAR (35)     NOT NULL,
    [AgentContactTel]                       VARCHAR (35)     NOT NULL,
    [AgentContactFax]                       VARCHAR (35)     NOT NULL,
    [AgentContactEmail]                     VARCHAR (256)    NOT NULL,
    [SubContractorIDType]                   VARCHAR (1)      NOT NULL,
    [SubContractorID]                       VARCHAR (17)     NOT NULL,
    [SubContractorBranch]                   VARCHAR (4)      NOT NULL,
    [SubContractorName]                     VARCHAR (120)    NOT NULL,
    [SubContractorAddress]                  VARCHAR (70)     NOT NULL,
    [SubContractorCity]                     VARCHAR (35)     NOT NULL,
    [SubContractorPostCode]                 VARCHAR (5)      NOT NULL,
    [SubContractorCountry]                  VARCHAR (2)      NOT NULL,
    [SubContractorContactPosition]          VARCHAR (35)     NOT NULL,
    [SubContractorContactName]              VARCHAR (35)     NOT NULL,
    [SubContractorContactTel]               VARCHAR (35)     NOT NULL,
    [SubContractorContactFax]               VARCHAR (35)     NOT NULL,
    [SubContractorContactEmail]             VARCHAR (256)    NOT NULL,
    [ConsigneeIDType]                       VARCHAR (1)      NOT NULL,
    [ConsigneeID]                           VARCHAR (17)     NOT NULL,
    [ConsigneeBranch]                       VARCHAR (4)      NOT NULL,
    [ConsigneeName]                         VARCHAR (120)    NOT NULL,
    [ConsigneeAddress]                      VARCHAR (70)     NOT NULL,
    [ConsigneeCity]                         VARCHAR (35)     NOT NULL,
    [ConsigneePostCode]                     VARCHAR (9)      NOT NULL,
    [ConsigneeCountry]                      VARCHAR (2)      NOT NULL,
    [OutwardProcessingOwnerIDType]          VARCHAR (1)      NOT NULL,
    [OutwardProcessingOwnerID]              VARCHAR (17)     NOT NULL,
    [OutwardProcessingOwnerBranch]          VARCHAR (4)      NOT NULL,
    [OutwardProcessingOwnerName]            VARCHAR (120)    NOT NULL,
    [OutwardProcessingOwnerAddress]         VARCHAR (70)     NOT NULL,
    [OutwardProcessingOwnerCity]            VARCHAR (35)     NOT NULL,
    [OutwardProcessingOwnerPostCode]        VARCHAR (9)      NOT NULL,
    [OutwardProcessingOwnerCountry]         VARCHAR (2)      NOT NULL,
    [OutwardProcessingOwnerContactPosition] VARCHAR (35)     NOT NULL,
    [OutwardProcessingOwnerContactName]     VARCHAR (35)     NOT NULL,
    [OutwardProcessingOwnerContactTel]      VARCHAR (35)     NOT NULL,
    [OutwardProcessingOwnerContactFax]      VARCHAR (35)     NOT NULL,
    [OutwardProcessingOwnerContactEmail]    VARCHAR (256)    NOT NULL,
    [EndUserIDType]                         VARCHAR (1)      NOT NULL,
    [EndUserID]                             VARCHAR (17)     NOT NULL,
    [EndUserBranch]                         VARCHAR (4)      NOT NULL,
    [EndUserName]                           VARCHAR (120)    NOT NULL,
    [EndUserAddress]                        VARCHAR (70)     NOT NULL,
    [EndUserCity]                           VARCHAR (35)     NOT NULL,
    [EndUserPostCode]                       VARCHAR (9)      NOT NULL,
    [EndUserCountry]                        VARCHAR (2)      NOT NULL,
    [IncotermCode]                          VARCHAR (3)      NOT NULL,
    [IncotermText]                          VARCHAR (140)    NOT NULL,
    [IncotermLocation]                      VARCHAR (35)     NOT NULL,
    [ReImportDate]                          DATETIME         NOT NULL,
    [StandardExchange]                      VARCHAR (1)      NOT NULL,
    [ExportAuthorizationNumber]             VARCHAR (12)     NOT NULL,
    [RefundDestinationCountry]              VARCHAR (2)      NOT NULL,
    [RefundTextualStatement]                VARCHAR (350)    NOT NULL,
    [RefundRequestType]                     VARCHAR (2)      NOT NULL,
    [RefundPaymentMethod]                   VARCHAR (2)      NOT NULL,
    [RefundRegisteredAgent]                 VARCHAR (2)      NOT NULL,
    [RefundSecurityAccount]                 VARCHAR (4)      NOT NULL,
    [RefundDeclarationIsRequest]            VARCHAR (1)      NOT NULL,
    [EmergencyProcedureDate]                DATETIME         NOT NULL,
    [EmergencyProcedureReferenceNumber]     VARCHAR (350)    NOT NULL,
    [DeletedFlag]                           VARCHAR (1)      NOT NULL,
    [KeepDuringRollback]                    VARCHAR (1)      NOT NULL
);
END


GO
PRINT N'Creating [dbo].[ttdStagingDEAESGoodsItemPackage]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingDEAESGoodsItemPackage' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingDEAESGoodsItemPackage] (
    [PartnerID]            INT           NOT NULL,
    [EffDate]              DATETIME      NOT NULL,
    [DeclarationGUID]      VARCHAR (50)  NOT NULL,
    [DeclarationDataGUID]  VARCHAR (50)  NOT NULL,
    [GoodsItemGUID]        VARCHAR (50)  NOT NULL,
    [GoodsItemPackageGUID] VARCHAR (50)  NOT NULL,
    [SequenceNum]          INT           NOT NULL,
    [Number]               INT           NOT NULL,
    [SequenceNumber]       INT           NOT NULL,
    [Type]                 VARCHAR (3)   NOT NULL,
    [MarksAndNumbers]      NVARCHAR (42) NOT NULL,
    [MainItemNumber]       INT           NOT NULL,
    [DeletedFlag]          VARCHAR (1)   NOT NULL,
    [KeepDuringRollback]   VARCHAR (1)   NOT NULL
);
END


GO
PRINT N'Creating [dbo].[ttdStagingDEAESGoodsItemPackage].[CIX_ttdStagingDEAESGoodsItemPackage]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_ttdStagingDEAESGoodsItemPackage' AND object_id = object_id('ttdStagingDEAESGoodsItemPackage'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_ttdStagingDEAESGoodsItemPackage]
    ON [dbo].[ttdStagingDEAESGoodsItemPackage]([EffDate] ASC);
END


GO
PRINT N'Creating [dbo].[ttdStagingDEAESGoodsItemPackageHist]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingDEAESGoodsItemPackageHist' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingDEAESGoodsItemPackageHist] (
    [PartnerID]            INT           NOT NULL,
    [EffDate]              DATETIME      NOT NULL,
    [DeclarationGUID]      VARCHAR (50)  NOT NULL,
    [DeclarationDataGUID]  VARCHAR (50)  NOT NULL,
    [GoodsItemGUID]        VARCHAR (50)  NOT NULL,
    [GoodsItemPackageGUID] VARCHAR (50)  NOT NULL,
    [SequenceNum]          INT           NOT NULL,
    [Number]               INT           NOT NULL,
    [SequenceNumber]       INT           NOT NULL,
    [Type]                 VARCHAR (3)   NOT NULL,
    [MarksAndNumbers]      NVARCHAR (42) NOT NULL,
    [MainItemNumber]       INT           NOT NULL,
    [DeletedFlag]          VARCHAR (1)   NOT NULL,
    [KeepDuringRollback]   VARCHAR (1)   NOT NULL
);
END


GO
PRINT N'Creating [dbo].[ttdStagingDEAESGoodsItemPackageHist].[CIX_ttdStagingDEAESGoodsItemPackageHist]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_ttdStagingDEAESGoodsItemPackageHist' AND object_id = object_id('ttdStagingDEAESGoodsItemPackageHist'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_ttdStagingDEAESGoodsItemPackageHist]
    ON [dbo].[ttdStagingDEAESGoodsItemPackageHist]([EffDate] ASC);
END


GO
PRINT N'Creating [dbo].[ttdStagingEUFIFOProcessing_RT]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingEUFIFOProcessing_RT' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingEUFIFOProcessing_RT] (
    [PartnerId]                                 INT              NOT NULL,
    [EffDate]                                   DATETIME         NOT NULL,
    [TxnNumGUID]                                VARCHAR (50)     NOT NULL,
    [IPTxnID]                                   VARCHAR (50)     NOT NULL,
    [IncoTerms]                                 VARCHAR (5)      NOT NULL,
    [IncoTermsLocation]                         VARCHAR (100)    NOT NULL,
    [Charge1]                                   NUMERIC (38, 20) NOT NULL,
    [Charge1CurrencyCode]                       VARCHAR (3)      NOT NULL,
    [Charge2]                                   NUMERIC (38, 20) NOT NULL,
    [Charge2CurrencyCode]                       VARCHAR (3)      NOT NULL,
    [Charge3]                                   NUMERIC (38, 20) NOT NULL,
    [Charge3CurrencyCode]                       VARCHAR (3)      NOT NULL,
    [Charge4]                                   NUMERIC (38, 20) NOT NULL,
    [Charge4CurrencyCode]                       VARCHAR (3)      NOT NULL,
    [Charge5]                                   NUMERIC (38, 20) NOT NULL,
    [Charge5CurrencyCode]                       VARCHAR (3)      NOT NULL,
    [SellerID]                                  VARCHAR (50)     NOT NULL,
    [SellerFederalID]                           VARCHAR (20)     NOT NULL,
    [SellerFederalIDType]                       VARCHAR (1)      NOT NULL,
    [SellerCompanyName]                         VARCHAR (100)    NOT NULL,
    [SellerContactName]                         VARCHAR (100)    NOT NULL,
    [SellerContactPhone]                        VARCHAR (25)     NOT NULL,
    [SellerContactFax]                          VARCHAR (25)     NOT NULL,
    [SellerContactEmail]                        VARCHAR (100)    NOT NULL,
    [SellerAddressLine1]                        VARCHAR (100)    NOT NULL,
    [SellerAddressLine2]                        VARCHAR (100)    NOT NULL,
    [SellerAddressLine3]                        VARCHAR (100)    NOT NULL,
    [SellerAddressLine4]                        VARCHAR (100)    NOT NULL,
    [SellerCity]                                VARCHAR (50)     NOT NULL,
    [SellerState]                               VARCHAR (50)     NOT NULL,
    [SellerPostalCode]                          VARCHAR (10)     NOT NULL,
    [SellerCountryCode]                         VARCHAR (20)     NOT NULL,
    [SellerDTSStatus]                           VARCHAR (20)     NOT NULL,
    [SellerDTSOverrideDate]                     DATETIME         NOT NULL,
    [SellerDTSLastValidatedDate]                DATETIME         NOT NULL,
    [ShipFromID]                                VARCHAR (50)     NOT NULL,
    [ShipFromFederalID]                         VARCHAR (20)     NOT NULL,
    [ShipFromFederalIDType]                     VARCHAR (1)      NOT NULL,
    [ShipFromCompanyName]                       VARCHAR (100)    NOT NULL,
    [ShipFromContactName]                       VARCHAR (100)    NOT NULL,
    [ShipFromContactPhone]                      VARCHAR (25)     NOT NULL,
    [ShipFromContactFax]                        VARCHAR (25)     NOT NULL,
    [ShipFromContactEmail]                      VARCHAR (100)    NOT NULL,
    [ShipFromAddressLine1]                      VARCHAR (100)    NOT NULL,
    [ShipFromAddressLine2]                      VARCHAR (100)    NOT NULL,
    [ShipFromAddressLine3]                      VARCHAR (100)    NOT NULL,
    [ShipFromAddressLine4]                      VARCHAR (100)    NOT NULL,
    [ShipFromCity]                              VARCHAR (50)     NOT NULL,
    [ShipFromState]                             VARCHAR (50)     NOT NULL,
    [ShipFromPostalCode]                        VARCHAR (10)     NOT NULL,
    [ShipFromCountryCode]                       VARCHAR (20)     NOT NULL,
    [ShipFromDTSStatus]                         VARCHAR (20)     NOT NULL,
    [ShipFromDTSOverrideDate]                   DATETIME         NOT NULL,
    [ShipFromDTSLastValidatedDate]              DATETIME         NOT NULL,
    [BillToID]                                  VARCHAR (50)     NOT NULL,
    [BillToFederalID]                           VARCHAR (20)     NOT NULL,
    [BillToFederalIDType]                       VARCHAR (1)      NOT NULL,
    [BillToCompanyName]                         VARCHAR (100)    NOT NULL,
    [BillToContactName]                         VARCHAR (100)    NOT NULL,
    [BillToContactPhone]                        VARCHAR (25)     NOT NULL,
    [BillToContactFax]                          VARCHAR (25)     NOT NULL,
    [BillToContactEmail]                        VARCHAR (100)    NOT NULL,
    [BillToAddressLine1]                        VARCHAR (100)    NOT NULL,
    [BillToAddressLine2]                        VARCHAR (100)    NOT NULL,
    [BillToAddressLine3]                        VARCHAR (100)    NOT NULL,
    [BillToAddressLine4]                        VARCHAR (100)    NOT NULL,
    [BillToCity]                                VARCHAR (50)     NOT NULL,
    [BillToState]                               VARCHAR (50)     NOT NULL,
    [BillToPostalCode]                          VARCHAR (10)     NOT NULL,
    [BillToCountryCode]                         VARCHAR (20)     NOT NULL,
    [BillToDTSStatus]                           VARCHAR (20)     NOT NULL,
    [BillToDTSOverrideDate]                     DATETIME         NOT NULL,
    [BillToDTSLastValidatedDate]                DATETIME         NOT NULL,
    [ShipToID]                                  VARCHAR (50)     NOT NULL,
    [ShipToFederalID]                           VARCHAR (20)     NOT NULL,
    [ShipToFederalIDType]                       VARCHAR (1)      NOT NULL,
    [ShipToCompanyName]                         VARCHAR (100)    NOT NULL,
    [ShipToContactName]                         VARCHAR (100)    NOT NULL,
    [ShipToContactPhone]                        VARCHAR (25)     NOT NULL,
    [ShipToContactFax]                          VARCHAR (25)     NOT NULL,
    [ShipToContactEmail]                        VARCHAR (100)    NOT NULL,
    [ShipToAddressLine1]                        VARCHAR (100)    NOT NULL,
    [ShipToAddressLine2]                        VARCHAR (100)    NOT NULL,
    [ShipToAddressLine3]                        VARCHAR (100)    NOT NULL,
    [ShipToAddressLine4]                        VARCHAR (100)    NOT NULL,
    [ShipToCity]                                VARCHAR (50)     NOT NULL,
    [ShipToState]                               VARCHAR (50)     NOT NULL,
    [ShipToPostalCode]                          VARCHAR (10)     NOT NULL,
    [ShipToCountryCode]                         VARCHAR (20)     NOT NULL,
    [ShipToDTSStatus]                           VARCHAR (20)     NOT NULL,
    [ShipToDTSOverrideDate]                     DATETIME         NOT NULL,
    [ShipToDTSLastValidatedDate]                DATETIME         NOT NULL,
    [IntermediateConsigneeID]                   VARCHAR (50)     NOT NULL,
    [IntermediateConsigneeFederalID]            VARCHAR (20)     NOT NULL,
    [IntermediateConsigneeFederalIDType]        VARCHAR (1)      NOT NULL,
    [IntermediateConsigneeCompanyName]          VARCHAR (100)    NOT NULL,
    [IntermediateConsigneeContactName]          VARCHAR (100)    NOT NULL,
    [IntermediateConsigneeContactPhone]         VARCHAR (25)     NOT NULL,
    [IntermediateConsigneeContactFax]           VARCHAR (25)     NOT NULL,
    [IntermediateConsigneeContactEmail]         VARCHAR (100)    NOT NULL,
    [IntermediateConsigneeAddressLine1]         VARCHAR (100)    NOT NULL,
    [IntermediateConsigneeAddressLine2]         VARCHAR (100)    NOT NULL,
    [IntermediateConsigneeAddressLine3]         VARCHAR (100)    NOT NULL,
    [IntermediateConsigneeAddressLine4]         VARCHAR (100)    NOT NULL,
    [IntermediateConsigneeCity]                 VARCHAR (50)     NOT NULL,
    [IntermediateConsigneeState]                VARCHAR (50)     NOT NULL,
    [IntermediateConsigneePostalCode]           VARCHAR (10)     NOT NULL,
    [IntermediateConsigneeCountryCode]          VARCHAR (20)     NOT NULL,
    [IntermediateConsigneeDTSStatus]            VARCHAR (50)     NOT NULL,
    [IntermediateConsigneeDTSOverrideDate]      DATETIME         NOT NULL,
    [IntermediateConsigneeDTSLastValidatedDate] DATETIME         NOT NULL,
    [UltimateConsigneeId]                       VARCHAR (50)     NOT NULL,
    [UltimateConsigneeFederalID]                VARCHAR (20)     NOT NULL,
    [UltimateConsigneeFederalIDType]            VARCHAR (1)      NOT NULL,
    [UltimateConsigneeCompanyName]              VARCHAR (100)    NOT NULL,
    [UltimateConsigneeContactName]              VARCHAR (100)    NOT NULL,
    [UltimateConsigneeContactPhone]             VARCHAR (25)     NOT NULL,
    [UltimateConsigneeContactFax]               VARCHAR (25)     NOT NULL,
    [UltimateConsigneeContactEmail]             VARCHAR (100)    NOT NULL,
    [UltimateConsigneeAddressLine1]             VARCHAR (100)    NOT NULL,
    [UltimateConsigneeAddressLine2]             VARCHAR (100)    NOT NULL,
    [UltimateConsigneeAddressLine3]             VARCHAR (100)    NOT NULL,
    [UltimateConsigneeAddressLine4]             VARCHAR (100)    NOT NULL,
    [UltimateConsigneeCity]                     VARCHAR (50)     NOT NULL,
    [UltimateConsigneeState]                    VARCHAR (50)     NOT NULL,
    [UltimateConsigneePostalCode]               VARCHAR (10)     NOT NULL,
    [UltimateConsigneeCountryCode]              VARCHAR (3)      NOT NULL,
    [UltimateConsigneeDTSStatus]                VARCHAR (50)     NOT NULL,
    [UltimateConsigneeDTSOverrideDate]          DATETIME         NOT NULL,
    [UltimateConsigneeDTSLastValidatedDate]     DATETIME         NOT NULL,
    [ForwarderID]                               VARCHAR (50)     NOT NULL,
    [ForwarderFederalID]                        VARCHAR (20)     NOT NULL,
    [ForwarderFederalIDType]                    VARCHAR (1)      NOT NULL,
    [ForwarderCompanyName]                      VARCHAR (100)    NOT NULL,
    [ForwarderContactName]                      VARCHAR (100)    NOT NULL,
    [ForwarderContactPhone]                     VARCHAR (25)     NOT NULL,
    [ForwarderContactFax]                       VARCHAR (25)     NOT NULL,
    [ForwarderContactEmail]                     VARCHAR (100)    NOT NULL,
    [ForwarderAddressLine1]                     VARCHAR (100)    NOT NULL,
    [ForwarderAddressLine2]                     VARCHAR (100)    NOT NULL,
    [ForwarderAddressLine3]                     VARCHAR (100)    NOT NULL,
    [ForwarderAddressLine4]                     VARCHAR (100)    NOT NULL,
    [ForwarderCity]                             VARCHAR (50)     NOT NULL,
    [ForwarderState]                            VARCHAR (50)     NOT NULL,
    [ForwarderPostalCode]                       VARCHAR (10)     NOT NULL,
    [ForwarderCountryCode]                      VARCHAR (20)     NOT NULL,
    [ForwarderDTSStatus]                        VARCHAR (20)     NOT NULL,
    [ForwarderDTSOverrideDate]                  DATETIME         NOT NULL,
    [ForwarderDTSLastValidatedDate]             DATETIME         NOT NULL,
    [ForwardToID]                               VARCHAR (50)     NOT NULL,
    [ForwardToFederalID]                        VARCHAR (20)     NOT NULL,
    [ForwardToFederalIDType]                    VARCHAR (1)      NOT NULL,
    [ForwardToCompanyName]                      VARCHAR (100)    NOT NULL,
    [ForwardToContactName]                      VARCHAR (100)    NOT NULL,
    [ForwardToContactPhone]                     VARCHAR (25)     NOT NULL,
    [ForwardToContactFax]                       VARCHAR (25)     NOT NULL,
    [ForwardToContactEmail]                     VARCHAR (100)    NOT NULL,
    [ForwardToAddressLine1]                     VARCHAR (100)    NOT NULL,
    [ForwardToAddressLine2]                     VARCHAR (100)    NOT NULL,
    [ForwardToAddressLine3]                     VARCHAR (100)    NOT NULL,
    [ForwardToAddressLine4]                     VARCHAR (100)    NOT NULL,
    [ForwardToCity]                             VARCHAR (50)     NOT NULL,
    [ForwardToState]                            VARCHAR (50)     NOT NULL,
    [ForwardToPostalCode]                       VARCHAR (10)     NOT NULL,
    [ForwardToCountryCode]                      VARCHAR (20)     NOT NULL,
    [ForwardToDTSStatus]                        VARCHAR (20)     NOT NULL,
    [ForwardToDTSOverrideDate]                  DATETIME         NOT NULL,
    [ForwardToDTSLastValidatedDate]             DATETIME         NOT NULL,
    [ExportingCarrierID]                        VARCHAR (50)     NOT NULL,
    [ExportingCarrierFederalID]                 VARCHAR (20)     NOT NULL,
    [ExportingCarrierFederalIDType]             VARCHAR (1)      NOT NULL,
    [ExportingCarrierCompanyName]               VARCHAR (100)    NOT NULL,
    [ExportingCarrierContactName]               VARCHAR (100)    NOT NULL,
    [ExportingCarrierContactPhone]              VARCHAR (25)     NOT NULL,
    [ExportingCarrierContactFax]                VARCHAR (25)     NOT NULL,
    [ExportingCarrierContactEmail]              VARCHAR (100)    NOT NULL,
    [ExportingCarrierAddressLine1]              VARCHAR (100)    NOT NULL,
    [ExportingCarrierAddressLine2]              VARCHAR (100)    NOT NULL,
    [ExportingCarrierAddressLine3]              VARCHAR (100)    NOT NULL,
    [ExportingCarrierAddressLine4]              VARCHAR (100)    NOT NULL,
    [ExportingCarrierCity]                      VARCHAR (50)     NOT NULL,
    [ExportingCarrierState]                     VARCHAR (50)     NOT NULL,
    [ExportingCarrierPostalCode]                VARCHAR (10)     NOT NULL,
    [ExportingCarrierCountryCode]               VARCHAR (20)     NOT NULL,
    [ExportingCarrierDTSStatus]                 VARCHAR (20)     NOT NULL,
    [ExportingCarrierDTSOverrideDate]           DATETIME         NOT NULL,
    [ExportingCarrierDTSLastValidatedDate]      DATETIME         NOT NULL,
    [InlandCarrierID]                           VARCHAR (50)     NOT NULL,
    [InlandCarrierFederalID]                    VARCHAR (20)     NOT NULL,
    [InlandCarrierFederalIDType]                VARCHAR (1)      NOT NULL,
    [InlandCarrierCompanyName]                  VARCHAR (100)    NOT NULL,
    [InlandCarrierContactName]                  VARCHAR (100)    NOT NULL,
    [InlandCarrierContactPhone]                 VARCHAR (25)     NOT NULL,
    [InlandCarrierContactFax]                   VARCHAR (25)     NOT NULL,
    [InlandCarrierContactEmail]                 VARCHAR (100)    NOT NULL,
    [InlandCarrierAddressLine1]                 VARCHAR (100)    NOT NULL,
    [InlandCarrierAddressLine2]                 VARCHAR (100)    NOT NULL,
    [InlandCarrierAddressLine3]                 VARCHAR (100)    NOT NULL,
    [InlandCarrierAddressLine4]                 VARCHAR (100)    NOT NULL,
    [InlandCarrierCity]                         VARCHAR (50)     NOT NULL,
    [InlandCarrierState]                        VARCHAR (50)     NOT NULL,
    [InlandCarrierPostalCode]                   VARCHAR (10)     NOT NULL,
    [InlandCarrierCountryCode]                  VARCHAR (20)     NOT NULL,
    [InlandCarrierDTSStatus]                    VARCHAR (20)     NOT NULL,
    [InlandCarrierDTSOverrideDate]              DATETIME         NOT NULL,
    [InlandCarrierDTSLastValidatedDate]         DATETIME         NOT NULL,
    [GrossWeight]                               NUMERIC (38, 20) NOT NULL,
    [GrossWeightSource]                         VARCHAR (1)      NOT NULL,
    [ECNNum]                                    VARCHAR (20)     NOT NULL,
    [ECNNumSource]                              VARCHAR (1)      NOT NULL,
    [HazMatFlag]                                VARCHAR (1)      NOT NULL,
    [HazMatFlagSource]                          VARCHAR (1)      NOT NULL,
    [PortOfLading]                              VARCHAR (50)     NOT NULL,
    [PortOfUnlading]                            VARCHAR (50)     NOT NULL,
    [LOCAL01]                                   VARCHAR (10)     NOT NULL,
    [LOCAL02]                                   VARCHAR (10)     NOT NULL,
    [LOCAL03]                                   VARCHAR (50)     NOT NULL,
    [LOCAL04]                                   VARCHAR (50)     NOT NULL,
    [LOCAL05]                                   VARCHAR (50)     NOT NULL,
    [LOCAL06]                                   VARCHAR (50)     NOT NULL,
    [LOCAL07]                                   VARCHAR (50)     NOT NULL,
    [LOCAL08]                                   VARCHAR (50)     NOT NULL,
    [LOCAL09]                                   VARCHAR (50)     NOT NULL,
    [LOCAL10]                                   VARCHAR (50)     NOT NULL,
    [KeepDuringRollback]                        VARCHAR (1)      NOT NULL,
    [DeletedFlag]                               VARCHAR (1)      NOT NULL
);
END


GO
PRINT N'Creating [dbo].[ttdStagingExportDetail_IN]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingExportDetail_IN' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingExportDetail_IN] (
    [PartnerID]                   INT              NOT NULL,
    [EffDate]                     DATETIME         NOT NULL,
    [ExportGUID]                  VARCHAR (50)     NOT NULL,
    [ExportDetailGUID]            VARCHAR (50)     NOT NULL,
    [LineNum]                     INT              NOT NULL,
    [ExportCode]                  VARCHAR (10)     NOT NULL,
    [ProductGUID]                 VARCHAR (50)     NOT NULL,
    [ProductNum]                  NVARCHAR (50)    NOT NULL,
    [ProductDesc]                 NVARCHAR (350)   NOT NULL,
    [ManufacturerID]              VARCHAR (30)     NOT NULL,
    [TxnQty]                      NUMERIC (38, 20) NOT NULL,
    [RemainingTxnQty]             NUMERIC (38, 20) NOT NULL,
    [TxnQtyUOM]                   VARCHAR (10)     NOT NULL,
    [UOMConvFactor]               NUMERIC (38, 20) NOT NULL,
    [RptQty]                      NUMERIC (38, 20) NOT NULL,
    [RemainingRptQty]             NUMERIC (38, 20) NOT NULL,
    [RptQtyUOM]                   VARCHAR (15)     NOT NULL,
    [AddlUOMConvFactor]           NUMERIC (38, 20) NOT NULL,
    [AddlRptQty]                  NUMERIC (38, 20) NOT NULL,
    [RemainingAddlRptQty]         NUMERIC (38, 20) NOT NULL,
    [AddlRptQtyUOM]               VARCHAR (15)     NOT NULL,
    [GrossWeight]                 NUMERIC (38, 20) NOT NULL,
    [NetWeight]                   NUMERIC (38, 20) NOT NULL,
    [WeightUOM]                   VARCHAR (10)     NOT NULL,
    [Value]                       NUMERIC (38, 20) NOT NULL,
    [TotalValue]                  NUMERIC (38, 20) NOT NULL,
    [RemainingTotalValue]         NUMERIC (38, 20) NOT NULL,
    [CurrencyCode]                VARCHAR (3)      NOT NULL,
    [LicenseRequired]             VARCHAR (1)      NOT NULL,
    [RegulationCode]              VARCHAR (5)      NOT NULL,
    [LicenseTypeCode]             VARCHAR (10)     NOT NULL,
    [LicenseNum]                  VARCHAR (20)     NOT NULL,
    [ExportTariffType]            VARCHAR (5)      NOT NULL,
    [ExportTariffNum]             VARCHAR (15)     NOT NULL,
    [ImportTariffType]            VARCHAR (5)      NOT NULL,
    [ImportTariffNum]             VARCHAR (15)     NOT NULL,
    [ECNNum]                      VARCHAR (20)     NOT NULL,
    [CountryOfOrigin]             VARCHAR (2)      NOT NULL,
    [HazMatFlag]                  VARCHAR (1)      NOT NULL,
    [FDAProductCode]              VARCHAR (50)     NOT NULL,
    [BTANum]                      VARCHAR (50)     NOT NULL,
    [EquipmentNum]                VARCHAR (20)     NOT NULL,
    [VehicleFlag]                 VARCHAR (10)     NOT NULL,
    [VehicleIDType]               VARCHAR (10)     NOT NULL,
    [VehicleIDNum]                VARCHAR (30)     NOT NULL,
    [VehicleTitle]                VARCHAR (30)     NOT NULL,
    [VehicleTitleState]           VARCHAR (10)     NOT NULL,
    [DDTCITARExemptionNum]        VARCHAR (20)     NOT NULL,
    [DDTCRegistrationNum]         VARCHAR (10)     NOT NULL,
    [DDTCMilitaryFlag]            VARCHAR (1)      NOT NULL,
    [DDTCEligiblePartyFlag]       VARCHAR (1)      NOT NULL,
    [DDTCUSMLCategory]            VARCHAR (20)     NOT NULL,
    [LicenseQty]                  NUMERIC (38, 20) NOT NULL,
    [RemainingLicenseQty]         NUMERIC (38, 20) NOT NULL,
    [LicenseUOM]                  VARCHAR (5)      NOT NULL,
    [OrderNum]                    VARCHAR (50)     NOT NULL,
    [Marks]                       NVARCHAR (1000)  NOT NULL,
    [Numbers]                     VARCHAR (75)     NOT NULL,
    [LicenseValue]                NUMERIC (38, 20) NOT NULL,
    [AESSubmit]                   VARCHAR (1)      NOT NULL,
    [ImportControlResolutionCode] VARCHAR (50)     NOT NULL,
    [ExportControlResolutionCode] VARCHAR (50)     NOT NULL,
    [EMDS01]                      NVARCHAR (50)    NOT NULL,
    [EMDS02]                      NVARCHAR (50)    NOT NULL,
    [EMDS03]                      NVARCHAR (50)    NOT NULL,
    [EMDS04]                      NVARCHAR (50)    NOT NULL,
    [EMDS05]                      NVARCHAR (50)    NOT NULL,
    [EMDS06]                      NVARCHAR (50)    NOT NULL,
    [EMDS07]                      NVARCHAR (50)    NOT NULL,
    [EMDS08]                      NVARCHAR (50)    NOT NULL,
    [EMDS09]                      NVARCHAR (50)    NOT NULL,
    [EMDS10]                      NVARCHAR (50)    NOT NULL,
    [EMDS11]                      NVARCHAR (50)    NOT NULL,
    [EMDS12]                      NVARCHAR (50)    NOT NULL,
    [EMDS13]                      NVARCHAR (50)    NOT NULL,
    [EMDS14]                      NVARCHAR (50)    NOT NULL,
    [EMDS15]                      NVARCHAR (50)    NOT NULL,
    [EMDL01]                      NVARCHAR (500)   NOT NULL,
    [EMDL02]                      NVARCHAR (500)   NOT NULL,
    [EMDL03]                      NVARCHAR (500)   NOT NULL,
    [EMDL04]                      NVARCHAR (500)   NOT NULL,
    [EMDL05]                      NVARCHAR (500)   NOT NULL,
    [EMDN01]                      NUMERIC (38, 20) NOT NULL,
    [EMDN02]                      NUMERIC (38, 20) NOT NULL,
    [EMDN03]                      NUMERIC (38, 20) NOT NULL,
    [EMDN04]                      NUMERIC (38, 20) NOT NULL,
    [EMDN05]                      NUMERIC (38, 20) NOT NULL,
    [EMDD01]                      DATETIME         NOT NULL,
    [EMDD02]                      DATETIME         NOT NULL,
    [EMDD03]                      DATETIME         NOT NULL,
    [EMDD04]                      DATETIME         NOT NULL,
    [EMDD05]                      DATETIME         NOT NULL,
    [DeletedFlag]                 VARCHAR (1)      NOT NULL,
    [KeepDuringRollback]          VARCHAR (1)      NOT NULL
);
END


GO
PRINT N'Creating [dbo].[ttdStagingExportDetail_IN].[CIX_ttdStagingExportDetail_IN]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_ttdStagingExportDetail_IN' AND object_id = object_id('ttdStagingExportDetail_IN'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_ttdStagingExportDetail_IN]
    ON [dbo].[ttdStagingExportDetail_IN]([EffDate] ASC);
END


GO
PRINT N'Creating [dbo].[ttdStagingExportDetail_IN_HIST]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingExportDetail_IN_HIST' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingExportDetail_IN_HIST] (
    [PartnerID]                   INT              NOT NULL,
    [EffDate]                     DATETIME         NOT NULL,
    [ExportGUID]                  VARCHAR (50)     NOT NULL,
    [ExportDetailGUID]            VARCHAR (50)     NOT NULL,
    [LineNum]                     INT              NOT NULL,
    [ExportCode]                  VARCHAR (10)     NOT NULL,
    [ProductGUID]                 VARCHAR (50)     NOT NULL,
    [ProductNum]                  NVARCHAR (50)    NOT NULL,
    [ProductDesc]                 NVARCHAR (350)   NOT NULL,
    [ManufacturerID]              VARCHAR (30)     NOT NULL,
    [TxnQty]                      NUMERIC (38, 20) NOT NULL,
    [RemainingTxnQty]             NUMERIC (38, 20) NOT NULL,
    [TxnQtyUOM]                   VARCHAR (10)     NOT NULL,
    [UOMConvFactor]               NUMERIC (38, 20) NOT NULL,
    [RptQty]                      NUMERIC (38, 20) NOT NULL,
    [RemainingRptQty]             NUMERIC (38, 20) NOT NULL,
    [RptQtyUOM]                   VARCHAR (15)     NOT NULL,
    [AddlUOMConvFactor]           NUMERIC (38, 20) NOT NULL,
    [AddlRptQty]                  NUMERIC (38, 20) NOT NULL,
    [RemainingAddlRptQty]         NUMERIC (38, 20) NOT NULL,
    [AddlRptQtyUOM]               VARCHAR (15)     NOT NULL,
    [GrossWeight]                 NUMERIC (38, 20) NOT NULL,
    [NetWeight]                   NUMERIC (38, 20) NOT NULL,
    [WeightUOM]                   VARCHAR (10)     NOT NULL,
    [Value]                       NUMERIC (38, 20) NOT NULL,
    [TotalValue]                  NUMERIC (38, 20) NOT NULL,
    [RemainingTotalValue]         NUMERIC (38, 20) NOT NULL,
    [CurrencyCode]                VARCHAR (3)      NOT NULL,
    [LicenseRequired]             VARCHAR (1)      NOT NULL,
    [RegulationCode]              VARCHAR (5)      NOT NULL,
    [LicenseTypeCode]             VARCHAR (10)     NOT NULL,
    [LicenseNum]                  VARCHAR (20)     NOT NULL,
    [ExportTariffType]            VARCHAR (5)      NOT NULL,
    [ExportTariffNum]             VARCHAR (15)     NOT NULL,
    [ImportTariffType]            VARCHAR (5)      NOT NULL,
    [ImportTariffNum]             VARCHAR (15)     NOT NULL,
    [ECNNum]                      VARCHAR (20)     NOT NULL,
    [CountryOfOrigin]             VARCHAR (2)      NOT NULL,
    [HazMatFlag]                  VARCHAR (1)      NOT NULL,
    [FDAProductCode]              VARCHAR (50)     NOT NULL,
    [BTANum]                      VARCHAR (50)     NOT NULL,
    [EquipmentNum]                VARCHAR (20)     NOT NULL,
    [VehicleFlag]                 VARCHAR (10)     NOT NULL,
    [VehicleIDType]               VARCHAR (10)     NOT NULL,
    [VehicleIDNum]                VARCHAR (30)     NOT NULL,
    [VehicleTitle]                VARCHAR (30)     NOT NULL,
    [VehicleTitleState]           VARCHAR (10)     NOT NULL,
    [DDTCITARExemptionNum]        VARCHAR (20)     NOT NULL,
    [DDTCRegistrationNum]         VARCHAR (10)     NOT NULL,
    [DDTCMilitaryFlag]            VARCHAR (1)      NOT NULL,
    [DDTCEligiblePartyFlag]       VARCHAR (1)      NOT NULL,
    [DDTCUSMLCategory]            VARCHAR (20)     NOT NULL,
    [LicenseQty]                  NUMERIC (38, 20) NOT NULL,
    [RemainingLicenseQty]         NUMERIC (38, 20) NOT NULL,
    [LicenseUOM]                  VARCHAR (5)      NOT NULL,
    [OrderNum]                    VARCHAR (50)     NOT NULL,
    [Marks]                       NVARCHAR (1000)  NOT NULL,
    [Numbers]                     VARCHAR (75)     NOT NULL,
    [LicenseValue]                NUMERIC (38, 20) NOT NULL,
    [AESSubmit]                   VARCHAR (1)      NOT NULL,
    [ImportControlResolutionCode] VARCHAR (50)     NOT NULL,
    [ExportControlResolutionCode] VARCHAR (50)     NOT NULL,
    [EMDS01]                      NVARCHAR (50)    NOT NULL,
    [EMDS02]                      NVARCHAR (50)    NOT NULL,
    [EMDS03]                      NVARCHAR (50)    NOT NULL,
    [EMDS04]                      NVARCHAR (50)    NOT NULL,
    [EMDS05]                      NVARCHAR (50)    NOT NULL,
    [EMDS06]                      NVARCHAR (50)    NOT NULL,
    [EMDS07]                      NVARCHAR (50)    NOT NULL,
    [EMDS08]                      NVARCHAR (50)    NOT NULL,
    [EMDS09]                      NVARCHAR (50)    NOT NULL,
    [EMDS10]                      NVARCHAR (50)    NOT NULL,
    [EMDS11]                      NVARCHAR (50)    NOT NULL,
    [EMDS12]                      NVARCHAR (50)    NOT NULL,
    [EMDS13]                      NVARCHAR (50)    NOT NULL,
    [EMDS14]                      NVARCHAR (50)    NOT NULL,
    [EMDS15]                      NVARCHAR (50)    NOT NULL,
    [EMDL01]                      NVARCHAR (500)   NOT NULL,
    [EMDL02]                      NVARCHAR (500)   NOT NULL,
    [EMDL03]                      NVARCHAR (500)   NOT NULL,
    [EMDL04]                      NVARCHAR (500)   NOT NULL,
    [EMDL05]                      NVARCHAR (500)   NOT NULL,
    [EMDN01]                      NUMERIC (38, 20) NOT NULL,
    [EMDN02]                      NUMERIC (38, 20) NOT NULL,
    [EMDN03]                      NUMERIC (38, 20) NOT NULL,
    [EMDN04]                      NUMERIC (38, 20) NOT NULL,
    [EMDN05]                      NUMERIC (38, 20) NOT NULL,
    [EMDD01]                      DATETIME         NOT NULL,
    [EMDD02]                      DATETIME         NOT NULL,
    [EMDD03]                      DATETIME         NOT NULL,
    [EMDD04]                      DATETIME         NOT NULL,
    [EMDD05]                      DATETIME         NOT NULL,
    [DeletedFlag]                 VARCHAR (1)      NOT NULL,
    [KeepDuringRollback]          VARCHAR (1)      NOT NULL
);
END


GO
PRINT N'Creating [dbo].[ttdStagingExportDetail_IN_HIST].[CIX_ttdStagingExportDetail_IN_HIST]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_ttdStagingExportDetail_IN_HIST' AND object_id = object_id('ttdStagingExportDetail_IN_HIST'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_ttdStagingExportDetail_IN_HIST]
    ON [dbo].[ttdStagingExportDetail_IN_HIST]([EffDate] ASC);
END


GO
PRINT N'Creating [dbo].[ttdStagingExportDetail_OUT]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingExportDetail_OUT' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingExportDetail_OUT] (
    [PartnerID]                   INT              NOT NULL,
    [EffDate]                     DATETIME         NOT NULL,
    [ExportGUID]                  VARCHAR (50)     NOT NULL,
    [ExportDetailGUID]            VARCHAR (50)     NOT NULL,
    [LineNum]                     INT              NOT NULL,
    [ExportCode]                  VARCHAR (10)     NOT NULL,
    [ProductGUID]                 VARCHAR (50)     NOT NULL,
    [ProductNum]                  NVARCHAR (50)    NOT NULL,
    [ProductDesc]                 NVARCHAR (350)   NOT NULL,
    [ManufacturerID]              VARCHAR (30)     NOT NULL,
    [TxnQty]                      NUMERIC (38, 20) NOT NULL,
    [RemainingTxnQty]             NUMERIC (38, 20) NOT NULL,
    [TxnQtyUOM]                   VARCHAR (10)     NOT NULL,
    [UOMConvFactor]               NUMERIC (38, 20) NOT NULL,
    [RptQty]                      NUMERIC (38, 20) NOT NULL,
    [RemainingRptQty]             NUMERIC (38, 20) NOT NULL,
    [RptQtyUOM]                   VARCHAR (15)     NOT NULL,
    [AddlUOMConvFactor]           NUMERIC (38, 20) NOT NULL,
    [AddlRptQty]                  NUMERIC (38, 20) NOT NULL,
    [RemainingAddlRptQty]         NUMERIC (38, 20) NOT NULL,
    [AddlRptQtyUOM]               VARCHAR (15)     NOT NULL,
    [GrossWeight]                 NUMERIC (38, 20) NOT NULL,
    [NetWeight]                   NUMERIC (38, 20) NOT NULL,
    [WeightUOM]                   VARCHAR (10)     NOT NULL,
    [Value]                       NUMERIC (38, 20) NOT NULL,
    [TotalValue]                  NUMERIC (38, 20) NOT NULL,
    [RemainingTotalValue]         NUMERIC (38, 20) NOT NULL,
    [CurrencyCode]                VARCHAR (3)      NOT NULL,
    [LicenseRequired]             VARCHAR (1)      NOT NULL,
    [RegulationCode]              VARCHAR (5)      NOT NULL,
    [LicenseTypeCode]             VARCHAR (10)     NOT NULL,
    [LicenseNum]                  VARCHAR (20)     NOT NULL,
    [ExportTariffType]            VARCHAR (5)      NOT NULL,
    [ExportTariffNum]             VARCHAR (15)     NOT NULL,
    [ImportTariffType]            VARCHAR (5)      NOT NULL,
    [ImportTariffNum]             VARCHAR (15)     NOT NULL,
    [ECNNum]                      VARCHAR (20)     NOT NULL,
    [CountryOfOrigin]             VARCHAR (2)      NOT NULL,
    [HazMatFlag]                  VARCHAR (1)      NOT NULL,
    [FDAProductCode]              VARCHAR (50)     NOT NULL,
    [BTANum]                      VARCHAR (50)     NOT NULL,
    [EquipmentNum]                VARCHAR (20)     NOT NULL,
    [VehicleFlag]                 VARCHAR (10)     NOT NULL,
    [VehicleIDType]               VARCHAR (10)     NOT NULL,
    [VehicleIDNum]                VARCHAR (30)     NOT NULL,
    [VehicleTitle]                VARCHAR (30)     NOT NULL,
    [VehicleTitleState]           VARCHAR (10)     NOT NULL,
    [DDTCITARExemptionNum]        VARCHAR (20)     NOT NULL,
    [DDTCRegistrationNum]         VARCHAR (10)     NOT NULL,
    [DDTCMilitaryFlag]            VARCHAR (1)      NOT NULL,
    [DDTCEligiblePartyFlag]       VARCHAR (1)      NOT NULL,
    [DDTCUSMLCategory]            VARCHAR (20)     NOT NULL,
    [LicenseQty]                  NUMERIC (38, 20) NOT NULL,
    [RemainingLicenseQty]         NUMERIC (38, 20) NOT NULL,
    [LicenseUOM]                  VARCHAR (5)      NOT NULL,
    [OrderNum]                    VARCHAR (50)     NOT NULL,
    [Marks]                       NVARCHAR (1000)  NOT NULL,
    [Numbers]                     VARCHAR (75)     NOT NULL,
    [LicenseValue]                NUMERIC (38, 20) NOT NULL,
    [AESSubmit]                   VARCHAR (1)      NOT NULL,
    [ImportControlResolutionCode] VARCHAR (50)     NOT NULL,
    [ExportControlResolutionCode] VARCHAR (50)     NOT NULL,
    [EMDS01]                      NVARCHAR (50)    NOT NULL,
    [EMDS02]                      NVARCHAR (50)    NOT NULL,
    [EMDS03]                      NVARCHAR (50)    NOT NULL,
    [EMDS04]                      NVARCHAR (50)    NOT NULL,
    [EMDS05]                      NVARCHAR (50)    NOT NULL,
    [EMDS06]                      NVARCHAR (50)    NOT NULL,
    [EMDS07]                      NVARCHAR (50)    NOT NULL,
    [EMDS08]                      NVARCHAR (50)    NOT NULL,
    [EMDS09]                      NVARCHAR (50)    NOT NULL,
    [EMDS10]                      NVARCHAR (50)    NOT NULL,
    [EMDS11]                      NVARCHAR (50)    NOT NULL,
    [EMDS12]                      NVARCHAR (50)    NOT NULL,
    [EMDS13]                      NVARCHAR (50)    NOT NULL,
    [EMDS14]                      NVARCHAR (50)    NOT NULL,
    [EMDS15]                      NVARCHAR (50)    NOT NULL,
    [EMDL01]                      NVARCHAR (500)   NOT NULL,
    [EMDL02]                      NVARCHAR (500)   NOT NULL,
    [EMDL03]                      NVARCHAR (500)   NOT NULL,
    [EMDL04]                      NVARCHAR (500)   NOT NULL,
    [EMDL05]                      NVARCHAR (500)   NOT NULL,
    [EMDN01]                      NUMERIC (38, 20) NOT NULL,
    [EMDN02]                      NUMERIC (38, 20) NOT NULL,
    [EMDN03]                      NUMERIC (38, 20) NOT NULL,
    [EMDN04]                      NUMERIC (38, 20) NOT NULL,
    [EMDN05]                      NUMERIC (38, 20) NOT NULL,
    [EMDD01]                      DATETIME         NOT NULL,
    [EMDD02]                      DATETIME         NOT NULL,
    [EMDD03]                      DATETIME         NOT NULL,
    [EMDD04]                      DATETIME         NOT NULL,
    [EMDD05]                      DATETIME         NOT NULL,
    [DeletedFlag]                 VARCHAR (1)      NOT NULL,
    [KeepDuringRollback]          VARCHAR (1)      NOT NULL
);
END


GO
PRINT N'Creating [dbo].[ttdStagingExportDetail_OUT].[CIX_ttdStagingExportDetail_OUT]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_ttdStagingExportDetail_OUT' AND object_id = object_id('ttdStagingExportDetail_OUT'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_ttdStagingExportDetail_OUT]
    ON [dbo].[ttdStagingExportDetail_OUT]([EffDate] ASC);
END


GO
PRINT N'Creating [dbo].[ttdStagingExportDetail_OUT_HIST]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingExportDetail_OUT_HIST' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingExportDetail_OUT_HIST] (
    [PartnerID]                   INT              NOT NULL,
    [EffDate]                     DATETIME         NOT NULL,
    [ExportGUID]                  VARCHAR (50)     NOT NULL,
    [ExportDetailGUID]            VARCHAR (50)     NOT NULL,
    [LineNum]                     INT              NOT NULL,
    [ExportCode]                  VARCHAR (10)     NOT NULL,
    [ProductGUID]                 VARCHAR (50)     NOT NULL,
    [ProductNum]                  NVARCHAR (50)    NOT NULL,
    [ProductDesc]                 NVARCHAR (350)   NOT NULL,
    [ManufacturerID]              VARCHAR (30)     NOT NULL,
    [TxnQty]                      NUMERIC (38, 20) NOT NULL,
    [RemainingTxnQty]             NUMERIC (38, 20) NOT NULL,
    [TxnQtyUOM]                   VARCHAR (10)     NOT NULL,
    [UOMConvFactor]               NUMERIC (38, 20) NOT NULL,
    [RptQty]                      NUMERIC (38, 20) NOT NULL,
    [RemainingRptQty]             NUMERIC (38, 20) NOT NULL,
    [RptQtyUOM]                   VARCHAR (15)     NOT NULL,
    [AddlUOMConvFactor]           NUMERIC (38, 20) NOT NULL,
    [AddlRptQty]                  NUMERIC (38, 20) NOT NULL,
    [RemainingAddlRptQty]         NUMERIC (38, 20) NOT NULL,
    [AddlRptQtyUOM]               VARCHAR (15)     NOT NULL,
    [GrossWeight]                 NUMERIC (38, 20) NOT NULL,
    [NetWeight]                   NUMERIC (38, 20) NOT NULL,
    [WeightUOM]                   VARCHAR (10)     NOT NULL,
    [Value]                       NUMERIC (38, 20) NOT NULL,
    [TotalValue]                  NUMERIC (38, 20) NOT NULL,
    [RemainingTotalValue]         NUMERIC (38, 20) NOT NULL,
    [CurrencyCode]                VARCHAR (3)      NOT NULL,
    [LicenseRequired]             VARCHAR (1)      NOT NULL,
    [RegulationCode]              VARCHAR (5)      NOT NULL,
    [LicenseTypeCode]             VARCHAR (10)     NOT NULL,
    [LicenseNum]                  VARCHAR (20)     NOT NULL,
    [ExportTariffType]            VARCHAR (5)      NOT NULL,
    [ExportTariffNum]             VARCHAR (15)     NOT NULL,
    [ImportTariffType]            VARCHAR (5)      NOT NULL,
    [ImportTariffNum]             VARCHAR (15)     NOT NULL,
    [ECNNum]                      VARCHAR (20)     NOT NULL,
    [CountryOfOrigin]             VARCHAR (2)      NOT NULL,
    [HazMatFlag]                  VARCHAR (1)      NOT NULL,
    [FDAProductCode]              VARCHAR (50)     NOT NULL,
    [BTANum]                      VARCHAR (50)     NOT NULL,
    [EquipmentNum]                VARCHAR (20)     NOT NULL,
    [VehicleFlag]                 VARCHAR (10)     NOT NULL,
    [VehicleIDType]               VARCHAR (10)     NOT NULL,
    [VehicleIDNum]                VARCHAR (30)     NOT NULL,
    [VehicleTitle]                VARCHAR (30)     NOT NULL,
    [VehicleTitleState]           VARCHAR (10)     NOT NULL,
    [DDTCITARExemptionNum]        VARCHAR (20)     NOT NULL,
    [DDTCRegistrationNum]         VARCHAR (10)     NOT NULL,
    [DDTCMilitaryFlag]            VARCHAR (1)      NOT NULL,
    [DDTCEligiblePartyFlag]       VARCHAR (1)      NOT NULL,
    [DDTCUSMLCategory]            VARCHAR (20)     NOT NULL,
    [LicenseQty]                  NUMERIC (38, 20) NOT NULL,
    [RemainingLicenseQty]         NUMERIC (38, 20) NOT NULL,
    [LicenseUOM]                  VARCHAR (5)      NOT NULL,
    [OrderNum]                    VARCHAR (50)     NOT NULL,
    [Marks]                       NVARCHAR (1000)  NOT NULL,
    [Numbers]                     VARCHAR (75)     NOT NULL,
    [LicenseValue]                NUMERIC (38, 20) NOT NULL,
    [AESSubmit]                   VARCHAR (1)      NOT NULL,
    [ImportControlResolutionCode] VARCHAR (50)     NOT NULL,
    [ExportControlResolutionCode] VARCHAR (50)     NOT NULL,
    [EMDS01]                      NVARCHAR (50)    NOT NULL,
    [EMDS02]                      NVARCHAR (50)    NOT NULL,
    [EMDS03]                      NVARCHAR (50)    NOT NULL,
    [EMDS04]                      NVARCHAR (50)    NOT NULL,
    [EMDS05]                      NVARCHAR (50)    NOT NULL,
    [EMDS06]                      NVARCHAR (50)    NOT NULL,
    [EMDS07]                      NVARCHAR (50)    NOT NULL,
    [EMDS08]                      NVARCHAR (50)    NOT NULL,
    [EMDS09]                      NVARCHAR (50)    NOT NULL,
    [EMDS10]                      NVARCHAR (50)    NOT NULL,
    [EMDS11]                      NVARCHAR (50)    NOT NULL,
    [EMDS12]                      NVARCHAR (50)    NOT NULL,
    [EMDS13]                      NVARCHAR (50)    NOT NULL,
    [EMDS14]                      NVARCHAR (50)    NOT NULL,
    [EMDS15]                      NVARCHAR (50)    NOT NULL,
    [EMDL01]                      NVARCHAR (500)   NOT NULL,
    [EMDL02]                      NVARCHAR (500)   NOT NULL,
    [EMDL03]                      NVARCHAR (500)   NOT NULL,
    [EMDL04]                      NVARCHAR (500)   NOT NULL,
    [EMDL05]                      NVARCHAR (500)   NOT NULL,
    [EMDN01]                      NUMERIC (38, 20) NOT NULL,
    [EMDN02]                      NUMERIC (38, 20) NOT NULL,
    [EMDN03]                      NUMERIC (38, 20) NOT NULL,
    [EMDN04]                      NUMERIC (38, 20) NOT NULL,
    [EMDN05]                      NUMERIC (38, 20) NOT NULL,
    [EMDD01]                      DATETIME         NOT NULL,
    [EMDD02]                      DATETIME         NOT NULL,
    [EMDD03]                      DATETIME         NOT NULL,
    [EMDD04]                      DATETIME         NOT NULL,
    [EMDD05]                      DATETIME         NOT NULL,
    [DeletedFlag]                 VARCHAR (1)      NOT NULL,
    [KeepDuringRollback]          VARCHAR (1)      NOT NULL
);
END


GO
PRINT N'Creating [dbo].[ttdStagingExportDetail_OUT_HIST].[CIX_ttdStagingExportDetail_OUT_HIST]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_ttdStagingExportDetail_OUT_HIST' AND object_id = object_id('ttdStagingExportDetail_OUT_HIST'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_ttdStagingExportDetail_OUT_HIST]
    ON [dbo].[ttdStagingExportDetail_OUT_HIST]([EffDate] ASC);
END


GO
PRINT N'Creating [dbo].[ttdStagingInprocessBindingRulingsNightlyExtract]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingInprocessBindingRulingsNightlyExtract' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingInprocessBindingRulingsNightlyExtract] (
    [PartnerID]              INT          NOT NULL,
    [EffDate]                DATETIME     NOT NULL,
    [BindingRulingGUID]      VARCHAR (50) NOT NULL,
    [ProdClassificationGUID] VARCHAR (50) NOT NULL,
    [DeletedFlag]            VARCHAR (1)  NOT NULL,
    [KeepDuringRollback]     VARCHAR (1)  NOT NULL
);
END


GO
PRINT N'Creating [dbo].[ttdStagingInprocessBindingRulingsNightlyExtract].[CIX_ttdStagingInprocessBindingRulingsNightlyExtract]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_ttdStagingInprocessBindingRulingsNightlyExtract' AND object_id = object_id('ttdStagingInprocessBindingRulingsNightlyExtract'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_ttdStagingInprocessBindingRulingsNightlyExtract]
    ON [dbo].[ttdStagingInprocessBindingRulingsNightlyExtract]([EffDate] ASC);
END


GO
PRINT N'Creating [dbo].[ttdStagingInprocessChargesNightlyExtract]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingInprocessChargesNightlyExtract' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingInprocessChargesNightlyExtract] (
    [PartnerID]                    INT          NOT NULL,
    [EffDate]                      DATETIME     NOT NULL,
    [ProdClassificationGUID]       VARCHAR (50) NOT NULL,
    [ProdClassificationDetailGUID] VARCHAR (50) NOT NULL,
    [ChargeDetailGUID]             VARCHAR (50) NOT NULL,
    [DeletedFlag]                  VARCHAR (1)  NOT NULL,
    [KeepDuringRollback]           VARCHAR (1)  NOT NULL
);
END


GO
PRINT N'Creating [dbo].[ttdStagingInprocessChargesNightlyExtract].[CIX_ttdStagingInprocessChargesNightlyExtract]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_ttdStagingInprocessChargesNightlyExtract' AND object_id = object_id('ttdStagingInprocessChargesNightlyExtract'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_ttdStagingInprocessChargesNightlyExtract]
    ON [dbo].[ttdStagingInprocessChargesNightlyExtract]([ProdClassificationGUID] ASC, [ProdClassificationDetailGUID] ASC, [ChargeDetailGUID] ASC);
END


GO
PRINT N'Creating [dbo].[ttdStagingInprocessCommercialDocumentsNightlyExtract]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingInprocessCommercialDocumentsNightlyExtract' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingInprocessCommercialDocumentsNightlyExtract] (
    [PartnerID]          INT          NOT NULL,
    [EffDate]            DATETIME     NOT NULL,
    [Country]            VARCHAR (20) NOT NULL,
    [DeletedFlag]        VARCHAR (1)  NOT NULL,
    [KeepDuringRollback] VARCHAR (1)  NOT NULL
);
END


GO
PRINT N'Creating [dbo].[ttdStagingInprocessCommercialDocumentsNightlyExtract].[CIX_ttdStagingInprocessCommercialDocumentsNightlyExtract]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_ttdStagingInprocessCommercialDocumentsNightlyExtract' AND object_id = object_id('ttdStagingInprocessCommercialDocumentsNightlyExtract'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_ttdStagingInprocessCommercialDocumentsNightlyExtract]
    ON [dbo].[ttdStagingInprocessCommercialDocumentsNightlyExtract]([EffDate] ASC);
END


GO
PRINT N'Creating [dbo].[ttdStagingInprocessCountryGroupCodeNightlyExtract]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingInprocessCountryGroupCodeNightlyExtract' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingInprocessCountryGroupCodeNightlyExtract] (
    [PartnerID]          INT          NOT NULL,
    [EffDate]            DATETIME     NOT NULL,
    [CountryGroupGUID]   VARCHAR (50) NOT NULL,
    [DeletedFlag]        VARCHAR (1)  NOT NULL,
    [KeepDuringRollback] VARCHAR (1)  NOT NULL
);
END


GO
PRINT N'Creating [dbo].[ttdStagingInprocessCountryGroupCodeNightlyExtract].[CIX_ttdStagingInprocessCountryGroupCodeNightlyExtract]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_ttdStagingInprocessCountryGroupCodeNightlyExtract' AND object_id = object_id('ttdStagingInprocessCountryGroupCodeNightlyExtract'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_ttdStagingInprocessCountryGroupCodeNightlyExtract]
    ON [dbo].[ttdStagingInprocessCountryGroupCodeNightlyExtract]([EffDate] ASC);
END


GO
PRINT N'Creating [dbo].[ttdStagingInprocessDPSSanctionsNightlyExtract]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingInprocessDPSSanctionsNightlyExtract' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingInprocessDPSSanctionsNightlyExtract] (
    [PartnerID]          INT         NOT NULL,
    [EffDate]            DATETIME    NOT NULL,
    [RegListID]          INT         NOT NULL,
    [RegEntityID]        INT         NOT NULL,
    [DeletedFlag]        VARCHAR (1) NOT NULL,
    [KeepDuringRollback] VARCHAR (1) NOT NULL
);
END


GO
PRINT N'Creating [dbo].[ttdStagingInprocessDPSSanctionsNightlyExtract].[CIX_ttdStagingInprocessDPSSanctionsNightlyExtract]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_ttdStagingInprocessDPSSanctionsNightlyExtract' AND object_id = object_id('ttdStagingInprocessDPSSanctionsNightlyExtract'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_ttdStagingInprocessDPSSanctionsNightlyExtract]
    ON [dbo].[ttdStagingInprocessDPSSanctionsNightlyExtract]([EffDate] ASC);
END


GO
PRINT N'Creating [dbo].[ttdStagingInprocessECNControlReasonsNightlyExtract]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingInprocessECNControlReasonsNightlyExtract' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingInprocessECNControlReasonsNightlyExtract] (
    [PartnerID]               INT             NOT NULL,
    [EffDate]                 DATETIME        NOT NULL,
    [RegListID]               INT             NOT NULL,
    [RegListDetailNum]        VARCHAR (50)    NOT NULL,
    [GroupCodeName]           VARCHAR (40)    NOT NULL,
    [ProductGroupDescription] NVARCHAR (1250) NOT NULL,
    [DeletedFlag]             VARCHAR (1)     NOT NULL,
    [KeepDuringRollback]      VARCHAR (1)     NOT NULL
);
END


GO
PRINT N'Creating [dbo].[ttdStagingInprocessECNControlReasonsNightlyExtract].[CIX_ttdStagingInprocessECNControlReasonsNightlyExtract]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_ttdStagingInprocessECNControlReasonsNightlyExtract' AND object_id = object_id('ttdStagingInprocessECNControlReasonsNightlyExtract'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_ttdStagingInprocessECNControlReasonsNightlyExtract]
    ON [dbo].[ttdStagingInprocessECNControlReasonsNightlyExtract]([EffDate] ASC);
END


GO
PRINT N'Creating [dbo].[ttdStagingInprocessECNNightlyExtract]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingInprocessECNNightlyExtract' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingInprocessECNNightlyExtract] (
    [PartnerID]          INT         NOT NULL,
    [EffDate]            DATETIME    NOT NULL,
    [RegListID]          INT         NOT NULL,
    [RegDenyID]          INT         NOT NULL,
    [DeletedFlag]        VARCHAR (1) NOT NULL,
    [KeepDuringRollback] VARCHAR (1) NOT NULL
);
END


GO
PRINT N'Creating [dbo].[ttdStagingInprocessECNNightlyExtract].[CIX_ttdStagingInprocessECNNightlyExtract]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_ttdStagingInprocessECNNightlyExtract' AND object_id = object_id('ttdStagingInprocessECNNightlyExtract'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_ttdStagingInprocessECNNightlyExtract]
    ON [dbo].[ttdStagingInprocessECNNightlyExtract]([RegListID] ASC, [RegDenyID] ASC);
END


GO
PRINT N'Creating [dbo].[ttdStagingInprocessECNRegulationGroupsNightlyExtract]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingInprocessECNRegulationGroupsNightlyExtract' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingInprocessECNRegulationGroupsNightlyExtract] (
    [PartnerID]          INT          NOT NULL,
    [EffDate]            DATETIME     NOT NULL,
    [RegListID]          INT          NOT NULL,
    [GroupCodeName]      VARCHAR (40) NOT NULL,
    [DeletedFlag]        VARCHAR (1)  NOT NULL,
    [KeepDuringRollback] VARCHAR (1)  NOT NULL
);
END


GO
PRINT N'Creating [dbo].[ttdStagingInprocessECNRegulationGroupsNightlyExtract].[CIX_ttdStagingInprocessECNRegulationGroupsNightlyExtract]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_ttdStagingInprocessECNRegulationGroupsNightlyExtract' AND object_id = object_id('ttdStagingInprocessECNRegulationGroupsNightlyExtract'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_ttdStagingInprocessECNRegulationGroupsNightlyExtract]
    ON [dbo].[ttdStagingInprocessECNRegulationGroupsNightlyExtract]([EffDate] ASC);
END


GO
PRINT N'Creating [dbo].[ttdStagingInprocessHSDescUOMNightlyExtract]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingInprocessHSDescUOMNightlyExtract' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingInprocessHSDescUOMNightlyExtract] (
    [PartnerID]                    INT          NOT NULL,
    [EffDate]                      DATETIME     NOT NULL,
    [ProdClassificationGUID]       VARCHAR (50) NOT NULL,
    [ProdClassificationDetailGUID] VARCHAR (50) NOT NULL,
    [DeletedFlag]                  VARCHAR (1)  NOT NULL,
    [KeepDuringRollback]           VARCHAR (1)  NOT NULL
);
END


GO
PRINT N'Creating [dbo].[ttdStagingInprocessHSDescUOMNightlyExtract].[CIX_ttdStagingInprocessHSDescUOMNightlyExtract]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_ttdStagingInprocessHSDescUOMNightlyExtract' AND object_id = object_id('ttdStagingInprocessHSDescUOMNightlyExtract'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_ttdStagingInprocessHSDescUOMNightlyExtract]
    ON [dbo].[ttdStagingInprocessHSDescUOMNightlyExtract]([ProdClassificationGUID] ASC, [ProdClassificationDetailGUID] ASC);
END


GO
PRINT N'Creating [dbo].[ttdStagingInprocessRelatedControlsNightlyExtract]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingInprocessRelatedControlsNightlyExtract' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingInprocessRelatedControlsNightlyExtract] (
    [PartnerID]              INT           NOT NULL,
    [EffDate]                DATETIME      NOT NULL,
    [ProdClassificationGUID] VARCHAR (50)  NOT NULL,
    [Number]                 NVARCHAR (50) NOT NULL,
    [DeletedFlag]            VARCHAR (1)   NOT NULL,
    [KeepDuringRollback]     VARCHAR (1)   NOT NULL
);
END


GO
PRINT N'Creating [dbo].[ttdStagingInprocessRelatedControlsNightlyExtract].[CIX_ttdStagingInprocessRelatedControlsNightlyExtract]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_ttdStagingInprocessRelatedControlsNightlyExtract' AND object_id = object_id('ttdStagingInprocessRelatedControlsNightlyExtract'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_ttdStagingInprocessRelatedControlsNightlyExtract]
    ON [dbo].[ttdStagingInprocessRelatedControlsNightlyExtract]([EffDate] ASC);
END


GO
PRINT N'Creating [dbo].[ttdStagingInprocessStandardDPSNightlyExtract]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingInprocessStandardDPSNightlyExtract' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingInprocessStandardDPSNightlyExtract] (
    [PartnerID]          INT         NOT NULL,
    [EffDate]            DATETIME    NOT NULL,
    [RegListID]          INT         NOT NULL,
    [RegEntityID]        INT         NOT NULL,
    [DeletedFlag]        VARCHAR (1) NOT NULL,
    [KeepDuringRollback] VARCHAR (1) NOT NULL
);
END


GO
PRINT N'Creating [dbo].[ttdStagingInprocessStandardDPSNightlyExtract].[CIX_ttdStagingInprocessStandardDPSNightlyExtract]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_ttdStagingInprocessStandardDPSNightlyExtract' AND object_id = object_id('ttdStagingInprocessStandardDPSNightlyExtract'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_ttdStagingInprocessStandardDPSNightlyExtract]
    ON [dbo].[ttdStagingInprocessStandardDPSNightlyExtract]([EffDate] ASC);
END


GO
PRINT N'Creating [dbo].[ttdStagingSAProductClassification]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingSAProductClassification' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingSAProductClassification] (
    [PartnerID]                   INT              NOT NULL,
    [EffDate]                     DATETIME         NOT NULL,
    [ProductGuid]                 VARCHAR (50)     NOT NULL,
    [ProductNum]                  NVARCHAR (50)    NOT NULL,
    [ProductDesc]                 NVARCHAR (350)   NOT NULL,
    [ProductName]                 NVARCHAR (50)    NOT NULL,
    [SupplierID]                  VARCHAR (30)     NOT NULL,
    [ManufacturerId]              VARCHAR (15)     NOT NULL,
    [BusinessUnit]                NVARCHAR (50)    NOT NULL,
    [BusinessDivision]            NVARCHAR (50)    NOT NULL,
    [ProductGroup]                NVARCHAR (30)    NOT NULL,
    [ProductTypeCode]             VARCHAR (2)      NOT NULL,
    [TaxID]                       VARCHAR (20)     NOT NULL,
    [TaxIDSuffix]                 VARCHAR (20)     NOT NULL,
    [Notes]                       NVARCHAR (MAX)   NOT NULL,
    [Value]                       NUMERIC (38, 20) NOT NULL,
    [Value2]                      NUMERIC (38, 20) NOT NULL,
    [CurrencyCode]                VARCHAR (3)      NOT NULL,
    [CommercialValue]             NUMERIC (38, 20) NOT NULL,
    [CommercialValueCurrencyCode] VARCHAR (3)      NOT NULL,
    [ProductMaterial]             NVARCHAR (200)   NOT NULL,
    [NetWeight]                   NUMERIC (38, 20) NOT NULL,
    [GrossWeight]                 NUMERIC (38, 20) NOT NULL,
    [WeightUOM]                   VARCHAR (3)      NOT NULL,
    [TxnQtyUOM]                   VARCHAR (3)      NOT NULL,
    [HSUOMConvFactor]             NUMERIC (38, 20) NOT NULL,
    [AddlHSUOMConvFactor]         NUMERIC (38, 20) NOT NULL,
    [HsNum]                       VARCHAR (12)     NOT NULL,
    [HsNum2]                      VARCHAR (12)     NOT NULL,
    [HsInProgress]                VARCHAR (15)     NOT NULL,
    [AssuranceLevel]              VARCHAR (10)     NOT NULL,
    [HsRationale]                 NVARCHAR (MAX)   NOT NULL,
    [GRI]                         VARCHAR (100)    NOT NULL,
    [BindingRuling]               VARCHAR (100)    NOT NULL,
    [RulingNotes]                 NVARCHAR (MAX)   NOT NULL,
    [ExportTariffNum]             VARCHAR (15)     NOT NULL,
    [ECNNum]                      VARCHAR (50)     NOT NULL,
    [PreferenceCode1]             VARCHAR (10)     NOT NULL,
    [PreferenceCode2]             VARCHAR (10)     NOT NULL,
    [CountryOfOrigin]             VARCHAR (2)      NOT NULL,
    [CPC1]                        VARCHAR (10)     NOT NULL,
    [CPC2]                        VARCHAR (10)     NOT NULL,
    [WCOEN]                       VARCHAR (100)    NOT NULL,
    [CASNum]                      VARCHAR (50)     NOT NULL,
    [HazMatFlag]                  VARCHAR (1)      NOT NULL,
    [UNNum]                       VARCHAR (10)     NOT NULL,
    [ProperShippingName]          NVARCHAR (100)   NOT NULL,
    [HazardClass]                 VARCHAR (10)     NOT NULL,
    [PackingGroup]                VARCHAR (10)     NOT NULL,
    [SubRisk]                     VARCHAR (10)     NOT NULL,
    [Flashpoint]                  VARCHAR (10)     NOT NULL,
    [MarinePollutant]             VARCHAR (10)     NOT NULL,
    [UNPackagingCode]             VARCHAR (10)     NOT NULL,
    [TechnicalName]               NVARCHAR (100)   NOT NULL,
    [AuditDate]                   DATETIME         NOT NULL,
    [AuditNotes]                  NVARCHAR (MAX)   NOT NULL,
    [ApprovedBy]                  VARCHAR (80)     NOT NULL,
    [ApprovalDate]                DATETIME         NOT NULL,
    [CreatedDate]                 DATETIME         NOT NULL,
    [CreatedBy]                   VARCHAR (80)     NOT NULL,
    [ModifiedDate]                DATETIME         NOT NULL,
    [ModifiedBy]                  VARCHAR (80)     NOT NULL,
    [FTZActiveFlag]               VARCHAR (1)      NOT NULL,
    [ActiveFlag]                  VARCHAR (1)      NOT NULL,
    [ZoneStatusCode]              VARCHAR (20)     NOT NULL,
    [SAGCS01]                     NVARCHAR (50)    NOT NULL,
    [SAGCS02]                     NVARCHAR (50)    NOT NULL,
    [SAGCS03]                     NVARCHAR (50)    NOT NULL,
    [SAGCS04]                     NVARCHAR (50)    NOT NULL,
    [SAGCS05]                     NVARCHAR (50)    NOT NULL,
    [SAGCS06]                     NVARCHAR (50)    NOT NULL,
    [SAGCS07]                     NVARCHAR (50)    NOT NULL,
    [SAGCS08]                     NVARCHAR (50)    NOT NULL,
    [SAGCS09]                     NVARCHAR (50)    NOT NULL,
    [SAGCS10]                     NVARCHAR (50)    NOT NULL,
    [SAGCS11]                     NVARCHAR (50)    NOT NULL,
    [SAGCS12]                     NVARCHAR (50)    NOT NULL,
    [SAGCS13]                     NVARCHAR (50)    NOT NULL,
    [SAGCS14]                     NVARCHAR (50)    NOT NULL,
    [SAGCS15]                     NVARCHAR (50)    NOT NULL,
    [SAGCL01]                     NVARCHAR (500)   NOT NULL,
    [SAGCL02]                     NVARCHAR (500)   NOT NULL,
    [SAGCL03]                     NVARCHAR (500)   NOT NULL,
    [SAGCL04]                     NVARCHAR (500)   NOT NULL,
    [SAGCL05]                     NVARCHAR (500)   NOT NULL,
    [SAGCN01]                     NUMERIC (38, 20) NOT NULL,
    [SAGCN02]                     NUMERIC (38, 20) NOT NULL,
    [SAGCN03]                     NUMERIC (38, 20) NOT NULL,
    [SAGCN04]                     NUMERIC (38, 20) NOT NULL,
    [SAGCN05]                     NUMERIC (38, 20) NOT NULL,
    [SAGCD01]                     DATETIME         NOT NULL,
    [SAGCD02]                     DATETIME         NOT NULL,
    [SAGCD03]                     DATETIME         NOT NULL,
    [SAGCD04]                     DATETIME         NOT NULL,
    [SAGCD05]                     DATETIME         NOT NULL,
    [ExistingProductFlag]         VARCHAR (1)      NOT NULL,
    [DeletedFlag]                 VARCHAR (1)      NOT NULL,
    [KeepDuringRollback]          VARCHAR (1)      NOT NULL
);
END


GO
PRINT N'Creating [dbo].[ttdStagingSAProductClassification].[CIX_ttdStagingSAProductClassification]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_ttdStagingSAProductClassification' AND object_id = object_id('ttdStagingSAProductClassification'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_ttdStagingSAProductClassification]
    ON [dbo].[ttdStagingSAProductClassification]([EffDate] ASC);
END


GO
PRINT N'Creating [dbo].[ttdStagingSAProductClassification].[IX_ttdStagingSAProductClassification_1]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='IX_ttdStagingSAProductClassification_1' AND object_id = object_id('ttdStagingSAProductClassification'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE NONCLUSTERED INDEX [IX_ttdStagingSAProductClassification_1]
    ON [dbo].[ttdStagingSAProductClassification]([PartnerID] ASC, [ProductGuid] ASC);
END


GO
PRINT N'Creating [dbo].[ttdStagingSAProductClassificationHist]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingSAProductClassificationHist' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingSAProductClassificationHist] (
    [PartnerID]                   INT              NOT NULL,
    [EffDate]                     DATETIME         NOT NULL,
    [ProductGuid]                 VARCHAR (50)     NOT NULL,
    [ProductNum]                  NVARCHAR (50)    NOT NULL,
    [ProductDesc]                 NVARCHAR (350)   NOT NULL,
    [ProductName]                 NVARCHAR (50)    NOT NULL,
    [SupplierID]                  VARCHAR (30)     NOT NULL,
    [ManufacturerId]              VARCHAR (15)     NOT NULL,
    [BusinessUnit]                NVARCHAR (50)    NOT NULL,
    [BusinessDivision]            NVARCHAR (50)    NOT NULL,
    [ProductGroup]                NVARCHAR (30)    NOT NULL,
    [ProductTypeCode]             VARCHAR (2)      NOT NULL,
    [TaxID]                       VARCHAR (20)     NOT NULL,
    [TaxIDSuffix]                 VARCHAR (20)     NOT NULL,
    [Notes]                       NVARCHAR (MAX)   NOT NULL,
    [Value]                       NUMERIC (38, 20) NOT NULL,
    [Value2]                      NUMERIC (38, 20) NOT NULL,
    [CurrencyCode]                VARCHAR (3)      NOT NULL,
    [CommercialValue]             NUMERIC (38, 20) NOT NULL,
    [CommercialValueCurrencyCode] VARCHAR (3)      NOT NULL,
    [ProductMaterial]             NVARCHAR (200)   NOT NULL,
    [NetWeight]                   NUMERIC (38, 20) NOT NULL,
    [GrossWeight]                 NUMERIC (38, 20) NOT NULL,
    [WeightUOM]                   VARCHAR (3)      NOT NULL,
    [TxnQtyUOM]                   VARCHAR (3)      NOT NULL,
    [HSUOMConvFactor]             NUMERIC (38, 20) NOT NULL,
    [AddlHSUOMConvFactor]         NUMERIC (38, 20) NOT NULL,
    [HsNum]                       VARCHAR (12)     NOT NULL,
    [HsNum2]                      VARCHAR (12)     NOT NULL,
    [HsInProgress]                VARCHAR (15)     NOT NULL,
    [AssuranceLevel]              VARCHAR (10)     NOT NULL,
    [HsRationale]                 NVARCHAR (MAX)   NOT NULL,
    [GRI]                         VARCHAR (100)    NOT NULL,
    [BindingRuling]               VARCHAR (100)    NOT NULL,
    [RulingNotes]                 NVARCHAR (MAX)   NOT NULL,
    [ExportTariffNum]             VARCHAR (15)     NOT NULL,
    [ECNNum]                      VARCHAR (50)     NOT NULL,
    [PreferenceCode1]             VARCHAR (10)     NOT NULL,
    [PreferenceCode2]             VARCHAR (10)     NOT NULL,
    [CountryOfOrigin]             VARCHAR (2)      NOT NULL,
    [CPC1]                        VARCHAR (10)     NOT NULL,
    [CPC2]                        VARCHAR (10)     NOT NULL,
    [WCOEN]                       VARCHAR (100)    NOT NULL,
    [CASNum]                      VARCHAR (50)     NOT NULL,
    [HazMatFlag]                  VARCHAR (1)      NOT NULL,
    [UNNum]                       VARCHAR (10)     NOT NULL,
    [ProperShippingName]          NVARCHAR (100)   NOT NULL,
    [HazardClass]                 VARCHAR (10)     NOT NULL,
    [PackingGroup]                VARCHAR (10)     NOT NULL,
    [SubRisk]                     VARCHAR (10)     NOT NULL,
    [Flashpoint]                  VARCHAR (10)     NOT NULL,
    [MarinePollutant]             VARCHAR (10)     NOT NULL,
    [UNPackagingCode]             VARCHAR (10)     NOT NULL,
    [TechnicalName]               NVARCHAR (100)   NOT NULL,
    [AuditDate]                   DATETIME         NOT NULL,
    [AuditNotes]                  NVARCHAR (MAX)   NOT NULL,
    [ApprovedBy]                  VARCHAR (80)     NOT NULL,
    [ApprovalDate]                DATETIME         NOT NULL,
    [CreatedDate]                 DATETIME         NOT NULL,
    [CreatedBy]                   VARCHAR (80)     NOT NULL,
    [ModifiedDate]                DATETIME         NOT NULL,
    [ModifiedBy]                  VARCHAR (80)     NOT NULL,
    [FTZActiveFlag]               VARCHAR (1)      NOT NULL,
    [ActiveFlag]                  VARCHAR (1)      NOT NULL,
    [ZoneStatusCode]              VARCHAR (20)     NOT NULL,
    [SAGCS01]                     NVARCHAR (50)    NOT NULL,
    [SAGCS02]                     NVARCHAR (50)    NOT NULL,
    [SAGCS03]                     NVARCHAR (50)    NOT NULL,
    [SAGCS04]                     NVARCHAR (50)    NOT NULL,
    [SAGCS05]                     NVARCHAR (50)    NOT NULL,
    [SAGCS06]                     NVARCHAR (50)    NOT NULL,
    [SAGCS07]                     NVARCHAR (50)    NOT NULL,
    [SAGCS08]                     NVARCHAR (50)    NOT NULL,
    [SAGCS09]                     NVARCHAR (50)    NOT NULL,
    [SAGCS10]                     NVARCHAR (50)    NOT NULL,
    [SAGCS11]                     NVARCHAR (50)    NOT NULL,
    [SAGCS12]                     NVARCHAR (50)    NOT NULL,
    [SAGCS13]                     NVARCHAR (50)    NOT NULL,
    [SAGCS14]                     NVARCHAR (50)    NOT NULL,
    [SAGCS15]                     NVARCHAR (50)    NOT NULL,
    [SAGCL01]                     NVARCHAR (500)   NOT NULL,
    [SAGCL02]                     NVARCHAR (500)   NOT NULL,
    [SAGCL03]                     NVARCHAR (500)   NOT NULL,
    [SAGCL04]                     NVARCHAR (500)   NOT NULL,
    [SAGCL05]                     NVARCHAR (500)   NOT NULL,
    [SAGCN01]                     NUMERIC (38, 20) NOT NULL,
    [SAGCN02]                     NUMERIC (38, 20) NOT NULL,
    [SAGCN03]                     NUMERIC (38, 20) NOT NULL,
    [SAGCN04]                     NUMERIC (38, 20) NOT NULL,
    [SAGCN05]                     NUMERIC (38, 20) NOT NULL,
    [SAGCD01]                     DATETIME         NOT NULL,
    [SAGCD02]                     DATETIME         NOT NULL,
    [SAGCD03]                     DATETIME         NOT NULL,
    [SAGCD04]                     DATETIME         NOT NULL,
    [SAGCD05]                     DATETIME         NOT NULL,
    [ExistingProductFlag]         VARCHAR (1)      NOT NULL,
    [DeletedFlag]                 VARCHAR (1)      NOT NULL,
    [KeepDuringRollback]          VARCHAR (1)      NOT NULL
);
END


GO
PRINT N'Creating [dbo].[ttdStagingSAProductClassificationHist].[CIX_ttdStagingSAProductClassificationHist]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_ttdStagingSAProductClassificationHist' AND object_id = object_id('ttdStagingSAProductClassificationHist'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_ttdStagingSAProductClassificationHist]
    ON [dbo].[ttdStagingSAProductClassificationHist]([EffDate] ASC);
END


GO
PRINT N'Creating [dbo].[ttdStagingSAProductClassificationHist].[IX_ttdStagingSAProductClassificationHist_1]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='IX_ttdStagingSAProductClassificationHist_1' AND object_id = object_id('ttdStagingSAProductClassificationHist'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE NONCLUSTERED INDEX [IX_ttdStagingSAProductClassificationHist_1]
    ON [dbo].[ttdStagingSAProductClassificationHist]([PartnerID] ASC, [ProductGuid] ASC);
END


GO
PRINT N'Creating [dbo].[ttdStagingTRProductClassification]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingTRProductClassification' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingTRProductClassification] (
    [PartnerID]                   INT              NOT NULL,
    [EffDate]                     DATETIME         NOT NULL,
    [ProductGuid]                 VARCHAR (50)     NOT NULL,
    [ProductNum]                  NVARCHAR (50)    NOT NULL,
    [ProductDesc]                 NVARCHAR (350)   NOT NULL,
    [ProductName]                 NVARCHAR (50)    NOT NULL,
    [SupplierID]                  VARCHAR (30)     NOT NULL,
    [ManufacturerId]              VARCHAR (15)     NOT NULL,
    [BusinessUnit]                NVARCHAR (50)    NOT NULL,
    [BusinessDivision]            NVARCHAR (50)    NOT NULL,
    [ProductGroup]                NVARCHAR (30)    NOT NULL,
    [ProductTypeCode]             VARCHAR (2)      NOT NULL,
    [TaxID]                       VARCHAR (20)     NOT NULL,
    [TaxIDSuffix]                 VARCHAR (20)     NOT NULL,
    [Notes]                       NVARCHAR (MAX)   NOT NULL,
    [Value]                       NUMERIC (38, 20) NOT NULL,
    [Value2]                      NUMERIC (38, 20) NOT NULL,
    [CurrencyCode]                VARCHAR (3)      NOT NULL,
    [CommercialValue]             NUMERIC (38, 20) NOT NULL,
    [CommercialValueCurrencyCode] VARCHAR (3)      NOT NULL,
    [ProductMaterial]             NVARCHAR (200)   NOT NULL,
    [NetWeight]                   NUMERIC (38, 20) NOT NULL,
    [GrossWeight]                 NUMERIC (38, 20) NOT NULL,
    [WeightUOM]                   VARCHAR (3)      NOT NULL,
    [TxnQtyUOM]                   VARCHAR (3)      NOT NULL,
    [HSUOMConvFactor]             NUMERIC (38, 20) NOT NULL,
    [AddlHSUOMConvFactor]         NUMERIC (38, 20) NOT NULL,
    [HsNum]                       VARCHAR (12)     NOT NULL,
    [HsNum2]                      VARCHAR (12)     NOT NULL,
    [HsInProgress]                VARCHAR (15)     NOT NULL,
    [AssuranceLevel]              VARCHAR (10)     NOT NULL,
    [HsRationale]                 NVARCHAR (MAX)   NOT NULL,
    [GRI]                         VARCHAR (100)    NOT NULL,
    [BindingRuling]               VARCHAR (100)    NOT NULL,
    [RulingNotes]                 NVARCHAR (MAX)   NOT NULL,
    [ExportTariffNum]             VARCHAR (15)     NOT NULL,
    [ECNNum]                      VARCHAR (50)     NOT NULL,
    [PreferenceCode1]             VARCHAR (10)     NOT NULL,
    [PreferenceCode2]             VARCHAR (10)     NOT NULL,
    [CountryOfOrigin]             VARCHAR (2)      NOT NULL,
    [CPC1]                        VARCHAR (10)     NOT NULL,
    [CPC2]                        VARCHAR (10)     NOT NULL,
    [WCOEN]                       VARCHAR (100)    NOT NULL,
    [CASNum]                      VARCHAR (50)     NOT NULL,
    [HazMatFlag]                  VARCHAR (1)      NOT NULL,
    [UNNum]                       VARCHAR (10)     NOT NULL,
    [ProperShippingName]          NVARCHAR (100)   NOT NULL,
    [HazardClass]                 VARCHAR (10)     NOT NULL,
    [PackingGroup]                VARCHAR (10)     NOT NULL,
    [SubRisk]                     VARCHAR (10)     NOT NULL,
    [Flashpoint]                  VARCHAR (10)     NOT NULL,
    [MarinePollutant]             VARCHAR (10)     NOT NULL,
    [UNPackagingCode]             VARCHAR (10)     NOT NULL,
    [TechnicalName]               NVARCHAR (100)   NOT NULL,
    [AuditDate]                   DATETIME         NOT NULL,
    [AuditNotes]                  NVARCHAR (MAX)   NOT NULL,
    [ApprovedBy]                  VARCHAR (80)     NOT NULL,
    [ApprovalDate]                DATETIME         NOT NULL,
    [CreatedDate]                 DATETIME         NOT NULL,
    [CreatedBy]                   VARCHAR (80)     NOT NULL,
    [ModifiedDate]                DATETIME         NOT NULL,
    [ModifiedBy]                  VARCHAR (80)     NOT NULL,
    [FTZActiveFlag]               VARCHAR (1)      NOT NULL,
    [ActiveFlag]                  VARCHAR (1)      NOT NULL,
    [ZoneStatusCode]              VARCHAR (20)     NOT NULL,
    [TRGCS01]                     NVARCHAR (50)    NOT NULL,
    [TRGCS02]                     NVARCHAR (50)    NOT NULL,
    [TRGCS03]                     NVARCHAR (50)    NOT NULL,
    [TRGCS04]                     NVARCHAR (50)    NOT NULL,
    [TRGCS05]                     NVARCHAR (50)    NOT NULL,
    [TRGCS06]                     NVARCHAR (50)    NOT NULL,
    [TRGCS07]                     NVARCHAR (50)    NOT NULL,
    [TRGCS08]                     NVARCHAR (50)    NOT NULL,
    [TRGCS09]                     NVARCHAR (50)    NOT NULL,
    [TRGCS10]                     NVARCHAR (50)    NOT NULL,
    [TRGCS11]                     NVARCHAR (50)    NOT NULL,
    [TRGCS12]                     NVARCHAR (50)    NOT NULL,
    [TRGCS13]                     NVARCHAR (50)    NOT NULL,
    [TRGCS14]                     NVARCHAR (50)    NOT NULL,
    [TRGCS15]                     NVARCHAR (50)    NOT NULL,
    [TRGCL01]                     NVARCHAR (500)   NOT NULL,
    [TRGCL02]                     NVARCHAR (500)   NOT NULL,
    [TRGCL03]                     NVARCHAR (500)   NOT NULL,
    [TRGCL04]                     NVARCHAR (500)   NOT NULL,
    [TRGCL05]                     NVARCHAR (500)   NOT NULL,
    [TRGCN01]                     NUMERIC (38, 20) NOT NULL,
    [TRGCN02]                     NUMERIC (38, 20) NOT NULL,
    [TRGCN03]                     NUMERIC (38, 20) NOT NULL,
    [TRGCN04]                     NUMERIC (38, 20) NOT NULL,
    [TRGCN05]                     NUMERIC (38, 20) NOT NULL,
    [TRGCD01]                     DATETIME         NOT NULL,
    [TRGCD02]                     DATETIME         NOT NULL,
    [TRGCD03]                     DATETIME         NOT NULL,
    [TRGCD04]                     DATETIME         NOT NULL,
    [TRGCD05]                     DATETIME         NOT NULL,
    [ExistingProductFlag]         VARCHAR (1)      NOT NULL,
    [DeletedFlag]                 VARCHAR (1)      NOT NULL,
    [KeepDuringRollback]          VARCHAR (1)      NOT NULL
);
END


GO
PRINT N'Creating [dbo].[ttdStagingTRProductClassification].[CIX_ttdStagingTRProductClassification]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_ttdStagingTRProductClassification' AND object_id = object_id('ttdStagingTRProductClassification'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_ttdStagingTRProductClassification]
    ON [dbo].[ttdStagingTRProductClassification]([EffDate] ASC);
END


GO
PRINT N'Creating [dbo].[ttdStagingTRProductClassification].[IX_ttdStagingTRProductClassification_1]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='IX_ttdStagingTRProductClassification_1' AND object_id = object_id('ttdStagingTRProductClassification'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE NONCLUSTERED INDEX [IX_ttdStagingTRProductClassification_1]
    ON [dbo].[ttdStagingTRProductClassification]([PartnerID] ASC, [ProductGuid] ASC);
END


GO
PRINT N'Creating [dbo].[ttdStagingTRProductClassificationHist]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingTRProductClassificationHist' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingTRProductClassificationHist] (
    [PartnerID]                   INT              NOT NULL,
    [EffDate]                     DATETIME         NOT NULL,
    [ProductGuid]                 VARCHAR (50)     NOT NULL,
    [ProductNum]                  NVARCHAR (50)    NOT NULL,
    [ProductDesc]                 NVARCHAR (350)   NOT NULL,
    [ProductName]                 NVARCHAR (50)    NOT NULL,
    [SupplierID]                  VARCHAR (30)     NOT NULL,
    [ManufacturerId]              VARCHAR (15)     NOT NULL,
    [BusinessUnit]                NVARCHAR (50)    NOT NULL,
    [BusinessDivision]            NVARCHAR (50)    NOT NULL,
    [ProductGroup]                NVARCHAR (30)    NOT NULL,
    [ProductTypeCode]             VARCHAR (2)      NOT NULL,
    [TaxID]                       VARCHAR (20)     NOT NULL,
    [TaxIDSuffix]                 VARCHAR (20)     NOT NULL,
    [Notes]                       NVARCHAR (MAX)   NOT NULL,
    [Value]                       NUMERIC (38, 20) NOT NULL,
    [Value2]                      NUMERIC (38, 20) NOT NULL,
    [CurrencyCode]                VARCHAR (3)      NOT NULL,
    [CommercialValue]             NUMERIC (38, 20) NOT NULL,
    [CommercialValueCurrencyCode] VARCHAR (3)      NOT NULL,
    [ProductMaterial]             NVARCHAR (200)   NOT NULL,
    [NetWeight]                   NUMERIC (38, 20) NOT NULL,
    [GrossWeight]                 NUMERIC (38, 20) NOT NULL,
    [WeightUOM]                   VARCHAR (3)      NOT NULL,
    [TxnQtyUOM]                   VARCHAR (3)      NOT NULL,
    [HSUOMConvFactor]             NUMERIC (38, 20) NOT NULL,
    [AddlHSUOMConvFactor]         NUMERIC (38, 20) NOT NULL,
    [HsNum]                       VARCHAR (12)     NOT NULL,
    [HsNum2]                      VARCHAR (12)     NOT NULL,
    [HsInProgress]                VARCHAR (15)     NOT NULL,
    [AssuranceLevel]              VARCHAR (10)     NOT NULL,
    [HsRationale]                 NVARCHAR (MAX)   NOT NULL,
    [GRI]                         VARCHAR (100)    NOT NULL,
    [BindingRuling]               VARCHAR (100)    NOT NULL,
    [RulingNotes]                 NVARCHAR (MAX)   NOT NULL,
    [ExportTariffNum]             VARCHAR (15)     NOT NULL,
    [ECNNum]                      VARCHAR (50)     NOT NULL,
    [PreferenceCode1]             VARCHAR (10)     NOT NULL,
    [PreferenceCode2]             VARCHAR (10)     NOT NULL,
    [CountryOfOrigin]             VARCHAR (2)      NOT NULL,
    [CPC1]                        VARCHAR (10)     NOT NULL,
    [CPC2]                        VARCHAR (10)     NOT NULL,
    [WCOEN]                       VARCHAR (100)    NOT NULL,
    [CASNum]                      VARCHAR (50)     NOT NULL,
    [HazMatFlag]                  VARCHAR (1)      NOT NULL,
    [UNNum]                       VARCHAR (10)     NOT NULL,
    [ProperShippingName]          NVARCHAR (100)   NOT NULL,
    [HazardClass]                 VARCHAR (10)     NOT NULL,
    [PackingGroup]                VARCHAR (10)     NOT NULL,
    [SubRisk]                     VARCHAR (10)     NOT NULL,
    [Flashpoint]                  VARCHAR (10)     NOT NULL,
    [MarinePollutant]             VARCHAR (10)     NOT NULL,
    [UNPackagingCode]             VARCHAR (10)     NOT NULL,
    [TechnicalName]               NVARCHAR (100)   NOT NULL,
    [AuditDate]                   DATETIME         NOT NULL,
    [AuditNotes]                  NVARCHAR (MAX)   NOT NULL,
    [ApprovedBy]                  VARCHAR (80)     NOT NULL,
    [ApprovalDate]                DATETIME         NOT NULL,
    [CreatedDate]                 DATETIME         NOT NULL,
    [CreatedBy]                   VARCHAR (80)     NOT NULL,
    [ModifiedDate]                DATETIME         NOT NULL,
    [ModifiedBy]                  VARCHAR (80)     NOT NULL,
    [FTZActiveFlag]               VARCHAR (1)      NOT NULL,
    [ActiveFlag]                  VARCHAR (1)      NOT NULL,
    [ZoneStatusCode]              VARCHAR (20)     NOT NULL,
    [TRGCS01]                     NVARCHAR (50)    NOT NULL,
    [TRGCS02]                     NVARCHAR (50)    NOT NULL,
    [TRGCS03]                     NVARCHAR (50)    NOT NULL,
    [TRGCS04]                     NVARCHAR (50)    NOT NULL,
    [TRGCS05]                     NVARCHAR (50)    NOT NULL,
    [TRGCS06]                     NVARCHAR (50)    NOT NULL,
    [TRGCS07]                     NVARCHAR (50)    NOT NULL,
    [TRGCS08]                     NVARCHAR (50)    NOT NULL,
    [TRGCS09]                     NVARCHAR (50)    NOT NULL,
    [TRGCS10]                     NVARCHAR (50)    NOT NULL,
    [TRGCS11]                     NVARCHAR (50)    NOT NULL,
    [TRGCS12]                     NVARCHAR (50)    NOT NULL,
    [TRGCS13]                     NVARCHAR (50)    NOT NULL,
    [TRGCS14]                     NVARCHAR (50)    NOT NULL,
    [TRGCS15]                     NVARCHAR (50)    NOT NULL,
    [TRGCL01]                     NVARCHAR (500)   NOT NULL,
    [TRGCL02]                     NVARCHAR (500)   NOT NULL,
    [TRGCL03]                     NVARCHAR (500)   NOT NULL,
    [TRGCL04]                     NVARCHAR (500)   NOT NULL,
    [TRGCL05]                     NVARCHAR (500)   NOT NULL,
    [TRGCN01]                     NUMERIC (38, 20) NOT NULL,
    [TRGCN02]                     NUMERIC (38, 20) NOT NULL,
    [TRGCN03]                     NUMERIC (38, 20) NOT NULL,
    [TRGCN04]                     NUMERIC (38, 20) NOT NULL,
    [TRGCN05]                     NUMERIC (38, 20) NOT NULL,
    [TRGCD01]                     DATETIME         NOT NULL,
    [TRGCD02]                     DATETIME         NOT NULL,
    [TRGCD03]                     DATETIME         NOT NULL,
    [TRGCD04]                     DATETIME         NOT NULL,
    [TRGCD05]                     DATETIME         NOT NULL,
    [ExistingProductFlag]         VARCHAR (1)      NOT NULL,
    [DeletedFlag]                 VARCHAR (1)      NOT NULL,
    [KeepDuringRollback]          VARCHAR (1)      NOT NULL
);
END


GO
PRINT N'Creating [dbo].[ttdStagingTRProductClassificationHist].[CIX_ttdStagingTRProductClassificationHist]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_ttdStagingTRProductClassificationHist' AND object_id = object_id('ttdStagingTRProductClassificationHist'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_ttdStagingTRProductClassificationHist]
    ON [dbo].[ttdStagingTRProductClassificationHist]([EffDate] ASC);
END


GO
PRINT N'Creating [dbo].[ttdStagingTRProductClassificationHist].[IX_ttdStagingTRProductClassificationHist_1]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='IX_ttdStagingTRProductClassificationHist_1' AND object_id = object_id('ttdStagingTRProductClassificationHist'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE NONCLUSTERED INDEX [IX_ttdStagingTRProductClassificationHist_1]
    ON [dbo].[ttdStagingTRProductClassificationHist]([PartnerID] ASC, [ProductGuid] ASC);
END


GO
PRINT N'Creating [dbo].[ttdStagingUnprocessedBindingRulingsNightlyExtract]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingUnprocessedBindingRulingsNightlyExtract' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingUnprocessedBindingRulingsNightlyExtract] (
    [PartnerID]              INT          NOT NULL,
    [EffDate]                DATETIME     NOT NULL,
    [BindingRulingGUID]      VARCHAR (50) NOT NULL,
    [ProdClassificationGUID] VARCHAR (50) NOT NULL,
    [ExpirationDate]         DATETIME     NOT NULL,
    [Number]                 VARCHAR (50) NOT NULL,
    [DeltaType]              VARCHAR (50) NOT NULL,
    [DeletedFlag]            VARCHAR (1)  NOT NULL,
    [KeepDuringRollback]     VARCHAR (1)  NOT NULL
);
END


GO
PRINT N'Creating [dbo].[ttdStagingUnprocessedBindingRulingsNightlyExtract].[CIX_ttdStagingUnprocessedBindingRulingsNightlyExtract]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_ttdStagingUnprocessedBindingRulingsNightlyExtract' AND object_id = object_id('ttdStagingUnprocessedBindingRulingsNightlyExtract'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_ttdStagingUnprocessedBindingRulingsNightlyExtract]
    ON [dbo].[ttdStagingUnprocessedBindingRulingsNightlyExtract]([EffDate] ASC);
END


GO
PRINT N'Creating [dbo].[ttdStagingUnprocessedBindingRulingsNightlyExtractHIST]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingUnprocessedBindingRulingsNightlyExtractHIST' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingUnprocessedBindingRulingsNightlyExtractHIST] (
    [PartnerID]              INT          NOT NULL,
    [EffDate]                DATETIME     NOT NULL,
    [BindingRulingGUID]      VARCHAR (50) NOT NULL,
    [ProdClassificationGUID] VARCHAR (50) NOT NULL,
    [ExpirationDate]         DATETIME     NOT NULL,
    [Number]                 VARCHAR (50) NOT NULL,
    [DeltaType]              VARCHAR (50) NOT NULL,
    [DeletedFlag]            VARCHAR (1)  NOT NULL,
    [KeepDuringRollback]     VARCHAR (1)  NOT NULL
);
END


GO
PRINT N'Creating [dbo].[ttdStagingUnprocessedBindingRulingsNightlyExtractHIST].[CIX_ttdStagingUnprocessedBindingRulingsNightlyExtractHIST]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_ttdStagingUnprocessedBindingRulingsNightlyExtractHIST' AND object_id = object_id('ttdStagingUnprocessedBindingRulingsNightlyExtractHIST'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_ttdStagingUnprocessedBindingRulingsNightlyExtractHIST]
    ON [dbo].[ttdStagingUnprocessedBindingRulingsNightlyExtractHIST]([EffDate] ASC);
END


GO
PRINT N'Creating [dbo].[ttdStagingUnprocessedChargesNightlyExtract]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingUnprocessedChargesNightlyExtract' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingUnprocessedChargesNightlyExtract] (
    [PartnerID]                    INT           NOT NULL,
    [EffDate]                      DATETIME      NOT NULL,
    [ProdClassificationGUID]       VARCHAR (50)  NOT NULL,
    [ProdClassificationDetailGUID] VARCHAR (50)  NOT NULL,
    [ChargeDetailGUID]             VARCHAR (50)  NOT NULL,
    [Number]                       NVARCHAR (50) NOT NULL,
    [ExpirationDate]               DATETIME      NOT NULL,
    [DeltaType]                    VARCHAR (50)  NOT NULL,
    [DeletedFlag]                  VARCHAR (1)   NOT NULL,
    [KeepDuringRollback]           VARCHAR (1)   NOT NULL
);
END


GO
PRINT N'Creating [dbo].[ttdStagingUnprocessedChargesNightlyExtract].[CIX_ttdStagingUnprocessedChargesNightlyExtract]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_ttdStagingUnprocessedChargesNightlyExtract' AND object_id = object_id('ttdStagingUnprocessedChargesNightlyExtract'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_ttdStagingUnprocessedChargesNightlyExtract]
    ON [dbo].[ttdStagingUnprocessedChargesNightlyExtract]([ProdClassificationGUID] ASC, [ProdClassificationDetailGUID] ASC, [ChargeDetailGUID] ASC);
END


GO
PRINT N'Creating [dbo].[ttdStagingUnprocessedChargesNightlyExtract_Hist]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingUnprocessedChargesNightlyExtract_Hist' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingUnprocessedChargesNightlyExtract_Hist] (
    [PartnerID]                    INT           NOT NULL,
    [EffDate]                      DATETIME      NOT NULL,
    [ProdClassificationGUID]       VARCHAR (50)  NOT NULL,
    [ProdClassificationDetailGUID] VARCHAR (50)  NOT NULL,
    [ChargeDetailGUID]             VARCHAR (50)  NOT NULL,
    [Number]                       NVARCHAR (50) NOT NULL,
    [ExpirationDate]               DATETIME      NOT NULL,
    [DeltaType]                    VARCHAR (50)  NOT NULL,
    [DeletedFlag]                  VARCHAR (1)   NOT NULL,
    [KeepDuringRollback]           VARCHAR (1)   NOT NULL
);
END


GO
PRINT N'Creating [dbo].[ttdStagingUnprocessedChargesNightlyExtract_Hist].[CIX_ttdStagingUnprocessedChargesNightlyExtract_Hist]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_ttdStagingUnprocessedChargesNightlyExtract_Hist' AND object_id = object_id('ttdStagingUnprocessedChargesNightlyExtract_Hist'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_ttdStagingUnprocessedChargesNightlyExtract_Hist]
    ON [dbo].[ttdStagingUnprocessedChargesNightlyExtract_Hist]([ProdClassificationGUID] ASC, [ProdClassificationDetailGUID] ASC, [ChargeDetailGUID] ASC);
END


GO
PRINT N'Creating [dbo].[ttdStagingUnprocessedCommercialDocumentsNightlyExtract]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingUnprocessedCommercialDocumentsNightlyExtract' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingUnprocessedCommercialDocumentsNightlyExtract] (
    [PartnerID]           INT            NOT NULL,
    [EffDate]             DATETIME       NOT NULL,
    [Country]             VARCHAR (20)   NOT NULL,
    [DocumentTransaction] VARCHAR (50)   NOT NULL,
    [DocumentType]        VARCHAR (50)   NOT NULL,
    [DocumentName]        NVARCHAR (300) NOT NULL,
    [Requirement]         VARCHAR (50)   NOT NULL,
    [Description]         NVARCHAR (MAX) NOT NULL,
    [Identifier1]         VARCHAR (50)   NOT NULL,
    [Link]                NVARCHAR (MAX) NOT NULL,
    [EffectivityDate]     DATETIME       NOT NULL,
    [ExpirationDate]      DATETIME       NOT NULL,
    [DeltaType]           VARCHAR (50)   NOT NULL,
    [DeletedFlag]         VARCHAR (1)    NOT NULL,
    [KeepDuringRollback]  VARCHAR (1)    NOT NULL
);
END


GO
PRINT N'Creating [dbo].[ttdStagingUnprocessedCommercialDocumentsNightlyExtract].[CIX_ttdStagingUnprocessedCommercialDocumentsNightlyExtract]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_ttdStagingUnprocessedCommercialDocumentsNightlyExtract' AND object_id = object_id('ttdStagingUnprocessedCommercialDocumentsNightlyExtract'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_ttdStagingUnprocessedCommercialDocumentsNightlyExtract]
    ON [dbo].[ttdStagingUnprocessedCommercialDocumentsNightlyExtract]([EffDate] ASC);
END


GO
PRINT N'Creating [dbo].[ttdStagingUnprocessedCommercialDocumentsNightlyExtractHIST]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingUnprocessedCommercialDocumentsNightlyExtractHIST' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingUnprocessedCommercialDocumentsNightlyExtractHIST] (
    [PartnerID]           INT            NOT NULL,
    [EffDate]             DATETIME       NOT NULL,
    [Country]             VARCHAR (20)   NOT NULL,
    [DocumentTransaction] VARCHAR (50)   NOT NULL,
    [DocumentType]        VARCHAR (50)   NOT NULL,
    [DocumentName]        NVARCHAR (300) NOT NULL,
    [Requirement]         VARCHAR (50)   NOT NULL,
    [Description]         NVARCHAR (MAX) NOT NULL,
    [Identifier1]         VARCHAR (50)   NOT NULL,
    [Link]                NVARCHAR (MAX) NOT NULL,
    [EffectivityDate]     DATETIME       NOT NULL,
    [ExpirationDate]      DATETIME       NOT NULL,
    [DeltaType]           VARCHAR (50)   NOT NULL,
    [DeletedFlag]         VARCHAR (1)    NOT NULL,
    [KeepDuringRollback]  VARCHAR (1)    NOT NULL
);
END


GO
PRINT N'Creating [dbo].[ttdStagingUnprocessedCommercialDocumentsNightlyExtractHIST].[CIX_ttdStagingUnprocessedCommercialDocumentsNightlyExtractHIST]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_ttdStagingUnprocessedCommercialDocumentsNightlyExtractHIST' AND object_id = object_id('ttdStagingUnprocessedCommercialDocumentsNightlyExtractHIST'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_ttdStagingUnprocessedCommercialDocumentsNightlyExtractHIST]
    ON [dbo].[ttdStagingUnprocessedCommercialDocumentsNightlyExtractHIST]([EffDate] ASC);
END


GO
PRINT N'Creating [dbo].[ttdStagingUnprocessedCountryGroupCodeNightlyExtract]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingUnprocessedCountryGroupCodeNightlyExtract' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingUnprocessedCountryGroupCodeNightlyExtract] (
    [PartnerID]          INT          NOT NULL,
    [EffDate]            DATETIME     NOT NULL,
    [CountryGroupGUID]   VARCHAR (50) NOT NULL,
    [CountryGroupCode]   VARCHAR (20) NOT NULL,
    [ExpirationDate]     DATETIME     NOT NULL,
    [DeltaType]          VARCHAR (50) NOT NULL,
    [DeletedFlag]        VARCHAR (1)  NOT NULL,
    [KeepDuringRollback] VARCHAR (1)  NOT NULL
);
END


GO
PRINT N'Creating [dbo].[ttdStagingUnprocessedCountryGroupCodeNightlyExtract].[CIX_ttdStagingUnprocessedCountryGroupCodeNightlyExtract]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_ttdStagingUnprocessedCountryGroupCodeNightlyExtract' AND object_id = object_id('ttdStagingUnprocessedCountryGroupCodeNightlyExtract'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_ttdStagingUnprocessedCountryGroupCodeNightlyExtract]
    ON [dbo].[ttdStagingUnprocessedCountryGroupCodeNightlyExtract]([EffDate] ASC);
END


GO
PRINT N'Creating [dbo].[ttdStagingUnprocessedCountryGroupCodeNightlyExtractHIST]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingUnprocessedCountryGroupCodeNightlyExtractHIST' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingUnprocessedCountryGroupCodeNightlyExtractHIST] (
    [PartnerID]          INT          NOT NULL,
    [EffDate]            DATETIME     NOT NULL,
    [CountryGroupGUID]   VARCHAR (50) NOT NULL,
    [CountryGroupCode]   VARCHAR (20) NOT NULL,
    [ExpirationDate]     DATETIME     NOT NULL,
    [DeltaType]          VARCHAR (50) NOT NULL,
    [DeletedFlag]        VARCHAR (1)  NOT NULL,
    [KeepDuringRollback] VARCHAR (1)  NOT NULL
);
END


GO
PRINT N'Creating [dbo].[ttdStagingUnprocessedCountryGroupCodeNightlyExtractHIST].[CIX_ttdStagingUnprocessedCountryGroupCodeNightlyExtractHIST]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_ttdStagingUnprocessedCountryGroupCodeNightlyExtractHIST' AND object_id = object_id('ttdStagingUnprocessedCountryGroupCodeNightlyExtractHIST'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_ttdStagingUnprocessedCountryGroupCodeNightlyExtractHIST]
    ON [dbo].[ttdStagingUnprocessedCountryGroupCodeNightlyExtractHIST]([EffDate] ASC);
END


GO
PRINT N'Creating [dbo].[ttdStagingUnprocessedDPSSanctionsNightlyExtract]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingUnprocessedDPSSanctionsNightlyExtract' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingUnprocessedDPSSanctionsNightlyExtract] (
    [PartnerID]           INT          NOT NULL,
    [EffDate]             DATETIME     NOT NULL,
    [RegListID]           INT          NOT NULL,
    [RegEntityID]         INT          NOT NULL,
    [RegEntityStatusDate] DATETIME     NOT NULL,
    [RegEntityExpDate]    DATETIME     NOT NULL,
    [ReasonDate]          DATETIME     NOT NULL,
    [ReasonExpDate]       DATETIME     NOT NULL,
    [DeltaType]           VARCHAR (50) NOT NULL,
    [DeletedFlag]         VARCHAR (1)  NOT NULL,
    [KeepDuringRollback]  VARCHAR (1)  NOT NULL
);
END


GO
PRINT N'Creating [dbo].[ttdStagingUnprocessedDPSSanctionsNightlyExtract].[CIX_ttdStagingUnprocessedDPSSanctionsNightlyExtract]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_ttdStagingUnprocessedDPSSanctionsNightlyExtract' AND object_id = object_id('ttdStagingUnprocessedDPSSanctionsNightlyExtract'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_ttdStagingUnprocessedDPSSanctionsNightlyExtract]
    ON [dbo].[ttdStagingUnprocessedDPSSanctionsNightlyExtract]([EffDate] ASC);
END


GO
PRINT N'Creating [dbo].[ttdStagingUnprocessedDPSSanctionsNightlyExtractHIST]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingUnprocessedDPSSanctionsNightlyExtractHIST' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingUnprocessedDPSSanctionsNightlyExtractHIST] (
    [PartnerID]           INT          NOT NULL,
    [EffDate]             DATETIME     NOT NULL,
    [RegListID]           INT          NOT NULL,
    [RegEntityID]         INT          NOT NULL,
    [RegEntityStatusDate] DATETIME     NOT NULL,
    [RegEntityExpDate]    DATETIME     NOT NULL,
    [ReasonDate]          DATETIME     NOT NULL,
    [ReasonExpDate]       DATETIME     NOT NULL,
    [DeltaType]           VARCHAR (50) NOT NULL,
    [DeletedFlag]         VARCHAR (1)  NOT NULL,
    [KeepDuringRollback]  VARCHAR (1)  NOT NULL
);
END


GO
PRINT N'Creating [dbo].[ttdStagingUnprocessedDPSSanctionsNightlyExtractHIST].[CIX_ttdStagingUnprocessedDPSSanctionsNightlyExtractHIST]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_ttdStagingUnprocessedDPSSanctionsNightlyExtractHIST' AND object_id = object_id('ttdStagingUnprocessedDPSSanctionsNightlyExtractHIST'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_ttdStagingUnprocessedDPSSanctionsNightlyExtractHIST]
    ON [dbo].[ttdStagingUnprocessedDPSSanctionsNightlyExtractHIST]([EffDate] ASC);
END


GO
PRINT N'Creating [dbo].[ttdStagingUnprocessedECNControlReasonsNightlyExtract]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingUnprocessedECNControlReasonsNightlyExtract' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingUnprocessedECNControlReasonsNightlyExtract] (
    [PartnerID]               INT             NOT NULL,
    [EffDate]                 DATETIME        NOT NULL,
    [RegListID]               INT             NOT NULL,
    [RegListDetailNum]        VARCHAR (50)    NOT NULL,
    [GroupCodeName]           VARCHAR (40)    NOT NULL,
    [ProductGroupDescription] NVARCHAR (1250) NOT NULL,
    [RegEffDate]              DATETIME        NOT NULL,
    [RegExpDate]              DATETIME        NOT NULL,
    [DeltaType]               VARCHAR (50)    NOT NULL,
    [DeletedFlag]             VARCHAR (1)     NOT NULL,
    [KeepDuringRollback]      VARCHAR (1)     NOT NULL
);
END


GO
PRINT N'Creating [dbo].[ttdStagingUnprocessedECNControlReasonsNightlyExtract].[CIX_ttdStagingUnprocessedECNControlReasonsNightlyExtract]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_ttdStagingUnprocessedECNControlReasonsNightlyExtract' AND object_id = object_id('ttdStagingUnprocessedECNControlReasonsNightlyExtract'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_ttdStagingUnprocessedECNControlReasonsNightlyExtract]
    ON [dbo].[ttdStagingUnprocessedECNControlReasonsNightlyExtract]([EffDate] ASC);
END


GO
PRINT N'Creating [dbo].[ttdStagingUnprocessedECNControlReasonsNightlyExtractHIST]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingUnprocessedECNControlReasonsNightlyExtractHIST' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingUnprocessedECNControlReasonsNightlyExtractHIST] (
    [PartnerID]               INT             NOT NULL,
    [EffDate]                 DATETIME        NOT NULL,
    [RegListID]               INT             NOT NULL,
    [RegListDetailNum]        VARCHAR (50)    NOT NULL,
    [GroupCodeName]           VARCHAR (40)    NOT NULL,
    [ProductGroupDescription] NVARCHAR (1250) NOT NULL,
    [RegEffDate]              DATETIME        NOT NULL,
    [RegExpDate]              DATETIME        NOT NULL,
    [DeltaType]               VARCHAR (50)    NOT NULL,
    [DeletedFlag]             VARCHAR (1)     NOT NULL,
    [KeepDuringRollback]      VARCHAR (1)     NOT NULL
);
END


GO
PRINT N'Creating [dbo].[ttdStagingUnprocessedECNControlReasonsNightlyExtractHIST].[CIX_ttdStagingUnprocessedECNControlReasonsNightlyExtractHIST]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_ttdStagingUnprocessedECNControlReasonsNightlyExtractHIST' AND object_id = object_id('ttdStagingUnprocessedECNControlReasonsNightlyExtractHIST'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_ttdStagingUnprocessedECNControlReasonsNightlyExtractHIST]
    ON [dbo].[ttdStagingUnprocessedECNControlReasonsNightlyExtractHIST]([EffDate] ASC);
END


GO
PRINT N'Creating [dbo].[ttdStagingUnprocessedECNNightlyExtract]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingUnprocessedECNNightlyExtract' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingUnprocessedECNNightlyExtract] (
    [PartnerID]          INT           NOT NULL,
    [EffDate]            DATETIME      NOT NULL,
    [RegListID]          INT           NOT NULL,
    [RegDenyID]          INT           NOT NULL,
    [Number]             NVARCHAR (50) NOT NULL,
    [ExpirationDate]     DATETIME      NOT NULL,
    [DeltaType]          VARCHAR (50)  NOT NULL,
    [DeletedFlag]        VARCHAR (1)   NOT NULL,
    [KeepDuringRollback] VARCHAR (1)   NOT NULL
);
END


GO
PRINT N'Creating [dbo].[ttdStagingUnprocessedECNNightlyExtract].[CIX_ttdStagingUnprocessedECNNightlyExtract]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_ttdStagingUnprocessedECNNightlyExtract' AND object_id = object_id('ttdStagingUnprocessedECNNightlyExtract'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_ttdStagingUnprocessedECNNightlyExtract]
    ON [dbo].[ttdStagingUnprocessedECNNightlyExtract]([RegListID] ASC, [RegDenyID] ASC);
END


GO
PRINT N'Creating [dbo].[ttdStagingUnprocessedECNNightlyExtract_Hist]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingUnprocessedECNNightlyExtract_Hist' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingUnprocessedECNNightlyExtract_Hist] (
    [PartnerID]          INT           NOT NULL,
    [EffDate]            DATETIME      NOT NULL,
    [RegListID]          INT           NOT NULL,
    [RegDenyID]          INT           NOT NULL,
    [Number]             NVARCHAR (50) NOT NULL,
    [ExpirationDate]     DATETIME      NOT NULL,
    [DeltaType]          VARCHAR (50)  NOT NULL,
    [DeletedFlag]        VARCHAR (1)   NOT NULL,
    [KeepDuringRollback] VARCHAR (1)   NOT NULL
);
END


GO
PRINT N'Creating [dbo].[ttdStagingUnprocessedECNNightlyExtract_Hist].[CIX_ttdStagingUnprocessedECNNightlyExtract_Hist]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_ttdStagingUnprocessedECNNightlyExtract_Hist' AND object_id = object_id('ttdStagingUnprocessedECNNightlyExtract_Hist'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_ttdStagingUnprocessedECNNightlyExtract_Hist]
    ON [dbo].[ttdStagingUnprocessedECNNightlyExtract_Hist]([RegListID] ASC, [RegDenyID] ASC);
END


GO
PRINT N'Creating [dbo].[ttdStagingUnprocessedECNRegulationGroupsNightlyExtract]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingUnprocessedECNRegulationGroupsNightlyExtract' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingUnprocessedECNRegulationGroupsNightlyExtract] (
    [PartnerID]          INT            NOT NULL,
    [EffDate]            DATETIME       NOT NULL,
    [RegListID]          INT            NOT NULL,
    [GroupCodeName]      VARCHAR (40)   NOT NULL,
    [GroupDescription]   NVARCHAR (500) NOT NULL,
    [Allowable]          VARCHAR (1)    NOT NULL,
    [CountryCode]        VARCHAR (2)    NOT NULL,
    [RegEffDate]         DATETIME       NOT NULL,
    [RegExpDate]         DATETIME       NOT NULL,
    [DeltaType]          VARCHAR (50)   NOT NULL,
    [DeletedFlag]        VARCHAR (1)    NOT NULL,
    [KeepDuringRollback] VARCHAR (1)    NOT NULL
);
END


GO
PRINT N'Creating [dbo].[ttdStagingUnprocessedECNRegulationGroupsNightlyExtract].[CIX_ttdStagingUnprocessedECNRegulationGroupsNightlyExtract]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_ttdStagingUnprocessedECNRegulationGroupsNightlyExtract' AND object_id = object_id('ttdStagingUnprocessedECNRegulationGroupsNightlyExtract'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_ttdStagingUnprocessedECNRegulationGroupsNightlyExtract]
    ON [dbo].[ttdStagingUnprocessedECNRegulationGroupsNightlyExtract]([EffDate] ASC);
END


GO
PRINT N'Creating [dbo].[ttdStagingUnprocessedECNRegulationGroupsNightlyExtractHIST]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingUnprocessedECNRegulationGroupsNightlyExtractHIST' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingUnprocessedECNRegulationGroupsNightlyExtractHIST] (
    [PartnerID]          INT            NOT NULL,
    [EffDate]            DATETIME       NOT NULL,
    [RegListID]          INT            NOT NULL,
    [GroupCodeName]      VARCHAR (40)   NOT NULL,
    [GroupDescription]   NVARCHAR (500) NOT NULL,
    [Allowable]          VARCHAR (1)    NOT NULL,
    [CountryCode]        VARCHAR (2)    NOT NULL,
    [RegEffDate]         DATETIME       NOT NULL,
    [RegExpDate]         DATETIME       NOT NULL,
    [DeltaType]          VARCHAR (50)   NOT NULL,
    [DeletedFlag]        VARCHAR (1)    NOT NULL,
    [KeepDuringRollback] VARCHAR (1)    NOT NULL
);
END


GO
PRINT N'Creating [dbo].[ttdStagingUnprocessedECNRegulationGroupsNightlyExtractHIST].[CIX_ttdStagingUnprocessedECNRegulationGroupsNightlyExtractHIST]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_ttdStagingUnprocessedECNRegulationGroupsNightlyExtractHIST' AND object_id = object_id('ttdStagingUnprocessedECNRegulationGroupsNightlyExtractHIST'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_ttdStagingUnprocessedECNRegulationGroupsNightlyExtractHIST]
    ON [dbo].[ttdStagingUnprocessedECNRegulationGroupsNightlyExtractHIST]([EffDate] ASC);
END


GO
PRINT N'Creating [dbo].[ttdStagingUnprocessedHSDescUOMNightlyExtract]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingUnprocessedHSDescUOMNightlyExtract' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingUnprocessedHSDescUOMNightlyExtract] (
    [PartnerID]                    INT           NOT NULL,
    [EffDate]                      DATETIME      NOT NULL,
    [ProdClassificationGUID]       VARCHAR (50)  NOT NULL,
    [ProdClassificationDetailGUID] VARCHAR (50)  NOT NULL,
    [Number]                       NVARCHAR (50) NOT NULL,
    [CustomsDeclarable]            VARCHAR (1)   NOT NULL,
    [ExpirationDate]               DATETIME      NOT NULL,
    [DeltaType]                    VARCHAR (50)  NOT NULL,
    [DeletedFlag]                  VARCHAR (1)   NOT NULL,
    [KeepDuringRollback]           VARCHAR (1)   NOT NULL
);
END


GO
PRINT N'Creating [dbo].[ttdStagingUnprocessedHSDescUOMNightlyExtract].[CIX_ttdStagingUnprocessedHSDescUOMNightlyExtract]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_ttdStagingUnprocessedHSDescUOMNightlyExtract' AND object_id = object_id('ttdStagingUnprocessedHSDescUOMNightlyExtract'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_ttdStagingUnprocessedHSDescUOMNightlyExtract]
    ON [dbo].[ttdStagingUnprocessedHSDescUOMNightlyExtract]([ProdClassificationGUID] ASC, [ProdClassificationDetailGUID] ASC);
END


GO
PRINT N'Creating [dbo].[ttdStagingUnprocessedHSDescUOMNightlyExtract].[IX_ttdStagingUnprocessedHSDescUOMNightlyExtract_DeltaType]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='IX_ttdStagingUnprocessedHSDescUOMNightlyExtract_DeltaType' AND object_id = object_id('ttdStagingUnprocessedHSDescUOMNightlyExtract'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
  IF (SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('DeltaType')
			AND ID = OBJECT_ID('ttdStagingUnprocessedHSDescUOMNightlyExtract')	) = 1
  BEGIN
	exec sp_executesql N'CREATE NONCLUSTERED INDEX [IX_ttdStagingUnprocessedHSDescUOMNightlyExtract_DeltaType]
		ON [dbo].[ttdStagingUnprocessedHSDescUOMNightlyExtract]([DeltaType] ASC) WHERE ([DeltaType]=''Number Expiry'')';
  END
END


GO
PRINT N'Creating [dbo].[ttdStagingUnprocessedHSDescUOMNightlyExtract].[IX_ttdStagingUnprocessedHSDescUOMNightlyExtract_Hist_DeltaType]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='IX_ttdStagingUnprocessedHSDescUOMNightlyExtract_Hist_DeltaType' AND object_id = object_id('ttdStagingUnprocessedHSDescUOMNightlyExtract'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
  IF (SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('DeltaType')
			AND ID = OBJECT_ID('ttdStagingUnprocessedHSDescUOMNightlyExtract')	) = 1
  BEGIN
	exec sp_executesql N'CREATE NONCLUSTERED INDEX [IX_ttdStagingUnprocessedHSDescUOMNightlyExtract_Hist_DeltaType]
    ON [dbo].[ttdStagingUnprocessedHSDescUOMNightlyExtract]([DeltaType] ASC) WHERE ([DeltaType]=''Number Expiry'')';
  END
END


GO
PRINT N'Creating [dbo].[ttdStagingUnprocessedHSDescUOMNightlyExtract_Hist]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingUnprocessedHSDescUOMNightlyExtract_Hist' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingUnprocessedHSDescUOMNightlyExtract_Hist] (
    [PartnerID]                    INT           NOT NULL,
    [EffDate]                      DATETIME      NOT NULL,
    [ProdClassificationGUID]       VARCHAR (50)  NOT NULL,
    [ProdClassificationDetailGUID] VARCHAR (50)  NOT NULL,
    [Number]                       NVARCHAR (50) NOT NULL,
    [CustomsDeclarable]            VARCHAR (1)   NOT NULL,
    [ExpirationDate]               DATETIME      NOT NULL,
    [DeltaType]                    VARCHAR (50)  NOT NULL,
    [DeletedFlag]                  VARCHAR (1)   NOT NULL,
    [KeepDuringRollback]           VARCHAR (1)   NOT NULL
);
END


GO
PRINT N'Creating [dbo].[ttdStagingUnprocessedHSDescUOMNightlyExtract_Hist].[CIX_ttdStagingUnprocessedHSDescUOMNightlyExtract_Hist]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_ttdStagingUnprocessedHSDescUOMNightlyExtract_Hist' AND object_id = object_id('ttdStagingUnprocessedHSDescUOMNightlyExtract_Hist'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_ttdStagingUnprocessedHSDescUOMNightlyExtract_Hist]
    ON [dbo].[ttdStagingUnprocessedHSDescUOMNightlyExtract_Hist]([ProdClassificationGUID] ASC, [ProdClassificationDetailGUID] ASC);
END


GO
PRINT N'Creating [dbo].[ttdStagingUnprocessedRelatedControlsNightlyExtract]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingUnprocessedRelatedControlsNightlyExtract' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingUnprocessedRelatedControlsNightlyExtract] (
    [PartnerID]              INT           NOT NULL,
    [EffDate]                DATETIME      NOT NULL,
    [ProdClassificationGUID] VARCHAR (50)  NOT NULL,
    [Number]                 NVARCHAR (50) NOT NULL,
    [ExpirationDate]         DATETIME      NOT NULL,
    [DeltaType]              VARCHAR (50)  NOT NULL,
    [DeletedFlag]            VARCHAR (1)   NOT NULL,
    [KeepDuringRollback]     VARCHAR (1)   NOT NULL
);
END


GO
PRINT N'Creating [dbo].[ttdStagingUnprocessedRelatedControlsNightlyExtract].[CIX_ttdStagingUnprocessedRelatedControlsNightlyExtract]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_ttdStagingUnprocessedRelatedControlsNightlyExtract' AND object_id = object_id('ttdStagingUnprocessedRelatedControlsNightlyExtract'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_ttdStagingUnprocessedRelatedControlsNightlyExtract]
    ON [dbo].[ttdStagingUnprocessedRelatedControlsNightlyExtract]([EffDate] ASC);
END


GO
PRINT N'Creating [dbo].[ttdStagingUnprocessedRelatedControlsNightlyExtractHIST]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingUnprocessedRelatedControlsNightlyExtractHIST' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingUnprocessedRelatedControlsNightlyExtractHIST] (
    [PartnerID]              INT           NOT NULL,
    [EffDate]                DATETIME      NOT NULL,
    [ProdClassificationGUID] VARCHAR (50)  NOT NULL,
    [Number]                 NVARCHAR (50) NOT NULL,
    [ExpirationDate]         DATETIME      NOT NULL,
    [DeltaType]              VARCHAR (50)  NOT NULL,
    [DeletedFlag]            VARCHAR (1)   NOT NULL,
    [KeepDuringRollback]     VARCHAR (1)   NOT NULL
);
END


GO
PRINT N'Creating [dbo].[ttdStagingUnprocessedRelatedControlsNightlyExtractHIST].[CIX_ttdStagingUnprocessedRelatedControlsNightlyExtractHIST]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_ttdStagingUnprocessedRelatedControlsNightlyExtractHIST' AND object_id = object_id('ttdStagingUnprocessedRelatedControlsNightlyExtractHIST'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_ttdStagingUnprocessedRelatedControlsNightlyExtractHIST]
    ON [dbo].[ttdStagingUnprocessedRelatedControlsNightlyExtractHIST]([EffDate] ASC);
END


GO
PRINT N'Creating [dbo].[ttdStagingUnprocessedStandardDPSNightlyExtract]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingUnprocessedStandardDPSNightlyExtract' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingUnprocessedStandardDPSNightlyExtract] (
    [PartnerID]          INT          NOT NULL,
    [EffDate]            DATETIME     NOT NULL,
    [RegListID]          INT          NOT NULL,
    [RegEntityID]        INT          NOT NULL,
    [RegEffDate]         DATETIME     NOT NULL,
    [RegExpDate]         DATETIME     NOT NULL,
    [ReasonEffDate]      DATETIME     NOT NULL,
    [ReasonExpDate]      DATETIME     NOT NULL,
    [ExceptionEffDate]   DATETIME     NOT NULL,
    [ExceptionExpDate]   DATETIME     NOT NULL,
    [DeltaType]          VARCHAR (50) NOT NULL,
    [DeletedFlag]        VARCHAR (1)  NOT NULL,
    [KeepDuringRollback] VARCHAR (1)  NOT NULL
);
END


GO
PRINT N'Creating [dbo].[ttdStagingUnprocessedStandardDPSNightlyExtract].[CIX_ttdStagingUnprocessedStandardDPSNightlyExtract]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_ttdStagingUnprocessedStandardDPSNightlyExtract' AND object_id = object_id('ttdStagingUnprocessedStandardDPSNightlyExtract'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_ttdStagingUnprocessedStandardDPSNightlyExtract]
    ON [dbo].[ttdStagingUnprocessedStandardDPSNightlyExtract]([EffDate] ASC);
END


GO
PRINT N'Creating [dbo].[ttdStagingUnprocessedStandardDPSNightlyExtractHIST]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingUnprocessedStandardDPSNightlyExtractHIST' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingUnprocessedStandardDPSNightlyExtractHIST] (
    [PartnerID]          INT          NOT NULL,
    [EffDate]            DATETIME     NOT NULL,
    [RegListID]          INT          NOT NULL,
    [RegEntityID]        INT          NOT NULL,
    [RegEffDate]         DATETIME     NOT NULL,
    [RegExpDate]         DATETIME     NOT NULL,
    [ReasonEffDate]      DATETIME     NOT NULL,
    [ReasonExpDate]      DATETIME     NOT NULL,
    [ExceptionEffDate]   DATETIME     NOT NULL,
    [ExceptionExpDate]   DATETIME     NOT NULL,
    [DeltaType]          VARCHAR (50) NOT NULL,
    [DeletedFlag]        VARCHAR (1)  NOT NULL,
    [KeepDuringRollback] VARCHAR (1)  NOT NULL
);
END


GO
PRINT N'Creating [dbo].[ttdStagingUnprocessedStandardDPSNightlyExtractHIST].[CIX_ttdStagingUnprocessedStandardDPSNightlyExtractHIST]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_ttdStagingUnprocessedStandardDPSNightlyExtractHIST' AND object_id = object_id('ttdStagingUnprocessedStandardDPSNightlyExtractHIST'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_ttdStagingUnprocessedStandardDPSNightlyExtractHIST]
    ON [dbo].[ttdStagingUnprocessedStandardDPSNightlyExtractHIST]([EffDate] ASC);
END


GO
PRINT N'Creating [dbo].[ttdStagingVNProductClassification]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingVNProductClassification' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingVNProductClassification] (
    [PartnerID]                   INT              NOT NULL,
    [EffDate]                     DATETIME         NOT NULL,
    [ProductGuid]                 VARCHAR (50)     NOT NULL,
    [ProductNum]                  NVARCHAR (50)    NOT NULL,
    [ProductDesc]                 NVARCHAR (350)   NOT NULL,
    [ProductName]                 NVARCHAR (50)    NOT NULL,
    [SupplierID]                  VARCHAR (30)     NOT NULL,
    [ManufacturerId]              VARCHAR (15)     NOT NULL,
    [BusinessUnit]                NVARCHAR (50)    NOT NULL,
    [BusinessDivision]            NVARCHAR (50)    NOT NULL,
    [ProductGroup]                NVARCHAR (30)    NOT NULL,
    [ProductTypeCode]             VARCHAR (2)      NOT NULL,
    [TaxID]                       VARCHAR (20)     NOT NULL,
    [TaxIDSuffix]                 VARCHAR (20)     NOT NULL,
    [Notes]                       NVARCHAR (MAX)   NOT NULL,
    [Value]                       NUMERIC (38, 20) NOT NULL,
    [Value2]                      NUMERIC (38, 20) NOT NULL,
    [CurrencyCode]                VARCHAR (3)      NOT NULL,
    [CommercialValue]             NUMERIC (38, 20) NOT NULL,
    [CommercialValueCurrencyCode] VARCHAR (3)      NOT NULL,
    [ProductMaterial]             NVARCHAR (200)   NOT NULL,
    [NetWeight]                   NUMERIC (38, 20) NOT NULL,
    [GrossWeight]                 NUMERIC (38, 20) NOT NULL,
    [WeightUOM]                   VARCHAR (3)      NOT NULL,
    [TxnQtyUOM]                   VARCHAR (3)      NOT NULL,
    [HSUOMConvFactor]             NUMERIC (38, 20) NOT NULL,
    [AddlHSUOMConvFactor]         NUMERIC (38, 20) NOT NULL,
    [HsNum]                       VARCHAR (12)     NOT NULL,
    [HsNum2]                      VARCHAR (12)     NOT NULL,
    [HsInProgress]                VARCHAR (15)     NOT NULL,
    [AssuranceLevel]              VARCHAR (10)     NOT NULL,
    [HsRationale]                 NVARCHAR (MAX)   NOT NULL,
    [GRI]                         VARCHAR (100)    NOT NULL,
    [BindingRuling]               VARCHAR (100)    NOT NULL,
    [RulingNotes]                 NVARCHAR (MAX)   NOT NULL,
    [ExportTariffNum]             VARCHAR (15)     NOT NULL,
    [ECNNum]                      VARCHAR (50)     NOT NULL,
    [PreferenceCode1]             VARCHAR (10)     NOT NULL,
    [PreferenceCode2]             VARCHAR (10)     NOT NULL,
    [CountryOfOrigin]             VARCHAR (2)      NOT NULL,
    [CPC1]                        VARCHAR (10)     NOT NULL,
    [CPC2]                        VARCHAR (10)     NOT NULL,
    [WCOEN]                       VARCHAR (100)    NOT NULL,
    [CASNum]                      VARCHAR (50)     NOT NULL,
    [HazMatFlag]                  VARCHAR (1)      NOT NULL,
    [UNNum]                       VARCHAR (10)     NOT NULL,
    [ProperShippingName]          NVARCHAR (100)   NOT NULL,
    [HazardClass]                 VARCHAR (10)     NOT NULL,
    [PackingGroup]                VARCHAR (10)     NOT NULL,
    [SubRisk]                     VARCHAR (10)     NOT NULL,
    [Flashpoint]                  VARCHAR (10)     NOT NULL,
    [MarinePollutant]             VARCHAR (10)     NOT NULL,
    [UNPackagingCode]             VARCHAR (10)     NOT NULL,
    [TechnicalName]               NVARCHAR (100)   NOT NULL,
    [AuditDate]                   DATETIME         NOT NULL,
    [AuditNotes]                  NVARCHAR (MAX)   NOT NULL,
    [ApprovedBy]                  VARCHAR (80)     NOT NULL,
    [ApprovalDate]                DATETIME         NOT NULL,
    [CreatedDate]                 DATETIME         NOT NULL,
    [CreatedBy]                   VARCHAR (80)     NOT NULL,
    [ModifiedDate]                DATETIME         NOT NULL,
    [ModifiedBy]                  VARCHAR (80)     NOT NULL,
    [FTZActiveFlag]               VARCHAR (1)      NOT NULL,
    [ActiveFlag]                  VARCHAR (1)      NOT NULL,
    [ZoneStatusCode]              VARCHAR (20)     NOT NULL,
    [VNGCS01]                     NVARCHAR (50)    NOT NULL,
    [VNGCS02]                     NVARCHAR (50)    NOT NULL,
    [VNGCS03]                     NVARCHAR (50)    NOT NULL,
    [VNGCS04]                     NVARCHAR (50)    NOT NULL,
    [VNGCS05]                     NVARCHAR (50)    NOT NULL,
    [VNGCS06]                     NVARCHAR (50)    NOT NULL,
    [VNGCS07]                     NVARCHAR (50)    NOT NULL,
    [VNGCS08]                     NVARCHAR (50)    NOT NULL,
    [VNGCS09]                     NVARCHAR (50)    NOT NULL,
    [VNGCS10]                     NVARCHAR (50)    NOT NULL,
    [VNGCS11]                     NVARCHAR (50)    NOT NULL,
    [VNGCS12]                     NVARCHAR (50)    NOT NULL,
    [VNGCS13]                     NVARCHAR (50)    NOT NULL,
    [VNGCS14]                     NVARCHAR (50)    NOT NULL,
    [VNGCS15]                     NVARCHAR (50)    NOT NULL,
    [VNGCL01]                     NVARCHAR (500)   NOT NULL,
    [VNGCL02]                     NVARCHAR (500)   NOT NULL,
    [VNGCL03]                     NVARCHAR (500)   NOT NULL,
    [VNGCL04]                     NVARCHAR (500)   NOT NULL,
    [VNGCL05]                     NVARCHAR (500)   NOT NULL,
    [VNGCN01]                     NUMERIC (38, 20) NOT NULL,
    [VNGCN02]                     NUMERIC (38, 20) NOT NULL,
    [VNGCN03]                     NUMERIC (38, 20) NOT NULL,
    [VNGCN04]                     NUMERIC (38, 20) NOT NULL,
    [VNGCN05]                     NUMERIC (38, 20) NOT NULL,
    [VNGCD01]                     DATETIME         NOT NULL,
    [VNGCD02]                     DATETIME         NOT NULL,
    [VNGCD03]                     DATETIME         NOT NULL,
    [VNGCD04]                     DATETIME         NOT NULL,
    [VNGCD05]                     DATETIME         NOT NULL,
    [ExistingProductFlag]         VARCHAR (1)      NOT NULL,
    [DeletedFlag]                 VARCHAR (1)      NOT NULL,
    [KeepDuringRollback]          VARCHAR (1)      NOT NULL
);
END


GO
PRINT N'Creating [dbo].[ttdStagingVNProductClassification].[CIX_ttdStagingVNProductClassification]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_ttdStagingVNProductClassification' AND object_id = object_id('ttdStagingVNProductClassification'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_ttdStagingVNProductClassification]
    ON [dbo].[ttdStagingVNProductClassification]([EffDate] ASC);
END


GO
PRINT N'Creating [dbo].[ttdStagingVNProductClassification].[IX_ttdStagingVNProductClassification_1]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='IX_ttdStagingVNProductClassification_1' AND object_id = object_id('ttdStagingVNProductClassification'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE NONCLUSTERED INDEX [IX_ttdStagingVNProductClassification_1]
    ON [dbo].[ttdStagingVNProductClassification]([PartnerID] ASC, [ProductGuid] ASC);
END


GO
PRINT N'Creating [dbo].[ttdStagingVNProductClassificationHist]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingVNProductClassificationHist' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingVNProductClassificationHist] (
    [PartnerID]                   INT              NOT NULL,
    [EffDate]                     DATETIME         NOT NULL,
    [ProductGuid]                 VARCHAR (50)     NOT NULL,
    [ProductNum]                  NVARCHAR (50)    NOT NULL,
    [ProductDesc]                 NVARCHAR (350)   NOT NULL,
    [ProductName]                 NVARCHAR (50)    NOT NULL,
    [SupplierID]                  VARCHAR (30)     NOT NULL,
    [ManufacturerId]              VARCHAR (15)     NOT NULL,
    [BusinessUnit]                NVARCHAR (50)    NOT NULL,
    [BusinessDivision]            NVARCHAR (50)    NOT NULL,
    [ProductGroup]                NVARCHAR (30)    NOT NULL,
    [ProductTypeCode]             VARCHAR (2)      NOT NULL,
    [TaxID]                       VARCHAR (20)     NOT NULL,
    [TaxIDSuffix]                 VARCHAR (20)     NOT NULL,
    [Notes]                       NVARCHAR (MAX)   NOT NULL,
    [Value]                       NUMERIC (38, 20) NOT NULL,
    [Value2]                      NUMERIC (38, 20) NOT NULL,
    [CurrencyCode]                VARCHAR (3)      NOT NULL,
    [CommercialValue]             NUMERIC (38, 20) NOT NULL,
    [CommercialValueCurrencyCode] VARCHAR (3)      NOT NULL,
    [ProductMaterial]             NVARCHAR (200)   NOT NULL,
    [NetWeight]                   NUMERIC (38, 20) NOT NULL,
    [GrossWeight]                 NUMERIC (38, 20) NOT NULL,
    [WeightUOM]                   VARCHAR (3)      NOT NULL,
    [TxnQtyUOM]                   VARCHAR (3)      NOT NULL,
    [HSUOMConvFactor]             NUMERIC (38, 20) NOT NULL,
    [AddlHSUOMConvFactor]         NUMERIC (38, 20) NOT NULL,
    [HsNum]                       VARCHAR (12)     NOT NULL,
    [HsNum2]                      VARCHAR (12)     NOT NULL,
    [HsInProgress]                VARCHAR (15)     NOT NULL,
    [AssuranceLevel]              VARCHAR (10)     NOT NULL,
    [HsRationale]                 NVARCHAR (MAX)   NOT NULL,
    [GRI]                         VARCHAR (100)    NOT NULL,
    [BindingRuling]               VARCHAR (100)    NOT NULL,
    [RulingNotes]                 NVARCHAR (MAX)   NOT NULL,
    [ExportTariffNum]             VARCHAR (15)     NOT NULL,
    [ECNNum]                      VARCHAR (50)     NOT NULL,
    [PreferenceCode1]             VARCHAR (10)     NOT NULL,
    [PreferenceCode2]             VARCHAR (10)     NOT NULL,
    [CountryOfOrigin]             VARCHAR (2)      NOT NULL,
    [CPC1]                        VARCHAR (10)     NOT NULL,
    [CPC2]                        VARCHAR (10)     NOT NULL,
    [WCOEN]                       VARCHAR (100)    NOT NULL,
    [CASNum]                      VARCHAR (50)     NOT NULL,
    [HazMatFlag]                  VARCHAR (1)      NOT NULL,
    [UNNum]                       VARCHAR (10)     NOT NULL,
    [ProperShippingName]          NVARCHAR (100)   NOT NULL,
    [HazardClass]                 VARCHAR (10)     NOT NULL,
    [PackingGroup]                VARCHAR (10)     NOT NULL,
    [SubRisk]                     VARCHAR (10)     NOT NULL,
    [Flashpoint]                  VARCHAR (10)     NOT NULL,
    [MarinePollutant]             VARCHAR (10)     NOT NULL,
    [UNPackagingCode]             VARCHAR (10)     NOT NULL,
    [TechnicalName]               NVARCHAR (100)   NOT NULL,
    [AuditDate]                   DATETIME         NOT NULL,
    [AuditNotes]                  NVARCHAR (MAX)   NOT NULL,
    [ApprovedBy]                  VARCHAR (80)     NOT NULL,
    [ApprovalDate]                DATETIME         NOT NULL,
    [CreatedDate]                 DATETIME         NOT NULL,
    [CreatedBy]                   VARCHAR (80)     NOT NULL,
    [ModifiedDate]                DATETIME         NOT NULL,
    [ModifiedBy]                  VARCHAR (80)     NOT NULL,
    [FTZActiveFlag]               VARCHAR (1)      NOT NULL,
    [ActiveFlag]                  VARCHAR (1)      NOT NULL,
    [ZoneStatusCode]              VARCHAR (20)     NOT NULL,
    [VNGCS01]                     NVARCHAR (50)    NOT NULL,
    [VNGCS02]                     NVARCHAR (50)    NOT NULL,
    [VNGCS03]                     NVARCHAR (50)    NOT NULL,
    [VNGCS04]                     NVARCHAR (50)    NOT NULL,
    [VNGCS05]                     NVARCHAR (50)    NOT NULL,
    [VNGCS06]                     NVARCHAR (50)    NOT NULL,
    [VNGCS07]                     NVARCHAR (50)    NOT NULL,
    [VNGCS08]                     NVARCHAR (50)    NOT NULL,
    [VNGCS09]                     NVARCHAR (50)    NOT NULL,
    [VNGCS10]                     NVARCHAR (50)    NOT NULL,
    [VNGCS11]                     NVARCHAR (50)    NOT NULL,
    [VNGCS12]                     NVARCHAR (50)    NOT NULL,
    [VNGCS13]                     NVARCHAR (50)    NOT NULL,
    [VNGCS14]                     NVARCHAR (50)    NOT NULL,
    [VNGCS15]                     NVARCHAR (50)    NOT NULL,
    [VNGCL01]                     NVARCHAR (500)   NOT NULL,
    [VNGCL02]                     NVARCHAR (500)   NOT NULL,
    [VNGCL03]                     NVARCHAR (500)   NOT NULL,
    [VNGCL04]                     NVARCHAR (500)   NOT NULL,
    [VNGCL05]                     NVARCHAR (500)   NOT NULL,
    [VNGCN01]                     NUMERIC (38, 20) NOT NULL,
    [VNGCN02]                     NUMERIC (38, 20) NOT NULL,
    [VNGCN03]                     NUMERIC (38, 20) NOT NULL,
    [VNGCN04]                     NUMERIC (38, 20) NOT NULL,
    [VNGCN05]                     NUMERIC (38, 20) NOT NULL,
    [VNGCD01]                     DATETIME         NOT NULL,
    [VNGCD02]                     DATETIME         NOT NULL,
    [VNGCD03]                     DATETIME         NOT NULL,
    [VNGCD04]                     DATETIME         NOT NULL,
    [VNGCD05]                     DATETIME         NOT NULL,
    [ExistingProductFlag]         VARCHAR (1)      NOT NULL,
    [DeletedFlag]                 VARCHAR (1)      NOT NULL,
    [KeepDuringRollback]          VARCHAR (1)      NOT NULL
);
END


GO
PRINT N'Creating [dbo].[ttdStagingVNProductClassificationHist].[CIX_ttdStagingVNProductClassificationHist]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_ttdStagingVNProductClassificationHist' AND object_id = object_id('ttdStagingVNProductClassificationHist'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_ttdStagingVNProductClassificationHist]
    ON [dbo].[ttdStagingVNProductClassificationHist]([EffDate] ASC);
END


GO
PRINT N'Creating [dbo].[ttdStagingVNProductClassificationHist].[IX_ttdStagingVNProductClassificationHist_1]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='IX_ttdStagingVNProductClassificationHist_1' AND object_id = object_id('ttdStagingVNProductClassificationHist'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE NONCLUSTERED INDEX [IX_ttdStagingVNProductClassificationHist_1]
    ON [dbo].[ttdStagingVNProductClassificationHist]([PartnerID] ASC, [ProductGuid] ASC);
END


GO
PRINT N'Creating [dbo].[ttdStagingZAProductClassification]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingZAProductClassification' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingZAProductClassification] (
    [PartnerID]                   INT              NOT NULL,
    [EffDate]                     DATETIME         NOT NULL,
    [ProductGuid]                 VARCHAR (50)     NOT NULL,
    [ProductNum]                  NVARCHAR (50)    NOT NULL,
    [ProductDesc]                 NVARCHAR (350)   NOT NULL,
    [ProductName]                 NVARCHAR (50)    NOT NULL,
    [SupplierID]                  VARCHAR (30)     NOT NULL,
    [ManufacturerId]              VARCHAR (15)     NOT NULL,
    [BusinessUnit]                NVARCHAR (50)    NOT NULL,
    [BusinessDivision]            NVARCHAR (50)    NOT NULL,
    [ProductGroup]                NVARCHAR (30)    NOT NULL,
    [ProductTypeCode]             VARCHAR (2)      NOT NULL,
    [TaxID]                       VARCHAR (20)     NOT NULL,
    [TaxIDSuffix]                 VARCHAR (20)     NOT NULL,
    [Notes]                       NVARCHAR (MAX)   NOT NULL,
    [Value]                       NUMERIC (38, 20) NOT NULL,
    [Value2]                      NUMERIC (38, 20) NOT NULL,
    [CurrencyCode]                VARCHAR (3)      NOT NULL,
    [CommercialValue]             NUMERIC (38, 20) NOT NULL,
    [CommercialValueCurrencyCode] VARCHAR (3)      NOT NULL,
    [ProductMaterial]             NVARCHAR (200)   NOT NULL,
    [NetWeight]                   NUMERIC (38, 20) NOT NULL,
    [GrossWeight]                 NUMERIC (38, 20) NOT NULL,
    [WeightUOM]                   VARCHAR (3)      NOT NULL,
    [TxnQtyUOM]                   VARCHAR (3)      NOT NULL,
    [HSUOMConvFactor]             NUMERIC (38, 20) NOT NULL,
    [AddlHSUOMConvFactor]         NUMERIC (38, 20) NOT NULL,
    [HsNum]                       VARCHAR (12)     NOT NULL,
    [HsNum2]                      VARCHAR (12)     NOT NULL,
    [HsInProgress]                VARCHAR (15)     NOT NULL,
    [AssuranceLevel]              VARCHAR (10)     NOT NULL,
    [HsRationale]                 NVARCHAR (MAX)   NOT NULL,
    [GRI]                         VARCHAR (100)    NOT NULL,
    [BindingRuling]               VARCHAR (100)    NOT NULL,
    [RulingNotes]                 NVARCHAR (MAX)   NOT NULL,
    [ExportTariffNum]             VARCHAR (15)     NOT NULL,
    [ECNNum]                      VARCHAR (50)     NOT NULL,
    [PreferenceCode1]             VARCHAR (10)     NOT NULL,
    [PreferenceCode2]             VARCHAR (10)     NOT NULL,
    [CountryOfOrigin]             VARCHAR (2)      NOT NULL,
    [CPC1]                        VARCHAR (10)     NOT NULL,
    [CPC2]                        VARCHAR (10)     NOT NULL,
    [WCOEN]                       VARCHAR (100)    NOT NULL,
    [CASNum]                      VARCHAR (50)     NOT NULL,
    [HazMatFlag]                  VARCHAR (1)      NOT NULL,
    [UNNum]                       VARCHAR (10)     NOT NULL,
    [ProperShippingName]          NVARCHAR (100)   NOT NULL,
    [HazardClass]                 VARCHAR (10)     NOT NULL,
    [PackingGroup]                VARCHAR (10)     NOT NULL,
    [SubRisk]                     VARCHAR (10)     NOT NULL,
    [Flashpoint]                  VARCHAR (10)     NOT NULL,
    [MarinePollutant]             VARCHAR (10)     NOT NULL,
    [UNPackagingCode]             VARCHAR (10)     NOT NULL,
    [TechnicalName]               NVARCHAR (100)   NOT NULL,
    [AuditDate]                   DATETIME         NOT NULL,
    [AuditNotes]                  NVARCHAR (MAX)   NOT NULL,
    [ApprovedBy]                  VARCHAR (80)     NOT NULL,
    [ApprovalDate]                DATETIME         NOT NULL,
    [CreatedDate]                 DATETIME         NOT NULL,
    [CreatedBy]                   VARCHAR (80)     NOT NULL,
    [ModifiedDate]                DATETIME         NOT NULL,
    [ModifiedBy]                  VARCHAR (80)     NOT NULL,
    [FTZActiveFlag]               VARCHAR (1)      NOT NULL,
    [ActiveFlag]                  VARCHAR (1)      NOT NULL,
    [ZoneStatusCode]              VARCHAR (20)     NOT NULL,
    [ZAGCS01]                     NVARCHAR (50)    NOT NULL,
    [ZAGCS02]                     NVARCHAR (50)    NOT NULL,
    [ZAGCS03]                     NVARCHAR (50)    NOT NULL,
    [ZAGCS04]                     NVARCHAR (50)    NOT NULL,
    [ZAGCS05]                     NVARCHAR (50)    NOT NULL,
    [ZAGCS06]                     NVARCHAR (50)    NOT NULL,
    [ZAGCS07]                     NVARCHAR (50)    NOT NULL,
    [ZAGCS08]                     NVARCHAR (50)    NOT NULL,
    [ZAGCS09]                     NVARCHAR (50)    NOT NULL,
    [ZAGCS10]                     NVARCHAR (50)    NOT NULL,
    [ZAGCS11]                     NVARCHAR (50)    NOT NULL,
    [ZAGCS12]                     NVARCHAR (50)    NOT NULL,
    [ZAGCS13]                     NVARCHAR (50)    NOT NULL,
    [ZAGCS14]                     NVARCHAR (50)    NOT NULL,
    [ZAGCS15]                     NVARCHAR (50)    NOT NULL,
    [ZAGCL01]                     NVARCHAR (500)   NOT NULL,
    [ZAGCL02]                     NVARCHAR (500)   NOT NULL,
    [ZAGCL03]                     NVARCHAR (500)   NOT NULL,
    [ZAGCL04]                     NVARCHAR (500)   NOT NULL,
    [ZAGCL05]                     NVARCHAR (500)   NOT NULL,
    [ZAGCN01]                     NUMERIC (38, 20) NOT NULL,
    [ZAGCN02]                     NUMERIC (38, 20) NOT NULL,
    [ZAGCN03]                     NUMERIC (38, 20) NOT NULL,
    [ZAGCN04]                     NUMERIC (38, 20) NOT NULL,
    [ZAGCN05]                     NUMERIC (38, 20) NOT NULL,
    [ZAGCD01]                     DATETIME         NOT NULL,
    [ZAGCD02]                     DATETIME         NOT NULL,
    [ZAGCD03]                     DATETIME         NOT NULL,
    [ZAGCD04]                     DATETIME         NOT NULL,
    [ZAGCD05]                     DATETIME         NOT NULL,
    [ExistingProductFlag]         VARCHAR (1)      NOT NULL,
    [DeletedFlag]                 VARCHAR (1)      NOT NULL,
    [KeepDuringRollback]          VARCHAR (1)      NOT NULL
);
END


GO
PRINT N'Creating [dbo].[ttdStagingZAProductClassification].[CIX_ttdStagingZAProductClassification]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_ttdStagingZAProductClassification' AND object_id = object_id('ttdStagingZAProductClassification'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_ttdStagingZAProductClassification]
    ON [dbo].[ttdStagingZAProductClassification]([EffDate] ASC);
END


GO
PRINT N'Creating [dbo].[ttdStagingZAProductClassification].[IX_ttdStagingZAProductClassification_1]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='IX_ttdStagingZAProductClassification_1' AND object_id = object_id('ttdStagingZAProductClassification'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE NONCLUSTERED INDEX [IX_ttdStagingZAProductClassification_1]
    ON [dbo].[ttdStagingZAProductClassification]([PartnerID] ASC, [ProductGuid] ASC);
END


GO
PRINT N'Creating [dbo].[ttdStagingZAProductClassificationHist]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingZAProductClassificationHist' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[ttdStagingZAProductClassificationHist] (
    [PartnerID]                   INT              NOT NULL,
    [EffDate]                     DATETIME         NOT NULL,
    [ProductGuid]                 VARCHAR (50)     NOT NULL,
    [ProductNum]                  NVARCHAR (50)    NOT NULL,
    [ProductDesc]                 NVARCHAR (350)   NOT NULL,
    [ProductName]                 NVARCHAR (50)    NOT NULL,
    [SupplierID]                  VARCHAR (30)     NOT NULL,
    [ManufacturerId]              VARCHAR (15)     NOT NULL,
    [BusinessUnit]                NVARCHAR (50)    NOT NULL,
    [BusinessDivision]            NVARCHAR (50)    NOT NULL,
    [ProductGroup]                NVARCHAR (30)    NOT NULL,
    [ProductTypeCode]             VARCHAR (2)      NOT NULL,
    [TaxID]                       VARCHAR (20)     NOT NULL,
    [TaxIDSuffix]                 VARCHAR (20)     NOT NULL,
    [Notes]                       NVARCHAR (MAX)   NOT NULL,
    [Value]                       NUMERIC (38, 20) NOT NULL,
    [Value2]                      NUMERIC (38, 20) NOT NULL,
    [CurrencyCode]                VARCHAR (3)      NOT NULL,
    [CommercialValue]             NUMERIC (38, 20) NOT NULL,
    [CommercialValueCurrencyCode] VARCHAR (3)      NOT NULL,
    [ProductMaterial]             NVARCHAR (200)   NOT NULL,
    [NetWeight]                   NUMERIC (38, 20) NOT NULL,
    [GrossWeight]                 NUMERIC (38, 20) NOT NULL,
    [WeightUOM]                   VARCHAR (3)      NOT NULL,
    [TxnQtyUOM]                   VARCHAR (3)      NOT NULL,
    [HSUOMConvFactor]             NUMERIC (38, 20) NOT NULL,
    [AddlHSUOMConvFactor]         NUMERIC (38, 20) NOT NULL,
    [HsNum]                       VARCHAR (12)     NOT NULL,
    [HsNum2]                      VARCHAR (12)     NOT NULL,
    [HsInProgress]                VARCHAR (15)     NOT NULL,
    [AssuranceLevel]              VARCHAR (10)     NOT NULL,
    [HsRationale]                 NVARCHAR (MAX)   NOT NULL,
    [GRI]                         VARCHAR (100)    NOT NULL,
    [BindingRuling]               VARCHAR (100)    NOT NULL,
    [RulingNotes]                 NVARCHAR (MAX)   NOT NULL,
    [ExportTariffNum]             VARCHAR (15)     NOT NULL,
    [ECNNum]                      VARCHAR (50)     NOT NULL,
    [PreferenceCode1]             VARCHAR (10)     NOT NULL,
    [PreferenceCode2]             VARCHAR (10)     NOT NULL,
    [CountryOfOrigin]             VARCHAR (2)      NOT NULL,
    [CPC1]                        VARCHAR (10)     NOT NULL,
    [CPC2]                        VARCHAR (10)     NOT NULL,
    [WCOEN]                       VARCHAR (100)    NOT NULL,
    [CASNum]                      VARCHAR (50)     NOT NULL,
    [HazMatFlag]                  VARCHAR (1)      NOT NULL,
    [UNNum]                       VARCHAR (10)     NOT NULL,
    [ProperShippingName]          NVARCHAR (100)   NOT NULL,
    [HazardClass]                 VARCHAR (10)     NOT NULL,
    [PackingGroup]                VARCHAR (10)     NOT NULL,
    [SubRisk]                     VARCHAR (10)     NOT NULL,
    [Flashpoint]                  VARCHAR (10)     NOT NULL,
    [MarinePollutant]             VARCHAR (10)     NOT NULL,
    [UNPackagingCode]             VARCHAR (10)     NOT NULL,
    [TechnicalName]               NVARCHAR (100)   NOT NULL,
    [AuditDate]                   DATETIME         NOT NULL,
    [AuditNotes]                  NVARCHAR (MAX)   NOT NULL,
    [ApprovedBy]                  VARCHAR (80)     NOT NULL,
    [ApprovalDate]                DATETIME         NOT NULL,
    [CreatedDate]                 DATETIME         NOT NULL,
    [CreatedBy]                   VARCHAR (80)     NOT NULL,
    [ModifiedDate]                DATETIME         NOT NULL,
    [ModifiedBy]                  VARCHAR (80)     NOT NULL,
    [FTZActiveFlag]               VARCHAR (1)      NOT NULL,
    [ActiveFlag]                  VARCHAR (1)      NOT NULL,
    [ZoneStatusCode]              VARCHAR (20)     NOT NULL,
    [ZAGCS01]                     NVARCHAR (50)    NOT NULL,
    [ZAGCS02]                     NVARCHAR (50)    NOT NULL,
    [ZAGCS03]                     NVARCHAR (50)    NOT NULL,
    [ZAGCS04]                     NVARCHAR (50)    NOT NULL,
    [ZAGCS05]                     NVARCHAR (50)    NOT NULL,
    [ZAGCS06]                     NVARCHAR (50)    NOT NULL,
    [ZAGCS07]                     NVARCHAR (50)    NOT NULL,
    [ZAGCS08]                     NVARCHAR (50)    NOT NULL,
    [ZAGCS09]                     NVARCHAR (50)    NOT NULL,
    [ZAGCS10]                     NVARCHAR (50)    NOT NULL,
    [ZAGCS11]                     NVARCHAR (50)    NOT NULL,
    [ZAGCS12]                     NVARCHAR (50)    NOT NULL,
    [ZAGCS13]                     NVARCHAR (50)    NOT NULL,
    [ZAGCS14]                     NVARCHAR (50)    NOT NULL,
    [ZAGCS15]                     NVARCHAR (50)    NOT NULL,
    [ZAGCL01]                     NVARCHAR (500)   NOT NULL,
    [ZAGCL02]                     NVARCHAR (500)   NOT NULL,
    [ZAGCL03]                     NVARCHAR (500)   NOT NULL,
    [ZAGCL04]                     NVARCHAR (500)   NOT NULL,
    [ZAGCL05]                     NVARCHAR (500)   NOT NULL,
    [ZAGCN01]                     NUMERIC (38, 20) NOT NULL,
    [ZAGCN02]                     NUMERIC (38, 20) NOT NULL,
    [ZAGCN03]                     NUMERIC (38, 20) NOT NULL,
    [ZAGCN04]                     NUMERIC (38, 20) NOT NULL,
    [ZAGCN05]                     NUMERIC (38, 20) NOT NULL,
    [ZAGCD01]                     DATETIME         NOT NULL,
    [ZAGCD02]                     DATETIME         NOT NULL,
    [ZAGCD03]                     DATETIME         NOT NULL,
    [ZAGCD04]                     DATETIME         NOT NULL,
    [ZAGCD05]                     DATETIME         NOT NULL,
    [ExistingProductFlag]         VARCHAR (1)      NOT NULL,
    [DeletedFlag]                 VARCHAR (1)      NOT NULL,
    [KeepDuringRollback]          VARCHAR (1)      NOT NULL
);
END


GO
PRINT N'Creating [dbo].[ttdStagingZAProductClassificationHist].[CIX_ttdStagingZAProductClassificationHist]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_ttdStagingZAProductClassificationHist' AND object_id = object_id('ttdStagingZAProductClassificationHist'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_ttdStagingZAProductClassificationHist]
    ON [dbo].[ttdStagingZAProductClassificationHist]([EffDate] ASC);
END


GO
PRINT N'Creating [dbo].[ttdStagingZAProductClassificationHist].[IX_ttdStagingZAProductClassificationHist_1]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='IX_ttdStagingZAProductClassificationHist_1' AND object_id = object_id('ttdStagingZAProductClassificationHist'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE NONCLUSTERED INDEX [IX_ttdStagingZAProductClassificationHist_1]
    ON [dbo].[ttdStagingZAProductClassificationHist]([PartnerID] ASC, [ProductGuid] ASC);
END


GO
PRINT N'Creating [dbo].[txdDEAESSpecialStatement]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdDEAESSpecialStatement' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[txdDEAESSpecialStatement] (
    [PartnerID]            INT          NOT NULL,
    [EffDate]              DATETIME     NOT NULL,
    [DeclarationGUID]      VARCHAR (50) NOT NULL,
    [DeclarationDataGUID]  VARCHAR (50) NOT NULL,
    [SpecialStatementGUID] VARCHAR (50) NOT NULL,
    [SequenceNum]          INT          NOT NULL,
    [StatementCode]        VARCHAR (1)  NOT NULL,
    [DeletedFlag]          VARCHAR (1)  NOT NULL,
    [KeepDuringRollback]   VARCHAR (1)  NOT NULL,
    CONSTRAINT [PK_txdDEAESSpecialStatement] PRIMARY KEY NONCLUSTERED ([PartnerID] ASC, [DeclarationGUID] ASC, [DeclarationDataGUID] ASC, [SpecialStatementGUID] ASC) WITH (FILLFACTOR = 90)
);
END


GO
PRINT N'Creating [dbo].[txdDEAESSpecialStatement].[CIX_txdDEAESSpecialStatement]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_txdDEAESSpecialStatement' AND object_id = object_id('txdDEAESSpecialStatement'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_txdDEAESSpecialStatement]
    ON [dbo].[txdDEAESSpecialStatement]([EffDate] ASC);
END


GO
PRINT N'Creating [dbo].[txdDEImpBEPartAVUV]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdDEImpBEPartAVUV' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[txdDEImpBEPartAVUV] (
    [PartnerID]                       INT            NOT NULL,
    [EffDate]                         DATETIME       NOT NULL,
    [DeclarationGUID]                 VARCHAR (50)   NOT NULL,
    [DeclarationDataGUID]             VARCHAR (50)   NOT NULL,
    [BEPartAVUVGUID]                  VARCHAR (50)   NOT NULL,
    [SequenceNum]                     INT            NOT NULL,
    [ItemNumber]                      INT            NOT NULL,
    [PreviousMovementReferenceNumber] VARCHAR (35)   NOT NULL,
    [PreviousItemNumber]              NUMERIC (5)    NOT NULL,
    [PreviousFiledFlag]               VARCHAR (1)    NOT NULL,
    [CommodityInformation]            NVARCHAR (350) NOT NULL,
    [DeletedFlag]                     VARCHAR (1)    NOT NULL,
    [KeepDuringRollback]              VARCHAR (1)    NOT NULL,
    CONSTRAINT [PK_txdDEImpBEPartAVUV] PRIMARY KEY NONCLUSTERED ([PartnerID] ASC, [DeclarationGUID] ASC, [DeclarationDataGUID] ASC, [BEPartAVUVGUID] ASC) WITH (FILLFACTOR = 90)
);
END


GO
PRINT N'Creating [dbo].[txdDEImpBEPartAVUV].[CIX_txdDEImpBEPartAVUV]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_txdDEImpBEPartAVUV' AND object_id = object_id('txdDEImpBEPartAVUV'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_txdDEImpBEPartAVUV]
    ON [dbo].[txdDEImpBEPartAVUV]([EffDate] ASC);
END


GO
PRINT N'Creating [dbo].[txdDEImpBEPartAVUV].[IX_txdDEImpBEPartAVUV_PKC]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='IX_txdDEImpBEPartAVUV_PKC' AND object_id = object_id('txdDEImpBEPartAVUV'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE NONCLUSTERED INDEX [IX_txdDEImpBEPartAVUV_PKC]
    ON [dbo].[txdDEImpBEPartAVUV]([PartnerID] ASC, [DeclarationGUID] ASC, [DeclarationDataGUID] ASC, [BEPartAVUVGUID] ASC)
    INCLUDE([EffDate], [CommodityInformation], [PreviousFiledFlag], [PreviousItemNumber], [PreviousMovementReferenceNumber], [ItemNumber], [SequenceNum]);
END


GO
PRINT N'Creating [dbo].[txdDEImpBEPartZL]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdDEImpBEPartZL' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[txdDEImpBEPartZL] (
    [PartnerID]                       INT             NOT NULL,
    [EffDate]                         DATETIME        NOT NULL,
    [DeclarationGUID]                 VARCHAR (50)    NOT NULL,
    [DeclarationDataGUID]             VARCHAR (50)    NOT NULL,
    [BEPartZLGUID]                    VARCHAR (50)    NOT NULL,
    [SequenceNum]                     INT             NOT NULL,
    [ItemNumber]                      INT             NOT NULL,
    [PreviousMovementReferenceNumber] VARCHAR (35)    NOT NULL,
    [PreviousItemNumber]              NUMERIC (5)     NOT NULL,
    [PreviousFiledFlag]               VARCHAR (1)     NOT NULL,
    [CommodityCode]                   VARCHAR (11)    NOT NULL,
    [ConventionalTreatmentIndicator]  VARCHAR (1)     NOT NULL,
    [AdditionalInformation]           NVARCHAR (100)  NOT NULL,
    [TradingQuantity]                 NUMERIC (12, 3) NOT NULL,
    [TradingQuantityUoM]              VARCHAR (4)     NOT NULL,
    [WasteQuantity]                   NUMERIC (12, 3) NOT NULL,
    [WasteQuantityUoM]                VARCHAR (4)     NOT NULL,
    [DeletedFlag]                     VARCHAR (1)     NOT NULL,
    [KeepDuringRollback]              VARCHAR (1)     NOT NULL,
    CONSTRAINT [PK_txdDEImpBEPartZL] PRIMARY KEY NONCLUSTERED ([PartnerID] ASC, [DeclarationGUID] ASC, [DeclarationDataGUID] ASC, [BEPartZLGUID] ASC) WITH (FILLFACTOR = 90)
);
END


GO
PRINT N'Creating [dbo].[txdDEImpBEPartZL].[CIX_txdDEImpBEPartZL]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_txdDEImpBEPartZL' AND object_id = object_id('txdDEImpBEPartZL'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_txdDEImpBEPartZL]
    ON [dbo].[txdDEImpBEPartZL]([EffDate] ASC);
END


GO
PRINT N'Creating [dbo].[txdDEImpBEPartZL].[IX_txdDEImpBEPartZL_PKC]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='IX_txdDEImpBEPartZL_PKC' AND object_id = object_id('txdDEImpBEPartZL'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE NONCLUSTERED INDEX [IX_txdDEImpBEPartZL_PKC]
    ON [dbo].[txdDEImpBEPartZL]([PartnerID] ASC, [DeclarationGUID] ASC, [DeclarationDataGUID] ASC, [BEPartZLGUID] ASC)
    INCLUDE([EffDate], [CommodityCode], [AdditionalInformation], [ConventionalTreatmentIndicator], [PreviousFiledFlag], [PreviousItemNumber], [PreviousMovementReferenceNumber], [ItemNumber], [SequenceNum], [TradingQuantity], [TradingQuantityUoM], [WasteQuantity], [WasteQuantityUoM]);
END


GO
PRINT N'Creating [dbo].[txdDEImpGoodsItemAdditionalCodeInformation]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdDEImpGoodsItemAdditionalCodeInformation' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[txdDEImpGoodsItemAdditionalCodeInformation] (
    [PartnerID]                     INT          NOT NULL,
    [EffDate]                       DATETIME     NOT NULL,
    [DeclarationGUID]               VARCHAR (50) NOT NULL,
    [DeclarationDataGUID]           VARCHAR (50) NOT NULL,
    [GoodsItemGUID]                 VARCHAR (50) NOT NULL,
    [AdditionalCodeInformationGUID] VARCHAR (50) NOT NULL,
    [SequenceNum]                   INT          NOT NULL,
    [AdditionalCommodity]           VARCHAR (4)  NOT NULL,
    [DeletedFlag]                   VARCHAR (1)  NOT NULL,
    [KeepDuringRollback]            VARCHAR (1)  NOT NULL,
    CONSTRAINT [PK_txdDEImpGoodsItemAdditionalCodeInformation] PRIMARY KEY NONCLUSTERED ([PartnerID] ASC, [DeclarationGUID] ASC, [DeclarationDataGUID] ASC, [GoodsItemGUID] ASC, [AdditionalCodeInformationGUID] ASC) WITH (FILLFACTOR = 90)
);
END


GO
PRINT N'Creating [dbo].[txdDEImpGoodsItemAdditionalCodeInformation].[CIX_txdDEImpGoodsItemAdditionalCodeInformation]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_txdDEImpGoodsItemAdditionalCodeInformation' AND object_id = object_id('txdDEImpGoodsItemAdditionalCodeInformation'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_txdDEImpGoodsItemAdditionalCodeInformation]
    ON [dbo].[txdDEImpGoodsItemAdditionalCodeInformation]([EffDate] ASC);
END


GO
PRINT N'Creating [dbo].[txdDEImpGoodsItemAdditionalCodeInformation].[IX_txdDEImpGoodsItemAdditionalCodeInformation_PKC]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='IX_txdDEImpGoodsItemAdditionalCodeInformation_PKC' AND object_id = object_id('txdDEImpGoodsItemAdditionalCodeInformation'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE NONCLUSTERED INDEX [IX_txdDEImpGoodsItemAdditionalCodeInformation_PKC]
    ON [dbo].[txdDEImpGoodsItemAdditionalCodeInformation]([PartnerID] ASC, [DeclarationGUID] ASC, [DeclarationDataGUID] ASC, [GoodsItemGUID] ASC, [AdditionalCodeInformationGUID] ASC)
    INCLUDE([EffDate], [AdditionalCommodity], [SequenceNum]);
END


GO
PRINT N'Creating [dbo].[txdDEImpGoodsItemReduction]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdDEImpGoodsItemReduction' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[txdDEImpGoodsItemReduction] (
    [PartnerID]              INT             NOT NULL,
    [EffDate]                DATETIME        NOT NULL,
    [DeclarationGUID]        VARCHAR (50)    NOT NULL,
    [DeclarationDataGUID]    VARCHAR (50)    NOT NULL,
    [GoodsItemGUID]          VARCHAR (50)    NOT NULL,
    [GoodsItemReductionGUID] VARCHAR (50)    NOT NULL,
    [SequenceNum]            INT             NOT NULL,
    [ReductionTaxGroup]      VARCHAR (2)     NOT NULL,
    [ReductionAmount]        NUMERIC (11, 2) NOT NULL,
    [DeletedFlag]            VARCHAR (1)     NOT NULL,
    [KeepDuringRollback]     VARCHAR (1)     NOT NULL,
    CONSTRAINT [PK_txdDEImpGoodsItemReduction] PRIMARY KEY NONCLUSTERED ([PartnerID] ASC, [DeclarationGUID] ASC, [DeclarationDataGUID] ASC, [GoodsItemGUID] ASC, [GoodsItemReductionGUID] ASC) WITH (FILLFACTOR = 90)
);
END


GO
PRINT N'Creating [dbo].[txdDEImpGoodsItemReduction].[CIX_txdDEImpGoodsItemReduction]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_txdDEImpGoodsItemReduction' AND object_id = object_id('txdDEImpGoodsItemReduction'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_txdDEImpGoodsItemReduction]
    ON [dbo].[txdDEImpGoodsItemReduction]([EffDate] ASC);
END


GO
PRINT N'Creating [dbo].[txdDEImpGoodsItemReduction].[IX_txdDEImpGoodsItemReduction_PKC]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='IX_txdDEImpGoodsItemReduction_PKC' AND object_id = object_id('txdDEImpGoodsItemReduction'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE NONCLUSTERED INDEX [IX_txdDEImpGoodsItemReduction_PKC]
    ON [dbo].[txdDEImpGoodsItemReduction]([PartnerID] ASC, [DeclarationGUID] ASC, [DeclarationDataGUID] ASC, [GoodsItemGUID] ASC, [GoodsItemReductionGUID] ASC)
    INCLUDE([EffDate], [ReductionAmount], [ReductionTaxGroup], [SequenceNum]);
END


GO
PRINT N'Creating [dbo].[txdDEImpGoodsItemSpecialRate]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdDEImpGoodsItemSpecialRate' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[txdDEImpGoodsItemSpecialRate] (
    [PartnerID]                  INT             NOT NULL,
    [EffDate]                    DATETIME        NOT NULL,
    [DeclarationGUID]            VARCHAR (50)    NOT NULL,
    [DeclarationDataGUID]        VARCHAR (50)    NOT NULL,
    [GoodsItemGUID]              VARCHAR (50)    NOT NULL,
    [GoodsItemSpecialRateGUID]   VARCHAR (50)    NOT NULL,
    [SequenceNum]                INT             NOT NULL,
    [SpecialRateGroup]           VARCHAR (2)     NOT NULL,
    [SpecialRateApplicationType] VARCHAR (2)     NOT NULL,
    [SpecialRateAmountOrFactor]  NUMERIC (12, 5) NOT NULL,
    [DeletedFlag]                VARCHAR (1)     NOT NULL,
    [KeepDuringRollback]         VARCHAR (1)     NOT NULL,
    CONSTRAINT [PK_txdDEImpGoodsItemSpecialRate] PRIMARY KEY NONCLUSTERED ([PartnerID] ASC, [DeclarationGUID] ASC, [DeclarationDataGUID] ASC, [GoodsItemGUID] ASC, [GoodsItemSpecialRateGUID] ASC) WITH (FILLFACTOR = 90)
);
END


GO
PRINT N'Creating [dbo].[txdDEImpGoodsItemSpecialRate].[CIX_txdDEImpGoodsItemSpecialRate]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_txdDEImpGoodsItemSpecialRate' AND object_id = object_id('txdDEImpGoodsItemSpecialRate'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_txdDEImpGoodsItemSpecialRate]
    ON [dbo].[txdDEImpGoodsItemSpecialRate]([EffDate] ASC);
END


GO
PRINT N'Creating [dbo].[txdDEImpGoodsItemSpecialRate].[IX_txdDEImpGoodsItemSpecialRate_PKC]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='IX_txdDEImpGoodsItemSpecialRate_PKC' AND object_id = object_id('txdDEImpGoodsItemSpecialRate'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE NONCLUSTERED INDEX [IX_txdDEImpGoodsItemSpecialRate_PKC]
    ON [dbo].[txdDEImpGoodsItemSpecialRate]([PartnerID] ASC, [DeclarationGUID] ASC, [DeclarationDataGUID] ASC, [GoodsItemGUID] ASC, [GoodsItemSpecialRateGUID] ASC)
    INCLUDE([EffDate], [SequenceNum], [SpecialRateAmountOrFactor], [SpecialRateApplicationType], [SpecialRateGroup]);
END


GO
PRINT N'Creating [dbo].[txdDEImpGoodsItemTaxDuty]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdDEImpGoodsItemTaxDuty' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[txdDEImpGoodsItemTaxDuty] (
    [PartnerID]           INT             NOT NULL,
    [EffDate]             DATETIME        NOT NULL,
    [DeclarationGUID]     VARCHAR (50)    NOT NULL,
    [DeclarationDataGUID] VARCHAR (50)    NOT NULL,
    [GoodsItemGUID]       VARCHAR (50)    NOT NULL,
    [TaxDutyGUID]         VARCHAR (50)    NOT NULL,
    [SequenceNum]         INT             NOT NULL,
    [Zollmenge]           NUMERIC (12, 3) NOT NULL,
    [ZollmengeUoM]        VARCHAR (4)     NOT NULL,
    [DeletedFlag]         VARCHAR (1)     NOT NULL,
    [KeepDuringRollback]  VARCHAR (1)     NOT NULL,
    CONSTRAINT [PK_txdDEImpGoodsItemTaxDuty] PRIMARY KEY NONCLUSTERED ([PartnerID] ASC, [DeclarationGUID] ASC, [DeclarationDataGUID] ASC, [GoodsItemGUID] ASC, [TaxDutyGUID] ASC) WITH (FILLFACTOR = 90)
);
END


GO
PRINT N'Creating [dbo].[txdDEImpGoodsItemTaxDuty].[CIX_txdDEImpGoodsItemTaxDuty]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_txdDEImpGoodsItemTaxDuty' AND object_id = object_id('txdDEImpGoodsItemTaxDuty'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_txdDEImpGoodsItemTaxDuty]
    ON [dbo].[txdDEImpGoodsItemTaxDuty]([EffDate] ASC);
END


GO
PRINT N'Creating [dbo].[txdDEImpGoodsItemTaxDuty].[IX_txdDEImpGoodsItemTaxDuty_PKC]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='IX_txdDEImpGoodsItemTaxDuty_PKC' AND object_id = object_id('txdDEImpGoodsItemTaxDuty'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE NONCLUSTERED INDEX [IX_txdDEImpGoodsItemTaxDuty_PKC]
    ON [dbo].[txdDEImpGoodsItemTaxDuty]([PartnerID] ASC, [DeclarationGUID] ASC, [DeclarationDataGUID] ASC, [GoodsItemGUID] ASC, [TaxDutyGUID] ASC)
    INCLUDE([EffDate], [SequenceNum], [Zollmenge], [ZollmengeUoM]);
END


GO
PRINT N'Creating [dbo].[txdDEImpGoodsItemValuationAdjustment]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdDEImpGoodsItemValuationAdjustment' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[txdDEImpGoodsItemValuationAdjustment] (
    [PartnerID]                             INT             NOT NULL,
    [EffDate]                               DATETIME        NOT NULL,
    [DeclarationGUID]                       VARCHAR (50)    NOT NULL,
    [DeclarationDataGUID]                   VARCHAR (50)    NOT NULL,
    [GoodsItemGUID]                         VARCHAR (50)    NOT NULL,
    [GoodsItemValuationAdjustmentGUID]      VARCHAR (50)    NOT NULL,
    [SequenceNum]                           INT             NOT NULL,
    [AdjustmentType]                        VARCHAR (3)     NOT NULL,
    [AdjustmentAmount]                      NUMERIC (11, 2) NOT NULL,
    [AdjustmentCurrency]                    VARCHAR (3)     NOT NULL,
    [IATAExchangeRateFlag]                  VARCHAR (1)     NOT NULL,
    [AdjustmentExchangeRateAgreedIndicator] VARCHAR (1)     NOT NULL,
    [AdjustmentExchangeRate]                NUMERIC (18, 9) NOT NULL,
    [AdjustmentExchangeRateDate]            DATETIME        NOT NULL,
    [AdjustmentPercentage]                  NUMERIC (5, 2)  NOT NULL,
    [DeletedFlag]                           VARCHAR (1)     NOT NULL,
    [KeepDuringRollback]                    VARCHAR (1)     NOT NULL,
    CONSTRAINT [PK_txdDEImpGoodsItemValuationAdjustment] PRIMARY KEY NONCLUSTERED ([PartnerID] ASC, [DeclarationGUID] ASC, [DeclarationDataGUID] ASC, [GoodsItemGUID] ASC, [GoodsItemValuationAdjustmentGUID] ASC) WITH (FILLFACTOR = 90)
);
END


GO
PRINT N'Creating [dbo].[txdDEImpGoodsItemValuationAdjustment].[CIX_txdDEImpGoodsItemValuationAdjustment]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_txdDEImpGoodsItemValuationAdjustment' AND object_id = object_id('txdDEImpGoodsItemValuationAdjustment'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_txdDEImpGoodsItemValuationAdjustment]
    ON [dbo].[txdDEImpGoodsItemValuationAdjustment]([EffDate] ASC);
END


GO
PRINT N'Creating [dbo].[txdDEImpGoodsItemValuationAdjustment].[IX_txdDEImpGoodsItemValuationAdjustment_PKC]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='IX_txdDEImpGoodsItemValuationAdjustment_PKC' AND object_id = object_id('txdDEImpGoodsItemValuationAdjustment'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE NONCLUSTERED INDEX [IX_txdDEImpGoodsItemValuationAdjustment_PKC]
    ON [dbo].[txdDEImpGoodsItemValuationAdjustment]([PartnerID] ASC, [DeclarationGUID] ASC, [DeclarationDataGUID] ASC, [GoodsItemGUID] ASC, [GoodsItemValuationAdjustmentGUID] ASC)
    INCLUDE([AdjustmentAmount], [AdjustmentCurrency], [AdjustmentExchangeRate], [AdjustmentExchangeRateAgreedIndicator], [AdjustmentExchangeRateDate], [AdjustmentPercentage], [AdjustmentType], [EffDate], [IATAExchangeRateFlag], [SequenceNum]);
END


GO
PRINT N'Creating [dbo].[txdDEImpItemSumA]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdDEImpItemSumA' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[txdDEImpItemSumA] (
    [PartnerID]                   INT          NOT NULL,
    [EffDate]                     DATETIME     NOT NULL,
    [DeclarationGUID]             VARCHAR (50) NOT NULL,
    [DeclarationDataGUID]         VARCHAR (50) NOT NULL,
    [ItemSumAGUID]                VARCHAR (50) NOT NULL,
    [SequenceNum]                 INT          NOT NULL,
    [TotalPackagesSumA]           NUMERIC (5)  NOT NULL,
    [DepositaryIdSumA]            VARCHAR (17) NOT NULL,
    [ClassificationKeySumA]       VARCHAR (3)  NOT NULL,
    [AirWaybillNumberSumA]        VARCHAR (44) NOT NULL,
    [MovementReferenceNumberSumA] VARCHAR (21) NOT NULL,
    [ItemNumberSumA]              NUMERIC (4)  NOT NULL,
    [DeletedFlag]                 VARCHAR (1)  NOT NULL,
    [KeepDuringRollback]          VARCHAR (1)  NOT NULL,
    CONSTRAINT [PK_txdDEImpItemSumA] PRIMARY KEY NONCLUSTERED ([PartnerID] ASC, [DeclarationGUID] ASC, [DeclarationDataGUID] ASC, [ItemSumAGUID] ASC) WITH (FILLFACTOR = 90)
);
END


GO
PRINT N'Creating [dbo].[txdDEImpItemSumA].[CIX_txdDEImpItemSumA]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_txdDEImpItemSumA' AND object_id = object_id('txdDEImpItemSumA'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_txdDEImpItemSumA]
    ON [dbo].[txdDEImpItemSumA]([EffDate] ASC);
END


GO
PRINT N'Creating [dbo].[txdDEImpItemSumA].[IX_txdDEImpItemSumA_PKC]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='IX_txdDEImpItemSumA_PKC' AND object_id = object_id('txdDEImpItemSumA'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE NONCLUSTERED INDEX [IX_txdDEImpItemSumA_PKC]
    ON [dbo].[txdDEImpItemSumA]([PartnerID] ASC, [DeclarationGUID] ASC, [DeclarationDataGUID] ASC, [ItemSumAGUID] ASC)
    INCLUDE([EffDate], [AirWaybillNumberSumA], [ClassificationKeySumA], [DepositaryIdSumA], [ItemNumberSumA], [MovementReferenceNumberSumA], [TotalPackagesSumA], [SequenceNum]);
END


GO
PRINT N'Creating [dbo].[txdDEImpNotification]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdDEImpNotification' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[txdDEImpNotification] (
    [PartnerID]        INT             NOT NULL,
    [EffDate]          DATETIME        NOT NULL,
    [DeclarationGUID]  VARCHAR (50)    NOT NULL,
    [ResponseGUID]     VARCHAR (50)    NOT NULL,
    [NotificationGUID] VARCHAR (50)    NOT NULL,
    [ItemNumber]       INT             NOT NULL,
    [MessageType]      VARCHAR (6)     NOT NULL,
    [Notification]     NVARCHAR (4000) NOT NULL,
    CONSTRAINT [PK_txdDEImpNotification] PRIMARY KEY NONCLUSTERED ([PartnerID] ASC, [DeclarationGUID] ASC, [ResponseGUID] ASC, [NotificationGUID] ASC) WITH (FILLFACTOR = 90)
);
END


GO
PRINT N'Creating [dbo].[txdDEImpNotification].[CIX_txdDEImpNotification]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_txdDEImpNotification' AND object_id = object_id('txdDEImpNotification'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_txdDEImpNotification]
    ON [dbo].[txdDEImpNotification]([EffDate] ASC);
END


GO
PRINT N'Creating [dbo].[txdDEImpParty]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdDEImpParty' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[txdDEImpParty] (
    [PartnerID]           INT            NOT NULL,
    [EffDate]             DATETIME       NOT NULL,
    [DeclarationGUID]     VARCHAR (50)   NOT NULL,
    [DeclarationDataGUID] VARCHAR (50)   NOT NULL,
    [PartyGUID]           VARCHAR (50)   NOT NULL,
    [SequenceNum]         INT            NOT NULL,
    [PartyId]             VARCHAR (17)   NOT NULL,
    [PartyName]           NVARCHAR (120) NOT NULL,
    [PartyAddressLine1]   NVARCHAR (35)  NOT NULL,
    [PartyCountry]        VARCHAR (2)    NOT NULL,
    [PartyPostalCode]     NVARCHAR (9)   NOT NULL,
    [PartyCity]           NVARCHAR (35)  NOT NULL,
    [PartyRegion]         NVARCHAR (35)  NOT NULL,
    [DeletedFlag]         VARCHAR (1)    NOT NULL,
    [KeepDuringRollback]  VARCHAR (1)    NOT NULL,
    CONSTRAINT [PK_txdDEImpParty] PRIMARY KEY NONCLUSTERED ([PartnerID] ASC, [DeclarationGUID] ASC, [DeclarationDataGUID] ASC, [PartyGUID] ASC) WITH (FILLFACTOR = 90)
);
END


GO
PRINT N'Creating [dbo].[txdDEImpParty].[CIX_txdDEImpParty]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_txdDEImpParty' AND object_id = object_id('txdDEImpParty'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_txdDEImpParty]
    ON [dbo].[txdDEImpParty]([EffDate] ASC);
END


GO
PRINT N'Creating [dbo].[txdDEImpParty].[IX_txdDEImpParty_PKC]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='IX_txdDEImpParty_PKC' AND object_id = object_id('txdDEImpParty'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE NONCLUSTERED INDEX [IX_txdDEImpParty_PKC]
    ON [dbo].[txdDEImpParty]([PartnerID] ASC, [DeclarationGUID] ASC, [DeclarationDataGUID] ASC, [PartyGUID] ASC)
    INCLUDE([EffDate], [PartyAddressLine1], [PartyCity], [PartyCountry], [PartyId], [PartyName], [PartyPostalCode], [PartyRegion], [SequenceNum]);
END


GO
PRINT N'Creating [dbo].[txdDEImpPeriodicDeclarationData]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdDEImpPeriodicDeclarationData' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[txdDEImpPeriodicDeclarationData] (
    [PartnerID]                              INT            NOT NULL,
    [EffDate]                                DATETIME       NOT NULL,
    [DeclarationGUID]                        VARCHAR (50)   NOT NULL,
    [PeriodicDeclarationDataGUID]            VARCHAR (50)   NOT NULL,
    [SequenceNum]                            INT            NOT NULL,
    [State]                                  VARCHAR (2)    NOT NULL,
    [VersionState]                           VARCHAR (1)    NOT NULL,
    [TransmitterId]                          VARCHAR (17)   NOT NULL,
    [TransmitterAuthorisedIdentity]          VARCHAR (4)    NOT NULL,
    [DeclarationOffice]                      VARCHAR (8)    NOT NULL,
    [MessageGroup]                           VARCHAR (3)    NOT NULL,
    [Status]                                 VARCHAR (1)    NOT NULL,
    [MessageFunction]                        VARCHAR (2)    NOT NULL,
    [IssueDate]                              DATETIME       NOT NULL,
    [ApplicationType]                        VARCHAR (3)    NOT NULL,
    [AccountingPeriodStartDate]              DATETIME       NOT NULL,
    [AccountingPeriodEndDate]                DATETIME       NOT NULL,
    [DeclarantIsAgent]                       VARCHAR (1)    NOT NULL,
    [DeferredPaymentVat]                     VARCHAR (14)   NOT NULL,
    [TaxOffice]                              VARCHAR (4)    NOT NULL,
    [Deduction]                              VARCHAR (1)    NOT NULL,
    [DeclarantAuthorizationNumber]           NVARCHAR (35)  NOT NULL,
    [DeclarantAuthorizationNumberSimplified] NVARCHAR (35)  NOT NULL,
    [MovementReferenceNumber]                VARCHAR (21)   NOT NULL,
    [LocalReferenceNumber]                   VARCHAR (35)   NOT NULL,
    [DefaultCurrency]                        VARCHAR (3)    NOT NULL,
    [AgentStatus]                            VARCHAR (1)    NOT NULL,
    [DeclarantId]                            VARCHAR (17)   NOT NULL,
    [DeclarantAuthorisedIdentity]            VARCHAR (4)    NOT NULL,
    [DeclarantName]                          NVARCHAR (120) NOT NULL,
    [DeclarantAddressLine1]                  NVARCHAR (35)  NOT NULL,
    [DeclarantCountry]                       VARCHAR (2)    NOT NULL,
    [DeclarantPostCode]                      NVARCHAR (9)   NOT NULL,
    [DeclarantCity]                          NVARCHAR (35)  NOT NULL,
    [DeclarantRegion]                        NVARCHAR (35)  NOT NULL,
    [AgentId]                                VARCHAR (17)   NOT NULL,
    [AgentAuthorisedIdentity]                VARCHAR (4)    NOT NULL,
    [BeneficiaryId]                          VARCHAR (17)   NOT NULL,
    [BeneficiaryAuthorisedIdentity]          VARCHAR (4)    NOT NULL,
    [BeneficiaryName]                        NVARCHAR (120) NOT NULL,
    [BeneficiaryAddressLine1]                NVARCHAR (35)  NOT NULL,
    [BeneficiaryCountry]                     VARCHAR (2)    NOT NULL,
    [BeneficiaryPostCode]                    NVARCHAR (9)   NOT NULL,
    [BeneficiaryCity]                        NVARCHAR (35)  NOT NULL,
    [BeneficiaryRegion]                      NVARCHAR (35)  NOT NULL,
    [DeclarantContactName]                   NVARCHAR (35)  NOT NULL,
    [DeclarantPosition]                      NVARCHAR (35)  NOT NULL,
    [DeclarantContactTel]                    VARCHAR (35)   NOT NULL,
    [DeclarantContactIdentificationNumber]   VARCHAR (25)   NOT NULL,
    [DeclarantEmailAddress]                  VARCHAR (256)  NOT NULL,
    [MandateReferenceNumber]                 VARCHAR (10)   NOT NULL,
    [IssuePlace]                             NVARCHAR (35)  NOT NULL,
    [DeadlineDate]                           DATETIME       NOT NULL,
    [TotalItems]                             INT            NOT NULL,
    [AuthorizationNumberAVUV]                VARCHAR (35)   NOT NULL,
    [ApplicantId]                            VARCHAR (17)   NOT NULL,
    [ApplicantAuthorisedIdentity]            VARCHAR (4)    NOT NULL,
    [RequestedProcedure]                     VARCHAR (2)    NOT NULL,
    [PreviousGUID]                           VARCHAR (50)   NOT NULL,
    [DeclarantAuthorizationNumberEndUse]     VARCHAR (35)   NOT NULL,
    [DeletedFlag]                            VARCHAR (1)    NOT NULL,
    [KeepDuringRollback]                     VARCHAR (1)    NOT NULL,
    CONSTRAINT [PK_txdDEImpPeriodicDeclarationData] PRIMARY KEY NONCLUSTERED ([PartnerID] ASC, [DeclarationGUID] ASC, [PeriodicDeclarationDataGUID] ASC) WITH (FILLFACTOR = 90)
);
END


GO
PRINT N'Creating [dbo].[txdDEImpPeriodicDeclarationData].[CIX_txdDEImpPeriodicDeclarationData]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_txdDEImpPeriodicDeclarationData' AND object_id = object_id('txdDEImpPeriodicDeclarationData'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_txdDEImpPeriodicDeclarationData]
    ON [dbo].[txdDEImpPeriodicDeclarationData]([EffDate] ASC);
END


GO
PRINT N'Creating [dbo].[txdDEImpResponseDebtor]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdDEImpResponseDebtor' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[txdDEImpResponseDebtor] (
    [PartnerID]                   INT            NOT NULL,
    [EffDate]                     DATETIME       NOT NULL,
    [DeclarationGUID]             VARCHAR (50)   NOT NULL,
    [ResponseGUID]                VARCHAR (50)   NOT NULL,
    [ResponseDebtorGUID]          VARCHAR (50)   NOT NULL,
    [DebtorCopyNumber]            VARCHAR (2)    NOT NULL,
    [DeclarantId]                 VARCHAR (17)   NOT NULL,
    [DeclarantAuthorisedIdentity] VARCHAR (4)    NOT NULL,
    [DeclarantName]               NVARCHAR (120) NOT NULL,
    [DeclarantAddressLine1]       NVARCHAR (35)  NOT NULL,
    [DeclarantCountry]            VARCHAR (2)    NOT NULL,
    [DeclarantPostCode]           VARCHAR (9)    NOT NULL,
    [DeclarantCity]               NVARCHAR (35)  NOT NULL,
    [DeclarantRegion]             NVARCHAR (35)  NOT NULL,
    [DeletedFlag]                 VARCHAR (1)    NOT NULL,
    [KeepDuringRollback]          VARCHAR (1)    NOT NULL,
    CONSTRAINT [PK_txdDEImpResponseDebtor] PRIMARY KEY NONCLUSTERED ([PartnerID] ASC, [DeclarationGUID] ASC, [ResponseGUID] ASC, [ResponseDebtorGUID] ASC) WITH (FILLFACTOR = 90)
);
END


GO
PRINT N'Creating [dbo].[txdDEImpResponseDebtor].[CIX_txdDEImpResponseDebtor]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_txdDEImpResponseDebtor' AND object_id = object_id('txdDEImpResponseDebtor'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_txdDEImpResponseDebtor]
    ON [dbo].[txdDEImpResponseDebtor]([EffDate] ASC);
END


GO
PRINT N'Creating [dbo].[txdDEImpResponseDepreciation]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdDEImpResponseDepreciation' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[txdDEImpResponseDepreciation] (
    [PartnerID]                     INT          NOT NULL,
    [EffDate]                       DATETIME     NOT NULL,
    [DeclarationGUID]               VARCHAR (50) NOT NULL,
    [ResponseDepreciationGUID]      VARCHAR (50) NOT NULL,
    [SequenceNum]                   INT          NOT NULL,
    [ScenarioNumber]                INT          NOT NULL,
    [MovementReferenceNumber]       VARCHAR (21) NOT NULL,
    [LocalReferenceNumber]          VARCHAR (35) NOT NULL,
    [TransmitterId]                 VARCHAR (17) NOT NULL,
    [TransmitterAuthorisedIdentity] VARCHAR (4)  NOT NULL,
    [DeletedFlag]                   VARCHAR (1)  NOT NULL,
    [KeepDuringRollback]            VARCHAR (1)  NOT NULL,
    CONSTRAINT [PK_txdDEImpResponseDepreciation] PRIMARY KEY NONCLUSTERED ([PartnerID] ASC, [DeclarationGUID] ASC, [ResponseDepreciationGUID] ASC) WITH (FILLFACTOR = 90)
);
END


GO
PRINT N'Creating [dbo].[txdDEImpResponseDepreciation].[CIX_txdDEImpResponseDepreciation]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_txdDEImpResponseDepreciation' AND object_id = object_id('txdDEImpResponseDepreciation'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_txdDEImpResponseDepreciation]
    ON [dbo].[txdDEImpResponseDepreciation]([EffDate] ASC);
END


GO
PRINT N'Creating [dbo].[txdDEImpResponseDepreciation].[IX_txdDEImpResponseDepreciation_PKC]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='IX_txdDEImpResponseDepreciation_PKC' AND object_id = object_id('txdDEImpResponseDepreciation'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE NONCLUSTERED INDEX [IX_txdDEImpResponseDepreciation_PKC]
    ON [dbo].[txdDEImpResponseDepreciation]([PartnerID] ASC, [DeclarationGUID] ASC, [ResponseDepreciationGUID] ASC)
    INCLUDE([EffDate], [LocalReferenceNumber], [MovementReferenceNumber], [ScenarioNumber], [SequenceNum], [TransmitterAuthorisedIdentity], [TransmitterId]);
END


GO
PRINT N'Creating [dbo].[txdDEImpResponseDetailAdditionalCode]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdDEImpResponseDetailAdditionalCode' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[txdDEImpResponseDetailAdditionalCode] (
    [PartnerID]                        INT          NOT NULL,
    [EffDate]                          DATETIME     NOT NULL,
    [DeclarationGUID]                  VARCHAR (50) NOT NULL,
    [ResponseGUID]                     VARCHAR (50) NOT NULL,
    [ResponseDetailGUID]               VARCHAR (50) NOT NULL,
    [ResponseDetailAdditionalCodeGUID] VARCHAR (50) NOT NULL,
    [AdditionalCommodity]              VARCHAR (4)  NOT NULL,
    [DeletedFlag]                      VARCHAR (1)  NOT NULL,
    [KeepDuringRollback]               VARCHAR (1)  NOT NULL,
    CONSTRAINT [PK_txdDEImpResponseDetailAdditionalCode] PRIMARY KEY NONCLUSTERED ([PartnerID] ASC, [DeclarationGUID] ASC, [ResponseGUID] ASC, [ResponseDetailGUID] ASC, [ResponseDetailAdditionalCodeGUID] ASC) WITH (FILLFACTOR = 90)
);
END


GO
PRINT N'Creating [dbo].[txdDEImpResponseDetailAdditionalCode].[CIX_txdDEImpResponseDetailAdditionalCode]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_txdDEImpResponseDetailAdditionalCode' AND object_id = object_id('txdDEImpResponseDetailAdditionalCode'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_txdDEImpResponseDetailAdditionalCode]
    ON [dbo].[txdDEImpResponseDetailAdditionalCode]([EffDate] ASC);
END


GO
PRINT N'Creating [dbo].[txdDEImpResponseDetailAdjustment]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdDEImpResponseDetailAdjustment' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[txdDEImpResponseDetailAdjustment] (
    [PartnerID]                             INT             NOT NULL,
    [EffDate]                               DATETIME        NOT NULL,
    [DeclarationGUID]                       VARCHAR (50)    NOT NULL,
    [ResponseGUID]                          VARCHAR (50)    NOT NULL,
    [ResponseDetailGUID]                    VARCHAR (50)    NOT NULL,
    [ResponseDetailAdjustmentGUID]          VARCHAR (50)    NOT NULL,
    [AdjustmentType]                        VARCHAR (3)     NOT NULL,
    [AdjustmentAmount]                      NUMERIC (12, 2) NOT NULL,
    [AdjustmentCurrency]                    VARCHAR (3)     NOT NULL,
    [IATAExchangeRateFlag]                  VARCHAR (1)     NOT NULL,
    [AdjustmentExchangeRateAgreedIndicator] VARCHAR (1)     NOT NULL,
    [AdjustmentRate]                        NUMERIC (18, 9) NOT NULL,
    [AdjustmentExchangeRateDate]            DATETIME        NOT NULL,
    [AdjustmentPercentage]                  NUMERIC (5, 2)  NOT NULL,
    [AdjustmentExchangeRate]                NUMERIC (18, 9) NOT NULL,
    [DeletedFlag]                           VARCHAR (1)     NOT NULL,
    [KeepDuringRollback]                    VARCHAR (1)     NOT NULL,
    CONSTRAINT [PK_txdDEImpResponseDetailAdjustment] PRIMARY KEY NONCLUSTERED ([PartnerID] ASC, [DeclarationGUID] ASC, [ResponseGUID] ASC, [ResponseDetailGUID] ASC, [ResponseDetailAdjustmentGUID] ASC) WITH (FILLFACTOR = 90)
);
END


GO
PRINT N'Creating [dbo].[txdDEImpResponseDetailAdjustment].[CIX_txdDEImpResponseDetailAdjustment]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_txdDEImpResponseDetailAdjustment' AND object_id = object_id('txdDEImpResponseDetailAdjustment'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_txdDEImpResponseDetailAdjustment]
    ON [dbo].[txdDEImpResponseDetailAdjustment]([EffDate] ASC);
END


GO
PRINT N'Creating [dbo].[txdDEImpResponseDetailContent]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdDEImpResponseDetailContent' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[txdDEImpResponseDetailContent] (
    [PartnerID]                 INT            NOT NULL,
    [EffDate]                   DATETIME       NOT NULL,
    [DeclarationGUID]           VARCHAR (50)   NOT NULL,
    [ResponseGUID]              VARCHAR (50)   NOT NULL,
    [ResponseDetailGUID]        VARCHAR (50)   NOT NULL,
    [ResponseDetailContentGUID] VARCHAR (50)   NOT NULL,
    [ContentType]               VARCHAR (2)    NOT NULL,
    [ContentPurityPercentage]   NUMERIC (5, 2) NOT NULL,
    [DeletedFlag]               VARCHAR (1)    NOT NULL,
    [KeepDuringRollback]        VARCHAR (1)    NOT NULL,
    CONSTRAINT [PK_txdDEImpResponseDetailContent] PRIMARY KEY NONCLUSTERED ([PartnerID] ASC, [DeclarationGUID] ASC, [ResponseGUID] ASC, [ResponseDetailGUID] ASC, [ResponseDetailContentGUID] ASC) WITH (FILLFACTOR = 90)
);
END


GO
PRINT N'Creating [dbo].[txdDEImpResponseDetailContent].[CIX_txdDEImpResponseDetailContent]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_txdDEImpResponseDetailContent' AND object_id = object_id('txdDEImpResponseDetailContent'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_txdDEImpResponseDetailContent]
    ON [dbo].[txdDEImpResponseDetailContent]([EffDate] ASC);
END


GO
PRINT N'Creating [dbo].[txdDEImpResponseDetailControlResultDutyQuantity]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdDEImpResponseDetailControlResultDutyQuantity' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[txdDEImpResponseDetailControlResultDutyQuantity] (
    [PartnerID]                                   INT             NOT NULL,
    [EffDate]                                     DATETIME        NOT NULL,
    [DeclarationGUID]                             VARCHAR (50)    NOT NULL,
    [DeclarationDataGUID]                         VARCHAR (50)    NOT NULL,
    [GoodsItemGUID]                               VARCHAR (50)    NOT NULL,
    [ResponseGUID]                                VARCHAR (50)    NOT NULL,
    [ResponseDetailGUID]                          VARCHAR (50)    NOT NULL,
    [ResponseDetailControlResultDutyQuantityGUID] VARCHAR (50)    NOT NULL,
    [SequenceNum]                                 INT             NOT NULL,
    [CreditedZollmenge2Q]                         NUMERIC (12, 3) NOT NULL,
    [CreditedZollmenge2UnitQ]                     VARCHAR (3)     NOT NULL,
    [CreditedZollmenge2UnitQualifierQ]            VARCHAR (1)     NOT NULL,
    [DeletedFlag]                                 VARCHAR (1)     NOT NULL,
    [KeepDuringRollback]                          VARCHAR (1)     NOT NULL,
    CONSTRAINT [PK_txdDEImpResponseDetailControlResultDutyQuantity] PRIMARY KEY NONCLUSTERED ([PartnerID] ASC, [DeclarationGUID] ASC, [DeclarationDataGUID] ASC, [GoodsItemGUID] ASC, [ResponseGUID] ASC, [ResponseDetailGUID] ASC, [ResponseDetailControlResultDutyQuantityGUID] ASC) WITH (FILLFACTOR = 90)
);
END


GO
PRINT N'Creating [dbo].[txdDEImpResponseDetailControlResultDutyQuantity].[CIX_txdDEImpResponseDetailControlResultDutyQuantity]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_txdDEImpResponseDetailControlResultDutyQuantity' AND object_id = object_id('txdDEImpResponseDetailControlResultDutyQuantity'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_txdDEImpResponseDetailControlResultDutyQuantity]
    ON [dbo].[txdDEImpResponseDetailControlResultDutyQuantity]([EffDate] ASC);
END


GO
PRINT N'Creating [dbo].[txdDEImpResponseDetailControlResultDutyQuantity].[IX_txdDEImpResponseDetailControlResultDutyQuantity_PKC]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='IX_txdDEImpResponseDetailControlResultDutyQuantity_PKC' AND object_id = object_id('txdDEImpResponseDetailControlResultDutyQuantity'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE NONCLUSTERED INDEX [IX_txdDEImpResponseDetailControlResultDutyQuantity_PKC]
    ON [dbo].[txdDEImpResponseDetailControlResultDutyQuantity]([PartnerID] ASC, [DeclarationGUID] ASC, [DeclarationDataGUID] ASC, [GoodsItemGUID] ASC, [ResponseGUID] ASC, [ResponseDetailGUID] ASC, [ResponseDetailControlResultDutyQuantityGUID] ASC)
    INCLUDE([EffDate], [CreditedZollmenge2Q], [CreditedZollmenge2UnitQ], [CreditedZollmenge2UnitQualifierQ], [SequenceNum]);
END


GO
PRINT N'Creating [dbo].[txdDEImpResponseDetailDepreciation]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdDEImpResponseDetailDepreciation' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[txdDEImpResponseDetailDepreciation] (
    [PartnerID]                      INT          NOT NULL,
    [EffDate]                        DATETIME     NOT NULL,
    [DeclarationGUID]                VARCHAR (50) NOT NULL,
    [ResponseDepreciationGUID]       VARCHAR (50) NOT NULL,
    [ResponseDetailDepreciationGUID] VARCHAR (50) NOT NULL,
    [ItemNumber]                     INT          NOT NULL,
    [DocumentType]                   VARCHAR (4)  NOT NULL,
    [DocumentNumber]                 VARCHAR (35) NOT NULL,
    [DepreciationDate]               DATETIME     NOT NULL,
    [DepreciationCancellationFlag]   VARCHAR (1)  NOT NULL,
    [DepreciationQuantity]           INT          NOT NULL,
    [DepreciationRemainingQuantity]  INT          NOT NULL,
    [DepreciationUoM]                VARCHAR (4)  NOT NULL,
    [DeletedFlag]                    VARCHAR (1)  NOT NULL,
    [KeepDuringRollback]             VARCHAR (1)  NOT NULL,
    CONSTRAINT [PK_txdDEImpResponseDetailDepreciation] PRIMARY KEY NONCLUSTERED ([PartnerID] ASC, [DeclarationGUID] ASC, [ResponseDepreciationGUID] ASC, [ResponseDetailDepreciationGUID] ASC) WITH (FILLFACTOR = 90)
);
END


GO
PRINT N'Creating [dbo].[txdDEImpResponseDetailDepreciation].[CIX_txdDEImpResponseDetailDepreciation]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_txdDEImpResponseDetailDepreciation' AND object_id = object_id('txdDEImpResponseDetailDepreciation'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_txdDEImpResponseDetailDepreciation]
    ON [dbo].[txdDEImpResponseDetailDepreciation]([EffDate] ASC);
END


GO
PRINT N'Creating [dbo].[txdDEImpResponseDetailDepreciation].[IX_txdDEImpResponseDetailDepreciation_PKC]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='IX_txdDEImpResponseDetailDepreciation_PKC' AND object_id = object_id('txdDEImpResponseDetailDepreciation'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE NONCLUSTERED INDEX [IX_txdDEImpResponseDetailDepreciation_PKC]
    ON [dbo].[txdDEImpResponseDetailDepreciation]([PartnerID] ASC, [DeclarationGUID] ASC, [ResponseDepreciationGUID] ASC, [ResponseDetailDepreciationGUID] ASC)
    INCLUDE([DocumentNumber], [DocumentType], [EffDate], [DepreciationCancellationFlag], [DepreciationDate], [DepreciationQuantity], [DepreciationRemainingQuantity], [DepreciationUoM], [ItemNumber]);
END


GO
PRINT N'Creating [dbo].[txdDEImpResponseDetailDutyCalculation]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdDEImpResponseDetailDutyCalculation' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[txdDEImpResponseDetailDutyCalculation] (
    [PartnerID]                          INT             NOT NULL,
    [EffDate]                            DATETIME        NOT NULL,
    [DeclarationGUID]                    VARCHAR (50)    NOT NULL,
    [ResponseGUID]                       VARCHAR (50)    NOT NULL,
    [ResponseDetailGUID]                 VARCHAR (50)    NOT NULL,
    [ResponseDetailDutyCalculationGUID]  VARCHAR (50)    NOT NULL,
    [TypeDutyCalculation]                VARCHAR (5)     NOT NULL,
    [DutyAssessmentBaseIndicator]        VARCHAR (1)     NOT NULL,
    [DutyRatedScale]                     VARCHAR (2)     NOT NULL,
    [DutyTaxRate]                        NUMERIC (12, 5) NOT NULL,
    [CalculatedTaxAmountItem]            NUMERIC (11, 2) NOT NULL,
    [AppliedPVReductionAmount]           NUMERIC (11, 2) NOT NULL,
    [OutstandingDutiesCalculationAmount] NUMERIC (11, 2) NOT NULL,
    [DutyCalculationNote]                VARCHAR (2)     NOT NULL,
    [CreditedDutiesAmountPayable]        NUMERIC (11, 2) NOT NULL,
    [CreditedDutiesAmountQuotaNumber]    VARCHAR (4)     NOT NULL,
    [NonCreditedDutiesAmountPayable]     NUMERIC (11, 2) NOT NULL,
    [DeletedFlag]                        VARCHAR (1)     NOT NULL,
    [KeepDuringRollback]                 VARCHAR (1)     NOT NULL,
    CONSTRAINT [PK_txdDEImpResponseDetailDutyCalculation] PRIMARY KEY NONCLUSTERED ([PartnerID] ASC, [DeclarationGUID] ASC, [ResponseGUID] ASC, [ResponseDetailGUID] ASC, [ResponseDetailDutyCalculationGUID] ASC) WITH (FILLFACTOR = 90)
);
END


GO
PRINT N'Creating [dbo].[txdDEImpResponseDetailDutyCalculation].[CIX_txdDEImpResponseDetailDutyCalculation]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_txdDEImpResponseDetailDutyCalculation' AND object_id = object_id('txdDEImpResponseDetailDutyCalculation'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_txdDEImpResponseDetailDutyCalculation]
    ON [dbo].[txdDEImpResponseDetailDutyCalculation]([EffDate] ASC);
END


GO
PRINT N'Creating [dbo].[txdDEImpResponseDetailDutyDifference]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdDEImpResponseDetailDutyDifference' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[txdDEImpResponseDetailDutyDifference] (
    [PartnerID]                             INT             NOT NULL,
    [EffDate]                               DATETIME        NOT NULL,
    [DeclarationGUID]                       VARCHAR (50)    NOT NULL,
    [ResponseGUID]                          VARCHAR (50)    NOT NULL,
    [ResponseDetailGUID]                    VARCHAR (50)    NOT NULL,
    [ResponseDetailDutyDifferenceGUID]      VARCHAR (50)    NOT NULL,
    [TypeDutyDifference]                    VARCHAR (5)     NOT NULL,
    [OutstandingDutiesAmountDifferenceItem] NUMERIC (11, 2) NOT NULL,
    [RaisedDutyAmountItem]                  NUMERIC (11, 2) NOT NULL,
    [DifferenceDutiesAmountItem]            NUMERIC (11, 2) NOT NULL,
    [DifferenceDutiesAmountEURItem]         NUMERIC (11, 2) NOT NULL,
    [DeletedFlag]                           VARCHAR (1)     NOT NULL,
    [KeepDuringRollback]                    VARCHAR (1)     NOT NULL,
    CONSTRAINT [PK_txdDEImpResponseDetailDutyDifference] PRIMARY KEY NONCLUSTERED ([PartnerID] ASC, [DeclarationGUID] ASC, [ResponseGUID] ASC, [ResponseDetailGUID] ASC, [ResponseDetailDutyDifferenceGUID] ASC) WITH (FILLFACTOR = 90)
);
END


GO
PRINT N'Creating [dbo].[txdDEImpResponseDetailDutyDifference].[CIX_txdDEImpResponseDetailDutyCalculation]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_txdDEImpResponseDetailDutyCalculation' AND object_id = object_id('txdDEImpResponseDetailDutyDifference'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_txdDEImpResponseDetailDutyCalculation]
    ON [dbo].[txdDEImpResponseDetailDutyDifference]([EffDate] ASC);
END


GO
PRINT N'Creating [dbo].[txdDEImpResponseDetailDutyTax]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdDEImpResponseDetailDutyTax' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[txdDEImpResponseDetailDutyTax] (
    [PartnerID]                 INT             NOT NULL,
    [EffDate]                   DATETIME        NOT NULL,
    [DeclarationGUID]           VARCHAR (50)    NOT NULL,
    [ResponseGUID]              VARCHAR (50)    NOT NULL,
    [ResponseDetailGUID]        VARCHAR (50)    NOT NULL,
    [ResponseDetailDutyTaxGUID] VARCHAR (50)    NOT NULL,
    [Zollmenge]                 NUMERIC (12, 3) NOT NULL,
    [ZollmengeUoM]              VARCHAR (4)     NOT NULL,
    [DeletedFlag]               VARCHAR (1)     NOT NULL,
    [KeepDuringRollback]        VARCHAR (1)     NOT NULL,
    CONSTRAINT [PK_txdDEImpResponseDetailDutyTax] PRIMARY KEY NONCLUSTERED ([PartnerID] ASC, [DeclarationGUID] ASC, [ResponseGUID] ASC, [ResponseDetailGUID] ASC, [ResponseDetailDutyTaxGUID] ASC) WITH (FILLFACTOR = 90)
);
END


GO
PRINT N'Creating [dbo].[txdDEImpResponseDetailDutyTax].[CIX_txdDEImpResponseDetailDutyTax]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_txdDEImpResponseDetailDutyTax' AND object_id = object_id('txdDEImpResponseDetailDutyTax'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_txdDEImpResponseDetailDutyTax]
    ON [dbo].[txdDEImpResponseDetailDutyTax]([EffDate] ASC);
END


GO
PRINT N'Creating [dbo].[txdDEImpResponseDetailExcise]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdDEImpResponseDetailExcise' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[txdDEImpResponseDetailExcise] (
    [PartnerID]                INT             NOT NULL,
    [EffDate]                  DATETIME        NOT NULL,
    [DeclarationGUID]          VARCHAR (50)    NOT NULL,
    [ResponseGUID]             VARCHAR (50)    NOT NULL,
    [ResponseDetailGUID]       VARCHAR (50)    NOT NULL,
    [ResponseDetailExciseGUID] VARCHAR (50)    NOT NULL,
    [ConsumptionTaxCode]       VARCHAR (4)     NOT NULL,
    [ExcisePurityPercentage]   NUMERIC (5, 2)  NOT NULL,
    [ExciseValue]              NUMERIC (11, 2) NOT NULL,
    [ConsumptionTaxQuantity]   NUMERIC (12, 3) NOT NULL,
    [ExciseUoM]                VARCHAR (4)     NOT NULL,
    [DeletedFlag]              VARCHAR (1)     NOT NULL,
    [KeepDuringRollback]       VARCHAR (1)     NOT NULL,
    CONSTRAINT [PK_txdDEImpResponseDetailExcise] PRIMARY KEY NONCLUSTERED ([PartnerID] ASC, [DeclarationGUID] ASC, [ResponseGUID] ASC, [ResponseDetailGUID] ASC, [ResponseDetailExciseGUID] ASC) WITH (FILLFACTOR = 90)
);
END


GO
PRINT N'Creating [dbo].[txdDEImpResponseDetailExcise].[CIX_txdDEImpResponseDetailExcise]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_txdDEImpResponseDetailExcise' AND object_id = object_id('txdDEImpResponseDetailExcise'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_txdDEImpResponseDetailExcise]
    ON [dbo].[txdDEImpResponseDetailExcise]([EffDate] ASC);
END


GO
PRINT N'Creating [dbo].[txdDEImpResponseDetailInvestigation]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdDEImpResponseDetailInvestigation' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[txdDEImpResponseDetailInvestigation] (
    [PartnerID]                       INT            NOT NULL,
    [EffDate]                         DATETIME       NOT NULL,
    [DeclarationGUID]                 VARCHAR (50)   NOT NULL,
    [ResponseInvestigationGUID]       VARCHAR (50)   NOT NULL,
    [ResponseDetailInvestigationGUID] VARCHAR (50)   NOT NULL,
    [ItemNumber]                      INT            NOT NULL,
    [InvestigationImportabilityFlag]  VARCHAR (1)    NOT NULL,
    [InvestigationCustomsValueFlag]   VARCHAR (1)    NOT NULL,
    [InvestigationNatureOfGoodsFlag]  VARCHAR (1)    NOT NULL,
    [InvestigationTaxRateFlag]        VARCHAR (1)    NOT NULL,
    [FinalAssessmentReserved]         VARCHAR (1)    NOT NULL,
    [InvestigationOtherFlag]          VARCHAR (1)    NOT NULL,
    [QuotaMessageFlag]                VARCHAR (1)    NOT NULL,
    [ProvisionalAntiDumpingFlag]      VARCHAR (1)    NOT NULL,
    [ItemIncompleteFlag]              VARCHAR (1)    NOT NULL,
    [ItemSubjectToAllowance]          VARCHAR (1)    NOT NULL,
    [AdmissionFinalFlag]              VARCHAR (1)    NOT NULL,
    [FurtherInvestigationReason]      VARCHAR (4000) NOT NULL,
    [DeletedFlag]                     VARCHAR (1)    NOT NULL,
    [KeepDuringRollback]              VARCHAR (1)    NOT NULL,
    CONSTRAINT [PK_txdDEImpResponseDetailInvestigation] PRIMARY KEY NONCLUSTERED ([PartnerID] ASC, [DeclarationGUID] ASC, [ResponseInvestigationGUID] ASC, [ResponseDetailInvestigationGUID] ASC) WITH (FILLFACTOR = 90)
);
END


GO
PRINT N'Creating [dbo].[txdDEImpResponseDetailInvestigation].[CIX_txdDEImpResponseDetailInvestigation]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_txdDEImpResponseDetailInvestigation' AND object_id = object_id('txdDEImpResponseDetailInvestigation'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_txdDEImpResponseDetailInvestigation]
    ON [dbo].[txdDEImpResponseDetailInvestigation]([EffDate] ASC);
END


GO
PRINT N'Creating [dbo].[txdDEImpResponseDetailInvestigation].[IX_txdDEImpResponseDetailInvestigation_PKC]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='IX_txdDEImpResponseDetailInvestigation_PKC' AND object_id = object_id('txdDEImpResponseDetailInvestigation'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE NONCLUSTERED INDEX [IX_txdDEImpResponseDetailInvestigation_PKC]
    ON [dbo].[txdDEImpResponseDetailInvestigation]([PartnerID] ASC, [DeclarationGUID] ASC, [ResponseInvestigationGUID] ASC, [ResponseDetailInvestigationGUID] ASC)
    INCLUDE([AdmissionFinalFlag], [EffDate], [FinalAssessmentReserved], [InvestigationCustomsValueFlag], [InvestigationImportabilityFlag], [InvestigationNatureOfGoodsFlag], [InvestigationOtherFlag], [InvestigationTaxRateFlag], [FurtherInvestigationReason], [ItemIncompleteFlag], [ItemNumber], [ItemSubjectToAllowance], [QuotaMessageFlag], [ProvisionalAntiDumpingFlag]);
END


GO
PRINT N'Creating [dbo].[txdDEImpResponseDetailInvestigationDocument]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdDEImpResponseDetailInvestigationDocument' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[txdDEImpResponseDetailInvestigationDocument] (
    [PartnerID]                               INT          NOT NULL,
    [EffDate]                                 DATETIME     NOT NULL,
    [DeclarationGUID]                         VARCHAR (50) NOT NULL,
    [ResponseDetailInvestigationGUID]         VARCHAR (50) NOT NULL,
    [ResponseDetailInvestigationDocumentGUID] VARCHAR (50) NOT NULL,
    [SequenceNum]                             INT          NOT NULL,
    [DocumentCode]                            VARCHAR (4)  NOT NULL,
    [DocumentDeadlineDate]                    DATETIME     NOT NULL,
    [DocumentSubmitToCustomsOfficeFlag]       VARCHAR (1)  NOT NULL,
    [DocumentSubmitPhysicalFlag]              VARCHAR (1)  NOT NULL,
    [DeletedFlag]                             VARCHAR (1)  NOT NULL,
    [KeepDuringRollback]                      VARCHAR (1)  NOT NULL,
    CONSTRAINT [PK_txdDEImpResponseDetailInvestigationDocument] PRIMARY KEY NONCLUSTERED ([PartnerID] ASC, [DeclarationGUID] ASC, [ResponseDetailInvestigationGUID] ASC, [ResponseDetailInvestigationDocumentGUID] ASC) WITH (FILLFACTOR = 90)
);
END


GO
PRINT N'Creating [dbo].[txdDEImpResponseDetailInvestigationDocument].[CIX_txdDEImpResponseDetailInvestigationDocument]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_txdDEImpResponseDetailInvestigationDocument' AND object_id = object_id('txdDEImpResponseDetailInvestigationDocument'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_txdDEImpResponseDetailInvestigationDocument]
    ON [dbo].[txdDEImpResponseDetailInvestigationDocument]([EffDate] ASC);
END


GO
PRINT N'Creating [dbo].[txdDEImpResponseDetailInvestigationDocument].[IX_txdDEImpResponseDetailInvestigationDocument_PKC]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='IX_txdDEImpResponseDetailInvestigationDocument_PKC' AND object_id = object_id('txdDEImpResponseDetailInvestigationDocument'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE NONCLUSTERED INDEX [IX_txdDEImpResponseDetailInvestigationDocument_PKC]
    ON [dbo].[txdDEImpResponseDetailInvestigationDocument]([PartnerID] ASC, [DeclarationGUID] ASC, [ResponseDetailInvestigationGUID] ASC, [ResponseDetailInvestigationDocumentGUID] ASC)
    INCLUDE([DocumentDeadlineDate], [DocumentSubmitPhysicalFlag], [DocumentSubmitToCustomsOfficeFlag], [EffDate], [DocumentCode], [SequenceNum]);
END


GO
PRINT N'Creating [dbo].[txdDEImpResponseDetailReduction]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdDEImpResponseDetailReduction' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[txdDEImpResponseDetailReduction] (
    [PartnerID]                        INT             NOT NULL,
    [EffDate]                          DATETIME        NOT NULL,
    [DeclarationGUID]                  VARCHAR (50)    NOT NULL,
    [ResponseGUID]                     VARCHAR (50)    NOT NULL,
    [ResponseDetailGUID]               VARCHAR (50)    NOT NULL,
    [ResponseDetailReductionGUID]      VARCHAR (50)    NOT NULL,
    [TaxTypeReduction]                 VARCHAR (5)     NOT NULL,
    [OutwardProcessingReductionAmount] NUMERIC (11, 2) NOT NULL,
    [DeletedFlag]                      VARCHAR (1)     NOT NULL,
    [KeepDuringRollback]               VARCHAR (1)     NOT NULL,
    CONSTRAINT [PK_txdDEImpResponseDetailReduction] PRIMARY KEY NONCLUSTERED ([PartnerID] ASC, [DeclarationGUID] ASC, [ResponseGUID] ASC, [ResponseDetailGUID] ASC, [ResponseDetailReductionGUID] ASC) WITH (FILLFACTOR = 90)
);
END


GO
PRINT N'Creating [dbo].[txdDEImpResponseDetailReduction].[CIX_txdDEImpResponseDetailReduction]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_txdDEImpResponseDetailReduction' AND object_id = object_id('txdDEImpResponseDetailReduction'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_txdDEImpResponseDetailReduction]
    ON [dbo].[txdDEImpResponseDetailReduction]([EffDate] ASC);
END


GO
PRINT N'Creating [dbo].[txdDEImpResponseDetailSecurityCalculation]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdDEImpResponseDetailSecurityCalculation' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[txdDEImpResponseDetailSecurityCalculation] (
    [PartnerID]                             INT             NOT NULL,
    [EffDate]                               DATETIME        NOT NULL,
    [DeclarationGUID]                       VARCHAR (50)    NOT NULL,
    [ResponseGUID]                          VARCHAR (50)    NOT NULL,
    [ResponseDetailGUID]                    VARCHAR (50)    NOT NULL,
    [ResponseDetailSecurityCalculationGUID] VARCHAR (50)    NOT NULL,
    [TypeSecurityDifference]                VARCHAR (5)     NOT NULL,
    [SecurityAssessmentBaseIndicator]       VARCHAR (1)     NOT NULL,
    [SecurityRatedScale]                    VARCHAR (2)     NOT NULL,
    [SecurityTaxRate]                       NUMERIC (12, 5) NOT NULL,
    [OutstandingSecurityCalculationAmount]  NUMERIC (11, 2) NOT NULL,
    [DeletedFlag]                           VARCHAR (1)     NOT NULL,
    [KeepDuringRollback]                    VARCHAR (1)     NOT NULL,
    CONSTRAINT [PK_txdDEImpResponseDetailSecurityCalculation] PRIMARY KEY NONCLUSTERED ([PartnerID] ASC, [DeclarationGUID] ASC, [ResponseGUID] ASC, [ResponseDetailGUID] ASC, [ResponseDetailSecurityCalculationGUID] ASC) WITH (FILLFACTOR = 90)
);
END


GO
PRINT N'Creating [dbo].[txdDEImpResponseDetailSecurityCalculation].[CIX_txdDEImpResponseDetailSecurityCalculation]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_txdDEImpResponseDetailSecurityCalculation' AND object_id = object_id('txdDEImpResponseDetailSecurityCalculation'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_txdDEImpResponseDetailSecurityCalculation]
    ON [dbo].[txdDEImpResponseDetailSecurityCalculation]([EffDate] ASC);
END


GO
PRINT N'Creating [dbo].[txdDEImpResponseDetailSecurityDifference]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdDEImpResponseDetailSecurityDifference' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[txdDEImpResponseDetailSecurityDifference] (
    [PartnerID]                               INT             NOT NULL,
    [EffDate]                                 DATETIME        NOT NULL,
    [DeclarationGUID]                         VARCHAR (50)    NOT NULL,
    [ResponseGUID]                            VARCHAR (50)    NOT NULL,
    [ResponseDetailGUID]                      VARCHAR (50)    NOT NULL,
    [ResponseDetailSecurityDifferenceGUID]    VARCHAR (50)    NOT NULL,
    [TypeSecurityDifference]                  VARCHAR (5)     NOT NULL,
    [OutstandingSecurityAmountDifferenceItem] NUMERIC (11, 2) NOT NULL,
    [RaisedSecurityAmountItem]                NUMERIC (11, 2) NOT NULL,
    [DifferenceSecurityAmountItem]            NUMERIC (11, 2) NOT NULL,
    [DifferenceSecurityAmountEURItem]         NUMERIC (11, 2) NOT NULL,
    [DeletedFlag]                             VARCHAR (1)     NOT NULL,
    [KeepDuringRollback]                      VARCHAR (1)     NOT NULL,
    CONSTRAINT [PK_txdDEImpResponseDetailSecurityDifference] PRIMARY KEY NONCLUSTERED ([PartnerID] ASC, [DeclarationGUID] ASC, [ResponseGUID] ASC, [ResponseDetailGUID] ASC, [ResponseDetailSecurityDifferenceGUID] ASC) WITH (FILLFACTOR = 90)
);
END


GO
PRINT N'Creating [dbo].[txdDEImpResponseDetailSecurityDifference].[CIX_txdDEImpResponseDetailSecurityDifference]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_txdDEImpResponseDetailSecurityDifference' AND object_id = object_id('txdDEImpResponseDetailSecurityDifference'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_txdDEImpResponseDetailSecurityDifference]
    ON [dbo].[txdDEImpResponseDetailSecurityDifference]([EffDate] ASC);
END


GO
PRINT N'Creating [dbo].[txdDEImpResponseDetailSpecialValue]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdDEImpResponseDetailSpecialValue' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[txdDEImpResponseDetailSpecialValue] (
    [PartnerID]                      INT             NOT NULL,
    [EffDate]                        DATETIME        NOT NULL,
    [DeclarationGUID]                VARCHAR (50)    NOT NULL,
    [ResponseGUID]                   VARCHAR (50)    NOT NULL,
    [ResponseDetailGUID]             VARCHAR (50)    NOT NULL,
    [ResponseDetailSpecialValueGUID] VARCHAR (50)    NOT NULL,
    [PriceCategory]                  VARCHAR (1)     NOT NULL,
    [SpecialValueSpecified]          NUMERIC (11, 2) NOT NULL,
    [DeletedFlag]                    VARCHAR (1)     NOT NULL,
    [KeepDuringRollback]             VARCHAR (1)     NOT NULL,
    CONSTRAINT [PK_txdDEImpResponseDetailSpecialValue] PRIMARY KEY NONCLUSTERED ([PartnerID] ASC, [DeclarationGUID] ASC, [ResponseGUID] ASC, [ResponseDetailGUID] ASC, [ResponseDetailSpecialValueGUID] ASC) WITH (FILLFACTOR = 90)
);
END


GO
PRINT N'Creating [dbo].[txdDEImpResponseDetailSpecialValue].[CIX_txdDEImpResponseDetailSpecialValue]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_txdDEImpResponseDetailSpecialValue' AND object_id = object_id('txdDEImpResponseDetailSpecialValue'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_txdDEImpResponseDetailSpecialValue]
    ON [dbo].[txdDEImpResponseDetailSpecialValue]([EffDate] ASC);
END


GO
PRINT N'Creating [dbo].[txdDEImpResponseForward]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdDEImpResponseForward' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[txdDEImpResponseForward] (
    [PartnerID]                            INT            NOT NULL,
    [EffDate]                              DATETIME       NOT NULL,
    [DeclarationGUID]                      VARCHAR (50)   NOT NULL,
    [ResponseForwardGUID]                  VARCHAR (50)   NOT NULL,
    [SequenceNum]                          INT            NOT NULL,
    [ScenarioNumber]                       VARCHAR (5)    NOT NULL,
    [CustomsOfficerName]                   VARCHAR (30)   NOT NULL,
    [ForwardedReason]                      VARCHAR (4000) NOT NULL,
    [ForwardedMovementReferenceNumber]     VARCHAR (21)   NOT NULL,
    [ForwardedDate]                        DATETIME       NOT NULL,
    [ForwardedCustomsOfficeIdentification] VARCHAR (4)    NOT NULL,
    [ForwardedCustomsOfficeName]           NVARCHAR (120) NOT NULL,
    [ForwardedCustomsOfficeAddressLine1]   NVARCHAR (30)  NOT NULL,
    [ForwardedCustomsOfficePostCode]       VARCHAR (6)    NOT NULL,
    [ForwardedCustomsOfficeCity]           NVARCHAR (35)  NOT NULL,
    [ForwardedCustomsOfficePOBoxPostal]    VARCHAR (20)   NOT NULL,
    [ForwardedCustomsOfficePostCodePostal] VARCHAR (9)    NOT NULL,
    [ForwardedCustomsOfficeCityPostal]     VARCHAR (35)   NOT NULL,
    [DeletedFlag]                          VARCHAR (1)    NOT NULL,
    [KeepDuringRollback]                   VARCHAR (1)    NOT NULL,
    CONSTRAINT [PK_txdDEImpResponseForward] PRIMARY KEY NONCLUSTERED ([PartnerID] ASC, [DeclarationGUID] ASC, [ResponseForwardGUID] ASC) WITH (FILLFACTOR = 90)
);
END


GO
PRINT N'Creating [dbo].[txdDEImpResponseForward].[CIX_txdDEImpResponseForward]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_txdDEImpResponseForward' AND object_id = object_id('txdDEImpResponseForward'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_txdDEImpResponseForward]
    ON [dbo].[txdDEImpResponseForward]([EffDate] ASC);
END


GO
PRINT N'Creating [dbo].[txdDEImpResponseForward].[IX_txdDEImpResponseForward_PKC]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='IX_txdDEImpResponseForward_PKC' AND object_id = object_id('txdDEImpResponseForward'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE NONCLUSTERED INDEX [IX_txdDEImpResponseForward_PKC]
    ON [dbo].[txdDEImpResponseForward]([PartnerID] ASC, [DeclarationGUID] ASC, [ResponseForwardGUID] ASC)
    INCLUDE([EffDate], [CustomsOfficerName], [ForwardedCustomsOfficeAddressLine1], [ForwardedCustomsOfficeCity], [ForwardedCustomsOfficeCityPostal], [ForwardedCustomsOfficeIdentification], [ForwardedCustomsOfficeName], [ForwardedCustomsOfficePOBoxPostal], [ForwardedCustomsOfficePostCode], [ForwardedCustomsOfficePostCodePostal], [ForwardedDate], [ForwardedMovementReferenceNumber], [ForwardedReason], [ScenarioNumber], [SequenceNum]);
END


GO
PRINT N'Creating [dbo].[txdDEImpResponseInvestigation]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdDEImpResponseInvestigation' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[txdDEImpResponseInvestigation] (
    [PartnerID]                 INT           NOT NULL,
    [EffDate]                   DATETIME      NOT NULL,
    [DeclarationGUID]           VARCHAR (50)  NOT NULL,
    [ResponseInvestigationGUID] VARCHAR (50)  NOT NULL,
    [SequenceNum]               INT           NOT NULL,
    [ScenarioNumber]            INT           NOT NULL,
    [LocalReferenceNumber]      VARCHAR (35)  NOT NULL,
    [MovementReferenceNumber]   VARCHAR (21)  NOT NULL,
    [VATNumber]                 NVARCHAR (20) NOT NULL,
    [DeletedFlag]               VARCHAR (1)   NOT NULL,
    [KeepDuringRollback]        VARCHAR (1)   NOT NULL,
    CONSTRAINT [PK_txdDEImpResponseInvestigation] PRIMARY KEY NONCLUSTERED ([PartnerID] ASC, [DeclarationGUID] ASC, [ResponseInvestigationGUID] ASC) WITH (FILLFACTOR = 90)
);
END


GO
PRINT N'Creating [dbo].[txdDEImpResponseInvestigation].[CIX_txdDEImpResponseInvestigation]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_txdDEImpResponseInvestigation' AND object_id = object_id('txdDEImpResponseInvestigation'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_txdDEImpResponseInvestigation]
    ON [dbo].[txdDEImpResponseInvestigation]([EffDate] ASC);
END


GO
PRINT N'Creating [dbo].[txdDEImpResponseInvestigation].[IX_txdDEImpResponseInvestigation_PKC]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='IX_txdDEImpResponseInvestigation_PKC' AND object_id = object_id('txdDEImpResponseInvestigation'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE NONCLUSTERED INDEX [IX_txdDEImpResponseInvestigation_PKC]
    ON [dbo].[txdDEImpResponseInvestigation]([PartnerID] ASC, [DeclarationGUID] ASC, [ResponseInvestigationGUID] ASC)
    INCLUDE([EffDate], [SequenceNum], [ScenarioNumber], [LocalReferenceNumber], [MovementReferenceNumber], [VATNumber]) WITH (FILLFACTOR = 100);
END


GO
PRINT N'Creating [dbo].[txdDEImpResponseLevy]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdDEImpResponseLevy' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[txdDEImpResponseLevy] (
    [PartnerID]                        INT             NOT NULL,
    [EffDate]                          DATETIME        NOT NULL,
    [DeclarationGUID]                  VARCHAR (50)    NOT NULL,
    [ResponseGUID]                     VARCHAR (50)    NOT NULL,
    [ResponseLevyGUID]                 VARCHAR (50)    NOT NULL,
    [RemittingDutiesAmount]            NUMERIC (12, 2) NOT NULL,
    [DutyRefundAmount]                 NUMERIC (12, 2) NOT NULL,
    [TaxPayableAmount]                 NUMERIC (12, 2) NOT NULL,
    [MethodPaymentPayableDutyAmount]   VARCHAR (1)     NOT NULL,
    [MethodPaymentReimbursementDuties] VARCHAR (1)     NOT NULL,
    [StatementAssignmentIndicator]     VARCHAR (1)     NOT NULL,
    [DutiesPayeeId]                    VARCHAR (17)    NOT NULL,
    [DutiesPayeeAuthorisedIdentity]    VARCHAR (4)     NOT NULL,
    [DutiesPayeeName]                  NVARCHAR (120)  NOT NULL,
    [DutiesPayeeAddressLine1]          NVARCHAR (35)   NOT NULL,
    [DutiesPayeeCountry]               VARCHAR (2)     NOT NULL,
    [DutiesPayeePostCode]              VARCHAR (9)     NOT NULL,
    [DutiesPayeeCity]                  NVARCHAR (35)   NOT NULL,
    [DutiesPayeeRegion]                NVARCHAR (35)   NOT NULL,
    [DutiesPayeeAccountHolder]         NVARCHAR (35)   NOT NULL,
    [DutiesPayeeCreditInstitution]     NVARCHAR (30)   NOT NULL,
    [DutiesPayeeIBAN]                  VARCHAR (34)    NOT NULL,
    [DutiesPayeeBIC]                   VARCHAR (11)    NOT NULL,
    [DeletedFlag]                      VARCHAR (1)     NOT NULL,
    [KeepDuringRollback]               VARCHAR (1)     NOT NULL,
    CONSTRAINT [PK_txdDEImpResponseLevy] PRIMARY KEY NONCLUSTERED ([PartnerID] ASC, [DeclarationGUID] ASC, [ResponseGUID] ASC, [ResponseLevyGUID] ASC) WITH (FILLFACTOR = 90)
);
END


GO
PRINT N'Creating [dbo].[txdDEImpResponseLevy].[CIX_txdDEImpResponseLevy]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_txdDEImpResponseLevy' AND object_id = object_id('txdDEImpResponseLevy'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_txdDEImpResponseLevy]
    ON [dbo].[txdDEImpResponseLevy]([EffDate] ASC);
END


GO
PRINT N'Creating [dbo].[txdDEImpResponseLevyDeferral]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdDEImpResponseLevyDeferral' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[txdDEImpResponseLevyDeferral] (
    [PartnerID]                          INT           NOT NULL,
    [EffDate]                            DATETIME      NOT NULL,
    [DeclarationGUID]                    VARCHAR (50)  NOT NULL,
    [ResponseGUID]                       VARCHAR (50)  NOT NULL,
    [ResponseLevyGUID]                   VARCHAR (50)  NOT NULL,
    [ResponseLevyDeferralGUID]           VARCHAR (50)  NOT NULL,
    [DeferredPaymentType]                VARCHAR (2)   NOT NULL,
    [DeferredPaymentAccountNumber]       VARCHAR (6)   NOT NULL,
    [DeferredPaymentAccountNumberPrefix] VARCHAR (3)   NOT NULL,
    [DeferredPaymentRequestType]         VARCHAR (1)   NOT NULL,
    [DeferredPaymentAccountHolder]       VARCHAR (100) NOT NULL,
    [DeletedFlag]                        VARCHAR (1)   NOT NULL,
    [KeepDuringRollback]                 VARCHAR (1)   NOT NULL,
    CONSTRAINT [PK_txdDEImpResponseLevyDeferral] PRIMARY KEY NONCLUSTERED ([PartnerID] ASC, [DeclarationGUID] ASC, [ResponseGUID] ASC, [ResponseLevyGUID] ASC, [ResponseLevyDeferralGUID] ASC) WITH (FILLFACTOR = 90)
);
END


GO
PRINT N'Creating [dbo].[txdDEImpResponseLevyDeferral].[CIX_txdDEImpResponseLevyDeferral]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_txdDEImpResponseLevyDeferral' AND object_id = object_id('txdDEImpResponseLevyDeferral'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_txdDEImpResponseLevyDeferral]
    ON [dbo].[txdDEImpResponseLevyDeferral]([EffDate] ASC);
END


GO
PRINT N'Creating [dbo].[txdDEImpResponseLevyDuty]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdDEImpResponseLevyDuty' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[txdDEImpResponseLevyDuty] (
    [PartnerID]               INT             NOT NULL,
    [EffDate]                 DATETIME        NOT NULL,
    [DeclarationGUID]         VARCHAR (50)    NOT NULL,
    [ResponseGUID]            VARCHAR (50)    NOT NULL,
    [ResponseLevyGUID]        VARCHAR (50)    NOT NULL,
    [ResponseLevyDutyGUID]    VARCHAR (50)    NOT NULL,
    [TaxType]                 VARCHAR (5)     NOT NULL,
    [OutstandingDutiesAmount] NUMERIC (11, 2) NOT NULL,
    [RaisedDutiesAmount]      NUMERIC (11, 2) NOT NULL,
    [DifferenceDutiesAmount]  NUMERIC (11, 2) NOT NULL,
    [DeletedFlag]             VARCHAR (1)     NOT NULL,
    [KeepDuringRollback]      VARCHAR (1)     NOT NULL,
    CONSTRAINT [PK_txdDEImpResponseLevyDuty] PRIMARY KEY NONCLUSTERED ([PartnerID] ASC, [DeclarationGUID] ASC, [ResponseGUID] ASC, [ResponseLevyGUID] ASC, [ResponseLevyDutyGUID] ASC) WITH (FILLFACTOR = 90)
);
END


GO
PRINT N'Creating [dbo].[txdDEImpResponseLevyDuty].[CIX_txdDEImpResponseLevyDuty]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_txdDEImpResponseLevyDuty' AND object_id = object_id('txdDEImpResponseLevyDuty'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_txdDEImpResponseLevyDuty]
    ON [dbo].[txdDEImpResponseLevyDuty]([EffDate] ASC);
END


GO
PRINT N'Creating [dbo].[txdDEImpResponseLiability]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdDEImpResponseLiability' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[txdDEImpResponseLiability] (
    [PartnerID]                   INT            NOT NULL,
    [EffDate]                     DATETIME       NOT NULL,
    [DeclarationGUID]             VARCHAR (50)   NOT NULL,
    [ResponseGUID]                VARCHAR (50)   NOT NULL,
    [ResponseLiabilityGUID]       VARCHAR (50)   NOT NULL,
    [LiabilityDebtorCopyNumber]   VARCHAR (2)    NOT NULL,
    [LiabilityDebtorTIN]          VARCHAR (17)   NOT NULL,
    [LiabilityDebtorBranchNumber] VARCHAR (4)    NOT NULL,
    [LiabilityDebtorName]         NVARCHAR (120) NOT NULL,
    [LiabilityDebtorStreetNumber] NVARCHAR (35)  NOT NULL,
    [LiabilityDebtorCountry]      VARCHAR (2)    NOT NULL,
    [LiabilityDebtorPostCode]     VARCHAR (9)    NOT NULL,
    [LiabilityDebtorCity]         NVARCHAR (35)  NOT NULL,
    [LiabilityDebtorRegion]       NVARCHAR (35)  NOT NULL,
    [DeletedFlag]                 VARCHAR (1)    NOT NULL,
    [KeepDuringRollback]          VARCHAR (1)    NOT NULL,
    CONSTRAINT [PK_txdDEImpResponseLiability] PRIMARY KEY NONCLUSTERED ([PartnerID] ASC, [DeclarationGUID] ASC, [ResponseGUID] ASC, [ResponseLiabilityGUID] ASC) WITH (FILLFACTOR = 90)
);
END


GO
PRINT N'Creating [dbo].[txdDEImpResponseLiability].[CIX_txdDEImpResponseLiability]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_txdDEImpResponseLiability' AND object_id = object_id('txdDEImpResponseLiability'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_txdDEImpResponseLiability]
    ON [dbo].[txdDEImpResponseLiability]([EffDate] ASC);
END


GO
PRINT N'Creating [dbo].[txdDEImpResponseNonCashSecurity]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdDEImpResponseNonCashSecurity' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[txdDEImpResponseNonCashSecurity] (
    [PartnerID]                           INT             NOT NULL,
    [EffDate]                             DATETIME        NOT NULL,
    [DeclarationGUID]                     VARCHAR (50)    NOT NULL,
    [ResponseGUID]                        VARCHAR (50)    NOT NULL,
    [ResponseResponseNonCashSecurityGUID] VARCHAR (50)    NOT NULL,
    [SequenceNum]                         INT             NOT NULL,
    [NonCashSecurityAmount]               NUMERIC (11, 2) NOT NULL,
    [NonCashSecurityType]                 VARCHAR (2)     NOT NULL,
    [DeletedFlag]                         VARCHAR (1)     NOT NULL,
    [KeepDuringRollback]                  VARCHAR (1)     NOT NULL,
    CONSTRAINT [PK_txdDEImpResponseNonCashSecurity] PRIMARY KEY NONCLUSTERED ([PartnerID] ASC, [DeclarationGUID] ASC, [ResponseGUID] ASC, [ResponseResponseNonCashSecurityGUID] ASC) WITH (FILLFACTOR = 90)
);
END


GO
PRINT N'Creating [dbo].[txdDEImpResponseNonCashSecurity].[CIX_txdDEImpResponseNonCashSecurity]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_txdDEImpResponseNonCashSecurity' AND object_id = object_id('txdDEImpResponseNonCashSecurity'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_txdDEImpResponseNonCashSecurity]
    ON [dbo].[txdDEImpResponseNonCashSecurity]([EffDate] ASC);
END


GO
PRINT N'Creating [dbo].[txdDEImpResponseNonCashSecurity].[IX_txdDEImpResponseNonCashSecurity_PKC]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='IX_txdDEImpResponseNonCashSecurity_PKC' AND object_id = object_id('txdDEImpResponseNonCashSecurity'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE NONCLUSTERED INDEX [IX_txdDEImpResponseNonCashSecurity_PKC]
    ON [dbo].[txdDEImpResponseNonCashSecurity]([PartnerID] ASC, [DeclarationGUID] ASC, [ResponseGUID] ASC, [ResponseResponseNonCashSecurityGUID] ASC)
    INCLUDE([EffDate], [NonCashSecurityAmount], [NonCashSecurityType], [SequenceNum]);
END


GO
PRINT N'Creating [dbo].[txdDEImpResponseParty]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdDEImpResponseParty' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[txdDEImpResponseParty] (
    [PartnerID]          INT            NOT NULL,
    [EffDate]            DATETIME       NOT NULL,
    [DeclarationGUID]    VARCHAR (50)   NOT NULL,
    [ResponseGUID]       VARCHAR (50)   NOT NULL,
    [ResponsePartyGUID]  VARCHAR (50)   NOT NULL,
    [SequenceNum]        INT            NOT NULL,
    [PartyId]            VARCHAR (17)   NOT NULL,
    [PartyName]          NVARCHAR (120) NOT NULL,
    [PartyAddressLine1]  NVARCHAR (35)  NOT NULL,
    [PartyCountry]       VARCHAR (2)    NOT NULL,
    [PartyPostalCode]    NVARCHAR (9)   NOT NULL,
    [PartyCity]          NVARCHAR (35)  NOT NULL,
    [PartyRegion]        NVARCHAR (35)  NOT NULL,
    [DeletedFlag]        VARCHAR (1)    NOT NULL,
    [KeepDuringRollback] VARCHAR (1)    NOT NULL,
    CONSTRAINT [PK_txdDEImpResponseParty] PRIMARY KEY NONCLUSTERED ([PartnerID] ASC, [DeclarationGUID] ASC, [ResponseGUID] ASC, [ResponsePartyGUID] ASC) WITH (FILLFACTOR = 90)
);
END


GO
PRINT N'Creating [dbo].[txdDEImpResponseParty].[CIX_txdDEImpResponseParty]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_txdDEImpResponseParty' AND object_id = object_id('txdDEImpResponseParty'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_txdDEImpResponseParty]
    ON [dbo].[txdDEImpResponseParty]([EffDate] ASC);
END


GO
PRINT N'Creating [dbo].[txdDEImpResponseParty].[IX_txdDEImpResponseParty_PKC]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='IX_txdDEImpResponseParty_PKC' AND object_id = object_id('txdDEImpResponseParty'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE NONCLUSTERED INDEX [IX_txdDEImpResponseParty_PKC]
    ON [dbo].[txdDEImpResponseParty]([PartnerID] ASC, [DeclarationGUID] ASC, [ResponseGUID] ASC, [ResponsePartyGUID] ASC)
    INCLUDE([EffDate], [PartyAddressLine1], [PartyCity], [PartyCountry], [PartyId], [PartyName], [PartyPostalCode], [PartyRegion], [SequenceNum]);
END


GO
PRINT N'Creating [dbo].[txdDEImpResponseSecurity]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdDEImpResponseSecurity' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[txdDEImpResponseSecurity] (
    [PartnerID]                              INT             NOT NULL,
    [EffDate]                                DATETIME        NOT NULL,
    [DeclarationGUID]                        VARCHAR (50)    NOT NULL,
    [ResponseGUID]                           VARCHAR (50)    NOT NULL,
    [ResponseSecurityGUID]                   VARCHAR (50)    NOT NULL,
    [TypeSecurityAmount]                     VARCHAR (1)     NOT NULL,
    [SecurityAmountCollected]                NUMERIC (11, 2) NOT NULL,
    [TotalNonCashCollateralAmount]           NUMERIC (11, 2) NOT NULL,
    [PayableCashSecurityAmount]              NUMERIC (11, 2) NOT NULL,
    [ReleasedSecurityAmount]                 NUMERIC (11, 2) NOT NULL,
    [SecurityAmountPaidOut]                  NUMERIC (11, 2) NOT NULL,
    [DischargeNonCashSecurity]               NUMERIC (11, 2) NOT NULL,
    [MethodPaymentReleasableSecurityAmounts] VARCHAR (1)     NOT NULL,
    [DutiesPayeeId]                          VARCHAR (17)    NOT NULL,
    [DutiesPayeeAuthorisedIdentity]          VARCHAR (4)     NOT NULL,
    [DutiesPayeeName]                        NVARCHAR (120)  NOT NULL,
    [DutiesPayeeAddressLine1]                NVARCHAR (35)   NOT NULL,
    [DutiesPayeeCountry]                     VARCHAR (2)     NOT NULL,
    [DutiesPayeePostCode]                    VARCHAR (9)     NOT NULL,
    [DutiesPayeeCity]                        NVARCHAR (35)   NOT NULL,
    [DutiesPayeeRegion]                      NVARCHAR (35)   NOT NULL,
    [DutiesPayeeCreditInstitution]           NVARCHAR (30)   NOT NULL,
    [DutiesPayeeIBAN]                        VARCHAR (34)    NOT NULL,
    [DutiesPayeeBIC]                         VARCHAR (11)    NOT NULL,
    [DeletedFlag]                            VARCHAR (1)     NOT NULL,
    [KeepDuringRollback]                     VARCHAR (1)     NOT NULL,
    CONSTRAINT [PK_txdDEImpResponseSecurity] PRIMARY KEY NONCLUSTERED ([PartnerID] ASC, [DeclarationGUID] ASC, [ResponseGUID] ASC, [ResponseSecurityGUID] ASC) WITH (FILLFACTOR = 90)
);
END


GO
PRINT N'Creating [dbo].[txdDEImpResponseSecurity].[CIX_txdDEImpResponseSecurity]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_txdDEImpResponseSecurity' AND object_id = object_id('txdDEImpResponseSecurity'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_txdDEImpResponseSecurity]
    ON [dbo].[txdDEImpResponseSecurity]([EffDate] ASC);
END


GO
PRINT N'Creating [dbo].[txdDEImpResponseSecurityDetail]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdDEImpResponseSecurityDetail' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[txdDEImpResponseSecurityDetail] (
    [PartnerID]                  INT             NOT NULL,
    [EffDate]                    DATETIME        NOT NULL,
    [DeclarationGUID]            VARCHAR (50)    NOT NULL,
    [ResponseGUID]               VARCHAR (50)    NOT NULL,
    [ResponseSecurityGUID]       VARCHAR (50)    NOT NULL,
    [ResponseSecurityDetailGUID] VARCHAR (50)    NOT NULL,
    [NonCashSecurityAmount]      NUMERIC (11, 2) NOT NULL,
    [NonCashSecurityType]        VARCHAR (2)     NOT NULL,
    [DeletedFlag]                VARCHAR (1)     NOT NULL,
    [KeepDuringRollback]         VARCHAR (1)     NOT NULL,
    CONSTRAINT [PK_txdDEImpResponseSecurityDetail] PRIMARY KEY NONCLUSTERED ([PartnerID] ASC, [DeclarationGUID] ASC, [ResponseGUID] ASC, [ResponseSecurityGUID] ASC, [ResponseSecurityDetailGUID] ASC) WITH (FILLFACTOR = 90)
);
END


GO
PRINT N'Creating [dbo].[txdDEImpResponseSecurityDetail].[CIX_txdDEImpResponseSecurityDetail]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_txdDEImpResponseSecurityDetail' AND object_id = object_id('txdDEImpResponseSecurityDetail'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_txdDEImpResponseSecurityDetail]
    ON [dbo].[txdDEImpResponseSecurityDetail]([EffDate] ASC);
END


GO
PRINT N'Creating [dbo].[txdDEImpResponseSecurityFormation]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdDEImpResponseSecurityFormation' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[txdDEImpResponseSecurityFormation] (
    [PartnerID]                     INT             NOT NULL,
    [EffDate]                       DATETIME        NOT NULL,
    [DeclarationGUID]               VARCHAR (50)    NOT NULL,
    [ResponseGUID]                  VARCHAR (50)    NOT NULL,
    [ResponseSecurityGUID]          VARCHAR (50)    NOT NULL,
    [ResponseSecurityFormationGUID] VARCHAR (50)    NOT NULL,
    [SecurityType]                  VARCHAR (5)     NOT NULL,
    [RaisedSecurityAmount]          NUMERIC (11, 2) NOT NULL,
    [OutstandingSecurityAmount]     NUMERIC (11, 2) NOT NULL,
    [DifferenceSecurityAmount]      NUMERIC (11, 2) NOT NULL,
    [DeletedFlag]                   VARCHAR (1)     NOT NULL,
    [KeepDuringRollback]            VARCHAR (1)     NOT NULL,
    CONSTRAINT [PK_txdDEImpResponseSecurityFormation] PRIMARY KEY NONCLUSTERED ([PartnerID] ASC, [DeclarationGUID] ASC, [ResponseGUID] ASC, [ResponseSecurityGUID] ASC, [ResponseSecurityFormationGUID] ASC) WITH (FILLFACTOR = 90)
);
END


GO
PRINT N'Creating [dbo].[txdDEImpResponseSecurityFormation].[CIX_txdDEImpResponseSecurityFormation]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_txdDEImpResponseSecurityFormation' AND object_id = object_id('txdDEImpResponseSecurityFormation'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_txdDEImpResponseSecurityFormation]
    ON [dbo].[txdDEImpResponseSecurityFormation]([EffDate] ASC);
END


GO
PRINT N'Creating [dbo].[txdDEImpResponseSecuritySummary]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdDEImpResponseSecuritySummary' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[txdDEImpResponseSecuritySummary] (
    [PartnerID]                 INT             NOT NULL,
    [EffDate]                   DATETIME        NOT NULL,
    [DeclarationGUID]           VARCHAR (50)    NOT NULL,
    [ResponseGUID]              VARCHAR (50)    NOT NULL,
    [ResponseDutySummaryGUID]   VARCHAR (50)    NOT NULL,
    [SequenceNum]               INT             NOT NULL,
    [CollateralToBeCollected]   NUMERIC (11, 2) NOT NULL,
    [CollateralTotalCalculated] NUMERIC (11, 2) NOT NULL,
    [CollateralTotalNonCashDue] NUMERIC (11, 2) NOT NULL,
    [CollateralCashDue]         NUMERIC (11, 2) NOT NULL,
    [GuaranteeReleasedAmount]   NUMERIC (11, 2) NOT NULL,
    [GuaranteeDueAmount]        NUMERIC (11, 2) NOT NULL,
    [GuaranteeRetainedAmount]   NUMERIC (11, 2) NOT NULL,
    [GuaranteeType]             VARCHAR (1)     NOT NULL,
    [GuaranteeWaiver]           VARCHAR (1)     NOT NULL,
    [GuaranteePaymentMethod]    VARCHAR (1)     NOT NULL,
    [DeletedFlag]               VARCHAR (1)     NOT NULL,
    [KeepDuringRollback]        VARCHAR (1)     NOT NULL,
    CONSTRAINT [PK_txdDEImpResponseSecuritySummary] PRIMARY KEY NONCLUSTERED ([PartnerID] ASC, [DeclarationGUID] ASC, [ResponseGUID] ASC, [ResponseDutySummaryGUID] ASC) WITH (FILLFACTOR = 90)
);
END


GO
PRINT N'Creating [dbo].[txdDEImpResponseSecuritySummary].[CIX_txdDEImpResponseSecuritySummary]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_txdDEImpResponseSecuritySummary' AND object_id = object_id('txdDEImpResponseSecuritySummary'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_txdDEImpResponseSecuritySummary]
    ON [dbo].[txdDEImpResponseSecuritySummary]([EffDate] ASC);
END


GO
PRINT N'Creating [dbo].[txdDEImpResponseSecuritySummary].[IX_txdDEImpResponseSecuritySummary_PKC]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='IX_txdDEImpResponseSecuritySummary_PKC' AND object_id = object_id('txdDEImpResponseSecuritySummary'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE NONCLUSTERED INDEX [IX_txdDEImpResponseSecuritySummary_PKC]
    ON [dbo].[txdDEImpResponseSecuritySummary]([PartnerID] ASC, [DeclarationGUID] ASC, [ResponseGUID] ASC, [ResponseDutySummaryGUID] ASC)
    INCLUDE([EffDate], [CollateralCashDue], [CollateralToBeCollected], [CollateralTotalCalculated], [CollateralTotalNonCashDue], [GuaranteeDueAmount], [GuaranteePaymentMethod], [GuaranteeReleasedAmount], [GuaranteeRetainedAmount], [GuaranteeType], [GuaranteeWaiver], [SequenceNum]);
END


GO
PRINT N'Creating [dbo].[txdDEImpSupplementaryData_DeclarationData]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdDEImpSupplementaryData_DeclarationData' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[txdDEImpSupplementaryData_DeclarationData] (
    [PartnerID]                   INT          NOT NULL,
    [EffDate]                     DATETIME     NOT NULL,
    [DeclarationGUID]             VARCHAR (50) NOT NULL,
    [PeriodicDeclarationDataGUID] VARCHAR (50) NOT NULL,
    [SimpDeclarationGUID]         VARCHAR (50) NOT NULL,
    [DeclarationDataGUID]         VARCHAR (50) NOT NULL,
    [DeletedFlag]                 VARCHAR (1)  NOT NULL,
    [KeepDuringRollback]          VARCHAR (1)  NOT NULL,
    CONSTRAINT [PK_txdDEImpSupplementaryData_DeclarationData] PRIMARY KEY NONCLUSTERED ([PartnerID] ASC, [DeclarationGUID] ASC, [PeriodicDeclarationDataGUID] ASC, [SimpDeclarationGUID] ASC, [DeclarationDataGUID] ASC) WITH (FILLFACTOR = 90)
);
END


GO
PRINT N'Creating [dbo].[txdDEImpSupplementaryData_DeclarationData].[CIX_txdDEImpSupplementaryData_DeclarationData]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_txdDEImpSupplementaryData_DeclarationData' AND object_id = object_id('txdDEImpSupplementaryData_DeclarationData'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_txdDEImpSupplementaryData_DeclarationData]
    ON [dbo].[txdDEImpSupplementaryData_DeclarationData]([EffDate] ASC);
END


GO
PRINT N'Creating [dbo].[txdDEImpSupplementaryData_DeclarationData].[UIX_txdDEImpSupplementaryData_DeclarationData_1]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='UIX_txdDEImpSupplementaryData_DeclarationData_1' AND object_id = object_id('txdDEImpSupplementaryData_DeclarationData'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE UNIQUE NONCLUSTERED INDEX [UIX_txdDEImpSupplementaryData_DeclarationData_1]
    ON [dbo].[txdDEImpSupplementaryData_DeclarationData]([PeriodicDeclarationDataGUID] ASC, [DeclarationDataGUID] ASC);
END


GO
PRINT N'Creating [dbo].[txdDEImpSupplementaryValidationWarning]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdDEImpSupplementaryValidationWarning' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[txdDEImpSupplementaryValidationWarning] (
    [PartnerID]                         INT            NOT NULL,
    [EffDate]                           DATETIME       NOT NULL,
    [DeclarationGUID]                   VARCHAR (50)   NOT NULL,
    [SupplementaryDeclarationDataGUID]  VARCHAR (50)   NOT NULL,
    [WarningGUID]                       VARCHAR (50)   NOT NULL,
    [SimplifiedMovementReferenceNumber] VARCHAR (35)   NOT NULL,
    [Location]                          VARCHAR (1000) NOT NULL,
    [Warning]                           VARCHAR (2000) NOT NULL,
    [DeletedFlag]                       VARCHAR (1)    NOT NULL,
    [KeepDuringRollback]                VARCHAR (1)    NOT NULL,
    CONSTRAINT [PK_txdDEImpSupplementaryValidationWarning] PRIMARY KEY NONCLUSTERED ([PartnerID] ASC, [DeclarationGUID] ASC, [SupplementaryDeclarationDataGUID] ASC, [WarningGUID] ASC) WITH (FILLFACTOR = 90)
);
END


GO
PRINT N'Creating [dbo].[txdDEImpSupplementaryValidationWarning].[CIX_txdDEImpSupplementaryValidationWarning]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_txdDEImpSupplementaryValidationWarning' AND object_id = object_id('txdDEImpSupplementaryValidationWarning'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_txdDEImpSupplementaryValidationWarning]
    ON [dbo].[txdDEImpSupplementaryValidationWarning]([EffDate] ASC);
END


GO
PRINT N'Creating [dbo].[txdDEImpSupplementaryValidationWarning].[IX_txdDEImpSupplementaryValidationWarning_PKC]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='IX_txdDEImpSupplementaryValidationWarning_PKC' AND object_id = object_id('txdDEImpSupplementaryValidationWarning'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE NONCLUSTERED INDEX [IX_txdDEImpSupplementaryValidationWarning_PKC]
    ON [dbo].[txdDEImpSupplementaryValidationWarning]([PartnerID] ASC, [DeclarationGUID] ASC, [SupplementaryDeclarationDataGUID] ASC, [WarningGUID] ASC)
    INCLUDE([EffDate], [Location], [SimplifiedMovementReferenceNumber], [Warning]);
END


GO
PRINT N'Creating [dbo].[txdDEImpSupplementaryValidationWarning].[IX_txdDEImpSupplementaryValidationWarning_1]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='IX_txdDEImpSupplementaryValidationWarning_1' AND object_id = object_id('txdDEImpSupplementaryValidationWarning'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE NONCLUSTERED INDEX [IX_txdDEImpSupplementaryValidationWarning_1]
    ON [dbo].[txdDEImpSupplementaryValidationWarning]([PartnerID] ASC, [SupplementaryDeclarationDataGUID] ASC)
    INCLUDE([Warning]);
END


GO
PRINT N'Creating [dbo].[txdDTSSearchLog]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdDTSSearchLog' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[txdDTSSearchLog] (
    [PartnerId]              INT              NOT NULL,
    [EffDate]                DATETIME         NOT NULL,
    [ProcessID]              VARCHAR (50)     NOT NULL,
    [BatchGuid]              UNIQUEIDENTIFIER NOT NULL,
    [RequestProcessID]       VARCHAR (50)     NOT NULL,
    [DTSLastValidatedDate]   DATETIME         NOT NULL,
    [DTSOverrideDate]        DATETIME         NOT NULL,
    [DTSSearchFlag]          VARCHAR (1)      NOT NULL,
    [DTSOverride]            VARCHAR (1)      NOT NULL,
    [EntityID]               TEXT             NOT NULL,
    [Name]                   TEXT             NOT NULL,
    [Address]                TEXT             NOT NULL,
    [City]                   TEXT             NOT NULL,
    [CountryCode]            TEXT             NOT NULL,
    [StateCode]              VARCHAR (50)     NOT NULL,
    [PostalCode]             VARCHAR (20)     NOT NULL,
    [SearchNameOption]       TEXT             NOT NULL,
    [SearchAddressOption]    TEXT             NOT NULL,
    [SearchSoundsLikeOption] TEXT             NOT NULL,
    [RegGroupIDList]         TEXT             NOT NULL,
    [Emails]                 TEXT             NOT NULL,
    [TotalSearched]          NUMERIC (38, 20) NOT NULL,
    [TotalHits]              NUMERIC (38, 20) NOT NULL,
    [TotalErrors]            NUMERIC (38, 20) NOT NULL,
    [DeletedFlag]            VARCHAR (1)      NOT NULL,
    [KeepDuringRollback]     VARCHAR (1)      NOT NULL
);
END


GO
PRINT N'Creating [dbo].[txdDTSSearchLog].[CIX_txdDTSSearchLog]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_txdDTSSearchLog' AND object_id = object_id('txdDTSSearchLog'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_txdDTSSearchLog]
    ON [dbo].[txdDTSSearchLog]([EffDate] ASC);
END


GO
PRINT N'Creating [dbo].[txdDTSSearchLog].[IX_txdDTSSearchLog_1]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='IX_txdDTSSearchLog_1' AND object_id = object_id('txdDTSSearchLog'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE NONCLUSTERED INDEX [IX_txdDTSSearchLog_1]
    ON [dbo].[txdDTSSearchLog]([PartnerId] ASC, [BatchGuid] ASC) WITH (FILLFACTOR = 100);
END


GO
PRINT N'Creating [dbo].[txdMXRecordEditLog]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdMXRecordEditLog' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[txdMXRecordEditLog] (
    [PartnerID]          INT           NOT NULL,
    [EffDate]            DATETIME      NOT NULL,
    [LogGUID]            BIGINT        IDENTITY (1, 1) NOT NULL,
    [UserName]           VARCHAR (50)  NOT NULL,
    [FifoGuid]           VARCHAR (50)  NOT NULL,
    [TableName]          VARCHAR (50)  NOT NULL,
    [FieldName]          VARCHAR (50)  NOT NULL,
    [CurrentValue]       VARCHAR (250) NOT NULL,
    [NewValue]           VARCHAR (250) NOT NULL,
    [EmailsSentTo]       VARCHAR (MAX) NOT NULL,
    [EmailSentDate]      DATETIME      NOT NULL,
    [DeletedFlag]        VARCHAR (1)   NOT NULL,
    [KeepDuringRollback] VARCHAR (1)   NOT NULL,
    CONSTRAINT [PK_txdMXRecordEditLog] PRIMARY KEY NONCLUSTERED ([PartnerID] ASC, [LogGUID] ASC)
);
END


GO
PRINT N'Creating [dbo].[txdMXRecordEditLog].[CIX_txdMXRecordEditLog]...';


GO



IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_txdMXRecordEditLog' AND object_id = object_id('txdMXRecordEditLog'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
	if not exists (SELECT top 1 1 FROM sys.indexes i WHERE i.object_id = object_id('txdMXRecordEditLog') and i.type_desc = 'CLUSTERED')
	BEGIN
		CREATE CLUSTERED INDEX [CIX_txdMXRecordEditLog]
			ON [dbo].[txdMXRecordEditLog]([EffDate] ASC) WITH (FILLFACTOR = 100);
	END
END


GO
PRINT N'Creating [dbo].[txdNLGoodsItemClassification]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdNLGoodsItemClassification' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[txdNLGoodsItemClassification] (
    [PartnerID]           INT          NOT NULL,
    [EffDate]             DATETIME     NOT NULL,
    [DeclarationGUID]     VARCHAR (50) NOT NULL,
    [DeclarationDataGUID] VARCHAR (50) NOT NULL,
    [GoodsShipmentGUID]   VARCHAR (50) NOT NULL,
    [GoodsItemGUID]       VARCHAR (50) NOT NULL,
    [ClassificationGUID]  VARCHAR (50) NOT NULL,
    [SequenceNum]         INT          NOT NULL,
    [Type]                VARCHAR (3)  NOT NULL,
    [Code]                VARCHAR (18) NOT NULL,
    [DeletedFlag]         VARCHAR (1)  NOT NULL,
    [KeepDuringRollback]  VARCHAR (1)  NOT NULL,
    CONSTRAINT [PK_txdNLGoodsItemClassification] PRIMARY KEY NONCLUSTERED ([PartnerID] ASC, [DeclarationGUID] ASC, [DeclarationDataGUID] ASC, [GoodsShipmentGUID] ASC, [GoodsItemGUID] ASC, [ClassificationGUID] ASC) WITH (FILLFACTOR = 90)
);
END


GO
PRINT N'Creating [dbo].[txdNLGoodsShipmentItinerary]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdNLGoodsShipmentItinerary' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[txdNLGoodsShipmentItinerary] (
    [PartnerID]           INT          NOT NULL,
    [EffDate]             DATETIME     NOT NULL,
    [DeclarationGUID]     VARCHAR (50) NOT NULL,
    [DeclarationDataGUID] VARCHAR (50) NOT NULL,
    [GoodsShipmentGUID]   VARCHAR (50) NOT NULL,
    [ItineraryGUID]       VARCHAR (50) NOT NULL,
    [SequenceNum]         INT          NOT NULL,
    [Country]             VARCHAR (2)  NOT NULL,
    [DeletedFlag]         VARCHAR (1)  NOT NULL,
    [KeepDuringRollback]  VARCHAR (1)  NOT NULL,
    CONSTRAINT [PK_txdNLGoodsShipmentItinerary] PRIMARY KEY NONCLUSTERED ([PartnerID] ASC, [DeclarationGUID] ASC, [DeclarationDataGUID] ASC, [GoodsShipmentGUID] ASC, [ItineraryGUID] ASC) WITH (FILLFACTOR = 90)
);
END


GO
PRINT N'Creating [dbo].[txdNLGoodsShipmentItinerary].[CIX_txdNLGoodsShipmentItinerary]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_txdNLGoodsShipmentItinerary' AND object_id = object_id('txdNLGoodsShipmentItinerary'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_txdNLGoodsShipmentItinerary]
    ON [dbo].[txdNLGoodsShipmentItinerary]([EffDate] ASC);
END


GO
PRINT N'Creating [dbo].[txdNLNCTSDeclaration]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdNLNCTSDeclaration' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[txdNLNCTSDeclaration] (
    [PartnerID]          INT           NOT NULL,
    [EffDate]            DATETIME      NOT NULL,
    [DeclarationGUID]    VARCHAR (50)  NOT NULL,
    [LRN]                VARCHAR (22)  NOT NULL,
    [MRN]                VARCHAR (21)  NOT NULL,
    [Description]        VARCHAR (512) NOT NULL,
    [CustomsType]        VARCHAR (10)  NOT NULL,
    [RecordType]         VARCHAR (10)  NOT NULL,
    [DeletedFlag]        VARCHAR (1)   NOT NULL,
    [KeepDuringRollback] VARCHAR (1)   NOT NULL,
    CONSTRAINT [PK_txdNLNCTSDeclaration] PRIMARY KEY NONCLUSTERED ([PartnerID] ASC, [DeclarationGUID] ASC)
);
END


GO
PRINT N'Creating [dbo].[txdNLNCTSDeclaration].[CIX_txdNLNCTSDeclaration]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_txdNLNCTSDeclaration' AND object_id = object_id('txdNLNCTSDeclaration'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_txdNLNCTSDeclaration]
    ON [dbo].[txdNLNCTSDeclaration]([EffDate] ASC);
END


GO
PRINT N'Creating [dbo].[txdNLNCTSEDIFACTError]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdNLNCTSEDIFACTError' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[txdNLNCTSEDIFACTError] (
    [PartnerID]                   INT            NOT NULL,
    [EffDate]                     DATETIME       NOT NULL,
    [DeclarationGUID]             VARCHAR (50)   NOT NULL,
    [HeaderGUID]                  VARCHAR (50)   NOT NULL,
    [ErrorGUID]                   VARCHAR (50)   NOT NULL,
    [SequenceNum]                 INT            NOT NULL,
    [InterchangeControlReference] VARCHAR (14)   NOT NULL,
    [Sender]                      VARCHAR (35)   NOT NULL,
    [Recipient]                   VARCHAR (35)   NOT NULL,
    [ActionTakenByRecipient]      VARCHAR (3)    NOT NULL,
    [SyntaxError]                 VARCHAR (3)    NOT NULL,
    [InterchangeServiceSegment]   VARCHAR (3)    NOT NULL,
    [ElementPosition]             VARCHAR (3)    NOT NULL,
    [ComponentPosition]           VARCHAR (3)    NOT NULL,
    [RestOfSegments]              VARCHAR (8000) NOT NULL,
    [DeletedFlag]                 VARCHAR (1)    NOT NULL,
    [KeepDuringRollback]          VARCHAR (1)    NOT NULL,
    CONSTRAINT [PK_txdNLNCTSEDIFACTError] PRIMARY KEY NONCLUSTERED ([PartnerID] ASC, [DeclarationGUID] ASC, [HeaderGUID] ASC, [ErrorGUID] ASC)
);
END


GO
PRINT N'Creating [dbo].[txdNLNCTSEDIFACTError].[CIX_txdNLNCTSEDIFACTError]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_txdNLNCTSEDIFACTError' AND object_id = object_id('txdNLNCTSEDIFACTError'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_txdNLNCTSEDIFACTError]
    ON [dbo].[txdNLNCTSEDIFACTError]([EffDate] ASC);
END


GO
PRINT N'Creating [dbo].[txdNLNCTSEnRouteEvent]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdNLNCTSEnRouteEvent' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[txdNLNCTSEnRouteEvent] (
    [PartnerID]                            INT           NOT NULL,
    [EffDate]                              DATETIME      NOT NULL,
    [DeclarationGUID]                      VARCHAR (50)  NOT NULL,
    [HeaderGUID]                           VARCHAR (50)  NOT NULL,
    [EnRouteGUID]                          VARCHAR (50)  NOT NULL,
    [SequenceNum]                          INT           NOT NULL,
    [Place]                                VARCHAR (35)  NOT NULL,
    [PlaceLng]                             VARCHAR (2)   NOT NULL,
    [CountryCode]                          VARCHAR (2)   NOT NULL,
    [AlreadyInNCTS]                        VARCHAR (1)   NOT NULL,
    [IncidentFlag]                         VARCHAR (1)   NOT NULL,
    [IncidentInformation]                  VARCHAR (350) NOT NULL,
    [IncidentInformationLng]               VARCHAR (2)   NOT NULL,
    [IncidentEndorsementDate]              DATETIME      NOT NULL,
    [IncidentEndorsementAuthority]         VARCHAR (35)  NOT NULL,
    [IncidentEndorsementAuthorityLng]      VARCHAR (2)   NOT NULL,
    [IncidentEndorsementPlace]             VARCHAR (35)  NOT NULL,
    [IncidentEndorsementPlaceLng]          VARCHAR (2)   NOT NULL,
    [IncidentEndorsementCountry]           VARCHAR (2)   NOT NULL,
    [SealsNumber]                          INT           NOT NULL,
    [NewTransportMeansIdentity]            VARCHAR (27)  NOT NULL,
    [NewTransportMeansIdentityLng]         VARCHAR (2)   NOT NULL,
    [NewTransportMeansNationality]         VARCHAR (2)   NOT NULL,
    [TransshipmentEndorsementDate]         DATETIME      NOT NULL,
    [TransshipmentEndorsementAuthority]    VARCHAR (35)  NOT NULL,
    [TransshipmentEndorsementAuthorityLng] VARCHAR (2)   NOT NULL,
    [TransshipmentEndorsementPlace]        VARCHAR (35)  NOT NULL,
    [TransshipmentEndorsementPlaceLng]     VARCHAR (2)   NOT NULL,
    [TransshipmentEndorsementCountry]      VARCHAR (2)   NOT NULL,
    [DeletedFlag]                          VARCHAR (1)   NOT NULL,
    [KeepDuringRollback]                   VARCHAR (1)   NOT NULL,
    CONSTRAINT [PK_txdNLNCTSEnRouteEvent] PRIMARY KEY NONCLUSTERED ([PartnerID] ASC, [DeclarationGUID] ASC, [HeaderGUID] ASC, [EnRouteGUID] ASC)
);
END


GO
PRINT N'Creating [dbo].[txdNLNCTSEnRouteEvent].[CIX_txdNLNCTSEnRouteEvent]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_txdNLNCTSEnRouteEvent' AND object_id = object_id('txdNLNCTSEnRouteEvent'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_txdNLNCTSEnRouteEvent]
    ON [dbo].[txdNLNCTSEnRouteEvent]([EffDate] ASC);
END


GO
PRINT N'Creating [dbo].[txdNLNCTSEnRouteEventContainer]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdNLNCTSEnRouteEventContainer' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[txdNLNCTSEnRouteEventContainer] (
    [PartnerID]          INT          NOT NULL,
    [EffDate]            DATETIME     NOT NULL,
    [DeclarationGUID]    VARCHAR (50) NOT NULL,
    [HeaderGUID]         VARCHAR (50) NOT NULL,
    [EnRouteGUID]        VARCHAR (50) NOT NULL,
    [ContainerGUID]      VARCHAR (50) NOT NULL,
    [SequenceNum]        INT          NOT NULL,
    [ContainerNumber]    VARCHAR (17) NOT NULL,
    [DeletedFlag]        VARCHAR (1)  NOT NULL,
    [KeepDuringRollback] VARCHAR (1)  NOT NULL,
    CONSTRAINT [PK_txdNLNCTSEnRouteEventContainer] PRIMARY KEY NONCLUSTERED ([PartnerID] ASC, [DeclarationGUID] ASC, [HeaderGUID] ASC, [EnRouteGUID] ASC, [ContainerGUID] ASC)
);
END


GO
PRINT N'Creating [dbo].[txdNLNCTSEnRouteEventContainer].[CIX_txdNLNCTSEnRouteEventContainer]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_txdNLNCTSEnRouteEventContainer' AND object_id = object_id('txdNLNCTSEnRouteEventContainer'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_txdNLNCTSEnRouteEventContainer]
    ON [dbo].[txdNLNCTSEnRouteEventContainer]([EffDate] ASC);
END


GO
PRINT N'Creating [dbo].[txdNLNCTSEnRouteEventSeal]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdNLNCTSEnRouteEventSeal' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[txdNLNCTSEnRouteEventSeal] (
    [PartnerID]          INT          NOT NULL,
    [EffDate]            DATETIME     NOT NULL,
    [DeclarationGUID]    VARCHAR (50) NOT NULL,
    [HeaderGUID]         VARCHAR (50) NOT NULL,
    [EnRouteGUID]        VARCHAR (50) NOT NULL,
    [SealGUID]           VARCHAR (50) NOT NULL,
    [SequenceNum]        INT          NOT NULL,
    [SealsIdentity]      VARCHAR (20) NOT NULL,
    [SealsIdentityLng]   VARCHAR (2)  NOT NULL,
    [DeletedFlag]        VARCHAR (1)  NOT NULL,
    [KeepDuringRollback] VARCHAR (1)  NOT NULL,
    CONSTRAINT [PK_txdNLNCTSEnRouteEventSeal] PRIMARY KEY NONCLUSTERED ([PartnerID] ASC, [DeclarationGUID] ASC, [HeaderGUID] ASC, [EnRouteGUID] ASC, [SealGUID] ASC)
);
END


GO
PRINT N'Creating [dbo].[txdNLNCTSEnRouteEventSeal].[CIX_txdNLNCTSEnRouteEventSeal]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_txdNLNCTSEnRouteEventSeal' AND object_id = object_id('txdNLNCTSEnRouteEventSeal'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_txdNLNCTSEnRouteEventSeal]
    ON [dbo].[txdNLNCTSEnRouteEventSeal]([EffDate] ASC);
END


GO
PRINT N'Creating [dbo].[txdNLNCTSError]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdNLNCTSError' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[txdNLNCTSError] (
    [PartnerID]              INT           NOT NULL,
    [EffDate]                DATETIME      NOT NULL,
    [DeclarationGUID]        VARCHAR (50)  NOT NULL,
    [HeaderGUID]             VARCHAR (50)  NOT NULL,
    [ErrorGUID]              VARCHAR (50)  NOT NULL,
    [SequenceNum]            INT           NOT NULL,
    [Type]                   VARCHAR (2)   NOT NULL,
    [Pointer]                VARCHAR (210) NOT NULL,
    [Reason]                 VARCHAR (6)   NOT NULL,
    [OriginalAttributeValue] VARCHAR (140) NOT NULL,
    [DeletedFlag]            VARCHAR (1)   NOT NULL,
    [KeepDuringRollback]     VARCHAR (1)   NOT NULL,
    CONSTRAINT [PK_txdNLNCTSError] PRIMARY KEY NONCLUSTERED ([PartnerID] ASC, [DeclarationGUID] ASC, [HeaderGUID] ASC, [ErrorGUID] ASC)
);
END


GO
PRINT N'Creating [dbo].[txdNLNCTSError].[CIX_txdNLNCTSError]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_txdNLNCTSError' AND object_id = object_id('txdNLNCTSError'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_txdNLNCTSError]
    ON [dbo].[txdNLNCTSError]([EffDate] ASC);
END


GO
PRINT N'Creating [dbo].[txdNLNCTSGoodsItem]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdNLNCTSGoodsItem' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[txdNLNCTSGoodsItem] (
    [PartnerID]                        INT           NOT NULL,
    [EffDate]                          DATETIME      NOT NULL,
    [DeclarationGUID]                  VARCHAR (50)  NOT NULL,
    [HeaderGUID]                       VARCHAR (50)  NOT NULL,
    [GoodsItemGUID]                    VARCHAR (50)  NOT NULL,
    [SequenceNum]                      INT           NOT NULL,
    [ItemNumber]                       INT           NOT NULL,
    [CommodityCode]                    VARCHAR (22)  NOT NULL,
    [TypeOfDeclaration]                VARCHAR (9)   NOT NULL,
    [GoodsDescription]                 VARCHAR (280) NOT NULL,
    [GoodsDescriptionLng]              VARCHAR (2)   NOT NULL,
    [GrossMass]                        NUMERIC (18)  NOT NULL,
    [NetMass]                          NUMERIC (18)  NOT NULL,
    [CountryOfDispatchExport]          VARCHAR (2)   NOT NULL,
    [CountryOfDestination]             VARCHAR (2)   NOT NULL,
    [TransportChargesMethodOfPayment]  VARCHAR (1)   NOT NULL,
    [CommercialReferenceNumber]        VARCHAR (70)  NOT NULL,
    [UNDangerousGoodsCode]             VARCHAR (4)   NOT NULL,
    [ConsignorName]                    VARCHAR (35)  NOT NULL,
    [ConsignorStreetAndNumber]         VARCHAR (35)  NOT NULL,
    [ConsignorPostalCode]              VARCHAR (9)   NOT NULL,
    [ConsignorCity]                    VARCHAR (35)  NOT NULL,
    [ConsignorCountryCode]             VARCHAR (2)   NOT NULL,
    [ConsignorNadLng]                  VARCHAR (2)   NOT NULL,
    [ConsignorTin]                     VARCHAR (17)  NOT NULL,
    [ConsigneeName]                    VARCHAR (35)  NOT NULL,
    [ConsigneeStreetAndNumber]         VARCHAR (35)  NOT NULL,
    [ConsigneePostalCode]              VARCHAR (9)   NOT NULL,
    [ConsigneeCity]                    VARCHAR (35)  NOT NULL,
    [ConsigneeCountryCode]             VARCHAR (2)   NOT NULL,
    [ConsigneeNadLng]                  VARCHAR (2)   NOT NULL,
    [ConsigneeTin]                     VARCHAR (17)  NOT NULL,
    [SecurityConsignorName]            VARCHAR (35)  NOT NULL,
    [SecurityConsignorStreetAndNumber] VARCHAR (35)  NOT NULL,
    [SecurityConsignorPostalCode]      VARCHAR (9)   NOT NULL,
    [SecurityConsignorCity]            VARCHAR (35)  NOT NULL,
    [SecurityConsignorCountryCode]     VARCHAR (2)   NOT NULL,
    [SecurityConsignorNadLng]          VARCHAR (2)   NOT NULL,
    [SecurityConsignorTin]             VARCHAR (17)  NOT NULL,
    [SecurityConsigneeName]            VARCHAR (35)  NOT NULL,
    [SecurityConsigneeStreetAndNumber] VARCHAR (35)  NOT NULL,
    [SecurityConsigneePostalCode]      VARCHAR (9)   NOT NULL,
    [SecurityConsigneeCity]            VARCHAR (35)  NOT NULL,
    [SecurityConsigneeCountryCode]     VARCHAR (2)   NOT NULL,
    [SecurityConsigneeNadLng]          VARCHAR (2)   NOT NULL,
    [SecurityConsigneeTin]             VARCHAR (17)  NOT NULL,
    [DeletedFlag]                      VARCHAR (1)   NOT NULL,
    [KeepDuringRollback]               VARCHAR (1)   NOT NULL,
    CONSTRAINT [PK_txdNLNCTSGoodsItem] PRIMARY KEY NONCLUSTERED ([PartnerID] ASC, [DeclarationGUID] ASC, [HeaderGUID] ASC, [GoodsItemGUID] ASC)
);
END


GO
PRINT N'Creating [dbo].[txdNLNCTSGoodsItem].[CIX_txdNLNCTSGoodsItem]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_txdNLNCTSGoodsItem' AND object_id = object_id('txdNLNCTSGoodsItem'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_txdNLNCTSGoodsItem]
    ON [dbo].[txdNLNCTSGoodsItem]([EffDate] ASC);
END


GO
PRINT N'Creating [dbo].[txdNLNCTSGoodsItemContainer]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdNLNCTSGoodsItemContainer' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[txdNLNCTSGoodsItemContainer] (
    [PartnerID]          INT          NOT NULL,
    [EffDate]            DATETIME     NOT NULL,
    [DeclarationGUID]    VARCHAR (50) NOT NULL,
    [HeaderGUID]         VARCHAR (50) NOT NULL,
    [GoodsItemGUID]      VARCHAR (50) NOT NULL,
    [ContainerGUID]      VARCHAR (50) NOT NULL,
    [SequenceNum]        INT          NOT NULL,
    [Number]             VARCHAR (17) NOT NULL,
    [DeletedFlag]        VARCHAR (1)  NOT NULL,
    [KeepDuringRollback] VARCHAR (1)  NOT NULL,
    CONSTRAINT [PK_txdNLNCTSGoodsItemContainer] PRIMARY KEY NONCLUSTERED ([PartnerID] ASC, [DeclarationGUID] ASC, [HeaderGUID] ASC, [GoodsItemGUID] ASC, [ContainerGUID] ASC)
);
END


GO
PRINT N'Creating [dbo].[txdNLNCTSGoodsItemContainer].[CIX_txdNLNCTSGoodsItemContainer]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_txdNLNCTSGoodsItemContainer' AND object_id = object_id('txdNLNCTSGoodsItemContainer'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_txdNLNCTSGoodsItemContainer]
    ON [dbo].[txdNLNCTSGoodsItemContainer]([EffDate] ASC);
END


GO
PRINT N'Creating [dbo].[txdNLNCTSGoodsItemDocument]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdNLNCTSGoodsItemDocument' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[txdNLNCTSGoodsItemDocument] (
    [PartnerID]                  INT          NOT NULL,
    [EffDate]                    DATETIME     NOT NULL,
    [DeclarationGUID]            VARCHAR (50) NOT NULL,
    [HeaderGUID]                 VARCHAR (50) NOT NULL,
    [GoodsItemGUID]              VARCHAR (50) NOT NULL,
    [DocumentGUID]               VARCHAR (50) NOT NULL,
    [SequenceNum]                INT          NOT NULL,
    [Type]                       VARCHAR (4)  NOT NULL,
    [Reference]                  VARCHAR (35) NOT NULL,
    [ReferenceLng]               VARCHAR (2)  NOT NULL,
    [ComplementOfInformation]    VARCHAR (26) NOT NULL,
    [ComplementOfInformationLng] VARCHAR (2)  NOT NULL,
    [DeletedFlag]                VARCHAR (1)  NOT NULL,
    [KeepDuringRollback]         VARCHAR (1)  NOT NULL,
    CONSTRAINT [PK_txdNLNCTSGoodsItemDocument] PRIMARY KEY NONCLUSTERED ([PartnerID] ASC, [DeclarationGUID] ASC, [HeaderGUID] ASC, [GoodsItemGUID] ASC, [DocumentGUID] ASC)
);
END


GO
PRINT N'Creating [dbo].[txdNLNCTSGoodsItemDocument].[CIX_txdNLNCTSGoodsItemDocument]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_txdNLNCTSGoodsItemDocument' AND object_id = object_id('txdNLNCTSGoodsItemDocument'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_txdNLNCTSGoodsItemDocument]
    ON [dbo].[txdNLNCTSGoodsItemDocument]([EffDate] ASC);
END


GO
PRINT N'Creating [dbo].[txdNLNCTSGoodsItemPackage]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdNLNCTSGoodsItemPackage' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[txdNLNCTSGoodsItemPackage] (
    [PartnerID]          INT          NOT NULL,
    [EffDate]            DATETIME     NOT NULL,
    [DeclarationGUID]    VARCHAR (50) NOT NULL,
    [HeaderGUID]         VARCHAR (50) NOT NULL,
    [GoodsItemGUID]      VARCHAR (50) NOT NULL,
    [PackageGUID]        VARCHAR (50) NOT NULL,
    [SequenceNum]        INT          NOT NULL,
    [MarksAndNumbers]    VARCHAR (42) NOT NULL,
    [MarksAndNumbersLng] VARCHAR (2)  NOT NULL,
    [Kind]               VARCHAR (3)  NOT NULL,
    [Number]             INT          NOT NULL,
    [NumberOfPieces]     INT          NOT NULL,
    [DeletedFlag]        VARCHAR (1)  NOT NULL,
    [KeepDuringRollback] VARCHAR (1)  NOT NULL,
    CONSTRAINT [PK_txdNLNCTSGoodsItemPackage] PRIMARY KEY NONCLUSTERED ([PartnerID] ASC, [DeclarationGUID] ASC, [HeaderGUID] ASC, [GoodsItemGUID] ASC, [PackageGUID] ASC)
);
END


GO
PRINT N'Creating [dbo].[txdNLNCTSGoodsItemPackage].[CIX_txdNLNCTSGoodsItemPackage]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_txdNLNCTSGoodsItemPackage' AND object_id = object_id('txdNLNCTSGoodsItemPackage'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_txdNLNCTSGoodsItemPackage]
    ON [dbo].[txdNLNCTSGoodsItemPackage]([EffDate] ASC);
END


GO
PRINT N'Creating [dbo].[txdNLNCTSGoodsItemPreviousDocument]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdNLNCTSGoodsItemPreviousDocument' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[txdNLNCTSGoodsItemPreviousDocument] (
    [PartnerID]                  INT          NOT NULL,
    [EffDate]                    DATETIME     NOT NULL,
    [DeclarationGUID]            VARCHAR (50) NOT NULL,
    [HeaderGUID]                 VARCHAR (50) NOT NULL,
    [GoodsItemGUID]              VARCHAR (50) NOT NULL,
    [PreviousDocumentGUID]       VARCHAR (50) NOT NULL,
    [SequenceNum]                INT          NOT NULL,
    [Type]                       VARCHAR (6)  NOT NULL,
    [Reference]                  VARCHAR (35) NOT NULL,
    [ReferenceLng]               VARCHAR (2)  NOT NULL,
    [ComplementOfInformation]    VARCHAR (26) NOT NULL,
    [ComplementOfInformationLng] VARCHAR (2)  NOT NULL,
    [DeletedFlag]                VARCHAR (1)  NOT NULL,
    [KeepDuringRollback]         VARCHAR (1)  NOT NULL,
    CONSTRAINT [PK_txdNLNCTSGoodsItemPreviousDocument] PRIMARY KEY NONCLUSTERED ([PartnerID] ASC, [DeclarationGUID] ASC, [HeaderGUID] ASC, [GoodsItemGUID] ASC, [PreviousDocumentGUID] ASC)
);
END


GO
PRINT N'Creating [dbo].[txdNLNCTSGoodsItemPreviousDocument].[CIX_txdNLNCTSGoodsItemPreviousDocument]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_txdNLNCTSGoodsItemPreviousDocument' AND object_id = object_id('txdNLNCTSGoodsItemPreviousDocument'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_txdNLNCTSGoodsItemPreviousDocument]
    ON [dbo].[txdNLNCTSGoodsItemPreviousDocument]([EffDate] ASC);
END


GO
PRINT N'Creating [dbo].[txdNLNCTSGoodsItemResultOfControl]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdNLNCTSGoodsItemResultOfControl' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[txdNLNCTSGoodsItemResultOfControl] (
    [PartnerID]             INT           NOT NULL,
    [EffDate]               DATETIME      NOT NULL,
    [DeclarationGUID]       VARCHAR (50)  NOT NULL,
    [HeaderGUID]            VARCHAR (50)  NOT NULL,
    [GoodsItemGUID]         VARCHAR (50)  NOT NULL,
    [ResultGUID]            VARCHAR (50)  NOT NULL,
    [SequenceNum]           INT           NOT NULL,
    [Description]           VARCHAR (140) NOT NULL,
    [DescriptionLng]        VARCHAR (2)   NOT NULL,
    [ControlIndicator]      VARCHAR (2)   NOT NULL,
    [PointerToTheAttribute] VARCHAR (35)  NOT NULL,
    [DeletedFlag]           VARCHAR (1)   NOT NULL,
    [KeepDuringRollback]    VARCHAR (1)   NOT NULL,
    CONSTRAINT [PK_txdNLNCTSGoodsItemResultOfControl] PRIMARY KEY NONCLUSTERED ([PartnerID] ASC, [DeclarationGUID] ASC, [HeaderGUID] ASC, [GoodsItemGUID] ASC, [ResultGUID] ASC)
);
END


GO
PRINT N'Creating [dbo].[txdNLNCTSGoodsItemResultOfControl].[CIX_txdNLNCTSGoodsItemResultOfControl]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_txdNLNCTSGoodsItemResultOfControl' AND object_id = object_id('txdNLNCTSGoodsItemResultOfControl'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_txdNLNCTSGoodsItemResultOfControl]
    ON [dbo].[txdNLNCTSGoodsItemResultOfControl]([EffDate] ASC);
END


GO
PRINT N'Creating [dbo].[txdNLNCTSGoodsItemSGICode]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdNLNCTSGoodsItemSGICode' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[txdNLNCTSGoodsItemSGICode] (
    [PartnerID]          INT          NOT NULL,
    [EffDate]            DATETIME     NOT NULL,
    [DeclarationGUID]    VARCHAR (50) NOT NULL,
    [HeaderGUID]         VARCHAR (50) NOT NULL,
    [GoodsItemGUID]      VARCHAR (50) NOT NULL,
    [SGICodeGUID]        VARCHAR (50) NOT NULL,
    [SequenceNum]        INT          NOT NULL,
    [Code]               VARCHAR (2)  NOT NULL,
    [Quantity]           NUMERIC (18) NOT NULL,
    [DeletedFlag]        VARCHAR (1)  NOT NULL,
    [KeepDuringRollback] VARCHAR (1)  NOT NULL,
    CONSTRAINT [PK_txdNLNCTSGoodsItemSGICode] PRIMARY KEY NONCLUSTERED ([PartnerID] ASC, [DeclarationGUID] ASC, [HeaderGUID] ASC, [GoodsItemGUID] ASC, [SGICodeGUID] ASC)
);
END


GO
PRINT N'Creating [dbo].[txdNLNCTSGoodsItemSGICode].[CIX_txdNLNCTSGoodsItemSGICode]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_txdNLNCTSGoodsItemSGICode' AND object_id = object_id('txdNLNCTSGoodsItemSGICode'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_txdNLNCTSGoodsItemSGICode]
    ON [dbo].[txdNLNCTSGoodsItemSGICode]([EffDate] ASC);
END


GO
PRINT N'Creating [dbo].[txdNLNCTSGoodsItemSpecialMention]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdNLNCTSGoodsItemSpecialMention' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[txdNLNCTSGoodsItemSpecialMention] (
    [PartnerID]          INT          NOT NULL,
    [EffDate]            DATETIME     NOT NULL,
    [DeclarationGUID]    VARCHAR (50) NOT NULL,
    [HeaderGUID]         VARCHAR (50) NOT NULL,
    [GoodsItemGUID]      VARCHAR (50) NOT NULL,
    [SpecialMentionGUID] VARCHAR (50) NOT NULL,
    [SequenceNum]        INT          NOT NULL,
    [Information]        VARCHAR (70) NOT NULL,
    [InformationLng]     VARCHAR (2)  NOT NULL,
    [Code]               VARCHAR (5)  NOT NULL,
    [ExportFromEC]       VARCHAR (1)  NOT NULL,
    [ExportFromCountry]  VARCHAR (2)  NOT NULL,
    [DeletedFlag]        VARCHAR (1)  NOT NULL,
    [KeepDuringRollback] VARCHAR (1)  NOT NULL,
    CONSTRAINT [PK_txdNLNCTSGoodsItemSpecialMention] PRIMARY KEY NONCLUSTERED ([PartnerID] ASC, [DeclarationGUID] ASC, [HeaderGUID] ASC, [GoodsItemGUID] ASC, [SpecialMentionGUID] ASC)
);
END


GO
PRINT N'Creating [dbo].[txdNLNCTSGoodsItemSpecialMention].[CIX_txdNLNCTSGoodsItemSpecialMention]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_txdNLNCTSGoodsItemSpecialMention' AND object_id = object_id('txdNLNCTSGoodsItemSpecialMention'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_txdNLNCTSGoodsItemSpecialMention]
    ON [dbo].[txdNLNCTSGoodsItemSpecialMention]([EffDate] ASC);
END


GO
PRINT N'Creating [dbo].[txdNLNCTSGuarantee]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdNLNCTSGuarantee' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[txdNLNCTSGuarantee] (
    [PartnerID]          INT          NOT NULL,
    [EffDate]            DATETIME     NOT NULL,
    [DeclarationGUID]    VARCHAR (50) NOT NULL,
    [HeaderGUID]         VARCHAR (50) NOT NULL,
    [GuaranteeGUID]      VARCHAR (50) NOT NULL,
    [SequenceNum]        INT          NOT NULL,
    [Type]               VARCHAR (1)  NOT NULL,
    [DeletedFlag]        VARCHAR (1)  NOT NULL,
    [KeepDuringRollback] VARCHAR (1)  NOT NULL,
    CONSTRAINT [PK_txdNLNCTSGuarantee] PRIMARY KEY NONCLUSTERED ([PartnerID] ASC, [DeclarationGUID] ASC, [HeaderGUID] ASC, [GuaranteeGUID] ASC)
);
END


GO
PRINT N'Creating [dbo].[txdNLNCTSGuarantee].[CIX_txdNLNCTSGuarantee]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_txdNLNCTSGuarantee' AND object_id = object_id('txdNLNCTSGuarantee'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_txdNLNCTSGuarantee]
    ON [dbo].[txdNLNCTSGuarantee]([EffDate] ASC);
END


GO
PRINT N'Creating [dbo].[txdNLNCTSGuaranteeReference]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdNLNCTSGuaranteeReference' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[txdNLNCTSGuaranteeReference] (
    [PartnerID]              INT          NOT NULL,
    [EffDate]                DATETIME     NOT NULL,
    [DeclarationGUID]        VARCHAR (50) NOT NULL,
    [HeaderGUID]             VARCHAR (50) NOT NULL,
    [GuaranteeGUID]          VARCHAR (50) NOT NULL,
    [GuaranteeReferenceGUID] VARCHAR (50) NOT NULL,
    [SequenceNum]            INT          NOT NULL,
    [GRN]                    VARCHAR (24) NOT NULL,
    [OtherGRN]               VARCHAR (35) NOT NULL,
    [AccessCode]             VARCHAR (4)  NOT NULL,
    [NotValidForEC]          VARCHAR (1)  NOT NULL,
    [DeletedFlag]            VARCHAR (1)  NOT NULL,
    [KeepDuringRollback]     VARCHAR (1)  NOT NULL,
    CONSTRAINT [PK_txdNLNCTSGuaranteeReference] PRIMARY KEY NONCLUSTERED ([PartnerID] ASC, [DeclarationGUID] ASC, [HeaderGUID] ASC, [GuaranteeGUID] ASC, [GuaranteeReferenceGUID] ASC)
);
END


GO
PRINT N'Creating [dbo].[txdNLNCTSGuaranteeReference].[CIX_txdNLNCTSGuaranteeReference]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_txdNLNCTSGuaranteeReference' AND object_id = object_id('txdNLNCTSGuaranteeReference'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_txdNLNCTSGuaranteeReference]
    ON [dbo].[txdNLNCTSGuaranteeReference]([EffDate] ASC);
END


GO
PRINT N'Creating [dbo].[txdNLNCTSGuaranteeReferenceValidityNonEC]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdNLNCTSGuaranteeReferenceValidityNonEC' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[txdNLNCTSGuaranteeReferenceValidityNonEC] (
    [PartnerID]              INT          NOT NULL,
    [EffDate]                DATETIME     NOT NULL,
    [DeclarationGUID]        VARCHAR (50) NOT NULL,
    [HeaderGUID]             VARCHAR (50) NOT NULL,
    [GuaranteeGUID]          VARCHAR (50) NOT NULL,
    [GuaranteeReferenceGUID] VARCHAR (50) NOT NULL,
    [ValidityNonECGUID]      VARCHAR (50) NOT NULL,
    [SequenceNum]            INT          NOT NULL,
    [NotValidFor]            VARCHAR (2)  NOT NULL,
    [DeletedFlag]            VARCHAR (1)  NOT NULL,
    [KeepDuringRollback]     VARCHAR (1)  NOT NULL,
    CONSTRAINT [PK_txdNLNCTSGuaranteeReferenceValidityNonEC] PRIMARY KEY NONCLUSTERED ([PartnerID] ASC, [DeclarationGUID] ASC, [HeaderGUID] ASC, [GuaranteeGUID] ASC, [GuaranteeReferenceGUID] ASC, [ValidityNonECGUID] ASC)
);
END


GO
PRINT N'Creating [dbo].[txdNLNCTSGuaranteeReferenceValidityNonEC].[CIX_txdNLNCTSGuaranteeReferenceValidityNonEC]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_txdNLNCTSGuaranteeReferenceValidityNonEC' AND object_id = object_id('txdNLNCTSGuaranteeReferenceValidityNonEC'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_txdNLNCTSGuaranteeReferenceValidityNonEC]
    ON [dbo].[txdNLNCTSGuaranteeReferenceValidityNonEC]([EffDate] ASC);
END


GO
PRINT N'Creating [dbo].[txdNLNCTSHeader]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdNLNCTSHeader' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[txdNLNCTSHeader] (
    [PartnerID]                                   INT           NOT NULL,
    [EffDate]                                     DATETIME      NOT NULL,
    [DeclarationGUID]                             VARCHAR (50)  NOT NULL,
    [HeaderGUID]                                  VARCHAR (50)  NOT NULL,
    [SequenceNum]                                 INT           NOT NULL,
    [LRN]                                         VARCHAR (22)  NOT NULL,
    [MRN]                                         VARCHAR (21)  NOT NULL,
    [Type]                                        VARCHAR (20)  NOT NULL,
    [TypeOfDeclaration]                           VARCHAR (9)   NOT NULL,
    [DeclarationAcceptanceDate]                   DATETIME      NOT NULL,
    [DeclarationRejectionDate]                    DATETIME      NOT NULL,
    [DeclarationRejectionReason]                  VARCHAR (350) NOT NULL,
    [DeclarationRejectionReasonLng]               VARCHAR (2)   NOT NULL,
    [CancellationDecision]                        VARCHAR (1)   NOT NULL,
    [DateOfCancellationRequest]                   DATETIME      NOT NULL,
    [CancellationInitiatedByCustoms]              VARCHAR (1)   NOT NULL,
    [DateOfCancellationDecision]                  DATETIME      NOT NULL,
    [CancellationJustification]                   VARCHAR (350) NOT NULL,
    [CancellationJustificationLng]                VARCHAR (2)   NOT NULL,
    [DateOfControlNotification]                   DATETIME      NOT NULL,
    [GoodsReleaseDate]                            DATETIME      NOT NULL,
    [ArrivalRejectionDate]                        DATETIME      NOT NULL,
    [ActionToBeTaken]                             VARCHAR (350) NOT NULL,
    [ActionToBeTakenLng]                          VARCHAR (2)   NOT NULL,
    [ArrivalRejectionReason]                      VARCHAR (350) NOT NULL,
    [ArrivalRejectionReasonLng]                   VARCHAR (2)   NOT NULL,
    [UnloadingRemarksRejectionDate]               DATETIME      NOT NULL,
    [UnloadingRemarksRejectionReason]             VARCHAR (350) NOT NULL,
    [UnloadingRemarksRejectionReasonLng]          VARCHAR (2)   NOT NULL,
    [ReleaseRequested]                            VARCHAR (1)   NOT NULL,
    [DateOfReleaseRequest]                        DATETIME      NOT NULL,
    [DateOfReleaseRequestRejection]               DATETIME      NOT NULL,
    [ReleaseRequestRejectionReason]               VARCHAR (350) NOT NULL,
    [ReleaseRequestRejectionReasonLng]            VARCHAR (2)   NOT NULL,
    [PrincipalName]                               VARCHAR (35)  NOT NULL,
    [PrincipalStreetAndNumber]                    VARCHAR (35)  NOT NULL,
    [PrincipalPostalCode]                         VARCHAR (9)   NOT NULL,
    [PrincipalCity]                               VARCHAR (35)  NOT NULL,
    [PrincipalCountryCode]                        VARCHAR (2)   NOT NULL,
    [PrincipalNadLng]                             VARCHAR (2)   NOT NULL,
    [PrincipalTin]                                VARCHAR (17)  NOT NULL,
    [HolderIdTir]                                 VARCHAR (17)  NOT NULL,
    [DestinationName]                             VARCHAR (35)  NOT NULL,
    [DestinationStreetAndNumber]                  VARCHAR (35)  NOT NULL,
    [DestinationPostalCode]                       VARCHAR (9)   NOT NULL,
    [DestinationCity]                             VARCHAR (35)  NOT NULL,
    [DestinationCountryCode]                      VARCHAR (2)   NOT NULL,
    [DestinationNadLng]                           VARCHAR (2)   NOT NULL,
    [DestinationTin]                              VARCHAR (17)  NOT NULL,
    [GuarantorName]                               VARCHAR (35)  NOT NULL,
    [GuarantorStreetAndNumber]                    VARCHAR (35)  NOT NULL,
    [GuarantorPostalCode]                         VARCHAR (9)   NOT NULL,
    [GuarantorCity]                               VARCHAR (35)  NOT NULL,
    [GuarantorCountryCode]                        VARCHAR (2)   NOT NULL,
    [GuarantorNadLng]                             VARCHAR (2)   NOT NULL,
    [GuarantorTin]                                VARCHAR (17)  NOT NULL,
    [WriteOffDate]                                DATETIME      NOT NULL,
    [DischargeCode]                               VARCHAR (1)   NOT NULL,
    [NCTSReturnCopy]                              VARCHAR (1)   NOT NULL,
    [IssuingDate]                                 DATETIME      NOT NULL,
    [BindingItinerary]                            VARCHAR (1)   NOT NULL,
    [AuthorisationId]                             VARCHAR (17)  NOT NULL,
    [ReturnCopiesCustomsOffice]                   VARCHAR (8)   NOT NULL,
    [ReturnCopiesCustomsOfficeName]               VARCHAR (35)  NOT NULL,
    [ReturnCopiesCustomsOfficeStreetAndNumber]    VARCHAR (35)  NOT NULL,
    [ReturnCopiesCustomsOfficeCountryCode]        VARCHAR (2)   NOT NULL,
    [ReturnCopiesCustomsOfficePostalCode]         VARCHAR (9)   NOT NULL,
    [ReturnCopiesCustomsOfficeCity]               VARCHAR (35)  NOT NULL,
    [ReturnCopiesCustomsOfficeNadLng]             VARCHAR (2)   NOT NULL,
    [PresentationCustomsOffice]                   VARCHAR (8)   NOT NULL,
    [DepartureCustomsOffice]                      VARCHAR (8)   NOT NULL,
    [ControlDate]                                 DATETIME      NOT NULL,
    [ControlResultCode]                           VARCHAR (2)   NOT NULL,
    [ControlledBy]                                VARCHAR (35)  NOT NULL,
    [ControlledByLng]                             VARCHAR (2)   NOT NULL,
    [DateLimit]                                   DATETIME      NOT NULL,
    [ContinueUnloading]                           VARCHAR (1)   NOT NULL,
    [NoReleaseMotivation]                         VARCHAR (350) NOT NULL,
    [NoReleaseMotivationLng]                      VARCHAR (2)   NOT NULL,
    [StateOfSealsOk]                              VARCHAR (10)  NOT NULL,
    [UnloadingRemark]                             VARCHAR (350) NOT NULL,
    [UnloadingRemarkLng]                          VARCHAR (2)   NOT NULL,
    [Conform]                                     VARCHAR (1)   NOT NULL,
    [UnloadingCompletion]                         VARCHAR (1)   NOT NULL,
    [UnloadingDate]                               DATETIME      NOT NULL,
    [CountryOfDestinationCode]                    VARCHAR (2)   NOT NULL,
    [AgreedLocationOfGoodsCode]                   VARCHAR (17)  NOT NULL,
    [AgreedLocationOfGoods]                       VARCHAR (35)  NOT NULL,
    [AgreedLocationOfGoodsLng]                    VARCHAR (2)   NOT NULL,
    [AuthorisedLocationOfGoodsCode]               VARCHAR (17)  NOT NULL,
    [PlaceOfLoadingCode]                          VARCHAR (17)  NOT NULL,
    [CountryOfDispatchExportCode]                 VARCHAR (2)   NOT NULL,
    [CustomsSubPlace]                             VARCHAR (17)  NOT NULL,
    [InlandTransportMode]                         VARCHAR (2)   NOT NULL,
    [TransportModeAtBorder]                       VARCHAR (2)   NOT NULL,
    [IdentityOfMeansOfTransportAtDeparture]       VARCHAR (27)  NOT NULL,
    [IdentityOfMeansOfTransportAtDepartureLng]    VARCHAR (2)   NOT NULL,
    [NationalityOfMeansOfTransportAtDeparture]    VARCHAR (2)   NOT NULL,
    [IdentityOfMeansOfTransportCrossingBorder]    VARCHAR (27)  NOT NULL,
    [IdentityOfMeansOfTransportCrossingBorderLng] VARCHAR (2)   NOT NULL,
    [NationalityOfMeansOfTransportCrossingBorder] VARCHAR (2)   NOT NULL,
    [TypeOfMeansOfTransportCrossingBorder]        VARCHAR (2)   NOT NULL,
    [ContainerisedIndicator]                      VARCHAR (1)   NOT NULL,
    [DialogLanguageIndicatorAtDeparture]          VARCHAR (2)   NOT NULL,
    [NctsAccompanyingDocumentLanguageCode]        VARCHAR (2)   NOT NULL,
    [TotalNumberOfItems]                          INT           NOT NULL,
    [TotalNumberOfPackages]                       INT           NOT NULL,
    [TotalGrossMass]                              NUMERIC (18)  NOT NULL,
    [DeclarationDate]                             DATETIME      NOT NULL,
    [DeclarationPlace]                            VARCHAR (35)  NOT NULL,
    [DeclarationPlaceLng]                         VARCHAR (2)   NOT NULL,
    [SpecificCircumstanceIndicator]               VARCHAR (1)   NOT NULL,
    [TransportChargesMethodOfPayment]             VARCHAR (1)   NOT NULL,
    [CommercialReferenceNumber]                   VARCHAR (70)  NOT NULL,
    [Security]                                    VARCHAR (1)   NOT NULL,
    [ConveyanceReferenceNumber]                   VARCHAR (35)  NOT NULL,
    [PlaceOfUnloadingCode]                        VARCHAR (35)  NOT NULL,
    [PlaceOfUnloadingLng]                         VARCHAR (2)   NOT NULL,
    [ConsignorName]                               VARCHAR (35)  NOT NULL,
    [ConsignorStreetAndNumber]                    VARCHAR (35)  NOT NULL,
    [ConsignorPostalCode]                         VARCHAR (9)   NOT NULL,
    [ConsignorCity]                               VARCHAR (35)  NOT NULL,
    [ConsignorCountryCode]                        VARCHAR (2)   NOT NULL,
    [ConsignorNadLng]                             VARCHAR (2)   NOT NULL,
    [ConsignorTin]                                VARCHAR (17)  NOT NULL,
    [ConsigneeName]                               VARCHAR (35)  NOT NULL,
    [ConsigneeStreetAndNumber]                    VARCHAR (35)  NOT NULL,
    [ConsigneePostalCode]                         VARCHAR (9)   NOT NULL,
    [ConsigneeCity]                               VARCHAR (35)  NOT NULL,
    [ConsigneeCountryCode]                        VARCHAR (2)   NOT NULL,
    [ConsigneeNadLng]                             VARCHAR (2)   NOT NULL,
    [ConsigneeTin]                                VARCHAR (17)  NOT NULL,
    [AuthorizedConsigneeTin]                      VARCHAR (17)  NOT NULL,
    [ArrivalTime]                                 DATETIME      NOT NULL,
    [DestinationCustomsOffice]                    VARCHAR (8)   NOT NULL,
    [RepresentativeName]                          VARCHAR (35)  NOT NULL,
    [RepresentativeCapacity]                      VARCHAR (35)  NOT NULL,
    [RepresentativeCapacityLng]                   VARCHAR (2)   NOT NULL,
    [SealsNumber]                                 INT           NOT NULL,
    [CarrierName]                                 VARCHAR (35)  NOT NULL,
    [CarrierStreetAndNumber]                      VARCHAR (35)  NOT NULL,
    [CarrierPostalCode]                           VARCHAR (9)   NOT NULL,
    [CarrierCity]                                 VARCHAR (35)  NOT NULL,
    [CarrierCountryCode]                          VARCHAR (2)   NOT NULL,
    [CarrierNadLng]                               VARCHAR (2)   NOT NULL,
    [CarrierTin]                                  VARCHAR (17)  NOT NULL,
    [SecurityConsignorName]                       VARCHAR (35)  NOT NULL,
    [SecurityConsignorStreetAndNumber]            VARCHAR (35)  NOT NULL,
    [SecurityConsignorPostalCode]                 VARCHAR (9)   NOT NULL,
    [SecurityConsignorCity]                       VARCHAR (35)  NOT NULL,
    [SecurityConsignorCountryCode]                VARCHAR (2)   NOT NULL,
    [SecurityConsignorNadLng]                     VARCHAR (2)   NOT NULL,
    [SecurityConsignorTin]                        VARCHAR (17)  NOT NULL,
    [SecurityConsigneeName]                       VARCHAR (35)  NOT NULL,
    [SecurityConsigneeStreetAndNumber]            VARCHAR (35)  NOT NULL,
    [SecurityConsigneePostalCode]                 VARCHAR (9)   NOT NULL,
    [SecurityConsigneeCity]                       VARCHAR (35)  NOT NULL,
    [SecurityConsigneeCountryCode]                VARCHAR (2)   NOT NULL,
    [SecurityConsigneeNadLng]                     VARCHAR (2)   NOT NULL,
    [SecurityConsigneeTin]                        VARCHAR (17)  NOT NULL,
    [ArrivalNotificationPlace]                    VARCHAR (35)  NOT NULL,
    [ArrivalNotificationPlaceLng]                 VARCHAR (2)   NOT NULL,
    [ArrivalAgreedLocationCode]                   VARCHAR (17)  NOT NULL,
    [ArrivalAgreedLocationOfGoods]                VARCHAR (35)  NOT NULL,
    [ArrivalAgreedLocationOfGoodsLng]             VARCHAR (2)   NOT NULL,
    [ArrivalAuthorisedLocationOfGoods]            VARCHAR (17)  NOT NULL,
    [SimplifiedProcedureFlag]                     VARCHAR (1)   NOT NULL,
    [ArrivalNotificationDate]                     DATETIME      NOT NULL,
    [DialogLanguageIndicatorAtDestination]        VARCHAR (2)   NOT NULL,
    [IncidentNumber]                              VARCHAR (50)  NOT NULL,
    [ReleaseType]                                 VARCHAR (2)   NOT NULL,
    [DepartureCompetentAuthority]                 VARCHAR (50)  NOT NULL,
    [NonArrivedMovementRequestDate]               DATETIME      NOT NULL,
    [CancellationReason]                          VARCHAR (350) NOT NULL,
    [CancellationReasonLNG]                       VARCHAR (2)   NOT NULL,
    [ActualConsigneeTin]                          VARCHAR (17)  NOT NULL,
    [ActualConsigneeName]                         VARCHAR (35)  NOT NULL,
    [ActualConsigneeStreetAndNumber]              VARCHAR (35)  NOT NULL,
    [ActualConsigneeCity]                         VARCHAR (35)  NOT NULL,
    [ActualConsigneeNadLng]                       VARCHAR (2)   NOT NULL,
    [ActualConsigneePostalCode]                   VARCHAR (9)   NOT NULL,
    [ActualConsigneeCountryCode]                  VARCHAR (2)   NOT NULL,
    [InformationOnPaperAvailable]                 VARCHAR (1)   NOT NULL,
    [TC11DeliveryDate]                            DATETIME      NOT NULL,
    [TC11DeliveredByCustoms]                      VARCHAR (1)   NOT NULL,
    [InformationText]                             VARCHAR (140) NOT NULL,
    [InformationTextLNG]                          VARCHAR (2)   NOT NULL,
    [InternalIncidentNumber]                      VARCHAR (50)  NOT NULL,
    [DeletedFlag]                                 VARCHAR (1)   NOT NULL,
    [KeepDuringRollback]                          VARCHAR (1)   NOT NULL,
    CONSTRAINT [PK_txdNLNCTSHeader] PRIMARY KEY NONCLUSTERED ([PartnerID] ASC, [DeclarationGUID] ASC, [HeaderGUID] ASC)
);
END


GO
PRINT N'Creating [dbo].[txdNLNCTSHeader].[CIX_txdNLNCTSHeader]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_txdNLNCTSHeader' AND object_id = object_id('txdNLNCTSHeader'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_txdNLNCTSHeader]
    ON [dbo].[txdNLNCTSHeader]([EffDate] ASC);
END


GO
PRINT N'Creating [dbo].[txdNLNCTSItinerary]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdNLNCTSItinerary' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[txdNLNCTSItinerary] (
    [PartnerID]          INT          NOT NULL,
    [EffDate]            DATETIME     NOT NULL,
    [DeclarationGUID]    VARCHAR (50) NOT NULL,
    [HeaderGUID]         VARCHAR (50) NOT NULL,
    [ItineraryGUID]      VARCHAR (50) NOT NULL,
    [SequenceNum]        INT          NOT NULL,
    [CountryOfRouting]   VARCHAR (2)  NOT NULL,
    [DeletedFlag]        VARCHAR (1)  NOT NULL,
    [KeepDuringRollback] VARCHAR (1)  NOT NULL,
    CONSTRAINT [PK_txdNLNCTSItinerary] PRIMARY KEY NONCLUSTERED ([PartnerID] ASC, [DeclarationGUID] ASC, [HeaderGUID] ASC, [ItineraryGUID] ASC)
);
END


GO
PRINT N'Creating [dbo].[txdNLNCTSItinerary].[CIX_txdNLNCTSItinerary]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_txdNLNCTSItinerary' AND object_id = object_id('txdNLNCTSItinerary'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_txdNLNCTSItinerary]
    ON [dbo].[txdNLNCTSItinerary]([EffDate] ASC);
END


GO
PRINT N'Creating [dbo].[txdNLNCTSMessage]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdNLNCTSMessage' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[txdNLNCTSMessage] (
    [PartnerID]                            INT           NOT NULL,
    [EffDate]                              DATETIME      NOT NULL,
    [DeclarationGUID]                      VARCHAR (50)  NOT NULL,
    [HeaderGUID]                           VARCHAR (50)  NOT NULL,
    [MessageGUID]                          VARCHAR (50)  NOT NULL,
    [FileName]                             VARCHAR (200) NOT NULL,
    [SequenceNum]                          INT           NOT NULL,
    [Origin]                               VARCHAR (20)  NOT NULL,
    [Status]                               VARCHAR (20)  NOT NULL,
    [StatusDate]                           DATETIME      NOT NULL,
    [Type]                                 VARCHAR (6)   NOT NULL,
    [SyntaxIdentifier]                     VARCHAR (4)   NOT NULL,
    [SyntaxVersionNumber]                  VARCHAR (1)   NOT NULL,
    [Sender]                               VARCHAR (35)  NOT NULL,
    [SenderIdentificationCodeQualifier]    VARCHAR (4)   NOT NULL,
    [Recipient]                            VARCHAR (35)  NOT NULL,
    [RecipientIdentificationCodeQualifier] VARCHAR (4)   NOT NULL,
    [DateOfPreparation]                    DATETIME      NOT NULL,
    [InterchangeControlReference]          VARCHAR (14)  NOT NULL,
    [RecipientReferencePassword]           VARCHAR (14)  NOT NULL,
    [RecipientReferencePasswordQualifier]  VARCHAR (2)   NOT NULL,
    [ApplicationReference]                 VARCHAR (14)  NOT NULL,
    [Priority]                             VARCHAR (1)   NOT NULL,
    [AcknowledgementRequest]               VARCHAR (1)   NOT NULL,
    [CommunicationsAgreementId]            VARCHAR (35)  NOT NULL,
    [TestIndicator]                        VARCHAR (1)   NOT NULL,
    [Identification]                       VARCHAR (14)  NOT NULL,
    [CommonAccessReference]                VARCHAR (35)  NOT NULL,
    [SequenceNumber]                       INT           NOT NULL,
    [FirstAndLastTransfer]                 VARCHAR (1)   NOT NULL,
    [UserGUID]                             VARCHAR (80)  NOT NULL,
    [UserName]                             VARCHAR (80)  NOT NULL,
    [DeletedFlag]                          VARCHAR (1)   NOT NULL,
    [KeepDuringRollback]                   VARCHAR (1)   NOT NULL,
    CONSTRAINT [PK_txdNLNCTSMessage] PRIMARY KEY NONCLUSTERED ([PartnerID] ASC, [DeclarationGUID] ASC, [HeaderGUID] ASC, [MessageGUID] ASC)
);
END


GO
PRINT N'Creating [dbo].[txdNLNCTSMessage].[CIX_txdNLNCTSMessage]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_txdNLNCTSMessage' AND object_id = object_id('txdNLNCTSMessage'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_txdNLNCTSMessage]
    ON [dbo].[txdNLNCTSMessage]([EffDate] ASC);
END


GO
PRINT N'Creating [dbo].[txdNLNCTSResultOfControl]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdNLNCTSResultOfControl' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[txdNLNCTSResultOfControl] (
    [PartnerID]             INT           NOT NULL,
    [EffDate]               DATETIME      NOT NULL,
    [DeclarationGUID]       VARCHAR (50)  NOT NULL,
    [HeaderGUID]            VARCHAR (50)  NOT NULL,
    [ResultGUID]            VARCHAR (50)  NOT NULL,
    [SequenceNum]           INT           NOT NULL,
    [Description]           VARCHAR (140) NOT NULL,
    [DescriptionLng]        VARCHAR (2)   NOT NULL,
    [ControlIndicator]      VARCHAR (2)   NOT NULL,
    [PointerToTheAttribute] VARCHAR (35)  NOT NULL,
    [CorrectedValue]        VARCHAR (27)  NOT NULL,
    [DeletedFlag]           VARCHAR (1)   NOT NULL,
    [KeepDuringRollback]    VARCHAR (1)   NOT NULL,
    CONSTRAINT [PK_txdNLNCTSResultOfControl] PRIMARY KEY NONCLUSTERED ([PartnerID] ASC, [DeclarationGUID] ASC, [HeaderGUID] ASC, [ResultGUID] ASC)
);
END


GO
PRINT N'Creating [dbo].[txdNLNCTSResultOfControl].[CIX_txdNLNCTSResultOfControl]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_txdNLNCTSResultOfControl' AND object_id = object_id('txdNLNCTSResultOfControl'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_txdNLNCTSResultOfControl]
    ON [dbo].[txdNLNCTSResultOfControl]([EffDate] ASC);
END


GO
PRINT N'Creating [dbo].[txdNLNCTSSeal]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdNLNCTSSeal' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[txdNLNCTSSeal] (
    [PartnerID]          INT          NOT NULL,
    [EffDate]            DATETIME     NOT NULL,
    [DeclarationGUID]    VARCHAR (50) NOT NULL,
    [HeaderGUID]         VARCHAR (50) NOT NULL,
    [SealGUID]           VARCHAR (50) NOT NULL,
    [SequenceNum]        INT          NOT NULL,
    [SealIdentity]       VARCHAR (20) NOT NULL,
    [SealIdentityLng]    VARCHAR (2)  NOT NULL,
    [DeletedFlag]        VARCHAR (1)  NOT NULL,
    [KeepDuringRollback] VARCHAR (1)  NOT NULL,
    CONSTRAINT [PK_txdNLNCTSSeal] PRIMARY KEY NONCLUSTERED ([PartnerID] ASC, [DeclarationGUID] ASC, [HeaderGUID] ASC, [SealGUID] ASC)
);
END


GO
PRINT N'Creating [dbo].[txdNLNCTSSeal].[CIX_txdNLNCTSSeal]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_txdNLNCTSSeal' AND object_id = object_id('txdNLNCTSSeal'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_txdNLNCTSSeal]
    ON [dbo].[txdNLNCTSSeal]([EffDate] ASC);
END


GO
PRINT N'Creating [dbo].[txdNLNCTSTransitOffice]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdNLNCTSTransitOffice' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[txdNLNCTSTransitOffice] (
    [PartnerID]          INT          NOT NULL,
    [EffDate]            DATETIME     NOT NULL,
    [DeclarationGUID]    VARCHAR (50) NOT NULL,
    [HeaderGUID]         VARCHAR (50) NOT NULL,
    [TransitOfficeGUID]  VARCHAR (50) NOT NULL,
    [SequenceNum]        INT          NOT NULL,
    [Code]               VARCHAR (8)  NOT NULL,
    [ArrivalTime]        DATETIME     NOT NULL,
    [DeletedFlag]        VARCHAR (1)  NOT NULL,
    [KeepDuringRollback] VARCHAR (1)  NOT NULL,
    CONSTRAINT [PK_txdNLNCTSTransitOffice] PRIMARY KEY NONCLUSTERED ([PartnerID] ASC, [DeclarationGUID] ASC, [HeaderGUID] ASC, [TransitOfficeGUID] ASC)
);
END


GO
PRINT N'Creating [dbo].[txdNLNCTSTransitOffice].[CIX_txdNLNCTSTransitOffice]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_txdNLNCTSTransitOffice' AND object_id = object_id('txdNLNCTSTransitOffice'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_txdNLNCTSTransitOffice]
    ON [dbo].[txdNLNCTSTransitOffice]([EffDate] ASC);
END


GO
PRINT N'Creating [dbo].[txdNLNCTSValidationWarning]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdNLNCTSValidationWarning' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[txdNLNCTSValidationWarning] (
    [PartnerID]          INT            NOT NULL,
    [EffDate]            DATETIME       NOT NULL,
    [DeclarationGUID]    VARCHAR (50)   NOT NULL,
    [HeaderGUID]         VARCHAR (50)   NOT NULL,
    [WarningGUID]        VARCHAR (50)   NOT NULL,
    [Location]           VARCHAR (1000) NOT NULL,
    [Warning]            VARCHAR (2000) NOT NULL,
    [DeletedFlag]        VARCHAR (1)    NOT NULL,
    [KeepDuringRollback] VARCHAR (1)    NOT NULL,
    CONSTRAINT [PK_txdNLNCTSValidationWarning] PRIMARY KEY NONCLUSTERED ([PartnerID] ASC, [DeclarationGUID] ASC, [HeaderGUID] ASC, [WarningGUID] ASC)
);
END


GO
PRINT N'Creating [dbo].[txdNLNCTSValidationWarning].[CIX_txdNLNCTSValidationWarning]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_txdNLNCTSValidationWarning' AND object_id = object_id('txdNLNCTSValidationWarning'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_txdNLNCTSValidationWarning]
    ON [dbo].[txdNLNCTSValidationWarning]([EffDate] ASC);
END


GO
PRINT N'Creating [dbo].[txdReportDefinitions]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdReportDefinitions' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[txdReportDefinitions] (
    [EffDate]            DATETIME      NOT NULL,
    [ReportName]         VARCHAR (30)  NOT NULL,
    [ReportApplication]  VARCHAR (100) NOT NULL,
    [DeletedFlag]        VARCHAR (1)   NOT NULL,
    [KeepDuringRollback] VARCHAR (1)   NOT NULL
);
END


GO
PRINT N'Creating [dbo].[txdReportDefinitions].[CIX_txdReportDefinitions]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_txdReportDefinitions' AND object_id = object_id('txdReportDefinitions'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_txdReportDefinitions]
    ON [dbo].[txdReportDefinitions]([EffDate] ASC);
END


GO
PRINT N'Creating [dbo].[txdReportDefinitions].[IX_txdReportDefinitions_1]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='IX_txdReportDefinitions_1' AND object_id = object_id('txdReportDefinitions'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE NONCLUSTERED INDEX [IX_txdReportDefinitions_1]
    ON [dbo].[txdReportDefinitions]([ReportName] ASC) WITH (FILLFACTOR = 100);
END


GO
PRINT N'Creating [dbo].[txdReportQueue]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdReportQueue' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[txdReportQueue] (
    [PartnerId]          INT              NOT NULL,
    [EffDate]            DATETIME         NOT NULL,
    [RequestId]          UNIQUEIDENTIFIER NOT NULL,
    [ReportName]         VARCHAR (30)     NOT NULL,
    [Userguid]           VARCHAR (50)     NOT NULL,
    [StatusCode]         VARCHAR (1)      NOT NULL,
    [StatusMsg]          TEXT             NOT NULL,
    [OutputURL]          VARCHAR (300)    NOT NULL,
    [OutputPath]         VARCHAR (300)    NOT NULL,
    [Server]             VARCHAR (50)     NOT NULL,
    [ApplicationURL]     VARCHAR (300)    NOT NULL,
    [StartTime]          DATETIME         NOT NULL,
    [EndTime]            DATETIME         NOT NULL,
    [ConnectionString]   VARCHAR (300)    NOT NULL,
    [Version]            VARCHAR (10)     NOT NULL,
    [DeletedFlag]        VARCHAR (1)      NOT NULL,
    [KeepDuringRollback] VARCHAR (1)      NOT NULL
);
END


GO
PRINT N'Creating [dbo].[txdReportQueue].[CIX_txdReportQueue]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_txdReportQueue' AND object_id = object_id('txdReportQueue'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_txdReportQueue]
    ON [dbo].[txdReportQueue]([EffDate] ASC);
END


GO
PRINT N'Creating [dbo].[txdReportQueue].[IX_txdReportQueue_1]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='IX_txdReportQueue_1' AND object_id = object_id('txdReportQueue'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE NONCLUSTERED INDEX [IX_txdReportQueue_1]
    ON [dbo].[txdReportQueue]([PartnerId] ASC, [RequestId] ASC) WITH (FILLFACTOR = 100);
END


GO
PRINT N'Creating [dbo].[txdReportQueueOutput]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdReportQueueOutput' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[txdReportQueueOutput] (
    [PartnerId]          INT              NOT NULL,
    [EffDate]            DATETIME         NOT NULL,
    [RequestId]          UNIQUEIDENTIFIER NOT NULL,
    [ReportTitle]        VARCHAR (100)    NOT NULL,
    [ReportURL]          VARCHAR (300)    NOT NULL,
    [ReportPath]         VARCHAR (300)    NOT NULL,
    [DeletedFlag]        VARCHAR (1)      NOT NULL,
    [KeepDuringRollback] VARCHAR (1)      NOT NULL
);
END


GO
PRINT N'Creating [dbo].[txdReportQueueOutput].[CIX_txdReportQueueOutput]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_txdReportQueueOutput' AND object_id = object_id('txdReportQueueOutput'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_txdReportQueueOutput]
    ON [dbo].[txdReportQueueOutput]([EffDate] ASC);
END


GO
PRINT N'Creating [dbo].[txdReportQueueOutput].[IX_txdReportQueueOutput_1]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='IX_txdReportQueueOutput_1' AND object_id = object_id('txdReportQueueOutput'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE NONCLUSTERED INDEX [IX_txdReportQueueOutput_1]
    ON [dbo].[txdReportQueueOutput]([PartnerId] ASC, [RequestId] ASC) WITH (FILLFACTOR = 100);
END


GO
PRINT N'Creating [dbo].[txdReportQueueParams]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdReportQueueParams' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[txdReportQueueParams] (
    [PartnerId]          INT              NOT NULL,
    [EffDate]            DATETIME         NOT NULL,
    [RequestId]          UNIQUEIDENTIFIER NOT NULL,
    [ParamName]          VARCHAR (200)    NOT NULL,
    [ParamValue]         NTEXT            NOT NULL,
    [DeletedFlag]        VARCHAR (1)      NOT NULL,
    [KeepDuringRollback] VARCHAR (1)      NOT NULL
);
END


GO
PRINT N'Creating [dbo].[txdReportQueueParams].[CIX_txdReportQueueParams]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='CIX_txdReportQueueParams' AND object_id = object_id('txdReportQueueParams'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE CLUSTERED INDEX [CIX_txdReportQueueParams]
    ON [dbo].[txdReportQueueParams]([EffDate] ASC);
END


GO
PRINT N'Creating [dbo].[txdReportQueueParams].[IX_txdReportQueueParams_1]...';


GO
IF EXISTS (SELECT top 1 1 FROM sys.indexes  WHERE name='IX_txdReportQueueParams_1' AND object_id = object_id('txdReportQueueParams'))
BEGIN
	PRINT 'Index Already Exists... Skipping'
END
ELSE
BEGIN
CREATE NONCLUSTERED INDEX [IX_txdReportQueueParams_1]
    ON [dbo].[txdReportQueueParams]([PartnerId] ASC, [RequestId] ASC) WITH (FILLFACTOR = 100);
END


GO
PRINT N'Creating [dbo].[txdTempStorageVariableInput]...';


GO
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdTempStorageVariableInput' AND Type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE [dbo].[txdTempStorageVariableInput] (
    [PartnerID]          INT            NOT NULL,
    [EffDate]            DATETIME       NOT NULL,
    [InputRequestGuid]   VARCHAR (50)   NOT NULL,
    [InputDetailGuid]    VARCHAR (50)   NOT NULL,
    [KeyValue1]          NVARCHAR (50)  NOT NULL,
    [KeyValue2]          NVARCHAR (50)  NOT NULL,
    [KeyValue3]          NVARCHAR (50)  NOT NULL,
    [ColumnName]         NVARCHAR (100) NOT NULL,
    [ColumnData]         NVARCHAR (100) NOT NULL,
    [DeletedFlag]        NVARCHAR (1)   NOT NULL,
    [KeepDuringRollback] VARCHAR (1)    NOT NULL,
    CONSTRAINT [PK_txdTempStorageVariableInput] PRIMARY KEY NONCLUSTERED ([PartnerID] ASC, [InputRequestGuid] ASC, [InputDetailGuid] ASC)
);
END


GO
if OBJECT_ID('[dbo].[DF__ttdStagin__KeepD__6A96485D]', 'C') IS NOT NULL
begin
PRINT N'Creating [dbo].[DF__ttdStagin__KeepD__6A96485D]...';

ALTER TABLE [dbo].[ttdStagingDEAESDeclarationDataHist]
    ADD CONSTRAINT [DF__ttdStagin__KeepD__6A96485D] DEFAULT ('N') FOR [KeepDuringRollback];
end

GO


GO
if OBJECT_ID('[dbo].[DF__ttdStagin__Delet__69A22424]', 'C') IS NOT NULL
begin
PRINT N'Creating [dbo].[DF__ttdStagin__Delet__69A22424]...';
	
ALTER TABLE [dbo].[ttdStagingDEAESDeclarationDataHist]
    ADD CONSTRAINT [DF__ttdStagin__Delet__69A22424] DEFAULT ('N') FOR [DeletedFlag];
end

GO


GO
if OBJECT_ID('[dbo].[DF_ttdStagingDEAESDeclarationDataHist_EmergencyProcedureReferenceNumber]', 'C') IS NOT NULL
begin
		
PRINT N'Creating [dbo].[DF_ttdStagingDEAESDeclarationDataHist_EmergencyProcedureReferenceNumber]...';
ALTER TABLE [dbo].[ttdStagingDEAESDeclarationDataHist]
    ADD CONSTRAINT [DF_ttdStagingDEAESDeclarationDataHist_EmergencyProcedureReferenceNumber] DEFAULT ('') FOR [EmergencyProcedureReferenceNumber];
end
	   
GO
PRINT N'Checking existing data against newly created constraints';


GO
if OBJECT_ID('[dbo].[FK_tmgEmailNotificationQueries]', 'F') IS NOT NULL
begin
		ALTER TABLE [dbo].[tmgEmailNotificationQueries_OLD_173] WITH CHECK CHECK CONSTRAINT [FK_tmgEmailNotificationQueries];
end


GO
PRINT N'Update complete.';


GO
