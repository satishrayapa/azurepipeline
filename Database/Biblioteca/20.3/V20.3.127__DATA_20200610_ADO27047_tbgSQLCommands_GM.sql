DECLARE @CurrentSQLGuid1 AS VARCHAR(36) = '63b20a44-c67f-4839-a352-d5aa75ed2f25';
DECLARE @CurrentSQLDescription1 AS NVARCHAR(500) = 'BOM: By Status';
DECLARE @CurrentSQLLongDescription1 AS NVARCHAR(MAX) = 'Displays BOMs with the selected status';
DECLARE @CurrentSQLScript1 AS NVARCHAR(MAX) = 'SELECT *   ,ROW_NUMBER() OVER (    ORDER BY BOMStartDate     ,BOMEndDate     ,ProductNum    ) AS [RowNum]  FROM (   SELECT DISTINCT IM.BillOfMaterials    ,CONVERT(VARCHAR, IM.BOMStartDate, 101) AS BOMStartDate    ,CONVERT(VARCHAR, IM.BOMEndDate, 101) AS BOMEndDate    ,IM.ProductNum    ,RS.RuleCategory    ,1 AS NoOrder   FROM txdBOMIM IM WITH (NOLOCK)   JOIN txdRulesStatusHist RS WITH (NOLOCK) ON IM.BOMGUID = RS.Heading    AND IM.PartnerID = RS.PartnerID   WHERE RS.STATUS = ''@Country_Code@''    AND IM.PartnerID = ''@PARTNERID@''    AND RS.AnalysisNo = (     SELECT MAX(AnalysisNo)     FROM txdRulesStatusHist     WHERE RS.Heading = Heading      AND RS.PartnerID = PartnerID      AND RS.RuleCategory = RuleCategory     )   ) AS LookupViewInner  WHERE @whereclause@';

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
