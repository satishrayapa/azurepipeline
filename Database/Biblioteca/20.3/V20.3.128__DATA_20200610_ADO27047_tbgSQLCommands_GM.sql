DECLARE @CurrentSQLGuid1 AS VARCHAR(36) = '6844ff79-1e52-4a2d-ad5f-8051d0fe3c34';
DECLARE @CurrentSQLDescription1 AS NVARCHAR(500) = 'BOM Lookup: BOMs Without Analysis';
DECLARE @CurrentSQLLongDescription1 AS NVARCHAR(MAX) = 'BOMs that have not yet been analyzed';
DECLARE @CurrentSQLScript1 AS NVARCHAR(MAX) = 'SELECT *   ,ROW_NUMBER() OVER (    ORDER BY BOMStartDate     ,BOMEndDate     ,ProductNum    ) AS [RowNum]  FROM (   SELECT DISTINCT bim.BillOfMaterials    ,bim.ProductNum    ,pc.ProductDesc    ,bim.BOMStartDate    ,bim.BOMEndDate    ,bim.Value    ,bim.CommercialValue    ,bim.Weight    ,bim.HTSNum    ,bim.CountryOfOrigin    ,bim.CountryOfManufacture    ,1 AS NoOrder   FROM txdBOMIM bim WITH (NOLOCK)   JOIN tmdProductClassification pc WITH (NOLOCK) ON pc.PartnerID = bim.PartnerID    AND pc.ProductNum = bim.ProductNum   WHERE bim.ProcessFlag = ''Y''    AND NOT EXISTS (     SELECT bh.BOMGUID     FROM txdBOMIMHist bh WITH (NOLOCK)     WHERE bh.PartnerID = ''@PARTNERID@''      AND bh.BOMGUID = bim.BOMGUID     )    AND bim.PartnerID = ''@PARTNERID@''   ) AS LookupViewInner  WHERE @whereclause@  ';

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
			,'gmghebrishvili'
			,'gmghebrishvili'
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
		,'gmghebrishvili'
		,'gmghebrishvili'
		,HASHBYTES('MD5', LEFT(@CurrentSQLScript1, 4000))
		,'General SQL'
		,'20.3'
		,'N'
		,'N'
		);
END
