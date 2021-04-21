USE [msdb]
GO

IF EXISTS (SELECT 1 FROM [dbo].[sysjobs] WHERE name = 'Nightly_Maintenance')
    EXEC msdb..sp_delete_job @job_name = 'Nightly_Maintenance'; 

/****** Object:  Job [Nightly_Maintenance]    Script Date: 5/26/2020 10:28:35 AM ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]    Script Date: 5/26/2020 10:28:35 AM ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'Nightly_Maintenance', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'This job will perform all steps including: Truncate temporary tables, Reindex, Recompute Statistics, Check Database Integrity, Create Backup. Delete Old Backups, Delete Old History. If any of the first steps fail, it will still perform the backup, but will report failure of the job and send notification.', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'master', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

/****** Object:  Step [Truncate Temporary Tables]    Script Date: 5/26/2020 10:28:35 AM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Truncate Temporary Tables', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=3, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'PRINT ''No Tables To Truncate Yet''', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

/****** Object:  Step [Create Backup]    Script Date: 5/26/2020 10:28:35 AM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Create Backup', 
		@step_id=2, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'DECLARE @name VARCHAR(50) -- database name  
DECLARE @path VARCHAR(256) -- path for backup files  
DECLARE @fileName VARCHAR(256) -- filename for backup  
DECLARE @fileDate VARCHAR(20) -- used for file name 
DECLARE @S3ARN_Prefix         NVARCHAR(100) 
DECLARE @S3ARN                NVARCHAR(100)
DECLARE @BackupFileName       VARCHAR(50)

SELECT @fileDate = CONVERT(VARCHAR(20),GETDATE(),112) 
SET @S3ARN_Prefix = ''arn:aws:s3:::a205822-infrastructure-database-backups-prod/backups/''

DECLARE db_cursor CURSOR STATIC FOR  
SELECT name 
FROM master.dbo.sysdatabases 
WHERE name NOT IN (''master'', ''tempdb'', ''model'', ''msdb'', ''rdsadmin'',''ContentIntegration'')  
	AND name NOT LIKE ''REPL%'' 
	AND name NOT LIKE ''%Archive%'' 
	AND name NOT LIKE ''%Hist%'' 
	AND name NOT LIKE ''%Temp%'' 
	AND name NOT LIKE ''%BAK%''
	AND CONVERT(INT,status & 0x200) / 512 = 0 --ensure that the database is online

OPEN db_cursor   
FETCH NEXT FROM db_cursor INTO @name   

WHILE @@FETCH_STATUS = 0   
BEGIN
	SET @BackupFileName = @name + ''_'' + @fileDate + ''.bak'' 

	IF CHARINDEX (''_PRD'', @name) > 0
		SET @S3ARN = @S3ARN_Prefix + ''prd/'' + @BackupFileName
	ELSE IF CHARINDEX (''_UAT'', @name) > 0
		SET @S3ARN = @S3ARN_Prefix + ''uat/'' + @BackupFileName
	ELSE IF CHARINDEX (''_IMP'', @name) > 0
		SET @S3ARN = @S3ARN_Prefix + ''imp/'' + @BackupFileName
	ELSE
		SET @S3ARN = @S3ARN_Prefix + @BackupFileName
      
  EXEC msdb.dbo.rds_backup_database 
      @source_db_name = @name, 
      @S3_arn_to_backup_to = @S3ARN,
      @overwrite_S3_backup_file = 0,
			@type=''FULL''

	FETCH NEXT FROM db_cursor INTO @name   
END   

CLOSE db_cursor   
DEALLOCATE db_cursor 
', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

-- Commenting below steps due to permission issues.
/*
/****** Object:  Step [Nightly Dynamic Reindex and Recompute Statistics]    Script Date: 5/26/2020 10:28:35 AM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Nightly Dynamic Reindex and Recompute Statistics', 
		@step_id=3, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=3, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'EXEC sp_msforeachdb ''IF exists (select 1 from [?]..sysobjects where name = ''''usp_DBARebuildIndexes'''') AND datepart(weekday,getdate()) NOT IN (1,7) begin EXEC [?]..usp_DBARebuildIndexes @DisableLargeTables = 1 END''
		', 
		@database_name=N'master', 
		--@output_file_name=N'D:\SQL Server\MSSQL13.QA2016\MSSQL\Log\IndexMaintenance.txt', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

/****** Object:  Step [update stats master]    Script Date: 5/26/2020 10:28:35 AM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'update stats master', 
		@step_id=4, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=3, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'DECLARE @minDateDiff int, @sql nvarchar(1000), @schema nvarchar(130), @table nvarchar(130), @stat nvarchar(130), @lastupd datetime; 
 
-- Min difference between statistics and index(es) update timestamp 
-- in days. 
SET @minDateDiff = 7; 
 
DECLARE StatsCursor CURSOR LOCAL FOR 
    SELECT SCH.name AS SchemaName 
          ,OBJ.name AS ObjectName 
          ,STA.name AS StatName 
          ,STATS_DATE(STA.object_id, STA.stats_id) AS StatUpdateStamp 
    FROM sys.stats AS STA 
         INNER JOIN sys.objects AS OBJ 
             ON STA.object_id = OBJ.object_id 
         INNER JOIN sys.schemas AS SCH 
             ON OBJ.schema_id = SCH.schema_id 
         LEFT JOIN 
         (SELECT IUS.object_id 
                ,MIN(ISNULL(IUS.last_user_update, IUS.last_system_update)) AS LastUpdate 
          FROM sys.dm_db_index_usage_stats AS IUS 
          WHERE database_id = DB_ID() 
                AND NOT ISNULL(IUS.last_user_update, IUS.last_system_update) IS NULL 
          GROUP BY IUS.object_id 
         ) AS IUS 
             ON IUS.object_id = STA.object_id 
    WHERE OBJ.type IN (''U'', ''V'')    -- only user tables and views 
          AND DATEDIFF(d, ISNULL(STATS_DATE(STA.object_id, STA.stats_id), {d N''1900-01-01''}) 
                        , IUS.LastUpdate) > @minDateDiff 
    ORDER BY STATS_DATE(STA.object_id, stats_id) ASC; 
 
-- Open the cursor 
OPEN StatsCursor; 

 
FETCH NEXT FROM StatsCursor 
    INTO @schema, @table, @stat, @lastupd 
WHILE @@FETCH_STATUS = 0 
BEGIN 
    -- Infoprint. 
    PRINT @schema + N''.'' + @table + CHAR(9) + @stat + CHAR(9) + ''-> '' + CONVERT(nvarchar(20), ISNULL(@lastupd, ''''), 120); 
 
    SET @sql = N''UPDATE STATISTICS '' 
               + QUOTENAME(@schema) + N''.'' + QUOTENAME(@table) + N''('' 
               + QUOTENAME(@stat) + N'') '' 
               + ''WITH FULLSCAN''
	
	exec (@sql )

    FETCH NEXT FROM StatsCursor 
        INTO @schema, @table, @stat, @lastupd; 
END; 
 
CLOSE StatsCursor; 
DEALLOCATE StatsCursor;
', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

/****** Object:  Step [Truncate Logs]    Script Date: 5/26/2020 10:28:35 AM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Truncate Logs', 
		@step_id=5, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=3, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'SET NOCOUNT ON 

DECLARE	@db_name AS NVARCHAR(300)
DECLARE	@db_logfile_physical_name AS NVARCHAR(300)

DECLARE get_files CURSOR
FOR
	SELECT	d.name ,
			f.name
	FROM	sysaltfiles f
			INNER JOIN sysdatabases d ON ( f.dbid = d.dbid )
	WHERE	fileid = 2
			AND d.dbid > 4
			AND CONVERT(INT,d.status & 0x200) / 512 = 0 --ensure that the database is online
	ORDER BY 1 ,
			2

OPEN get_files
FETCH NEXT FROM get_files INTO @db_name, @db_logfile_physical_name
DECLARE	@Command AS NVARCHAR(4000)
DECLARE @Recovery AS VARCHAR(100)
WHILE ( @@FETCH_STATUS = 0 ) 	
	BEGIN
		SELECT @Recovery = CAST(databasepropertyex(name, ''Recovery'') AS VARCHAR(100)) from master.dbo.sysdatabases WHERE name = @db_name  
		IF @Recovery = ''SIMPLE''
		BEGIN
		DECLARE @filename VARCHAR(100)
		SET @db_logfile_physical_name = LTRIM(RTRIM(@db_logfile_physical_name))
		SELECT	@Command = N''USE ['' + @db_name + N''] DBCC SHRINKFILE (''''''
				+ @db_logfile_physical_name + '''''', TRUNCATEONLY)  WITH NO_INFOMSGS ''
		EXEC sp_executesql @Command
		PRINT @Command
		END
		ELSE
		BEGIN      
		PRINT ''********* '' + @db_name + '' has recovery of '' + @Recovery + '' *********''
		END
		FETCH NEXT FROM get_files INTO @db_name, @db_logfile_physical_name
	END

CLOSE get_files
DEALLOCATE get_files', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

/****** Object:  Step [truncate logs 0]    Script Date: 5/26/2020 10:28:35 AM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'truncate logs 0', 
		@step_id=6, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'SET NOCOUNT ON 
DECLARE	@db_name AS NVARCHAR(300)
DECLARE	@db_logfile_physical_name AS NVARCHAR(300)

DECLARE get_files CURSOR
FOR
	SELECT	d.name ,
			f.name
	FROM	sysaltfiles f
			INNER JOIN sysdatabases d ON ( f.dbid = d.dbid )
	WHERE	fileid = 2
			AND d.dbid > 4
			AND CONVERT(INT,d.status & 0x200) / 512 = 0 --ensure that the database is online
			and ((f.size*8)/1024/1024) > 100 --greater than 100gb
	ORDER BY 1 ,
			2

OPEN get_files
FETCH NEXT FROM get_files INTO @db_name, @db_logfile_physical_name
DECLARE	@Command AS NVARCHAR(4000)
WHILE ( @@FETCH_STATUS = 0 ) 	
	BEGIN
		DECLARE @filename VARCHAR(100)
		SET @db_logfile_physical_name = LTRIM(RTRIM(@db_logfile_physical_name))
		SELECT	@Command = N''USE ['' + @db_name + N''] DBCC SHRINKFILE (''''''
				+ @db_logfile_physical_name + '''''', TRUNCATEONLY)  WITH NO_INFOMSGS ''
		EXEC sp_executesql @Command
		FETCH NEXT FROM get_files INTO @db_name, @db_logfile_physical_name
	END

CLOSE get_files
DEALLOCATE get_files', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

/****** Object:  Step [Delete Old History]    Script Date: 5/26/2020 10:28:35 AM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Delete Old History', 
		@step_id=7, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=1, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'declare @twentyEightDaysAgo datetime
set @twentyEightDaysAgo = DATEADD(DAY,-28,GETDATE())

exec msdb.dbo.sp_delete_backuphistory @twentyEightDaysAgo
', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
*/

EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1

IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'dailybackup', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=1, 
		@active_start_date=20200527, 
		@active_end_date=99991231, 
		@active_start_time=0, 
		@active_end_time=235959 
		--@schedule_uid=N'633754a7-ca7d-4b09-8745-1ef19de2fd45'

IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'

IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:
GO

