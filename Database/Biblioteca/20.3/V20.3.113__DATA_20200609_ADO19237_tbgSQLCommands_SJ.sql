DECLARE @CurrentSQLGuid1 AS VARCHAR(36) = 'acd775e0-a3c7-46c3-bbd3-8431d1671066';
DECLARE @CurrentSQLDescription1 AS NVARCHAR(500) = 'BOM: Components Due to Expire';
DECLARE @CurrentSQLLongDescription1 AS NVARCHAR(MAX) = 'Displays product and certificate information for certificates that expire within the next 90 days';
DECLARE @CurrentSQLScript1 AS NVARCHAR(MAX) = 
	'SELECT * ,    ROW_NUMBER() OVER ( ORDER BY CertificateStartDate, CertificateEndDate, ProductNum ) AS [RowNum]             FROM                  ( select distinct  ''['' + ''View'' + ''](/Interfaces/fidBOMAnalysisUpload.aspx?BOM='' + IM.BOMGUID + '')'' as [View],  im.BillOfMaterials,                  cert.ProductNum,  cert.ManufacturerID,   convert(varchar, cert.CertificateStartDate, 103) as CertificateStartDate,   convert(varchar, cert.CertificateEndDate, 103) as CertificateEndDate,  cert.CertType as Agreement,  cert.CertDesc, 1 AS NoOrder  from tmgProductNumFTACert cert with (nolock)  join txdBOMPC bom with (nolock)   on cert.PartnerID = bom.PartnerID   and cert.productnum = bom.productnum     and cert.ManufacturerId = bom.ManufacturerId join txdBOMIM IM with (nolock)   on im.PartnerID = bom.PartnerID   and im.BOMGuid = bom.BOMGuid  where cert.CertificateEndDate < GetDate() + 90 and year(cert.certificatestartdate) = year(im.bomstartdate) and year(im.bomstartdate) = year(getdate()) and cert.PartnerID=@Partnerid@               ) AS LookupViewInner WHERE                                         @whereclause@'
	;

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
			,'sjallepalli'
			,'sjallepalli'
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
		,'sjallepalli'
		,'sjallepalli'
		,HASHBYTES('MD5', LEFT(@CurrentSQLScript1, 4000))
		,'General SQL'
		,'20.3'
		,'N'
		,'N'
		);
END
