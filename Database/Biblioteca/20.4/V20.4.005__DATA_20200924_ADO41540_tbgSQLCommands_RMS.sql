DECLARE @CurrentSQLGuid1 AS VARCHAR(36) = 'ac9a627a-ff70-4d2e-9b31-174b1135f794';
DECLARE @CurrentSQLDescription1 AS NVARCHAR(500) = 'Export Lookup: All Shipments on Hold';
DECLARE @CurrentSQLLongDescription1 AS NVARCHAR(MAX) = 'Displays all of the Shipements that are currently on Hold.';
DECLARE @CurrentSQLScript1 AS NVARCHAR(MAX) = 'SELECT * ,  ROW_NUMBER() OVER ( ORDER BY @orderby@, OrderNumShip ) AS [RowNum] FROM (  SELECT DISTINCT   ''[''+ ''Edit'' + '']'' + ''(/Export/fidExportCISLI.aspx?TYPE='' + eh.RecordType + ''&ExportGuid=''+ CAST (eh.ExportGuid AS VARCHAR(50)) + '')'' AS Edit,   eh.OrderNumShip,    ISNULL(g.Decode, '''') as Status,   1 AS NoOrder  FROM txdExportHeader eh (NOLOCK)   JOIN txdExportParties ep (NOLOCK)    ON eh.ExportGUID = ep.ExportGUID   AND eh.PartnerID = ep.PartnerID  LEFT JOIN tmgglobalcodes g (nolock)   ON g.partnerid = eh.partnerid   AND g.code = eh.status   AND g.fieldname = ''EXPORTSTATUS''  WHERE   EXISTS (SELECT ExportGuid FROM txdExportSystemMessages with (nolock)                  WHERE ExportGuid = eh.ExportGuid AND HoldFlag = ''Y'')   AND eh.Status = ''H''   AND eh.recordtype = ''E''   AND eh.partnerid = @PartnerID ) AS LookupViewInner WHERE   @whereclause@';

IF EXISTS (
		SELECT TOP 1 1
		FROM tbgSQLCommands WITH (NOLOCK)
		WHERE SQLGUID = CAST(@CurrentSQLGuid1 AS UNIQUEIDENTIFIER)
			AND SQLType = 'General SQL'
			AND Version = '20.4'
		)
BEGIN
	IF (
			SELECT Count(SQLhash)
			FROM (
				SELECT SQLhash
				FROM tbgSQLcommands WITH (NOLOCK)
				WHERE SQLGUID = CAST(@CurrentSQLGuid1 AS UNIQUEIDENTIFIER)
					AND Version = '20.4'
					AND SQLType = 'General SQL'
				
				UNION
				
				SELECT HASHBYTES('MD5', LEFT(@CurrentSQLScript1, 4000)) AS SQLhash
				) tmp
			) <> 1
	BEGIN
		INSERT INTO tbgSQLcommandsHist
		SELECT [PartnerID]
			,[EffDate]
			,[SQLGUID]
			,[SQLCommand]
			,[Description]
			,[LongDescription]
			,[CreatedDate]
			,[CreatedBy]
			,[ApprovedBy]
			,[SQLHash]
			,[SQLType]
			,[Version]
			,[DeletedFlag]
			,[KeepDuringRollback]
		FROM tbgSQLcommands WITH (NOLOCK)
		WHERE SQLGUID = CAST(@CurrentSQLGuid1 AS UNIQUEIDENTIFIER)
			AND Version = '20.4'
			AND SQLType = 'General SQL';

		DELETE
		FROM tbgSQLCommands
		WHERE SQLGUID = CAST(@CurrentSQLGuid1 AS UNIQUEIDENTIFIER)
			AND Version = '20.4'
			AND SQLType = 'General SQL';

		INSERT [dbo].[tbgSQLCommands] (
			[PartnerID]
			,[EffDate]
			,[SQLGUID]
			,[SQLCommand]
			,[Description]
			,[LongDescription]
			,[CreatedDate]
			,[CreatedBy]
			,[ApprovedBy]
			,[SQLHash]
			,[SQLType]
			,[Version]
			,[DeletedFlag]
			,[KeepDuringRollback]
			)
		VALUES (
			4000
			,GETDATE()
			,@CurrentSQLGuid1
			,@CurrentSQLScript1
			,@CurrentSQLDescription1
			,@CurrentSQLLongDescription1
			,GETDATE()
			,'rsheth'
			,'rsheth'
			,HASHBYTES('MD5', LEFT(@CurrentSQLScript1, 4000))
			,'General SQL'
			,'20.4'
			,'N'
			,'N'
			);
	END
END
ELSE
BEGIN
	INSERT [dbo].[tbgSQLCommands] (
		[PartnerID]
		,[EffDate]
		,[SQLGUID]
		,[SQLCommand]
		,[Description]
		,[LongDescription]
		,[CreatedDate]
		,[CreatedBy]
		,[ApprovedBy]
		,[SQLHash]
		,[SQLType]
		,[Version]
		,[DeletedFlag]
		,[KeepDuringRollback]
		)
	VALUES (
		4000
		,GETDATE()
		,@CurrentSQLGuid1
		,@CurrentSQLScript1
		,@CurrentSQLDescription1
		,@CurrentSQLLongDescription1
		,GETDATE()
		,'rsheth'
		,'rsheth'
		,HASHBYTES('MD5', LEFT(@CurrentSQLScript1, 4000))
		,'General SQL'
		,'20.4'
		,'N'
		,'N'
		);
END

DECLARE @CurrentSQLGuid2 AS VARCHAR(36) = '69a8f10e-78e3-4087-9834-654adc7f5642';
DECLARE @CurrentSQLDescription2 AS NVARCHAR(500) = 'Export Lookup: Denied Parties Hold';
DECLARE @CurrentSQLLongDescription2 AS NVARCHAR(MAX) = 'Displays all of the shipments that have been put on hold due to a Denied Party';
DECLARE @CurrentSQLScript2 AS NVARCHAR(MAX) = 'SELECT * ,  ROW_NUMBER() OVER ( ORDER BY @orderby@ ) AS [RowNum]  FROM       (    SELECT DISTINCT    ''[''+ ''Edit'' + '']'' + ''(/Export/fidExportCISLI.aspx?TYPE='' + eh.RecordType + ''&ExportGuid=''+ CAST(eh.ExportGuid AS VARCHAR(50)) + '')'' AS Edit,    eh.OrderNumShip,     eh.OrderNum,    ISNULL(g.Decode, eh.Status) AS Status,    em.Message AS HoldReason,    1 AS NoOrder   FROM txdExportHeader eh (NOLOCK)    LEFT JOIN tmgGlobalCodes g (NOLOCK)    ON g.PartnerID = eh.PartnerID    AND g.Code = eh.Status    AND g.fieldname = ''EXPORTSTATUS''   JOIN txdExportSystemMessages em (NOLOCK)     ON eh.ExportGuid = em.ExportGuid     AND eh.PartnerID = em.PartnerID     AND em.MessageType = ''DPS''   WHERE    eh.Status = ''H''    AND eh.RecordType = ''E''    AND eh.PartnerID = @PartnerID  ) AS LookupViewInner  WHERE                                  @whereclause@';

IF EXISTS (
		SELECT TOP 1 1
		FROM tbgSQLCommands WITH (NOLOCK)
		WHERE SQLGUID = CAST(@CurrentSQLGuid2 AS UNIQUEIDENTIFIER)
			AND SQLType = 'General SQL'
			AND Version = '20.4'
		)
BEGIN
	IF (
		SELECT Count(LongDescription)
			FROM (
				SELECT LongDescription
				FROM tbgSQLcommands WITH (NOLOCK)
				WHERE SQLGUID = CAST(@CurrentSQLGuid2 AS UNIQUEIDENTIFIER)
					AND Version = '20.4'
					AND SQLType = 'General SQL'
				
				UNION
				
				SELECT @CurrentSQLLongDescription2 AS LongDescription
				) tmp
			) <> 1
	BEGIN
		INSERT INTO tbgSQLcommandsHist
		SELECT [PartnerID]
			,[EffDate]
			,[SQLGUID]
			,[SQLCommand]
			,[Description]
			,[LongDescription]
			,[CreatedDate]
			,[CreatedBy]
			,[ApprovedBy]
			,[SQLHash]
			,[SQLType]
			,[Version]
			,[DeletedFlag]
			,[KeepDuringRollback]
		FROM tbgSQLcommands WITH (NOLOCK)
		WHERE SQLGUID = CAST(@CurrentSQLGuid2 AS UNIQUEIDENTIFIER)
			AND Version = '20.4'
			AND SQLType = 'General SQL';

		DELETE
		FROM tbgSQLCommands
		WHERE SQLGUID = CAST(@CurrentSQLGuid2 AS UNIQUEIDENTIFIER)
			AND Version = '20.4'
			AND SQLType = 'General SQL';

		INSERT [dbo].[tbgSQLCommands] (
			[PartnerID]
			,[EffDate]
			,[SQLGUID]
			,[SQLCommand]
			,[Description]
			,[LongDescription]
			,[CreatedDate]
			,[CreatedBy]
			,[ApprovedBy]
			,[SQLHash]
			,[SQLType]
			,[Version]
			,[DeletedFlag]
			,[KeepDuringRollback]
			)
		VALUES (
			4000
			,GETDATE()
			,@CurrentSQLGuid2
			,@CurrentSQLScript2
			,@CurrentSQLDescription2
			,@CurrentSQLLongDescription2
			,GETDATE()
			,'rsheth'
			,'rsheth'
			,HASHBYTES('MD5', LEFT(@CurrentSQLScript2, 4000))
			,'General SQL'
			,'20.4'
			,'N'
			,'N'
			);
	END
END
ELSE
BEGIN
	INSERT [dbo].[tbgSQLCommands] (
		[PartnerID]
		,[EffDate]
		,[SQLGUID]
		,[SQLCommand]
		,[Description]
		,[LongDescription]
		,[CreatedDate]
		,[CreatedBy]
		,[ApprovedBy]
		,[SQLHash]
		,[SQLType]
		,[Version]
		,[DeletedFlag]
		,[KeepDuringRollback]
		)
	VALUES (
		4000
		,GETDATE()
		,@CurrentSQLGuid2
		,@CurrentSQLScript2
		,@CurrentSQLDescription2
		,@CurrentSQLLongDescription2
		,GETDATE()
		,'rsheth'
		,'rsheth'
		,HASHBYTES('MD5', LEFT(@CurrentSQLScript2, 4000))
		,'General SQL'
		,'20.4'
		,'N'
		,'N'
		);
END

DECLARE @CurrentSQLGuid3 AS VARCHAR(36) = 'd6be8e80-99a5-4506-a748-dbd2c9331fdf';
DECLARE @CurrentSQLDescription3 AS NVARCHAR(500) = 'Export Lookup: Missing Export Tariff #';
DECLARE @CurrentSQLLongDescription3 AS NVARCHAR(MAX) = 'Displays the shipments that have a detail line that is missing an export tariff number.';
DECLARE @CurrentSQLScript3 AS NVARCHAR(MAX) = 'SELECT * ,  ROW_NUMBER() OVER ( ORDER BY @orderby@) AS [RowNum]  FROM       (    SELECT DISTINCT    ''[''+ ''Edit'' + '']'' + ''(/Export/fidExportCISLI.aspx?TYPE='' + eh.RecordType + ''&ExportGuid=''+ CAST(eh.ExportGuid AS VARCHAR(50)) + '')'' AS Edit,    eh.OrderNumShip,     eh.OrderNum, eh.ExportDate,  ISNULL(g.Decode, eh.Status) AS Status,    1 AS NoOrder   FROM txdExportHeader eh (NOLOCK)    LEFT JOIN tmgGlobalCodes g (NOLOCK)    ON g.PartnerID = eh.PartnerID    AND g.Code = eh.Status    AND g.FieldName = ''EXPORTSTATUS''   where eh.RecordType = ''E''    AND eh.PartnerID = @PartnerID    AND EXISTS(SELECT 1 FROM txdExportDetail ED (NOLOCK)         WHERE ed.ExportGUID = eh.ExportGUID        AND ED.PartnerID = eh.PartnerID         AND ED.ExportTariffNum = ''''        )  ) AS LookupViewInner  WHERE                                  @whereclause@';

IF EXISTS (
		SELECT TOP 1 1
		FROM tbgSQLCommands WITH (NOLOCK)
		WHERE SQLGUID = CAST(@CurrentSQLGuid3 AS UNIQUEIDENTIFIER)
			AND SQLType = 'General SQL'
			AND Version = '20.4'
		)
BEGIN
	IF (
			SELECT Count(LongDescription)
			FROM (
				SELECT LongDescription
				FROM tbgSQLcommands WITH (NOLOCK)
				WHERE SQLGUID = CAST(@CurrentSQLGuid3 AS UNIQUEIDENTIFIER)
					AND Version = '20.4'
					AND SQLType = 'General SQL'
				
				UNION
				
				SELECT @CurrentSQLLongDescription3 AS LongDescription
				) tmp
			) <> 1
	BEGIN
		INSERT INTO tbgSQLcommandsHist
		SELECT [PartnerID]
			,[EffDate]
			,[SQLGUID]
			,[SQLCommand]
			,[Description]
			,[LongDescription]
			,[CreatedDate]
			,[CreatedBy]
			,[ApprovedBy]
			,[SQLHash]
			,[SQLType]
			,[Version]
			,[DeletedFlag]
			,[KeepDuringRollback]
		FROM tbgSQLcommands WITH (NOLOCK)
		WHERE SQLGUID = CAST(@CurrentSQLGuid3 AS UNIQUEIDENTIFIER)
			AND Version = '20.4'
			AND SQLType = 'General SQL';

		DELETE
		FROM tbgSQLCommands
		WHERE SQLGUID = CAST(@CurrentSQLGuid3 AS UNIQUEIDENTIFIER)
			AND Version = '20.4'
			AND SQLType = 'General SQL';

		INSERT [dbo].[tbgSQLCommands] (
			[PartnerID]
			,[EffDate]
			,[SQLGUID]
			,[SQLCommand]
			,[Description]
			,[LongDescription]
			,[CreatedDate]
			,[CreatedBy]
			,[ApprovedBy]
			,[SQLHash]
			,[SQLType]
			,[Version]
			,[DeletedFlag]
			,[KeepDuringRollback]
			)
		VALUES (
			4000
			,GETDATE()
			,@CurrentSQLGuid3
			,@CurrentSQLScript3
			,@CurrentSQLDescription3
			,@CurrentSQLLongDescription3
			,GETDATE()
			,'rsheth'
			,'rsheth'
			,HASHBYTES('MD5', LEFT(@CurrentSQLScript3, 4000))
			,'General SQL'
			,'20.4'
			,'N'
			,'N'
			);
	END
END
ELSE
BEGIN
	INSERT [dbo].[tbgSQLCommands] (
		[PartnerID]
		,[EffDate]
		,[SQLGUID]
		,[SQLCommand]
		,[Description]
		,[LongDescription]
		,[CreatedDate]
		,[CreatedBy]
		,[ApprovedBy]
		,[SQLHash]
		,[SQLType]
		,[Version]
		,[DeletedFlag]
		,[KeepDuringRollback]
		)
	VALUES (
		4000
		,GETDATE()
		,@CurrentSQLGuid3
		,@CurrentSQLScript3
		,@CurrentSQLDescription3
		,@CurrentSQLLongDescription3
		,GETDATE()
		,'rsheth'
		,'rsheth'
		,HASHBYTES('MD5', LEFT(@CurrentSQLScript3, 4000))
		,'General SQL'
		,'20.4'
		,'N'
		,'N'
		);
END

DECLARE @CurrentSQLGuid4 AS VARCHAR(36) = '93beabb3-bed0-438a-8518-4ddf06f527ea';
DECLARE @CurrentSQLDescription4 AS NVARCHAR(500) = 'Export Lookup: Missing ECN';
DECLARE @CurrentSQLLongDescription4 AS NVARCHAR(MAX) = 'Displays the shipments that have a detail line that is missing an ECN number.';
DECLARE @CurrentSQLScript4 AS NVARCHAR(MAX) = 'SELECT * ,  ROW_NUMBER() OVER ( ORDER BY @orderby@) AS [RowNum]  FROM       (    SELECT DISTINCT    ''[''+ ''Edit'' + '']'' + ''(/Export/fidExportCISLI.aspx?TYPE='' + eh.RecordType + ''&ExportGuid=''+ CAST(eh.ExportGuid AS VARCHAR(50)) + '')'' AS Edit,    eh.OrderNumShip,     eh.OrderNum, eh.ExportDate,   ISNULL(g.Decode, eh.Status) AS Status,    1 AS NoOrder   FROM txdExportHeader eh (NOLOCK)    LEFT JOIN tmgGlobalCodes g WITH (NOLOCK)    ON g.PartnerID = eh.PartnerID    AND g.Code = eh.Status    AND g.FieldName = ''EXPORTSTATUS''   WHERE eh.RecordType = ''E''   AND eh.PartnerID = @PartnerID   AND EXISTS(SELECT 1 FROM txdExportDetail ED (NOLOCK)       WHERE ed.ExportGUID = eh.ExportGUID       AND ED.PartnerID = eh.PartnerID        AND ED.ECNNum  = ''''       )  ) AS LookupViewInner  WHERE                                  @whereclause@';

IF EXISTS (
		SELECT TOP 1 1
		FROM tbgSQLCommands WITH (NOLOCK)
		WHERE SQLGUID = CAST(@CurrentSQLGuid4 AS UNIQUEIDENTIFIER)
			AND SQLType = 'General SQL'
			AND Version = '20.4'
		)
BEGIN
	IF (
			SELECT Count(LongDescription)
			FROM (
				SELECT LongDescription
				FROM tbgSQLcommands WITH (NOLOCK)
				WHERE SQLGUID = CAST(@CurrentSQLGuid4 AS UNIQUEIDENTIFIER)
					AND Version = '20.4'
					AND SQLType = 'General SQL'
				
				UNION
				
				SELECT @CurrentSQLLongDescription4 AS LongDescription
				) tmp
			) <> 1
	BEGIN
		INSERT INTO tbgSQLcommandsHist
		SELECT [PartnerID]
			,[EffDate]
			,[SQLGUID]
			,[SQLCommand]
			,[Description]
			,[LongDescription]
			,[CreatedDate]
			,[CreatedBy]
			,[ApprovedBy]
			,[SQLHash]
			,[SQLType]
			,[Version]
			,[DeletedFlag]
			,[KeepDuringRollback]
		FROM tbgSQLcommands WITH (NOLOCK)
		WHERE SQLGUID = CAST(@CurrentSQLGuid4 AS UNIQUEIDENTIFIER)
			AND Version = '20.4'
			AND SQLType = 'General SQL';

		DELETE
		FROM tbgSQLCommands
		WHERE SQLGUID = CAST(@CurrentSQLGuid4 AS UNIQUEIDENTIFIER)
			AND Version = '20.4'
			AND SQLType = 'General SQL';

		INSERT [dbo].[tbgSQLCommands] (
			[PartnerID]
			,[EffDate]
			,[SQLGUID]
			,[SQLCommand]
			,[Description]
			,[LongDescription]
			,[CreatedDate]
			,[CreatedBy]
			,[ApprovedBy]
			,[SQLHash]
			,[SQLType]
			,[Version]
			,[DeletedFlag]
			,[KeepDuringRollback]
			)
		VALUES (
			4000
			,GETDATE()
			,@CurrentSQLGuid4
			,@CurrentSQLScript4
			,@CurrentSQLDescription4
			,@CurrentSQLLongDescription4
			,GETDATE()
			,'rsheth'
			,'rsheth'
			,HASHBYTES('MD5', LEFT(@CurrentSQLScript4, 4000))
			,'General SQL'
			,'20.4'
			,'N'
			,'N'
			);
	END
END
ELSE
BEGIN
	INSERT [dbo].[tbgSQLCommands] (
		[PartnerID]
		,[EffDate]
		,[SQLGUID]
		,[SQLCommand]
		,[Description]
		,[LongDescription]
		,[CreatedDate]
		,[CreatedBy]
		,[ApprovedBy]
		,[SQLHash]
		,[SQLType]
		,[Version]
		,[DeletedFlag]
		,[KeepDuringRollback]
		)
	VALUES (
		4000
		,GETDATE()
		,@CurrentSQLGuid4
		,@CurrentSQLScript4
		,@CurrentSQLDescription4
		,@CurrentSQLLongDescription4
		,GETDATE()
		,'rsheth'
		,'rsheth'
		,HASHBYTES('MD5', LEFT(@CurrentSQLScript4, 4000))
		,'General SQL'
		,'20.4'
		,'N'
		,'N'
		);
END

DECLARE @CurrentSQLGuid5 AS VARCHAR(36) = 'b9b764cc-36ac-48a7-88f2-f4d076b4f003';
DECLARE @CurrentSQLDescription5 AS NVARCHAR(500) = 'Export Lookup: Missing Product Numbers';
DECLARE @CurrentSQLLongDescription5 AS NVARCHAR(MAX) = 'Displays shipments that have detail lines missing product numbers.';
DECLARE @CurrentSQLScript5 AS NVARCHAR(MAX) = 'SELECT * , ROW_NUMBER() OVER ( ORDER BY @orderby@) AS [RowNum] FROM      (  SELECT DISTINCT   ''[''+ ''Edit'' + '']'' + ''(/Export/fidExportCISLI.aspx?TYPE='' + eh.RecordType + ''&ExportGuid=''+ cast (eh.ExportGuid AS varchar(50)) + '')'' AS Edit,   eh.OrderNumShip,    eh.OrderNum,   ISNULL(g.Decode, eh.Status) as Status,   1 AS NoOrder  FROM txdExportHeader eh (NOLOCK)   LEFT JOIN tmgGlobalCodes g (NOLOCK)   ON g.PartnerID = eh.PartnerID   AND g.Code = eh.Status   AND g.FieldName = ''EXPORTSTATUS''  where eh.recordtype = ''E''   AND eh.partnerid = @PartnerID   AND eh.ProcessedFlag = ''Y''   AND EXISTS(SELECT 1 FROM txdExportDetail ED with (nolock)      WHERE ED.ExportGUID = eh.ExportGUID       AND ed.PartnerID = eh.PartnerID       AND ED.productnum = '''') ) AS LookupViewInner WHERE                                 @whereclause@';

IF EXISTS (
		SELECT TOP 1 1
		FROM tbgSQLCommands WITH (NOLOCK)
		WHERE SQLGUID = CAST(@CurrentSQLGuid5 AS UNIQUEIDENTIFIER)
			AND SQLType = 'General SQL'
			AND Version = '20.4'
		)
BEGIN
	IF (
			SELECT Count(SQLhash)
			FROM (
				SELECT SQLhash
				FROM tbgSQLcommands WITH (NOLOCK)
				WHERE SQLGUID = CAST(@CurrentSQLGuid5 AS UNIQUEIDENTIFIER)
					AND Version = '20.4'
					AND SQLType = 'General SQL'
				
				UNION
				
				SELECT HASHBYTES('MD5', LEFT(@CurrentSQLScript5, 4000)) AS SQLhash
				) tmp
			) <> 1
	BEGIN
		INSERT INTO tbgSQLcommandsHist
		SELECT [PartnerID]
			,[EffDate]
			,[SQLGUID]
			,[SQLCommand]
			,[Description]
			,[LongDescription]
			,[CreatedDate]
			,[CreatedBy]
			,[ApprovedBy]
			,[SQLHash]
			,[SQLType]
			,[Version]
			,[DeletedFlag]
			,[KeepDuringRollback]
		FROM tbgSQLcommands WITH (NOLOCK)
		WHERE SQLGUID = CAST(@CurrentSQLGuid5 AS UNIQUEIDENTIFIER)
			AND Version = '20.4'
			AND SQLType = 'General SQL';

		DELETE
		FROM tbgSQLCommands
		WHERE SQLGUID = CAST(@CurrentSQLGuid5 AS UNIQUEIDENTIFIER)
			AND Version = '20.4'
			AND SQLType = 'General SQL';

		INSERT [dbo].[tbgSQLCommands] (
			[PartnerID]
			,[EffDate]
			,[SQLGUID]
			,[SQLCommand]
			,[Description]
			,[LongDescription]
			,[CreatedDate]
			,[CreatedBy]
			,[ApprovedBy]
			,[SQLHash]
			,[SQLType]
			,[Version]
			,[DeletedFlag]
			,[KeepDuringRollback]
			)
		VALUES (
			4000
			,GETDATE()
			,@CurrentSQLGuid5
			,@CurrentSQLScript5
			,@CurrentSQLDescription5
			,@CurrentSQLLongDescription5
			,GETDATE()
			,'rsheth'
			,'rsheth'
			,HASHBYTES('MD5', LEFT(@CurrentSQLScript5, 4000))
			,'General SQL'
			,'20.4'
			,'N'
			,'N'
			);
	END
END
ELSE
BEGIN
	INSERT [dbo].[tbgSQLCommands] (
		[PartnerID]
		,[EffDate]
		,[SQLGUID]
		,[SQLCommand]
		,[Description]
		,[LongDescription]
		,[CreatedDate]
		,[CreatedBy]
		,[ApprovedBy]
		,[SQLHash]
		,[SQLType]
		,[Version]
		,[DeletedFlag]
		,[KeepDuringRollback]
		)
	VALUES (
		4000
		,GETDATE()
		,@CurrentSQLGuid5
		,@CurrentSQLScript5
		,@CurrentSQLDescription5
		,@CurrentSQLLongDescription5
		,GETDATE()
		,'rsheth'
		,'rsheth'
		,HASHBYTES('MD5', LEFT(@CurrentSQLScript5, 4000))
		,'General SQL'
		,'20.4'
		,'N'
		,'N'
		);
END

DECLARE @CurrentSQLGuid7 AS VARCHAR(36) = '25480f2e-5b87-460f-8971-698f93d7a12d';
DECLARE @CurrentSQLDescription7 AS NVARCHAR(500) = 'Export Lookup: Duplicate Transactions';
DECLARE @CurrentSQLLongDescription7 AS NVARCHAR(MAX) = 'Displays the shipments that have duplicate records as well as the number of duplications.    ';
DECLARE @CurrentSQLScript7 AS NVARCHAR(MAX) = 'SELECT * ,  ROW_NUMBER() OVER ( ORDER BY @orderby@) AS [RowNum]  FROM       (    SELECT DISTINCT    eh.InvoiceNum,    COUNT(eh.InvoiceNum) AS DuplicateCount,    1 AS NoOrder   FROM txdExportHeader eh (NOLOCK)    WHERE eh.RecordType = ''E''    AND eh.PartnerID = @PartnerID     AND eh.Status NOT IN (''F'', ''V'')    GROUP BY eh.InvoiceNum    HAVING COUNT(*) > 1  ) AS LookupViewInner  WHERE                                  @whereclause@';

IF EXISTS (
		SELECT TOP 1 1
		FROM tbgSQLCommands WITH (NOLOCK)
		WHERE SQLGUID = CAST(@CurrentSQLGuid7 AS UNIQUEIDENTIFIER)
			AND SQLType = 'General SQL'
			AND Version = '20.4'
		)
BEGIN
	IF (
			SELECT Count(SQLhash)
			FROM (
				SELECT SQLhash
				FROM tbgSQLcommands WITH (NOLOCK)
				WHERE SQLGUID = CAST(@CurrentSQLGuid7 AS UNIQUEIDENTIFIER)
					AND Version = '20.4'
					AND SQLType = 'General SQL'
				
				UNION
				
				SELECT HASHBYTES('MD5', LEFT(@CurrentSQLScript7, 4000)) AS SQLhash
				) tmp
			) <> 1
	BEGIN
		INSERT INTO tbgSQLcommandsHist
		SELECT [PartnerID]
			,[EffDate]
			,[SQLGUID]
			,[SQLCommand]
			,[Description]
			,[LongDescription]
			,[CreatedDate]
			,[CreatedBy]
			,[ApprovedBy]
			,[SQLHash]
			,[SQLType]
			,[Version]
			,[DeletedFlag]
			,[KeepDuringRollback]
		FROM tbgSQLcommands WITH (NOLOCK)
		WHERE SQLGUID = CAST(@CurrentSQLGuid7 AS UNIQUEIDENTIFIER)
			AND Version = '20.4'
			AND SQLType = 'General SQL';

		DELETE
		FROM tbgSQLCommands
		WHERE SQLGUID = CAST(@CurrentSQLGuid7 AS UNIQUEIDENTIFIER)
			AND Version = '20.4'
			AND SQLType = 'General SQL';

		INSERT [dbo].[tbgSQLCommands] (
			[PartnerID]
			,[EffDate]
			,[SQLGUID]
			,[SQLCommand]
			,[Description]
			,[LongDescription]
			,[CreatedDate]
			,[CreatedBy]
			,[ApprovedBy]
			,[SQLHash]
			,[SQLType]
			,[Version]
			,[DeletedFlag]
			,[KeepDuringRollback]
			)
		VALUES (
			4000
			,GETDATE()
			,@CurrentSQLGuid7
			,@CurrentSQLScript7
			,@CurrentSQLDescription7
			,@CurrentSQLLongDescription7
			,GETDATE()
			,'rsheth'
			,'rsheth'
			,HASHBYTES('MD5', LEFT(@CurrentSQLScript7, 4000))
			,'General SQL'
			,'20.4'
			,'N'
			,'N'
			);
	END
END
ELSE
BEGIN
	INSERT [dbo].[tbgSQLCommands] (
		[PartnerID]
		,[EffDate]
		,[SQLGUID]
		,[SQLCommand]
		,[Description]
		,[LongDescription]
		,[CreatedDate]
		,[CreatedBy]
		,[ApprovedBy]
		,[SQLHash]
		,[SQLType]
		,[Version]
		,[DeletedFlag]
		,[KeepDuringRollback]
		)
	VALUES (
		4000
		,GETDATE()
		,@CurrentSQLGuid7
		,@CurrentSQLScript7
		,@CurrentSQLDescription7
		,@CurrentSQLLongDescription7
		,GETDATE()
		,'rsheth'
		,'rsheth'
		,HASHBYTES('MD5', LEFT(@CurrentSQLScript7, 4000))
		,'General SQL'
		,'20.4'
		,'N'
		,'N'
		);
END

DECLARE @CurrentSQLGuid8 AS VARCHAR(36) = '2e970280-bba4-49ee-bf5d-539c1b043a52';
DECLARE @CurrentSQLDescription8 AS NVARCHAR(500) = 'Export Lookup: Shipments Missing Compliance Data';
DECLARE @CurrentSQLLongDescription8 AS NVARCHAR(MAX) = 'Displays the shipments that contain product that are missing an ECN,  Export Tariff Number, or Country of Origin.';
DECLARE @CurrentSQLScript8 AS NVARCHAR(MAX) = 
	'SELECT * ,  ROW_NUMBER() OVER ( ORDER BY @orderby@) AS [RowNum]  FROM       (    SELECT DISTINCT    ''[''+ ''Edit'' + '']'' + ''(/Export/fidExportCISLI.aspx?TYPE='' + eh.RecordType + ''&ExportGuid=''+ cast (eh.ExportGuid AS varchar(50)) + '')'' AS Edit,    eh.OrderNum,     ISNULL(g.Decode, eh.Status) as Status,    ed.ProductNum,    ed.ProductDesc,        ed.ECNNum,          ed.ExportTariffNum,          ed.CountryOfOrigin,    xxpc.ProductTypeCode,    1 AS NoOrder      FROM txdExportHeader eh (NOLOCK)    JOIN txdExportDetail ed (NOLOCK)    ON eh.ExportGUID = ed.ExportGUID    AND eh.PartnerID = ed.PartnerID   JOIN txdExportParties ep (NOLOCK)     ON eh.ExportGUID = ep.ExportGUID    AND eh.PartnerID = ep.PartnerID   JOIN tmdUSProductClassification xxpc     ON ed.ProductGUID = CAST(xxpc.ProductGuid AS VARCHAR(50))         AND ed.PartnerID = xxpc.PartnerID         LEFT JOIN tmgGlobalCodes g (NOLOCK)    ON g.PartnerID = eh.PartnerID    AND g.Code = eh.Status    AND g.FieldName = ''EXPORTSTATUS''   WHERE eh.RecordType = ''E''    AND eh.PartnerID = @PartnerID    AND eh.Status NOT IN (''F'', ''V'')     AND ed.ECNNum = ''''          OR ed.ExportTariffNum = ''''           OR ed.CountryOfOrigin = ''''  ) AS LookupViewInner  WHERE                                  @whereclause@'
	;

IF EXISTS (
		SELECT TOP 1 1
		FROM tbgSQLCommands WITH (NOLOCK)
		WHERE SQLGUID = CAST(@CurrentSQLGuid8 AS UNIQUEIDENTIFIER)
			AND SQLType = 'General SQL'
			AND Version = '20.4'
		)
BEGIN
	IF (
			SELECT Count(LongDescription)
			FROM (
				SELECT LongDescription
				FROM tbgSQLcommands WITH (NOLOCK)
				WHERE SQLGUID = CAST(@CurrentSQLGuid8 AS UNIQUEIDENTIFIER)
					AND Version = '20.4'
					AND SQLType = 'General SQL'
				
				UNION
				
				SELECT @CurrentSQLLongDescription8 AS LongDescription
				) tmp
			) <> 1
	BEGIN
		INSERT INTO tbgSQLcommandsHist
		SELECT [PartnerID]
			,[EffDate]
			,[SQLGUID]
			,[SQLCommand]
			,[Description]
			,[LongDescription]
			,[CreatedDate]
			,[CreatedBy]
			,[ApprovedBy]
			,[SQLHash]
			,[SQLType]
			,[Version]
			,[DeletedFlag]
			,[KeepDuringRollback]
		FROM tbgSQLcommands WITH (NOLOCK)
		WHERE SQLGUID = CAST(@CurrentSQLGuid8 AS UNIQUEIDENTIFIER)
			AND Version = '20.4'
			AND SQLType = 'General SQL';

		DELETE
		FROM tbgSQLCommands
		WHERE SQLGUID = CAST(@CurrentSQLGuid8 AS UNIQUEIDENTIFIER)
			AND Version = '20.4'
			AND SQLType = 'General SQL';

		INSERT [dbo].[tbgSQLCommands] (
			[PartnerID]
			,[EffDate]
			,[SQLGUID]
			,[SQLCommand]
			,[Description]
			,[LongDescription]
			,[CreatedDate]
			,[CreatedBy]
			,[ApprovedBy]
			,[SQLHash]
			,[SQLType]
			,[Version]
			,[DeletedFlag]
			,[KeepDuringRollback]
			)
		VALUES (
			4000
			,GETDATE()
			,@CurrentSQLGuid8
			,@CurrentSQLScript8
			,@CurrentSQLDescription8
			,@CurrentSQLLongDescription8
			,GETDATE()
			,'rsheth'
			,'rsheth'
			,HASHBYTES('MD5', LEFT(@CurrentSQLScript8, 4000))
			,'General SQL'
			,'20.4'
			,'N'
			,'N'
			);
	END
END
ELSE
BEGIN
	INSERT [dbo].[tbgSQLCommands] (
		[PartnerID]
		,[EffDate]
		,[SQLGUID]
		,[SQLCommand]
		,[Description]
		,[LongDescription]
		,[CreatedDate]
		,[CreatedBy]
		,[ApprovedBy]
		,[SQLHash]
		,[SQLType]
		,[Version]
		,[DeletedFlag]
		,[KeepDuringRollback]
		)
	VALUES (
		4000
		,GETDATE()
		,@CurrentSQLGuid8
		,@CurrentSQLScript8
		,@CurrentSQLDescription8
		,@CurrentSQLLongDescription8
		,GETDATE()
		,'rsheth'
		,'rsheth'
		,HASHBYTES('MD5', LEFT(@CurrentSQLScript8, 4000))
		,'General SQL'
		,'20.4'
		,'N'
		,'N'
		);
END

DECLARE @CurrentSQLGuid9 AS VARCHAR(36) = '00f53a58-e099-46a4-8e8b-bdbd1eee946c';
DECLARE @CurrentSQLDescription9 AS NVARCHAR(500) = 'Export Lookup: Exports Within 5 Days of the Export Date and on hold';
DECLARE @CurrentSQLLongDescription9 AS NVARCHAR(MAX) = 'Displays the shipments which are within 5 days of their scheduled export date, but are on hold.  ';
DECLARE @CurrentSQLScript9 AS NVARCHAR(MAX) = 'SELECT * ,  ROW_NUMBER() OVER ( ORDER BY @orderby@) AS [RowNum]  FROM       (    SELECT DISTINCT    ''[''+ ''Edit'' + '']'' + ''(/Export/fidExportCISLI.aspx?TYPE='' + eh.RecordType + ''&ExportGuid=''+ CAST(eh.ExportGuid AS VARCHAR(50)) + '')'' AS Edit,    eh.OrderNumShip,     ISNULL(g.Decode, eh.Status) AS Status,    eh.ShipmentRefNum,     eh.ShipDate,    eh.ExportDate,    eh.ExportCountry,    eh.ImportCountry,    1 AS NoOrder   FROM txdExportHeader eh (NOLOCK)    JOIN txdExportParties ep (NOLOCK)     ON eh.ExportGUID = ep.ExportGUID    AND eh.PartnerID = ep.PartnerID   LEFT JOIN tmgGlobalCodes g (NOLOCK)    ON g.PartnerID = eh.PartnerID    AND g.Code = eh.Status    AND g.FieldName = ''EXPORTSTATUS''   WHERE eh.Status = ''H''    AND eh.RecordType = ''E''    AND eh.PartnerID = @PartnerID    AND DATEDIFF(Day, GETDATE(),eh.ExportDate) <= 5  ) AS LookupViewInner  WHERE                                  @whereclause@';

IF EXISTS (
		SELECT TOP 1 1
		FROM tbgSQLCommands WITH (NOLOCK)
		WHERE SQLGUID = CAST(@CurrentSQLGuid9 AS UNIQUEIDENTIFIER)
			AND SQLType = 'General SQL'
			AND Version = '20.4'
		)
BEGIN
	IF (
			SELECT Count(SQLhash)
			FROM (
				SELECT SQLhash
				FROM tbgSQLcommands WITH (NOLOCK)
				WHERE SQLGUID = CAST(@CurrentSQLGuid9 AS UNIQUEIDENTIFIER)
					AND Version = '20.4'
					AND SQLType = 'General SQL'
				
				UNION
				
				SELECT HASHBYTES('MD5', LEFT(@CurrentSQLScript9, 4000)) AS SQLhash
				) tmp
			) <> 1
	BEGIN
		INSERT INTO tbgSQLcommandsHist
		SELECT [PartnerID]
			,[EffDate]
			,[SQLGUID]
			,[SQLCommand]
			,[Description]
			,[LongDescription]
			,[CreatedDate]
			,[CreatedBy]
			,[ApprovedBy]
			,[SQLHash]
			,[SQLType]
			,[Version]
			,[DeletedFlag]
			,[KeepDuringRollback]
		FROM tbgSQLcommands WITH (NOLOCK)
		WHERE SQLGUID = CAST(@CurrentSQLGuid9 AS UNIQUEIDENTIFIER)
			AND Version = '20.4'
			AND SQLType = 'General SQL';

		DELETE
		FROM tbgSQLCommands
		WHERE SQLGUID = CAST(@CurrentSQLGuid9 AS UNIQUEIDENTIFIER)
			AND Version = '20.4'
			AND SQLType = 'General SQL';

		INSERT [dbo].[tbgSQLCommands] (
			[PartnerID]
			,[EffDate]
			,[SQLGUID]
			,[SQLCommand]
			,[Description]
			,[LongDescription]
			,[CreatedDate]
			,[CreatedBy]
			,[ApprovedBy]
			,[SQLHash]
			,[SQLType]
			,[Version]
			,[DeletedFlag]
			,[KeepDuringRollback]
			)
		VALUES (
			4000
			,GETDATE()
			,@CurrentSQLGuid9
			,@CurrentSQLScript9
			,@CurrentSQLDescription9
			,@CurrentSQLLongDescription9
			,GETDATE()
			,'rsheth'
			,'rsheth'
			,HASHBYTES('MD5', LEFT(@CurrentSQLScript9, 4000))
			,'General SQL'
			,'20.4'
			,'N'
			,'N'
			);
	END
END
ELSE
BEGIN
	INSERT [dbo].[tbgSQLCommands] (
		[PartnerID]
		,[EffDate]
		,[SQLGUID]
		,[SQLCommand]
		,[Description]
		,[LongDescription]
		,[CreatedDate]
		,[CreatedBy]
		,[ApprovedBy]
		,[SQLHash]
		,[SQLType]
		,[Version]
		,[DeletedFlag]
		,[KeepDuringRollback]
		)
	VALUES (
		4000
		,GETDATE()
		,@CurrentSQLGuid9
		,@CurrentSQLScript9
		,@CurrentSQLDescription9
		,@CurrentSQLLongDescription9
		,GETDATE()
		,'rsheth'
		,'rsheth'
		,HASHBYTES('MD5', LEFT(@CurrentSQLScript9, 4000))
		,'General SQL'
		,'20.4'
		,'N'
		,'N'
		);
END

DECLARE @CurrentSQLGuid10 AS VARCHAR(36) = '00cf4f44-7cf2-4734-89a4-37da34d69a08';
DECLARE @CurrentSQLDescription10 AS NVARCHAR(500) = 'Export Lookup: QP Shipments Without Corresponding Export Shipment';
DECLARE @CurrentSQLLongDescription10 AS NVARCHAR(MAX) = 'Displays the shipments that have been filed as bonded shipments in the QP module, but do not have a corresponding shipment in the Export Management module.   ';
DECLARE @CurrentSQLScript10 AS NVARCHAR(MAX) = 'SELECT * ,  ROW_NUMBER() OVER ( ORDER BY @orderby@) AS [RowNum]  FROM       (    SELECT DISTINCT    qh.InbondDate,    qh.inbondNum,    ISNULL(eh.ShipmentRefNum,'''') AS ShipmentRefNum,    ISNULL(eh.OrderNumShip,'''') AS OrderNumShip,     ISNULL(g.Decode, eh.Status) AS Status,    QPO1,    EntryNum,    1 AS NoOrder   FROM txdQPHeader qh (NOLOCK)   LEFT JOIN txdExportHeader eh (NOLOCK)     ON qh.PartnerId = eh.PartnerID     AND (qh.QPO1 = eh.OrderNumShip or qh.InbondNum = eh.EntryNum)    AND eh.RecordType = ''E''   LEFT JOIN tmgGlobalCodes g (NOLOCK)    ON g.PartnerID = eh.partnerid    AND g.Code = eh.Status    AND g.FieldName = ''EXPORTSTATUS''   WHERE qh.PartnerID = @PartnerID    AND eh.PartnerID IS NULL  ) AS LookupViewInner  WHERE                                  @whereclause@';

IF EXISTS (
		SELECT TOP 1 1
		FROM tbgSQLCommands WITH (NOLOCK)
		WHERE SQLGUID = CAST(@CurrentSQLGuid10 AS UNIQUEIDENTIFIER)
			AND SQLType = 'General SQL'
			AND Version = '20.4'
		)
BEGIN
	IF (
			SELECT Count(SQLhash)
			FROM (
				SELECT SQLhash
				FROM tbgSQLcommands WITH (NOLOCK)
				WHERE SQLGUID = CAST(@CurrentSQLGuid10 AS UNIQUEIDENTIFIER)
					AND Version = '20.4'
					AND SQLType = 'General SQL'
				
				UNION
				
				SELECT HASHBYTES('MD5', LEFT(@CurrentSQLScript10, 4000)) AS SQLhash
				) tmp
			) <> 1
	BEGIN
		INSERT INTO tbgSQLcommandsHist
		SELECT [PartnerID]
			,[EffDate]
			,[SQLGUID]
			,[SQLCommand]
			,[Description]
			,[LongDescription]
			,[CreatedDate]
			,[CreatedBy]
			,[ApprovedBy]
			,[SQLHash]
			,[SQLType]
			,[Version]
			,[DeletedFlag]
			,[KeepDuringRollback]
		FROM tbgSQLcommands WITH (NOLOCK)
		WHERE SQLGUID = CAST(@CurrentSQLGuid10 AS UNIQUEIDENTIFIER)
			AND Version = '20.4'
			AND SQLType = 'General SQL';

		DELETE
		FROM tbgSQLCommands
		WHERE SQLGUID = CAST(@CurrentSQLGuid10 AS UNIQUEIDENTIFIER)
			AND Version = '20.4'
			AND SQLType = 'General SQL';

		INSERT [dbo].[tbgSQLCommands] (
			[PartnerID]
			,[EffDate]
			,[SQLGUID]
			,[SQLCommand]
			,[Description]
			,[LongDescription]
			,[CreatedDate]
			,[CreatedBy]
			,[ApprovedBy]
			,[SQLHash]
			,[SQLType]
			,[Version]
			,[DeletedFlag]
			,[KeepDuringRollback]
			)
		VALUES (
			4000
			,GETDATE()
			,@CurrentSQLGuid10
			,@CurrentSQLScript10
			,@CurrentSQLDescription10
			,@CurrentSQLLongDescription10
			,GETDATE()
			,'rsheth'
			,'rsheth'
			,HASHBYTES('MD5', LEFT(@CurrentSQLScript10, 4000))
			,'General SQL'
			,'20.4'
			,'N'
			,'N'
			);
	END
END
ELSE
BEGIN
	INSERT [dbo].[tbgSQLCommands] (
		[PartnerID]
		,[EffDate]
		,[SQLGUID]
		,[SQLCommand]
		,[Description]
		,[LongDescription]
		,[CreatedDate]
		,[CreatedBy]
		,[ApprovedBy]
		,[SQLHash]
		,[SQLType]
		,[Version]
		,[DeletedFlag]
		,[KeepDuringRollback]
		)
	VALUES (
		4000
		,GETDATE()
		,@CurrentSQLGuid10
		,@CurrentSQLScript10
		,@CurrentSQLDescription10
		,@CurrentSQLLongDescription10
		,GETDATE()
		,'rsheth'
		,'rsheth'
		,HASHBYTES('MD5', LEFT(@CurrentSQLScript10, 4000))
		,'General SQL'
		,'20.4'
		,'N'
		,'N'
		);
END

DECLARE @CurrentSQLGuid11 AS VARCHAR(36) = '85cef7be-2ed9-4a12-a52b-3fc6f17ed87f';
DECLARE @CurrentSQLDescription11 AS NVARCHAR(500) = 'Export Lookup: Export Shipments Without Correcsponding QP';
DECLARE @CurrentSQLLongDescription11 AS NVARCHAR(MAX) = 'Displays the shipments that have been filed as bonded shipments in the Export Management module, but do not have a corresponding shipment in the QP module.   ';
DECLARE @CurrentSQLScript11 AS NVARCHAR(MAX) = 'SELECT * ,  ROW_NUMBER() OVER ( ORDER BY @orderby@) AS [RowNum]  FROM       (    SELECT DISTINCT    eh.ExportDate,    eh.OrderNumShip,    eh.ShipmentRefNum,    ISNULL(qh.InbondNum,'''') AS InbondNum,     ISNULL(g.Decode, eh.Status) AS Status,    ISNULL(QPO1,'''') as QPO1,    eh.EntryNum,    1 AS NoOrder   FROM txdExportHeader eh (NOLOCK)    LEFT JOIN txdQPHeader qh(NOLOCK)    ON qh.PartnerId = eh.PartnerID     AND (qh.QPO1 = eh.OrderNumShip OR qh.InbondNum = eh.EntryNum)   LEFT JOIN tmgGlobalCodes g (NOLOCK)    ON g.PartnerID = eh.PartnerID    AND g.Code = eh.Status    AND g.FieldName = ''EXPORTSTATUS''   WHERE eh.Status IN (''H'',''U'',''P'')    AND eh.recordtype = ''E''    AND eh.partnerid = @PartnerID    AND qh.PartnerID IS NULL  ) AS LookupViewInner  WHERE                                  @whereclause@';

IF EXISTS (
		SELECT TOP 1 1
		FROM tbgSQLCommands WITH (NOLOCK)
		WHERE SQLGUID = CAST(@CurrentSQLGuid11 AS UNIQUEIDENTIFIER)
			AND SQLType = 'General SQL'
			AND Version = '20.4'
		)
BEGIN
	IF (
			SELECT Count(SQLhash)
			FROM (
				SELECT SQLhash
				FROM tbgSQLcommands WITH (NOLOCK)
				WHERE SQLGUID = CAST(@CurrentSQLGuid11 AS UNIQUEIDENTIFIER)
					AND Version = '20.4'
					AND SQLType = 'General SQL'
				
				UNION
				
				SELECT HASHBYTES('MD5', LEFT(@CurrentSQLScript11, 4000)) AS SQLhash
				) tmp
			) <> 1
	BEGIN
		INSERT INTO tbgSQLcommandsHist
		SELECT [PartnerID]
			,[EffDate]
			,[SQLGUID]
			,[SQLCommand]
			,[Description]
			,[LongDescription]
			,[CreatedDate]
			,[CreatedBy]
			,[ApprovedBy]
			,[SQLHash]
			,[SQLType]
			,[Version]
			,[DeletedFlag]
			,[KeepDuringRollback]
		FROM tbgSQLcommands WITH (NOLOCK)
		WHERE SQLGUID = CAST(@CurrentSQLGuid11 AS UNIQUEIDENTIFIER)
			AND Version = '20.4'
			AND SQLType = 'General SQL';

		DELETE
		FROM tbgSQLCommands
		WHERE SQLGUID = CAST(@CurrentSQLGuid11 AS UNIQUEIDENTIFIER)
			AND Version = '20.4'
			AND SQLType = 'General SQL';

		INSERT [dbo].[tbgSQLCommands] (
			[PartnerID]
			,[EffDate]
			,[SQLGUID]
			,[SQLCommand]
			,[Description]
			,[LongDescription]
			,[CreatedDate]
			,[CreatedBy]
			,[ApprovedBy]
			,[SQLHash]
			,[SQLType]
			,[Version]
			,[DeletedFlag]
			,[KeepDuringRollback]
			)
		VALUES (
			4000
			,GETDATE()
			,@CurrentSQLGuid11
			,@CurrentSQLScript11
			,@CurrentSQLDescription11
			,@CurrentSQLLongDescription11
			,GETDATE()
			,'rsheth'
			,'rsheth'
			,HASHBYTES('MD5', LEFT(@CurrentSQLScript11, 4000))
			,'General SQL'
			,'20.4'
			,'N'
			,'N'
			);
	END
END
ELSE
BEGIN
	INSERT [dbo].[tbgSQLCommands] (
		[PartnerID]
		,[EffDate]
		,[SQLGUID]
		,[SQLCommand]
		,[Description]
		,[LongDescription]
		,[CreatedDate]
		,[CreatedBy]
		,[ApprovedBy]
		,[SQLHash]
		,[SQLType]
		,[Version]
		,[DeletedFlag]
		,[KeepDuringRollback]
		)
	VALUES (
		4000
		,GETDATE()
		,@CurrentSQLGuid11
		,@CurrentSQLScript11
		,@CurrentSQLDescription11
		,@CurrentSQLLongDescription11
		,GETDATE()
		,'rsheth'
		,'rsheth'
		,HASHBYTES('MD5', LEFT(@CurrentSQLScript11, 4000))
		,'General SQL'
		,'20.4'
		,'N'
		,'N'
		);
END
