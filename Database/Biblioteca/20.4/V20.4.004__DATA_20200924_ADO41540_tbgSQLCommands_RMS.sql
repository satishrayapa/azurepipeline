DECLARE @CurrentSQLGuid1 AS VARCHAR(36) = '6bdb9e34-fa0c-4aab-8258-cf1d880aff44';
DECLARE @CurrentSQLDescription1 AS NVARCHAR(500) = 'Export Lookup: AES Flag Set to Y, no ITN, Processed Shipments';
DECLARE @CurrentSQLLongDescription1 AS NVARCHAR(MAX) = 'Displays the shipments that have been processed in AES but have no ITN numbers.';
DECLARE @CurrentSQLScript1 AS NVARCHAR(MAX) = 'SELECT * ,  ROW_NUMBER() OVER ( ORDER BY @orderby@) AS [RowNum]  FROM       (    SELECT DISTINCT    ''[''+ ''Edit'' + '']'' + ''(/Export/fidExportCISLI.aspx?TYPE='' + eh.RecordType + ''&ExportGuid=''+ CAST(eh.ExportGuid AS VARCHAR(50)) + '')'' AS Edit,    eh.OrderNumShip,     eh.OrderNum,    ISNULL(g.Decode, eh.Status) as Status,    1 AS NoOrder   FROM txdExportHeader eh (NOLOCK)    LEFT JOIN tmgGlobalCodes g (NOLOCK)    ON g.PartnerID = eh.PartnerID    AND g.Code = eh.Status    AND g.FieldName = ''EXPORTSTATUS''   WHERE eh.RecordType = ''E''    AND eh.partnerid = @PartnerID    AND eh.AESSubmitFlag = ''Y''    AND eh.AESITN = ''''    AND eh.ProcessedFlag = ''Y''  ) AS LookupViewInner  WHERE                                  @whereclause@';

IF EXISTS (
		SELECT TOP 1 1
		FROM tbgSQLCommands WITH (NOLOCK)
		WHERE SQLGUID = CAST(@CurrentSQLGuid1 AS UNIQUEIDENTIFIER)
			AND SQLType = 'General SQL'
			AND Version = '20.4'
		)
BEGIN
	IF (
			SELECT Count(LongDescription)
			FROM (
				SELECT LongDescription
				FROM tbgSQLcommands WITH (NOLOCK)
				WHERE SQLGUID = CAST(@CurrentSQLGuid1 AS UNIQUEIDENTIFIER)
					AND Version = '20.4'
					AND SQLType = 'General SQL'
				
				UNION
				
				SELECT @CurrentSQLLongDescription1 AS LongDescription
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

DECLARE @CurrentSQLGuid2 AS VARCHAR(36) = 'b2aab4fd-27a6-46fc-8bc4-c9bada344e40';
DECLARE @CurrentSQLDescription2 AS NVARCHAR(500) = 'Export Lookup: Shipments Approaching Filing Deadline';
DECLARE @CurrentSQLLongDescription2 AS NVARCHAR(MAX) = 'Displays shipments that are approaching their export date.';
DECLARE @CurrentSQLScript2 AS NVARCHAR(MAX) = 'SELECT * ,  ROW_NUMBER() OVER ( ORDER BY @orderby@) AS [RowNum]  FROM       (    SELECT DISTINCT    ''[''+ ''Edit'' + '']'' + ''(/Export/fidExportCISLI.aspx?TYPE='' + eh.RecordType + ''&ExportGuid=''+ CAST(eh.ExportGuid AS VARCHAR(50)) + '')'' AS Edit,    eh.OrderNumShip,     eh.OrderNum,    eh.ExportDate,     ISNULL(g.Decode, eh.Status) AS Status,    1 AS NoOrder   FROM txdExportHeader eh (NOLOCK)    LEFT JOIN tmgGlobalCodes g (NOLOCK)    ON g.PartnerID = eh.PartnerID    AND g.Code = eh.Status    AND g.FieldName = ''EXPORTSTATUS''   WHERE eh.Status = ''H''    AND eh.recordtype = ''E''    AND eh.ExportDate <= DATEADD(DD, +1, GETDATE())    AND eh.AESITN = ''''    AND eh.partnerid = @PartnerID  ) AS LookupViewInner  WHERE                                  @whereclause@';

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

DECLARE @CurrentSQLGuid3 AS VARCHAR(36) = 'd74730e1-ab11-4991-a405-f31cdf5868a7';
DECLARE @CurrentSQLDescription3 AS NVARCHAR(500) = 'Export Lookup: AES Transmissions Today';
DECLARE @CurrentSQLLongDescription3 AS NVARCHAR(MAX) = 'Displays the shipments that have been processed by AES in the current day.';
DECLARE @CurrentSQLScript3 AS NVARCHAR(MAX) = 'SELECT * ,  ROW_NUMBER() OVER ( ORDER BY @orderby@) AS [RowNum]  FROM       (    SELECT DISTINCT    ''[''+ ''Edit'' + '']'' + ''(/Export/fidExportCISLI.aspx?TYPE='' + eh.RecordType + ''&ExportGuid=''+ CAST(eh.ExportGuid AS VARCHAR(50)) + '')'' AS Edit,    eh.ShipmentRefNum,    g.Decode as Status,    aes.TransmissionDate AS ''AES Transmission Date'',    1 AS NoOrder   FROM txdExportHeader eh (NOLOCK)    JOIN txdAESHeader aes (NOLOCK)     ON eh.ShipmentRefNum = aes.ShipmentRefNum     AND eh.PartnerID = aes.PartnerID   LEFT JOIN tmgGlobalCodes g (NOLOCK)    ON g.PartnerID = eh.PartnerID    AND g.Code = eh.Status    AND g.FieldName = ''EXPORTSTATUS''   WHERE eh.RecordType = ''E''    AND eh.PartnerID = @PartnerID     AND eh.Status = ''P''     AND DATEDIFF(d, GETDATE(), aes.TransmissionDate) = 0      AND aes.TransmittedFlag = ''Y''  ) AS LookupViewInner  WHERE                                  @whereclause@';

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

DECLARE @CurrentSQLGuid4 AS VARCHAR(36) = '508254b9-cd75-466c-9cae-7bc43834555c';
DECLARE @CurrentSQLDescription4 AS NVARCHAR(500) = 'Export Lookup: AES Exorts Within 5 days and No ITN';
DECLARE @CurrentSQLLongDescription4 AS NVARCHAR(MAX) = 'Displays the shipments within 5 days of the export date that do not yet have their ITN number. ';
DECLARE @CurrentSQLScript4 AS NVARCHAR(MAX) = 'SELECT * ,  ROW_NUMBER() OVER ( ORDER BY @orderby@) AS [RowNum]  FROM       (    SELECT DISTINCT    ''[''+ ''Edit'' + '']'' + ''(/Export/fidExportCISLI.aspx?TYPE='' + eh.RecordType + ''&ExportGuid=''+ CAST(eh.ExportGuid AS VARCHAR(50)) + '')'' AS Edit,    eh.OrderNum,     ISNULL(g.Decode, eh.Status) AS Status,    eh.AESSubmitFlag,    eh.AESITN,    eh.ExportDate,    1 AS NoOrder      FROM txdExportHeader eh (NOLOCK)    LEFT JOIN tmgGlobalCodes g (NOLOCK)    ON g.PartnerID = eh.PartnerID    AND g.Code = eh.Status    AND g.FieldName = ''EXPORTSTATUS''   WHERE eh.RecordType = ''E''    AND eh.PartnerID = @PartnerID     AND eh.Status not in (''F'', ''V'')     AND eh.AESSubmitFlag = ''Y''     AND eh.AESITN = ''''    AND eh.ExportDate >= DATEADD(DAY,-5, GETDATE())  ) AS LookupViewInner  WHERE                                  @whereclause@';

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

DECLARE @CurrentSQLGuid5 AS VARCHAR(36) = '8bd5a2ef-df05-474b-a9ff-ce6b1e26a968';
DECLARE @CurrentSQLDescription5 AS NVARCHAR(500) = 'Export Lookup: Accepted Shipments Without ECS Date';
DECLARE @CurrentSQLLongDescription5 AS NVARCHAR(MAX) = 'Displays the shipments which have not been put on hold and do not have an ECS date.    ';
DECLARE @CurrentSQLScript5 AS NVARCHAR(MAX) = 'SELECT * ,  ROW_NUMBER() OVER ( ORDER BY @orderby@) AS [RowNum]  FROM       (    SELECT     ''['' + ''Edit'' + '']'' + ''(/Export/fidConsolidate.aspx?TYPE='' + RIGHT(CustomsType, 1) + ''&CUSTOMSTYPE='' + SUBSTRING(CustomsType, 1, LEN(CustomsType) - 1) + ''&SRN='' + ShipmentRefNum AS Edit,    CustomsType,    ShipmentRefNum AS UCR,    ITN AS MRN,    CarrierId,    TransmissionDate,    DestinationCountry AS DestCtry,    DATEDIFF(dd, GETDATE(), TransmissionDate) AS SinceExport,    1 AS NoOrder   FROM txdConsolidatedHeader(NOLOCK)   WHERE partnerid = @PartnerID    AND DestinationCountry NOT IN (     SELECT CountryCode     FROM tmfCountryGroup(NOLOCK)     WHERE GroupName = ''EU''     )    AND ECSReceivedDate = ''01/01/1900''  ) AS LookupViewInner  WHERE                                  @whereclause@';

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

DECLARE @CurrentSQLGuid6 AS VARCHAR(36) = 'f9db24ed-b6c1-4de8-b6f6-7f0ae3b9eaa4';
DECLARE @CurrentSQLDescription6 AS NVARCHAR(500) = 'Export Lookup: Fatally Rejected EEI Fillings';
DECLARE @CurrentSQLLongDescription6 AS NVARCHAR(MAX) = 'Displays the shipments which have been rejected in their final dispositions.    ';
DECLARE @CurrentSQLScript6 AS NVARCHAR(MAX) = 'SELECT * ,  ROW_NUMBER() OVER ( ORDER BY @orderby@) AS [RowNum]  FROM       (   SELECT DISTINCT    ''[''+ ''Edit'' + '']'' + ''(/Export/fidAESTransmission.aspx?TYPE=E&SRN='' + aesh.ShipmentRefNum + '')'' AS Edit,    aesh.ShipmentRefNum,     aesh.FinalDisposition,    aesh.ExportDate,    aesh.PortOfExportation,    aesh.DestinationCountry,    aesh.CarrierID,    aesh.TransportRefNum,    1 AS NoOrder   FROM txdAESHeader aesh (nolock)    WHERE aesh.partnerid = @PartnerID    AND aesh.FinalDisposition = ''R''     AND aesh.SeverityIndicator = ''F''  ) AS LookupViewInner  WHERE                                  @whereclause@';

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

DECLARE @CurrentSQLGuid7 AS VARCHAR(36) = '7f70ffaf-3f3b-42d7-b6d8-88d05fdf494c';
DECLARE @CurrentSQLDescription7 AS NVARCHAR(500) = 'Export Lookup: AES Filings';
DECLARE @CurrentSQLLongDescription7 AS NVARCHAR(MAX) = 'Displays shipments that have been filed in AES and contains the relevant information about AES filings.  ';
DECLARE @CurrentSQLScript7 AS NVARCHAR(MAX) = 'SELECT * ,  ROW_NUMBER() OVER ( ORDER BY @orderby@) AS [RowNum]  FROM       (    SELECT DISTINCT    ''[''+ ''Edit'' + '']'' + ''(/Export/fidAESTransmission.aspx?TYPE='' + eh.RecordType + ''&SRN='' + eh.ShipmentRefNum + '')'' AS Edit,    aesh.ShipmentRefNum,     eh.Status,    OrderNumShip,    aesh.TransmissionDate,    aess.ResponseDate,    aesh.AESITN,    (SELECT TOP 1 NarrativeText FROM txdAESReply (NOLOCK) WHERE ID = aess.ID ORDER BY EffDate DESC) AS LastResponse,    1 AS NoOrder   FROM txdAESHeader aesh (NOLOCK)    JOIN txdExportHeader eh (NOLOCK)    ON aesh.ShipmentRefNum = eh.ShipmentRefNum     AND aesh.PartnerID = eh.PartnerID   JOIN txdAESTransactionStatus aess (NOLOCK)    ON aess.ShipmentRefNum = aesh.ShipmentRefNum     AND aess.PartnerID = aesh.PartnerID   WHERE    aesh.PartnerID = @PartnerID  ) AS LookupViewInner  WHERE                                  @whereclause@';

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

DECLARE @CurrentSQLGuid8 AS VARCHAR(36) = '94248d42-d1b0-4700-96e4-da8e4c1cb6fa';
DECLARE @CurrentSQLDescription8 AS NVARCHAR(500) = 'Export Lookup: AES Transmissions within the Last 7, 30, 90 Days';
DECLARE @CurrentSQLLongDescription8 AS NVARCHAR(MAX) = 'Displays AES transmissions made within the last 7, 30 or 90 days, as selected by the user in the dropdown';
DECLARE @CurrentSQLScript8 AS NVARCHAR(MAX) = 'SELECT * ,  ROW_NUMBER() OVER ( ORDER BY @orderby@) AS [RowNum]  FROM       (    SELECT DISTINCT    ''[''+ ''Edit'' + '']'' + ''(/Export/fidExportCISLI.aspx?TYPE='' + eh.RecordType + ''&ExportGuid=''+ CAST(eh.ExportGuid AS VARCHAR(50)) + '')'' AS Edit,    eh.ShipmentRefNum,    g.Decode AS Status,    aes.TransmissionDate AS ''AES Transmission Date'',    1 AS NoOrder   FROM txdExportHeader eh (NOLOCK)    JOIN txdAESHeader aes (NOLOCK)     ON eh.ShipmentRefNum = aes.ShipmentRefNum     AND eh.PartnerID = aes.PartnerID   LEFT JOIN tmgGlobalCodes g (NOLOCK)    ON g.PartnerID = eh.PartnerID    AND g.Code = eh.Status    AND g.FieldName = ''EXPORTSTATUS''   WHERE eh.RecordType = ''E''    AND eh.PartnerID = @PartnerID     AND aes.TransmissionDate >= DATEADD(day,-@VALUE@, GETDATE())     AND aes.TransmittedFlag = ''Y''  ) AS LookupViewInner  WHERE                                  @whereclause@';

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

DECLARE @CurrentSQLGuid9 AS VARCHAR(36) = 'ea5b9a8f-eb0c-4bce-9eba-3c0c65acdd96';
DECLARE @CurrentSQLDescription9 AS NVARCHAR(500) = 'Export Lookup: All AES Messages by ShipmentRefNum';
DECLARE @CurrentSQLLongDescription9 AS NVARCHAR(MAX) = 'Displays messages returned from AES by Shipment';
DECLARE @CurrentSQLScript9 AS NVARCHAR(MAX) = 'SELECT * ,  ROW_NUMBER() OVER ( ORDER BY @orderby@, ResponseDate DESC) AS [RowNum]  FROM       (    SELECT DISTINCT    ''[''+ ''Edit'' + '']'' + ''(/Export/fidAESTransmission.aspx?TYPE='' + eh.RecordType + ''&SRN='' + eh.ShipmentRefNum + '')'' AS Edit,    aesh.ShipmentRefNum,     eh.Status,    aesh.TransmissionDate,    aess.ResponseDate,    aesh.AESITN,    aesr.NarrativeText AS LastResponse,    1 AS NoOrder   FROM txdAESHeader aesh (NOLOCK)    JOIN txdExportHeader eh (NOLOCK)    ON aesh.ShipmentRefNum = eh.ShipmentRefNum     AND aesh.PartnerID = eh.PartnerID   JOIN txdAESTransactionStatus aess (NOLOCK)    ON aess.ShipmentRefNum = aesh.ShipmentRefNum     AND aess.PartnerID = aesh.PartnerID   JOIN txdAESReply aesr (NOLOCK)    ON aesr.ID = aess.ID    AND aesr.PartnerID = aess.PartnerID   WHERE    aesh.PartnerID = @PartnerID  ) AS LookupViewInner  WHERE                                  @whereclause@';

IF EXISTS (
		SELECT TOP 1 1
		FROM tbgSQLCommands WITH (NOLOCK)
		WHERE SQLGUID = CAST(@CurrentSQLGuid9 AS UNIQUEIDENTIFIER)
			AND SQLType = 'General SQL'
			AND Version = '20.4'
		)
BEGIN
	IF (
			SELECT Count(LongDescription)
			FROM (
				SELECT LongDescription
				FROM tbgSQLcommands WITH (NOLOCK)
				WHERE SQLGUID = CAST(@CurrentSQLGuid9 AS UNIQUEIDENTIFIER)
					AND Version = '20.4'
					AND SQLType = 'General SQL'
				
				UNION
				
				SELECT @CurrentSQLLongDescription9 AS LongDescription
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
