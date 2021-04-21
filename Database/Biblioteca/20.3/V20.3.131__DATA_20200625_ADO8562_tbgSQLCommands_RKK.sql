DECLARE @CurrentSQLGuid1 AS VARCHAR(36) = '08d79e1d-5020-4f23-a021-49c2bdc3cc7f';
DECLARE @CurrentSQLDescription1 AS NVARCHAR(500) = 'Company Partners / DPS Spreadsheet Upload - Update usrTable';
DECLARE @CurrentSQLLongDescription1 AS NVARCHAR(MAX) = 'Company Partners / DPS Spreadsheet Upload - Update usrTable';
DECLARE @CurrentSQLScript1 AS NVARCHAR(MAX) = 'UPDATE usrCompanyUpload SET COMPN01 = 0 WHERE COMPN01 = '''' and PartnerID = @PartnerID UPDATE usrCompanyUpload SET COMPN02 = 0 WHERE COMPN02 = '''' and PartnerID = @PartnerID UPDATE usrCompanyUpload SET COMPN03 = 0 WHERE COMPN03 = '''' and PartnerID = @PartnerID  UPDATE usrCompanyUpload SET COMPN04 = 0 WHERE COMPN04 = '''' and PartnerID = @PartnerID UPDATE usrCompanyUpload SET COMPN05 = 0 WHERE COMPN05 = '''' and PartnerID = @PartnerID';

IF EXISTS (
		SELECT TOP 1 1
		FROM tbgSQLCommands WITH (NOLOCK)
		WHERE SQLGUID = CAST(@CurrentSQLGuid1 AS UNIQUEIDENTIFIER)
			AND Version = '20.3'
			AND SQLType = 'BPM Standard SQL'
		)
BEGIN
	IF (
			SELECT Count(SQLhash)
			FROM (
				SELECT SQLhash
				FROM tbgSQLcommands WITH (NOLOCK)
				WHERE SQLGUID = CAST(@CurrentSQLGuid1 AS UNIQUEIDENTIFIER)
					AND Version = '20.3'
					AND SQLType = 'BPM Standard SQL'
				
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
			AND SQLType = 'BPM Standard SQL';

		DELETE
		FROM tbgSQLCommands
		WHERE SQLGUID = CAST(@CurrentSQLGuid1 AS UNIQUEIDENTIFIER)
			AND Version = '20.3'
			AND SQLType = 'BPM Standard SQL';

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
			,'rkeswani'
			,'JCapobianco'
			,HASHBYTES('MD5', LEFT(@CurrentSQLScript1, 4000))
			,'BPM Standard SQL'
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
		,'rkeswani'
		,'JCapobianco'
		,HASHBYTES('MD5', LEFT(@CurrentSQLScript1, 4000))
		,'BPM Standard SQL'
		,'20.3'
		,'N'
		,'N'
		);
END

