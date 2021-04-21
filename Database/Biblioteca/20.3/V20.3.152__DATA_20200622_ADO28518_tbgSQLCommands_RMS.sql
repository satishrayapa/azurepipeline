DECLARE @CurrentSQLGuid1 AS VARCHAR(36) = '28a23a57-3427-41b9-83ec-ea03b7869859';
DECLARE @CurrentSQLDescription1 AS NVARCHAR(500) = 'Classification Lookup: Products Missing Weight Standard';
DECLARE @CurrentSQLLongDescription1 AS NVARCHAR(MAX) = 'Displays all products missing weight values (net or gross)';
DECLARE @CurrentSQLScript1 AS NVARCHAR(MAX) = 'SELECT * ,    ROW_NUMBER() OVER ( ORDER BY @orderby@, ProductNum ) AS [RowNum]
            FROM                     (
SELECT ''['' + ''Edit'' + '']'' + ''(/Maintenance/Edit.aspx?ProductNum='' + xxpc.ProductNum + ''&ID='' + CAST (xxpc.ProductGuid AS VARCHAR(50)) + ''&TYPE=1&COUNTRY=US)'' AS Edit, 
xxpc.ProductNum
,xxpc.ProductDesc
,xxpc.GrossWeight
,xxpc.NetWeight,
1 AS NoOrder
FROM	tmdProductClassification pc WITH (NOLOCK)
JOIN	tmd@COUNTRY_CODE@ProductClassification xxpc WITH (NOLOCK) ON xxpc.PartnerID = pc.PartnerID AND
xxpc.ProductGuid = pc.ProductGuid
WHERE	xxpc.PartnerID = @PartnerID@ AND
ISNULL(xxpc.GrossWeight,0) = 0 OR
ISNULL(xxpc.NetWeight,0) = 0
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
