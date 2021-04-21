DECLARE @CurrentSQLGuid1 AS VARCHAR(36) = 'ba648465-efc4-464c-a1b2-382ba3ebb46c';
DECLARE @CurrentSQLDescription1 AS NVARCHAR(500) = 'Certificate Lookup: Certificates Due to Expire';
DECLARE @CurrentSQLLongDescription1 AS NVARCHAR(MAX) = 'Displays certificates  are due to expire in 90 days or less';
DECLARE @CurrentSQLScript1 AS NVARCHAR(MAX) = 
	'SELECT *
	,ROW_NUMBER() OVER (
		ORDER BY CertificateStartDate
			,CertificateEndDate
			,ProductNum
		) AS [RowNum]
FROM (
	SELECT DISTINCT cert.ProductNum
		,cert.ManufacturerID
		,convert(VARCHAR, cert.CertificateStartDate, 103) AS CertificateStartDate
		,convert(VARCHAR, cert.CertificateEndDate, 103) AS CertificateEndDate
		,cert.CertType AS Agreement
		,cert.CertDesc
		,1 AS NoOrder
	FROM tmgProductNumFTACert cert WITH (NOLOCK)
	WHERE cert.CertificateEndDate < GetDate() + 90
		AND cert.CertDesc = ''FTA Analysis''
		AND PartnerId = @PartnerID@
		AND cert.STATUS = ''Active''
		AND cert.certguid = (
			SELECT TOP 1 certguid
			FROM tmgProductNumFTACert
			WHERE cert.ProductNum = ProductNum
				AND cert.CertificateStartDate = CertificateStartDate
				AND cert.CertificateEndDate = CertificateEndDate
				AND cert.CertType = CertType
				AND cert.ManufacturerID = ManufacturerID
			ORDER BY effdate DESC
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
