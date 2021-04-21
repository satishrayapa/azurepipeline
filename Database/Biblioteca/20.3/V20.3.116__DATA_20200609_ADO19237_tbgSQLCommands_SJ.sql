DECLARE @CurrentSQLGuid1 AS VARCHAR(36) = 'cd4319f7-69f9-48aa-9b45-278a2c0e13f1';
DECLARE @CurrentSQLDescription1 AS NVARCHAR(500) = 'FTA Solicitation Lookup: Active Solicitations';
DECLARE @CurrentSQLLongDescription1 AS NVARCHAR(MAX) = 'Displays solicitations which are currently active.';
DECLARE @CurrentSQLScript1 AS NVARCHAR(MAX) = 
	'SELECT * ,    ROW_NUMBER() OVER ( ORDER BY Status, SolicitationYear, DateSent, DueDate ) AS [RowNum]             FROM                  ( select Distinct  ''['' + dr.Title + ''](/FTA/Maintenance/fmgSolicitationManagement.aspx?id='' + dr.DocReqGuid + '')'' as Title,   Status,   year(dr.PeriodBeginDate) as ''SolicitationYear'',   convert (varchar,dr.DateSent,101) as ''DateSent'',   convert (varchar,dr.DueDate, 101) as ''DueDate'',  ''['' + comp.CompanyName + ''](/FTA/Maintenance/fmgSupplierDashboard.aspx?SUPP='' + replace(drd.Supplier, cast(drd.PartnerID as varchar) + ''~'', '''') + '')'' as Supplier, 1 AS NoOrder  from tmgDocRequest dr WITH (NOLOCK)   join tmgdocrequestdetail drd WITH (NOLOCK) on  dr.DocReqGUID = drd.DocReqGUID and  dr.PartnerID = drd.PartnerID  join tmgCompany comp WITH (NOLOCK) on  drd.PartnerID = comp.PartnerID and  replace(drd.Supplier, cast(drd.PartnerID as varchar) + ''~'', '''') = comp.CompanyID   where dr.PartnerID = @PartnerID@  and status not in (''Final'', ''Archived'', ''Complete'') ) AS LookupViewInner WHERE                                         @whereclause@'
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
