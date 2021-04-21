DECLARE @CurrentSQLGuid1 AS VARCHAR(36) = '704a868c-d986-4d6e-890a-87423deebb5a';
DECLARE @CurrentSQLDescription1 AS NVARCHAR(500) = 'Export Lookup: Finalized Shipments';
DECLARE @CurrentSQLLongDescription1 AS NVARCHAR(MAX) = 'Displays the shipments that have been finalized.  ';
DECLARE @CurrentSQLScript1 AS NVARCHAR(MAX) = 'SELECT * ,  ROW_NUMBER() OVER ( ORDER BY @orderby@) AS [RowNum]  FROM       (    SELECT    ''[''+ ''Edit'' + '']'' + ''(/Export/fidExportCISLI.aspx?TYPE='' + eh.RecordType + ''&ExportGuid=''+ CAST(eh.ExportGuid AS VARCHAR(50)) + '')'' AS Edit,    eh.OrderNumShip,    eh.ShipDate,    eh.LastProcessedDate,    eh.ImportCountry,    ep.UltimateConsigneeCompanyName,    1 AS NoOrder   FROM txdExportHeader eh (NOLOCK)   JOIN txdExportParties ep (NOLOCK)    ON eh.ExportGUID = ep.ExportGUID    AND eh.PartnerID = ep.PartnerID   WHERE eh.FinalizedFlag = ''Y''    AND eh.PartnerID = @PartnerID  ) AS LookupViewInner  WHERE                                  @whereclause@';

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

DECLARE @CurrentSQLGuid2 AS VARCHAR(36) = 'c14dd075-8951-4bd9-b98c-bfefff83f426';
DECLARE @CurrentSQLDescription2 AS NVARCHAR(500) = 'Export Lookup: Exports With Denied Parties';
DECLARE @CurrentSQLLongDescription2 AS NVARCHAR(MAX) = 'Displays shipments that historically received a DPS hit against one or more party.';
DECLARE @CurrentSQLScript2 AS NVARCHAR(MAX) = 'SELECT * ,    ROW_NUMBER() OVER (ORDER BY @orderby@, OrderNumShip) AS [RowNum]             FROM   (   SELECT   ''[''+ ''Edit'' + '']'' + ''(/Export/fidExportCISLI.aspx?TYPE=E&ExportGuid=''+ CAST(eh.ExportGuid AS VARCHAR(50)) + '')'' AS Edit,  eh.OrderNumShip,   em.Message AS HoldReason,  1 as NoOrder  FROM txdExportHeader eh with (nolock)  JOIN txdExportSystemMessages em with (nolock)   ON eh.ExportGuid = em.ExportGuid   AND eh.PartnerID = em.PartnerID  where em.MessageType = ''DPS''   AND eh.recordtype = ''E''   AND eh.partnerid = @PartnerID ) AS LookupViewInner WHERE                                 @whereclause@';

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

DECLARE @CurrentSQLGuid3 AS VARCHAR(36) = '2b07e450-c321-4a80-82b9-712defa584a5';
DECLARE @CurrentSQLDescription3 AS NVARCHAR(500) = 'Export Lookup: All Hold Messages';
DECLARE @CurrentSQLLongDescription3 AS NVARCHAR(MAX) = 'Displays all of the shipments which have had hold messages assigned to them.';
DECLARE @CurrentSQLScript3 AS NVARCHAR(MAX) = 'SELECT * , ROW_NUMBER() OVER ( ORDER BY @orderby@, ordernumship desc ) AS [RowNum] FROM      (   SELECT DISTINCT  ''[''+ ''Edit'' + '']'' + ''(/Export/fidExportCISLI.aspx?TYPE='' + eh.RecordType + ''&ExportGuid=''+ CAST(eh.ExportGuid AS VARCHAR(50)) + '')'' AS Edit,  eh.OrderNumShip,   em.Message AS HoldReason,  1 AS NoOrder  FROM txdExportHeader eh with (nolock)  JOIN txdExportSystemMessages em with (nolock)   ON eh.ExportGuid = em.ExportGuid   AND eh.PartnerID = em.PartnerID  WHERE em.HoldFlag = ''Y''   AND eh.recordtype = ''E''   AND eh.partnerid = @PartnerID ) AS LookupViewInner WHERE                                 @whereclause@';

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

DECLARE @CurrentSQLGuid4 AS VARCHAR(36) = '96766873-6ac1-4dd4-87d2-1ebdc5b59036';
DECLARE @CurrentSQLDescription4 AS NVARCHAR(500) = 'Export Lookup: Shipments With non-EAR99 Products';
DECLARE @CurrentSQLLongDescription4 AS NVARCHAR(MAX) = 'Displays all of the shipments which do not contain any items classified with a ECN Number of EAR99.';
DECLARE @CurrentSQLScript4 AS NVARCHAR(MAX) = 'SELECT * ,  ROW_NUMBER() OVER ( ORDER BY @orderby@) AS [RowNum]  FROM       (    SELECT     ''[''+ ''Edit'' + '']'' + ''(/Export/fidExportCISLI.aspx?TYPE='' + eh.RecordType + ''&ExportGuid=''+ CAST(eh.ExportGuid AS VARCHAR(50)) + '')'' AS Edit,    eh.OrderNumShip,     eh.Status,     ed.ProductNum,     ed.Productdesc,     ed.ECNNum,     ed.DDTCUSMLCategory,     ed.LicenseRequired,     ed.LicenseNum,    1 AS NoOrder   FROM txdExportHeader eh (NOLOCK)    JOIN txdExportDetail ed (NOLOCK)     ON eh.ExportGuid = ed.ExportGuid    AND eh.PartnerID = ed.PartnerID   WHERE ed.ECNNum NOT IN ('''', ''EAR99'')    AND eh.recordtype = ''E''    AND eh.partnerid = @PartnerID  ) AS LookupViewInner  WHERE                                  @whereclause@';

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

DECLARE @CurrentSQLGuid5 AS VARCHAR(36) = 'd4edbafe-6d89-4268-b764-94b14ec1e7a3';
DECLARE @CurrentSQLDescription5 AS NVARCHAR(500) = 'Export Lookup: Hold Message Counts';
DECLARE @CurrentSQLLongDescription5 AS NVARCHAR(MAX) = 'Displays the number of times that a hold has been issued and the reason why it was issued.';
DECLARE @CurrentSQLScript5 AS NVARCHAR(MAX) = 'SELECT * , ROW_NUMBER() OVER ( ORDER BY @orderby@, Count DESC ) AS [RowNum] FROM      (   SELECT   em.Message AS HoldReason,    COUNT(em.Message) AS Count,   1 as NoOrder  FROM txdExportHeader eh with (nolock)  JOIN txdExportSystemMessages em with (nolock)   ON eh.ExportGuid = em.ExportGuid   AND eh.PartnerID = em.PartnerID  WHERE em.HoldFlag = ''Y''   AND eh.recordtype = ''E''   AND eh.partnerid = @PartnerID  GROUP BY em.Message ) AS LookupViewInner WHERE                                 @whereclause@';

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

DECLARE @CurrentSQLGuid6 AS VARCHAR(36) = 'ff1c36ee-fa59-4879-be7e-dadf09f247e8';
DECLARE @CurrentSQLDescription6 AS NVARCHAR(500) = 'Export Lookup: Shipments With Related Ultimate Consignee';
DECLARE @CurrentSQLLongDescription6 AS NVARCHAR(MAX) = 'Displays the shipments with an ultimate consignee who has an indicated relationship to the client.';
DECLARE @CurrentSQLScript6 AS NVARCHAR(MAX) = 
	'SELECT * ,  ROW_NUMBER() OVER ( ORDER BY @orderby@) AS [RowNum]  FROM       (    SELECT DISTINCT    ''[''+ ''Edit'' + '']'' + ''(/Export/fidExportCISLI.aspx?TYPE='' + eh.RecordType + ''&ExportGuid=''+ CAST(eh.ExportGuid AS VARCHAR(50)) + '')'' AS Edit,    eh.OrderNumShip,     ISNULL(g.Decode, eh.Status) as Status,    ep.UltimateConsigneeID,    ep.UltimateConsigneeCompanyName,    ep.UltimateConsigneeCity,    ep.UltimateConsigneeState,    comp.RelationshipDetail,    1 AS NoOrder   FROM txdExportHeader eh (NOLOCK)    JOIN txdExportParties ep (NOLOCK)     ON eh.ExportGUID = ep.ExportGUID    AND eh.PartnerID = ep.PartnerID   JOIN tmgCompany comp (NOLOCK)     ON ep.UltimateConsigneeID = comp.CompanyID    AND ep.PartnerID = comp.PartnerID   LEFT JOIN tmgGlobalCodes g (NOLOCK)    ON g.partnerid = eh.partnerid    AND g.code = eh.status    AND g.fieldname = ''EXPORTSTATUS''   WHERE comp.RelationshipDetail <> ''''    AND eh.recordtype = ''E''    AND eh.partnerid = @PartnerID  ) AS LookupViewInner  WHERE                                  @whereclause@'
	;

IF EXISTS (
		SELECT TOP 1 1
		FROM tbgSQLCommands WITH (NOLOCK)
		WHERE SQLGUID = CAST(@CurrentSQLGuid6 AS UNIQUEIDENTIFIER)
			AND SQLType = 'General SQL'
			AND Version = '20.4'
		)
BEGIN
	IF (
			SELECT Count(SQLhash)
			FROM (
				SELECT SQLhash
				FROM tbgSQLcommands WITH (NOLOCK)
				WHERE SQLGUID = CAST(@CurrentSQLGuid6 AS UNIQUEIDENTIFIER)
					AND Version = '20.4'
					AND SQLType = 'General SQL'
				
				UNION
				
				SELECT HASHBYTES('MD5', LEFT(@CurrentSQLScript6, 4000)) AS SQLhash
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
		WHERE SQLGUID = CAST(@CurrentSQLGuid6 AS UNIQUEIDENTIFIER)
			AND Version = '20.4'
			AND SQLType = 'General SQL';

		DELETE
		FROM tbgSQLCommands
		WHERE SQLGUID = CAST(@CurrentSQLGuid6 AS UNIQUEIDENTIFIER)
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
			,@CurrentSQLGuid6
			,@CurrentSQLScript6
			,@CurrentSQLDescription6
			,@CurrentSQLLongDescription6
			,GETDATE()
			,'rsheth'
			,'rsheth'
			,HASHBYTES('MD5', LEFT(@CurrentSQLScript6, 4000))
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
		,@CurrentSQLGuid6
		,@CurrentSQLScript6
		,@CurrentSQLDescription6
		,@CurrentSQLLongDescription6
		,GETDATE()
		,'rsheth'
		,'rsheth'
		,HASHBYTES('MD5', LEFT(@CurrentSQLScript6, 4000))
		,'General SQL'
		,'20.4'
		,'N'
		,'N'
		);
END

DECLARE @CurrentSQLGuid7 AS VARCHAR(36) = '3b5f7a82-97c6-42cb-af83-90ae77dad245';
DECLARE @CurrentSQLDescription7 AS NVARCHAR(500) = 'Export Lookup: Request to Ship Date KPI';
DECLARE @CurrentSQLLongDescription7 AS NVARCHAR(MAX) = 'Displays all shipments along with differences between the requested date and the ship date.';
DECLARE @CurrentSQLScript7 AS NVARCHAR(MAX) = 'SELECT * ,  ROW_NUMBER() OVER ( ORDER BY @orderby@) AS [RowNum]  FROM       (    SELECT DISTINCT    ''[''+ ''Edit'' + '']'' + ''(/Export/fidExportCISLI.aspx?TYPE='' + eh.RecordType + ''&ExportGuid=''+ CAST(eh.ExportGuid AS VARCHAR(50)) + '')'' AS Edit,    eh.OrderNumShip,     ISNULL(g.Decode, eh.Status) AS Status,    eh.RequestedDate,    eh.ShipDate,    DATEDIFF(DAY, eh.RequestedDate, eh.ShipDate) AS RequestToShipDays,    1 AS NoOrder   FROM txdExportHeader eh (NOLOCK)    JOIN txdExportParties ep (NOLOCK)     ON eh.ExportGUID = ep.ExportGUID    AND eh.PartnerID = ep.PartnerID   LEFT JOIN tmgGlobalCodes g (NOLOCK)    ON g.PartnerID = eh.PartnerID    AND g.Code = eh.Status    AND g.FieldName = ''EXPORTSTATUS''   WHERE eh.recordtype = ''E''    AND eh.partnerid = @PartnerID  ) AS LookupViewInner  WHERE                                  @whereclause@';

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

DECLARE @CurrentSQLGuid8 AS VARCHAR(36) = 'cb340c75-a1a6-4f9c-924e-4c6ba2cb4f0a';
DECLARE @CurrentSQLDescription8 AS NVARCHAR(500) = 'Export Lookup: Shipments Processed Today';
DECLARE @CurrentSQLLongDescription8 AS NVARCHAR(MAX) = 'Displays all shipments that have been processed on the current day.  ';
DECLARE @CurrentSQLScript8 AS NVARCHAR(MAX) = 
	'SELECT * ,  ROW_NUMBER() OVER ( ORDER BY @orderby@) AS [RowNum]  FROM       (    SELECT DISTINCT     ''[''+ ''Edit'' + '']'' + ''(/Export/fidExportCISLI.aspx?TYPE='' + eh.RecordType + ''&ExportGuid=''+ cast (eh.ExportGuid AS varchar(50)) + '')'' AS Edit,     eh.InvoiceNum,     MAX(g.Decode) as Status,     MAX(em.EffDate) as ''Processed Date'',     1 AS NoOrder    FROM txdExportHeader eh (NOLOCK)     JOIN txdExportSystemMessages em (NOLOCK)      ON eh.ExportGUID = em.ExportGUID      AND eh.PartnerID = em.PartnerID    LEFT JOIN tmgGlobalCodes g (NOLOCK)     ON g.PartnerID = eh.PartnerID     AND g.Code = eh.Status     AND g.FieldName = ''EXPORTSTATUS''    WHERE eh.RecordType = ''E''     AND eh.PartnerID = @PartnerID      AND eh.Status = ''P''      AND DATEDIFF(d, GETDATE(), em.EffDate) = 0     AND em.Message = ''Shipment successfully processed.''     GROUP BY eh.ExportGUID, eh.InvoiceNum, eh.RecordType  ) AS LookupViewInner  WHERE                                  @whereclause@';

IF EXISTS (
		SELECT TOP 1 1
		FROM tbgSQLCommands WITH (NOLOCK)
		WHERE SQLGUID = CAST(@CurrentSQLGuid8 AS UNIQUEIDENTIFIER)
			AND SQLType = 'General SQL'
			AND Version = '20.4'
		)
BEGIN
	IF (
			SELECT Count(SQLhash)
			FROM (
				SELECT SQLhash
				FROM tbgSQLcommands WITH (NOLOCK)
				WHERE SQLGUID = CAST(@CurrentSQLGuid8 AS UNIQUEIDENTIFIER)
					AND Version = '20.4'
					AND SQLType = 'General SQL'
				
				UNION
				
				SELECT HASHBYTES('MD5', LEFT(@CurrentSQLScript8, 4000)) AS SQLhash
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

DECLARE @CurrentSQLGuid9 AS VARCHAR(36) = '81f3dead-b16f-4d78-846b-5a386bdd2d55';
DECLARE @CurrentSQLDescription9 AS NVARCHAR(500) = 'Export Lookup: All Export Messages By Shipment';
DECLARE @CurrentSQLLongDescription9 AS NVARCHAR(MAX) = 'Displays the shipments that have system messages associated to them.';
DECLARE @CurrentSQLScript9 AS NVARCHAR(MAX) = 'SELECT * ,  ROW_NUMBER() OVER ( ORDER BY @orderby@) AS [RowNum]  FROM       (   SELECT DISTINCT    ''[''+ ''Edit'' + '']'' + ''(/Export/fidExportCISLI.aspx?TYPE='' + eh.RecordType + ''&ExportGuid=''+ cast (eh.ExportGuid AS varchar(50)) + '')'' AS Edit,    eh.InvoiceNum,    g.Decode AS Status,    em.Message,    1 AS NoOrder   FROM txdExportHeader eh (NOLOCK)    JOIN txdExportSystemMessages em (NOLOCK)     ON eh.ExportGUID = em.ExportGUID     AND eh.PartnerID = em.PartnerId   LEFT JOIN tmgGlobalCodes g (NOLOCK)    ON g.PartnerID = eh.PartnerID    AND g.Code = eh.Status    AND g.FieldName = ''EXPORTSTATUS''   WHERE eh.RecordType = ''E''    AND eh.PartnerID = @PartnerID     AND eh.Status NOT IN (''F'', ''V'')  ) AS LookupViewInner  WHERE                                  @whereclause@';

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

DECLARE @CurrentSQLGuid10 AS VARCHAR(36) = '2ddfb8db-e07f-4210-9c25-05a24da73f93';
DECLARE @CurrentSQLDescription10 AS NVARCHAR(500) = 'Export Lookup: Number Of Exports By Carrier';
DECLARE @CurrentSQLLongDescription10 AS NVARCHAR(MAX) = 'Displays the number of times each carrier has been used.';
DECLARE @CurrentSQLScript10 AS NVARCHAR(MAX) = 'SELECT * ,  ROW_NUMBER() OVER ( ORDER BY @orderby@, CarrierID) AS [RowNum]  FROM       (    SELECT DISTINCT    eh.ExportCountry,    eh.ImportCountry,    eh.CarrierID,    MAX(eh.ConveyanceName) AS ConveyanceName,    COUNT(ExportGUID) AS ExportsByCarrier,    1 AS NoOrder   FROM txdExportHeader eh (NOLOCK)    LEFT JOIN tmgGlobalCodes g (NOLOCK)    ON g.PartnerID = eh.PartnerID    AND g.Code = eh.Status    AND g.FieldName = ''EXPORTSTATUS''   WHERE eh.RecordType = ''E''    AND eh.PartnerID = @PartnerID     AND eh.Status NOT IN (''F'', ''V'')     AND eh.CarrierID <> ''''   GROUP BY eh.CarrierID, eh.ImportCountry, eh.ExportCountry  ) AS LookupViewInner  WHERE                                  @whereclause@';

IF EXISTS (
		SELECT TOP 1 1
		FROM tbgSQLCommands WITH (NOLOCK)
		WHERE SQLGUID = CAST(@CurrentSQLGuid10 AS UNIQUEIDENTIFIER)
			AND SQLType = 'General SQL'
			AND Version = '20.4'
		)
BEGIN
	IF (
			SELECT Count(LongDescription)
			FROM (
				SELECT LongDescription
				FROM tbgSQLcommands WITH (NOLOCK)
				WHERE SQLGUID = CAST(@CurrentSQLGuid10 AS UNIQUEIDENTIFIER)
					AND Version = '20.4'
					AND SQLType = 'General SQL'
				
				UNION
				
				SELECT @CurrentSQLLongDescription10 AS LongDescription
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

DECLARE @CurrentSQLGuid11 AS VARCHAR(36) = '27a65e7e-8b07-42c8-888d-7db41f5fe428';
DECLARE @CurrentSQLDescription11 AS NVARCHAR(500) = 'Export Lookup: Number Of Exports By Country Pairing';
DECLARE @CurrentSQLLongDescription11 AS NVARCHAR(MAX) = 'Displays the number of exports for previously observed country pairings.    ';
DECLARE @CurrentSQLScript11 AS NVARCHAR(MAX) = 'SELECT * ,  ROW_NUMBER() OVER ( ORDER BY @orderby@) AS [RowNum]  FROM       (    SELECT DISTINCT    eh.ExportCountry,    eh.ImportCountry,    COUNT(ExportGUID) AS ExportsPerCountry,    1 AS NoOrder   FROM txdExportHeader eh (NOLOCK)    WHERE eh.RecordType = ''E''    AND eh.PartnerID = @PartnerID     AND eh.Status NOT IN (''F'', ''V'')   GROUP BY eh.ImportCountry, eh.ExportCountry  ) AS LookupViewInner  WHERE                                  @whereclause@';

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

DECLARE @CurrentSQLGuid12 AS VARCHAR(36) = '3d45c253-e11f-428c-92a0-ef8366396d34';
DECLARE @CurrentSQLDescription12 AS NVARCHAR(500) = 'Export Lookup: Domestic Shipments';
DECLARE @CurrentSQLLongDescription12 AS NVARCHAR(MAX) = 'Displays shipments where the ImportCountry is the same as the ExportCountry.    ';
DECLARE @CurrentSQLScript12 AS NVARCHAR(MAX) = 'SELECT * ,  ROW_NUMBER() OVER ( ORDER BY @orderby@) AS [RowNum]  FROM       (    SELECT DISTINCT     ''[''+ ''Edit'' + '']'' + ''(/Export/fidExportCISLI.aspx?TYPE='' + eh.RecordType + ''&ExportGuid=''+ CAST(eh.ExportGuid AS VARCHAR(50)) + '')'' AS Edit,     eh.OrderNumShip,      ISNULL(g.Decode, eh.Status) as Status,     eh.ShipmentRefNum,      eh.ShipDate,     eh.ExportDate,     eh.ExportCountry,     eh.ImportCountry,     1 AS NoOrder    FROM txdExportHeader eh (NOLOCK)     JOIN txdExportParties ep (NOLOCK)      ON eh.ExportGUID = ep.ExportGUID     AND eh.PartnerID = ep.PartnerID    LEFT JOIN tmgGlobalCodes g (NOLOCK)     ON g.PartnerID = eh.PartnerID     AND g.Code = eh.Status     AND g.FieldName = ''EXPORTSTATUS''    where     eh.Status = ''H'' and     eh.RecordType = ''E'' and     eh.PartnerID = @PartnerID and     eh.ExportCountry = eh.ImportCountry  ) AS LookupViewInner  WHERE                                  @whereclause@';

IF EXISTS (
		SELECT TOP 1 1
		FROM tbgSQLCommands WITH (NOLOCK)
		WHERE SQLGUID = CAST(@CurrentSQLGuid12 AS UNIQUEIDENTIFIER)
			AND SQLType = 'General SQL'
			AND Version = '20.4'
		)
BEGIN
	IF (
			SELECT Count(SQLhash)
			FROM (
				SELECT SQLhash
				FROM tbgSQLcommands WITH (NOLOCK)
				WHERE SQLGUID = CAST(@CurrentSQLGuid12 AS UNIQUEIDENTIFIER)
					AND Version = '20.4'
					AND SQLType = 'General SQL'
				
				UNION
				
				SELECT HASHBYTES('MD5', LEFT(@CurrentSQLScript12, 4000)) AS SQLhash
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
		WHERE SQLGUID = CAST(@CurrentSQLGuid12 AS UNIQUEIDENTIFIER)
			AND Version = '20.4'
			AND SQLType = 'General SQL';

		DELETE
		FROM tbgSQLCommands
		WHERE SQLGUID = CAST(@CurrentSQLGuid12 AS UNIQUEIDENTIFIER)
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
			,@CurrentSQLGuid12
			,@CurrentSQLScript12
			,@CurrentSQLDescription12
			,@CurrentSQLLongDescription12
			,GETDATE()
			,'rsheth'
			,'rsheth'
			,HASHBYTES('MD5', LEFT(@CurrentSQLScript12, 4000))
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
		,@CurrentSQLGuid12
		,@CurrentSQLScript12
		,@CurrentSQLDescription12
		,@CurrentSQLLongDescription12
		,GETDATE()
		,'rsheth'
		,'rsheth'
		,HASHBYTES('MD5', LEFT(@CurrentSQLScript12, 4000))
		,'General SQL'
		,'20.4'
		,'N'
		,'N'
		);
END

DECLARE @CurrentSQLGuid13 AS VARCHAR(36) = '0d082f57-1614-45b0-a385-65ad788a2bf2';
DECLARE @CurrentSQLDescription13 AS NVARCHAR(500) = 'Export Lookup: Processed Shipments';
DECLARE @CurrentSQLLongDescription13 AS NVARCHAR(MAX) = 'Displays the shipments that have been processed.   ';
DECLARE @CurrentSQLScript13 AS NVARCHAR(MAX) = 'SELECT * ,  ROW_NUMBER() OVER ( ORDER BY @orderby@) AS [RowNum]  FROM       (    SELECT DISTINCT    ''[''+ ''Edit'' + '']'' + ''(/Export/fidExportCISLI.aspx?TYPE='' + eh.RecordType + ''&ExportGuid=''+ CAST(eh.ExportGuid AS VARCHAR(50)) + '')'' AS Edit,    eh.OrderNumShip,     ISNULL(g.Decode, eh.Status) as Status,    eh.ShipmentRefNum,     eh.ShipDate,    eh.ExportDate,    eh.ExportCountry,    eh.ImportCountry,    1 AS NoOrder   FROM txdExportHeader eh (NOLOCK)    JOIN txdExportParties ep (NOLOCK)     ON eh.ExportGUID = ep.ExportGUID    AND eh.PartnerID = ep.PartnerID   LEFT JOIN tmgGlobalCodes g (nolock)    ON g.partnerid = eh.partnerid    AND g.code = eh.status    AND g.fieldname = ''EXPORTSTATUS''   where eh.recordtype = ''E''    AND eh.partnerid = @PartnerID    AND eh.ProcessedFlag = ''Y''  ) AS LookupViewInner  WHERE                                  @whereclause@';

IF EXISTS (
		SELECT TOP 1 1
		FROM tbgSQLCommands WITH (NOLOCK)
		WHERE SQLGUID = CAST(@CurrentSQLGuid13 AS UNIQUEIDENTIFIER)
			AND SQLType = 'General SQL'
			AND Version = '20.4'
		)
BEGIN
	IF (
			SELECT Count(SQLhash)
			FROM (
				SELECT SQLhash
				FROM tbgSQLcommands WITH (NOLOCK)
				WHERE SQLGUID = CAST(@CurrentSQLGuid13 AS UNIQUEIDENTIFIER)
					AND Version = '20.4'
					AND SQLType = 'General SQL'
				
				UNION
				
				SELECT HASHBYTES('MD5', LEFT(@CurrentSQLScript13, 4000)) AS SQLhash
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
		WHERE SQLGUID = CAST(@CurrentSQLGuid13 AS UNIQUEIDENTIFIER)
			AND Version = '20.4'
			AND SQLType = 'General SQL';

		DELETE
		FROM tbgSQLCommands
		WHERE SQLGUID = CAST(@CurrentSQLGuid13 AS UNIQUEIDENTIFIER)
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
			,@CurrentSQLGuid13
			,@CurrentSQLScript13
			,@CurrentSQLDescription13
			,@CurrentSQLLongDescription13
			,GETDATE()
			,'rsheth'
			,'rsheth'
			,HASHBYTES('MD5', LEFT(@CurrentSQLScript13, 4000))
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
		,@CurrentSQLGuid13
		,@CurrentSQLScript13
		,@CurrentSQLDescription13
		,@CurrentSQLLongDescription13
		,GETDATE()
		,'rsheth'
		,'rsheth'
		,HASHBYTES('MD5', LEFT(@CurrentSQLScript13, 4000))
		,'General SQL'
		,'20.4'
		,'N'
		,'N'
		);
END

DECLARE @CurrentSQLGuid14 AS VARCHAR(36) = '837ee233-fb26-4e5c-83da-f4d019a945da';
DECLARE @CurrentSQLDescription14 AS NVARCHAR(500) = 'Export Lookup: Voided Shipments';
DECLARE @CurrentSQLLongDescription14 AS NVARCHAR(MAX) = 'Displays the shipments that have been voided.  ';
DECLARE @CurrentSQLScript14 AS NVARCHAR(MAX) = 
	'SELECT *, ROW_NUMBER() OVER (                                  ORDER BY @orderby@                                  ) AS [RowNum]  FROM (                  SELECT DISTINCT ''['' + ''Edit'' + '']'' + ''(/Export/fidExportCISLI.aspx?TYPE='' + eh.RecordType + ''&ExportGuid='' + CAST(eh.ExportGuid AS VARCHAR(50)) + '')'' AS Edit, eh.OrderNumShip, ISNULL(g.Decode, eh.STATUS) AS Status, eh.ShipmentRefNum, eh.ShipDate, eh.ExportDate, eh.ExportCountry, eh.ImportCountry, eh.VoidReasonCode, eh.VoidExplanation, eh.ModifiedBy, 1 AS NoOrder                    FROM txdExportHeader eh(NOLOCK)                  JOIN txdExportParties ep(NOLOCK)                                  ON eh.ExportGUID = ep.ExportGUID                                                  AND eh.PartnerID = ep.PartnerID                  LEFT JOIN tmgGlobalCodes g(NOLOCK)                                  ON g.partnerid = eh.partnerid                                                  AND g.code = eh.STATUS                                                  AND g.fieldname = ''EXPORTSTATUS''                  WHERE eh.STATUS = ''V''                                  AND eh.recordtype = ''E''                                  AND eh.partnerid = @PartnerID@                                  AND eh.VoidFlag = ''Y''                  ) AS LookupViewInner  WHERE @whereclause@'
	;

IF EXISTS (
		SELECT TOP 1 1
		FROM tbgSQLCommands WITH (NOLOCK)
		WHERE SQLGUID = CAST(@CurrentSQLGuid14 AS UNIQUEIDENTIFIER)
			AND SQLType = 'General SQL'
			AND Version = '20.4'
		)
BEGIN
	IF (
			SELECT Count(LongDescription)
			FROM (
				SELECT LongDescription
				FROM tbgSQLcommands WITH (NOLOCK)
				WHERE SQLGUID = CAST(@CurrentSQLGuid14 AS UNIQUEIDENTIFIER)
					AND Version = '20.4'
					AND SQLType = 'General SQL'
				
				UNION
				
				SELECT @CurrentSQLLongDescription14 AS LongDescription
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
		WHERE SQLGUID = CAST(@CurrentSQLGuid14 AS UNIQUEIDENTIFIER)
			AND Version = '20.4'
			AND SQLType = 'General SQL';

		DELETE
		FROM tbgSQLCommands
		WHERE SQLGUID = CAST(@CurrentSQLGuid14 AS UNIQUEIDENTIFIER)
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
			,@CurrentSQLGuid14
			,@CurrentSQLScript14
			,@CurrentSQLDescription14
			,@CurrentSQLLongDescription14
			,GETDATE()
			,'rsheth'
			,'rsheth'
			,HASHBYTES('MD5', LEFT(@CurrentSQLScript14, 4000))
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
		,@CurrentSQLGuid14
		,@CurrentSQLScript14
		,@CurrentSQLDescription14
		,@CurrentSQLLongDescription14
		,GETDATE()
		,'rsheth'
		,'rsheth'
		,HASHBYTES('MD5', LEFT(@CurrentSQLScript14, 4000))
		,'General SQL'
		,'20.4'
		,'N'
		,'N'
		);
END

DECLARE @CurrentSQLGuid15 AS VARCHAR(36) = 'b7c06947-0135-4bdc-b264-3d7016ad770f';
DECLARE @CurrentSQLDescription15 AS NVARCHAR(500) = 'Export Lookup: Shipments With Process Overrides';
DECLARE @CurrentSQLLongDescription15 AS NVARCHAR(MAX) = 'Displays the shipments which were originally put on hold but have been overridden by the user. ';
DECLARE @CurrentSQLScript15 AS NVARCHAR(MAX) = 'SELECT * ,  ROW_NUMBER() OVER ( ORDER BY @orderby@) AS [RowNum]  FROM       (    SELECT DISTINCT     ''['' + ''Edit'' + '']'' + ''(/Export/fidExportCISLI.aspx?TYPE='' + eh.RecordType + ''&ExportGuid='' + CAST(eh.ExportGuid AS VARCHAR(50)) + '')'' AS Edit,    eh.ShipmentRefNum,    eh.OrderNum,    eh.ExportCountry,    eh.ImportCountry,    eh.ExportDate,    ISNULL(g.Decode, '''') AS Status,    1 AS NoOrder   FROM txdExportHeader eh (NOLOCK)   JOIN txdExportSystemMessages em (NOLOCK)    ON eh.ExportGUID = em.ExportGUID    AND eh.PartnerID = em.PartnerID   LEFT JOIN tmgGlobalCodes g(NOLOCK)    ON g.PartnerID = eh.PartnerID    AND g.Code = eh.Status    AND g.FieldName = ''EXPORTSTATUS''   WHERE 1 = 1    AND eh.recordtype = ''E''    AND eh.partnerid = @PartnerID    AND eh.Status = ''HP''  ) AS LookupViewInner  WHERE                                  @whereclause@';

IF EXISTS (
		SELECT TOP 1 1
		FROM tbgSQLCommands WITH (NOLOCK)
		WHERE SQLGUID = CAST(@CurrentSQLGuid15 AS UNIQUEIDENTIFIER)
			AND SQLType = 'General SQL'
			AND Version = '20.4'
		)
BEGIN
	IF (
			SELECT Count(SQLhash)
			FROM (
				SELECT SQLhash
				FROM tbgSQLcommands WITH (NOLOCK)
				WHERE SQLGUID = CAST(@CurrentSQLGuid15 AS UNIQUEIDENTIFIER)
					AND Version = '20.4'
					AND SQLType = 'General SQL'
				
				UNION
				
				SELECT HASHBYTES('MD5', LEFT(@CurrentSQLScript15, 4000)) AS SQLhash
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
		WHERE SQLGUID = CAST(@CurrentSQLGuid15 AS UNIQUEIDENTIFIER)
			AND Version = '20.4'
			AND SQLType = 'General SQL';

		DELETE
		FROM tbgSQLCommands
		WHERE SQLGUID = CAST(@CurrentSQLGuid15 AS UNIQUEIDENTIFIER)
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
			,@CurrentSQLGuid15
			,@CurrentSQLScript15
			,@CurrentSQLDescription15
			,@CurrentSQLLongDescription15
			,GETDATE()
			,'rsheth'
			,'rsheth'
			,HASHBYTES('MD5', LEFT(@CurrentSQLScript15, 4000))
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
		,@CurrentSQLGuid15
		,@CurrentSQLScript15
		,@CurrentSQLDescription15
		,@CurrentSQLLongDescription15
		,GETDATE()
		,'rsheth'
		,'rsheth'
		,HASHBYTES('MD5', LEFT(@CurrentSQLScript15, 4000))
		,'General SQL'
		,'20.4'
		,'N'
		,'N'
		);
END

DECLARE @CurrentSQLGuid16 AS VARCHAR(36) = '3afae6c9-68a8-46f9-9c91-bdf2815779da';
DECLARE @CurrentSQLDescription16 AS NVARCHAR(500) = 'Export Lookup: Shipments Processed in the Last 7, 30, 90 days';
DECLARE @CurrentSQLLongDescription16 AS NVARCHAR(MAX) = 'Shipments processed in the last 7, 30 or 90 days based on the user''s selection in the dropdown';
DECLARE @CurrentSQLScript16 AS NVARCHAR(MAX) = 
	'SELECT * ,  ROW_NUMBER() OVER ( ORDER BY @orderby@) AS [RowNum]  FROM       (    SELECT DISTINCT     ''[''+ ''Edit'' + '']'' + ''(/Export/fidExportCISLI.aspx?TYPE='' + eh.RecordType + ''&ExportGuid=''+ cast (eh.ExportGuid AS varchar(50)) + '')'' AS Edit,     eh.InvoiceNum,     MAX(g.Decode) AS Status,     MAX(em.EffDate) AS ''Processed Date'',     1 AS NoOrder    FROM txdExportHeader eh (NOLOCK)     JOIN txdExportSystemMessages em (NOLOCK)      ON eh.ExportGUID = em.ExportGUID      AND eh.PartnerID = em.PartnerID    LEFT JOIN tmgGlobalCodes g (NOLOCK)     ON g.partnerid = eh.partnerid     AND g.code = eh.status     AND g.fieldname = ''EXPORTSTATUS''    WHERE eh.recordtype = ''E''     AND eh.partnerid = @PartnerID      AND eh.status = ''P''      AND em.Effdate >= DATEADD(day, - @VALUE@, GETDATE())      AND em.Message = ''Shipment successfully processed.''     Group by eh.ExportGUID, eh.InvoiceNum, eh.RecordType  ) AS LookupViewInner  WHERE                                  @whereclause@'
	;

IF EXISTS (
		SELECT TOP 1 1
		FROM tbgSQLCommands WITH (NOLOCK)
		WHERE SQLGUID = CAST(@CurrentSQLGuid16 AS UNIQUEIDENTIFIER)
			AND SQLType = 'General SQL'
			AND Version = '20.4'
		)
BEGIN
	IF (
			SELECT Count(LongDescription)
			FROM (
				SELECT LongDescription
				FROM tbgSQLcommands WITH (NOLOCK)
				WHERE SQLGUID = CAST(@CurrentSQLGuid16 AS UNIQUEIDENTIFIER)
					AND Version = '20.4'
					AND SQLType = 'General SQL'
				
				UNION
				
				SELECT @CurrentSQLLongDescription16 AS LongDescription
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
		WHERE SQLGUID = CAST(@CurrentSQLGuid16 AS UNIQUEIDENTIFIER)
			AND Version = '20.4'
			AND SQLType = 'General SQL';

		DELETE
		FROM tbgSQLCommands
		WHERE SQLGUID = CAST(@CurrentSQLGuid16 AS UNIQUEIDENTIFIER)
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
			,@CurrentSQLGuid16
			,@CurrentSQLScript16
			,@CurrentSQLDescription16
			,@CurrentSQLLongDescription16
			,GETDATE()
			,'rsheth'
			,'rsheth'
			,HASHBYTES('MD5', LEFT(@CurrentSQLScript16, 4000))
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
		,@CurrentSQLGuid16
		,@CurrentSQLScript16
		,@CurrentSQLDescription16
		,@CurrentSQLLongDescription16
		,GETDATE()
		,'rsheth'
		,'rsheth'
		,HASHBYTES('MD5', LEFT(@CurrentSQLScript16, 4000))
		,'General SQL'
		,'20.4'
		,'N'
		,'N'
		);
END

DECLARE @CurrentSQLGuid17 AS VARCHAR(36) = 'f0405e73-a1f7-4e09-9c3b-a97d5e76c6ce';
DECLARE @CurrentSQLDescription17 AS NVARCHAR(500) = 'Export Lookup: Export Lookup';
DECLARE @CurrentSQLLongDescription17 AS NVARCHAR(MAX) = 'Displays all export transactions.';
DECLARE @CurrentSQLScript17 AS NVARCHAR(MAX) = 'SELECT * , ROW_NUMBER() OVER ( ORDER BY @orderby@, OrderNumShip DESC ) AS [RowNum] FROM      (    SELECT    eh.PartnerID, eh.ExportGuid, eh.OrderNumShip, g.Decode AS Status, eh.ExportDate,   1 AS NoOrder  FROM txdExportHeader eh with (nolock)  JOIN txdExportParties ep with (nolock)   ON eh.ExportGuid = ep.ExportGuid    AND eh.PartnerID = ep.PartnerID  LEFT JOIN tmgglobalcodes g with (nolock)   ON g.PartnerID = eh.PartnerID   AND g.Code = eh.Status   AND g.FieldName = ''EXPORTSTATUS''  WHERE   eh.RecordType = ''E''   AND eh.PartnerID = @PartnerID ) AS LookupViewInner WHERE                                 @whereclause@';

IF EXISTS (
		SELECT TOP 1 1
		FROM tbgSQLCommands WITH (NOLOCK)
		WHERE SQLGUID = CAST(@CurrentSQLGuid17 AS UNIQUEIDENTIFIER)
			AND SQLType = 'General SQL'
			AND Version = '20.4'
		)
BEGIN
	IF (
			SELECT Count(SQLhash)
			FROM (
				SELECT SQLhash
				FROM tbgSQLcommands WITH (NOLOCK)
				WHERE SQLGUID = CAST(@CurrentSQLGuid17 AS UNIQUEIDENTIFIER)
					AND Version = '20.4'
					AND SQLType = 'General SQL'
				
				UNION
				
				SELECT HASHBYTES('MD5', LEFT(@CurrentSQLScript17, 4000)) AS SQLhash
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
		WHERE SQLGUID = CAST(@CurrentSQLGuid17 AS UNIQUEIDENTIFIER)
			AND Version = '20.4'
			AND SQLType = 'General SQL';

		DELETE
		FROM tbgSQLCommands
		WHERE SQLGUID = CAST(@CurrentSQLGuid17 AS UNIQUEIDENTIFIER)
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
			,@CurrentSQLGuid17
			,@CurrentSQLScript17
			,@CurrentSQLDescription17
			,@CurrentSQLLongDescription17
			,GETDATE()
			,'rsheth'
			,'rsheth'
			,HASHBYTES('MD5', LEFT(@CurrentSQLScript17, 4000))
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
		,@CurrentSQLGuid17
		,@CurrentSQLScript17
		,@CurrentSQLDescription17
		,@CurrentSQLLongDescription17
		,GETDATE()
		,'rsheth'
		,'rsheth'
		,HASHBYTES('MD5', LEFT(@CurrentSQLScript17, 4000))
		,'General SQL'
		,'20.4'
		,'N'
		,'N'
		);
END

DECLARE @CurrentSQLGuid18 AS VARCHAR(36) = 'c2e3b4f9-2338-4e16-9eab-66b3818a5f74';
DECLARE @CurrentSQLDescription18 AS NVARCHAR(500) = 'Export Lookup: Processed Shipments by User';
DECLARE @CurrentSQLLongDescription18 AS NVARCHAR(MAX) = 'Displays the number of shipments that have been processed by specific users by week';
DECLARE @CurrentSQLScript18 AS NVARCHAR(MAX) = 'SELECT * ,   ROW_NUMBER() OVER ( ORDER BY @orderby@, Week DESC, UserName ) AS [RowNum]  FROM (   SELECT     DATEADD(week, DATEDIFF(week, 0, eh.LastProcessedDate), 0) as Week,     ed.UserName,    COUNT(DISTINCT eh.ExportGUID) AS [Processed Count],    1 AS NoOrder   FROM txdExportHeader eh (NOLOCK)   JOIN txdExportDocumentation ed (NOLOCK)     ON eh.ExportGUID = ed.ExportGUID    AND eh.PartnerID = ed.PartnerID   WHERE eh.RecordType = ''E''    AND eh.ProcessedFlag = ''Y''     AND ed.Status = ''PRINTED''    AND eh.PartnerID = @PartnerID   GROUP BY DATEADD(week, DATEDIFF(week, 0, eh.LastProcessedDate), 0), ed.UserName  ) AS LookupViewInner  WHERE    @whereclause@';

IF EXISTS (
		SELECT TOP 1 1
		FROM tbgSQLCommands WITH (NOLOCK)
		WHERE SQLGUID = CAST(@CurrentSQLGuid18 AS UNIQUEIDENTIFIER)
			AND SQLType = 'General SQL'
			AND Version = '20.4'
		)
BEGIN
	IF (
			SELECT Count(SQLhash)
			FROM (
				SELECT SQLhash
				FROM tbgSQLcommands WITH (NOLOCK)
				WHERE SQLGUID = CAST(@CurrentSQLGuid18 AS UNIQUEIDENTIFIER)
					AND Version = '20.4'
					AND SQLType = 'General SQL'
				
				UNION
				
				SELECT HASHBYTES('MD5', LEFT(@CurrentSQLScript18, 4000)) AS SQLhash
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
		WHERE SQLGUID = CAST(@CurrentSQLGuid18 AS UNIQUEIDENTIFIER)
			AND Version = '20.4'
			AND SQLType = 'General SQL';

		DELETE
		FROM tbgSQLCommands
		WHERE SQLGUID = CAST(@CurrentSQLGuid18 AS UNIQUEIDENTIFIER)
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
			,@CurrentSQLGuid18
			,@CurrentSQLScript18
			,@CurrentSQLDescription18
			,@CurrentSQLLongDescription18
			,GETDATE()
			,'rsheth'
			,'rsheth'
			,HASHBYTES('MD5', LEFT(@CurrentSQLScript18, 4000))
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
		,@CurrentSQLGuid18
		,@CurrentSQLScript18
		,@CurrentSQLDescription18
		,@CurrentSQLLongDescription18
		,GETDATE()
		,'rsheth'
		,'rsheth'
		,HASHBYTES('MD5', LEFT(@CurrentSQLScript18, 4000))
		,'General SQL'
		,'20.4'
		,'N'
		,'N'
		);
END

DECLARE @CurrentSQLGuid19 AS VARCHAR(36) = '1dbad088-4044-489c-b734-5e9d48ce509b';
DECLARE @CurrentSQLDescription19 AS NVARCHAR(500) = 'Shipments Exceeding $2,500';
DECLARE @CurrentSQLLongDescription19 AS NVARCHAR(MAX) = 'Displays all AES export shipments exceeding $2,500';
DECLARE @CurrentSQLScript19 AS NVARCHAR(MAX) = 
	'SELECT *  ,ROW_NUMBER() OVER (   ORDER BY @orderby@   ) AS [RowNum] FROM (  SELECT eh.effdate   ,eh.PartnerID   ,eh.ExportGuid   ,eh.OrderNumShip   ,eh.AccountNum   ,eh.OrderNum AS OrderNum   ,(    SELECT cast(SUM(TotalValue) AS NUMERIC(38, 2))    FROM txdExportDetail d WITH (NOLOCK)    WHERE eh.partnerid = d.partnerid     AND eh.exportguid = d.exportguid    ) AS TotalValue   ,eh.AESSubmitFlag   ,eh.AESITN   ,CASE     WHEN EXISTS (      SELECT 1      FROM txdExportSystemMessages esm WITH (NOLOCK)      WHERE esm.PartnerID = eh.Partnerid       AND esm.ExportGUID = eh.ExportguID       AND esm.Field = ''AESSubmitFlag''       AND esm.HoldFlag = ''Y''      )     AND NOT EXISTS (      SELECT 1      FROM txdExportSystemMessages esm WITH (NOLOCK)      WHERE esm.PartnerID = eh.Partnerid       AND esm.ExportGUID = eh.ExportguID       AND esm.Field <> ''AESSubmitFlag''       AND esm.HoldFlag = ''Y''      )     THEN g.decode + '' - AES Selection''    ELSE g.Decode    END AS Status   ,ep.SellerID   ,ep.SellerCompanyName   ,ep.BillToCompanyName   ,ep.ShipToCompanyName   ,eh.ImportCountry   ,ep.ShipToCity + '' -  '' + ep.ShipToCountryCode AS ShipToCityCountry   ,eh.RequestedDate   ,eha.EMHS01   ,eha.EMHS02   ,eha.EMHS03   ,ep.ShipFromCity   ,eha.EMHD01   ,ISNULL(STUFF((      SELECT ''// '' + Note      FROM txdExportNote en      WHERE eh.ExportGUID = en.ExportGUID      ORDER BY en.Effdate      FOR XML PATH('''')      ), 1, 2, ''''), '''') AS Note   ,1 AS NoOrder  FROM txdExportHeader eh with (nolock)  JOIN txdExportParties ep with (nolock)   ON eh.ExportGuid = ep.ExportGuid    AND eh.PartnerID = ep.PartnerID  JOIN txdExportHeaderAddlFields eha with (nolock)   ON eh.ExportGuid = eha.ExportGuid    AND eh.PartnerID = eha.PartnerID  LEFT JOIN tmgglobalcodes g with (nolock)   ON g.PartnerID = eh.PartnerID    AND g.Code = eh.STATUS    AND g.FieldName = ''EXPORTSTATUS''  WHERE eh.RecordType = ''E''   AND Eh.STATUS NOT IN (''V'')   AND (    SELECT SUM(TotalValue)    FROM txdExportDetail d WITH (NOLOCK)    WHERE eh.partnerid = d.partnerid     AND eh.exportguid = d.exportguid    ) >= 2500   AND (    eh.AESSubmitFlag <> ''Y''    OR eh.AESITN = ''''    )  ) AS LookupViewInner WHERE @whereclause@ '
	;

IF EXISTS (
		SELECT TOP 1 1
		FROM tbgSQLCommands WITH (NOLOCK)
		WHERE SQLGUID = CAST(@CurrentSQLGuid19 AS UNIQUEIDENTIFIER)
			AND SQLType = 'General SQL'
			AND Version = '20.4'
		)
BEGIN
	IF (
			SELECT Count(LongDescription)
			FROM (
				SELECT LongDescription
				FROM tbgSQLcommands WITH (NOLOCK)
				WHERE SQLGUID = CAST(@CurrentSQLGuid19 AS UNIQUEIDENTIFIER)
					AND Version = '20.4'
					AND SQLType = 'General SQL'
				
				UNION
				
				SELECT @CurrentSQLLongDescription19 AS LongDescription
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
		WHERE SQLGUID = CAST(@CurrentSQLGuid19 AS UNIQUEIDENTIFIER)
			AND Version = '20.4'
			AND SQLType = 'General SQL';

		DELETE
		FROM tbgSQLCommands
		WHERE SQLGUID = CAST(@CurrentSQLGuid19 AS UNIQUEIDENTIFIER)
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
			,@CurrentSQLGuid19
			,@CurrentSQLScript19
			,@CurrentSQLDescription19
			,@CurrentSQLLongDescription19
			,GETDATE()
			,'rsheth'
			,'rsheth'
			,HASHBYTES('MD5', LEFT(@CurrentSQLScript19, 4000))
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
		,@CurrentSQLGuid19
		,@CurrentSQLScript19
		,@CurrentSQLDescription19
		,@CurrentSQLLongDescription19
		,GETDATE()
		,'rsheth'
		,'rsheth'
		,HASHBYTES('MD5', LEFT(@CurrentSQLScript19, 4000))
		,'General SQL'
		,'20.4'
		,'N'
		,'N'
		);
END
