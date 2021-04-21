USE [ipmaster]
GO

/****** Object:  StoredProcedure [dbo].[usp_ChangeTrackingCaptureChanges]    Script Date: 9/21/2020 5:18:22 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

if (select top 1 1 from sys.procedures where name='usp_ChangeTrackingCaptureChanges') = 1
	begin
	print('Dropping '+'usp_ChangeTrackingCaptureChanges')
	drop procedure [usp_ChangeTrackingCaptureChanges]
	end
else
	begin
	print('No drop needed for '+'usp_ChangeTrackingCaptureChanges')
	end
	;
GO

CREATE PROCEDURE [dbo].[usp_ChangeTrackingCaptureChanges]
	(
	 @PartnerID@ INT
	,@TableName@ VARCHAR(255)
	,@BatchSize@ INT
	,@NewSync@ BIGINT OUT
	,@BatchCount@ INT OUT
	,@DestinationTable@ VARCHAR(255) OUT
	)
AS BEGIN /*
Name: usp_ChangeTrackingCaptureChanges 
Author: Matt Laffoon
Description: Loads changed data into global temp table and returns the name of the table.
Parameters: 
		@PartnerID@ - INT = Must provide PartnerID that matches tmfDefaults
		@TableName@ - VARCHAR(255) = Specify a single table
		@BatchSize@ - INT = The number of records to put into a single batch
Output Parameters:
		@NewSync@ - BIGINT = The ttdChangeTracking.SYS_CHANGE_VERSION at the time of running this SP
		@BatchCount@ - INT = The number of batches
		@DestinationTable@ - VARCHAR(255) = The name of the tempdb extract table
Returns:
		## - Success = Number of rows affected
		 0 - Warning = Zero rows affected
		-1 - Error   = Invalid PartnerID
		-2 - Error   = Table X does not have Change Tracking enabled
		-3 - Error   = Table X is turned off (ttdChangeTracking.status = -1, 0)
		-4 - Error   = Table X was previously out-of-sync (ttdChangeTracking.status = 2)
		-5 - Error   = Table X has become out-of-sync (ttdChangeTracking.status = 2)
		-9 - FATAL   = An uncaught exception occurred
Change History:
		- 02/11/2014 - ML - Released for Unit Testing
		- 04/17/2014 - ML - Checked In
		- 08/28/2014 - ML - Added Snapshot Isolation
		- 10/27/2014 - ARS - Works with @PartnerID@@ in table names
		- 04/13/2015 - ARS - Trims table names, in case people don't trim their tablenames
		- 03/02/2016 - ARS - Adjusting inserts so DBAs can remove nullability on LastSuccess/LastFailure
		- 04/26/2016 - ARS - Trimming did not work; I have to use DATALENGTH so it counts a trailing space
		- 08/11/2016 - ARS - Rewrote most of the stored procedure:
				1) All variables have a starting and ending @ because of find & replace collisions with @TableName and @TableNameWithPartnerID
				2) The data extract table adds a BatchNum column, and an index if there are multiple batches
				3) Removed @Output@ and added @NewSync@ and @BatchCount@
				4) All error handling has been moved to the top of the SP
				5) Return statements will specify an error code, instead of always being -1 and returning the error text for parsing
				6) All updates (on success/failure) to ttdChangeTracking will be done by PTI, not the SP
		- 12/01/2016 - ML - Fixed issue where DELETE operations were getting skipped by fixing the join to the changetable.
		- 02/13/2017 - PTI Team - Remove NO LOCK FROM LINE: LEFT OUTER JOIN [dbo].[' + @TableNameWithPartnerID@ + '] d
*/
SET TRANSACTION ISOLATION LEVEL SNAPSHOT

/************\
 *   INIT   *
\************/

-- We're having issues with TableNames with leading & trailing spaces
-- TODO: Eliminate this being a problem in general, not correct it here
IF (DATALENGTH(@TableName@) <> DATALENGTH(LTRIM(RTRIM(@TableName@))))
BEGIN
	-- Correct it for the future
	UPDATE ttdChangeTracking
		SET TableName = LTRIM(RTRIM(TableName))
	WHERE PartnerID = @PartnerID@
		AND TableName = @TableName@
	
	-- Correct it for the present
	SET @TableName@ = LTRIM(RTRIM(@TableName@))
END

-- Variables
DECLARE @TableNameWithPartnerID@ varchar(255) = REPLACE(@TableName@, '@PartnerID@', @PartnerID@)
DECLARE @Join@ VARCHAR(MAX), @Select@ VARCHAR(MAX)
DECLARE @pkeyName@ varchar(255), @pkeyType@ varchar(255)
DECLARE @sql@ NVARCHAR(MAX)
DECLARE @OldSync@ bigint
DECLARE @ResultCount@ int

SET @NewSync@ = -1
SET @BatchCount@ = -1
SET @DestinationTable@ = '##'
		+ CAST(@PartnerID@ AS VARCHAR(10))
		+ @TableName@
		+ REPLACE(REPLACE(REPLACE(REPLACE(CAST(SYSDATETIME() AS VARCHAR(50)), '-', ''), ' ', ''), ':', ''), '.', '')


/**********************\
 *   Error Checking   *
\**********************/

-- Is the PartnerID correct?
IF NOT EXISTS (
	SELECT TOP(1) 1
	FROM dbo.tmfDefaults WITH (NOLOCK)
	WHERE PartnerID = @PartnerID@
) RETURN -1

-- Is Change Tracking enabled?
IF NOT EXISTS (
	SELECT TOP(1) 1
	FROM sys.change_tracking_tables
	WHERE object_id = OBJECT_ID(@TableNameWithPartnerID@)
) RETURN -2

-- Is there a record in ttdChangeTracking?
-- NOTE: This is how DBAs insert records to ttdChangeTracking, they call the SP by itself
IF NOT EXISTS (
	SELECT TOP(1) 1
	FROM dbo.ttdChangeTracking WITH (NOLOCK)
	WHERE PartnerID = @PartnerID@
		AND TableName = @TableName@
) BEGIN
	INSERT INTO dbo.ttdChangeTracking (
		PartnerID, CreateDate, TableName, Status, SYS_CHANGE_VERSION,
		LastSuccess, LastFailure, LastUpdated, PushType, IsStandard,
		ResyncScript, DeletedFlag, KeepDuringRollback
	) VALUES (
		@PartnerID@, GETDATE(), @TableName@, 0, ISNULL(CHANGE_TRACKING_CURRENT_VERSION(), 0),
		'1900-01-01', '1900-01-01', '1900-01-01', -1, '?',
		NULL, 'N', 'N'
	)
END

-- Is PTI turned off?
If EXISTS(
	SELECT TOP(1) 1
	FROM dbo.ttdChangeTracking WITH (NOLOCK)
	WHERE PartnerID = @PartnerID@
		AND TableName = @TableName@
		AND Status IN (-1, 0, 3)
) RETURN -3

-- Is PTI currently out-of-sync?
If EXISTS(
	SELECT TOP(1) 1
	FROM dbo.ttdChangeTracking WITH (NOLOCK)
	WHERE PartnerID = @PartnerID@
		AND TableName = @TableName@
		AND Status IN (2)
) RETURN -4

-- Is Change Tracking still in sync?
IF EXISTS (
	SELECT TOP(1) 1
	FROM ttdChangeTracking WITH (NOLOCK)
	WHERE PartnerID = @PartnerID@
		AND TableName = @TableName@
		AND SYS_CHANGE_VERSION < change_tracking_min_valid_version(OBJECT_ID(@TableNameWithPartnerID@))
) RETURN -5


/***********************\
 *   Grab PK Columns   *
\***********************/

-- Create the cursor
DECLARE pkeys CURSOR
FOR
	SELECT cc.Column_Name As ColumnName--,
		-- NOTE: We're using a SELECT INTO, not a CREATE TABLE; INSERT INTO, so we don't need this; but it does work...
		--CASE
		--	-- Precision and scale
		--	WHEN col.DATA_TYPE IN ('decimal', 'numeric')
		--		THEN col.DATA_TYPE + '(' + CAST(col.NUMERIC_PRECISION AS varchar(10)) + ', ' + CAST(col.NUMERIC_SCALE AS varchar(10)) + ')'
		--	-- Precision only
		--	WHEN col.DATA_TYPE IN ('float')
		--		THEN col.DATA_TYPE + '(' + CAST(col.NUMERIC_PRECISION AS varchar(10)) + ')'
		--	-- Length
		--	WHEN col.DATA_TYPE IN ('char', 'varchar', 'nchar', 'nvarchar', 'binary', 'varbinary')
		--		THEN col.DATA_TYPE + '(' + CASE WHEN col.CHARACTER_MAXIMUM_LENGTH = -1 THEN 'MAX' ELSE CAST(col.CHARACTER_MAXIMUM_LENGTH AS varchar(10)) END + ')'
		--	-- No modifiers
		--	WHEN col.DATA_TYPE IN ( -- NOTE: text, ntest, image, geometry, geography, and xml cannot be PK columns
		--			'uniqueidentifier', 'date', 'time', 'datetime2', 'datetimeoffset', 'tinyint',
		--			'smallint', 'int', 'smalldatetime', 'real', 'money', 'datetime', 'sql_variant',
		--			'bit', 'smallmoney', 'bigint', 'hierarchyid', 'timestamp', 'sysname')
		--		THEN col.DATA_TYPE
		--	-- What happened? Try nvarchar(MAX) and see what happens
		--	ELSE 'nvarchar(MAX)'
		--END As ColumnDefinition
	FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS tc
	INNER JOIN INFORMATION_SCHEMA.CONSTRAINT_COLUMN_USAGE cc
		ON tc.TABLE_CATALOG = cc.TABLE_CATALOG
		AND tc.TABLE_SCHEMA = cc.TABLE_SCHEMA
		AND tc.TABLE_NAME = cc.TABLE_NAME
		AND tc.CONSTRAINT_NAME = cc.CONSTRAINT_NAME
	INNER JOIN INFORMATION_SCHEMA.COLUMNS col
		ON cc.TABLE_CATALOG = col.TABLE_CATALOG
		AND cc.TABLE_SCHEMA = col.TABLE_SCHEMA
		AND cc.TABLE_NAME = col.TABLE_NAME
		AND cc.COLUMN_NAME = col.COLUMN_NAME
	WHERE tc.Constraint_Type = 'PRIMARY KEY'
		AND tc.TABLE_NAME = @TableNameWithPartnerID@

OPEN pkeys
FETCH NEXT FROM pkeys INTO @pkeyName@

-- For each ColumnName, build the SELECT & JOIN statements
WHILE @@FETCH_STATUS=0
BEGIN
	SELECT
		@Select@ = ISNULL(@Select@ + ', ', '') + 't.[' + @pkeyName@ + '] AS [PK_' + @pkeyName@ + ']',
		@Join@ = ISNULL(@Join@ + ' AND ', '') + 't.[' + @pkeyName@ + '] = d.[' + @pkeyName@ + ']'

	FETCH NEXT FROM pkeys INTO @pkeyName@
END

-- Clean up
CLOSE pkeys
DEALLOCATE pkeys

/***************************\
 *   Extract the PK Data   *
\***************************/

SET @OldSync@ = (
	SELECT SYS_CHANGE_VERSION
	FROM ttdChangeTracking WITH (NOLOCK)
	WHERE PartnerID = @PartnerID@
		AND TableName = @TableName@
)

-- Extract the data into a temp table
SET @sql@ = N''
	+ ' SET @NewSync@ = CHANGE_TRACKING_CURRENT_VERSION()'
	+ ' '
	+ ' SELECT CAST((ROW_NUMBER() OVER(ORDER BY SYS_CHANGE_VERSION) - 1) / @BatchSize@ AS INT) + 1 As PTI_BatchNum, ''' + @TableName@ + ''' AS PTI_TableName, ' + @select@ + ', t.SYS_CHANGE_OPERATION AS PTI_SYS_CHANGE_OPERATION, d.*'
	+ ' INTO [dbo].[' + @DestinationTable@ + ']'
	+ ' FROM CHANGETABLE(CHANGES ['
	+ @TableNameWithPartnerID@ + '], @OldSync@) as t'
	+ ' LEFT OUTER JOIN [dbo].[' + @TableNameWithPartnerID@ + '] d '
		+ ' ON ' + @Join@ + ' AND d.PartnerID = @PartnerID@'
	+ ' '
	+ ' SET @ResultCount@ = @@ROWCOUNT'
	+ ' '
	+ ' IF @ResultCount@ > @BatchSize@'
	+ '		CREATE INDEX [IX_' + @DestinationTable@ + '] ON [' + @DestinationTable@ + '] (PTI_BatchNum)'

BEGIN TRY
	EXEC sp_executesql @sql@,
		N'@PartnerID@ int, @BatchSize@ int, @OldSync@ bigint, @NewSync@ bigint OUT, @ResultCount@ int OUT',
		-- IN Parameters
		@PartnerID@ = @PartnerID@,
		@BatchSize@ = @BatchSize@,
		@OldSync@ = @OldSync@,
		-- OUT Parameters
		@NewSync@ = @NewSync@ OUT,
		@ResultCount@ = @ResultCount@ OUT
	
	SET @BatchCount@ = (CAST((@ResultCount@ - 1) / @BatchSize@ AS INT) + 1)
	
	RETURN @ResultCount@
END TRY
BEGIN CATCH
	SELECT N'ERROR (' + CAST(ERROR_NUMBER() AS VARCHAR(MAX)) + ', ' + CAST(ERROR_SEVERITY() AS VARCHAR(MAX)) + ', ' + CAST(ERROR_STATE() AS VARCHAR(MAX)) + '): ' + ERROR_MESSAGE()
	
	RETURN -9
END CATCH

-- NOTE: We still need to update ttdChangeTracking [Status, SYS_CHANGE_VERSION, LastUpdated, LastSuccess, LastFailure],
--       but those will be handled by the PTI service code, not this stored procedure

END

GO


USE [ipmaster]
GO

/****** Object:  StoredProcedure [dbo].[usp_ChangeTrackingTableList]    Script Date: 9/21/2020 5:20:53 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO






if (select top 1 1 from sys.procedures where name='usp_ChangeTrackingTableList') = 1
	begin
	print('Dropping '+'usp_ChangeTrackingTableList')
	drop procedure usp_ChangeTrackingTableList
	end
else
	begin
	print('No drop needed for '+'usp_ChangeTrackingTableList')
	end
	;

	go


CREATE PROCEDURE [dbo].[usp_ChangeTrackingTableList] (@PartnerID INT)
AS /*
Name: usp_ChangeTrackingTableList 
Author: Matt Laffoon
Description: Provides a list of tables that have changes since last extract.
Parameters: 
			@PartnerID - INT = Must provide PartnerID that matches tmfDefaults
Output Parameters:			
Returns:
			Returns -1 on fatal error
Change History:
			- 02/11/2014 - ML - Released for Unit Testing
			- 04/17/2014 - ML - Checked In
			- 08/28/2014 - ML - Added Snapshot Isolation
			- 10/27/2014 - ARS - Works with @PartnerId@ in table names
			- 03/30/2015 - ARS - Due to aggressive cleanup, we need to update SYS_CHANGE_VERSION each time we check a table.
			- 02/16/2017 - ML - Changed when we update SYS_CHANGE_VERSION to fix the bug of missing tables if they occurred in a race condition.
*/
	SET TRANSACTION ISOLATION LEVEL SNAPSHOT
	
	DECLARE @TableName VARCHAR(255)
	DECLARE @SQL NVARCHAR(MAX)
	DECLARE @SyncVersion INT
	DECLARE @DBPartnerID INT
	
	SET @TableName = ''
	
	IF NOT EXISTS ( SELECT
							1
						FROM
							dbo.tmfDefaults td
						WHERE
							PartnerID = @PartnerID )
		BEGIN
	
			SELECT
					@DBPartnerID = MAX(PartnerID)
				FROM
					dbo.tmfDefaults td		
	
			SELECT
					'Invalid PartnerID Provided - PartnerID provided: '
					+ CAST(@PartnerID AS VARCHAR(10))
					+ ' - PartnerID in Database: '
					+ CAST(@DBPartnerID AS VARCHAR(10))
			RETURN - 1
		END

	ELSE
		BEGIN

			SELECT
					TableName
				,	SYS_CHANGE_VERSION
				,	0 AS Processed
				INTO
					#TableList
				FROM
					ttdChangeTracking
				WHERE
					PartnerID = @PartnerID
					AND Status = 1
					AND SYS_CHANGE_VERSION < CHANGE_TRACKING_CURRENT_VERSION()
	
			SELECT TOP 1
					@TableName = TableName
				,	@SyncVersion = SYS_CHANGE_VERSION
				FROM
					#TableList
				WHERE
					Processed = 0
	
			CREATE TABLE #ChangedTables
				(
				 PartnerID INT
				,TableName VARCHAR(255)
				,ChangeRows INT
				)
		
			WHILE @TableName <> ''
				BEGIN
					SET @SQL = 'SELECT ' + CAST(@PartnerID AS VARCHAR(10))
						+ ' as PartnerID, ''' + @TableName
						+ ''' as TableName, COUNT(*) as ChangeRows FROM CHANGETABLE(CHANGES '
						+ REPLACE(@TableName, '@PartnerId@', @PartnerID) + ','
						+ CAST(@SyncVersion AS VARCHAR(100)) + ') AS a'
		
		
		
					BEGIN TRY
						INSERT INTO #ChangedTables
								EXEC (
									  @SQL
									)
						
						UPDATE
								#TableList
							SET	
								Processed = 1
							WHERE
								TableName = @TableName
							
						SET @TableName = ''
						
						SELECT TOP 1
								@TableName = ISNULL(TableName, '')
							,	@SyncVersion = ISNULL(SYS_CHANGE_VERSION, '')
							FROM
								#TableList
							WHERE
								Processed = 0
								

					END TRY
					BEGIN CATCH
						IF ERROR_NUMBER() = 22105
							BEGIN
								UPDATE
										dbo.ttdChangeTracking
									SET	
										LastUpdated = GETDATE()
									,	LastFailure = GETDATE()
									WHERE
										TableName = @TableName
										AND PartnerID = @PartnerID
								
								INSERT INTO #ChangedTables
										(PartnerID, TableName, ChangeRows)
									VALUES
										(@PartnerID, -- PartnerID - int
										 @TableName, -- TableName - varchar(255)
										 -1  -- ChangeRows - int
										 )
								
								UPDATE
										#TableList
									SET	
										Processed = 1
									WHERE
										TableName = @TableName
									
								SET @TableName = ''
									
								SELECT TOP 1
										@TableName = ISNULL(TableName, '')
									,	@SyncVersion = ISNULL(SYS_CHANGE_VERSION,
															  '')
									FROM
										#TableList
									WHERE
										Processed = 0
							END
						ELSE
							BEGIN
								SELECT
										ERROR_MESSAGE() AS [ERROR_MESSAGE]
								SET @TableName = ''
								RETURN - 1
							END			
					END CATCH
		
		
		
				END
	
			/* Reset any SYS_CHANGE_VERSION to the minimum valid version to prevent the table from expiring in the event nothing has changed for a long period of time */
			
			UPDATE
				ct
			SET
				SYS_CHANGE_VERSION = CHANGE_TRACKING_MIN_VALID_VERSION(OBJECT_ID(TableName))
			FROM
				ttdChangeTracking ct
			WHERE
				ct.SYS_CHANGE_VERSION < CHANGE_TRACKING_MIN_VALID_VERSION(OBJECT_ID(TableName))
				AND CHANGE_TRACKING_MIN_VALID_VERSION(OBJECT_ID(TableName)) IS NOT NULL
			
			SELECT
					PartnerID
				,	TableName
				,	ChangeRows
				FROM
					#ChangedTables
				WHERE
					ChangeRows <> 0
				ORDER BY
					ChangeRows DESC
					
			IF @@ROWCOUNT > 0
			BEGIN
			RETURN 1
			END
			
		END	


GO


USE [ipmaster]
GO

/****** Object:  StoredProcedure [dbo].[usp_CreateDefaultTTMWorkflows]    Script Date: 9/21/2020 5:22:05 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



if (select top 1 1 from sys.procedures where name='usp_CreateDefaultTTMWorkflows') = 1
	begin
	print('Dropping '+'usp_CreateDefaultTTMWorkflows')
	drop procedure [usp_CreateDefaultTTMWorkflows]
	end
else
	begin
	print('No drop needed for '+'usp_CreateDefaultTTMWorkflows')
	end
	;

	go





create procedure [dbo].[usp_CreateDefaultTTMWorkflows]
    @recordtype varchar(1),
    @workflow varchar(100) = null,
    @recreate varchar(1) = 'N'
as /*
Name:			usp_CreateDefaultTTMWorkflows
Author:			Matt DiPietro
Description:	inserts default workflow shells for TTM workflow processing

Parameters:		@recordtype - the Export RecordType for which to create the workflows
				@workflow - optional parameter.  If specified it will only create the default version of the specified workflow
				@recreate - optional parameter.  If Y, an existing version of the workflow will be deleted and recreated as the default
Change History:
                - 06/12/2013 - initial version of procedure.  Only includes the TTM_PROCESS workflow.

*/
    declare @partnerid as integer
    select @partnerid = partnerid from tmfdefaults
    
    declare @currentWorkflow as varchar(100)

    if @workflow is null or @workflow = 'PROCESS' begin
        set @currentWorkflow = 'TTM_PROCESS_' + @recordtype
        
        if @recreate = 'Y' begin
            print 'deleting workflow: ' + @currentWorkflow
            delete tlgApplicationLaunchTree where workflow = @currentWorkflow
        end
        
        if not exists (select * from tlgApplicationLaunchTree where workflow = @currentWorkflow and partnerid = @partnerid) begin
            print 'creating workflow: ' + @currentWorkflow
            insert into tlgApplicationLaunchTree
            select * from (
                select @partnerid as PartnerID, getdate() as EffDate, @currentWorkflow as Workflow, 1 as SequenceNo, 'dxdTTMWorkflowEngine' as ApplicationToLaunch, 'CLEAR MESSAGES;_' as Command, 'N' as DeletedFlag, 'N' as KeepDuringRollback
                union select @partnerid as PartnerID, getdate() as EffDate, @currentWorkflow as Workflow, 2 as SequenceNo, 'dxdTTMWorkflowEngine' as ApplicationToLaunch, 'CUSTOM SQL;after_save_sql' as Command, 'N' as DeletedFlag, 'N' as KeepDuringRollback
                union select @partnerid as PartnerID, getdate() as EffDate, @currentWorkflow as Workflow, 3 as SequenceNo, 'dxdTTMWorkflowEngine' as ApplicationToLaunch, 'VALIDATE SHIPMENT;' as Command, 'N' as DeletedFlag, 'N' as KeepDuringRollback
                union select @partnerid as PartnerID, getdate() as EffDate, @currentWorkflow as Workflow, 4 as SequenceNo, 'dxdTTMWorkflowEngine' as ApplicationToLaunch, 'PROCESS SHIPMENT;' as Command, 'N' as DeletedFlag, 'N' as KeepDuringRollback
            ) q
        end else begin
            print 'cannot create existing workflow: ' + @currentWorkflow
        end
    end
/*
    if @workflow is null or @workflow = 'SAVE' begin
        set @currentWorkflow = 'TTM_SAVE_' + @recordtype
        
        if @recreate = 'Y' begin
            print 'deleting workflow: ' + @currentWorkflow
            delete tlgApplicationLaunchTree where workflow = @currentWorkflow
        end
        
        if not exists (select * from tlgApplicationLaunchTree where workflow = @currentWorkflow and partnerid = @partnerid) begin
            print 'creating workflow: ' + @currentWorkflow
            insert into tlgApplicationLaunchTree
            select * from (
                select @partnerid as PartnerID, getdate() as EffDate, @currentWorkflow as Workflow, 1 as SequenceNo, 'dxdTTMWorkflowEngine' as ApplicationToLaunch, 'CUSTOM SQL;after_save_sql' as Command, 'N' as DeletedFlag, 'N' as KeepDuringRollback
            ) q
        end else begin
            print 'cannot create existing workflow: ' + @currentWorkflow
        end
    end
    
    if @workflow is null or @workflow = 'VALIDATE' begin
        set @currentWorkflow = 'TTM_VALIDATE_' + @recordtype
        
        if @recreate = 'Y' begin
            print 'deleting workflow: ' + @currentWorkflow
            delete tlgApplicationLaunchTree where workflow = @currentWorkflow
        end
        
        if not exists (select * from tlgApplicationLaunchTree where workflow = @currentWorkflow and partnerid = @partnerid) begin
            print 'creating workflow: ' + @currentWorkflow
            insert into tlgApplicationLaunchTree
            select * from (
                select @partnerid as PartnerID, getdate() as EffDate, @currentWorkflow as Workflow, 1 as SequenceNo, 'dxdTTMWorkflowEngine' as ApplicationToLaunch, 'CUSTOM SQL;after_save_sql' as Command, 'N' as DeletedFlag, 'N' as KeepDuringRollback
            ) q
        end else begin
            print 'cannot create existing workflow: ' + @currentWorkflow
        end
    end

    if @workflow is null or @workflow = 'PREVIEW' begin
        set @currentWorkflow = 'TTM_PREVIEW_' + @recordtype
        
        if @recreate = 'Y' begin
            print 'deleting workflow: ' + @currentWorkflow
            delete tlgApplicationLaunchTree where workflow = @currentWorkflow
        end
        
        if not exists (select * from tlgApplicationLaunchTree where workflow = @currentWorkflow and partnerid = @partnerid) begin
            print 'creating workflow: ' + @currentWorkflow
            insert into tlgApplicationLaunchTree
            select * from (
                select @partnerid as PartnerID, getdate() as EffDate, @currentWorkflow as Workflow, 1 as SequenceNo, 'dxdTTMWorkflowEngine' as ApplicationToLaunch, 'CUSTOM SQL;after_save_sql' as Command, 'N' as DeletedFlag, 'N' as KeepDuringRollback
            ) q
        end else begin
            print 'cannot create existing workflow: ' + @currentWorkflow
        end
    end

    if @workflow is null or @workflow = 'UNPROCESS' begin
        set @currentWorkflow = 'TTM_UNPROCESS_' + @recordtype
        
        if @recreate = 'Y' begin
            print 'deleting workflow: ' + @currentWorkflow
            delete tlgApplicationLaunchTree where workflow = @currentWorkflow
        end
        
        if not exists (select * from tlgApplicationLaunchTree where workflow = @currentWorkflow and partnerid = @partnerid) begin
            print 'creating workflow: ' + @currentWorkflow
            insert into tlgApplicationLaunchTree
            select * from (
                select @partnerid as PartnerID, getdate() as EffDate, @currentWorkflow as Workflow, 1 as SequenceNo, 'dxdTTMWorkflowEngine' as ApplicationToLaunch, 'CUSTOM SQL;after_save_sql' as Command, 'N' as DeletedFlag, 'N' as KeepDuringRollback
            ) q
        end else begin
            print 'cannot create existing workflow: ' + @currentWorkflow
        end
    end

    if @workflow is null or @workflow = 'FINALIZE' begin
        set @currentWorkflow = 'TTM_FINALIZE_' + @recordtype
        
        if @recreate = 'Y' begin
            print 'deleting workflow: ' + @currentWorkflow
            delete tlgApplicationLaunchTree where workflow = @currentWorkflow
        end
        
        if not exists (select * from tlgApplicationLaunchTree where workflow = @currentWorkflow and partnerid = @partnerid) begin
            print 'creating workflow: ' + @currentWorkflow
            insert into tlgApplicationLaunchTree
            select * from (
                select @partnerid as PartnerID, getdate() as EffDate, @currentWorkflow as Workflow, 1 as SequenceNo, 'dxdTTMWorkflowEngine' as ApplicationToLaunch, 'CUSTOM SQL;after_save_sql' as Command, 'N' as DeletedFlag, 'N' as KeepDuringRollback
            ) q
        end else begin
            print 'cannot create existing workflow: ' + @currentWorkflow
        end
    end

    if @workflow is null or @workflow = 'UNFINALIZE' begin
        set @currentWorkflow = 'TTM_UNFINALIZE_' + @recordtype
        
        if @recreate = 'Y' begin
            print 'deleting workflow: ' + @currentWorkflow
            delete tlgApplicationLaunchTree where workflow = @currentWorkflow
        end
        
        if not exists (select * from tlgApplicationLaunchTree where workflow = @currentWorkflow and partnerid = @partnerid) begin
            print 'creating workflow: ' + @currentWorkflow
            insert into tlgApplicationLaunchTree
            select * from (
                select @partnerid as PartnerID, getdate() as EffDate, @currentWorkflow as Workflow, 1 as SequenceNo, 'dxdTTMWorkflowEngine' as ApplicationToLaunch, 'CUSTOM SQL;after_save_sql' as Command, 'N' as DeletedFlag, 'N' as KeepDuringRollback
            ) q
        end else begin
            print 'cannot create existing workflow: ' + @currentWorkflow
        end
    end
*/

GO


USE [ipmaster]
GO

/****** Object:  StoredProcedure [dbo].[usp_DBACopyTableIndexes]    Script Date: 9/21/2020 5:22:19 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





if (select top 1 1 from sys.procedures where name='usp_DBACopyTableIndexes') = 1
	begin
	print('Dropping '+'usp_DBACopyTableIndexes')
	drop procedure usp_DBACopyTableIndexes
	end
else
	begin
	print('No drop needed for '+'usp_DBACopyTableIndexes')
	end
	;

	go



CREATE PROCEDURE [dbo].[usp_DBACopyTableIndexes]
(
	 @DatabaseName NVARCHAR(128) = NULL
	,@TableName NVARCHAR(128)
)
AS
/*
Name: usp_DBACopyTableIndexes 
Author: John DePrato
Description: Copies indexes so that when doing a table adjustment the indexes can be rebuilt against the changed schema
Parameters: @DatabaseName - NVARCHAR(128) = uses the current database context to run the database update
			@TableName - NVARCHAR(128) = specify a single table that is going to be modified
Change History:
	- 09/03/2014 - JCD - Created
    - 04/20/2016 - KDJ - Modify.  SP was not dropping the index from the table.
*/
BEGIN
	SET NOCOUNT ON
	
	DECLARE @DatabaseSQL NVARCHAR(255)
	DECLARE @SQL NVARCHAR(MAX)
	DECLARE @Parameters NVARCHAR(2000)
	
	CREATE TABLE #TEMP_ERROR_OUTPUT
	(
		ERROR INT
	)
	
	IF (@DatabaseName IS NULL OR @DatabaseName = '')
	BEGIN
		SET @DatabaseName = DB_NAME()
	END
	
	SET @SQL = 'IF EXISTS(SELECT 1 FROM ' + @DatabaseName + '.sys.tables WHERE name = ' + '''' + @TableName + '''' + ') SELECT 0 ELSE SELECT 1'
	
	PRINT @SQL
	
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

	SET @SQL = REPLACE('IF (OBJECT_ID(''dbo.TEMP_INDEXES_@TableName@'') IS NOT NULL) BEGIN DROP TABLE dbo.TEMP_INDEXES_@TableName@ END;','@TableName@',@TableName)
	SET @SQL = @DatabaseSQL + @SQL
	
	EXEC sp_executesql @SQL

	SET @SQL = REPLACE(
	'SELECT	 TBL.name AS TableName
			,IDX.name AS IndexName
			,c.name AS ColumnName
			,IC.key_ordinal
			,IC.is_descending_key
			,IC.is_included_column
			,IDX.allow_page_locks
			,IDX.allow_row_locks
			,IDX.fill_factor
			,IDX.has_filter
			,IDX.filter_definition
			,IDX.is_primary_key
			,IDX.is_unique
			,IDX.is_unique_constraint
			,IDX.type
			,IDX.type_desc
			,IDX.is_padded
			,IDX.is_disabled
			,IDX.ignore_dup_key
	INTO dbo.TEMP_INDEXES_@TableName@
	FROM sys.tables AS TBL
	INNER JOIN sys.columns AS C ON TBL.object_id = c.object_id
	INNER JOIN sys.index_columns AS IC ON IC.column_id = c.column_id AND IC.object_id = c.object_id
	INNER JOIN sys.indexes AS IDX ON IDX.index_id = IC.index_id AND IC.object_id = IDX.OBJECT_ID
	WHERE TBL.name = ' + '''' + '@TableName@' + '''','@TableName@',@TableName)
	
	SET @SQL = @DatabaseSQL + @SQL
	
	EXEC sp_executesql @SQL
	
	
	
	--/********added by kdj 04/20/2016
	
	
		
	SET @SQL = REPLACE(
			   'DECLARE @IndexName NVARCHAR(128)
				DECLARE @DFName NVARCHAR(128)
				DECLARE @StatName NVARCHAR(128)
			    DECLARE @is_primary_key BIT
				DECLARE @Count INT
			    DECLARE @MaxCount INT
			    DECLARE @SQL NVARCHAR(MAX)

				SELECT DISTINCT IDENTITY(INT,1,1) AS RowID
						,df.name AS [DFName]
						,st.name AS [TableName]
				INTO #TEMP_DF
				FROM sys.default_constraints df
				JOIN sys.columns sc ON sc.object_id = df.parent_object_id AND df.parent_column_id = sc.column_id
				JOIN sys.tables st ON st.object_id = sc.object_id
				WHERE @TableName = st.name 
					--AND @ColumnName = sc.name
			    
				SELECT @Count = 1, @MaxCount = COUNT(*)
				FROM #TEMP_DF

				WHILE (@Count <= @MaxCount)
				BEGIN
					SELECT	 @DFName = DFName
							,@TableName = TableName
					FROM #TEMP_DF
					WHERE RowID = @Count

					SET @SQL = ''ALTER TABLE ['' + @TableName + ''] DROP CONSTRAINT ['' + @DFName + '']''

					EXEC sp_executesql @SQL

					SET @Count += 1
				END

				SELECT DISTINCT IDENTITY(INT,1,1) AS RowID
								,ss.name AS [StatName]
								,st.name AS [TableName]
				INTO #TEMP_STAT
				FROM sys.stats ss
				JOIN sys.stats_columns ssc ON ssc.object_id = ss.object_id AND ssc.stats_id = ss.stats_id
				JOIN sys.columns sc ON ssc.column_id = sc.column_id AND ssc.object_id = sc.object_id
				JOIN sys.tables st ON sc.object_id = st.object_id
				WHERE NOT EXISTS (	SELECT 1 
									FROM sys.indexes si
									WHERE si.name = ss.name)
					AND @TableName = st.name 
					------AND @ColumnName = sc.name

				SELECT @Count = 1, @MaxCount = COUNT(*)
				FROM #TEMP_STAT

				WHILE (@Count <= @MaxCount)
				BEGIN
					SELECT   @StatName = StatName
							,@TableName = TableName
					FROM #TEMP_STAT
					WHERE RowID = @Count

					SET @SQL = ''DROP STATISTICS '' + @TableName + ''.'' + @StatName

					EXEC sp_executesql @SQL
					
					SET @Count += 1
				END

				SELECT IDENTITY(INT,1,1) AS RowID
						,IndexName
						,TableName
						,is_primary_key
				INTO #TEMP_RESULT
				FROM dbo.TEMP_INDEXES_@TableName@
				GROUP BY IndexName, TableName, is_primary_key
				
				SELECT @Count = 1, @MaxCount = COUNT(*)
				FROM #TEMP_RESULT
				
				WHILE (@Count <= @MaxCount)
				BEGIN
					SELECT @TableName = TableName
							,@IndexName = IndexName
							,@is_primary_key = is_primary_key
					FROM #TEMP_RESULT
					WHERE RowID = @Count
					
					IF (@is_primary_key = 1)
					BEGIN
						SET @SQL = ''ALTER TABLE ['' + @TableName + ''] DROP CONSTRAINT ['' + @IndexName + '']''
					END
					ELSE
					BEGIN
						SET @SQL = ''DROP INDEX ['' + @IndexName + ''] ON ['' + @TableName + '']''
					END
					
					EXEC sp_executesql @SQL
					
					SET @Count += 1
				END','@TableName@',@TableName)
	
	SET @Parameters = '@TableName NVARCHAR(128)'

	EXEC sp_executesql @SQL, @Parameters, @TableName
	
	
	
	
	
	---added by kdj 04/20/2016**********/
	GOTO SUCCESS
	
	DATABASE_NAME_ERROR:
	RAISERROR('DATABASE %s DOES NOT EXIST ON THE SERVER.',16,1,@DatabaseName)
	
	DATABASE_TABLENAME_ERROR:
	RAISERROR('TABLE NAME %s DOES NOT EXIST ON THE SERVER.',16,1,@TableName)
	
	SUCCESS:
	PRINT 'INDEXES FOR TABLE ' + @TableName + ' HAVE BEEN SAVED'
	
	SET NOCOUNT OFF
END

GO


USE [ipmaster]
GO

/****** Object:  StoredProcedure [dbo].[usp_DBACopyTableIndexesByColumn]    Script Date: 9/21/2020 5:22:27 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

if (select top 1 1 from sys.procedures where name='usp_DBACopyTableIndexesByColumn') = 1
	begin
	print('Dropping '+'usp_DBACopyTableIndexesByColumn')
	drop procedure usp_DBACopyTableIndexesByColumn
	end
else
	begin
	print('No drop needed for '+'usp_DBACopyTableIndexesByColumn')
	end
	;

	go

CREATE PROCEDURE [dbo].[usp_DBACopyTableIndexesByColumn]
(
	 @DatabaseName NVARCHAR(128) = NULL
	,@TableName NVARCHAR(128)
	,@ColumnName NVARCHAR(128)
	,@ColumnType NVARCHAR(128)
	,@ForceCopy BIT = 0
	,@ColumnLength INT = NULL
	,@ColumnScale INT = NULL
	,@ColumnPrecision INT = NULL
)
AS
/*
Name: usp_DBACopyTableIndexesByColumn
Author: John DePrato
Description: Copies indexes of the affected column so that when doing a table adjustment the indexes can be rebuilt against the changed schema
Parameters: @DatabaseName - NVARCHAR(128) = uses the current database context to run the database update
			@TableName - NVARCHAR(128) = specify a single table that is going to be modified
			@ColumnName - NVARCHAR(128) = name of the column that will be modified
			@ColumnType - NVARCHAR(128) = column type that of the defined column name
			@ForceCopy - BIT - Regardless of the requirements for determining if a copy of the index 
							   should be made or not, the index will be copied and then dropped
			@ColumnLength - INT = the length of the column if applicable to the column type defined
			@ColumnScale - INT = the column scale if needed i.e. DECIMAL(scale,precision)
			@ColumnPrecision - INT = the column precision if needed i.e. DECIMAL(scale,precision)
Change History:
	- 09/13/2014 - JCD - Created
	- 01/07/2015 - JCD - Add the ability to drop statistics and default constraints
*/
BEGIN
	SET NOCOUNT ON
	
	DECLARE @DatabaseSQL NVARCHAR(255)
	DECLARE @TableCheckSQL NVARCHAR(MAX)
	DECLARE @ColumnCheckSQL NVARCHAR(MAX)
	DECLARE @SQL NVARCHAR(MAX)
	DECLARE @Parameters NVARCHAR(2000)
	
	IF (@ColumnType IN ('decimal','numeric','money','smallmoney') AND (@ColumnScale IS NULL OR @ColumnPrecision IS NULL))
	BEGIN
		GOTO SCALE_PARAMETER_ERROR
	END
	
	IF (@ColumnType NOT IN ('decimal','numeric','money','smallmoney',
							'tinyint','small','int','bigint','bit','text',
							'ntext','date','datetimeoffset','datetime2',
							'smalldatetime','datetime','time','uniqueidentifier'
							,'image','timestamp','xml') AND (@ColumnLength IS NULL OR @ColumnLength < 1)
														AND @ForceCopy = 0)
	BEGIN
		GOTO PARAMETER_ERROR
	END
	
	CREATE TABLE #TEMP_ERROR_OUTPUT
	(
		ERROR INT
	)
	
	IF (@DatabaseName IS NULL OR @DatabaseName = '')
	BEGIN
		SET @DatabaseName = DB_NAME()
	END
	
	SET @TableCheckSQL = 'IF EXISTS(SELECT 1 FROM ' + @DatabaseName + '.sys.tables WHERE name = ' + '''' + @TableName + '''' + ') SELECT 0 ELSE SELECT 1'

	SET @ColumnCheckSQL = 'IF EXISTS(SELECT 1 FROM ' + @DatabaseName + '.sys.tables st JOIN sys.columns sc ON st.object_id = sc.object_id WHERE st.name = ' + '''' + @TableName + '''' + ' AND sc.name = ' + '''' + @ColumnName + '''' + ') SELECT 0 ELSE SELECT 1'
	
	--PRINT @SQL
	
	INSERT INTO #TEMP_ERROR_OUTPUT
	EXEC sp_executesql @TableCheckSQL
	
	IF NOT EXISTS(SELECT 1 FROM master.sys.databases WHERE name = @DatabaseName)
	BEGIN
		GOTO DATABASE_NAME_ERROR
	END
	
	IF EXISTS(SELECT 1 FROM #TEMP_ERROR_OUTPUT WHERE Error = 1)
	BEGIN
		GOTO DATABASE_TABLENAME_ERROR
	END

	TRUNCATE TABLE #TEMP_ERROR_OUTPUT

	INSERT INTO #TEMP_ERROR_OUTPUT
	EXEC sp_executesql @ColumnCheckSQL

	IF EXISTS(SELECT 1 FROM #TEMP_ERROR_OUTPUT WHERE Error = 1)
	BEGIN
		GOTO TABLE_COLUMNNAME_ERROR
	END
		
	SET @DatabaseSQL = 'USE [' + @DatabaseName + ']; '

	SET @SQL = REPLACE('IF (OBJECT_ID(''dbo.TEMP_INDEXES_@TableName@'') IS NOT NULL) BEGIN DROP TABLE dbo.TEMP_INDEXES_@TableName@ END;','@TableName@',@TableName)
	SET @SQL = @DatabaseSQL + @SQL
	
	EXEC sp_executesql @SQL

	SET @SQL = REPLACE(
	'SELECT	 TBL.name AS TableName
			,IDX.name AS IndexName
			,c.name AS ColumnName
			,IC.key_ordinal
			,IC.is_descending_key
			,IC.is_included_column
			,IDX.allow_page_locks
			,IDX.allow_row_locks
			,IDX.fill_factor
			,IDX.has_filter
			,IDX.filter_definition
			,IDX.is_primary_key
			,IDX.is_unique
			,IDX.is_unique_constraint
			,IDX.type
			,IDX.type_desc
			,IDX.is_padded
			,IDX.is_disabled
			,IDX.ignore_dup_key
	INTO dbo.TEMP_INDEXES_@TableName@
	FROM sys.tables AS TBL
	INNER JOIN sys.columns AS C ON TBL.object_id = c.object_id
	INNER JOIN sys.index_columns AS IC ON IC.column_id = c.column_id AND IC.object_id = c.object_id
	INNER JOIN sys.indexes AS IDX ON IDX.index_id = IC.index_id AND IC.object_id = IDX.OBJECT_ID
	WHERE TBL.name = @TableName
		AND EXISTS( SELECT 1
					FROM sys.tables AS TBL2
					INNER JOIN sys.columns C2 ON TBL2.object_id = C2.object_id
					INNER JOIN sys.types T2 ON T2.system_type_id = C2.system_type_id
					INNER JOIN sys.index_columns IC2 ON IC2.column_id = C2.column_id AND IC2.object_id = C2.object_id
					INNER JOIN sys.indexes IDX2 ON IDX2.index_id = IC2.index_id AND IC2.object_id = IDX2.OBJECT_ID
					WHERE IDX.name = IDX2.name
						AND TBL2.name = @TableName
						AND C2.name = @ColumnName
						AND 1 = CASE WHEN @ForceCopy = 1 THEN 1
									 WHEN @ColumnType IN (''decimal'',''numeric'',''money'',''smallmoney'') AND T2.name = @ColumnType THEN 1
									 WHEN @ColumnType NOT IN (''decimal'',''numeric'',''money'',''smallmoney'',
												''tinyint'',''smallint'',''int'',''bigint'',''bit'',''text'',
												''ntext'',''date'',''datetimeoffset'',''datetime2'',
												''smalldatetime'',''datetime'',''time'',''uniqueidentifier''
												,''image'',''timestamp'',''xml'')
											AND T2.name = @ColumnType
											AND @ColumnLength < C2.max_length THEN 1
									 WHEN @ColumnType <> T2.name THEN 1
								ELSE 0 END)','@TableName@',@TableName)
	
	SET @SQL = @DatabaseSQL + @SQL
	
	SET @Parameters = '@TableName NVARCHAR(128),@ColumnName NVARCHAR(128),@ColumnType NVARCHAR(128),@ColumnLength INT,@ForceCopy BIT'
	
	EXEC sp_executesql @SQL, @Parameters, @TableName, @ColumnName, @ColumnType, @ColumnLength, @ForceCopy
	
	SET @SQL = REPLACE(
			   'DECLARE @IndexName NVARCHAR(128)
				DECLARE @DFName NVARCHAR(128)
				DECLARE @StatName NVARCHAR(128)
			    DECLARE @is_primary_key BIT
				DECLARE @Count INT
			    DECLARE @MaxCount INT
			    DECLARE @SQL NVARCHAR(MAX)

				SELECT DISTINCT IDENTITY(INT,1,1) AS RowID
						,df.name AS [DFName]
						,st.name AS [TableName]
				INTO #TEMP_DF
				FROM sys.default_constraints df
				JOIN sys.columns sc ON sc.object_id = df.parent_object_id AND df.parent_column_id = sc.column_id
				JOIN sys.tables st ON st.object_id = sc.object_id
				WHERE @TableName = st.name 
					AND @ColumnName = sc.name
			    
				SELECT @Count = 1, @MaxCount = COUNT(*)
				FROM #TEMP_DF

				WHILE (@Count <= @MaxCount)
				BEGIN
					SELECT	 @DFName = DFName
							,@TableName = TableName
					FROM #TEMP_DF
					WHERE RowID = @Count

					SET @SQL = ''ALTER TABLE ['' + @TableName + ''] DROP CONSTRAINT ['' + @DFName + '']''

					EXEC sp_executesql @SQL

					SET @Count += 1
				END

				SELECT DISTINCT IDENTITY(INT,1,1) AS RowID
								,ss.name AS [StatName]
								,st.name AS [TableName]
				INTO #TEMP_STAT
				FROM sys.stats ss
				JOIN sys.stats_columns ssc ON ssc.object_id = ss.object_id AND ssc.stats_id = ss.stats_id
				JOIN sys.columns sc ON ssc.column_id = sc.column_id AND ssc.object_id = sc.object_id
				JOIN sys.tables st ON sc.object_id = st.object_id
				WHERE NOT EXISTS (	SELECT 1 
									FROM sys.indexes si
									WHERE si.name = ss.name)
					AND @TableName = st.name 
					AND @ColumnName = sc.name

				SELECT @Count = 1, @MaxCount = COUNT(*)
				FROM #TEMP_STAT

				WHILE (@Count <= @MaxCount)
				BEGIN
					SELECT   @StatName = StatName
							,@TableName = TableName
					FROM #TEMP_STAT
					WHERE RowID = @Count

					SET @SQL = ''DROP STATISTICS '' + @TableName + ''.'' + @StatName

					EXEC sp_executesql @SQL
					
					SET @Count += 1
				END

				SELECT IDENTITY(INT,1,1) AS RowID
						,IndexName
						,TableName
						,is_primary_key
				INTO #TEMP_RESULT
				FROM dbo.TEMP_INDEXES_@TableName@
				GROUP BY IndexName, TableName, is_primary_key
				
				SELECT @Count = 1, @MaxCount = COUNT(*)
				FROM #TEMP_RESULT
				
				WHILE (@Count <= @MaxCount)
				BEGIN
					SELECT @TableName = TableName
							,@IndexName = IndexName
							,@is_primary_key = is_primary_key
					FROM #TEMP_RESULT
					WHERE RowID = @Count
					
					IF (@is_primary_key = 1)
					BEGIN
						SET @SQL = ''ALTER TABLE ['' + @TableName + ''] DROP CONSTRAINT ['' + @IndexName + '']''
					END
					ELSE
					BEGIN
						SET @SQL = ''DROP INDEX ['' + @IndexName + ''] ON ['' + @TableName + '']''
					END
					
					EXEC sp_executesql @SQL
					
					SET @Count += 1
				END','@TableName@',@TableName)
	
	SET @Parameters = '@TableName NVARCHAR(128),@ColumnName NVARCHAR(128)'

	EXEC sp_executesql @SQL, @Parameters, @TableName, @ColumnName
	
	GOTO SUCCESS
	
	SCALE_PARAMETER_ERROR:
	RAISERROR('PARAMETERS COLUMN SCALE AND COLUMN PRECISION ARE REQUIRED FOR COLUMN TYPE %s',16,1,@ColumnType)
	RETURN
	
	PARAMETER_ERROR:
	RAISERROR('PARAMETERS OF TYPE %s ARE REQUIRED TO HAVE A LENGTH DEFINED',16,1,@ColumnType)
	RETURN
	
	DATABASE_NAME_ERROR:
	RAISERROR('DATABASE %s DOES NOT EXIST ON THE SERVER.',16,1,@DatabaseName)
	RETURN
	
	DATABASE_TABLENAME_ERROR:
	RAISERROR('TABLE NAME %s DOES NOT EXIST ON THE SERVER.',16,1,@TableName)
	RETURN

	TABLE_COLUMNNAME_ERROR:
	RAISERROR('COLUMN NAME %s DOES NOT EXIST ON TABLE %s',16,1,@ColumnName,@TableName)
	RETURN
	
	SUCCESS:
	PRINT 'INDEXES FOR TABLE ' + @TableName + ' HAVE BEEN SAVED'
	RETURN
	
	SET NOCOUNT OFF
END

GO

USE [ipmaster]
GO

/****** Object:  StoredProcedure [dbo].[usp_DBACreateTableIndexes]    Script Date: 9/21/2020 5:22:38 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




if (select top 1 1 from sys.procedures where name='usp_DBACreateTableIndexes') = 1
	begin
	print('Dropping '+'usp_DBACreateTableIndexes')
	drop procedure usp_DBACreateTableIndexes
	end
else
	begin
	print('No drop needed for '+'usp_DBACreateTableIndexes')
	end
	;

	go




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

USE [ipmaster]
GO

/****** Object:  StoredProcedure [dbo].[usp_DBADropOldBackupTables]    Script Date: 9/21/2020 5:22:47 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




if (select top 1 1 from sys.procedures where name='usp_DBADropOldBackupTables') = 1
	begin
	print('Dropping '+'usp_DBADropOldBackupTables')
	drop procedure usp_DBADropOldBackupTables
	end
else
	begin
	print('No drop needed for '+'usp_DBADropOldBackupTables')
	end
	;

	go



CREATE PROCEDURE [dbo].[usp_DBADropOldBackupTables] ( @DaysToDrop INT = 32 )
AS /*
Name: usp_DBADropOldBackupTables
Author: Matt Laffoon
Description: Drops backup tables
                  to the table dbaBackupTracking
Parameters: @DaysToDrop - Specifies the age of the tables to be dropped in number of days. Default is 32 to always be on a monthly tape in prod
Change History:
      - 11/07/2012 - ML - Created
      - 5/8/2015 - KJ - Altered insert statement to join on table schema and table name, so the join is not pulling back too many records
	  - 8/15/2016 - KJ - Join on sys.schemas since so.(uid) is the object owner and bck will never be object owner
      - 06/06/2016 - ML - Now removes all tables in the bck schema, instead of tables named bck and bkp
					 NR - Rewrote this as the first line of the WHERE clause 
					      Good for LAB and most Prod, but may need to rethink for CONTENT.
					 (Research select table_name from information_schema.tables where table_schema = 'bck' and table_name not like 'b%')
	  - 08/24/2016 - ML - Increased size of TableName column to handle large names
	  - 03/06/2019 - NR - Removed PK and {OUTER JOIN/WHERE clause combo} which prevented the same table name from being dropped twice
	  - 03/06/2019 - NR - Added statement to drop PK, if it exists, from dbaBackupTracking 
	  - 03/06/2019 - NR - Expanded search to include schemas in dbo and bck (but not other schemas)
	  - 03/06/2019 - NR - Added exclusion to prevent dropping permanent backup tables, i.e. 'BACKUP%'
	  - 03/06/2019 - NR - Expanded search for table names prefexed:  BCK,BKP,bkc,bku,bk,bc,bac
						  (Multiscript and review:  select LEFT(name,3) from sys.tables where name like 'b%' group by LEFT(name,3))
	  - 03/06/2019 - NR - Added a check for existance of the #temp tables
	  - 03/06/2019 - NR - Added a check for so.Type='U' (Table) b/c the job will error when attempting to drop a View (so.Type='V')
	  - 04/01/2019 - NR - Epanded search for table names:  TEMP_INDEXES_,tmp_%_TableRequest --created by DBA scrub process or DBA TableRequestTool
	  - 07/25/2019 - NR - Increased [TableName] field length
	  - 09/24/2019 - NR - Added is_read_only=0 to avoid running this on read-only databases
*/

IF OBJECT_ID('tempdb..##DropTableCommands') IS NOT NULL BEGIN DROP TABLE ##DropTableCommands END
IF OBJECT_ID('tempdb..#mydatabases') IS NOT NULL BEGIN DROP TABLE #mydatabases END

DECLARE @Cmd AS NVARCHAR(MAX)
DECLARE @CurrentDatabase AS NVARCHAR(1000)
DECLARE @updateCmd AS NVARCHAR(4000)
DECLARE @tableCount INT
DECLARE @NumDays VARCHAR(6)

SELECT @NumDays = CAST((@DaysToDrop * -1) AS VARCHAR(6))

SET NOCOUNT ON

SELECT  name AS databasename ,
        0 AS processed
INTO    #mydatabases
FROM    sys.databases
WHERE   name NOT IN ( 'tempdb', 'master', 'msdb', 'model' )
        AND name NOT LIKE 'REPL%'
        AND name NOT LIKE 'SEC%'
        AND name NOT LIKE '%Archive%'
        AND name NOT LIKE '%Hist%'
        AND name NOT LIKE '%Temp%'
        AND name NOT LIKE 'Tmp%'
        AND name NOT LIKE '%BAK%'
        AND name NOT LIKE 'Tfs_IntegrationPlatform%'
        AND state_desc = 'ONLINE' --the database is online
		AND is_read_only=0 --the database is not read only (e.g. a snapshot)
ORDER BY name
SET @CurrentDatabase = NULL
SELECT TOP 1
        @CurrentDatabase = databasename
FROM    #mydatabases
WHERE   processed = 0
WHILE @CurrentDatabase IS NOT NULL 
    BEGIN
		SET @Cmd = 'IF OBJECT_ID(''['+ @CurrentDatabase+'].dbo.dbaBackupTracking'') IS NULL
				BEGIN
					CREATE TABLE ['+@CurrentDatabase+'].dbo.dbaBackupTracking (
					TableName varchar(300) NOT NULL
					,CreatedDate datetime NOT NULL
					,DropDate datetime NULL)
				END
	     
	     IF (SELECT COUNT(1) FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA=''dbo'' AND TABLE_NAME=''dbaBackupTracking''
	     AND CHARACTER_MAXIMUM_LENGTH<300)>0
			 BEGIN
				ALTER TABLE [dbo].[dbaBackupTracking] ALTER COLUMN [TableName] [varchar] (300) NOT NULL
			 END     
               
			IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N''[dbo].[dbaBackupTracking]'') AND name = N''PK_dbaBackupTracking'')
				BEGIN
					ALTER TABLE [dbo].[dbaBackupTracking] DROP CONSTRAINT [PK_dbaBackupTracking]
				END
        
        
            INSERT INTO ['+@CurrentDatabase+'].dbo.dbaBackupTracking (TableName, CreatedDate, DropDate)
              SELECT  
                   (''[''+it.TABLE_SCHEMA+''].[''+so.name+'']'') AS [TableName] ,
                    so.[crdate] AS [CreatedDate] ,
                    NULL AS DropDate
              FROM    
					[' + @currentDatabase + '].INFORMATION_SCHEMA.TABLES AS it 
					INNER JOIN [' +@currentDatabase + '].dbo.sysobjects AS so 
					on  it.[TABLE_NAME] = so.[name]
					INNER JOIN [' +@CurrentDatabase + '].sys.schemas s on s.schema_id = so.uid
					and it.TABLE_SCHEMA = s.name                                                         
		      WHERE  
		      	(it.TABLE_SCHEMA =''bck'' AND so.name NOT LIKE ''b%'' AND so.crdate < DATEADD(DAY, ' + @NumDays + ', GETDATE()) AND so.type=''U'')
				
				OR
				
				(
					it.TABLE_SCHEMA in (''bck'',''dbo'') 
					AND
					so.name NOT LIKE ''backup%''
					AND
					so.type=''U''
					AND 
					( 
					   so.name LIKE ''BCK%''
					OR so.name LIKE ''BKP%'' 
					OR so.name LIKE ''bkc%''
					OR so.name LIKE ''bku%''
					OR so.name LIKE ''bk%''
					OR so.name LIKE ''bc%''
					OR so.name LIKE ''bac%''
					OR so.name LIKE ''RESTORPT%''
					OR so.name LIKE ''TEMP_INDEXES_%''
					OR so.name LIKE ''tmp_%_TableRequest''
					)				
					AND so.crdate < DATEADD(DAY, ' + @NumDays + ', GETDATE())
				)			
				'
            
              --print @cmd

        EXEC sp_executesql @cmd
            --removed dbo.  The schema is already tagged onto the tableName.
        SET @Cmd = 'SELECT  ''DROP TABLE [' + @CurrentDatabase + '].'' + tablename AS DropCommand , 
                tablename AS TableName ,
                0 AS processed
        INTO    ##DropTableCommands
        FROM    [' + @CurrentDatabase + '].dbo.dbaBackupTracking
        WHERE   DropDate IS NULL'
                        
            EXEC sp_executesql @cmd
            
            SELECT @tableCount = COUNT(*)
            FROM ##DropTableCommands
            
            PRINT @CurrentDatabase + ' has ' + CAST(@tableCount AS VARCHAR(4)) + ' tables that will be dropped.'
            
        SET @Cmd = NULL
            
        SELECT TOP 1
                @Cmd = DropCommand
        FROM    ##DropTableCommands
        WHERE   processed = 0
                        
        WHILE @Cmd IS NOT NULL 
            BEGIN
                PRINT @cmd

                EXEC sp_executesql @cmd
                        
                UPDATE  ##DropTableCommands
                SET     processed = 1
                WHERE   DropCommand = @cmd
                        
                SELECT  @updateCmd = 'update [' + @CurrentDatabase
                        + '].dbo.dbaBackupTracking set DropDate = GETDATE() WHERE TableName = '''
                        + TableName + ''''
                FROM    ##DropTableCommands
                WHERE   DropCommand = @cmd
      
                EXEC sp_executesql @updateCmd
                --PRINT @updateCmd
                        
                SET @cmd = NULL
                SELECT TOP 1
                        @Cmd = DropCommand
                FROM    ##DropTableCommands
                WHERE   processed = 0
            END
IF OBJECT_ID('tempdb..##DropTableCommands') IS NOT NULL BEGIN DROP TABLE ##DropTableCommands END

        UPDATE  #mydatabases
        SET     processed = 1
        WHERE   databasename = @CurrentDatabase
        SET @CurrentDatabase = NULL
        SELECT TOP 1
                @CurrentDatabase = databasename
        FROM    #mydatabases
        WHERE   processed = 0
    END

IF OBJECT_ID('tempdb..#mydatabases') IS NOT NULL BEGIN DROP TABLE #mydatabases END

SET NOCOUNT OFF


GO

USE [ipmaster]
GO

/****** Object:  StoredProcedure [dbo].[usp_DBARebuildIndexes]    Script Date: 9/21/2020 5:23:00 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




if (select top 1 1 from sys.procedures where name='usp_DBARebuildIndexes') = 1
	begin
	print('Dropping '+'usp_DBARebuildIndexes')
	drop procedure usp_DBARebuildIndexes
	end
else
	begin
	print('No drop needed for '+'usp_DBARebuildIndexes')
	end
	;

	go



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
		,@EnablePartitioning BIT = 0
		,@DisableLargeTables BIT = 0
		,@LargeTableSize INT = 5000000
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
				@EnableFullScan - BIT = 1; when 1, will perform a FULL SCAN when updating statistics. Default is 1
				@PrintParameters - BIT = 1; when 1, will print the parameters that were fed to the stored procedure for logging purposes. Default is 1
				@EnableOnline - BIT = 1; when 1, will perform online reindexing - requires SQL 2008R2 Enterprise. Default is 0
				@DisableLargeTables BIT = 0; when 1, will NOT rebuild tables over the row count in LargeTableSize Default is 0
				@LargeTableSize INT = 5000000; defines what is considered a large table by number of rows. Default is 5 million
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
		- 08/23/2014 - JD - Added partitioned bit to disable if partitioning is not being used
		- 01/26/2015 - ML - Fixed issue with check for blobs.
		- 09/01/2016 - ML - Added DisableLargeTables and LargeTableSize parameters to give the option to skip tables over a certain size
		- 08/24/2017 - PB - Fixed additional issue with check for blobs
		- 08/25/2017 - ML - Replaced reference to sysobjects with sys.objects as it is deprecated.
		- 04/16/2018 - PB - Added [] to index name in the SQL statement and ; at the end of the SQL statement.
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
		DECLARE @IsLargeTable BIT
		

		SELECT @ProductVersion = CASE LEFT(CAST(SERVERPROPERTY('ProductVersion') AS VARCHAR(128)),PATINDEX('%.%',CAST(SERVERPROPERTY('ProductVersion') AS VARCHAR(128)))-1)
								WHEN 8 THEN '2000'
								WHEN 9 THEN '2005'
								WHEN 10 THEN '2008'
								WHEN 11 THEN '2012'
								WHEN 12 THEN '2014'
								WHEN 13 THEN '2016'
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
		
		SELECT @OnlineSupported = CASE WHEN @ProductVersion IN ('2005','2008','2012','2014','2016') AND @ProductEdition = 'Enterprise' THEN 1
								  ELSE 0 END
		
		
		--Check if workflows are running where applicable
		IF EXISTS ( SELECT  1
					FROM sys.objects
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
			DECLARE @rowcount INT;

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
				PRINT 'DisableLargeTables - ' + CAST(@DisableLargeTables AS VARCHAR(1))
				PRINT 'LargeTableSize - ' + CAST(@LargeTableSize AS VARCHAR(15))
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
					,IsLargeTable BIT DEFAULT 0
				);

				CREATE TABLE #tsize
				(
					[name]   nvarchar(200),
				   [rows]   int,
				   [reserved]   varchar(180),
				   [data]   varchar(180),
				   [index_size]   varchar(180),
				   [unused]   varchar(180),
				 )

				CREATE TABLE #tablesize
				(
				   [name]   nvarchar(200),
				   [rows]   int,
				   [reserved]   varchar(180),
				   [reserved_int]   int default(0),
				   [data]   varchar(180),
				   [data_int]   int default(0),
				   [index_size]   varchar(180),
				   [index_size_int]   int default(0),
				   [unused]   varchar(180),
				   [unused_int]   int default(0)
				)
				
				OPEN tables;
				
				FETCH NEXT FROM tables INTO @vtablename;

				WHILE @@FETCH_STATUS = 0 
				BEGIN
					INSERT INTO #fraglist (ObjectName,ObjectId,IndexName,IndexId,Lvl,CountPages,CountRows,MinRecSize,MaxRecSize,AvgRecSize,ForRecCount,Extents,ExtentSwitches,AvgFreeBytes,AvgPageDensity,ScanDensity,BestCount,ActualCount,LogicalFrag,ExtentFrag )
					EXEC( 'DBCC SHOWCONTIG (''' + @vtablename + ''') WITH FAST, TABLERESULTS, ALL_INDEXES, NO_INFOMSGS');
						UPDATE #fraglist set ObjectName = @vtablename where ObjectID = OBJECT_ID(@vtablename)
					INSERT INTO #tsize ([name],[rows],[reserved],[data],[index_size],[unused])
					EXEC ( 'exec sp_spaceused ''' + @vtablename + '''' )
						--Holding 1 record at a time in #tsize in order to update the object name back to a qualified object name before inserting into #tablesize
						UPDATE #tsize SET name = @vtablename
						INSERT INTO #tablesize ([name],[rows],[reserved],[data],[index_size],[unused])
						SELECT [name],[rows],[reserved],[data],[index_size],[unused] FROM #tsize t
						TRUNCATE TABLE #tsize
					FETCH NEXT FROM tables INTO @vtablename;
				END;
				
				CLOSE tables;
				DEALLOCATE tables;
				
				UPDATE f
				SET f.IsLargeTable = 1
				FROM	#fraglist f
						INNER JOIN #tablesize t ON f.ObjectName = t.name
				WHERE
					t.rows > @LargeTableSize

				UPDATE #tablesize 
				SET
				   [reserved_int] = CAST(SUBSTRING([reserved], 1, CHARINDEX(' ', [reserved])) AS int),
				   [data_int] = CAST(SUBSTRING([data], 1, CHARINDEX(' ', [data])) AS int),
				   [index_size_int] = CAST(SUBSTRING([index_size], 1, CHARINDEX(' ', [index_size])) AS int),
				   [unused_int] = CAST(SUBSTRING([unused], 1, CHARINDEX(' ', [unused])) AS int)

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
						,f.IsLargeTable
						,t.[rows]
				FROM    #fraglist f
						INNER JOIN #tablesize t ON f.ObjectName = t.name
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
											 ,@density
											 ,@IsLargeTable
											 ,@rowcount;

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
							+ ' - Row Count: ' + CAST(@rowcount AS VARCHAR(25))
							
						IF @IsLargeTable = 1 AND @DisableLargeTables = 1
						BEGIN
							PRINT 'READONLY: Skipping - DisableLargeTables is enabled. Table is a LARGE table with a rowcount of: ' + CAST(@rowcount AS VARCHAR(25))
						END
						ELSE
						BEGIN
							IF @IsLargeTable = 1 AND @DisableLargeTables = 0
							BEGIN
								PRINT 'READONLY: Note - Table is a LARGE table with a rowcount of: ' + CAST(@rowcount AS VARCHAR(25))
							END							
						END							
					END
					ELSE 
					BEGIN
						PRINT 'Rebuilding and updating statistics for index: '
							+ RTRIM(@vtablename) + '('
							+ RTRIM(@vindexname)
							+ ') - fragmentation currently '
							+ RTRIM(CONVERT(VARCHAR(15), @frag))
							+ '% and density currently ' + CAST(@density AS VARCHAR(15))
							+ ' - Row Count: ' + CAST(@rowcount AS VARCHAR(25))
				
						IF @IsLargeTable = 1 AND @DisableLargeTables = 1
						BEGIN
							PRINT 'Skipping - DisableLargeTables is enabled. Table is a LARGE table with a rowcount of: ' + CAST(@rowcount AS VARCHAR(25))
							SELECT @execstr = 'SELECT NULL'
						END
						ELSE
						BEGIN
							IF @IsLargeTable = 1 AND @DisableLargeTables = 0
							BEGIN
								PRINT 'Note - Table is a LARGE table with a rowcount of: ' + CAST(@rowcount AS VARCHAR(25))
							END

							IF @EnableOnline = 1
							BEGIN
									
								SELECT
									   @HasBlobColumn = CASE WHEN MAX(so.object_ID) IS NULL THEN 0 ELSE 1 END
								FROM
									   sys.objects SO 
								INNER JOIN
									   sys.columns SC ON SO.Object_id = SC.object_id
								WHERE
									   so.object_id = @objectid
									   and sc.system_type_id in
											  (select system_type_id from sys.types 
													 where
														   name in ('text', 'ntext', 'image', 'varchar(max)', 'nvarchar(max)', 'varbinary(max)', 'xml')
														   or ((name='varchar' or name='nvarchar')
																  and sc.max_length = -1));

											
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
													+'['+ RTRIM(@vindexname)
													+ ']) WITH NO_INFOMSGS;';
							END
						END
						PRINT @execstr 
						EXEC (@execstr);
						
						IF @EnableFullScan = 1
						BEGIN
							SELECT  @execstr = 'UPDATE STATISTICS '
												+ RTRIM(@vtablename) + '('
												+ '['+RTRIM(@vindexname) + ']) WITH FULLSCAN;'
						END
						ELSE
						BEGIN
							SELECT  @execstr = 'UPDATE STATISTICS '
												+ RTRIM(@vtablename) + '('
												+'['+ RTRIM(@vindexname) + ']);'									
						END
						PRINT @execstr                                            
						EXEC (@execstr);
					END
					FETCH NEXT FROM indexes INTO  @vtablename
												 ,@objectid
												 ,@indexid
												 ,@vindexname
												 ,@frag
												 ,@density
												 ,@IsLargeTable
												 ,@rowcount;
				END;
				
				CLOSE indexes;
				DEALLOCATE indexes;
				
				DROP TABLE #fraglist;
			END
			
			IF (@ProductVersion IN ('2008','2012','2014','2016') AND @ProductEdition = 'Enterprise' AND @EnablePartitioning = 1)
			BEGIN
				DECLARE @vpartitionnumber VARCHAR(10)
				
				CREATE TABLE ##TEMP_PARTITIONS
				(
					 TableName VARCHAR(128)
					,IndexName VARCHAR(128)
					,PartitionNumber VARCHAR(10)
					,FragmentationPercentage DECIMAL(28,2)
				)
				
				SET @execstr = 'USE [' + @currentDatabase + '];
								DECLARE @DBID INT
								SET @DBID = DB_ID(' + '''' + @currentDatabase + '''' + ')
								
								IF (@DBID IS NOT NULL)
								BEGIN
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
																HAVING COUNT(*) > 1)
										AND (OBJECT_NAME(ps.OBJECT_ID) = ' + '''' + @TableName + '''' + ' OR ' + @TableName + ' IS NULL)  
								END'
				
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

GO


USE [ipmaster]
GO

/****** Object:  StoredProcedure [dbo].[usp_GCStatisticalClassifier_WordCountFrequency_RebuildStatistics]    Script Date: 9/21/2020 5:23:09 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



if (select top 1 1 from sys.procedures where name='usp_GCStatisticalClassifier_WordCountFrequency_RebuildStatistics') = 1
	begin
	print('Dropping '+'usp_GCStatisticalClassifier_WordCountFrequency_RebuildStatistics')
	drop procedure usp_GCStatisticalClassifier_WordCountFrequency_RebuildStatistics
	end
else
	begin
	print('No drop needed for '+'usp_GCStatisticalClassifier_WordCountFrequency_RebuildStatistics')
	end
	;

	go





CREATE PROCEDURE [dbo].[usp_GCStatisticalClassifier_WordCountFrequency_RebuildStatistics](
	@PartnerID int,
	@CountryCode varchar(2),
	@HSNumLength int = 12,
	@ColumnName varchar(200) = 'ProductDesc',
	@TableName varchar(200) = NULL
) AS
/*
 * Name: usp_GCStatisticalClassifier_WordCountFrequency_RebuildStatistics
 * Author: Andy R. Schmitz
 * Description: The Statistical Classifier requires statistics to be pregenerated. Unfortunately that can take 30 minutes, per
 *              country, per column. So we have a SP (eventually a CLR function?) to handle the number crunching more efficiently.
 * Parameters:
 *       PartnerID - The PartnerID of the Partner
 *     CountryCode - The CountryCode we're analyzing
 *     HSNumLength - The length of the HSNumber we're analyzing
 *                   12 is the max length, but often times we may only want to analyze the first 6 digits
 *      ColumnName - The XXPC column we're analyzing
 *       TableName - Allows you to target global, but store the statistics as US, or something
 * Returns: The number of product records processed
 * Change History:
 *     13 Aug 2015 - ARS - Created initial version
 *     12 Feb 2016 - ARS - Can customize the TableName
 *     26 Jul 2017 - GMB - Adding support for suppl/addl fields
 */
BEGIN
	SET NOCOUNT ON
	IF @TableName IS NULL
	BEGIN
		SET @TableName = 'tmd' + @CountryCode + 'ProductClassification'
	END

	DECLARE @input TABLE (ColumnText varchar(MAX) NOT NULL, HSNum varchar(12) NOT NULL)
	DECLARE @wl TABLE (ColumnText varchar(MAX) NOT NULL)
	DECLARE @currentHS varchar(12)
	DECLARE @results int = 0
	DECLARE @tempInsertSQL varchar(MAX)

	/* 1) Gather statistics */
	-- Pull ProductDesc & HSNum into a temp table so we're not locking the whole table
	IF @TableName = 'tmd' + @CountryCode + 'ProductClassification'
		BEGIN
			SET @tempInsertSQL = ' SELECT [' + @ColumnName + '], HSNum'
				+ ' FROM [' + @TableName + '] WITH (NOLOCK)'
				+ ' WHERE PartnerID=' + CONVERT(varchar(20), @PartnerID)
				+ ' AND [' + @ColumnName + '] IS NOT NULL'
				+ ' AND HSNum IS NOT NULL'
		END
	ELSE
		BEGIN
			SET @tempInsertSQL = ' SELECT supp.[' + @ColumnName + '], pc.HSNum'
				+ ' FROM tmd' + @CountryCode + 'ProductClassification pc WITH (NOLOCK)'
				+ ' INNER JOIN ' + @TableName + ' supp WITH (NOLOCK)'
				+ '   ON pc.ProductGuid = supp.ProductGuid'
				+ '     AND pc.PartnerID = supp.PartnerID'
				+ ' WHERE pc.PartnerID=' + CONVERT(varchar(20), @PartnerID)
				+ ' AND supp.[' + @ColumnName + '] IS NOT NULL'
				+ ' AND pc.HSNum IS NOT NULL'
		END
	
	INSERT INTO @input
	EXEC(@tempInsertSQL)

	-- Trim the data
	UPDATE @input
	SET
		ColumnText = LTRIM(RTRIM(ColumnText)),
		HSNum = LEFT(HSNum, @HSNUmLength)
	WHERE 1=1

	-- Delete errant records
	DELETE FROM @input
	WHERE ColumnText = ''
		OR HSNum = ''


	/* 2) Clean up previous data */
	DELETE FROM dbo.txgStatisticalClassifierStatistics
	WHERE PartnerID = @PartnerID
		AND CountryCode = @CountryCode
		AND ColumnName = @ColumnName
		AND HSNumLength = @HSNumLength


	/* 3) For each HS Number within the dataset... */
	WHILE EXISTS(SELECT 1 FROM @input)
	BEGIN

		-- Grab the top value
		SET @currentHS = (
			SELECT TOP(1) HSNum
			FROM @input
		)

		-- Clean up the word list table from any previous results
		DELETE FROM @wl
		WHERE 1=1

		-- Dump the column text into the wordlist table
		INSERT INTO @wl
		SELECT ColumnText
		FROM @input
		WHERE HSNum = @currentHS

		/* 4) Split the description into individual words, and insert each word as a seperate row into the statistics table */
		INSERT INTO dbo.txgStatisticalClassifierStatistics
			(PartnerID, EffDate, CountryCode,
			 ColumnName, HSNumLength, HSNum,
			 Word, WordCount, ProductCount,
			 DeletedFlag, KeepDuringRollback)
		SELECT DISTINCT
			@PartnerID, GETDATE(), @CountryCode,
			@ColumnName, @HSNumLength, @currentHS,
			s.item, COUNT(s.item), (SELECT COUNT(*) FROM @wl),
			'N', 'N'
		FROM @wl AS t
		CROSS APPLY
			ipmaster.dbo.udf_SplitStringCLR_SQL(
				ipmaster.dbo.ufn_StripCharacters(t.ColumnText, '^a-z0-9|', '|'),
				'|'
			) As s
		WHERE s.item <> '' AND LEN(s.item) <= 50
		GROUP BY s.item

		-- Delete that HSNum so we can move onto the next
		DELETE FROM @input
		WHERE HSNum = @currentHS

		-- Update the return value
		SET @results = @results + @@ROWCOUNT
	END

	RETURN @results

	SET NOCOUNT OFF
END

GO

USE [ipmaster]
GO

/****** Object:  StoredProcedure [dbo].[usp_PTISetup]    Script Date: 9/21/2020 5:23:17 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


if (select top 1 1 from sys.procedures where name='usp_PTISetup') = 1
	begin
	print('Dropping '+'usp_PTISetup')
	drop procedure usp_PTISetup
	end
else
	begin
	print('No drop needed for '+'usp_PTISetup')
	end
	;

	go




CREATE PROCEDURE [dbo].[usp_PTISetup] 
/*@SourcePartnerID varchar (10),@SubscriberPartnerID varchar (10)--decided to set these from tmfDefaults in Section 1*/
@SourceDatabaseName varchar (50)
,@SubscriberDatabaseName varchar (50)
,@TableNames nvarchar (max)
,@ErrorMessage NVARCHAR (MAX) OUTPUT

AS 
PRINT 'Inside usp_PTISetup'
PRINT 'VERSION 2019.07.23.NAR'

SET NOCOUNT ON; 

DECLARE @SourcePartnerID varchar (10);
DECLARE @SubscriberPartnerID varchar (10);
DECLARE @RaiseError bit;
DECLARE @ErrorMessage_TableNames NVARCHAR(MAX);

SET @RaiseError=1
SET @ErrorMessage_TableNames=''
SET @ErrorMessage=''


Print 'Section 1'
/* ======== | Section 1: Source & Subscriber Databases Exist | ============= */
/*
VERIFY DATABASE NAME--e.g. Requester should not use an IP Address for the database name.
*/

/*This sanitizes the database names by removing carriage return, line feed, tab and space that occur when a requester executes the procedure with variable inputs vertically stacked, includes by mistake or copies from another application*/
SET @SourceDatabaseName=REPLACE(REPLACE(REPLACE(REPLACE(CAST(@SourceDatabaseName AS VARCHAR(50)), CHAR(13),''), CHAR(10),''), CHAR(9),''), CHAR(32),'')
SET @SubscriberDatabaseName=REPLACE(REPLACE(REPLACE(REPLACE(CAST(@SubscriberDatabaseName AS VARCHAR(50)), CHAR(13),''), CHAR(10),''), CHAR(9),''), CHAR(32),'')

if (SELECT COUNT(1) FROM [master].SYS.DATABASES 
WHERE NAME IN (@SourceDatabaseName,@SubscriberDatabaseName) and state_desc='ONLINE')=2  /*Reading the "Warning" section. For cross-server PTI, change this to 1 and set PartnerIDs.  No other changes required below.  2 requires both partners to be on same server*/
BEGIN
SET @RaiseError=0

/*Get the PartnerID of Source and of Subscriber from tmfDefaults*/
DECLARE @SQLCommand_SourcePartnerIDQuery NVARCHAR(MAX);
SET @SQLCommand_SourcePartnerIDQuery = ('SELECT @input_SourcePartnerID = (SELECT PartnerID FROM ['+@SourceDatabaseName+'].[dbo].[tmfDefaults] WITH (NOLOCK))')
SET @SourcePartnerID = 0
EXEC SP_EXECUTESQL @SQLCommand_SourcePartnerIDQuery,  N'@input_SourcePartnerID varchar (10) output', @SourcePartnerID output

DECLARE @SQLCommand_SubscriberPartnerIDQuery NVARCHAR(MAX);
SET @SQLCommand_SubscriberPartnerIDQuery = ('SELECT @input_SubscriberPartnerID = (SELECT PartnerID FROM ['+@SubscriberDatabaseName+'].[dbo].[tmfDefaults] WITH (NOLOCK))')
SET @SubscriberPartnerID = 0
EXEC SP_EXECUTESQL @SQLCommand_SubscriberPartnerIDQuery,  N'@input_SubscriberPartnerID varchar (10) output', @SubscriberPartnerID output
END

IF @RaiseError=1
BEGIN
SET @ErrorMessage='The database names provided were not found.  Examples of database names are: IP_123, TEST_123, SOW_123, etc...'
END  /*End of Section1*/


Print 'Section 2'
/* ======== | Section 2: Tables Exist & Cased as in Database | ============= */
IF @ErrorMessage=''
BEGIN /*Begin Section2: PartA*/

/*
Move the comma-seperated table names from the @TableNames variable into table #PTISetup_TableList. 
*/
IF OBJECT_ID ('tempdb..#PTISetup_TableList') IS NOT NULL BEGIN DROP TABLE #PTISetup_TableList END 


create table #PTISetup_TableList
(
SourceTableName	nvarchar (300) NOT NULL,
SubscriberTableName	nvarchar (300) NOT NULL,  /*This is a duplicate list of tables, except with the Subscriber PartnerID*/
Processed BIT NOT NULL,	
HasPrimaryKey BIT NOT NULL
)

INSERT INTO #PTISetup_TableList
SELECT RESULTS AS [SourceTableName], RESULTS AS [SubscriberTableName], 0 AS [Processed], 0 AS [HasPrimaryKey] FROM dbo.ufn_SplitList(@TableNames,',')

/*Sanitize the table names by removing carriage return, line feed, tab and space that occur when a requester executes the procedure with variable inputs vertically stacked, includes by mistake or copies from another application*/
UPDATE #PTISetup_TableList
SET 
[SourceTableName]=REPLACE(REPLACE(REPLACE(REPLACE(CAST([SourceTableName] AS NVARCHAR(MAX)), CHAR(13),''), CHAR(10),''), CHAR(9),''), CHAR(32),''),
[SubscriberTableName]=REPLACE(REPLACE(REPLACE(REPLACE(CAST([SubscriberTableName] AS NVARCHAR(MAX)), CHAR(13),''), CHAR(10),''), CHAR(9),''), CHAR(32),'')

/*Sanitize the table list if a requester were to submit the table schema along with table names*/
UPDATE #PTISetup_TableList
SET 
SourceTableName=REPLACE(SourceTableName,'dbo.',''),
SubscriberTableName=REPLACE(SubscriberTableName,'dbo.','')

/*Sanitize the table list by removing duplicate table names--such as would occur if a requester submits all of the table names from both Source and Subscriber*/
UPDATE #PTISetup_TableList
SET 
SourceTableName=REPLACE(SourceTableName,@SourcePartnerID,'@PartnerID@'),
SubscriberTableName=REPLACE(SubscriberTableName,@SourcePartnerID,'@PartnerID@')

UPDATE #PTISetup_TableList
SET 
SourceTableName=REPLACE(SourceTableName,@SubscriberPartnerID,'@PartnerID@'),
SubscriberTableName=REPLACE(SubscriberTableName,@SubscriberPartnerID,'@PartnerID@')

; WITH CTE_PTI AS( 
SELECT 
tl.[SourceTableName],  
RN=ROW_NUMBER()OVER(PARTITION BY  tl.[SourceTableName] ORDER BY tl.[SourceTableName] asc) 
FROM #PTISetup_TableList tl 
)
delete CTE_PTI
where RN>1 

/*
Tables with these prefixes are dropped automatically during our normal business process
and should be excluded from PTI setup: backups (bck), temporary (tmp), user (usr) and non-dbo schemas.
*/
if (select count(1) from #PTISetup_TableList 
where 
[SourceTableName] not like 'txd%' 
AND [SourceTableName] not like 'tmd%' 
AND [SourceTableName] not like 'tmf%' 
AND [SourceTableName] not like 'tmg%' 
AND [SourceTableName] not like 'ttd%' 
)>0
begin
SET @ErrorMessage=(SELECT N'Error--PTI setup allowed for table prefixes:  txd,tmd,tmf,tmg and ttd.  Not allowed: anything else...bck, tmp, usr and non-dbo schema.')
end
END /*End of Section2: PartA*/


if @ErrorMessage=''
begin /*Begin Section2: PartB*/
/*
--VALIDATE THE LIST OF TABLE NAMES--
To verify that the tables exist in their respective partners, replace @PartnerID@ with the PartnerID of either Source or Subscriber in the respective fields)
We'll change this back later so that the PTI setup can commence.

Note that this replaces each table name provided with the case-sensitive table name found in the system (INFORMATION_SCHEMA.TABLES) or else returns @ErrorMessage. 
PTI is not case sentive; however, the VB code is. 
*/

UPDATE #PTISetup_TableList
SET SourceTableName=REPLACE(SourceTableName,'@PartnerID@',@SourcePartnerID),
SubscriberTableName=REPLACE(SubscriberTableName,'@PartnerID@',@SubscriberPartnerID)

DECLARE @SourceTL NVARCHAR (MAX);
SET @SourceTL=N'UPDATE #PTISetup_TableList
SET [SourceTableName]=''dbo.''+TABLE_NAME
FROM ['+@SourceDatabaseName+'].INFORMATION_SCHEMA.TABLES
WHERE 
TABLE_SCHEMA=''dbo'' 
AND TABLE_NAME=[SourceTableName]'

if (select top 1 1 from [master].sys.databases where name=@SourceDatabaseName and state_desc='ONLINE')=1
BEGIN 
EXEC SP_EXECUTESQL @SourceTL
END

DECLARE @SubscriberTL NVARCHAR (MAX);  /*Same action for Subscriber*/
SET @SubscriberTL=N'UPDATE #PTISetup_TableList
SET [SubscriberTableName]=''dbo.''+TABLE_NAME
FROM ['+@SubscriberDatabaseName+'].INFORMATION_SCHEMA.TABLES
WHERE 
TABLE_SCHEMA=''dbo'' 
AND TABLE_NAME=[SubscriberTableName]'

if (select top 1 1 from [master].sys.databases where name=@SubscriberDatabaseName and state_desc='ONLINE')=1
BEGIN 
EXEC SP_EXECUTESQL @SubscriberTL
END

/*
Above, if table exists, we prefix it with the schema 'dbo.'
Now, any TableName in #PTISetup_TableList that are prefixed with 'dbo.' are in the system, and all others are not in the system.
If any are not in the system, raise @ErrorMessage.
*/
 
----------------------------/*Return list of tables that do not exist in Source*/
IF (
SELECT COUNT(1)
FROM #PTISetup_TableList 
WHERE [SourceTableName] not like 'dbo.%'
) != 0 and (select top 1 1 from [master].sys.databases where name=@SourceDatabaseName and state_desc='ONLINE')=1
BEGIN

SELECT @ErrorMessage_TableNames=COALESCE(@ErrorMessage_TableNames+ ',' , '' ) + SourceTableName 
FROM #PTISetup_TableList 
WHERE [SourceTableName] not like 'dbo.%'
ORDER BY SourceTableName

SET @ErrorMessage=(SELECT N'Error--Table(s) do(es) not exist in '+@SourceDatabaseName+':  {'+RIGHT(@ErrorMessage_TableNames,LEN(@ErrorMessage_TableNames)-1)+'}')
END

----------------------------/*Return list of tables that do not exist in Subscriber*/
IF @ErrorMessage='' 
AND (SELECT COUNT(1)
FROM #PTISetup_TableList 
WHERE [SubscriberTableName] not like 'dbo.%'
) != 0 and (select top 1 1 from [master].sys.databases where name=@SubscriberDatabaseName and state_desc='ONLINE')=1
BEGIN

SELECT @ErrorMessage_TableNames=COALESCE(@ErrorMessage_TableNames+ ',' , '' ) + SubscriberTableName 
FROM #PTISetup_TableList 
WHERE [SubscriberTableName] not like 'dbo.%'
ORDER BY SubscriberTableName

SET @ErrorMessage=(SELECT N'Error--Table(s) do(es) not exist in '+@SubscriberDatabaseName+':  {'+RIGHT(@ErrorMessage_TableNames,LEN(@ErrorMessage_TableNames)-1)+'}')
END

END /*End of Section2: PartB*/



Print 'Section 3'
/* ======== | Section 3: Tables have a Primary Key | ============= */

/*To prevent a PTI setup during a database failover...continue only if no error has raised and both Source & Subscriber are on the same server.*/
IF @ErrorMessage='' 
AND (SELECT TOP 1 1 FROM [master].sys.databases WHERE NAME=@SourceDatabaseName and state_desc='ONLINE')=1
BEGIN

/*
--VALIDATE THE Primary Keys--
Verify that each table in the Source partner has a primary key.
*/

WHILE (SELECT TOP 1 1 FROM #PTISetup_TableList WHERE Processed=0 AND SourceTableName LIKE 'dbo.%')=1
BEGIN
	DECLARE @SourceTableName_Loop1 varchar(300);
	SET @SourceTableName_Loop1=(SELECT TOP 1 [SourceTableName] FROM #PTISetup_TableList WHERE Processed=0 AND SourceTableName LIKE 'dbo.%')

DECLARE @SourceHasPK NVARCHAR (MAX);
SET @SourceHasPK = 
N'USE ['+@SourceDatabaseName+'] if (SELECT COUNT(1)
	FROM sys.objects
	WHERE parent_object_id=(OBJECT_ID('''+@SourceTableName_Loop1+''')) 
	AND type=''PK''
	) != 0
	BEGIN
		UPDATE tempdb..#PTISetup_TableList 
		SET HasPrimaryKey=1 
		WHERE SourceTableName='''+@SourceTableName_Loop1+'''
	END'
	
exec sp_executesql @SourceHasPK 

	UPDATE #PTISetup_TableList SET Processed=1 WHERE SourceTableName=@SourceTableName_Loop1
END

/*Raise @ErrorMessage if any table in the Source partner does not have a PK*/
IF (SELECT COUNT(1) FROM #PTISetup_TableList WHERE [HasPrimaryKey]=0 and SourceTableName LIKE 'dbo.%') != 0
BEGIN
SELECT @ErrorMessage_TableNames=COALESCE(@ErrorMessage_TableNames+ ',' , '' ) + SourceTableName 
FROM #PTISetup_TableList
WHERE [HasPrimaryKey]=0 and SourceTableName LIKE 'dbo.%'
ORDER BY SourceTableName

SET @ErrorMessage=(SELECT N'Error--Add primary keys to table(s) in '+@SourceDatabaseName+':  {'+RIGHT(@ErrorMessage_TableNames,LEN(@ErrorMessage_TableNames)-1)+'}')
END

END 

--------------------------------------Subscriber PK

/*To prevent a PTI setup during a database failover...continue only if no error has raised and both Source & Subscriber are on the same server.*/
IF @ErrorMessage='' 
AND (SELECT TOP 1 1 FROM [master].sys.databases WHERE NAME=@SubscriberDatabaseName and state_desc='ONLINE')=1
BEGIN

UPDATE #PTISetup_TableList
SET Processed=0,HasPrimaryKey=0

/*
--VALIDATE THE Primary Keys--
Verify that each table in the Subscriber partner has a primary key.
*/

WHILE (SELECT TOP 1 1 FROM #PTISetup_TableList WHERE Processed=0 AND SubscriberTableName LIKE 'dbo.%')=1
BEGIN
	DECLARE @SubscriberTableName_Loop1 varchar(300);
	SET @SubscriberTableName_Loop1=(SELECT TOP 1 [SubscriberTableName] FROM #PTISetup_TableList WHERE Processed=0 AND SubscriberTableName LIKE 'dbo.%')

DECLARE @SubscriberHasPK NVARCHAR (MAX);
SET @SubscriberHasPK=
N'USE ['+@SubscriberDatabaseName+'] if (
	SELECT COUNT(1)
	FROM sys.objects
	WHERE parent_object_id=(OBJECT_ID('''+@SubscriberTableName_Loop1+''')) 
	AND type=''PK''
	) != 0
	BEGIN
		UPDATE tempdb..#PTISetup_TableList 
		SET [HasPrimaryKey]=1 
		WHERE [SubscriberTableName]='''+@SubscriberTableName_Loop1+'''
	END'

	exec sp_executesql @SubscriberHasPK 

	UPDATE #PTISetup_TableList SET Processed=1 WHERE SubscriberTableName=@SubscriberTableName_Loop1
	
END


/*Raise @ErrorMessage if any table in the Subscriber partner does not have a PK*/
IF (SELECT COUNT(1) FROM #PTISetup_TableList WHERE [HasPrimaryKey]=0 and SubscriberTableName LIKE 'dbo.%') != 0
BEGIN
SELECT @ErrorMessage_TableNames=COALESCE(@ErrorMessage_TableNames+ ',' , '' ) + SubscriberTableName 
FROM #PTISetup_TableList
WHERE [HasPrimaryKey]=0 and SubscriberTableName LIKE 'dbo.%'
ORDER BY SubscriberTableName

SET @ErrorMessage=(SELECT N'Error--Add primary keys to table(s) in '+@SubscriberDatabaseName+':  {'+RIGHT(@ErrorMessage_TableNames,LEN(@ErrorMessage_TableNames)-1)+'}')
END

END /*End of Section3*/


Print 'Section 4'
/* ======== | Section 4: Table Structure Matches in Source & Subscriber | ============= */

/*
We'll use the [HasPrimaryKey] field more generally as a [Flag] field for Section 4.
PK=1 equals table structures match in Source and Subscriber; PK=0 is unequal table structure.
We begin with the assumption that the table structures match, aka PK=1, and we set PK=0 if any attribute {TableName(adjusted for PartnerID),ColumnName,DataType,CharacterMaximumLength} of the structure does not match.
To prevent a PTI setup during a database failover...continue only if no error has raised and both Source & Subscriber are on the same server.
*/

IF @ErrorMessage='' 
and (SELECT COUNT(1) FROM sys.databases WHERE NAME in (@SourceDatabaseName,@SubscriberDatabaseName) and state_desc='ONLINE')=2
BEGIN

/*All tables should be dbo.; this verifies that all exist in Source and Subscriber*/
DELETE tl FROM #PTISetup_TableList tl
WHERE tl.[SourceTableName] NOT LIKE 'dbo.%'
OR tl.[SubscriberTableName] NOT LIKE 'dbo.%'

/*We no longer need the dbo. schema in our string variables for code purposes*/
UPDATE #PTISetup_TableList
SET [SourceTableName] = RIGHT([SourceTableName],LEN([SourceTableName])-4),
[SubscriberTableName] = RIGHT([SubscriberTableName],LEN([SubscriberTableName])-4)
WHERE [SourceTableName] LIKE 'dbo.%'
OR [SubscriberTableName] LIKE 'dbo.%'

/*Prepare to process; the loop sets PK=0 if table structures do not match in Source & Subscriber; begin with the assumption that they do match*/
UPDATE #PTISetup_TableList
SET Processed=0, HasPrimaryKey=1 

	WHILE (SELECT TOP 1 1 FROM #PTISetup_TableList WHERE Processed=0)=1
	BEGIN
		DECLARE @SourceTableName_Loop2 varchar(300);
		DECLARE @SubscriberTableName_Loop2 varchar(300);
		SET @SourceTableName_Loop2=(SELECT TOP 1 [SourceTableName] FROM #PTISetup_TableList WHERE Processed=0)
		SET @SubscriberTableName_Loop2=(SELECT TOP 1 [SubscriberTableName] FROM #PTISetup_TableList WHERE [SourceTableName]=@SourceTableName_Loop2)
		
		IF OBJECT_ID ('tempdb..#TableA') IS NOT NULL BEGIN DROP TABLE #TableA END 
		IF OBJECT_ID ('tempdb..#TableB') IS NOT NULL BEGIN DROP TABLE #TableB END 

		CREATE TABLE #TableA (
		[TABLE_NAME] VARCHAR (300) NOT NULL,
		[COLUMN_NAME] VARCHAR (300) NOT NULL,
		[DATA_TYPE] VARCHAR (30) NOT NULL,
		[CHARACTER_MAXIMUM_LENGTH] NVARCHAR (MAX) NOT NULL,
		[IS_NULLABLE] VARCHAR (3) NOT NULL,
		[ORDINAL_POSITION] VARCHAR (3) NOT NULL
		)
		
		CREATE TABLE #TableB (
		[TABLE_NAME] VARCHAR (300) NOT NULL,
		[COLUMN_NAME] VARCHAR (300) NOT NULL,
		[DATA_TYPE] VARCHAR (30) NOT NULL,
		[CHARACTER_MAXIMUM_LENGTH] NVARCHAR (MAX) NOT NULL,
		[IS_NULLABLE] VARCHAR (3) NOT NULL,
		[ORDINAL_POSITION] VARCHAR (3) NOT NULL
		)

		DECLARE @Compare NVARCHAR(MAX);
		SET @Compare = N'
		INSERT INTO #TableA
		SELECT 
		[TABLE_NAME] AS [TABLE_NAME]
		,[COLUMN_NAME] AS [COLUMN_NAME]
		,[DATA_TYPE] AS [DATA_TYPE]
		,ISNULL(CAST([CHARACTER_MAXIMUM_LENGTH] as varchar(100)),''NULL'') AS [CHARACTER_MAXIMUM_LENGTH]
		,[IS_NULLABLE] AS [IS_NULLABLE]
		,[ORDINAL_POSITION] AS [ORDINAL_POSITION]
		FROM ['+@SourceDatabaseName+'].INFORMATION_SCHEMA.COLUMNS
		WHERE TABLE_NAME = '''+@SourceTableName_Loop2+''' and TABLE_SCHEMA = ''dbo''
		ORDER BY [ORDINAL_POSITION] ASC

		INSERT INTO #TableB
		SELECT 
		[TABLE_NAME] AS [TABLE_NAME]
		,[COLUMN_NAME] AS [COLUMN_NAME]
		,[DATA_TYPE] AS [DATA_TYPE]
		,ISNULL(CAST([CHARACTER_MAXIMUM_LENGTH] as varchar(100)),''NULL'') AS [CHARACTER_MAXIMUM_LENGTH]
		,[IS_NULLABLE] AS [IS_NULLABLE]
		,[ORDINAL_POSITION] AS [ORDINAL_POSITION]
		FROM ['+@SubscriberDatabaseName+'].INFORMATION_SCHEMA.COLUMNS
		WHERE TABLE_NAME = '''+@SubscriberTableName_Loop2+''' and TABLE_SCHEMA = ''dbo''
		ORDER BY [ORDINAL_POSITION] ASC'

		EXEC SP_EXECUTESQL @Compare

		UPDATE #TableA SET [TABLE_NAME] = REPLACE([TABLE_NAME],@SourcePartnerID,'@PartnerID@')
		UPDATE #TableB SET [TABLE_NAME] = REPLACE([TABLE_NAME],@SubscriberPartnerID,'@PartnerID@')

		/*to view all: SELECT #TableA.*, #TableB.* FROM...*/
		IF (
		SELECT COUNT(1) 
		FROM #TableA
		FULL JOIN #TableB 
		ON (
		#TableA.[ORDINAL_POSITION] = #TableB.[ORDINAL_POSITION]
		)
		WHERE  
		#TableA.[TABLE_NAME] COLLATE SQL_Latin1_General_CP1_CS_AS != #TableB.[TABLE_NAME] COLLATE SQL_Latin1_General_CP1_CS_AS
		OR #TableA.[COLUMN_NAME] != #TableB.[COLUMN_NAME]
		OR #TableA.[DATA_TYPE] != #TableB.[DATA_TYPE]
		OR #TableA.[CHARACTER_MAXIMUM_LENGTH] != #TableB.[CHARACTER_MAXIMUM_LENGTH]
		OR #TableA.[IS_NULLABLE] != #TableB.[IS_NULLABLE]
		) > 0
		BEGIN
			/*Update PK=0 to indicate that the table structure does not match in Source & Subscriber*/
			UPDATE #PTISetup_TableList SET HasPrimaryKey=0 WHERE SourceTableName=@SourceTableName_Loop2
		END	
	
		UPDATE #PTISetup_TableList SET Processed=1 WHERE SourceTableName=@SourceTableName_Loop2
		
	END

	/*Raise @ErrorMessage if any table has a dissimilar table structure between the Source and Subscriber.*/
	IF (SELECT COUNT(1) FROM #PTISetup_TableList WHERE [HasPrimaryKey]=0) != 0
	BEGIN
	SELECT @ErrorMessage_TableNames=COALESCE(@ErrorMessage_TableNames+ ',' , '' ) + SubscriberTableName 
	FROM #PTISetup_TableList
	WHERE [HasPrimaryKey]=0
	ORDER BY SubscriberTableName

	SET @ErrorMessage=(SELECT N'Error--Table structure do(es) not match in Source & Subscriber:  {'+RIGHT(@ErrorMessage_TableNames,LEN(@ErrorMessage_TableNames)-1)+'}')
	END

END  /*End of Section4*/


Print 'Section 5'
/* ======== | Section 5: Setup PTI | ============= */

/*NAR:  IF NO ERRORS WERE RAISED, continue with PTI Setup*/

IF @ErrorMessage='' 
BEGIN

/*
NAR:  For efficiency, drop columns from #PTISetup_TableList if not being used later. 
i.e. Drop all columns, except for SourceTableName and Processed.
*/
ALTER TABLE #PTISetup_TableList DROP COLUMN SubscriberTableName, HasPrimaryKey

/*Put the @PartnerID@ back in place from where we switched it with the SourcePartnerID earlier*/
UPDATE #PTISetup_TableList
SET SourceTableName=REPLACE(SourceTableName,@SourcePartnerID,'@PartnerID@')

/*Reset [#PTISetup_TableList].[Processed]=0 */
UPDATE #PTISetup_TableList
SET Processed=0

WHILE (SELECT TOP 1 1 FROM #PTISetup_TableList WHERE Processed=0)=1
BEGIN
	DECLARE @TableName_1 varchar(300);
	SET @TableName_1=(SELECT TOP 1 [SourceTableName] FROM #PTISetup_TableList WHERE Processed=0)

/*
Angel and Kevin:  In Section4, we validate SourceTableName and SubscriberTableName for case-sensitivity, 
which allows us to do this loop using either one of them.
We could optionally comment out TABLE_NAME in the WHERE clauses of Section4, and instead add @TableName_2 here(filled with SubscriberTableName).
This may fool the VB code into accepting the table names when they are not a case-sensitive match between Source and Subscriber.
Let me know what you think.
*/

/*NAR:  Commence PTI setup in a loop, once for each record in #PTISetup_TableList*/
/*********Begin PTI Setup************/
							  
		/*Runs on Subscriber*/DECLARE @SQLCommand_tigPTISources NVARCHAR (MAX);
		/*Runs on Subscriber*/DECLARE @SQLCommand_tigPTIRulesEngine_1 NVARCHAR (MAX);
		/*Runs on Subscriber*/DECLARE @SQLCommand_tigPTIRulesEngine_2 NVARCHAR (MAX);
		/*Runs on Source*/    DECLARE @SQLCommand_tigPTISubscribers NVARCHAR (MAX);
		/*Runs on tempdb*/    DECLARE @SQLCommand_SnapshotIsolation_tempdb NVARCHAR (MAX);
		/*Runs on Subscriber*/DECLARE @SQLCommand_SnapshotIsolation_Subscriber NVARCHAR (MAX);
		/*Runs on Source*/    DECLARE @SQLCommand_SnapshotIsolation_Source NVARCHAR (MAX);
		/*Runs on Source*/    DECLARE @SQLCommand_EnableChangeTracking_SourceDB NVARCHAR(MAX);
		/*Runs on Source*/    DECLARE @SQLCommand_EnableChangeTracking_SourceTable NVARCHAR(MAX);
		/*Runs on Source*/    DECLARE @SQLCommand_usp_InsertIntoChangeTrackingTable NVARCHAR (MAX);
		/*Runs on Source*/    DECLARE @SQLCommand_TurnOnPTI NVARCHAR (MAX);

		DECLARE @N varchar (1);
		DECLARE @Priority varchar (1);
		
		SET @N='N';
		SET @Priority=''
		
		/*A high-dollar client may be priority 1; we give this client's newest subscribers the same priority level as the previous PTI setups for this table*/
		DECLARE @QueryForPreExistingPriority NVARCHAR(MAX);
		SET @QueryForPreExistingPriority=
		('SELECT @input_Priority=
		(SELECT top 1 [Priority] FROM ['+@SourceDatabaseName+'].[dbo].[tigPTISubscribers] ptiSubscribers
		WHERE ptiSubscribers.[PartnerId]='+@SourcePartnerID+'
		AND ptiSubscribers.[DestinationPartnerId]='+@SubscriberPartnerID+'
		AND ptiSubscribers.[TableName]='''+@TableName_1+'''
		ORDER BY Priority ASC
		)
		')
		EXEC SP_EXECUTESQL @QueryForPreExistingPriority,  N'@input_Priority VARCHAR (1) output', @Priority output

		IF @Priority IS NULL OR @Priority=''
		BEGIN
		SET @Priority='2'
		END


		/* === | Runs on Subscriber | === */
		/*
		We delete before inserting the same record for two reasons:
		  --to remove duplicates which may have occurred during a manual PTI Setup.
		  --to remove any table name which is not a case-sensitive match to the table in system.
		Kevin: Could you please consider the WHERE clauses? Are there any considerations missed regarding Priority, DeletedFlag and KeepDuringRollback?
		We will use MultiScript to search lab and prod for examples.
		*/
		SET @SQLCommand_tigPTISources =
		N'USE [ipmaster] 
		
		DELETE FROM ['+@SubscriberDatabaseName+'].[dbo].[tigPTISources]
		WHERE  
		[PartnerId]='+@SubscriberPartnerID+'
		AND [SourcePartnerId]='+@SourcePartnerID+'
		AND [TableName]='''+@TableName_1+''' 
		/*AND [Priority]='+@Priority+'*/
		AND [DeletedFlag]='''+@N+'''
		AND [KeepDuringRollback]='''+@N+'''
		
		INSERT INTO ['+@SubscriberDatabaseName+'].[dbo].[tigPTISources]
		(  
		PartnerId,EffDate,SourcePartnerId,TableName,Priority,DeletedFlag,KeepDuringRollback
		)
		SELECT  
		'+@SubscriberPartnerID+' AS [PartnerId]
		,GETDATE() AS [EffDate]
		,'+@SourcePartnerID+' AS [SourcePartnerId]
		,'''+@TableName_1+''' AS [TableName]
		,'+@Priority+' AS [Priority]
		,'''+@N+''' AS [DeletedFlag]
		,'''+@N+''' AS [KeepDuringRollback]
		WHERE NOT EXISTS 
		(
		SELECT TOP 1 1 
		FROM ['+@SubscriberDatabaseName+'].[dbo].[tigPTISources] ptiSources WITH (NOLOCK)
		WHERE ptiSources.[PartnerId]='+@SubscriberPartnerID+'
		AND ptiSources.[SourcePartnerId]='+@SourcePartnerID+'
		AND ptiSources.[TableName]='''+@TableName_1+'''
		)'

		SET @SQLCommand_tigPTIRulesEngine_1 =
		N'USE [ipmaster] 
		
		DELETE FROM ['+@SubscriberDatabaseName+'].[dbo].[tigPTIRulesEngine]
		WHERE
		[PartnerId]='+@SubscriberPartnerID+' 
		AND [SourcePartnerId]='+@SourcePartnerID+' 
		AND [TableName]='''+@TableName_1+''' 
		AND [RuleOrder]=1 
		AND [SQLGuid]=''511586AF-7D9B-4C6B-9F4A-C9D76324797B'' 
		AND [DeletedFlag]='''+@N+''' 
		AND [KeepDuringRollBack]='''+@N+''' 
		
		INSERT INTO ['+@SubscriberDatabaseName+'].[dbo].[tigPTIRulesEngine]
		( 
		PartnerId,EffDate,SourcePartnerId,TableName,RuleOrder,SQLGuid,DeletedFlag,KeepDuringRollBack
		) 
		SELECT
		'+@SubscriberPartnerID+' AS [PartnerId]
		,GETDATE() AS [EffDate]
		,'+@SourcePartnerID+' AS [SourcePartnerId]
		,'''+@TableName_1+''' AS [TableName]
		,1 AS [RuleOrder]
		,''511586AF-7D9B-4C6B-9F4A-C9D76324797B'' AS [SQLGuid]
		,'''+@N+''' AS [DeletedFlag]
		,'''+@N+''' AS [KeepDuringRollBack]
		WHERE NOT EXISTS 
		(
		SELECT TOP 1 1 
		FROM ['+@SubscriberDatabaseName+'].[dbo].[tigPTIRulesEngine] ptiRules
		WHERE ptiRules.[PartnerId]='+@SubscriberPartnerID+'
		AND ptiRules.[SourcePartnerId]='+@SourcePartnerID+'
		AND ptiRules.[TableName]='''+@TableName_1+'''
		AND ptiRules.[RuleOrder]=1
		)'

		SET @SQLCommand_tigPTIRulesEngine_2 =
		N'USE [ipmaster] 
		
		DELETE FROM ['+@SubscriberDatabaseName+'].[dbo].[tigPTIRulesEngine]
		WHERE
		[PartnerId]='+@SubscriberPartnerID+' 
		AND [SourcePartnerId]='+@SourcePartnerID+' 
		AND [TableName]='''+@TableName_1+''' 
		AND [RuleOrder]=2 
		AND [SQLGuid]=''06D8EDFF-CD4F-4444-BBEA-41C8A6122425'' 
		AND [DeletedFlag]='''+@N+''' 
		AND [KeepDuringRollBack]='''+@N+'''
		
		INSERT INTO ['+@SubscriberDatabaseName+'].[dbo].[tigPTIRulesEngine]
		( 
		PartnerId,EffDate,SourcePartnerId,TableName,RuleOrder,SQLGuid,DeletedFlag,KeepDuringRollBack
		) 
		SELECT
		'+@SubscriberPartnerID+' AS [PartnerId]
		,GETDATE() AS [EffDate]
		,'+@SourcePartnerID+' AS [SourcePartnerId]
		,'''+@TableName_1+''' AS [TableName]
		,2 AS [RuleOrder]
		,''06D8EDFF-CD4F-4444-BBEA-41C8A6122425'' AS [SQLGuid]
		,'''+@N+''' AS [DeletedFlag]
		,'''+@N+''' AS [KeepDuringRollBack]
		WHERE NOT EXISTS
		(
		SELECT TOP 1 1 
		FROM ['+@SubscriberDatabaseName+'].[dbo].[tigPTIRulesEngine] ptiRules
		WHERE ptiRules.[PartnerId]='+@SubscriberPartnerID+'
		AND ptiRules.[SourcePartnerId]='+@SourcePartnerID+'
		AND ptiRules.[TableName]='''+@TableName_1+'''
		AND ptiRules.[RuleOrder]=2
		)'

		/*Runs on Source*/
		SET @SQLCommand_tigPTISubscribers =
		N'USE [ipmaster] 
		
		DELETE FROM ['+@SourceDatabaseName+'].[dbo].[tigPTISubscribers]
		WHERE
		[PartnerId]='+@SourcePartnerID+'
		AND [DestinationPartnerId]='+@SubscriberPartnerID+' 
		AND [TableName]='''+@TableName_1+'''
		/*AND [Priority]='+@Priority+'*/
		AND [DeletedFlag]='''+@N+'''
		AND [KeepDuringRollback]='''+@N+'''
		
		INSERT INTO ['+@SourceDatabaseName+'].[dbo].[tigPTISubscribers]
		( 
		PartnerId,EffDate,DestinationPartnerId,TableName,Priority,DeletedFlag,KeepDuringRollback
		)
		SELECT 
		'+@SourcePartnerID+' AS [PartnerId]
		,GETDATE() AS [EffDate]
		,'+@SubscriberPartnerID+' AS [DestinationPartnerId]
		,'''+@TableName_1+''' AS [TableName]
		,'+@Priority+' AS [Priority]
		,'''+@N+''' AS [DeletedFlag]
		,'''+@N+''' AS [KeepDuringRollback]
		WHERE NOT EXISTS 
		(
		SELECT TOP 1 1 
		FROM ['+@SourceDatabaseName+'].[dbo].[tigPTISubscribers] ptiSubscribers
		WHERE ptiSubscribers.[PartnerId]='+@SourcePartnerID+'
		AND ptiSubscribers.[DestinationPartnerId]='+@SubscriberPartnerID+'
		AND ptiSubscribers.[TableName]='''+@TableName_1+'''
		)'

		/* === | Turns on Snapshot Isolation for tempdb, Source and Subscriber databases | === */
		SET @SQLCommand_SnapshotIsolation_tempdb =
		N'USE [ipmaster] ALTER DATABASE  [tempdb] SET ALLOW_SNAPSHOT_ISOLATION ON'

		SET @SQLCommand_SnapshotIsolation_Subscriber =
		N'USE [ipmaster] ALTER DATABASE  ['+@SubscriberDatabaseName+'] SET ALLOW_SNAPSHOT_ISOLATION ON'

		SET @SQLCommand_SnapshotIsolation_Source=
		N'USE [ipmaster] ALTER DATABASE  ['+@SourceDatabaseName+'] SET ALLOW_SNAPSHOT_ISOLATION ON'

		/* === | Enable Change Tracking on Source DATABASE | === */
		SET @SQLCommand_EnableChangeTracking_SourceDB=
		N'USE [ipmaster] ALTER DATABASE ['+@SourceDatabaseName+'] SET CHANGE_TRACKING=ON'

		/* === | Enable Change Tracking on Source TABLE | === */
		
		/*Enables change tracking on the actual name of table rather than on the @PartnerID@ table name*/
		DECLARE @TableNameWithoutVariable varchar(300);

		IF @TableName_1 LIKE '%@PartnerID@%'
		BEGIN 
		SET @TableNameWithoutVariable=REPLACE(@TableName_1,'@PartnerID@',@SourcePartnerID)
		END
		ELSE 
		BEGIN
		SET @TableNameWithoutVariable=@TableName_1
		END
		
		/*If the table exists in the source database, (if the table has a PK, per earlier query), and change tracking is not enabled on the table, then enable change tracking on the table*/
		SET @SQLCommand_EnableChangeTracking_SourceTable=
		N'USE [ipmaster] IF (select top 1 1 from ['+@SourceDatabaseName+'].information_schema.tables where table_name='''+@TableNameWithoutVariable+''')=1
		BEGIN
		USE ['+@SourceDatabaseName+']

		DECLARE @object_id INT;
		SET @object_id=(SELECT TOP 1 [object_id] FROM SYS.TABLES st WHERE st.[name]='''+@TableNameWithoutVariable+''')

		IF (SELECT top 1 [object_id] FROM SYS.TABLES st WHERE st.[name]='''+@TableNameWithoutVariable+''')=@object_id
		and not exists (
		SELECT 1
		FROM sys.change_tracking_tables sctt
		WHERE sctt.[object_id]=@object_id
		)
		BEGIN
		ALTER TABLE ['+@SourceDatabaseName+'].[dbo].['+@TableNameWithoutVariable+'] ENABLE CHANGE_TRACKING
		END

		END
		'

		/* === | Runs SP on Source | === */
		/*Runs USP insert into ttdChangeTracking*/
		SET @SQLCommand_usp_InsertIntoChangeTrackingTable=
		N'
		USE [ipmaster]

		if not exists (select top 1 1 from ['+@SourceDatabaseName+'].[dbo].[ttdChangeTracking] where TableName ='''+@TableName_1+''')
		begin

		DECLARE @RC INT
		DECLARE @PartnerID@ INT
		DECLARE @TableName@ VARCHAR(255)
		DECLARE @BatchSize@ INT
		DECLARE @NewSync@ BIGINT
		DECLARE @BatchCount@ INT
		DECLARE @DestinationTable@ VARCHAR(255)

		EXECUTE @RC=['+@SourceDatabaseName+'].[dbo].[usp_ChangeTrackingCaptureChanges] 
		'+@SourcePartnerID+'
		,'''+@TableName_1+'''
		,10000
		,@NewSync@ OUTPUT
		,@BatchCount@ OUTPUT
		,@DestinationTable@ OUTPUT
		SELECT @NewSync@, @batchcount@, @DestinationTable@

		end
		'

		/* === | Turns on PTI in Source | === */
		SET @SQLCommand_TurnOnPTI =
		N'UPDATE ct 
		SET ct.[Status]=1
		FROM ['+@SourceDatabaseName+'].[dbo].[ttdChangeTracking] ct
		WHERE ct.[TableName]='''+@TableName_1+''''

		/* ======================= | Execute the above queries | ============================ */ 
		 
		/* === | Inserts into Sources and RulesEngine tables in Subscriber partner | === */

		DECLARE @PTISubscribersDatabaseExistsQuery NVARCHAR(MAX);
		DECLARE @PTISubscribersDatabaseExists INT;
		SET @PTISubscribersDatabaseExistsQuery=('SELECT @input_PTISubscribersDatabaseExists=(SELECT TOP 1 1 FROM [master].sys.databases sd where sd.[name]='''+@SubscriberDatabaseName+''' and sd.[state_desc]=''online'')')
		SET @PTISubscribersDatabaseExists=0
		EXEC SP_EXECUTESQL @PTISubscribersDatabaseExistsQuery,  N'@input_PTISubscribersDatabaseExists INT output', @PTISubscribersDatabaseExists output
			
		DECLARE @PTISourcesTableExistsQuery NVARCHAR(MAX);
		DECLARE @PTISourcesTableExists INT;
		SET @PTISourcesTableExistsQuery=('SELECT @input_PTISourcesTableExists=(SELECT TOP 1 1 FROM ['+@SubscriberDatabaseName+'].sys.tables st where st.[name]=''tigPTISources'')')
		SET @PTISourcesTableExists=0
		EXEC SP_EXECUTESQL @PTISourcesTableExistsQuery,  N'@input_PTISourcesTableExists INT output', @PTISourcesTableExists output
			
		DECLARE @PTIRulesEngineTableExistsQuery NVARCHAR(MAX);
		DECLARE @PTIRulesEngineTableExists INT;
		SET @PTIRulesEngineTableExistsQuery=('SELECT @input_PTIRulesEngineTableExists=(SELECT TOP 1 1 FROM ['+@SubscriberDatabaseName+'].sys.tables st where st.[name]=''tigPTIRulesEngine'')')
		SET @PTIRulesEngineTableExists=0
		EXEC SP_EXECUTESQL @PTIRulesEngineTableExistsQuery,  N'@input_PTIRulesEngineTableExists INT output', @PTIRulesEngineTableExists output
			
		IF @PTISubscribersDatabaseExists=1 and @PTISourcesTableExists=1 and @PTIRulesEngineTableExists=1 
		BEGIN
		EXEC SP_EXECUTESQL @SQLCommand_tigPTISources;
		EXEC SP_EXECUTESQL @SQLCommand_tigPTIRulesEngine_1;
		EXEC SP_EXECUTESQL @SQLCommand_tigPTIRulesEngine_2;
		END
		ELSE
		BEGIN
		SET @ErrorMessage='Contact DBA.  One or more not found:  '+@SubscriberDatabaseName+', tigPTISources or tigPTIRulesEngine.'
		END

		/* === | Inserts into Subscribers table in Source partner | === */

		DECLARE @PTISourcesDatabaseExistsQuery NVARCHAR(MAX);
		DECLARE @PTISourcesDatabaseExists INT;
		SET @PTISourcesDatabaseExistsQuery=('SELECT @input_PTISourcesDatabaseExists=(SELECT TOP 1 1 FROM [master].sys.databases sd where sd.[name]='''+@SourceDatabaseName+''' and sd.[state_desc]=''online'')')
		SET @PTISourcesDatabaseExists=0
		EXEC SP_EXECUTESQL @PTISourcesDatabaseExistsQuery,  N'@input_PTISourcesDatabaseExists INT output', @PTISourcesDatabaseExists output

		DECLARE @PTISubscribersTableExistsQuery NVARCHAR(MAX);
		DECLARE @PTISubscribersTableExists INT;
		SET @PTISubscribersTableExistsQuery=('SELECT @input_PTISubscribersTableExists=(SELECT TOP 1 1 FROM ['+@SubscriberDatabaseName+'].sys.tables st where st.[name]=''tigPTISubscribers'')')
		SET @PTISubscribersTableExists=0
		EXEC SP_EXECUTESQL @PTISubscribersTableExistsQuery,  N'@input_PTISubscribersTableExists INT output', @PTISubscribersTableExists output

		IF @PTISourcesDatabaseExists=1 and @PTISubscribersTableExists=1
		BEGIN
		EXEC SP_EXECUTESQL @SQLCommand_tigPTISubscribers;
		END
		ELSE
		BEGIN
		SET @ErrorMessage='Contact DBA.  One or more not found:  '+@SourceDatabaseName+', tigPTISubscribers.'
		END	

		/* === | Turns on Snapshot Isolation for tempdb, Source and Subscriber databases if snapshot isolation is off | === */
		/*
		/*For tempdb*/
		IF (SELECT TOP 1 1 FROM [master].sys.databases sd WHERE sd.[name]='tempdb' and sd.[state_desc]='online' /*and sd.[snapshot_isolation_state]=0*/)=1
		BEGIN
		EXEC SP_EXECUTESQL @SQLCommand_SnapshotIsolation_tempdb
		END
		ELSE
		BEGIN
		SET @ErrorMessage='Could not turn on SnapshotIsolation for tempdb:  [tempdb] not found.'
		END
		*/
		/*For Subscriber*/
		IF (SELECT TOP 1 1 FROM [master].sys.databases sd WHERE sd.[name]=@SubscriberDatabaseName and sd.[state_desc]='online' /*and sd.[snapshot_isolation_state]=0*/)=1
		BEGIN
		EXEC SP_EXECUTESQL @SQLCommand_SnapshotIsolation_Subscriber
		END
		ELSE
		BEGIN
		SET @ErrorMessage='Could not turn on SnapshotIsolation for Subscriber:  '+@SubscriberDatabaseName+'.  Subscriber not found.'
		END
		/*For Source*/
		IF (SELECT TOP 1 1 FROM [master].sys.databases sd WHERE sd.[name]=@SourceDatabaseName and sd.[state_desc]='online' /*and sd.[snapshot_isolation_state]=0*/)=1
		BEGIN
		EXEC SP_EXECUTESQL @SQLCommand_SnapshotIsolation_Source
		END
		ELSE
		BEGIN
		SET @ErrorMessage='Could not turn on SnapshotIsolation for Source:  '+@SourceDatabaseName+'.  Source not found.'
		END

		/* === | Enable Change Tracking (CT) on Source DATABASE if the db exists and CT is not enabled | === */
		if (select top 1 1 from [master].sys.databases sd
		where sd.[name]=@SourceDatabaseName and sd.[state_desc]='online'
		and not exists (
		select 1 from [master].sys.change_tracking_databases sctd
		where sd.database_id=sctd.database_id
		))=1
		BEGIN
		EXEC SP_EXECUTESQL @SQLCommand_EnableChangeTracking_SourceDB
		END

		/* === | Enables Change Tracking on Source TABLE | === */

		/*IF source database exists and both snapshot isolation and change tracking are on for the database, run query to enable change tracking on a table in the source database*/
		IF (
		SELECT TOP 1 1 FROM [master].sys.databases sd WHERE sd.[name]=@SourceDatabaseName and sd.[snapshot_isolation_state]=1 and sd.[state_desc]='online'
		AND exists (select 1 from [master].sys.change_tracking_databases sctd where sd.database_id=sctd.database_id)
		)=1
		BEGIN
		EXEC SP_EXECUTESQL @SQLCommand_EnableChangeTracking_SourceTable
		END

		DECLARE @PTIChangeTrackingTableExistsQuery NVARCHAR(MAX);
		DECLARE @PTIChangeTrackingTableExists INT;
		SET @PTIChangeTrackingTableExistsQuery=('SELECT @input_PTIChangeTrackingTableExists=(SELECT TOP 1 1 FROM ['+@SourceDatabaseName+'].sys.tables st where st.[name]=''ttdChangeTracking'')')
		SET @PTIChangeTrackingTableExists=0
		EXEC SP_EXECUTESQL @PTIChangeTrackingTableExistsQuery,  N'@input_PTIChangeTrackingTableExists INT output', @PTIChangeTrackingTableExists output

		if @PTIChangeTrackingTableExists=1
		begin
		EXEC SP_EXECUTESQL @SQLCommand_usp_InsertIntoChangeTrackingTable
		EXEC SP_EXECUTESQL @SQLCommand_TurnOnPTI
		end

/*********End PTI Setup************/
UPDATE #PTISetup_TableList SET Processed=1 WHERE SourceTableName=@TableName_1
END

IF @ErrorMessage=''
BEGIN
SET @ErrorMessage='Success: PTI Setup is complete.  Please test PTI.'
END

END /*End of Section5*/


Print 'Section 6'
/* ======== | Section 6: Output | ============= */
/*Return this variable*/
if @ErrorMessage<>''
BEGIN
SELECT @ErrorMessage
END

IF OBJECT_ID ('tempdb..#PTISetup_TableList') IS NOT NULL BEGIN DROP TABLE #PTISetup_TableList END 
IF OBJECT_ID ('tempdb..#TableA') IS NOT NULL BEGIN DROP TABLE #TableA END 
IF OBJECT_ID ('tempdb..#TableB') IS NOT NULL BEGIN DROP TABLE #TableB END 

Print 'Done. End of script.'


go
USE [ipmaster]
GO

/****** Object:  StoredProcedure [dbo].[usp_PTISetupRemoval]    Script Date: 9/21/2020 5:23:22 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO









if (select top 1 1 from sys.procedures where name='usp_PTISetupRemoval') = 1
	begin
	print('Dropping '+'usp_PTISetupRemoval')
	drop procedure usp_PTISetupRemoval
	end
else
	begin
	print('No drop needed for '+'usp_PTISetupRemoval')
	end
	;

	go


CREATE PROCEDURE [dbo].[usp_PTISetupRemoval] 
/*@SourcePartnerID varchar (10),@SubscriberPartnerID varchar (10)--decided to set these from tmfDefaults in Section 1*/
@SourceDatabaseName varchar (50)
,@SubscriberDatabaseName varchar (50)
,@TableNames nvarchar (max)
,@ErrorMessage NVARCHAR (MAX) OUTPUT

AS 
PRINT 'Inside usp_PTISetupRemoval'
PRINT 'VERSION 2019.07.23.NAR'

SET NOCOUNT ON; 

DECLARE @SourcePartnerID varchar (10);
DECLARE @SubscriberPartnerID varchar (10);
DECLARE @RaiseError bit;
DECLARE @ErrorMessage_TableNames NVARCHAR(MAX);

SET @RaiseError=1
SET @ErrorMessage_TableNames=''
SET @ErrorMessage=''

Print 'Section 1'
/* ======== | Section 1: Source & Subscriber Databases Exist | ============= */
/*
VERIFY DATABASE NAME--e.g. Requester should not use an IP Address for the database name.
*/

/*This sanitizes the database names by removing carriage return, line feed, tab and space that occur when a requester executes the procedure with variable inputs stacked, includes by mistake or copies from another application*/
SET @SourceDatabaseName=REPLACE(REPLACE(REPLACE(REPLACE(CAST(@SourceDatabaseName AS VARCHAR(50)), CHAR(13),''), CHAR(10),''), CHAR(9),''), CHAR(32),'')
SET @SubscriberDatabaseName=REPLACE(REPLACE(REPLACE(REPLACE(CAST(@SubscriberDatabaseName AS VARCHAR(50)), CHAR(13),''), CHAR(10),''), CHAR(9),''), CHAR(32),'')

if (SELECT COUNT(1) FROM [master].SYS.DATABASES 
WHERE NAME IN (@SourceDatabaseName,@SubscriberDatabaseName) and state_desc='ONLINE')=2  /*Reading the "Warning" section. For cross-server PTI, change this to 1 and set PartnerIDs.  No other changes required below.  2 requires both partners to be on same server*/
BEGIN
SET @RaiseError=0

/*Get the PartnerID of Source and of Subscriber from tmfDefaults*/
DECLARE @SQLCommand_SourcePartnerIDQuery NVARCHAR(MAX);
SET @SQLCommand_SourcePartnerIDQuery = ('SELECT @input_SourcePartnerID = (SELECT PartnerID FROM ['+@SourceDatabaseName+'].[dbo].[tmfDefaults] WITH (NOLOCK))')
SET @SourcePartnerID = 0
EXEC SP_EXECUTESQL @SQLCommand_SourcePartnerIDQuery,  N'@input_SourcePartnerID varchar (10) output', @SourcePartnerID output

DECLARE @SQLCommand_SubscriberPartnerIDQuery NVARCHAR(MAX);
SET @SQLCommand_SubscriberPartnerIDQuery = ('SELECT @input_SubscriberPartnerID = (SELECT PartnerID FROM ['+@SubscriberDatabaseName+'].[dbo].[tmfDefaults] WITH (NOLOCK))')
SET @SubscriberPartnerID = 0
EXEC SP_EXECUTESQL @SQLCommand_SubscriberPartnerIDQuery,  N'@input_SubscriberPartnerID varchar (10) output', @SubscriberPartnerID output
END

IF @RaiseError=1
BEGIN
SET @ErrorMessage='The database names provided were not found.  Examples of database names are: IP_123, TEST_123, SOW_123, etc...'
END  /*End of Section1*/


Print 'Section 2'
/* ======== | Section 2: Tables Exist & Cased as in Database | ============= */
IF @ErrorMessage=''
BEGIN /*Begin Section2: PartA*/

/*
Move the comma-seperated table names from the @TableNames variable into table #PTISetupRemoval_TableList. 
*/

IF OBJECT_ID ('tempdb..#PTISetup_TableList') IS NOT NULL BEGIN DROP TABLE #PTISetup_TableList END 

create table #PTISetupRemoval_TableList
(
SourceTableName	nvarchar (300) NOT NULL,
SubscriberTableName	nvarchar (300) NOT NULL,  /*This is a duplicate list of tables, except with the Subscriber PartnerID*/
Processed BIT NOT NULL,	
HasPrimaryKey BIT NOT NULL
)

INSERT INTO #PTISetupRemoval_TableList
SELECT RESULTS AS [SourceTableName], RESULTS AS [SubscriberTableName], 0 AS [Processed], 0 AS [HasPrimaryKey] FROM dbo.ufn_SplitList(@TableNames,',')

/*Sanitize the table names by removing carriage return, line feed, tab and space that occur when a requester executes the procedure with variable inputs vertically stacked, includes by mistake or copies from another application*/
UPDATE #PTISetupRemoval_TableList
SET 
[SourceTableName]=REPLACE(REPLACE(REPLACE(REPLACE(CAST([SourceTableName] AS NVARCHAR(MAX)), CHAR(13),''), CHAR(10),''), CHAR(9),''), CHAR(32),''),
[SubscriberTableName]=REPLACE(REPLACE(REPLACE(REPLACE(CAST([SubscriberTableName] AS NVARCHAR(MAX)), CHAR(13),''), CHAR(10),''), CHAR(9),''), CHAR(32),'')

/*Sanitize the table list if a requester were to submit the table schema along with table names*/
UPDATE #PTISetupRemoval_TableList
SET 
SourceTableName=REPLACE(SourceTableName,'dbo.',''),
SubscriberTableName=REPLACE(SubscriberTableName,'dbo.','')

/*Sanitize the table list by removing duplicate table names--such as would occur if a requester submits all of the table names from both Source and Subscriber*/
UPDATE #PTISetupRemoval_TableList
SET 
SourceTableName=REPLACE(SourceTableName,@SourcePartnerID,'@PartnerID@'),
SubscriberTableName=REPLACE(SubscriberTableName,@SourcePartnerID,'@PartnerID@')

UPDATE #PTISetupRemoval_TableList
SET 
SourceTableName=REPLACE(SourceTableName,@SubscriberPartnerID,'@PartnerID@'),
SubscriberTableName=REPLACE(SubscriberTableName,@SubscriberPartnerID,'@PartnerID@')

; WITH CTE_PTI AS( 
SELECT 
tl.[SourceTableName],  
RN=ROW_NUMBER()OVER(PARTITION BY  tl.[SourceTableName] ORDER BY tl.[SourceTableName] asc) 
FROM #PTISetupRemoval_TableList tl 
)
delete CTE_PTI
where RN>1 

/*
Tables with these prefixes are dropped automatically during our normal business process
and should be excluded from PTI setup: backups (bck), temporary (tmp), user (usr) and non-dbo schemas.
*/
if (select count(1) from #PTISetupRemoval_TableList 
where 
[SourceTableName] not like 'txd%' 
AND [SourceTableName] not like 'tmd%' 
AND [SourceTableName] not like 'tmf%' 
AND [SourceTableName] not like 'tmg%' 
AND [SourceTableName] not like 'ttd%' 
)>0
begin
SET @ErrorMessage=(SELECT N'Error--PTI setup allowed for table prefixes:  txd,tmd,tmf,tmg and ttd.  Not allowed: anything else...bck, tmp, usr and non-dbo schema.')
end
END /*End of Section2: PartA*/


if @ErrorMessage=''
begin /*Begin Section2: PartB*/
/*
--VALIDATE THE LIST OF TABLE NAMES--
To verify that the tables exist in their respective partners, replace @PartnerID@ with the PartnerID of either Source or Subscriber in the respective fields)
We'll change this back later so that the PTI setup can commence.

Note that this replaces each table name provided with the case-sensitive table name found in the system (INFORMATION_SCHEMA.TABLES) or else returns @ErrorMessage. 
PTI is not case sentive; however, the VB code is. 
*/

UPDATE #PTISetupRemoval_TableList
SET SourceTableName=REPLACE(SourceTableName,'@PartnerID@',@SourcePartnerID),
SubscriberTableName=REPLACE(SubscriberTableName,'@PartnerID@',@SubscriberPartnerID)

DECLARE @SourceTL NVARCHAR (MAX);
SET @SourceTL=N'UPDATE #PTISetupRemoval_TableList
SET [SourceTableName]=''dbo.''+TABLE_NAME
FROM ['+@SourceDatabaseName+'].INFORMATION_SCHEMA.TABLES
WHERE 
TABLE_SCHEMA=''dbo'' 
AND TABLE_NAME=[SourceTableName]'

if (select top 1 1 from [master].sys.databases where name=@SourceDatabaseName and state_desc='ONLINE')=1
BEGIN 
EXEC SP_EXECUTESQL @SourceTL
END

DECLARE @SubscriberTL NVARCHAR (MAX);  /*Same action for Subscriber*/
SET @SubscriberTL=N'UPDATE #PTISetupRemoval_TableList
SET [SubscriberTableName]=''dbo.''+TABLE_NAME
FROM ['+@SubscriberDatabaseName+'].INFORMATION_SCHEMA.TABLES
WHERE 
TABLE_SCHEMA=''dbo'' 
AND TABLE_NAME=[SubscriberTableName]'

if (select top 1 1 from [master].sys.databases where name=@SubscriberDatabaseName and state_desc='ONLINE')=1
BEGIN 
EXEC SP_EXECUTESQL @SubscriberTL
END

/*
Above, if table exists, we prefix it with the schema 'dbo.'
Now, any TableName in #PTISetupRemoval_TableList that are prefixed with 'dbo.' are in the system, and all others are not in the system.
If any are not in the system, raise @ErrorMessage.
*/
 
----------------------------/*Return list of tables that do not exist in Source*/
IF (
SELECT COUNT(1)
FROM #PTISetupRemoval_TableList 
WHERE [SourceTableName] not like 'dbo.%'
) != 0 and (select top 1 1 from [master].sys.databases where name=@SourceDatabaseName and state_desc='ONLINE')=1
BEGIN

SELECT @ErrorMessage_TableNames=COALESCE(@ErrorMessage_TableNames+ ',' , '' ) + SourceTableName 
FROM #PTISetupRemoval_TableList 
WHERE [SourceTableName] not like 'dbo.%'
ORDER BY SourceTableName

SET @ErrorMessage=(SELECT N'Error--Table(s) do(es) not exist in '+@SourceDatabaseName+':  {'+RIGHT(@ErrorMessage_TableNames,LEN(@ErrorMessage_TableNames)-1)+'}')
END

----------------------------/*Return list of tables that do not exist in Subscriber*/
IF @ErrorMessage='' 
AND (SELECT COUNT(1)
FROM #PTISetupRemoval_TableList 
WHERE [SubscriberTableName] not like 'dbo.%'
) != 0 and (select top 1 1 from [master].sys.databases where name=@SubscriberDatabaseName and state_desc='ONLINE')=1
BEGIN

SELECT @ErrorMessage_TableNames=COALESCE(@ErrorMessage_TableNames+ ',' , '' ) + SubscriberTableName 
FROM #PTISetupRemoval_TableList 
WHERE [SubscriberTableName] not like 'dbo.%'
ORDER BY SubscriberTableName

SET @ErrorMessage=(SELECT N'Error--Table(s) do(es) not exist in '+@SubscriberDatabaseName+':  {'+RIGHT(@ErrorMessage_TableNames,LEN(@ErrorMessage_TableNames)-1)+'}')
END

END /*End of Section2: PartB*/


--skip/* ======== | Section 3: Tables have a Primary Key | ============= */
--skip/* ======== | Section 4: Table Structure Matches in Source & Subscriber | ============= */


Print 'Section 5'
/* ======== | Section 5: Setup PTI | ============= */

/*NAR:  IF NO ERRORS WERE RAISED, continue with PTI Setup*/

IF @ErrorMessage='' 
BEGIN

/*
NAR:  For efficiency, drop columns from #PTISetupRemoval_TableList if not being used later. 
i.e. Drop all columns, except for SourceTableName and Processed.
*/
ALTER TABLE #PTISetupRemoval_TableList DROP COLUMN SubscriberTableName, HasPrimaryKey

/*Put the @PartnerID@ back in place from where we switched it with the SourcePartnerID earlier*/
UPDATE #PTISetupRemoval_TableList
SET SourceTableName=REPLACE(SourceTableName,@SourcePartnerID,'@PartnerID@')

/*Reset [#PTISetupRemoval_TableList].[Processed]=0 */
UPDATE #PTISetupRemoval_TableList
SET Processed=0

/*Remove tables not like dbo.; unexpected to be here after validations, but just in case*/
DELETE FROM #PTISetupRemoval_TableList WHERE SourceTableName NOT LIKE 'dbo.%'

/*Remove the "dbo." which is no longer needed*/
UPDATE #PTISetupRemoval_TableList 
SET SourceTableName=REPLACE(SourceTableName,'dbo.','')

WHILE (SELECT TOP 1 1 FROM #PTISetupRemoval_TableList WHERE Processed=0)=1
BEGIN
	DECLARE @TableName_1 varchar(300);
	SET @TableName_1=(SELECT TOP 1 [SourceTableName] FROM #PTISetupRemoval_TableList WHERE Processed=0)

/*NAR:  Commence PTI setup in a loop, once for each record in #PTISetupRemoval_TableList*/
/*********Begin PTI Setup************/
							  
		/*Runs on Subscriber*/DECLARE @SQLCommand_tigPTISources NVARCHAR (MAX);
		/*Runs on Subscriber*/DECLARE @SQLCommand_tigPTIRulesEngine_1 NVARCHAR (MAX);
		/*Runs on Subscriber*/DECLARE @SQLCommand_tigPTIRulesEngine_2 NVARCHAR (MAX);
		/*Runs on Source*/    DECLARE @SQLCommand_tigPTISubscribers NVARCHAR (MAX);
		/*Runs on tempdb*/    DECLARE @SQLCommand_SnapshotIsolation_tempdb NVARCHAR (MAX);
		/*Runs on Subscriber*/DECLARE @SQLCommand_SnapshotIsolation_Subscriber NVARCHAR (MAX);
		/*Runs on Source*/    DECLARE @SQLCommand_SnapshotIsolation_Source NVARCHAR (MAX);
		/*Runs on Source*/    DECLARE @SQLCommand_EnableChangeTracking_SourceDB NVARCHAR(MAX);
		/*Runs on Source*/    DECLARE @SQLCommand_EnableChangeTracking_SourceTable NVARCHAR(MAX);
		/*Runs on Source*/    DECLARE @SQLCommand_usp_InsertIntoChangeTrackingTable NVARCHAR (MAX);
		/*Runs on Source*/    DECLARE @SQLCommand_TurnOffPTI NVARCHAR (MAX);

		DECLARE @N varchar (1);
		DECLARE @Priority varchar (1);
		
		SET @N='N';
		SET @Priority=''
		
		/*A high-dollar client may be priority 1; we give this client's newest subscribers the same priority level as the previous PTI setups for this table*/
		DECLARE @QueryForPreExistingPriority NVARCHAR(MAX);
		SET @QueryForPreExistingPriority=
		('SELECT @input_Priority=
		(SELECT top 1 [Priority] FROM ['+@SourceDatabaseName+'].[dbo].[tigPTISubscribers] ptiSubscribers
		WHERE ptiSubscribers.[PartnerId]='+@SourcePartnerID+'
		AND ptiSubscribers.[DestinationPartnerId]='+@SubscriberPartnerID+'
		AND ptiSubscribers.[TableName]='''+@TableName_1+'''
		ORDER BY Priority ASC
		)
		')
		EXEC SP_EXECUTESQL @QueryForPreExistingPriority,  N'@input_Priority VARCHAR (1) output', @Priority output

		IF @Priority IS NULL OR @Priority=''
		BEGIN
		SET @Priority='2'
		END


		/* === | Runs on Subscriber | === */
		SET @SQLCommand_tigPTISources =
		N'USE [ipmaster] DELETE FROM ['+@SubscriberDatabaseName+'].[dbo].[tigPTISources]
		WHERE  
		[PartnerId]='+@SubscriberPartnerID+'
		AND [SourcePartnerId]='+@SourcePartnerID+'
		AND [TableName]='''+@TableName_1+''' 
		/*AND [Priority]='+@Priority+'*/
		AND [DeletedFlag]='''+@N+'''
		AND [KeepDuringRollback]='''+@N+'''
		'

		SET @SQLCommand_tigPTIRulesEngine_1 =
		N'USE [ipmaster] DELETE FROM ['+@SubscriberDatabaseName+'].[dbo].[tigPTIRulesEngine]
		WHERE
		[PartnerId]='+@SubscriberPartnerID+' 
		AND [SourcePartnerId]='+@SourcePartnerID+' 
		AND [TableName]='''+@TableName_1+''' 
		AND [RuleOrder]=1 
		AND [SQLGuid]=''511586AF-7D9B-4C6B-9F4A-C9D76324797B'' 
		AND [DeletedFlag]='''+@N+''' 
		AND [KeepDuringRollBack]='''+@N+''' 
		'

		SET @SQLCommand_tigPTIRulesEngine_2 =
		N'USE [ipmaster] DELETE FROM ['+@SubscriberDatabaseName+'].[dbo].[tigPTIRulesEngine]
		WHERE
		[PartnerId]='+@SubscriberPartnerID+' 
		AND [SourcePartnerId]='+@SourcePartnerID+' 
		AND [TableName]='''+@TableName_1+''' 
		AND [RuleOrder]=2 
		AND [SQLGuid]=''06D8EDFF-CD4F-4444-BBEA-41C8A6122425'' 
		AND [DeletedFlag]='''+@N+''' 
		AND [KeepDuringRollBack]='''+@N+''' 
		'

		/*Runs on Source*/
		SET @SQLCommand_tigPTISubscribers =
		N'USE [ipmaster] DELETE FROM ['+@SourceDatabaseName+'].[dbo].[tigPTISubscribers]
		WHERE
		[PartnerId]='+@SourcePartnerID+'
		AND [DestinationPartnerId]='+@SubscriberPartnerID+' 
		AND [TableName]='''+@TableName_1+'''
		/*AND [Priority]='+@Priority+'*/
		AND [DeletedFlag]='''+@N+'''
		AND [KeepDuringRollback]='''+@N+'''
		'

		--SKIP/* === | Turns on Snapshot Isolation for tempdb, Source and Subscriber databases | === */
		--SKIP/* === | Enable Change Tracking on Source DATABASE | === */
		--SKIP/* === | Enable Change Tracking on Source TABLE | === */
		--SKIP/* === | Runs SP on Source | === */
		--SKIP/* === | Turns on PTI in Source | === */
		
		SET @SQLCommand_TurnOffPTI =
		N'DELETE ct FROM ['+@SourceDatabaseName+'].[dbo].[ttdChangeTracking] ct
		WHERE ct.[TableName]='''+@TableName_1+''''

		/* ======================= | Execute the above queries | ============================ */ 
		 
		/* === | Inserts into Sources and RulesEngine tables in Subscriber partner | === */

		DECLARE @PTISubscribersDatabaseExistsQuery NVARCHAR(MAX);
		DECLARE @PTISubscribersDatabaseExists INT;
		SET @PTISubscribersDatabaseExistsQuery=('SELECT @input_PTISubscribersDatabaseExists=(SELECT TOP 1 1 FROM [master].sys.databases sd where sd.[name]='''+@SubscriberDatabaseName+''' and sd.[state_desc]=''online'')')
		SET @PTISubscribersDatabaseExists=0
		EXEC SP_EXECUTESQL @PTISubscribersDatabaseExistsQuery,  N'@input_PTISubscribersDatabaseExists INT output', @PTISubscribersDatabaseExists output
			
		DECLARE @PTISourcesTableExistsQuery NVARCHAR(MAX);
		DECLARE @PTISourcesTableExists INT;
		SET @PTISourcesTableExistsQuery=('SELECT @input_PTISourcesTableExists=(SELECT TOP 1 1 FROM ['+@SubscriberDatabaseName+'].sys.tables st where st.[name]=''tigPTISources'')')
		SET @PTISourcesTableExists=0
		EXEC SP_EXECUTESQL @PTISourcesTableExistsQuery,  N'@input_PTISourcesTableExists INT output', @PTISourcesTableExists output
			
		DECLARE @PTIRulesEngineTableExistsQuery NVARCHAR(MAX);
		DECLARE @PTIRulesEngineTableExists INT;
		SET @PTIRulesEngineTableExistsQuery=('SELECT @input_PTIRulesEngineTableExists=(SELECT TOP 1 1 FROM ['+@SubscriberDatabaseName+'].sys.tables st where st.[name]=''tigPTIRulesEngine'')')
		SET @PTIRulesEngineTableExists=0
		EXEC SP_EXECUTESQL @PTIRulesEngineTableExistsQuery,  N'@input_PTIRulesEngineTableExists INT output', @PTIRulesEngineTableExists output
			
		IF @PTISubscribersDatabaseExists=1 and @PTISourcesTableExists=1 and @PTIRulesEngineTableExists=1 
		BEGIN
		EXEC SP_EXECUTESQL @SQLCommand_tigPTISources;
		EXEC SP_EXECUTESQL @SQLCommand_tigPTIRulesEngine_1;
		EXEC SP_EXECUTESQL @SQLCommand_tigPTIRulesEngine_2;
		END
		ELSE
		BEGIN
		SET @ErrorMessage='Contact DBA.  One or more not found:  '+@SubscriberDatabaseName+', tigPTISources or tigPTIRulesEngine.'
		END

		/* === | Inserts into Subscribers table in Source partner | === */

		DECLARE @PTISourcesDatabaseExistsQuery NVARCHAR(MAX);
		DECLARE @PTISourcesDatabaseExists INT;
		SET @PTISourcesDatabaseExistsQuery=('SELECT @input_PTISourcesDatabaseExists=(SELECT TOP 1 1 FROM [master].sys.databases sd where sd.[name]='''+@SourceDatabaseName+''' and sd.[state_desc]=''online'')')
		SET @PTISourcesDatabaseExists=0
		EXEC SP_EXECUTESQL @PTISourcesDatabaseExistsQuery,  N'@input_PTISourcesDatabaseExists INT output', @PTISourcesDatabaseExists output

		DECLARE @PTISubscribersTableExistsQuery NVARCHAR(MAX);
		DECLARE @PTISubscribersTableExists INT;
		SET @PTISubscribersTableExistsQuery=('SELECT @input_PTISubscribersTableExists=(SELECT TOP 1 1 FROM ['+@SubscriberDatabaseName+'].sys.tables st where st.[name]=''tigPTISubscribers'')')
		SET @PTISubscribersTableExists=0
		EXEC SP_EXECUTESQL @PTISubscribersTableExistsQuery,  N'@input_PTISubscribersTableExists INT output', @PTISubscribersTableExists output

		IF @PTISourcesDatabaseExists=1 and @PTISubscribersTableExists=1
		BEGIN
		EXEC SP_EXECUTESQL @SQLCommand_tigPTISubscribers;
		END
		ELSE
		BEGIN
		SET @ErrorMessage='Contact DBA.  One or more not found:  '+@SourceDatabaseName+', tigPTISubscribers.'
		END	

		--skip/* === | Turns on Snapshot Isolation for tempdb, Source and Subscriber databases if snapshot isolation is off | === */
		--skip/* === | Enable Change Tracking (CT) on Source DATABASE if the db exists and CT is not enabled | === */
		--skip/* === | Enables Change Tracking on Source TABLE | === */

		/* === | Enables Change Tracking on Source TABLE | === */
		EXEC SP_EXECUTESQL @SQLCommand_TurnOffPTI

/*********End PTI Setup************/
UPDATE #PTISetupRemoval_TableList SET Processed=1 WHERE SourceTableName=@TableName_1
END

IF @ErrorMessage=''
BEGIN
SET @ErrorMessage='Success: The removal of PTI Setup is complete.  Please test PTI.'
END

END /*End of Section5*/


Print 'Section 6'
/* ======== | Section 6: Output | ============= */
/*Return this variable*/
if @ErrorMessage<>''
BEGIN
SELECT @ErrorMessage
END

IF OBJECT_ID ('tempdb..#PTISetup_TableList') IS NOT NULL BEGIN DROP TABLE #PTISetup_TableList END 

Print 'Done. End of script.'

go

USE [ipmaster]
GO

/****** Object:  StoredProcedure [dbo].[usp_WebAccess]    Script Date: 9/21/2020 5:23:34 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



if (select top 1 1 from sys.procedures where name='usp_WebAccess') = 1
	begin
	print('Dropping '+'usp_WebAccess')
	drop procedure usp_WebAccess
	end
else
	begin
	print('No drop needed for '+'usp_WebAccess')
	end
	;

	go



CREATE PROCEDURE [dbo].[usp_WebAccess] 
@PartnerIDs NVARCHAR (MAX)              
,@ErrorMessage NVARCHAR (MAX) OUTPUT

AS 

/*
The user runs this on server where the security database resides:
DECLARE @ErrorMessage nvarchar(max)
EXEC [ipMaster].[dbo].[usp_WebAccess]
@PartnerIDs='1,2,3'    /*Automatically includes all PartnerIDs that have security on the server if left blank (less partners where the user should not have access).*/
,@ErrorMessage=@ErrorMessage OUT /*<<--DO NOT ALTER*/

What is it?  
User stored procedure that recognizes a TR employee's Active Directory login, which is the login that allows the employee to connect to a server using Windows Authentication from the SSMS application; 
matches the employee's login within an IPMaster table of employee information...tmgTREmployees (NetworkLogin,FirstName,LastName,Department,Country,UsageCounter); 
loops through all security databases on a server instance to find the PartnerIDs supplied to the procedure; 
backs up, drops and re-adds records in the tables required for the employee to connect to a client website; 
and returns the UserLogin and a randomly assigned password from a password bank (hardcoded in proc).  

The last two digits of the Sum(UsageCounter) of everyone who uses the procedure are considered by a formula that generates a two-digit number that corresponds to a password.  
The procedure recognizes the HSO/DA encryption needs of each security database; and accordingly, inserts either the HSO or DA encrypted password while returning unencrypted login credentials in a string to the employee.

How use?  
Supply a comma delimited list of PartnerIDs to the procedure;
execute the procedure in SSMS on the server where partner security database resides.
SELECT original_login() returns the application login in OpenSQL, which is not in our list of employees; the proc would return the "you are not on our list" error.

Which products?
Works for GTM platform; could soon to work for SCC and ISF also.

Continuation:
This project is an intermediary step toward a long-term solution of creating or utilizing a centralized security hub, such as SAFE, for employees to access client applications.  
The code here could be easily appended as a piece of the larger architecture.
(Could run it from PartnerDB which already has our client inventory and client team lists; concerns over inaccuracy)

Maintenance:
DBA should add and remove TR employees (who require access to client websites) to/from below table upon hire or exit.  
EmployeeActivationChecklist and EmployeeExitChecklist should include the DBA distribution chain or otherwise contact DBA team lead.

CREATE TABLE [IPMaster].[dbo].[tmgTREmployees] (
[NetworkLogin] varchar(80),
[FirstName] varchar(80), 
[LastName] varchar(80),
[Department] varchar(80),
[Country] varchar(2),
[UsageCounter] int,
[EffDate] datetime
);

Author:  Nathan Reich, June 2020


Why I made this procedure (Sales pitch):
This procedure opens the door for employees who need access--immediately when they need it--and closes the door behind them to keep our applications secure.  
It reduces the number of logins to one standard login per employee, retains all the access of prior logins, sets a reasonable timeout for the access and grants appropriate access (per Country and Department) immediately without interrupting any other staff.

We have an assembly line in which we build and maintain revenue-generating client environments.
Any of our 600 plus employees must login to a given client application to perform a brief task.
"I cannot login" wastes time for the customer, client-facing employees and technical staff--these departments: {Professional Services, Customer Success, IT, Release Management, DBA, Systems Engineering} 
I estimate this procedure to save 1-2 hours each day per person who is normally involved in the manual process of getting employees into the application.
This may eliminate a large portion of work done by our India-based Customer Success team (~40 employees) allowing them to take on new responsibilities of greater benefit to TR.
This speeds New Partner Setup, SOWs, Testing, Go Lives and even User Deactivations (because it's easier to find and remove standardized user records)

This procedure:
--eliminates "I cannot login" by giving appropriate access (considers location and level of access appropriate to an employee based on country and department)
--eliminates the distraction of dropping what I am doing (constantly) to help others login.
--increases productivity and opportunity to succeed of all involved (by eliminating up to 25% wasted time each workday)
--gets us to the root of the problem faster when troubleshooting connectivity issues
--safeguards us from legal liability as well as internal and external threats to our operations and brand image (due to unintential access)

Overkill?  No.
Up until now, employees have manually created unlimited logins for themselves with full access, unlimited durations and often the same "Password101!" provided to clients.
These logins merge into other security databases each time we perform a security merge--which is a normal daily task--leaving thousands of "open doors".
Clients can see employee logins during demos and (with little guesswork) login as a TR employee...potentially to a competitor site.
Also, former employees are likely to retain URLs on personal devices and likely to know current employee logins; therefore, it isn't a stretch to assume that former employees can login to client applications as current employees. 
Note that employees have access to OpenSQL through client applications, thus direct access (via cross-db query and loops) to all client database in lab and production...the ability to select, alter, create and drop all data everywhere.

For all the above reasons, I made this procedure.
*/


-----------------------

PRINT 'Inside usp_WebAccess version 7.5.2020 NAR'
SET NOCOUNT ON; 

/*=== |Cleanup Temp Table| ===*/

IF OBJECT_ID('tempdb..#tmp_SecurityDatabases') IS NOT NULL BEGIN DROP TABLE #tmp_SecurityDatabases END

/*=== |DECLARE variables| ===*/

/*Pulls from ORIGINAL_LOGIN()*/
	DECLARE @Network VARCHAR(80); 
	DECLARE @NetworkLogin VARCHAR(80);
/*Used to validate the list of PartnerIDs supplied by the user*/
	DECLARE @ValidatePartnerIDs nvarchar(max);
/*Pulls from [IPMaster].[dbo].[tmgTREmployees]; Department and Country determine location and level of access (Audit Compliance)*/
	DECLARE @FirstName VARCHAR(80);
	DECLARE @LastName VARCHAR(80);
	DECLARE @Department VARCHAR(80);
	DECLARE @Country VARCHAR(2);
/*Built from data in [IPMaster].[dbo].[tmgTREmployees]*/ 
	DECLARE @FirstInitialAndLastName varchar(255);
	DECLARE @FirstNameDotLastName varchar(255);
	DECLARE @LastNameDotFirstName varchar(255);
	DECLARE @ListOfPossibleEmails NVARCHAR (MAX);
/*Used to execute strings within procedure; frequently reused*/	
	DECLARE @SQLCommand NVARCHAR (MAX);
/*Used once for a nested execution of @SQLCommand (bck schema)*/
	DECLARE @UseDatabase NVARCHAR (MAX);
/*Pulls from sys.databases; used in loop*/	
	DECLARE @CurrentDatabase VARCHAR(80);
/*Used to temporarily reassign rather than remove records from the UserPartnerGroup table*/
	DECLARE @PlaceHolderUserGuid varchar(50);
/*Used to create an unnecessary backup of the user records assigned to the user*/
	DECLARE @Date varchar(20);
/*Used to assign a UserPassword randomly from a pool of 20 fixed passwords*/
	DECLARE @SumUsageCounter INT;
	DECLARE @PasswordNumber INT;
	DECLARE @HSOUserPassword varchar(50);
	DECLARE @DAUserPassword varchar(50);
	DECLARE @DecryptedUserPassword varchar(20);

/*=== |SET variables| ===*/
	SET @ErrorMessage=''

	/*Return error message if your network is not in our domain of recognized networks OR if your login is not found in table[IPMaster].[dbo].[tmgTREmployees].*/
	SET @Network=(SELECT LEFT(ORIGINAL_LOGIN(),CHARINDEX('\', ORIGINAL_LOGIN())-1));
	SET @NetworkLogin=(SELECT RIGHT(ORIGINAL_LOGIN(),CHARINDEX('\', REVERSE(ORIGINAL_LOGIN()))-1))

	--PRINT 'test @NetworkLogin: '+@NetworkLogin
	--PRINT 'test @PartnerIDs1: '+CAST(@PartnerIDs AS NVARCHAR(MAX))

	IF @Network NOT IN ('MATTHEWS','IPFRAEQ','IPCLTP10')
	OR (SELECT count(1) FROM [IPMaster].[dbo].[tmgTREmployees] WHERE NetworkLogin=@NetworkLogin)=0
	BEGIN
	set @ErrorMessage='usp_WebAccess Error:  Your name is not on our list of approved users.  Please submit a SNOW task to DBA.  Questions: GTM_DBA@ThomsonReuters.com.'
	END


	IF @ErrorMessage=''
	BEGIN /*Begin : Sanitize PartnerIDs*/

	--PRINT 'test @PartnerIDs2: '+CAST(@PartnerIDs AS NVARCHAR(MAX))

	/*Sanitize inputs.  Removes carriage return, line feed, tab and space that may have been entered by mistake.*/
	SET @PartnerIDs=REPLACE(REPLACE(REPLACE(REPLACE(CAST(@PartnerIDs AS NVARCHAR(MAX)), CHAR(13),''), CHAR(10),''), CHAR(9),''), CHAR(32),'')

	--PRINT 'test @PartnerIDs3: '+CAST(@PartnerIDs AS NVARCHAR(MAX))

	/*Removes a series of commas  e.g. ',,,,,,,,,1,,,,,2,,3,,4,,,,,,,5,6,7,8,9,A,B,C,D,E,' */
	SET @PartnerIDs=REPLACE(@PartnerIDs,',,,',',')
	SET @PartnerIDs=REPLACE(@PartnerIDs,',,',',')
	SET @PartnerIDs=REPLACE(@PartnerIDs,',,,',',')
	SET @PartnerIDs=REPLACE(@PartnerIDs,',,',',')
	
	/*Removes single comma at beginning of string*/
	IF LEFT(@PartnerIDs,1)=','
	BEGIN
	SET @PartnerIDs=RIGHT(@PartnerIDs,LEN(@PartnerIDs)-1)
	END

	/*Removes single comma at end of string*/
	IF RIGHT(@PartnerIDs,1)=','
	BEGIN
	SET @PartnerIDs=LEFT(@PartnerIDs,LEN(@PartnerIDs)-1)
	END

	--PRINT 'test @PartnerIDs4: '+CAST(@PartnerIDs AS NVARCHAR(MAX))

	/*Set error message if string contains any character other than 0 through 9 or other than a comma*/
	SET @ValidatePartnerIDs=REPLACE(@PartnerIDs,',','')
	IF @ValidatePartnerIDs LIKE '%[^0-9]%'
	BEGIN
	SET @ErrorMessage='usp_WebAccess Error:  @PartnerIDs may contain numbers and commas.  Please try again.'
	END

	END /*End : Sanitize PartnerIDs*/

	--PRINT 'test @ValidatePartnerIDs: '+CAST(@ValidatePartnerIDs AS NVARCHAR(MAX))

	IF @ErrorMessage=''
	BEGIN /* Begin : Sanitize inputs pulled from [IPMaster].[dbo].[tmgTREmployees] and set other internal variables*/

	/*Sanitize inputs that are pulled from the employees table by cleaning up the the table*/
	SET @SQLCommand=NULL
	SET @SQLCommand=
	N'UPDATE [IPMaster].[dbo].[tmgTREmployees]
	SET
	NetworkLogin=REPLACE(REPLACE(REPLACE(REPLACE(CAST(NetworkLogin AS VARCHAR(50)), CHAR(13),''''), CHAR(10),''''), CHAR(9),''''), CHAR(32),'''')
	,FirstName=REPLACE(REPLACE(REPLACE(REPLACE(CAST(FirstName AS VARCHAR(50)), CHAR(13),''''), CHAR(10),''''), CHAR(9),''''), CHAR(32),'''')
	,LastName=REPLACE(REPLACE(REPLACE(REPLACE(CAST(LastName AS VARCHAR(50)), CHAR(13),''''), CHAR(10),''''), CHAR(9),''''), CHAR(32),'''')
	,Department=REPLACE(REPLACE(REPLACE(REPLACE(CAST(Department AS VARCHAR(50)), CHAR(13),''''), CHAR(10),''''), CHAR(9),''''), CHAR(32),'''')
	,Country=REPLACE(REPLACE(REPLACE(REPLACE(CAST(Country AS VARCHAR(50)), CHAR(13),''''), CHAR(10),''''), CHAR(9),''''), CHAR(32),'''')
	WHERE NetworkLogin LIKE ''%'+@NetworkLogin+'%'''
	EXEC SP_EXECUTESQL @SQLCommand
	/*The "like" helps us to correct typos in [tmgTREmployees].[NetworkLogin] before we try to pull data based on a particular login*/

	/*Remove duplicates of NetworkLogin from [IPMaster].[dbo].[tmgTREmployees].  The latest entry in [IPMaster].[dbo].[tmgTREmployees] will carry forward; prior entries are deleted.*/
	; WITH CTE AS( 
	SELECT 
	tre.NetworkLogin,  
	RN=ROW_NUMBER()OVER(PARTITION BY tre.NetworkLogin ORDER BY (tre.EffDate) asc) 
	FROM [IPMaster].[dbo].[tmgTREmployees] tre 
	)
	delete cte
	where RN>1 

	SELECT TOP 1 
	@FirstName=FirstName
	,@LastName=LastName
	FROM [IPMaster].[dbo].[tmgTREmployees] WITH (NOLOCK) 
	WHERE NetworkLogin=@NetworkLogin

	/*Uppercase the first letter AND lowercase the remainder of the name TO create standard email address later in this procedure*/
	set @FirstName=(select UPPER(LEFT(@FirstName,1)) + LOWER(RIGHT(@FirstName,RTRIM(LEN(@FirstName)-1))))
	set @LastName=(select UPPER(LEFT(@LastName,1)) + LOWER(RIGHT(@LastName,RTRIM(LEN(@LastName)-1))))

	/*Determine the possible email addresses currently used by the user.  Note: @Cognizant.com was a temparary-employment agency used by TR.  We've been told to search manually rather than include here.*/
	SET @FirstInitialAndLastName=LEFT(@FirstName,1) + @LastName
	SET @FirstNameDotLastName=@FirstName + '.' + @LastName
	SET @LastNameDotFirstName=@LastName + '.' + @FirstName
	SET @ListOfPossibleEmails=(''''+ 
			  @FirstInitialAndLastName +'@integrationpoint.net'
	+''','''+ @FirstInitialAndLastName +'@integrationpoint.com'
	+''','''+ @FirstInitialAndLastName +'@integrationpoint.org'
	+''','''+ @FirstNameDotLastName +'@integrationpoint.net'
	+''','''+ @FirstNameDotLastName +'@integrationpoint.com'
	+''','''+ @FirstNameDotLastName +'@integrationpoint.org'
	+''','''+ @FirstNameDotLastName +'@thomsonreuters.com'
	+''','''+ @FirstNameDotLastName +'@tr.com'
	+''','''+ @LastNameDotFirstName +'@integrationpoint.net'
	+''','''+ @LastNameDotFirstName +'@integrationpoint.com'
	+''','''+ @LastNameDotFirstName +'@integrationpoint.org'
	+''','''+ @LastNameDotFirstName +'@thomsonreuters.com'
	+''','''+ @LastNameDotFirstName +'@tr.com'
	+'''')

	--PRINT 'test @ListOfPossibleEmails: '+@ListOfPossibleEmails

	/*Used to assign the old tmgUserPartnerGroup records back to the new user so that all previous group access is kept*/
	SET @PlaceHolderUserGuid=CAST(NEWID() AS VARCHAR(50));

	--PRINT 'test @PlaceHolderUserGuid: '+@PlaceHolderUserGuid

	/*Used to create a backup table for the old tmgUser records related to the employee*/
	SET @Date=CAST(GETDATE() AS VARCHAR(20));
	SET @Date=Replace(REPLACE(Replace(REPLACE(@Date,'-',''),' ',''),':',''),'.','')

	--PRINT 'test @Date: '+CAST(@Date AS VARCHAR(20))

	SET @HSOUserPassword=''
	SET @DAUserPassword=''

	END/*End : Sanitize inputs pulled from [IPMaster].[dbo].[tmgTREmployees] and SET other internal variables*/


	
	IF @ErrorMessage=''
	BEGIN /*Begin : Assign a UserPassword randomly from a pool of 20 fixed passwords.  The randomness is based on calculations with the ending digits of sum(UsageCounter), so that the password is based on usage as well as even and odd numbers. */
	
	/*Cleanup the [UsageCounter] field by setting null values to zero*/
	UPDATE [IPMaster].[dbo].[tmgTREmployees] 
	SET UsageCounter=ISNULL(UsageCounter,0)

	/*Update the [UsageCounter] field, which counts the number of times this employee has used this procedure.*/
	SET @SQLCommand=NULL
	SET @SQLCommand=
	N'
	UPDATE [IPMaster].[dbo].[tmgTREmployees] 
	SET UsageCounter=
	(CASE 
	WHEN UsageCounter>=0 THEN UsageCounter+1  
	ELSE 0  
	END)
	WHERE NetworkLogin='''+@NetworkLogin+'''
	'
	EXECUTE SP_EXECUTESQL @SQLCommand;

	SET @SumUsageCounter=0
	SET @PasswordNumber=0
	SET @SumUsageCounter=(SELECT SUM(UsageCounter) FROM [IPMaster].[dbo].[tmgTREmployees] WITH (NOLOCK))

	/*Assign a number between 10 and 29 as the @PasswordNumber, which corresponds to a fixed @UserPassword.*/
	IF @SumUsageCounter<=9
	BEGIN
	SET @PasswordNumber=(10+@SumUsageCounter)
	END

	IF @SumUsageCounter>9
	BEGIN /*Begin : @SumUsageCounter>9*/
	
	IF LEFT(RIGHT(@SumUsageCounter,2),1) IN (1,3)
	BEGIN
	SET @PasswordNumber=10
	END

	IF LEFT(RIGHT(@SumUsageCounter,2),1) IN (5,7)
	BEGIN
	SET @PasswordNumber=20
	END

	IF LEFT(RIGHT(@SumUsageCounter,2),1) IN (2,4)
	BEGIN
	SET @PasswordNumber=30
	END

	IF LEFT(RIGHT(@SumUsageCounter,2),1) IN (6,8)
	BEGIN
	SET @PasswordNumber=40
	END

	IF LEFT(RIGHT(@SumUsageCounter,2),1) IN (9)
	BEGIN
	SET @PasswordNumber=50
	END
	
	SET @PasswordNumber=@PasswordNumber+RIGHT(@SumUsageCounter,1)
	
	END /*End : @SumUsageCounter>9*/
	
	SET @HSOUserPassword=''
	SET @DAUserPassword=''

	/*
	NAR: For improvements, could create random passwords (that would foil a dictionary attack) and ask SysEng to HSO and DA encrypt all 50.  
	My grocery list of passwords are commonplace, non-offensive, user-friendly passwords to assure that only a handful of users should share the same password, until first login.
	Login would occur within 30 days or else the record is wil be out of date.
	 */

	IF @PasswordNumber=10 BEGIN SET @HSOUserPassword='1mUDHZdZIcv2tlu1A9Ghqg=='; SET @DAUserPassword='(Pn^ee*bg&f!%12$3'; SET @DecryptedUserPassword='Carrots!123' END
	IF @PasswordNumber=11 BEGIN SET @HSOUserPassword='p7e5y4h4JfaAyz8n/oCRyQ=='; SET @DAUserPassword='*Te(rr^af*&7&89'; SET @DecryptedUserPassword='Greens&789'END
	IF @PasswordNumber=12 BEGIN SET @HSOUserPassword='lKaI4gGu0VNX4r+7FgHvCg=='; SET @DAUserPassword='(Cb^gn*gb&f%%56$7'; SET @DecryptedUserPassword='Potatos%567' END
	IF @PasswordNumber=13 BEGIN SET @HSOUserPassword='aIUaPwpOqSNh0k7gxUtD0g=='; SET @DAUserPassword='*Fn(yn^qf*#3&45'; SET @DecryptedUserPassword='Salads#345' END
	IF @PasswordNumber=14 BEGIN SET @HSOUserPassword='cwEBKCQqb+73hTwjeBYQzw=='; SET @DAUserPassword='^Pu*vp&xr%af$@2^34'; SET @DecryptedUserPassword='Chickens@234' END
	IF @PasswordNumber=15 BEGIN SET @HSOUserPassword='YvIlL0mm9D+j1qwAY+j5Zw=='; SET @DAUserPassword='*Fh(tn^ef**8&76'; SET @DecryptedUserPassword='Sugars*876' END
	IF @PasswordNumber=16 BEGIN SET @HSOUserPassword='vMxeHt6BWBA2nutEloJKbQ=='; SET @DAUserPassword='*By(vi^rf*^6&78'; SET @DecryptedUserPassword='Olives^678' END
	IF @PasswordNumber=17 BEGIN SET @HSOUserPassword='i7uBwIruLpBuJUUiKcAyNQ=='; SET @DAUserPassword='*Oe(rn^qf*%5&67'; SET @DecryptedUserPassword='Breads%567' END
	IF @PasswordNumber=18 BEGIN SET @HSOUserPassword='xOjJbrMmMPCJXAk4apaoww=='; SET @DAUserPassword='%Jn$gr^ez#ry@ba%f$$45@6'; SET @DecryptedUserPassword='Watermelons$456' END
	IF @PasswordNumber=19 BEGIN SET @HSOUserPassword='ragvbLsUVYn4Or3hhUMgCg=='; SET @DAUserPassword='(On^an*an&f#%32$1'; SET @DecryptedUserPassword='Bananas#321' END
	
	IF @PasswordNumber=20 BEGIN SET @HSOUserPassword='DGSQSGTBtet0xiKjVkjwCw=='; SET @DAUserPassword='*Te(nc^rf*)0&98'; SET @DecryptedUserPassword='Grapes)098' END
	IF @PasswordNumber=21 BEGIN SET @HSOUserPassword='7XbBEWzQkv9Mfxdp9IXUjQ=='; SET @DAUserPassword='(Be^na*tr&f@%23$4'; SET @DecryptedUserPassword='Oranges@234' END
	IF @PasswordNumber=22 BEGIN SET @HSOUserPassword='Nf8tLcktkEo+p/0CE/clQQ=='; SET @DAUserPassword='&Pu%bp$by^ng#rf@%5%43'; SET @DecryptedUserPassword='Chocolates%543' END
	IF @PasswordNumber=23 BEGIN SET @HSOUserPassword='KKb0D95FD4Kghf4Icn0A8w=='; SET @DAUserPassword='(Jn^ya*hg&f(%98$7'; SET @DecryptedUserPassword='Walnuts(987' END
	IF @PasswordNumber=24 BEGIN SET @HSOUserPassword='7MxdQQR5VPC5sCSBNMjuKg=='; SET @DAUserPassword='(Sy^bj*re&f!%13$5'; SET @DecryptedUserPassword='Flowers!135' END
	IF @PasswordNumber=25 BEGIN SET @HSOUserPassword='hKhICP4T7AUdcpzFBBpOOQ=='; SET @DAUserPassword='^In*av&yy%nf$$4^68'; SET @DecryptedUserPassword='Vanillas$468' END
	IF @PasswordNumber=26 BEGIN SET @HSOUserPassword='x4q3Ayz0xt1QYTYmQb1b7A=='; SET @DAUserPassword='*Nc(cy^rf*#3&57'; SET @DecryptedUserPassword='Apples#357' END
	IF @PasswordNumber=27 BEGIN SET @HSOUserPassword='fXjWf6I0Hd1quGHNFKTTrQ=='; SET @DAUserPassword='(Cr^np*ur&f%%53$1'; SET @DecryptedUserPassword='Peaches%531' END
	IF @PasswordNumber=28 BEGIN SET @HSOUserPassword='7QFHbI6bVaerhjF5z4lCEw=='; SET @DAUserPassword='(En^vf*va&f^%64$2'; SET @DecryptedUserPassword='Raisins^642' END
	IF @PasswordNumber=29 BEGIN SET @HSOUserPassword='HJnGwBnK1ZnE3q0HER22AA=='; SET @DAUserPassword='(Yr^ag*vy&f(%97$5'; SET @DecryptedUserPassword='Lentils(975' END

	IF @PasswordNumber=30 BEGIN SET @HSOUserPassword='j8TSP+QE2tFvVTDQkz3Ftg=='; SET @DAUserPassword='(Ev*pr(f!^15*9'; SET @DecryptedUserPassword='Rices!159' END
	IF @PasswordNumber=31 BEGIN SET @HSOUserPassword='ht1KlYh29SXmeeBhafM59g=='; SET @DAUserPassword='(Dh^va*bn&f(%95$1'; SET @DecryptedUserPassword='Quinoas(951' END
	IF @PasswordNumber=32 BEGIN SET @HSOUserPassword='369zYOqBatn8RhagBJlDCg=='; SET @DAUserPassword='%Fn$hr^ex#en@hg%f#$75@3'; SET @DecryptedUserPassword='Sauerkrauts#753' END
	IF @PasswordNumber=33 BEGIN SET @HSOUserPassword='JJDAakOFeVpsIYjn/xLhKg=='; SET @DAUserPassword='*Pu&vp%xc$rn^f(#35@7'; SET @DecryptedUserPassword='Chickpeas(357' END
	IF @PasswordNumber=34 BEGIN SET @HSOUserPassword='hzeLp3XTOfjDXGVLLNGjuw=='; SET @DAUserPassword='*Yv&zn%Or$na^f)#98@4'; SET @DecryptedUserPassword='LimaBeans)984' END
	IF @PasswordNumber=35 BEGIN SET @HSOUserPassword='fyVCk2pRC/lJ4UX3uu0v4Q=='; SET @DAUserPassword='(Lb^th*eg&f*%65$7'; SET @DecryptedUserPassword='Yogurts*657' END
	IF @PasswordNumber=36 BEGIN SET @HSOUserPassword='AE+KSDcm9SUSBQrAqh3unQ=='; SET @DAUserPassword='*Ce(ha^rf*&3&24'; SET @DecryptedUserPassword='Prunes&324' END
	IF @PasswordNumber=37 BEGIN SET @HSOUserPassword='p8k63sVZ1d2B9/9p8OTD+w=='; SET @DAUserPassword='(^Gb*zn&gb%rf$^7^86'; SET @DecryptedUserPassword='Tomatoes^786' END
	IF @PasswordNumber=38 BEGIN SET @HSOUserPassword='mtwFKWw48pZAiFb3781cjA=='; SET @DAUserPassword='^Pn*oo&nt%rf$@4^59'; SET @DecryptedUserPassword='Cabbages@459' END
	IF @PasswordNumber=39 BEGIN SET @HSOUserPassword='9W5OPjbZfYgnjZ9cO9uHMQ=='; SET @DAUserPassword='(Zn^fn*yn&f!%56$9'; SET @DecryptedUserPassword='Masalas!569' END

	IF @PasswordNumber=40 BEGIN SET @HSOUserPassword='przVn1cNUtScDi/3BTdo3Q=='; SET @DAUserPassword='(Cv^px*yr&f&%65$3'; SET @DecryptedUserPassword='Pickles&653' END
	IF @PasswordNumber=41 BEGIN SET @HSOUserPassword='8mMC8A/u8rozInRMgOyGdg=='; SET @DAUserPassword='(Gh*an(f%^98*5'; SET @DecryptedUserPassword='Tunas%985' END
	IF @PasswordNumber=42 BEGIN SET @HSOUserPassword='d9UV/cdkcw4Hjf6o/REjDA=='; SET @DAUserPassword='(Or*ng(f@^25*6'; SET @DecryptedUserPassword='Beats@256' END
	IF @PasswordNumber=43 BEGIN SET @HSOUserPassword='WiZxzhcBH+VbRqoGLcZr9Q=='; SET @DAUserPassword='%Pe$na^or#ee@vr%f*$65@8'; SET @DecryptedUserPassword='Cranberries*658' END
	IF @PasswordNumber=44 BEGIN SET @HSOUserPassword='OyNIq0UXrLAaKVtqhvWHmQ=='; SET @DAUserPassword='(On^an*an&f(%45$3'; SET @DecryptedUserPassword='Bananas(453' END
	IF @PasswordNumber=45 BEGIN SET @HSOUserPassword='g7gV8dagjOSrUZDDmlJD3Q=='; SET @DAUserPassword='(Pu^vy*vr&f#%45$8'; SET @DecryptedUserPassword='Chilies#458' END
	IF @PasswordNumber=46 BEGIN SET @HSOUserPassword='6cZPwjZU69PvOc7YD9D7jg=='; SET @DAUserPassword='^Iv*ar&tn%ef$-8^52'; SET @DecryptedUserPassword='Vinegars-852' END
	IF @PasswordNumber=47 BEGIN SET @HSOUserPassword='vIE06nxMzWCs+PR8tIlmMw=='; SET @DAUserPassword='*Jn(gr^ef*!1&25'; SET @DecryptedUserPassword='Waters!125' END
	IF @PasswordNumber=48 BEGIN SET @HSOUserPassword='UwVvf9DnDs0AjOBkDfedeg=='; SET @DAUserPassword='*Cn(fg^nf*%8&54'; SET @DecryptedUserPassword='Pastas%854' END
	IF @PasswordNumber=49 BEGIN SET @HSOUserPassword='ZcDnsCNCAII+/NQmKLeqYg=='; SET @DAUserPassword='(Ph^ee*vr&f&%32$6'; SET @DecryptedUserPassword='Curries&326' END
	
	IF @PasswordNumber=50 BEGIN SET @HSOUserPassword='LaQ4i7vJg5jbSsRmVE5PXA=='; SET @DAUserPassword='(Fn*tr(f!^98*6'; SET @DecryptedUserPassword='Sages!986' END
	IF @PasswordNumber=51 BEGIN SET @HSOUserPassword='E2QM4N6xcTzLAV8J1ITTAg=='; SET @DAUserPassword='*Pv&aa%nz$ba^f^#74@8'; SET @DecryptedUserPassword='Cinnamons^748' END
	IF @PasswordNumber=52 BEGIN SET @HSOUserPassword='b6trES9tGlXMWvYn79KBnA=='; SET @DAUserPassword='*Py(bi^rf*$7&84'; SET @DecryptedUserPassword='Cloves$784' END
	IF @PasswordNumber=53 BEGIN SET @HSOUserPassword='RvTsAyCxhyzY0N0KwBkQhw=='; SET @DAUserPassword='^In*av&yy%nf$^1^24'; SET @DecryptedUserPassword='Vanillas^124' END
	IF @PasswordNumber=54 BEGIN SET @HSOUserPassword='fdIV7/Kv8Vzevg53NyXF5g=='; SET @DAUserPassword='(Tn^ey*vp&f@%14$2'; SET @DecryptedUserPassword='Garlics@142' END
	IF @PasswordNumber=55 BEGIN SET @HSOUserPassword='a/HB/RskQbG6R7FWYbcwnA=='; SET @DAUserPassword='^Zh*fg&ne%qf$*5^21'; SET @DecryptedUserPassword='Mustards*521' END
	IF @PasswordNumber=56 BEGIN SET @HSOUserPassword='QPa7tXInYxklNBfEP0fBww=='; SET @DAUserPassword='&Pb%ev$na^qr#ef@%5%87'; SET @DecryptedUserPassword='Corianders%587' END
	IF @PasswordNumber=57 BEGIN SET @HSOUserPassword='hjefOGUMNn/vSMqCCFz44g=='; SET @DAUserPassword='^Pn*en&jn%lf$#5^23'; SET @DecryptedUserPassword='Caraways#523' END
	IF @PasswordNumber=58 BEGIN SET @HSOUserPassword='KlsZHLK7PwOu5Cl3k1mqMw=='; SET @DAUserPassword='(Fn*yg(f(^58*9'; SET @DecryptedUserPassword='Salts(589' END
	IF @PasswordNumber=59 BEGIN SET @HSOUserPassword='+/zoDunGWgHkfg/62IHshg=='; SET @DAUserPassword='&Ne%gv$pu^bx#rf@&5%47'; SET @DecryptedUserPassword='Artichokes&547' END

	END /*End : Assign a UserPassword randomly from a pool of 20 fixed passwords.  The randomness is based on calculations with the ending digits of sum(UsageCounter), so that the password is based on usage as well as even and odd numbers. */
	
	--PRINT 'test @SumUsageCounter: '+CAST(@SumUsageCounter AS NVARCHAR(MAX))
	--PRINT 'test @PasswordNumber: '+CAST(@PasswordNumber AS VARCHAR(2))



	IF @ErrorMessage=''
	BEGIN /*Begin : Determine in which security databases to drop-and-create users associated to this employee--and then do it.*/

/*=== |Drop and CREATE tmp table| ===*/
/*This holds all databases, until we trim down the list to security databases containing certain tables.*/

	if  object_id('tempdb..#tmp_SecurityDatabases') is not null begin drop table #tmp_SecurityDatabases end

	SELECT  name AS DatabaseName
			,0 AS Processed            /*tracks in which security databases we have searched*/
	INTO    #tmp_SecurityDatabases
	FROM    sys.databases
	WHERE   state_desc='ONLINE' /*the database is online*/
			AND is_read_only=0    /*the database is not read only (e.g. a snapshot)*/
			AND name not in ('tempdb','msdb','model','master')
			AND name not like 'temp%'
/*Above will include temp, archive, and any other type of database; this prevents later transactions from inserting the old user data again.  No protection against tape refreshes, since this does not touch tapes*/

	/*
	This reduces the list of databases  in (#tmp_SecurityDatabases) to only Security DBs that include the PartnerIDs requested by the user.
	*/

	SET @CurrentDatabase=NULL;
	SELECT TOP 1 @CurrentDatabase=DatabaseName
	FROM    #tmp_SecurityDatabases
	WHERE   Processed=0
	WHILE @CurrentDatabase IS NOT NULL 
    BEGIN
		SET @SQLCommand=NULL
		SET @SQLCommand=N'
		IF (SELECT COUNT(*) FROM ['+@CurrentDatabase+'].INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA=''dbo'' AND TABLE_NAME=''tmgUser'')=0
		AND (SELECT COUNT(*) FROM ['+@CurrentDatabase+'].INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA=''dbo'' AND TABLE_NAME=''tUser'')=0
		BEGIN
			DELETE sd FROM #tmp_SecurityDatabases sd WHERE sd.DatabaseName='''+@CurrentDatabase+'''
		END

		IF '+@PartnerIDs+' <>''''
		AND (SELECT COUNT(*) FROM ['+@CurrentDatabase+'].INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA=''dbo'' AND TABLE_NAME=''tmgPartnerDataConnection'')=1
		BEGIN 
			IF (SELECT count(1) FROM ['+@CurrentDatabase+'].[dbo].[tmgPartnerDataConnection] WITH (NOLOCK) WHERE PartnerID IN ('+@PartnerIDs+'))=0
			BEGIN
				DELETE FROM #tmp_SecurityDatabases WHERE DatabaseName='''+@CurrentDatabase+'''
			END
		END

		IF '+@PartnerIDs+' <>''''
		AND (SELECT COUNT(*) FROM ['+@CurrentDatabase+'].INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA=''dbo'' AND TABLE_NAME=''tPartner'')=1
		BEGIN 
			IF (SELECT count(1) FROM ['+@CurrentDatabase+'].[dbo].[tPartner] WITH (NOLOCK) WHERE PartnerID IN ('+@PartnerIDs+'))=0
			BEGIN
				DELETE FROM #tmp_SecurityDatabases WHERE DatabaseName='''+@CurrentDatabase+'''
			END
		END
		'
		EXECUTE SP_EXECUTESQL @SQLCommand;
		--print @SQLCommand;
		--PRINT 'Troubleshoot1'

		UPDATE  #tmp_SecurityDatabases
		SET     Processed=1
		WHERE   DatabaseName=@CurrentDatabase
		
		SET @CurrentDatabase=NULL
		SELECT TOP 1 @CurrentDatabase=DatabaseName
		FROM    #tmp_SecurityDatabases
		WHERE   Processed=0
	END

--SELECT * FROM #tmp_SecurityDatabases
--END /*TROUBLESHOOTING*/

/*
The remaining security databases listed in #tmp_SecurityDatabases provide access to the PartnerIDs requested by the user.
Loop through this list, and execute scripts to drop and add the records required for the user to connect.
Specifically, drop records (in this order) from tmgUserPartnerGroup (update rather than drop), tmgUserCustomization (drop) and tmgUser (drop).  We add the records again in the reverse order.
*/

UPDATE #tmp_SecurityDatabases SET Processed=0

--PRINT 'test Troubleshoot2'

SET @CurrentDatabase=NULL;

--PRINT 'test @CurrentDatabase1:'+ @CurrentDatabase

SELECT TOP 1 @CurrentDatabase=DatabaseName
FROM    #tmp_SecurityDatabases
WHERE   Processed=0

--PRINT 'test @CurrentDatabase2:'+ @CurrentDatabase

WHILE @CurrentDatabase IS NOT NULL 
    BEGIN /*BEGIN @CurrentDatabase loop*/

--PRINT 'test Troubleshoot3'

/*=== | Temporarily Reassign The tmgUserPartnerGroup records | === */  
	/*
	We will use the @PlaceHolderGuid to temporarily assign UPG records of this user to someone who does not exist (create orphaned records) and then assign these records back to the new user.
	We must do this to keep at least one UPG record per user group tied to the partner or else groups could fail to Merge at go live.
	*/
	SET @SQLCommand=NULL
	SET @SQLCommand =
	N'IF '+@PartnerIDs+' !=''''
	AND (SELECT COUNT(*) FROM ['+@CurrentDatabase+'].INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA=''dbo'' AND TABLE_NAME=''tmgUserPartnerGroup'')=1
	AND (SELECT COUNT(*) FROM ['+@CurrentDatabase+'].INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA=''dbo'' AND TABLE_NAME=''tmgUser'')=1
	BEGIN
	UPDATE upg
	SET UserGUID='''+@PlaceHolderUserGuid+'''
	FROM ['+@CurrentDatabase+'].[dbo].[tmgUserPartnerGroup] upg
	WHERE EXISTS 
	(
	SELECT 1 FROM ['+@CurrentDatabase+'].[dbo].[tmgUser] u
	WHERE u.email IN ('+@ListOfPossibleEmails+')
	AND upg.UserGUID=u.UserGUID
	AND u.UserLogin NOT LIKE ''%DPS%''
	AND u.UserLogin NOT LIKE ''%DTS%''
	) AND upg.PartnerID IN ('+@PartnerIDs+')
	END'
	EXEC SP_EXECUTESQL @SQLCommand

	SET @SQLCommand=NULL
	SET @SQLCommand =
	N'IF '+@PartnerIDs+' =''''
	AND (SELECT COUNT(*) FROM ['+@CurrentDatabase+'].INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA=''dbo'' AND TABLE_NAME=''tmgUserPartnerGroup'')=1
	AND (SELECT COUNT(*) FROM ['+@CurrentDatabase+'].INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA=''dbo'' AND TABLE_NAME=''tmgUser'')=1
	BEGIN
	UPDATE upg
	SET UserGUID='''+@PlaceHolderUserGuid+'''
	FROM ['+@CurrentDatabase+'].[dbo].[tmgUserPartnerGroup] upg
	WHERE EXISTS 
	(
	SELECT 1 FROM ['+@CurrentDatabase+'].[dbo].[tmgUser] u
	WHERE u.email IN ('+@ListOfPossibleEmails+')
	AND upg.UserGUID=u.UserGUID
	AND u.UserLogin NOT LIKE ''%DPS%''
	AND u.UserLogin NOT LIKE ''%DTS%''
	)
	END'
	EXEC SP_EXECUTESQL @SQLCommand

	/*Remove user record from tmgUserCustomization*/
	SET @SQLCommand=NULL
	SET @SQLCommand =
	N'IF '+@PartnerIDs+' !=''''
	AND (SELECT COUNT(*) FROM ['+@CurrentDatabase+'].INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA=''dbo'' AND TABLE_NAME=''tmgUserCustomization'')=1
	AND (SELECT COUNT(*) FROM ['+@CurrentDatabase+'].INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA=''dbo'' AND TABLE_NAME=''tmgUser'')=1
	BEGIN
	DELETE uc FROM ['+@CurrentDatabase+'].[dbo].[tmgUserCustomization] uc
	WHERE EXISTS 
	(
	SELECT 1 FROM ['+@CurrentDatabase+'].[dbo].[tmgUser] u
	WHERE u.email IN ('+@ListOfPossibleEmails+')
	AND uc.UserGUID=u.UserGUID
	) AND uc.PartnerID IN ('+@PartnerIDs+')
	END'
	EXEC SP_EXECUTESQL @SQLCommand

	SET @SQLCommand=NULL
	SET @SQLCommand =
	N'IF '+@PartnerIDs+' =''''
	AND (SELECT COUNT(*) FROM ['+@CurrentDatabase+'].INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA=''dbo'' AND TABLE_NAME=''tmgUserCustomization'')=1
	AND (SELECT COUNT(*) FROM ['+@CurrentDatabase+'].INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA=''dbo'' AND TABLE_NAME=''tmgUser'')=1
	BEGIN
	DELETE uc FROM ['+@CurrentDatabase+'].[dbo].[tmgUserCustomization] uc
	WHERE EXISTS 
	(
	SELECT 1 FROM ['+@CurrentDatabase+'].[dbo].[tmgUser] u
	WHERE u.email IN ('+@ListOfPossibleEmails+')
	AND uc.UserGUID=u.UserGUID
	) 
	END'
	EXEC SP_EXECUTESQL @SQLCommand

	print '@CurrentDatabase:'+@CurrentDatabase

	/*
	--Add the bck schema if it does not exist--FIX ME: need to figure out how to grant permission to the stored procedure (rather than the user's login) to create the schema
	--https://docs.microsoft.com/en-us/sql/t-sql/statements/grant-schema-permissions-transact-sql?view=sql-server-ver15

	SET @SQLCommand=NULL
	SET @SQLCommand='IF NOT EXISTS (SELECT * FROM ['+@CurrentDatabase+'].sys.schemas WHERE name = N''bck'')
	EXEC sys.sp_executesql N''CREATE SCHEMA [bck]'' '

	SET @UseDatabase=NULL
	SET @UseDatabase=N'USE ['+@CurrentDatabase+'] DECLARE  @subSQLCommand nvarchar(max) 
	SET @subSQLCommand=''' + REPLACE(@SQLCommand, CHAR(39), CHAR(39) + CHAR(39)) + '''
	EXEC sp_executesql @subSQLCommand'
	EXEC sp_executesql @UseDatabase
	*/

	/*Backup and Remove user record from tmgUser*/
	SET @SQLCommand=NULL
	SET @SQLCommand =
	N'IF (SELECT COUNT(*) FROM ['+@CurrentDatabase+'].INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA=''dbo'' AND TABLE_NAME=''tmgUser'')=1
	BEGIN		
	SELECT * 
	INTO [dbo].[bck_tmgUser_'+@Date+'_'+@FirstName+@LastName+']
	FROM ['+@CurrentDatabase+'].[dbo].[tmgUser] u
	WHERE u.Email IN ('+@ListOfPossibleEmails+')
		
	DELETE u FROM ['+@CurrentDatabase+'].[dbo].[tmgUser] u
	WHERE u.Email IN ('+@ListOfPossibleEmails+')
	END'
	EXEC SP_EXECUTESQL @SQLCommand
	/*Some security dbs are missing bck schema.  We use dbo, until we find the correct GRANT PERMISSION for the usp rather than the user of the usp--so the code can create bck schema if it is missing.*/

	/*
	--Keep this for later.
	--Do not remove records from tmgTradeOpsUser or tmgCustomerSuccessUser (At the moment, we reference these to fill the Department field in tmgTREmployees.)
	--tmgTREmployees may render {tmgTradeOpsUser and tmgCustomerSuccessUser} obsolete in the near future.  Go live "keep users" could reference tmgTREmployees instead.
	--Note:  we should add safeguards so that only dba/syseng/devops have access to these three tables...else someone could add a record and gain a different level of access--except that everyone currently has equal 1002 access.

	/*Remove user record from tmgTradeOpsUser; this table should be deprecated one day when no longer needed */
	SET @SQLCommand=''
	SET @SQLCommand =
	'IF EXISTS (SELECT * FROM ['+@CurrentDatabase+'].dbo.sysobjects WHERE id=OBJECT_ID(N''[dbo].[tmgTradeOpsUser]'') AND OBJECTPROPERTY(id, N''IsUserTable'')=1)
	BEGIN	
	DELETE tou FROM ['+@CurrentDatabase+'].[dbo].[tmgTradeOpsUser] tou
	WHERE tou.Email IN ('+@ListOfPossibleEmails+')
	END'
	EXEC SP_EXECUTESQL @SQLCommand

	/*Remove user record from tmgCustomerSuccessUser; this table should be deprecated one day when no longer needed */
	SET @SQLCommand=''
	SET @SQLCommand =
	'IF EXISTS (SELECT * FROM ['+@CurrentDatabase+'].dbo.sysobjects WHERE id=OBJECT_ID(N''[dbo].[tmgCustomerSuccessUser]'') AND OBJECTPROPERTY(id, N''IsUserTable'')=1)
	BEGIN	
	DELETE csu FROM ['+@CurrentDatabase+'].[dbo].[tmgCustomerSuccessUser] csu
	WHERE csu.Email IN ('+@ListOfPossibleEmails+')
	END'
	EXEC SP_EXECUTESQL @SQLCommand
	*/


	/*Update Department=CS for 'Customer Success Tier 1 Support' (formerly Monitoring)*/
	SET @SQLCommand=NULL
	SET @SQLCommand =
	N'IF EXISTS (SELECT * FROM [IPMaster].dbo.sysobjects WHERE id=OBJECT_ID(N''[dbo].[tmgTREmployees]'') AND OBJECTPROPERTY(id, N''IsUserTable'')=1)
	AND EXISTS (SELECT * FROM ['+@CurrentDatabase+'].dbo.sysobjects WHERE id=OBJECT_ID(N''[dbo].[tmgCustomerSuccessUser]'') AND OBJECTPROPERTY(id, N''IsUserTable'')=1)
	BEGIN	
	UPDATE [IPMaster].[dbo].[tmgTREmployees] 
	SET Department=''CS''
	where EXISTS (SELECT 1 FROM ['+@CurrentDatabase+'].[dbo].[tmgCustomerSuccessUser] csu WHERE csu.Email IN ('+@ListOfPossibleEmails+'))
	AND NetworkLogin='''+@NetworkLogin+'''
	END'
	EXEC SP_EXECUTESQL @SQLCommand

	/*Update Department=T for 'Technology Tier 2 Support' (formerly TradeOps)*/
	SET @SQLCommand=NULL
	SET @SQLCommand =
	N'IF EXISTS (SELECT * FROM [IPMaster].dbo.sysobjects WHERE id=OBJECT_ID(N''[dbo].[tmgTREmployees]'') AND OBJECTPROPERTY(id, N''IsUserTable'')=1)
	AND EXISTS (SELECT * FROM ['+@CurrentDatabase+'].dbo.sysobjects WHERE id=OBJECT_ID(N''[dbo].[tmgTradeOpsUser]'') AND OBJECTPROPERTY(id, N''IsUserTable'')=1)
	BEGIN	
	UPDATE [IPMaster].[dbo].[tmgTREmployees] 
	SET Department=''T''
	where EXISTS (SELECT 1 FROM ['+@CurrentDatabase+'].[dbo].[tmgTradeOpsUser] tou WHERE tou.Email IN ('+@ListOfPossibleEmails+'))
	AND NetworkLogin='''+@NetworkLogin+'''
	END'
	EXEC SP_EXECUTESQL @SQLCommand
	/*Release Management, Systems Engineering, DBA and IT are collectively Tier 3 Support (mostly for the Professional Services department)*/
	
	/*Country of employment: Only employees of the United States of America may have access to {111461, 111462, 115381} and {1114619, 1114629, 1153819}.  
	Delete these partners from the @PartnerIDs string if employee is not employed in USA (need clarification regarding citizenship/employment location)*/
		
	SELECT TOP 1 
	@Department=Department
	,@Country=Country
	FROM [IPMaster].[dbo].[tmgTREmployees] WITH (NOLOCK) 
	WHERE NetworkLogin=@NetworkLogin
	
	--PRINT 'test @Department: '+@Department
	--PRINT 'test @Country: '+@Country

	IF @Country != 'US' 
	BEGIN /*BEGIN : Deny access to non-US employees for Audit Compliance*/
	SET @PartnerIDs=Replace(@PartnerIDs,'1114619','')
	SET @PartnerIDs=Replace(@PartnerIDs,'1114629','')
	SET @PartnerIDs=Replace(@PartnerIDs,'1153819','')
	SET @PartnerIDs=Replace(@PartnerIDs,'111461','')
	SET @PartnerIDs=Replace(@PartnerIDs,'111462','')
	SET @PartnerIDs=Replace(@PartnerIDs,'115381','')

	/*Removes a series of commas -- duplicating the replacement of an odd number 
	followed by an even number of commas retains one comma between PartnerIDs after 
	certain clients are removed from the list (for their IT/Accounting Audit standards).*/
	SET @PartnerIDs=REPLACE(@PartnerIDs,',,,',',')
	SET @PartnerIDs=REPLACE(@PartnerIDs,',,',',')
	SET @PartnerIDs=REPLACE(@PartnerIDs,',,,',',')
	SET @PartnerIDs=REPLACE(@PartnerIDs,',,',',')
	
	/*Removes single comma at beginning of string*/
	IF LEFT(@PartnerIDs,1)=','
	BEGIN
	SET @PartnerIDs=RIGHT(@PartnerIDs,LEN(@PartnerIDs)-1)
	END

	/*Removes single comma at end of string*/
	IF RIGHT(@PartnerIDs,1)=','
	BEGIN
	SET @PartnerIDs=LEFT(@PartnerIDs,LEN(@PartnerIDs)-1)
	END

	END/*END : Deny access to non-US employees for Audit Compliance*/


/*=== | ADD User - GTM Applications | === */ 	
	/*
	For the forseeable future, all TR employees currently use the 1002 (IP Full Access Group), which has unlimited access.
	Customer Success was formerly limited to the MONITORING groupguid and the IPConfigAdmin group.

	What this does:
	If GroupDescription is blank, use standard GroupGuid. 
	If GroupDescription exists with a different GroupGuid, use existing GroupGuid.

	The tmgUserPartnerGroup table associates a User to a partner via a UserGuid
	Each user may have a different UserGuid in every security database.
	Insert a new record into tmgUserPartnerGroup record if the userlogin does not already exist in the security database, else use an existing userguid.  
	Add CustomerSuccess to the IPConfigAdmin group.
	*/

SET @SQLCommand=NULL
SET @SQLCommand =
N'
DECLARE @GroupDescription VARCHAR(80),@GroupGuid VARCHAR(80),@UserGUID AS VARCHAR(50),@UserLogin AS VARCHAR (80),@Email AS VARCHAR(80),@UserPassword AS VARCHAR(80),@PartnerID INT;

SET @GroupGUID=''1002'' 
SET @GroupDescription=''IP Full Access Group''
SET @UserGUID=NEWID()  
SET @UserLogin='''+@FirstInitialAndLastName+'_IP''
SET @Email='''+@FirstNameDotLastName+'@ThomsonReuters.com''
SET @PartnerID=NULL

IF (SELECT count(1) FROM ['+@CurrentDatabase+'].[dbo].[tmgGroup] WITH (NOLOCK) WHERE Description=@GroupDescription)>0
BEGIN SET @GroupGUID=(SELECT TOP 1 GroupGUID FROM ['+@CurrentDatabase+'].[dbo].[tmgGroup] WITH (NOLOCK) WHERE Description=@GroupDescription) END
ELSE
BEGIN insert into ['+@CurrentDatabase+'].[dbo].[tmgGroup] select @GroupGUID,@GroupDescription,GETDATE(),''N'',''N'' END

IF (SELECT TOP 1 LEFT(reverse(DatabasePassword),1) FROM ['+@CurrentDatabase+'].[dbo].[tmgPartnerDataConnection] WITH (NOLOCK))=''=''
BEGIN SET @UserPassword='''+@HSOUserPassword+''' END
ELSE
BEGIN SET @UserPassword='''+@DAUserPassword+''' END
		
INSERT INTO ['+@CurrentDatabase+'].[dbo].[tmgUser] (UserGUID,UserLogin,UserFirstName,UserLastName,UserPassword,PasswordSalt,Enabled,EMail,MaxPasswordRetries,CurrentPasswordRetries,DefaultPartnerID,DatePasswordChanged,ForceNextLoginPasswordChange,LastUserLoginDate,DaysToChangePassword,CultureGUID,EffDate,SSOIdType,SSOId,UserCreationMethod,SSOLoginEnabled,UserEffectiveDate,UserExpirationDate,DeletedFlag,KeepDuringRollback)
SELECT @UserGUID,@UserLogin,'''+@FirstName+''','''+@LastName+''',@UserPassword,NEWID(),1,@Email,10,0,0,GETDATE(),1,''1/1/1900'',-1,''en-US'',GETDATE(),''None'','''',''Other'',''N'',GETDATE(),GETDATE()+30,''N'',''N''	

IF OBJECT_ID (''tempdb..#tmp_PartnerID'') IS NOT NULL BEGIN DROP TABLE #tmp_PartnerID END 
CREATE TABLE #tmp_PartnerID (PartnerID INT NOT NULL, Processed bit NOT NULL)
	
IF ('''+@PartnerIDs+''')=('''')
BEGIN INSERT INTO #tmp_PartnerID SELECT PartnerID,0 FROM ['+@CurrentDatabase+'].[dbo].[tmgPartnerDataConnection] END
else
BEGIN INSERT INTO #tmp_PartnerID SELECT PartnerID,0 FROM ['+@CurrentDatabase+'].[dbo].[tmgPartnerDataConnection] WHERE PartnerID in ('+@PartnerIDs+') END

SELECT TOP 1 @PartnerID=PartnerID FROM #tmp_PartnerID WHERE Processed=0
WHILE @PartnerID IS NOT NULL 
BEGIN						
	IF NOT EXISTS (SELECT 1 FROM ['+@CurrentDatabase+'].[dbo].[tmgUserPartnerGroup] upg WHERE upg.PartnerID=@PartnerID and upg.UserGUID=@UserGUID and upg.GroupGUID=@GroupGUID)
	BEGIN INSERT INTO ['+@CurrentDatabase+'].[dbo].[tmgUserPartnerGroup] select @UserGUID,@PartnerID,@GroupGUID,GETDATE(),''N'',''N'' END

	IF ('''+@Department+''')=(''CS'')
	BEGIN
	IF NOT EXISTS (SELECT 1 FROM ['+@CurrentDatabase+'].[dbo].[tmgUserPartnerGroup] upg WITH (NOLOCK) WHERE upg.PartnerID=@PartnerID and upg.UserGUID=@UserGUID AND @GroupGUID=''IPConfigAdmin'')
	BEGIN INSERT INTO ['+@CurrentDatabase+'].[dbo].[tmgUserPartnerGroup] (UserGUID,PartnerID,GroupGuid,EffDate,DeletedFlag,KeepDuringRollback) select @UserGUID,@PartnerID,''IPConfigAdmin'',GETDATE(),''N'',''N'' END
	END

	IF NOT EXISTS (SELECT 1 FROM ['+@CurrentDatabase+'].[dbo].[tmgUserCustomization] uc WITH (NOLOCK) WHERE uc.PartnerID=@PartnerID AND uc.UserGUID=@UserGUID)
	BEGIN 
	INSERT INTO ['+@CurrentDatabase+'].[dbo].[tmgUserCustomization] (PartnerID,UserGUID,DateFormat,DateTimeFormat,TimezoneOffset,Timezone,Location,Stylesheet,EmailToSupport,ViewStatusAlerts,ViewSystemMessages,ViewNotification ,NotificationInterval,NotificationPosition,DeletedFlag,KeepDuringRollback)
	SELECT @PartnerID,@UserGUID,'''','''','''','''',''US'',''classic.css'',''Y'',''Y'',''Y'',''Y'',5,''33'','''','''' 
	END

	UPDATE #tmp_PartnerID SET Processed=1 WHERE PartnerID=@PartnerID
	SET @PartnerID=NULL;
	SELECT TOP 1 @PartnerID=PartnerID FROM #tmp_PartnerID WHERE Processed=0
end
'
	EXEC SP_EXECUTESQL @SQLCommand
	--print @SQLCommand
	--SELECT LEN(@SQLCommand)

	/*Assign the old tmgUserPartnerGroup records back to the new user record of the employee*/
	SET @SQLCommand=NULL
	SET @SQLCommand =
	N'
	IF EXISTS (SELECT * FROM ['+@CurrentDatabase+'].dbo.sysobjects WHERE id=OBJECT_ID(N''[dbo].[tmgUserPartnerGroup]'') AND OBJECTPROPERTY(id, N''IsUserTable'')=1)
	AND EXISTS (SELECT * FROM ['+@CurrentDatabase+'].dbo.sysobjects WHERE id=OBJECT_ID(N''[dbo].[tmgUser]'') AND OBJECTPROPERTY(id, N''IsUserTable'')=1)
	BEGIN
	UPDATE ['+@CurrentDatabase+'].[dbo].[tmgUserPartnerGroup]
	SET UserGUID=(SELECT TOP 1 u.UserGuid FROM ['+@CurrentDatabase+'].[dbo].[tmgUser] u WITH (NOLOCK) WHERE u.Email IN ('+@ListOfPossibleEmails+') AND u.UserLogin NOT LIKE ''%dts%'' AND u.UserLogin NOT LIKE ''%dps%'')
	WHERE UserGUID='''+@PlaceHolderUserGuid+'''
	END
	'
	EXEC SP_EXECUTESQL @SQLCommand
	--print @SQLCommand

	/*Cleanup the duplicates in tmgUserPartnerGroup*/

		SET @SQLCommand=NULL
		SET @SQLCommand =
		N'
		; WITH CTE AS( 
		SELECT 
		upg.UserGUID, 
		upg.PartnerID, 
		upg.GroupGUID, 
		RN = ROW_NUMBER()OVER(PARTITION BY upg.UserGUID, upg.PartnerID, upg.GroupGUID ORDER BY upg.EffDate asc) 
		FROM ['+@CurrentDatabase+'].[dbo].[tmgUserPartnerGroup] upg 
		)
		delete cte
		where RN>1 
		'
		EXEC SP_EXECUTESQL @SQLCommand

	/*FIX ME:  NAR : 20200615 LABEL AND WRITE THE ISF AND SCC LOGIC HERE*/

		UPDATE  #tmp_SecurityDatabases
		SET     Processed=1
		WHERE   DatabaseName=@CurrentDatabase
		SET @CurrentDatabase=NULL
		SELECT TOP 1
				@CurrentDatabase=DatabaseName
		FROM    #tmp_SecurityDatabases
		WHERE   Processed=0
	END /*END @CurrentDatabase loop*/

END /*End : Determine in which security databases to drop-and-create users associated to this employee--and then do it.*/


/*Provide the username and a randomly generated password to the user*/
IF @ErrorMessage=''
BEGIN SET @ErrorMessage='Try login with username:  '+@FirstInitialAndLastName+'_IP and Password: '+@DecryptedUserPassword END

SELECT @ErrorMessage

/*=== |Cleanup Temp Table| ===*/

IF OBJECT_ID('tempdb..#tmp_SecurityDatabases') IS NOT NULL BEGIN DROP TABLE #tmp_SecurityDatabases END

SET NOCOUNT OFF




--To Do:
--CREATE TABLE [IPMaster].[dbo].[tmgTREmployees] and fill it
--need to put a lock on the tmgTREmployees table (later) and on the usp_WebAccess stored proc
--need to drop bck% tables from security databases, including isf and scc databases after 30 days
--update the email in tmgTradeOpsUser and tmgCustomerSuccessUser to @ThomsonReuters.com
--If we switch to a platform that does not recognize ORIGINAL_LOGIN(), then we could supply the NetworkLogin to the procedure from somthing like the sp_who2 procedure where spid=x if an equivalent exists on the new platform




/*General Helpful Security Notes:

The GroupGUID is not the same in every security database for any 1 group description (name) in tmgGroup. 

select Description, GroupGUID
from dbo.tmgGroup
order by Description

1001 --> IP Read Only Group --> Will never be asked for, but this is an IP only group
1002 --> IP Full Access Group --> All Software Analysts will be setup for this, CSMs should not have a user created on all clients, only Trade Ops
1003 --> Zone Operator Group --> Client Acces
1004 --> Read Only Group  --> Client Access
IPConfigAdmin --> IPConfigAdmin -->  Currently, Solutions Delivery access for Config Changes. Monitoring needs this as well
MONITORING --> MONITORING --> Monitoring access
2001 --> 'QA Production Push Audit' 

----------

select TABLE_NAME
from information_schema.COLUMNS 
where COLUMN_NAME='PartnerTypeID'
AND TABLE_NAME NOT LIKE '%tmgpartnerdataconnection%'

SELECT * FROM tmgPartnerType
--1=primary --> this probably means 'client facing or not for internal use'

------------

^Cn*ff&jb%eq$10^1!=Password101!  (Non HSO)
gKJ2kSzle9kemQj9Js+gjA== is Password101! (HSO)

------------

--Create tmgTradeOpsUser table if it does not exist in a security database 
IF NOT EXISTS (select * from dbo.sysobjects where id=object_id(N'[dbo].[tmgTradeOpsUser]') and OBJECTPROPERTY(id, N'IsUserTable')=1)
BEGIN
	CREATE TABLE [dbo].[tmgTradeOpsUser](
	[UserLogin] [varchar](80) NOT NULL,
	[UserFirstName] [varchar](80) NOT NULL,
	[UserLastName] [varchar](80) NOT NULL,
	[Email] [varchar](80) NOT NULL
) ON [PRIMARY]
END	

 Insert a record into the tmgTradeOpsUSer table if marked as a TradeOpsUser (1) in #NewUsers 
			SELECT @TradeOpsUser=TradeOpsUser FROM #NewUsers
			WHERE FirstName=@FirstName AND LastName=@LastName

			IF @TradeOpsUser='Y'
			and (select top 1 1 from [dbo].tmgTradeOpsUSer where
			UserLogin=@UserLogin
			and UserFirstName=@FirstName
			and UserLastName=@LastName
			and Email=@Email
			)<>1
			BEGIN
			INSERT INTO [dbo].tmgTradeOpsUSer
			SELECT @UserLogin,@FirstName,@LastName,@Email
			END


---------------------

--21 Records we should update

--10.200.21.81
USE [DTS_SECURITY]
GO
SELECT EMAIL FROM tmgUser WITH (NOLOCK)
WHERE (userlogin like '%dps%'
or userlogin like '%dts%')
and email <> ''
and email like '%@integrationpoint%'
and email not like '%test%'


-------------


--good read:

"specify database name within a cte"
--https://www.essentialsql.com/introduction-common-table-expressions-ctes/

*/
GO


USE [ipmaster]
GO

/****** Object:  UserDefinedFunction [dbo].[ufn_GCStatisticalClassifier_WordCountFrequency]    Script Date: 9/21/2020 5:24:28 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


if (select top 1 1 from sys.objects where name='ufn_GCStatisticalClassifier_WordCountFrequency') = 1
	begin
	print('Dropping '+'ufn_GCStatisticalClassifier_WordCountFrequency')
	drop function ufn_GCStatisticalClassifier_WordCountFrequency
	end
else
	begin
	print('No drop needed for '+'ufn_GCStatisticalClassifier_WordCountFrequency')
	end
	;

	go





CREATE FUNCTION [dbo].[ufn_GCStatisticalClassifier_WordCountFrequency](
	@PartnerID int,
	@CountryCode varchar(2),
	@HSNumLength int = 12,
	@ColumnName varchar(200) = 'ProductDesc',
	@ColumnValue AS nvarchar(MAX)
) RETURNS @results TABLE(
	HSNum varchar(12) NOT NULL,
	Probability float NOT NULL,
	ProbabilityScaled float NOT NULL
) AS
/*
 * Name: ufn_GCStatisticalClassifier_WordCountFrequency
 * Author: Andy R. Schmitz
 * Description: This procedure analyzes the number of times a word (ex. within ProductDesc) is
 *              associated with a particular HS Number. Whatever description you pass in is
 *              used, and we come up with a most likely result
 * Parameters:
 *       PartnerID - The PartnerID of the Partner
 *     CountryCode - The Country we're analyzing
 *     HSNumLength - The length of the HSNumber we're analyzing
 *                   12 is the max length, but often times we may only want to analyze the first 6 digits
 *      ColumnName - The XXPC column we're analyzing
 *     ColumnValue - The text (ex. ProductDesc) we're needing to analyze
 * Returns: A table of  HSNumbers, probabilities, and it's probability in proportion to everything else
 * Change History:
 *     13 Aug 2015 - ARS - Created initial version
 *     27 Apr 2016 - ARS - We're removing the initial probability, based on the proportion of products in the system already
 */
BEGIN
	INSERT INTO @results
	SELECT
		c.HSNum,
		EXP(SUM(LOG(c.Probability))),
		0
	FROM ufn_GCStatisticalClassifier_WordCountFrequency_ConditionalProbabilities
		(@PartnerID, @CountryCode, @HSNumLength, @ColumnName, @ColumnValue) AS c
	GROUP BY c.HSNum
	ORDER BY EXP(SUM(LOG(c.Probability))) DESC

	UPDATE @results
	SET ProbabilityScaled = Probability / (
		SELECT SUM(Probability) FROM @results
	)

	RETURN
END

GO

USE [ipmaster]
GO

/****** Object:  UserDefinedFunction [dbo].[ufn_GCStatisticalClassifier_WordCountFrequency_ConditionalProbabilities]    Script Date: 9/21/2020 5:24:40 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




if (select top 1 1 from sys.objects where name='ufn_GCStatisticalClassifier_WordCountFrequency_ConditionalProbabilities') = 1
	begin
	print('Dropping '+'ufn_GCStatisticalClassifier_WordCountFrequency_ConditionalProbabilities')
	drop function ufn_GCStatisticalClassifier_WordCountFrequency_ConditionalProbabilities
	end
else
	begin
	print('No drop needed for '+'ufn_GCStatisticalClassifier_WordCountFrequency_ConditionalProbabilities')
	end
	;

	go


CREATE FUNCTION [dbo].[ufn_GCStatisticalClassifier_WordCountFrequency_ConditionalProbabilities](
	@PartnerID int,
	@CountryCode varchar(2),
	@HSNumLength int = 12,
	@ColumnName varchar(200) = 'ProductDesc',
	@ColumnValue AS nvarchar(MAX)
)
RETURNS @results TABLE (
		Word varchar(MAX) NOT NULL,
		HSNum varchar(12) NOT NULL,
		Probability float NOT NULL
)
AS
/*
 * Name: ufn_GCStatisticalClassifier_WordCountFrequency_ConditionalProbabilities
 * Author: Andy R. Schmitz
 * Description: This performs 1/2 of a Bayesian Classification on the words passed in
 * Parameters:
 *       PartnerID - The PartnerID of the Partner
 *     CountryCode - The CountryCode we're analyzing
 *     HSNumLength - The length of the HSNumber we're analyzing
 *                   12 is the max length, but often times we may only want to analyze the first 6 digits
 *      ColumnName - The XXPC column we're analyzing
 *     ColumnValue - The text (ex. ProductDesc) we're needing to analyze
 * Returns: A table of HSNumbers, probabilities, and it's probability in proportion to everything else
 * Change History:
 *     13 Aug 2015 - ARS - Created initial version
 */
BEGIN
	DECLARE @wl TABLE (Word varchar(MAX) NOT NULL)

	INSERT INTO @wl SELECT item
	FROM ipMaster.dbo.udf_SplitStringCLR_SQL(ipMaster.dbo.ufn_StripCharacters(@ColumnValue, '^a-z0-9|', '|'), '|') As s

	DECLARE @v float = (
		SELECT COUNT(DISTINCT Word)
		FROM txgStatisticalClassifierStatistics
		WHERE PartnerID=@PartnerID
			AND CountryCode=@CountryCode
			AND ColumnName = @ColumnName
			AND HSNumLength = @HSNumLength
	)

	INSERT INTO @results
	SELECT
		wl.Word,
		hs.HSNum,
		(ISNULL(s.WordCount, 0) + 1) / CAST(hs.wc + @v AS float)
	FROM @wl wl
	CROSS JOIN (
		SELECT DISTINCT HSNum, SUM(WordCount) As wc
		FROM txgStatisticalClassifierStatistics
		WHERE PartnerID = @PartnerID
			AND CountryCode = @CountryCode
			AND ColumnName = @ColumnName
			AND HSNumLength = @HSNumLength
		GROUP BY HSNum
	) hs
	LEFT JOIN txgStatisticalClassifierStatistics s
		ON s.Word=wl.Word
		AND s.HSNum=hs.HSNum

	RETURN
END

GO


USE [ipmaster]
GO

/****** Object:  UserDefinedFunction [dbo].[ufn_GCStatisticalClassifier_WordCountFrequency_StartingProbabilities]    Script Date: 9/21/2020 5:24:45 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





if (select top 1 1 from sys.objects where name='ufn_GCStatisticalClassifier_WordCountFrequency_StartingProbabilities') = 1
	begin
	print('Dropping '+'ufn_GCStatisticalClassifier_WordCountFrequency_StartingProbabilities')
	drop function ufn_GCStatisticalClassifier_WordCountFrequency_StartingProbabilities
	end
else
	begin
	print('No drop needed for '+'ufn_GCStatisticalClassifier_WordCountFrequency_StartingProbabilities')
	end
	;

	go


CREATE FUNCTION [dbo].[ufn_GCStatisticalClassifier_WordCountFrequency_StartingProbabilities](
	@PartnerID int,
	@CountryCode varchar(2),
	@HSNumLength int = 12,
	@ColumnName varchar(200) = 'ProductDesc'
)
RETURNS @results TABLE(
	HSNum varchar(12) NOT NULL,
	Probability float NOT NULL
)
AS
/*
 * Name: ufn_GCStatisticalClassifier_WordCountFrequency_StartingProbabilities
 * Author: Andy R. Schmitz
 * Description: This returns a list of HSNums, and how often they appear within the database
 *              This is the best guess we start with, within the Bayesian Classifier algorithm
 * Parameters:
 *       PartnerID - The PartnerID of the Partner
 *     CountryCode - The CountryCode we're analyzing
 *     HSNumLength - The length of the HSNumber we're analyzing
 *                   12 is the max length, but often times we may only want to analyze the first 6 digits
 *      ColumnName - The XXPC column we're analyzing
 * Returns: A table of HSNumbers, and proportionally how often it's used within the database
 * Change History:
 *     13 Aug 2015 - ARS - Created initial version
 */
BEGIN
	INSERT INTO @results
	SELECT DISTINCT HsNum, MAX(ProductCount) AS Probability
	FROM txgStatisticalClassifierStatistics
	WHERE PartnerID=@PartnerID
		AND CountryCode=@CountryCode
		AND ColumnName=@ColumnName
		AND HSNumLength = @HSNumLength
	GROUP BY HsNum

	UPDATE @results
	SET Probability = Probability / (
		SELECT SUM(Probability) FROM @results
	)

	RETURN
END

GO

USE [ipmaster]
GO

/****** Object:  UserDefinedFunction [dbo].[ufn_SplitList]    Script Date: 9/21/2020 5:25:46 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





if (select top 1 1 from sys.objects where name='ufn_SplitList') = 1
	begin
	print('Dropping '+'ufn_SplitList')
	drop function ufn_SplitList
	end
else
	begin
	print('No drop needed for '+'ufn_SplitList')
	end
	;

	go


CREATE FUNCTION [dbo].[ufn_SplitList]
(
	 @InputString NVARCHAR(4000)
	,@SplitChar VARCHAR(5)
)
RETURNS @ValuesList TABLE
(
	[RESULTS] NVARCHAR(255)
)
AS /*
Name: ufn_SplitList 
Author: John DePrato / Matt Laffoon
Description: Takes in a deliminted string and outputs a table
Parameters: @InputString NVARCHAR(MAX) - The deliminated string
						@SplitChar CHAR(5) - The delimiter
Change History:
	- 01/22/2014 - ML - Baselined
	- 07/11/2014 - JCD - Fixed issue with hardcoded delimiter
*/

BEGIN
	DECLARE	@ListValue NVARCHAR(4000)
	DECLARE	@LEN INT
	DECLARE	@INDEX INT

	SET @InputString = @InputString + @SplitChar

	WHILE NOT @InputString = @SplitChar
	BEGIN
		SET @LEN = LEN(@InputString)
		SET @INDEX = CHARINDEX(@SplitChar,@InputString)

		SELECT	@ListValue = SUBSTRING(@InputString,1,@INDEX - 1)

		INSERT	INTO @ValuesList
		SELECT	@ListValue

		SET @LEN = LEN(@InputString)
		SET @INDEX = CHARINDEX(@SplitChar,@InputString)

		IF LEN(LTRIM(RTRIM(SUBSTRING(@InputString,@INDEX + 1,@LEN)))) > 1
		BEGIN
			SELECT	@InputString = SUBSTRING(@InputString,@INDEX + 1,@LEN - @INDEX)
		END
		ELSE
		BEGIN
			SET @InputString = @SplitChar
		END
	END
	RETURN
END


GO


USE [ipmaster]
GO

/****** Object:  UserDefinedFunction [dbo].[fnMoneyToEnglish]    Script Date: 9/21/2020 5:26:09 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



if (select top 1 1 from sys.objects where name='fnMoneyToEnglish') = 1
	begin
	print('Dropping '+'fnMoneyToEnglish')
	drop function fnMoneyToEnglish
	end
else
	begin
	print('No drop needed for '+'fnMoneyToEnglish')
	end
	;

	go




CREATE FUNCTION [dbo].[fnMoneyToEnglish](@Money AS money)
    RETURNS VARCHAR(1024)
AS
BEGIN
  RETURN ([dbo].[fnMoneyToEnglishNL](@Money, @@NESTLEVEL))
END

GO

USE [ipmaster]
GO

/****** Object:  UserDefinedFunction [dbo].[fnMoneyToEnglishNL]    Script Date: 9/21/2020 5:26:13 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



if (select top 1 1 from sys.objects where name='fnMoneyToEnglishNL') = 1
	begin
	print('Dropping '+'fnMoneyToEnglishNL')
	drop function fnMoneyToEnglishNL
	end
else
	begin
	print('No drop needed for '+'fnMoneyToEnglishNL')
	end
	;

	go




CREATE FUNCTION [dbo].[fnMoneyToEnglishNL](@Money AS money, @nl int)
    RETURNS VARCHAR(1024)
AS
BEGIN
      DECLARE @Number as BIGINT
      SET @Number = FLOOR(@Money)
      DECLARE @Below20 TABLE (ID int identity(0,1), Word varchar(32))
      DECLARE @Below100 TABLE (ID int identity(2,1), Word varchar(32))
 
      INSERT @Below20 (Word) VALUES
                        ( 'Zero'), ('One'),( 'Two' ), ( 'Three'),
                        ( 'Four' ), ( 'Five' ), ( 'Six' ), ( 'Seven' ),
                        ( 'Eight'), ( 'Nine'), ( 'Ten'), ( 'Eleven' ),
                        ( 'Twelve' ), ( 'Thirteen' ), ( 'Fourteen'),
                        ( 'Fifteen' ), ('Sixteen' ), ( 'Seventeen'),
                        ('Eighteen' ), ( 'Nineteen' )
       INSERT @Below100 VALUES ('Twenty'), ('Thirty'),('Forty'), ('Fifty'),
                               ('Sixty'), ('Seventy'), ('Eighty'), ('Ninety')
 
DECLARE @English varchar(1024) =
(
  SELECT Case
    WHEN @Number = 0 THEN  ''
    WHEN @Number BETWEEN 1 AND 19
      THEN (SELECT Word FROM @Below20 WHERE ID=@Number)
   WHEN @Number BETWEEN 20 AND 99
-- SQL Server recursive function   
     THEN  (SELECT Word FROM @Below100 WHERE ID=@Number/10)+ '-' +
           dbo.fnMoneyToEnglishNL( @Number % 10, @nl)
   WHEN @Number BETWEEN 100 AND 999  
     THEN  (dbo.fnMoneyToEnglishNL( @Number / 100, @nl))+' Hundred '+
         dbo.fnMoneyToEnglishNL( @Number % 100, @nl)
   WHEN @Number BETWEEN 1000 AND 999999  
     THEN  (dbo.fnMoneyToEnglishNL( @Number / 1000, @nl))+' Thousand '+
         dbo.fnMoneyToEnglishNL( @Number % 1000, @nl) 
   WHEN @Number BETWEEN 1000000 AND 999999999  
     THEN  (dbo.fnMoneyToEnglishNL( @Number / 1000000, @nl))+' Million '+
         dbo.fnMoneyToEnglishNL( @Number % 1000000, @nl)
   ELSE ' INVALID INPUT' END
)
SELECT @English = RTRIM(@English)
SELECT @English = RTRIM(LEFT(@English,len(@English)-1))
                 WHERE RIGHT(@English,1)='-'
IF (@@NestLevel - @nl) = 1
BEGIN
      SELECT @English = @English+' Dollars and '
      SELECT @English = @English+
      convert(varchar,convert(int,100*(@Money - @Number))) +' Cents'
END
RETURN (@English)
END

GO


USE [ipmaster]
GO

/****** Object:  UserDefinedFunction [dbo].[ufn_GetDBNameForPartner]    Script Date: 9/21/2020 5:26:26 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO






if (select top 1 1 from sys.objects where name='ufn_GetDBNameForPartner') = 1
	begin
	print('Dropping '+'ufn_GetDBNameForPartner')
	drop function ufn_GetDBNameForPartner
	end
else
	begin
	print('No drop needed for '+'ufn_GetDBNameForPartner')
	end
	;

	go



CREATE FUNCTION [dbo].[ufn_GetDBNameForPartner] (
	@PartnerID INT
) RETURNS VARCHAR(100)
BEGIN
	DECLARE @result VARCHAR(100)
	
	SET @result = 'IP_' + CAST(@PartnerID AS VARCHAR(100))
	
	IF(connectionproperty('local_net_address')='172.16.15.18' AND @@SERVICENAME='LABSQL01')
		SET @result = @result + '_QA'
	
	RETURN @result
END

GO

USE [ipmaster]
GO

/****** Object:  UserDefinedFunction [dbo].[ufn_IMMEXGenerateSpanishCurrency]    Script Date: 9/21/2020 5:26:45 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



if (select top 1 1 from sys.objects where name='ufn_IMMEXGenerateSpanishCurrency') = 1
	begin
	print('Dropping '+'ufn_IMMEXGenerateSpanishCurrency')
	drop function ufn_IMMEXGenerateSpanishCurrency
	end
else
	begin
	print('No drop needed for '+'ufn_IMMEXGenerateSpanishCurrency')
	end
	;

	go




CREATE FUNCTION [dbo].[ufn_IMMEXGenerateSpanishCurrency](@Value AS Decimal(38,2), @Currency AS Varchar(3))
RETURNS VARCHAR(3000) AS
BEGIN
	DECLARE @Moneda As Varchar(100)
	DECLARE @Monedas As Varchar(100)
	DECLARE @Centimo As Varchar(100)
	DECLARE @Centimos As Varchar(100)
	DECLARE @Preposicion As Varchar(100)
	DECLARE @NumCentimos Decimal(10,0)
	DECLARE @StringValue As Varchar(3000)
	DECLARE @MAXIMUM AS DECIMAL(38,2)
	
	SET @MAXIMUM = 999999999999.99
	SET @Moneda = 'Peso'         --Nombre de Moneda (Singular)
	SET @Monedas = 'Pesos'       --'Nombre de Moneda (Plural)
	SET @Centimo = 'Centavo'     --'Nombre de Céntimos (Singular)
	SET @Centimos = 'Centavos'   --'Nombre de Céntimos (Plural)
	SET @Preposicion = 'Con'     --'Preposición entre Moneda y Céntimos
	
	IF (@Currency = 'USD')
		BEGIN
			SET @Moneda = 'Dolar'         --Nombre de Moneda (Singular)
			SET @Monedas = 'Dolares'       --'Nombre de Moneda (Plural)		
		END
		
	IF (@Currency = 'EUR')
		BEGIN
			SET @Moneda = 'Euro'         --Nombre de Moneda (Singular)
			SET @Monedas = 'Euros'       --'Nombre de Moneda (Plural)		
		END
		
	--Checking the Value
	IF (@Value > '0.0') AND (@Value <= @MAXIMUM)
		BEGIN
			DECLARE @UNITS AS VARCHAR(3000)
			DECLARE @TENS AS VARCHAR(3000)
			DECLARE @HUNDREDS AS VARCHAR(3000)
			SET @UNITS = ' 1Un, 2Dos, 3Tres, 4Cuatro, 5Cinco, 6Seis, 7Siete, 8Ocho, 9Nueve, 10Diez, 11Once, 12Doce, 13Trece, 14Catorce, 15Quince, 16Dieciséis, 17Diecisiete, 18Dieciocho, 19Diecinueve, 20Veinte, 21Veintiun, 22Veintidos, 23Veintitres, 24Veinticuatro, 25Veinticinco, 26Veintiseis, 27Veintisiete, 28Veintiocho, 29Veintinueve,'
			SET @TENS = ' 1Diez, 2Veinte, 3Treinta, 4Cuarenta, 5Cincuenta, 6Sesenta, 7Setenta, 8Ochenta, 9Noventa, 10Cien,'
			SET @HUNDREDS = ' 1Ciento, 2Doscientos, 3Trescientos, 4Cuatrocientos, 5Quinientos, 6Seiscientos, 7Setecientos, 8Ochocientos, 9Novecientos,'
			
			--PRINT FLOOR(@VALUE)
			
			IF (FLOOR(@VALUE) BETWEEN 0 AND 9)
				BEGIN
					SET @StringValue = SUBSTRING(@UNITS, CHARINDEX(' ' + REPLACE(CONVERT(VARCHAR(5),FLOOR(@VALUE)),'.00',''),@UNITS,1) + 2, CHARINDEX(',', @UNITS, CHARINDEX(' ' + REPLACE(CONVERT(VARCHAR(5),FLOOR(@VALUE)),'.00',''),@UNITS,1)) - CHARINDEX(' ' + REPLACE(CONVERT(VARCHAR(5),FLOOR(@VALUE)),'.00',''),@UNITS,1) -2)
					--PRINT @StringValue
				END
			IF (FLOOR(@VALUE) BETWEEN 10 AND 29) 
				BEGIN
					SET @StringValue = SUBSTRING(@UNITS, CHARINDEX(' ' + REPLACE(CONVERT(VARCHAR(5),FLOOR(@VALUE)),'.00',''),@UNITS,1) + 3, CHARINDEX(',', @UNITS, CHARINDEX(' ' + REPLACE(CONVERT(VARCHAR(5),FLOOR(@VALUE)),'.00',''),@UNITS,1)) - CHARINDEX(' ' + REPLACE(CONVERT(VARCHAR(5),FLOOR(@VALUE)),'.00',''),@UNITS,1) -3)
					--PRINT @StringValue
				END
			IF (FLOOR(@VALUE) BETWEEN 30 AND 99) 
				BEGIN
					SET @StringValue =	SUBSTRING(@TENS, CHARINDEX(' ' + REPLACE(CONVERT(VARCHAR(5),FLOOR(@VALUE/10)),'.00',''),@TENS,1) + 2, CHARINDEX(',', @TENS, CHARINDEX(' ' + REPLACE(CONVERT(VARCHAR(5),FLOOR(@VALUE/10)),'.00',''),@TENS,1)) - CHARINDEX(' ' + REPLACE(CONVERT(VARCHAR(5),FLOOR(@VALUE/10)),'.00',''),@TENS,1) -2) +
										CASE WHEN FLOOR(@VALUE%10) > 0 THEN
										 ' Y ' + dbo.ufn_IMMEXGenerateSpanishCurrency(FLOOR(@VALUE%10), @Currency)
										 ELSE '' END
										 
					--PRINT @StringValue
				END
			IF (FLOOR(@VALUE) = 100) 
				BEGIN
					SET @StringValue =	SUBSTRING(@TENS, CHARINDEX(' ' + REPLACE(CONVERT(VARCHAR(5),FLOOR(@VALUE/10)),'.00',''),@TENS,1) + 3, CHARINDEX(',', @TENS, CHARINDEX(' ' + REPLACE(CONVERT(VARCHAR(5),FLOOR(@VALUE/10)),'.00',''),@TENS,1)) - CHARINDEX(' ' + REPLACE(CONVERT(VARCHAR(5),FLOOR(@VALUE/10)),'.00',''),@TENS,1) -3)
				END
			IF (FLOOR(@VALUE) BETWEEN 101 AND 999) 
				BEGIN
					SET @StringValue =	SUBSTRING(@HUNDREDS, CHARINDEX(' ' + REPLACE(CONVERT(VARCHAR(5),FLOOR(@VALUE/100)),'.00',''),@HUNDREDS,1) + 2, CHARINDEX(',', @HUNDREDS, CHARINDEX(' ' + REPLACE(CONVERT(VARCHAR(5),FLOOR(@VALUE/100)),'.00',''),@HUNDREDS,1)) - CHARINDEX(' ' + REPLACE(CONVERT(VARCHAR(5),FLOOR(@VALUE/100)),'.00',''),@HUNDREDS,1) -2) + ' ' +
										CASE WHEN FLOOR(@VALUE%100) > 0 THEN
										 ' ' + dbo.ufn_IMMEXGenerateSpanishCurrency(FLOOR(@VALUE%100), @Currency)
										 ELSE '' END
				END
			IF (FLOOR(@VALUE) BETWEEN 1000 AND 999999) 
				BEGIN
					SET @StringValue =	dbo.ufn_IMMEXGenerateSpanishCurrency(FLOOR(@VALUE/1000), @Currency) + ' Mil ' +
										CASE WHEN FLOOR(@VALUE%1000) > 0 THEN
										 ' ' + dbo.ufn_IMMEXGenerateSpanishCurrency(FLOOR(@VALUE%1000), @Currency)
										 ELSE '' END
				END
			IF (FLOOR(@VALUE) BETWEEN 1000000 AND 1999999) 
				BEGIN
					SET @StringValue =	dbo.ufn_IMMEXGenerateSpanishCurrency(FLOOR(@VALUE/1000000), @Currency) + ' Millon ' +
										CASE WHEN FLOOR(@VALUE%1000000) > 0 THEN
										 ' ' + dbo.ufn_IMMEXGenerateSpanishCurrency(FLOOR(@VALUE%1000000), @Currency)
										 ELSE '' END
				END
			IF (FLOOR(@VALUE) BETWEEN 2000000 AND 999999999) 
				BEGIN
					SET @StringValue =	dbo.ufn_IMMEXGenerateSpanishCurrency(FLOOR(@VALUE/1000000), @Currency) + ' Millones ' +
										CASE WHEN FLOOR(@VALUE%1000000) > 0 THEN
										 ' ' + dbo.ufn_IMMEXGenerateSpanishCurrency(FLOOR(@VALUE%1000000), @Currency)
										 ELSE '' END
				END
		
		SET @StringValue = REPLACE(REPLACE(@StringValue,' ' + @Monedas, ''), ' ' + @Moneda,'')
		
	    If (FLOOR(@VALUE) = 1)
			SET @StringValue = @StringValue + ' ' + @Moneda
		Else
			SET @StringValue = @StringValue + ' ' + @Monedas
		IF FLOOR((@VALUE%1) * 100) > 0
		SET @StringValue = @StringValue + ' ' + REPLACE(CONVERT(VARCHAR(5),FLOOR((@VALUE%1) * 100)),'.00','') + '/100 ' + @Currency
	END
	RETURN @StringValue 
END

GO


USE [ipmaster]
GO

/****** Object:  UserDefinedFunction [dbo].[ufn_NumInvalidCharacters_EN_SAP]    Script Date: 9/21/2020 5:27:51 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



if (select top 1 1 from sys.objects where name='ufn_NumInvalidCharacters_EN_SAP') = 1
	begin
	print('Dropping '+'ufn_NumInvalidCharacters_EN_SAP')
	drop function ufn_NumInvalidCharacters_EN_SAP
	end
else
	begin
	print('No drop needed for '+'ufn_NumInvalidCharacters_EN_SAP')
	end
	;

	go




CREATE FUNCTION [dbo].[ufn_NumInvalidCharacters_EN_SAP]
(
    @nstring nvarchar(255)
)
RETURNS int
AS /*
Name: ufn_NumInvalidCharacters_EN_SAP
Author: Matt Laffoon
Description: Returns the count of characters SAP considers invalid for English
Parameters: @nstring  - the unicode string to be considered.
Change History:
	- 04/10/2013 - ML - Created
*/
BEGIN

   DECLARE @Result INT
   SET @Result = 0 

    DECLARE @nchar nvarchar(1)
    DECLARE @position int

    SET @position = 1
    WHILE @position <= LEN(@nstring)
    BEGIN
        SET @nchar = SUBSTRING(@nstring, @position, 1)
        --Unicode & ASCII are the same from 1 to 255.
        --Only Unicode goes beyond 255
        --0 to 31 are non-printable characters
       --126 defined as the highest code acceptable for EN 
        IF UNICODE(@nchar) NOT BETWEEN  32 AND 126
            SET @Result = @Result + 1
        SET @position = @position + 1
    END

    RETURN @Result

END

GO

USE [ipmaster]
GO

/****** Object:  UserDefinedFunction [dbo].[ufn_NumWeekdaysBetweenDates]    Script Date: 9/21/2020 5:27:59 PM ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO





if (select top 1 1 from sys.objects where name='ufn_NumWeekdaysBetweenDates') = 1
	begin
	print('Dropping '+'ufn_NumWeekdaysBetweenDates')
	drop function ufn_NumWeekdaysBetweenDates
	end
else
	begin
	print('No drop needed for '+'ufn_NumWeekdaysBetweenDates')
	end
	;

	go


CREATE FUNCTION [dbo].[ufn_NumWeekdaysBetweenDates]
	(
	  @StartDate AS DATETIME ,
	  @EndDate AS DATETIME
	)
RETURNS INT
AS 
 /*
Name: [ufn_NumWeekdaysBetweenDates]
Author: Matt Laffoon
Description: Returns the number of weekdays between 2 dates
Parameters: @StartDate and @EndDate
Change History:
	- 03/21/2013 - ML - Created
	- 04/23/2014 - ML - Corrected an issue with sunday getting double counted for differences under a week
*/
	BEGIN
		DECLARE	@BusinessDays INT
SELECT @BusinessDays =
	(DATEDIFF(dd, @StartDate, @EndDate))
	- CASE WHEN DATENAME(dw, @EndDate) = 'Sunday' AND DATENAME(dw, @StartDate) <> 'Sunday' AND DATEDIFF(dd, @StartDate, @EndDate) < 7
		THEN (DATEDIFF (wk, @StartDate, @EndDate)) ELSE (DATEDIFF (wk, @StartDate, @EndDate) * 2) END
	- CASE WHEN DATENAME(dw, @EndDate) = 'Sunday' AND DATENAME(dw, @StartDate) <> 'Sunday'  THEN 1 ELSE 0 END
	-CASE WHEN DATENAME(dw, @EndDate) = 'Saturday' AND DATENAME(dw, @StartDate) <> 'Saturday'  THEN 1 ELSE 0 END
	-CASE WHEN DATENAME(dw, @EndDate) <> 'Sunday' AND DATENAME(dw, @StartDate) = 'Sunday'  THEN 1 ELSE 0 END
	-CASE WHEN DATENAME(dw, @EndDate) <> 'Saturday' AND DATENAME(dw, @StartDate) = 'Saturday'  THEN 1 ELSE 0 END
	
		IF @BusinessDays < 0 
			SET @BusinessDays = 0
		RETURN @BusinessDays			
	END

GO



USE [ipmaster]
GO

/****** Object:  UserDefinedFunction [dbo].[ufn_RemoveInvalidCharacters_EN_SAP]    Script Date: 9/21/2020 5:28:06 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


if (select top 1 1 from sys.objects where name='ufn_RemoveInvalidCharacters_EN_SAP') = 1
	begin
	print('Dropping '+'ufn_RemoveInvalidCharacters_EN_SAP')
	drop function ufn_RemoveInvalidCharacters_EN_SAP
	end
else
	begin
	print('No drop needed for '+'ufn_RemoveInvalidCharacters_EN_SAP')
	end
	;

	go

CREATE FUNCTION [dbo].[ufn_RemoveInvalidCharacters_EN_SAP]
(
    @nstring NVARCHAR(MAX)
)
RETURNS VARCHAR(MAX)
AS  /*
Name: ufn_RemoveInvalidCharacters_EN_SAP
Author: Matt Laffoon
Description: Returns the inputed string without characters SAP considers invalid for English
Parameters: @nstring  - the unicode string to be considered.
Change History:
	- 04/10/2013 - ML - Created
*/
BEGIN

    DECLARE @Result NVARCHAR(MAX)
    SET @Result = ''

    DECLARE @nchar NVARCHAR(1)
    DECLARE @position INT

    SET @position = 1
    WHILE @position <= LEN(@nstring)
    BEGIN
        SET @nchar = SUBSTRING(@nstring, @position, 1)
        --Unicode & ASCII are the same from 1 to 255.
        --Only Unicode goes beyond 255
        --0 to 31 are non-printable characters
       --126 defined as the highest code acceptable for EN 
        IF UNICODE(@nchar) BETWEEN  32 AND 126
            SET @Result = @Result + @nchar
        SET @position = @position + 1
    END

    RETURN @Result

END

GO

USE [ipmaster]
GO

/****** Object:  UserDefinedFunction [dbo].[ufn_StripCharacters]    Script Date: 9/21/2020 5:28:14 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




if (select top 1 1 from sys.objects where name='ufn_StripCharacters') = 1
	begin
	print('Dropping '+'ufn_StripCharacters')
	drop function ufn_StripCharacters
	end
else
	begin
	print('No drop needed for '+'ufn_StripCharacters')
	end
	;

	go




CREATE FUNCTION [dbo].[ufn_StripCharacters](
	@String nvarchar(MAX),
	@PatternToStrip nvarchar(MAX),
	@ReplacementString nvarchar(MAX) = ''
)
RETURNS nvarchar(MAX)
AS BEGIN
	DECLARE @pos INT = 1
	DECLARE @end INT = LEN(@String)
	
	WHILE @pos<>0
	BEGIN
		SET @pos = PATINDEX('%[' + @PatternToStrip + ']%', @String)
		IF (@pos <> 0)
			SET @String = STUFF(@String, @pos, 1, @ReplacementString)
	END
	RETURN @String
END

GO





use ipmaster
go



if (select top 1 1 from sys.objects where name='udf_LevenshteinFuzzyMatch_SQL') = 1
	begin
	print('Dropping '+'udf_LevenshteinFuzzyMatch_SQL')
	drop function udf_LevenshteinFuzzyMatch_SQL
	end
else
	begin
	print('No drop needed for '+'udf_LevenshteinFuzzyMatch_SQL')
	end
	;

	go



CREATE FUNCTION udf_LevenshteinFuzzyMatch_SQL(@s1 nvarchar(4000), @s2 nvarchar(4000))
RETURNS FLOAT
AS
BEGIN
  DECLARE @s1l int, @s2l int, @i int, @j int, @sc nchar, @c float, @c1 int,
    @cv0 nvarchar(4000), @cv1 nvarchar(4000), @cmin int , @denominator float
  SELECT @s1l = LEN(@s1 + 'x') - 1, @s2l = LEN(@s2 + 'x') - 1, @cv1 = '', @j = 1, @i = 1, @c = 0
  set @denominator=(case when @s1l<@s2l then @s2l else @s1l end)
  WHILE @j <= @s2l
    SELECT @cv1 = @cv1 + NCHAR(@j), @j = @j + 1
  WHILE @i <= @s1l
  BEGIN
    SELECT @sc = SUBSTRING(@s1, @i, 1), @c1 = @i, @c = @i, @cv0 = '', @j = 1, @cmin = 4000
    WHILE @j <= @s2l
    BEGIN
      SET @c = @c + 1
      SET @c1 = @c1 - CASE WHEN @sc = SUBSTRING(@s2, @j, 1) THEN 1 ELSE 0 END
      IF @c > @c1 SET @c = @c1
      SET @c1 = UNICODE(SUBSTRING(@cv1, @j, 1)) + 1
      IF @c > @c1 SET @c = @c1
      IF @c < @cmin SET @cmin = @c
      SELECT @cv0 = @cv0 + NCHAR(@c), @j = @j + 1
    END
    SELECT @cv1 = @cv0, @i = @i + 1
  END

 

  IF(@s1l=@s2l and @s1l=0)
  RETURN 100
  ELSE IF (@s1l!=@s2l and (@s1l=0 OR  @s2l=0))
  RETURN 0
  

 

  RETURN  ROUND((1-(@c/@denominator))*100,2)
END

go

use ipmaster
go


if (select top 1 1 from sys.objects where name='udf_SplitStringCLR_SQL') = 1
	begin
	print('Dropping '+'udf_SplitStringCLR_SQL')
	drop function udf_SplitStringCLR_SQL
	end
else
	begin
	print('No drop needed for '+'udf_SplitStringCLR_SQL')
	end
	;

	go

CREATE FUNCTION dbo.udf_SplitStringCLR_SQL
(
   @InputString       NVARCHAR(MAX),
   @SplitChar Varchar(100)
)
RETURNS @ValuesList TABLE (item NVARCHAR(MAX))
AS

 

 BEGIN
 INSERT    INTO @ValuesList
      SELECT  y.i.value('(./text())[1]', 'nvarchar(4000)')
      FROM 
      ( 
        SELECT x = CONVERT(XML, '<i>' 
          + REPLACE(@InputString, ISNULL(@SplitChar,''), '</i><i>') 
          + '</i>').query('.')
      ) AS a CROSS APPLY x.nodes('i') AS y(i) where isnull(y.i.value('(./text())[1]', 'nvarchar(4000)'),'')<>''
  
  RETURN

 

END
go
