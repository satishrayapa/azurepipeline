DECLARE @CurrentSQLGuid1 AS VARCHAR(36) = 'da986e44-a197-4939-bf02-ca9330e1dfb1';
DECLARE @CurrentSQLDescription1 AS NVARCHAR(500) = 'Classification Lookup: Products With Invalid HsNum';
DECLARE @CurrentSQLLongDescription1 AS NVARCHAR(MAX) = 'Displays products with Invalid HS Numbers';
DECLARE @CurrentSQLScript1 AS NVARCHAR(MAX) = 'SELECT * ,    ROW_NUMBER() OVER ( ORDER BY @orderby@, ProductNum ) AS [RowNum]
            FROM                  ( SELECT	''['' + ''Edit'' + '']'' + ''(/Maintenance/Edit.aspx?ProductNum='' + xxpc.ProductNum + ''&ID='' + CAST  (xxpc.ProductGuid AS VARCHAR(50)) + ''&TYPE=1&COUNTRY=@COUNTRY_CODE@))'' AS Edit
	   ,xxpc.ProductNum
	   ,xxpc.ProductDesc
	   ,xxpc.ProductMaterial
	   ,xxpc.ProductTypeCode
	   ,xxpc.HsNum
	   ,cm.message AS ValidationMessage
	   ,xxpc.CountryofOrigin
	   ,xxpc.ManufacturerID
	   ,xxpc.ActiveFlag,
1 AS NoOrder
FROM	tmdProductClassification pc WITH (NOLOCK)
JOIN	tmd@COUNTRY_CODE@ProductClassification xxpc WITH (NOLOCK) ON xxpc.PartnerID = pc.PartnerID AND
																	 xxpc.ProductGuid = pc.ProductGuid
JOIN	tmdclassificationmessages cm WITH (NOLOCK) ON xxpc.PartnerID = cm.PartnerID AND
													  xxpc.ProductGuid = cm.ProductGuid AND
													  cm.countrycode = ''@COUNTRY_CODE@''
WHERE	xxpc.PartnerID = @PartnerID@ AND
		cm.fieldname IN (''hsnum'',''hsnum2'')
) AS LookupViewInner
            WHERE                               @whereclause@';

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



