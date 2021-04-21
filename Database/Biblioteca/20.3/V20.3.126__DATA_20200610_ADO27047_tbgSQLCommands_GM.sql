DECLARE @CurrentSQLGuid1 AS VARCHAR(36) = '0233f2be-d0c5-40b5-9b52-63d209145f8a';
DECLARE @CurrentSQLDescription1 AS NVARCHAR(500) = 'BOM: Missing Info';
DECLARE @CurrentSQLLongDescription1 AS NVARCHAR(MAX) = 'BOMs with missing HTS, Manufacturer ID, Country of Origin, or Country of Manufacture information';
DECLARE @CurrentSQLScript1 AS NVARCHAR(MAX) = 'SELECT *   ,ROW_NUMBER() OVER (    ORDER BY BOMStartDate     ,BOMEndDate     ,ProductNum    ) AS [RowNum]  FROM (   SELECT DISTINCT ''['' + ''View'' + ''](/Interfaces/fidBOMAnalysisUpload.aspx?BOM='' + IM.BOMGUID + '')'' AS [View]    ,BillOfMaterials AS Name    ,Convert(VARCHAR, BOMStartDate, 101) AS BOMStartDate    ,Convert(VARCHAR, BOMEndDate, 101) AS BOMEndDate    ,IM.ProductNum AS ProductNum    ,1 AS NoOrder   FROM dbo.txdBOMIM IM WITH (NOLOCK)   INNER JOIN dbo.txdBOMPC PC WITH (NOLOCK) ON IM.BOMGUID = PC.BOMGUID    AND IM.PartnerId = PC.PartnerId   WHERE (     PC.HTSNum = ''''     OR PC.ManufacturerID = ''''     OR PC.CountryofOrigin = ''''     OR IM.CountryofManufacture = ''''     )    AND PC.PartnerID = @PartnerID@    AND IM.BOMType = ''FTA''    AND IM.Processflag = ''Y''   ) AS LookupViewInner  WHERE @whereclause@  ';

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
