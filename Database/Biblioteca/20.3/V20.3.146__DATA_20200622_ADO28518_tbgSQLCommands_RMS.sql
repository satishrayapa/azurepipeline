DECLARE @CurrentSQLGuid1 AS VARCHAR(36) = '7a3bc757-a00e-45a8-8354-33cb31bf5e72';
DECLARE @CurrentSQLDescription1 AS NVARCHAR(500) = 'Classification Lookup: Classification Lookup Standard Countries';
DECLARE @CurrentSQLLongDescription1 AS NVARCHAR(MAX) = 'Displays all Products in the selected country profile';
DECLARE @CurrentSQLScript1 AS NVARCHAR(MAX) = 'SELECT * ,	 ROW_NUMBER() OVER ( ORDER BY	 @orderby@ ) AS [RowNum] FROM ( 
      SELECT
	 ''['' + ''Edit'' + '']'' + ''(/Maintenance/Edit.aspx?ProductNum='' + xxpc.ProductNum + ''&ID='' + CAST (xxpc.ProductGuid AS VARCHAR(50)) + ''&TYPE=1&COUNTRY=@COUNTRY_CODE@)'' AS Edit 
,	 xxpc.ProductGuid,
	 xxpc.ProductNum,
	 xxpc.ProductDesc,
	 xxpc.HsNum,
	 pc.HSNum as GlobalHSNum,
	 pc.ProductName,
	 pc.SupplierID,
	 pc.ManufacturerID,
	 pc.BusinessUnit,
	 pc.BusinessDivision,
	 pc.ProductGroup,
	 pc.ProductTypeCode,
	 pc.TaxID,
	 pc.Notes,
	 pc.ProductMaterial,
	 pc.NetWeight,
	 pc.GrossWeight,
	 pc.WeightUOM,
	 pc.TxnQtyUOM ,pc.HsInProgress,
	 pc.AssuranceLevel,
	 pc.HSRationale,pc.GRI,
	 pc.BindingRuling,
	 pc.ECNNum,
	 pc.CountryOfOrigin,
	 1 AS NoOrder 
FROM
	 tmd@COUNTRY_CODE@ProductClassification xxpc (nolock) 
JOIN
	 tmdProductClassification pc 
ON
	 xxpc.PartnerID = pc.PartnerID and xxpc.ProductGuid = pc.ProductGuid 
WHERE
	 xxpc.PartnerID = @PartnerID 
GROUP BY
	 xxpc.PartnerID,
	 xxpc.ProductGuid,
	 xxpc.ProductNum,
	 xxpc.ProductDesc,
	 xxpc.HsNum,
	 xxpc.ModifiedBy,
	 pc.HSNum,
	 pc.ProductName,
	 pc.SupplierID,
	 pc.ManufacturerID,
	 pc.BusinessUnit,
	 pc.BusinessDivision,
	 pc.ProductGroup,
	 pc.ProductTypeCode,
	 pc.TaxID,
	 pc.Notes,
	 pc.ProductMaterial,
	 pc.NetWeight,
	 pc.GrossWeight,
	 pc.WeightUOM,
	 pc.TxnQtyUOM ,pc.HsInProgress,
	 pc.AssuranceLevel,
	 pc.HSRationale,pc.GRI,
	 pc.BindingRuling,
	 pc.ECNNum,
	 pc.CountryOfOrigin ) AS LookupViewInner 
WHERE
	 @whereclause@ ';

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