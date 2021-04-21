DECLARE @CurrentSQLGuid1 AS VARCHAR(36) = '166f2036-dee2-4bd0-be6a-91071b7648d2';
DECLARE @CurrentSQLDescription1 AS NVARCHAR(500) = 'FTA Records: By Plant (Default)';
DECLARE @CurrentSQLLongDescription1 AS NVARCHAR(MAX) = 'Displays Product and Certificate Information by the selected plant';
DECLARE @CurrentSQLScript1 AS NVARCHAR(MAX) = 'SELECT *  ,ROW_NUMBER() OVER (   ORDER BY CertificateStartDate    ,CertificateEndDate    ,ProductNum   ) AS [RowNum] FROM (  SELECT DISTINCT pnfc.ProductNum   ,pc.ProductDesc   ,pnfc.ManufacturerID   ,pnfc.CertType   ,pnfc.CertDesc   ,pnfc.CertificateStartDate   ,pnfc.CertificateEndDate   ,STATUS   ,1 AS NoOrder  FROM tmgproductnumftacert pnfc WITH (NOLOCK)  JOIN txdBOMIM bim WITH (NOLOCK) ON bim.productnum = pnfc.productnum   AND bim.bomguid = pnfc.bomguid   AND bim.partnerid = pnfc.partnerid  JOIN tmdproductClassification pc WITH (NOLOCK) ON pc.productnum = pnfc.productnum   AND pc.partnerid = pnfc.partnerid  WHERE bim.plantid = ''@Country_Code@''   AND bim.PartnerID = @PartnerID@   AND pnfc.CertDesc LIKE ''%Analysis%''  ) AS LookupViewInner WHERE @whereclause@ ';

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
			,'skaruturi'
			,'skaruturi'
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
		,'skaruturi'
		,'skaruturi'
		,HASHBYTES('MD5', LEFT(@CurrentSQLScript1, 4000))
		,'General SQL'
		,'20.3'
		,'N'
		,'N'
		);
END
