DECLARE @CurrentSQLGuid1 AS VARCHAR(36) = '7013fd15-076a-47ac-8b4f-f559214c45e1';
DECLARE @CurrentSQLDescription1 AS NVARCHAR(500) = 'Classification Lookup: Products with Non-Standard RptQtyUom';
DECLARE @CurrentSQLLongDescription1 AS NVARCHAR(MAX) = 'Displays products where RptQtyUOM is not in the list of Standard Reporting UOM defined in Global Codes';
DECLARE @CurrentSQLScript1 AS NVARCHAR(MAX) = 'SELECT *
	,ROW_NUMBER() OVER (
		ORDER BY @orderby@
		) AS [RowNum]
FROM   (
SELECT ''['' + ''Edit'' + '']'' + ''(/Maintenance/Edit.aspx?ProductNum='' + uspc.ProductNum + ''&ID='' + CAST (uspc.ProductGuid AS VARCHAR(50)) + ''&TYPE=1&COUNTRY=US)'' AS Edit, 
 uspc.ProductNum
		,ftz.HtsIndex
		,uspc.HsNum
		,hts.RptQtyUom
		,uspc.HsUomConvFactor
		,1 AS NoOrder
	FROM tmdUSProductClassification uspc WITH (NOLOCK)
	JOIN tmdUSProductClassificationFTZ ftz WITH (NOLOCK) ON uspc.ProductGuid = ftz.ProductGuid
		AND uspc.PartnerID = ftz.PartnerID
	JOIN tmdHTS hts WITH (NOLOCK) ON ftz.HtsIndex = hts.HtsIndex
		AND ftz.PartnerID = hts.PartnerID
	WHERE uspc.FTZActiveFlag = ''Y''
		AND hts.RptQtyUom NOT IN (
			SELECT Code
			FROM tmgGlobalCodes
			WHERE FieldName = ''StndRptQtyUom''
			)
		AND uspc.PartnerID = (
			SELECT PartnerID
			FROM tmfDefaults
			)
	) AS LookupViewInner
WHERE @whereclause@
';

IF EXISTS (
		SELECT TOP 1 1
		FROM tbgSQLCommands WITH (NOLOCK)
		WHERE SQLGUID = CAST(@CurrentSQLGuid1 AS UNIQUEIDENTIFIER)
			AND Version = '20.3'
			AND SQLType = 'General SQL'
		)
BEGIN
	IF (
			SELECT Count(LongDescription)
			FROM (
				SELECT LongDescription
				FROM tbgSQLcommands WITH (NOLOCK)
				WHERE SQLGUID = CAST(@CurrentSQLGuid1 AS UNIQUEIDENTIFIER)
					AND Version = '20.3'
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
			AND Version = '20.3'
			AND SQLType = 'General SQL';

		DELETE
		FROM tbgSQLCommands
		WHERE SQLGUID = CAST(@CurrentSQLGuid1 AS UNIQUEIDENTIFIER)
			AND Version = '20.3'
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
			,'20.3'
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
		,'20.3'
		,'N'
		,'N'
		);
END


