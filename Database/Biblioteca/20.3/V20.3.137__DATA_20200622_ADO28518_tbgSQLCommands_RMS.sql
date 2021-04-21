DECLARE @CurrentSQLGuid1 AS VARCHAR(36) = 'cca6d524-7383-4dff-8e7c-7cb4f70332fa';
DECLARE @CurrentSQLDescription1 AS NVARCHAR(500) = 'Classification Lookup: Products with ECN non-EAR99 Standard';
DECLARE @CurrentSQLLongDescription1 AS NVARCHAR(MAX) = 'Displays products in the selected country where the ECN Number is not EAR99';
DECLARE @CurrentSQLScript1 AS NVARCHAR(MAX) = 'SELECT * ,
ROW_NUMBER() OVER ( ORDER BY @orderby@ ) AS [RowNum]
FROM 
(
SELECT ''['' + ''Edit'' + '']'' + ''(/Maintenance/Edit.aspx?ProductNum='' + xxpc.ProductNum + ''&ID='' + CAST (xxpc.ProductGuid AS VARCHAR(50)) + ''&TYPE=1&COUNTRY=US)'' AS Edit, 
xxpc.ProductNum,
xxpc.ProductDesc,
xxpc.BusinessDivision,
xxpc.SupplierID,
xxpc.CountryOfOrigin,
xxpc.HsNum,
xxpc.AssuranceLevel,
xxpc.ECNNum,
1 AS NoOrder
FROM	tmdProductClassification pc WITH (NOLOCK)
JOIN	tmd@Country_Code@ProductClassification xxpc WITH (NOLOCK) ON xxpc.PartnerID = pc.PartnerID AND
										 xxpc.ProductGuid = pc.ProductGuid
WHERE	xxpc.ECNNum <> ''EAR99'' AND
xxpc.PartnerID = @PartnerID@
) AS LookupViewInner
WHERE                               
	@whereclause@';

IF EXISTS (
		SELECT TOP 1 1
		FROM tbgSQLCommands WITH (NOLOCK)
		WHERE SQLGUID = CAST(@CurrentSQLGuid1 AS UNIQUEIDENTIFIER)
			AND Version = '20.3'
			AND SQLType = 'General SQL'
		)
BEGIN
	IF (
			SELECT Count(SQLhash)
			FROM (
				SELECT SQLhash
				FROM tbgSQLcommands WITH (NOLOCK)
				WHERE SQLGUID = CAST(@CurrentSQLGuid1 AS UNIQUEIDENTIFIER)
					AND Version = '20.3'
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
