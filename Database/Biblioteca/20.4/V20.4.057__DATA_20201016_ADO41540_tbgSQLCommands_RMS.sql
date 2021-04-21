SET XACT_ABORT ON;
BEGIN TRANSACTION;

SET IDENTITY_INSERT dbo.tbgSQLCommandsHist OFF;
GO
DECLARE @CurrentSQLGuid6 AS VARCHAR(36) = 'c66b01f4-2662-4728-a000-687495fb2e02';
DECLARE @CurrentSQLDescription6 AS NVARCHAR(500) = 'Shipments With Products Not In Global Classification';
DECLARE @CurrentSQLLongDescription6 AS NVARCHAR(MAX) = 'Displays the shipments that contain products which are not stored in Global Classification.';
DECLARE @CurrentSQLScript6 AS NVARCHAR(MAX) = 
	'SELECT * ,  ROW_NUMBER() OVER ( ORDER BY @orderby@ ) AS [RowNum]  FROM       (    SELECT DISTINCT    ''[Edit]'' + ''(/Export/fidExportCISLI.aspx?TYPE='' + eh.RecordType + ''&ExportGUID=''+ eh.ExportGUID + '')'' AS Edit,    eh.OrderNumShip,     ISNULL(g.Decode, eh.Status) as Status,      eh.ExportDate,     eh.ShipDate,     eh.ExportCountry,     eh.ImportCountry,    1 AS NoOrder   FROM txdExportHeader eh (NOLOCK)    JOIN txdExportDetail ed (NOLOCK)    ON ed.ExportGUID = eh.ExportGUID    AND ed.PartnerID = eh.PartnerID    LEFT JOIN tmgGlobalCodes g (NOLOCK)    ON g.PartnerID = eh.PartnerID    AND g.Code = eh.Status    AND g.FieldName = ''EXPORTSTATUS''   LEFT JOIN tmdProductClassification pc (NOLOCK)    ON pc.PartnerID = eh.PartnerID    AND pc.ProductNum = ed.ProductNum   WHERE eh.Status = ''H''    AND eh.RecordType = ''E''    AND eh.PartnerID = @PartnerID    /*AND eh.ExportCountry = ''@Country_Code@''     AND pc.PartnerID IS NULL*/  ) AS LookupViewInner  WHERE                                  @whereclause@'
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

SET IDENTITY_INSERT dbo.tbgSQLCommandsHist ON;
GO	

COMMIT TRANSACTION
SET XACT_ABORT OFF;