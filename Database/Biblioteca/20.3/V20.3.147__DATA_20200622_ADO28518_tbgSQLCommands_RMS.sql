DECLARE @CurrentSQLGuid1 AS VARCHAR(36) = '497c7e34-2487-4ac6-9065-c47dcde11104';
DECLARE @CurrentSQLDescription1 AS NVARCHAR(500) = 'Audit Log Lookup: Audit Log Lookup';
DECLARE @CurrentSQLLongDescription1 AS NVARCHAR(MAX) = 'Displays changes done by users relating to product classifications within the selected country profile';
DECLARE @CurrentSQLScript1 AS NVARCHAR(MAX) = 
	'SELECT * ,
							ROW_NUMBER() OVER ( ORDER BY @orderby@, ModifyDate desc ) AS [RowNum]
							FROM    
    (
SELECT ''['' + ''Edit'' + '']'' + ''(/Maintenance/Edit.aspx?ProductNum='' + xxpc.ProductNum + ''&ID='' + CAST (xxpc.ProductGuid AS VARCHAR(50)) + ''&TYPE=1&COUNTRY=US)'' AS Edit, 
										xxpc.ProductGuid, 
										xxpc.ProductNum, 
										xxpc.ProductDesc, 
										al.UserName, 
										al.LogEntry, 
										al.EffDate as ModifyDate,
										1 AS NoOrder
									from tmd@COUNTRY_CODE@ProductClassification xxpc (nolock)
									join tmdProductClassification pc (nolock) on 
										xxpc.PartnerID = pc.PartnerID and
										xxpc.ProductGuid = pc.ProductGuid
									left join tmdAuditLog al (nolock) on 
										xxpc.PartnerID = al.PartnerID and
										xxpc.ProductGuid = al.ProductGuid and
										al.CountryCode = ''@COUNTRY_CODE@''
									where
										xxpc.PartnerID = @PartnerID
								) AS LookupViewInner
								WHERE                               
									@whereclause@'
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
