DECLARE @CurrentSQLGuid1 AS VARCHAR(36) = '6754f933-0d24-4c59-90e2-535bd72db918';
DECLARE @CurrentSQLDescription1 AS NVARCHAR(500) = 'Export Lookup: Exports With License Required';
DECLARE @CurrentSQLLongDescription1 AS NVARCHAR(MAX) = 'Displays all of the shipments which require licensing.';
DECLARE @CurrentSQLScript1 AS NVARCHAR(MAX) = 'SELECT * , ROW_NUMBER() OVER ( ORDER BY @orderby@ ) AS [RowNum] FROM      (   SELECT    ''[''+ ''Edit'' + '']'' + ''(/Export/fidExportCISLI.aspx?TYPE='' + eh.RecordType + ''&ExportGuid=''+ CAST(eh.ExportGuid AS VARCHAR(50)) + '')'' AS Edit,   eh.OrderNumShip,    eh.Status,    ed.ProductNum,    ed.Productdesc,    ed.ECNNum,    ed.DDTCUSMLCategory,    ed.LicenseRequired,    ed.LicenseNum,   1 AS NoOrder  FROM txdExportHeader eh with (nolock)  JOIN txdExportDetail ed with (nolock)   ON eh.ExportGuid = ed.ExportGuid   AND eh.PartnerID = ed.PartnerID  WHERE ed.LicenseRequired = ''Y''   AND eh.recordtype = ''E''   AND eh.partnerid = @PartnerID  ) AS LookupViewInner WHERE                                 @whereclause@';

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

DECLARE @CurrentSQLGuid2 AS VARCHAR(36) = 'c43387f4-cb76-45cc-a84a-040ca5197e32';
DECLARE @CurrentSQLDescription2 AS NVARCHAR(500) = 'Export Lookup: License maybe required';
DECLARE @CurrentSQLLongDescription2 AS NVARCHAR(MAX) = 'Displays the shipments that may require licensing.';
DECLARE @CurrentSQLScript2 AS NVARCHAR(MAX) = 'SELECT * , ROW_NUMBER() OVER ( ORDER BY @orderby@) AS [RowNum] FROM      (   SELECT DISTINCT   ''[''+ ''Edit'' + '']'' + ''(/Export/fidExportCISLI.aspx?TYPE='' + eh.RecordType + ''&ExportGuid=''+ CAST(eh.ExportGuid AS VARCHAR(50)) + '')'' AS Edit,   eh.OrderNumShip,    eh.OrderNum,   ISNULL(g.Decode, eh.Status) AS Status,   1 AS NoOrder  FROM txdExportHeader eh (NOLOCK)   LEFT JOIN tmgGlobalCodes g (NOLOCK)   ON g.PartnerID = eh.PartnerID   AND g.Code = eh.Status   AND g.FieldName = ''EXPORTSTATUS''  where eh.RecordType = ''E''   AND eh.partnerid = @PartnerID   AND eh.ProcessedFlag = ''Y''   AND EXISTS(SELECT 1 FROM txdExportDetail ED with (nolock) WHERE ED.ExportGUID = eh.ExportGUID AND ed.PartnerID = eh.PartnerID AND ED.LicenseRequired  = ''Y'') ) AS LookupViewInner WHERE                                 @whereclause@';

IF EXISTS (
		SELECT TOP 1 1
		FROM tbgSQLCommands WITH (NOLOCK)
		WHERE SQLGUID = CAST(@CurrentSQLGuid2 AS UNIQUEIDENTIFIER)
			AND SQLType = 'General SQL'
			AND Version = '20.4'
		)
BEGIN
	IF (
			SELECT Count(SQLhash)
			FROM (
				SELECT SQLhash
				FROM tbgSQLcommands WITH (NOLOCK)
				WHERE SQLGUID = CAST(@CurrentSQLGuid2 AS UNIQUEIDENTIFIER)
					AND Version = '20.4'
					AND SQLType = 'General SQL'
				
				UNION
				
				SELECT HASHBYTES('MD5', LEFT(@CurrentSQLScript2, 4000)) AS SQLhash
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

DECLARE @CurrentSQLGuid3 AS VARCHAR(36) = '333b819d-fbba-40a5-ac43-39027a5b5cc2';
DECLARE @CurrentSQLDescription3 AS NVARCHAR(500) = 'Export Lookup: Licenseable Shipments';
DECLARE @CurrentSQLLongDescription3 AS NVARCHAR(MAX) = 'Displays all of the shipments that have been processed and require licensing.    ';
DECLARE @CurrentSQLScript3 AS NVARCHAR(MAX) = 'SELECT * ,  ROW_NUMBER() OVER ( ORDER BY @orderby@) AS [RowNum]  FROM       (    SELECT DISTINCT    ''[''+ ''Edit'' + '']'' + ''(/Export/fidExportCISLI.aspx?TYPE='' + eh.RecordType + ''&ExportGuid=''+ CAST(eh.ExportGuid AS VARCHAR(50)) + '')'' AS Edit,    eh.OrderNumShip,     ISNULL(g.Decode, eh.Status) AS Status,    ed.LicenseRequired,    ed.LicenseNum,    ed.ECNNum,    eh.ExportCountry,    eh.ImportCountry,    ed.ExportTariffNum,    1 AS NoOrder   FROM txdExportHeader eh (NOLOCK)    JOIN txdExportDetail ed (NOLOCK)     ON eh.ExportGUID = ed.ExportGUID    AND eh.PartnerID = ed.PartnerID   LEFT JOIN tmgGlobalCodes g (NOLOCK)    ON g.PartnerID = eh.PartnerID    AND g.Code = eh.Status    AND g.FieldName = ''EXPORTSTATUS''   WHERE eh.ProcessedFlag <> ''Y''    AND eh.recordtype = ''E''    AND eh.partnerid = @PartnerID    AND ed.LicenseRequired = ''Y''  ) AS LookupViewInner  WHERE                                  @whereclause@';

IF EXISTS (
		SELECT TOP 1 1
		FROM tbgSQLCommands WITH (NOLOCK)
		WHERE SQLGUID = CAST(@CurrentSQLGuid3 AS UNIQUEIDENTIFIER)
			AND SQLType = 'General SQL'
			AND Version = '20.4'
		)
BEGIN
	IF (
			SELECT Count(SQLhash)
			FROM (
				SELECT SQLhash
				FROM tbgSQLcommands WITH (NOLOCK)
				WHERE SQLGUID = CAST(@CurrentSQLGuid3 AS UNIQUEIDENTIFIER)
					AND Version = '20.4'
					AND SQLType = 'General SQL'
				
				UNION
				
				SELECT HASHBYTES('MD5', LEFT(@CurrentSQLScript3, 4000)) AS SQLhash
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
