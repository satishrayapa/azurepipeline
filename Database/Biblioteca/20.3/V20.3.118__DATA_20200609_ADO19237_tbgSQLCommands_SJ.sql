DECLARE @CurrentSQLGuid1 AS VARCHAR(36) = '87df2899-c698-47a6-a6ee-9be24bbf932f';
DECLARE @CurrentSQLDescription1 AS NVARCHAR(500) = 'Solicitation: Past Due';
DECLARE @CurrentSQLLongDescription1 AS NVARCHAR(MAX) = 'Displays FTA, Supplier, and DueDate information for Solicitations that are overdue';
DECLARE @CurrentSQLScript1 AS NVARCHAR(MAX) = 
	'SELECT *  ,ROW_NUMBER() OVER (   ORDER BY DueDate    ,STATUS   ) AS [RowNum] FROM (  SELECT DISTINCT ''['' + ''View'' + ''](/FTA/Maintenance/fmgSolicitationManagement.aspx?id='' + dr.DocReqGuid + '')'' AS [View]   ,dr.Title   ,drd.CertAgreement AS ''FTA''   ,convert(VARCHAR, dr.DueDate, 1) AS DueDate   ,DATEDIFF(d, dr.duedate, getdate()) AS DaysOverdue   ,dr.STATUS   ,comp.CompanyName AS Supplier   ,1 AS NoOrder  FROM tmgDocRequest dr WITH (NOLOCK)  JOIN tmgDocRequestDetail drd WITH (NOLOCK) ON dr.PartnerID = drd.PartnerID   AND dr.DocReqGuid = drd.DocReqGuid  JOIN tmgCompany comp WITH (NOLOCK) ON drd.PartnerID = comp.PartnerID   AND replace(drd.Supplier, cast(drd.PartnerID AS VARCHAR) + ''~'', '''') = comp.CompanyID  WHERE dr.PartnerID = @PartnerID@   AND dr.DueDate < getdate()   AND STATUS IN (    ''Sent''    ,''Not Complete''    ,''Action Required''    )  GROUP BY comp.companyname   ,dr.docreqguid   ,dr.DueDate   ,dr.STATUS   ,dr.title   ,drd.CertAgreement   ,drd.Supplier   ,drd.PartnerID  ) AS LookupViewInner WHERE @whereclause@ '
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
