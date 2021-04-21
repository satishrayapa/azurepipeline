/****** Object:  Table [dbo].[dbaBackupTracking]    Script Date: 12/24/2019 7:32:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dbaBackupTracking](
	[TableName] [varchar](100) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[DropDate] [datetime] NULL,
 CONSTRAINT [PK_dbaBackupTracking] PRIMARY KEY NONCLUSTERED 
(
	[TableName] ASC,
	[CreatedDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ReleaseDetail]    Script Date: 12/24/2019 7:32:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReleaseDetail](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ReleaseNumber] [varchar](20) NOT NULL,
	[ReleaseDetailVersion] [varchar](20) NOT NULL,
	[ReleaseAppliedDate] [datetime] NOT NULL,
	[DeployNotes] [varchar](max) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tlgApplicationLaunchProcessID]    Script Date: 12/24/2019 7:32:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tlgApplicationLaunchProcessID](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[Workflow] [varchar](255) NOT NULL,
	[ProcessGuid] [uniqueidentifier] NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tlgServerApplicationsAllowedToRun]    Script Date: 12/24/2019 7:32:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tlgServerApplicationsAllowedToRun](
	[EffDate] [datetime] NOT NULL,
	[ServerName] [varchar](255) NOT NULL,
	[ApplicationAllowedToRun] [varchar](255) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmfDefaults]    Script Date: 12/24/2019 7:32:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmfDefaults](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[FtzNum] [varchar](15) NOT NULL,
	[CompanyName] [varchar](200) NOT NULL,
	[CompanyAddress] [varchar](200) NOT NULL,
	[CompanyCity] [varchar](50) NOT NULL,
	[CompanyState] [varchar](2) NOT NULL,
	[CompanyZip] [varchar](10) NOT NULL,
	[CompanyPhone] [varchar](50) NOT NULL,
	[EndOfFiscalYear] [datetime] NOT NULL,
	[EndOfZoneYear] [datetime] NOT NULL,
	[Ein] [varchar](12) NOT NULL,
	[JointFtzNum] [varchar](4) NOT NULL,
	[JointCompanyName] [varchar](30) NOT NULL,
	[JointCompanyAddress] [varchar](200) NOT NULL,
	[JointCompanyCity] [varchar](20) NOT NULL,
	[JointCompanyState] [varchar](2) NOT NULL,
	[JointCompanyZip] [varchar](10) NOT NULL,
	[JointCompanyPhone] [varchar](50) NOT NULL,
	[JointEin] [varchar](12) NOT NULL,
	[CompanyAuthorization] [varchar](2) NOT NULL,
	[FtzPort] [varchar](5) NOT NULL,
	[HmfRate] [numeric](38, 20) NOT NULL,
	[ChargeRate] [numeric](38, 20) NOT NULL,
	[Mpf500Amt] [numeric](38, 20) NOT NULL,
	[InformalMpfAmt] [numeric](38, 20) NOT NULL,
	[EntryTypeValue] [numeric](38, 20) NOT NULL,
	[TeamNum] [varchar](3) NOT NULL,
	[BondNum] [varchar](10) NOT NULL,
	[BondType] [varchar](2) NOT NULL,
	[SerialNum] [varchar](5) NOT NULL,
	[ConsigneeState] [varchar](2) NOT NULL,
	[LocationOfGoods] [varchar](10) NOT NULL,
	[Purchaser] [varchar](50) NOT NULL,
	[ReportPath] [varchar](50) NOT NULL,
	[AbiPath] [varchar](50) NOT NULL,
	[DownloadPath] [varchar](50) NOT NULL,
	[InitTxnCounter] [numeric](38, 20) NOT NULL,
	[RpimOrderCounter] [numeric](38, 20) NOT NULL,
	[LastCf214Suffix] [int] NOT NULL,
	[LastShipmentSuffix] [int] NOT NULL,
	[LastEntryNum] [int] NOT NULL,
	[EntryFilerCode] [varchar](3) NOT NULL,
	[NextCF7512Number] [varchar](13) NOT NULL,
	[EndingCF7512Number] [varchar](13) NOT NULL,
	[LastTxnDate] [datetime] NOT NULL,
	[LibyaStatement] [varchar](2000) NOT NULL,
	[TscaStatement] [varchar](2000) NOT NULL,
	[ReconcileAllFlag] [varchar](1) NOT NULL,
	[WeightVariancePercent] [numeric](38, 20) NOT NULL,
	[ApiDensityOfWater] [numeric](38, 20) NOT NULL,
	[ApiAtmosphericFactor] [numeric](38, 20) NOT NULL,
	[ManufacturerID] [varchar](25) NOT NULL,
	[DownloadFlag] [varchar](1) NOT NULL,
	[ValidFlag] [varchar](1) NOT NULL,
	[DailyFlag] [varchar](1) NOT NULL,
	[NumFlag] [varchar](1) NOT NULL,
	[FIFOFlag] [varchar](1) NOT NULL,
	[LastFIFOFinalize] [datetime] NOT NULL,
	[DateFormat] [varchar](50) NOT NULL,
	[DateTimeFormat] [varchar](50) NOT NULL,
	[TimezoneOffset] [varchar](50) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
 CONSTRAINT [PK_tmfDefaults] PRIMARY KEY CLUSTERED 
(
	[PartnerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmgSQL]    Script Date: 12/24/2019 7:32:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmgSQL](
	[PartnerID] [int] NULL,
	[EffDate] [datetime] NOT NULL,
	[SQLGUID] [varchar](50) NOT NULL,
	[SQLDescription] [varchar](50) NULL,
	[SQLCmd] [text] NULL,
	[TxnDate] [datetime] NULL,
	[SQLLongDescription] [ntext] NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
 CONSTRAINT [PK_tmgSQL] PRIMARY KEY CLUSTERED 
(
	[SQLGUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmgSQLUserList]    Script Date: 12/24/2019 7:32:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmgSQLUserList](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[UserGUID] [varchar](80) NOT NULL,
	[SQLGUID] [varchar](50) NOT NULL,
	[PageName] [varchar](50) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
 CONSTRAINT [PK_tmgSQLUserList] PRIMARY KEY CLUSTERED 
(
	[PartnerID] ASC,
	[UserGUID] ASC,
	[SQLGUID] ASC,
	[PageName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmp_tlgWorkFlowSchedule]    Script Date: 12/24/2019 7:32:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmp_tlgWorkFlowSchedule](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[WorkFlowGUID] [varchar](80) NOT NULL,
	[Description] [varchar](120) NOT NULL,
	[Recurring] [varchar](1) NOT NULL,
	[Time] [varchar](5) NOT NULL,
	[Date] [datetime] NOT NULL,
	[WorkFlow] [varchar](255) NOT NULL,
	[LastUpdated] [datetime] NOT NULL,
	[Interval] [int] NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tmp_txdReportDefinitions]    Script Date: 12/24/2019 7:32:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmp_txdReportDefinitions](
	[EffDate] [datetime] NOT NULL,
	[ReportName] [varchar](30) NOT NULL,
	[ReportApplication] [varchar](100) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tugOpenQuery]    Script Date: 12/24/2019 7:32:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tugOpenQuery](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[Identifier] [uniqueidentifier] NOT NULL,
	[UserGUID] [varchar](50) NOT NULL,
	[OpenQuerySQL] [text] NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
 CONSTRAINT [PK_tugOpenQuery] PRIMARY KEY CLUSTERED 
(
	[PartnerID] ASC,
	[Identifier] ASC,
	[UserGUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[txdReportDefinitions]    Script Date: 12/24/2019 7:32:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[txdReportDefinitions](
	[EffDate] [datetime] NOT NULL,
	[ReportName] [varchar](30) NOT NULL,
	[ReportApplication] [varchar](100) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[txdReportQueue]    Script Date: 12/24/2019 7:32:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[txdReportQueue](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[RequestId] [uniqueidentifier] NOT NULL,
	[ReportName] [varchar](30) NOT NULL,
	[Userguid] [varchar](50) NOT NULL,
	[StatusCode] [varchar](1) NOT NULL,
	[StatusMsg] [text] NOT NULL,
	[OutputURL] [varchar](300) NOT NULL,
	[OutputPath] [varchar](300) NOT NULL,
	[Server] [varchar](50) NOT NULL,
	[ApplicationURL] [varchar](300) NOT NULL,
	[StartTime] [datetime] NOT NULL,
	[EndTime] [datetime] NOT NULL,
	[ConnectionString] [varchar](300) NOT NULL,
	[Priority] [varchar](1) NOT NULL,
	[StorageType] [varchar](1) NOT NULL,
	[Version] [varchar](10) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[txdReportQueueOutput]    Script Date: 12/24/2019 7:32:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[txdReportQueueOutput](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[RowId] [uniqueidentifier] NOT NULL,
	[RequestId] [uniqueidentifier] NOT NULL,
	[ReportTitle] [varchar](150) NULL,
	[ReportURL] [varchar](300) NOT NULL,
	[ReportPath] [varchar](300) NOT NULL,
	[GTNGuid] [uniqueidentifier] NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[txdReportQueueParams]    Script Date: 12/24/2019 7:32:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[txdReportQueueParams](
	[PartnerId] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[RequestId] [uniqueidentifier] NOT NULL,
	[ParamName] [varchar](200) NOT NULL,
	[ParamValue] [ntext] NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[ReleaseDetail] ADD  CONSTRAINT [DF__ReleaseDe__Deplo__0EA100AE]  DEFAULT ('N') FOR [DeployNotes]
GO
ALTER TABLE [dbo].[ReleaseDetail] ADD  CONSTRAINT [DF__ReleaseDe__Delet__0F9524E7]  DEFAULT ('N') FOR [DeletedFlag]
GO
ALTER TABLE [dbo].[ReleaseDetail] ADD  CONSTRAINT [DF__ReleaseDe__KeepD__10894920]  DEFAULT ('N') FOR [KeepDuringRollback]
GO
ALTER TABLE [dbo].[tmfDefaults] ADD  CONSTRAINT [DF_tmfDefaults_EndOfFiscalYear]  DEFAULT (((1)/(1))/(1900)) FOR [EndOfFiscalYear]
GO
ALTER TABLE [dbo].[tmfDefaults] ADD  CONSTRAINT [DF_tmfDefaults_EndOfZoneYear]  DEFAULT (((1)/(1))/(1900)) FOR [EndOfZoneYear]
GO
ALTER TABLE [dbo].[tmfDefaults] ADD  DEFAULT ('') FOR [DateFormat]
GO
ALTER TABLE [dbo].[tmfDefaults] ADD  DEFAULT ('') FOR [DateTimeFormat]
GO
ALTER TABLE [dbo].[tmfDefaults] ADD  DEFAULT ('') FOR [TimezoneOffset]
GO
ALTER TABLE [dbo].[tmfDefaults] ADD  DEFAULT ('N') FOR [DeletedFlag]
GO
ALTER TABLE [dbo].[tmfDefaults] ADD  DEFAULT ('N') FOR [KeepDuringRollback]
GO
ALTER TABLE [dbo].[tmgSQL] ADD  CONSTRAINT [DF_tmgSQL_SQLLongDescription]  DEFAULT ('') FOR [SQLLongDescription]
GO
ALTER TABLE [dbo].[tmgSQL] ADD  CONSTRAINT [DF_tmgSQL_DeletedFlag]  DEFAULT ('N') FOR [DeletedFlag]
GO
ALTER TABLE [dbo].[tmgSQL] ADD  CONSTRAINT [DF_tmgSQL_KeepDuringRollback]  DEFAULT ('N') FOR [KeepDuringRollback]
GO
ALTER TABLE [dbo].[tugOpenQuery] ADD  CONSTRAINT [DF_tugOpenQuery_Identifier]  DEFAULT (newid()) FOR [Identifier]
GO
ALTER TABLE [dbo].[txdReportQueue] ADD  CONSTRAINT [DF_txdReportQueue_Priority]  DEFAULT ('0') FOR [Priority]
GO
ALTER TABLE [dbo].[txdReportQueue] ADD  CONSTRAINT [DF_txdReportQueue_StorageType]  DEFAULT ('0') FOR [StorageType]
GO
ALTER TABLE [dbo].[txdReportQueue] ADD  DEFAULT ('7.7') FOR [Version]
GO
ALTER TABLE [dbo].[txdReportQueue] ADD  DEFAULT ('N') FOR [DeletedFlag]
GO
ALTER TABLE [dbo].[txdReportQueue] ADD  DEFAULT ('N') FOR [KeepDuringRollback]
GO
ALTER TABLE [dbo].[txdReportQueueOutput] ADD  CONSTRAINT [DF_txdReportQueueOutput_RowId]  DEFAULT (newid()) FOR [RowId]
GO
ALTER TABLE [dbo].[txdReportQueueOutput] ADD  CONSTRAINT [DF_txdReportQueueOutput_GTNGuid]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [GTNGuid]
GO
/****** Object:  StoredProcedure [dbo].[usp_DBACreateTableIndexes]    Script Date: 12/24/2019 7:32:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_DBACreateTableIndexes]
(
	 @DatabaseName NVARCHAR(128) = NULL
	,@TableName NVARCHAR(128)
)
AS
/*
Name: usp_DBACreateTableIndexes 
Author: John DePrato
Description: Creates indexes so that when doing a table adjustment the indexes can be rebuilt against the changed schema
Parameters: @DatabaseName - NVARCHAR(128) = uses the current database context to run the database update
			@TableName - NVARCHAR(128) = specify a single table that is going to be modified
Change History:
	- 09/03/2014 - JCD - Created
*/
BEGIN
	SET NOCOUNT ON
	DECLARE @DatabaseSQL NVARCHAR(255)
	DECLARE @Parameters NVARCHAR(500)
	DECLARE @SQL NVARCHAR(MAX)

	CREATE TABLE #TEMP_ERROR_OUTPUT
	(
		ERROR INT
	)
	
	IF (@DatabaseName IS NULL OR @DatabaseName = '')
	BEGIN
		SET @DatabaseName = DB_NAME()
	END
	
	SET @SQL = 'IF EXISTS(SELECT 1 FROM ' + @DatabaseName + '.sys.tables WHERE name = ' + '''' + @TableName + '''' + ') SELECT 0 ELSE SELECT 1'
	
	INSERT INTO #TEMP_ERROR_OUTPUT
	EXEC sp_executesql @SQL
	
	IF NOT EXISTS(SELECT 1 FROM master.sys.databases WHERE name = @DatabaseName)
	BEGIN
		GOTO DATABASE_NAME_ERROR
	END
	
	IF EXISTS(SELECT 1 FROM #TEMP_ERROR_OUTPUT WHERE Error = 1)
	BEGIN
		GOTO DATABASE_TABLENAME_ERROR
	END
		
	SET @DatabaseSQL = 'USE [' + @DatabaseName + ']; '

	SET @SQL = REPLACE(N'
	DECLARE @SQL NVARCHAR(MAX)
	DECLARE @Count INT
	DECLARE @MaxCount INT
	DECLARE @ColumnCount INT
	DECLARE @ColumnMaxCount INT
	DECLARE @TableName NVARCHAR(128)
	DECLARE @IndexName NVARCHAR(128)
	DECLARE @allow_page_locks NVARCHAR(3)
	DECLARE @allow_row_locks NVARCHAR(3)
	DECLARE @fill_factor INT
	DECLARE @has_filter BIT
	DECLARE @filter_definition NVARCHAR(MAX)
	DECLARE @is_primary_key BIT
	DECLARE @is_unique BIT
	DECLARE @is_unique_constraint BIT
	DECLARE @type TINYINT
	DECLARE @type_desc NVARCHAR(50)
	DECLARE @is_padded NVARCHAR(3)
	DECLARE @is_disabled INT
	DECLARE @ignore_dup_key NVARCHAR(3)
	DECLARE @Column NVARCHAR(128)
	DECLARE @Columns NVARCHAR(MAX)
	DECLARE @IncludedColumn NVARCHAR(128)
	DECLARE @IncludedColumns NVARCHAR(MAX)
	DECLARE @options NVARCHAR(2000)
	
	SELECT	 IDENTITY(INT,1,1) AS RowID
			,TableName
			,IndexName
			,CASE WHEN [allow_page_locks] = 1 THEN ''ON'' ELSE ''OFF'' END AS [allow_page_locks]
			,CASE WHEN [allow_row_locks] = 1 THEN ''ON'' ELSE ''OFF'' END AS [allow_row_locks]
			,[fill_factor]
			,[has_filter]
			,[filter_definition]
			,[is_primary_key]
			,[is_unique]
			,[is_unique_constraint]
			,[type]
			,[type_desc]
			,CASE WHEN [is_padded] = 1 THEN ''ON'' ELSE ''OFF'' END AS [is_padded]
			,[is_disabled]
			,CASE WHEN [ignore_dup_key] = 1 THEN ''ON'' ELSE ''OFF'' END AS [ignore_dup_key] 
	INTO #TEMP_INDEXES
	FROM dbo.TEMP_INDEXES_@TableName@
	GROUP BY [TableName]
			,[IndexName]
			,[allow_page_locks]
			,[allow_row_locks]
			,[fill_factor]
			,[has_filter]
			,[filter_definition]
			,[is_primary_key]
			,[is_unique]
			,[is_unique_constraint]
			,[type]
			,[type_desc]
			,[is_padded]
			,[is_disabled]
			,[ignore_dup_key]
	
	SELECT @Count = 1, @MaxCount = COUNT(*)
	FROM #TEMP_INDEXES
	
	WHILE (@Count <= @MaxCount)
	BEGIN
		IF (OBJECT_ID(''tempdb..#TEMP_COLUMNS'') IS NOT NULL)
		BEGIN
			DROP TABLE #TEMP_COLUMNS
		END
		
		SELECT @IndexName = IndexName, @TableName = TableName
		FROM #TEMP_INDEXES
		WHERE RowID = @Count
		
		SELECT	 IDENTITY(INT,1,1) AS key_ordinal
				,CASE WHEN tupc.is_descending_key = 1 THEN ''DESC'' ELSE ''ASC'' END AS is_descending_key
				,tupc.ColumnName
		INTO #TEMP_COLUMNS
		FROM sys.tables tbl
		JOIN sys.columns col ON tbl.object_id = col.object_id
		JOIN dbo.TEMP_INDEXES_@TableName@ tupc ON tupc.ColumnName = col.name
		WHERE tbl.name = @TableName
			AND tupc.IndexName = @IndexName
			AND tupc.is_included_column = 0
		ORDER BY tupc.key_ordinal ASC
		
		DELETE tc
		FROM #TEMP_COLUMNS tc
		WHERE NOT EXISTS(SELECT 1 
						 FROM sys.tables tbl
						 JOIN sys.columns col ON tbl.object_id = col.object_id
						 WHERE tbl.name = @TableName
							AND tc.ColumnName = col.name)
		
		SELECT @ColumnCount = 1, @ColumnMaxCount = COUNT(*)
		FROM #TEMP_COLUMNS
		
		SET @Column = ''''
		SET @Columns = ''''
		
		WHILE (@ColumnCount <= @ColumnMaxCount)
		BEGIN
			SET @Column = (	SELECT ''['' + ColumnName + ''] '' + is_descending_key
							FROM #TEMP_COLUMNS
							WHERE key_ordinal = @ColumnCount)

			SET @Columns =  CASE WHEN @ColumnMaxCount = 1 THEN @Column
							WHEN @ColumnMaxCount > 1 AND @ColumnMaxCount <> @ColumnCount THEN @Columns + @Column + '',''
							ELSE @Columns + @Column END
							
			SET @ColumnCount += 1		
		END
		
		IF (@Columns = '''' OR @Columns IS NULL)
		BEGIN
			GOTO SKIP_INDEX
		END
		
		SELECT 	  @TableName = [TableName]
				 ,@IndexName = [IndexName]
				 ,@allow_page_locks = [allow_page_locks]
				 ,@allow_row_locks = [allow_row_locks]
				 ,@fill_factor = [fill_factor]
				 ,@has_filter = [has_filter]
				 ,@filter_definition = [filter_definition]
				 ,@is_primary_key = [is_primary_key]
				 ,@is_unique = [is_unique]
				 ,@is_unique_constraint = [is_unique_constraint]
				 ,@type = [type]
				 ,@type_desc = [type_desc]
				 ,@is_padded = [is_padded]
				 ,@is_disabled = [is_disabled]
				 ,@ignore_dup_key = [ignore_dup_key]
		FROM #TEMP_INDEXES
		WHERE RowID = @Count
		
		IF (OBJECT_ID(@IndexName) IS NULL)
		BEGIN
			SET @options =  ''PAD_INDEX = '' + @is_padded + '', ''
			SET @options += ''ALLOW_ROW_LOCKS = '' + @allow_row_locks + '', ''
			SET @options += ''ALLOW_PAGE_LOCKS = '' + @allow_page_locks + '', ''
			SET @options += ''IGNORE_DUP_KEY = '' + @ignore_dup_key + '', ''
			SET @options += CASE WHEN @fill_factor = 0 THEN ''FILLFACTOR = '' + ''100'' ELSE ''FILLFACTOR = '' + CAST(@fill_factor AS NVARCHAR(3)) END
			
			IF (@type_desc = ''CLUSTERED'')
			BEGIN
				IF (@is_primary_key = 1)
				BEGIN
					SET @SQL = ''ALTER TABLE '' + @TableName + '' ADD CONSTRAINT '' + @IndexName + '' PRIMARY KEY CLUSTERED ( '' + @columns + '' ) WITH ( '' +  @options + '' )''
				END
				ELSE
				BEGIN
					IF (@is_unique = 1 AND @is_unique_constraint = 0)
					BEGIN
						SET @SQL = ''CREATE UNIQUE CLUSTERED INDEX '' + @IndexName + '' ON '' + @TableName + '' ( '' + @columns + '' ) WITH ( '' + @options + '' )''
					END
					ELSE IF (@is_unique_constraint = 1)
					BEGIN
						SET @SQL = ''ALTER TABLE '' + @TableName + '' ADD CONSTRAINT '' + @IndexName + '' UNIQUE CLUSTERED ( '' + @columns + '' ) WITH ( '' + @options + '' )''
					END
					ELSE
					BEGIN
						SET @SQL = ''CREATE CLUSTERED INDEX '' + @IndexName + '' ON '' + @TableName + '' ( '' + @columns + '' ) WITH ( '' + @options + '' )''
					END
				END
			END
			ELSE IF (@type_desc = ''NONCLUSTERED'')
			BEGIN
				IF (@is_primary_key = 1)
				BEGIN
					SET @SQL = ''ALTER TABLE '' + @TableName + '' ADD CONSTRAINT '' + @IndexName + '' PRIMARY KEY NONCLUSTERED ( '' + @columns + '' ) WITH ( '' + @options + '' )'' 
				END
				ELSE
				BEGIN
					IF (OBJECT_ID(''tempdb..#TEMP_INCLUDED_COLUMNS'') IS  NOT NULL)
					BEGIN
						DROP TABLE #TEMP_INCLUDED_COLUMNS
					END
					
					SELECT	 IDENTITY(INT,1,1) AS RowID
							,ColumnName
					INTO #TEMP_INCLUDED_COLUMNS
					FROM sys.tables tbl
					JOIN sys.columns col ON col.object_id = tbl.object_id
					JOIN dbo.TEMP_INDEXES_@TableName@ tupc ON tupc.ColumnName = col.name
					WHERE tbl.name = @TableName
						AND tupc.IndexName = @IndexName
						AND tupc.is_included_column = 1
					
					SELECT @ColumnCount = 1, @ColumnMaxCount = COUNT(*)
					FROM #TEMP_INCLUDED_COLUMNS
					
					SET @IncludedColumn = ''''
					SET @IncludedColumns = ''''

					WHILE (@ColumnCount <= @ColumnMaxCount)
					BEGIN
						SET @IncludedColumn = (	SELECT ''['' + ColumnName + '']''
												FROM #TEMP_INCLUDED_COLUMNS
												WHERE RowID = @ColumnCount)

						SET @IncludedColumns =  CASE WHEN @ColumnMaxCount = 1 THEN @IncludedColumn
												WHEN @ColumnMaxCount > 1 AND @ColumnMaxCount <> @ColumnCount THEN @IncludedColumns + @IncludedColumn + '',''
												ELSE @IncludedColumns + @IncludedColumn END

						SET @ColumnCount += 1
					END
					
					IF (@is_unique = 1 AND @is_unique_constraint = 0)
					BEGIN
						IF (@has_filter = 1)
						BEGIN
							SET @filter_definition = '' WHERE '' + @filter_definition
							
							IF (@IncludedColumns = '''' OR @IncludedColumns IS NULL)
							BEGIN
								SET @SQL = ''CREATE UNIQUE NONCLUSTERED INDEX '' + @IndexName + '' ON '' + @TableName + '' ( '' + @columns + '' ) '' + @filter_definition + '' WITH ( '' + @options + '' )'' 
							END
							ELSE
							BEGIN
								SET @SQL = ''CREATE UNIQUE NONCLUSTERED INDEX '' + @IndexName + '' ON '' + @TableName + '' ( '' + @columns + '' ) INCLUDE ( '' + @IncludedColumns + '' ) '' + @filter_definition + '' WITH ( '' + @options + '' )'' 
							END
						END
						ELSE
						BEGIN
							IF (@IncludedColumns = '''' OR @IncludedColumns IS NULL)
							BEGIN
								SET @SQL = ''CREATE UNIQUE NONCLUSTERED INDEX '' + @IndexName + '' ON '' + @TableName + '' ( '' + @columns + '' ) WITH ( '' + @options + '' )'' 
							END
							ELSE
							BEGIN
								SET @SQL = ''CREATE UNIQUE NONCLUSTERED INDEX '' + @IndexName + '' ON '' + @TableName + '' ( '' + @columns + '' ) INCLUDE ( '' + @IncludedColumns + '' ) WITH ( '' + @options + '' )'' 
							END
						END
					END
					ELSE IF (@is_unique_constraint = 1)
					BEGIN
						IF (@IncludedColumns = '''' OR @IncludedColumns IS NULL)
						BEGIN
							SET @SQL = ''ALTER TABLE '' + @TableName + '' ADD CONSTRAINT '' + @IndexName + '' UNIQUE NONCLUSTERED ( '' + @columns + '' ) WITH ( '' + @options + '' )''
						END
						ELSE
						BEGIN
							SET @SQL = ''ALTER TABLE '' + @TableName + '' ADD CONSTRAINT '' + @IndexName + '' UNIQUE NONCLUSTERED ( '' + @columns + '' ) INCLUDE ( '' + @IncludedColumns + '' ) WITH ( '' + @options + '' )''
						END
					END
					ELSE
					BEGIN
						IF (@has_filter = 1)
						BEGIN
							SET @filter_definition = '' WHERE '' + @filter_definition
							
							IF (@IncludedColumns = '''' OR @IncludedColumns IS NULL)
							BEGIN
								SET @SQL = ''CREATE NONCLUSTERED INDEX '' + @IndexName + '' ON '' + @TableName + '' ('' + @columns + '') '' + @filter_definition + '' WITH ( '' + @options + '' )''
							END
							ELSE
							BEGIN
								SET @SQL = ''CREATE NONCLUSTERED INDEX '' + @IndexName + '' ON '' + @TableName + '' ('' + @columns + '') INCLUDE ( '' + @IncludedColumns + '' ) '' + @filter_definition + '' WITH ( '' + @options + '' )''
							END
						END
						ELSE
						BEGIN
							IF (@IncludedColumns = '''' OR @IncludedColumns IS NULL)
							BEGIN
								SET @SQL = ''CREATE NONCLUSTERED INDEX '' + @IndexName + '' ON '' + @TableName + '' ('' + @columns + '') WITH ( '' + @options + '' )''
							END
							ELSE
							BEGIN
								SET @SQL = ''CREATE NONCLUSTERED INDEX '' + @IndexName + '' ON '' + @TableName + '' ('' + @columns + '') INCLUDE ( '' + @IncludedColumns + '' ) WITH ( '' + @options + '' )''
							END
						END
					END
				END
			END
		END
		
		
		BEGIN TRY
		EXEC sp_executesql @SQL
		END TRY
		BEGIN CATCH
			PRINT ''INDEX '' + @IndexName + '' ON TABLE '' + @TableName + '' ALREADY EXISTS OR ERRORED WHEN BEING CREATED''
		END CATCH
		
		SKIP_INDEX:
		
		SET @SQL = ''''
		SET @Count += 1
	END','@TableName@',@TableName)

	SET @SQL = @DatabaseSQL + @SQL

	EXEC sp_executesql @SQL
	
	SET @SQL = REPLACE('IF (OBJECT_ID(''dbo.TEMP_INDEXES_@TableName@'') IS NOT NULL) BEGIN DROP TABLE dbo.TEMP_INDEXES_@TableName@ END;','@TableName@',@TableName)
	
	SET @SQL = @DatabaseSQL + @SQL
	
	
	EXEC sp_executesql @SQL

	GOTO SUCCESS
	
	DATABASE_NAME_ERROR:
	RAISERROR('DATABASE %s DOES NOT EXIST ON THE SERVER.',16,1,@DatabaseName)
	
	DATABASE_TABLENAME_ERROR:
	RAISERROR('DATABASE %s DOES NOT EXIST ON THE SERVER.',16,1,@TableName)
	
	SUCCESS:
	PRINT 'INDEXES FOR TABLE ' + @TableName + ' HAVE BEEN CREATED'
	
	SET NOCOUNT OFF
END
GO
/****** Object:  StoredProcedure [dbo].[usp_DBARebuildIndexes]    Script Date: 12/24/2019 7:32:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  StoredProcedure [dbo].[usp_DBARebuildIndexes]    Script Date: 06/30/2014 10:46:44 ******/
	CREATE PROCEDURE [dbo].[usp_DBARebuildIndexes] 
	( 
		 @ReadOnly BIT = 0
		,@TableName varchar(200) = NULL
		,@IndexName varchar(200) = NULL
		,@MaxFrag DECIMAL = 30.0
		,@MinDensity INT = 50
		,@EnableFullScan BIT = 1
		,@PrintParameters BIT = 1
		,@EnableOnline BIT = 0
	)
	AS 
	/*
	Name: usp_DBARebuildIndexes 
	Author: Matt Laffoon
	Description: Rebuilds indexes that are fragmented.
	Parameters: @readonly - BIT = 1 will only print what needs to be reindexed. Default is 0
				@TableName - varchar(200) = specify a single table or leave NULL to run against all tables. Defaults to NULL
				@IndexName - varchar(200) = specify a single index (requires @TableName to be populated) or leave NULL to run against all indexes on table(s). Defaults to NULL
				@MaxFrag - Decimal = Specify the maximum fragmentation percentage allowed when determining to rebuild. Defaults at 30.0
				@MinDensity - INT = Specify the minimum scan density allowed when determining what indexes to rebuild. Defaults at 50
				@EnableFullScan - BIT = 1 will perform a FULL SCAN when updating statistics. Default is 1
				@PrintParameters - BIT = 1 will print the parameters that were fed to the stored procedure for logging purposes. Default is 1
				@EnableOnline - BIT = 1 will perform online reindexing - requires SQL 2008R2 Enterprise. Default is 0
	Run On Each Database Example: EXEC sp_msforeachdb "if exists (select 1 from [?]..sysobjects where name = 'usp_DBARebuildIndexes') begin EXEC [?]..usp_DBARebuildIndexes 1 end"
	Change History:
		- 09/11/2012 - ML - Created
		- 09/14/2012 - ML - Added readonly paramater and readytorun variable check.
		- 06/07/2013 - ML - Made logging clearer that it was in read only mode. Fixed errors around different schemas.
		- 08/06/2013 - ML - Added WITH FULLSCAN to statistics update.
		- 09/26/2013 - ML - Added ability to specify a single table or a single Index. 
						  - Moved MaxFrag and MinDensity to parameters
						  - Full Scan on statistics update is configurable
						  - Cleaned up some print messages.
		- 01/27/2014 - ML - Added online reindexing for Enterprise installs
						  - Added additional workflows to check for
		- 04/10/2014 - JD - Added checking and rebuilding of partitioned indexes
	*/
	BEGIN
		
		IF (OBJECT_ID('tempdb..##TEMP_PARTITIONS') IS NOT NULL)
		BEGIN
			DROP TABLE ##TEMP_PARTITIONS
		END
		
		DECLARE @execstr VARCHAR(1500)
		DECLARE @currentDatabase VARCHAR(30)
		DECLARE @ReadyToRun BIT
		DECLARE @ProductVersion VARCHAR(4)
		DECLARE @ProductEdition VARCHAR(128)
		DECLARE @HasBlobColumn BIT
		DECLARE @EnablePartitioning BIT
		

		SELECT @ProductVersion = CASE LEFT(CAST(SERVERPROPERTY('ProductVersion') AS VARCHAR(128)),PATINDEX('%.%',CAST(SERVERPROPERTY('ProductVersion') AS VARCHAR(128)))-1)
								WHEN 8 THEN '2000'
								WHEN 9 THEN '2005'
								WHEN 10 THEN '2008'
								WHEN 11 THEN '2012'
								WHEN 12 THEN '2014'
							 END
		
		SELECT @ProductEdition = CASE SERVERPROPERTY('EngineEdition') 
								  WHEN 1 THEN 'Personal'
								  WHEN 2 THEN 'Standard'
								  WHEN 3 THEN 'Enterprise'
								  WHEN 4 THEN 'Express'
								  WHEN 5 THEN 'SQL Azure'
							END

		SELECT @currentDatabase = DB_NAME()
	    
		DECLARE @OnlineSupported BIT
		
		SELECT @OnlineSupported = CASE WHEN @ProductVersion IN ('2005','2008','2012','2014') AND @ProductEdition = 'Enterprise' THEN 1
								  ELSE 0 END
		
		
		--Check if workflows are running where applicable
		IF EXISTS ( SELECT  1
					FROM sysobjects
					WHERE name = 'tlgapplicationlaunchstatus') 
		BEGIN
			IF EXISTS 
			(
				SELECT 1
				FROM tlgapplicationlaunchstatus WITH (NOLOCK)
				WHERE workflow IN 
									(	
										 'FIFO'
										,'UPDATE_AND_VALIDATE_PRODUCTION'
										,'MXVALIDATION'
										,'MOVE_STAGING_TO_PRODUCTION'
										,'FIFO_Rollback'
										,'RULES_ENGINE'
										,'ENTRYVALIDATION'
										,'FIFO_Finalize'
										,'PostFIFO_Rollback'
										,'RULES_ENGINE'
										,'TTM DB MAINTENANCE'
										,'ZONE_TO_ZONE_IMPORT'
										,'ZONE_TO_ZONE_RECONCILIATION'
										,'ZONE_TO_ZONE_TRANSFER'
										,'SEND SOLICITATION'
										,'SEND SOLICITATION REMINDER'
										,'CLIENT IMPORT'
										,'DTS Submit'
									)
			)
			BEGIN
				SET @ReadyToRun = 0
				PRINT 'Database: ' + @currentDatabase + ' - Workflow Currently Running, Skipping'
			END
			ELSE 
			BEGIN
				SET @ReadyToRun = 1
				PRINT 'Database: ' + @currentDatabase + ' is ready to run.'
			END
		END
		ELSE
		BEGIN
			SET @ReadyToRun = 1
			PRINT 'Database: ' + @currentDatabase + ' is ready to run.'
		END
		
		--Override Options
		IF (@TableName IS NOT NULL AND @ReadyToRun = 0)
		BEGIN
			SET @ReadyToRun = 1 
			PRINT 'Database: ' + @currentDatabase + ' - Workflow Currently Running, TableName specified, Ignoring Skip Command and Running'
		END

		IF (@IndexName IS NOT NULL AND @TableName IS NULL)
		BEGIN
			SET @ReadyToRun = 0
			PRINT 'Database: ' + @currentDatabase + ' - IndexName specified with no TableName, Skipping'
		END
		
		IF (@EnableOnline = 1 AND @OnlineSupported = 1)
		BEGIN
			IF @EnableOnline = 1 AND @ReadyToRun = 0
			BEGIN
				SET @ReadyToRun = 1
				PRINT 'Database: ' + @currentDatabase + ' - Workflow Currently Running, Online ReIndexing Enabled, Ignoring Skip Command and Running'
			END
		END
		
		IF (@EnableOnline = 1 AND @OnlineSupported = 0)
		BEGIN
			SET @ReadyToRun = 0
			PRINT 'Online Indexing is Enabled but is not supported by this version and/or edition of SQL Server. Skipping...'
		END
			
		IF @ReadyToRun = 0
		BEGIN
			PRINT 'Database: ' + @currentDatabase + ' - Skipped'
		END
		ELSE 
		BEGIN
			SET NOCOUNT ON;
			DECLARE @vtablename VARCHAR(255);
			DECLARE @objectid INT;
			DECLARE @indexid INT;
			DECLARE @vindexname VARCHAR(255);
			DECLARE @frag DECIMAL;
			DECLARE @numberoftables INT;
			DECLARE @density INT;

			SELECT @numberoftables = COUNT(*) --Number of potential tables
			FROM INFORMATION_SCHEMA.TABLES
			WHERE TABLE_TYPE = 'BASE TABLE'
				AND (@TableName IS NULL OR TABLE_NAME = @TableName)
				AND TABLE_CATALOG NOT IN ( 'master', 'model', 'msdb', 'tempdb' );
									   
			PRINT '*************************************************'
			PRINT '...Running...'
			PRINT '*************************************************'
			IF @PrintParameters = 1
			BEGIN
				PRINT '...Parameters...'
				PRINT '*************************************************'
				PRINT 'MaxFrag - ' + CAST(@MaxFrag AS VARCHAR(15))
				PRINT 'MinDensity - ' + CAST(@MinDensity AS VARCHAR(15))
				PRINT 'TableName - ' + ISNULL(@TableName,'NULL')
				PRINT 'IndexName - ' + ISNULL(@IndexName,'NULL')
				PRINT 'EnableFullScan - ' + CAST(@EnableFullScan AS VARCHAR(1))
				PRINT 'ReadOnly - ' + CAST(@ReadOnly AS VARCHAR(1))
				PRINT 'EnableOnline - ' + CAST(@EnableOnline AS VARCHAR(1))
				PRINT '*************************************************'
			END
			
			IF ( @numberoftables > 0 ) 
			BEGIN
				DECLARE tables CURSOR STATIC FOR
				SELECT  '[' + TABLE_SCHEMA + '].[' + TABLE_NAME + ']'
				FROM INFORMATION_SCHEMA.TABLES
				WHERE TABLE_TYPE = 'BASE TABLE'
					AND TABLE_NAME NOT LIKE '%$%'
					AND TABLE_CATALOG NOT IN ('master','model','msdb','tempdb','distribution')
					AND TABLE_NAME NOT LIKE '''%'
					AND (@TableName IS NULL OR TABLE_NAME = @TableName)
					AND TABLE_SCHEMA IS NOT NULL

				CREATE TABLE #fraglist
				(
					 ObjectName CHAR(255) 
					,ObjectId INT 
					,IndexName CHAR(255) 
					,IndexId INT 
					,Lvl INT 
					,CountPages INT 
					,CountRows INT 
					,MinRecSize INT 
					,MaxRecSize INT 
					,AvgRecSize INT 
					,ForRecCount INT 
					,Extents INT 
					,ExtentSwitches INT 
					,AvgFreeBytes INT 
					,AvgPageDensity INT 
					,ScanDensity DECIMAL 
					,BestCount INT 
					,ActualCount INT 
					,LogicalFrag DECIMAL 
					,ExtentFrag DECIMAL
				);
				
				OPEN tables;
				
				FETCH NEXT FROM tables INTO @vtablename;

				WHILE @@FETCH_STATUS = 0 
				BEGIN
					INSERT INTO #fraglist
					EXEC( 'DBCC SHOWCONTIG (''' + @vtablename + ''') WITH FAST, TABLERESULTS, ALL_INDEXES, NO_INFOMSGS');
					UPDATE #fraglist set ObjectName = @vtablename where ObjectID = OBJECT_ID(@vtablename)
					FETCH NEXT FROM tables INTO @vtablename;
				END;
				
				CLOSE tables;
				DEALLOCATE tables;
				
				SELECT @numberoftables = COUNT(DISTINCT objectname)
				FROM #fraglist
				WHERE (LogicalFrag >= @maxfrag OR [ScanDensity] < @mindensity)
						AND CountPages > 100
						AND INDEXPROPERTY(ObjectId, IndexName, 'IndexDepth') > 0;
						
				IF @TableName IS NULL
				BEGIN
					PRINT '*************************************************'
					PRINT 'Database: ' + @currentDatabase + ' - There are '
						+ CAST(@numberoftables AS VARCHAR(4))
						+ ' tables that are fragmented or that have low scan density.'
					PRINT '*************************************************'
				END
				
				IF @TableName IS NOT NULL AND @numberoftables = 0
				BEGIN
					PRINT 'Table: ' + @TableName + ' is not fragmented and does not have a low scan density.'
				END

				DECLARE indexes CURSOR STATIC FOR
				SELECT   ObjectName 
						,ObjectId 
						,IndexId 
						,Indexname 
						,LogicalFrag 
						,ScanDensity
				FROM    #fraglist
				WHERE   ( LogicalFrag >= @maxfrag OR [ScanDensity] < @mindensity)
					AND CountPages > 100
					AND (IndexName = @IndexName OR @IndexName IS NULL)
					AND INDEXPROPERTY(ObjectId, IndexName, 'IndexDepth') > 0;
					
				OPEN indexes;
				
				FETCH NEXT FROM indexes INTO  @vtablename
											 ,@objectid
											 ,@indexid
											 ,@vindexname
											 ,@frag
											 ,@density;

				WHILE @@FETCH_STATUS = 0 
				BEGIN
					IF @readonly = 1 
					BEGIN	
						PRINT 'READONLY: Rebuilding and updating statistics for index: '
							+ RTRIM(@vtablename) + '('
							+ RTRIM(@vindexname)
							+ ') - fragmentation currently '
							+ RTRIM(CONVERT(VARCHAR(15), @frag))
							+ '% and density currently ' + CAST(@density AS VARCHAR(15))
					END
					ELSE 
					BEGIN
						PRINT 'Rebuilding and updating statistics for index: '
							+ RTRIM(@vtablename) + '('
							+ RTRIM(@vindexname)
							+ ') - fragmentation currently '
							+ RTRIM(CONVERT(VARCHAR(15), @frag))
							+ '% and density currently ' + CAST(@density AS VARCHAR(15))
								
						IF @EnableOnline = 1
						BEGIN
									
							SELECT @HasBlobColumn = CASE WHEN MAX(so.object_ID) IS NULL THEN 0 ELSE 1 END
							FROM sys.objects SO 
							INNER JOIN sys.columns SC ON SO.Object_id = SC.object_id
							INNER JOIN sys.types ST ON SC.system_type_id = ST.system_type_id 
														AND ST.name in ('text', 'ntext', 'image', 'varchar(max)', 'nvarchar(max)', 'varbinary(max)', 'xml')
							WHERE SO.name = RTRIM(@vtablename)
											
							IF @HasBlobColumn = 1
							BEGIN
								PRINT 'Table contains a BLOB data type and cannot rebuild online. Skipping this table...'
								SELECT @execstr = 'SELECT NULL'
							END
							ELSE
							BEGIN
								SELECT @execstr = 'ALTER INDEX [' + RTRIM(@vindexname) + '] ON ' + RTRIM(@vtablename) + ' REBUILD WITH ( ONLINE = ON )'
							END
						END
						ELSE
						BEGIN										
							SELECT  @execstr = 'DBCC DBREINDEX ('''
												+ RTRIM(@vtablename) + ''','
												+ RTRIM(@vindexname)
												+ ') WITH NO_INFOMSGS';
						END
						
						PRINT @execstr 
						EXEC (@execstr);
						
						IF @EnableFullScan = 1
						BEGIN
							SELECT  @execstr = 'UPDATE STATISTICS '
												+ RTRIM(@vtablename) + '('
												+ RTRIM(@vindexname) + ') WITH FULLSCAN'
						END
						ELSE
						BEGIN
							SELECT  @execstr = 'UPDATE STATISTICS '
												+ RTRIM(@vtablename) + '('
												+ RTRIM(@vindexname) + ')'									
						END
						PRINT @execstr                                            
						EXEC (@execstr);
					END
					FETCH NEXT FROM indexes INTO 	 @vtablename
													,@objectid
													,@indexid
													,@vindexname
													,@frag
													,@density;
				END;
				
				CLOSE indexes;
				DEALLOCATE indexes;
				
				DROP TABLE #fraglist;
			END
			
			IF (@ProductVersion IN ('2008','2012','2014') AND @ProductEdition = 'Enterprise')
			BEGIN
				DECLARE @vpartitionnumber VARCHAR(10)
				
				CREATE TABLE ##TEMP_PARTITIONS
				(
					 TableName VARCHAR(128)
					,IndexName VARCHAR(128)
					,PartitionNumber VARCHAR(10)
					,FragmentationPercentage DECIMAL(28,2)
				)
				
				SET @execstr = '
								DECLARE @DBID INT
								SET @DBID = DB_ID(DB_NAME())
								
								INSERT INTO ##TEMP_PARTITIONS
								SELECT DISTINCT OBJECT_NAME(ps.OBJECT_ID) AS TableName
												,i.name AS IndexName
												,CAST(ps.partition_number AS VARCHAR(10)) AS PartitionNumber
												,CAST(ps.avg_fragmentation_in_percent AS DECIMAL(28,2)) AS FragmentationPercentage
								FROM sys.dm_db_index_physical_stats(@DBID,NULL,NULL,NULL,' + '''' + 'DETAILED' + '''' + ') ps
								JOIN sys.indexes i ON i.object_id = ps.object_id AND i.index_id = ps.index_id
								WHERE avg_fragmentation_in_percent > 30
									AND ps.OBJECT_ID IN (	SELECT DISTINCT object_id
															FROM sys.partitions 
															GROUP BY object_id, index_id
															HAVING COUNT(*) > 1)'
				
				EXEC(@execstr)
				
				SELECT @EnablePartitioning = CASE WHEN (SELECT COUNT(*)
														FROM ##TEMP_PARTITIONS) > 0 THEN 1 
												  ELSE 0 
											 END
				
				IF @EnablePartitioning = 1
				BEGIN
					PRINT ''
					PRINT '*************************************************'
					PRINT ' Partitioning is enable and any fragmented indexes will be rebuilt'
					PRINT '*************************************************'
					PRINT ''
					
					DECLARE cur_partitions CURSOR STATIC FOR 
					SELECT TableName, IndexName, PartitionNumber, FragmentationPercentage
					FROM ##TEMP_PARTITIONS
					
					OPEN cur_partitions
					
					FETCH NEXT FROM cur_partitions INTO @vtablename, @vindexname, @vpartitionnumber, @frag
					
					WHILE (@@FETCH_STATUS = 0)
					BEGIN
												
						SELECT @execstr = 'ALTER INDEX [' + RTRIM(@vindexname) + '] ON ' + RTRIM(@vtablename) + ' REBUILD Partition = ' + RTRIM(@vpartitionnumber)
						
						IF (@ReadOnly = 1)
						BEGIN
							PRINT @execstr
							
							PRINT 'READONLY: Rebuilding and updating statistics for index: '
								+ RTRIM(@vtablename) + '('
								+ RTRIM(@vindexname)
								+ ') - fragmentation currently '
								+ RTRIM(CONVERT(VARCHAR(15), @frag))
						END
						ELSE
						BEGIN
							PRINT @execstr
							
							PRINT 'Rebuilding and updating statistics for index: '
								+ RTRIM(@vtablename) + '('
								+ RTRIM(@vindexname)
								+ ') - fragmentation currently '
								+ RTRIM(CONVERT(VARCHAR(15), @frag))
								
							EXEC(@execstr)
						
							IF @EnableFullScan = 1
							BEGIN
								SELECT  @execstr = 'UPDATE STATISTICS '
													+ RTRIM(@vtablename) + '('
													+ RTRIM(@vindexname) + ') WITH FULLSCAN'
							END
							ELSE
							BEGIN
								SELECT  @execstr = 'UPDATE STATISTICS '
													+ RTRIM(@vtablename) + '('
													+ RTRIM(@vindexname) + ')'									
							END
								EXEC (@execstr)
						END
		
						FETCH NEXT FROM cur_partitions INTO @vtablename, @vindexname, @vpartitionnumber, @frag
					END
					
					CLOSE cur_partitions
					DEALLOCATE cur_partitions
					
					IF (OBJECT_ID('tempdb..##TEMP_PARTITION_TABLES') IS NOT NULL)
					BEGIN
						DROP TABLE ##TEMP_PARTITIONS
					END
				END
			END
		END
	END
