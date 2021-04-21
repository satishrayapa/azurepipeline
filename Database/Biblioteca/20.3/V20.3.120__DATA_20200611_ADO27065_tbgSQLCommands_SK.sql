DECLARE @CurrentSQLGuid1 AS VARCHAR(36) = '5c28fed1-5a35-4d65-a032-4a95b76662a5';
DECLARE @CurrentSQLDescription1 AS NVARCHAR(500) = 'Solicitation Lookup: Solicitations with New Comments';
DECLARE @CurrentSQLLongDescription1 AS NVARCHAR(MAX) = 'Displays Supplier and FTA information for solicitations with comments added or changed within the last month';
DECLARE @CurrentSQLScript1 AS NVARCHAR(MAX) = 'SELECT * ,    ROW_NUMBER() OVER ( ORDER BY DateSent, EffDate, Status ) AS [RowNum]             FROM                  ( SELECT ''['' + ''View'' + ''](/FTA/Maintenance/fmgSolicitationManagement.aspx?id='' + dr.DocReqGuid + '')'' as [View], dr.Title, DR.DateSent, dc.Effdate, drd.CertAgreement as ''FTA'', DR.Status, DC.Comment, Comp.CompanyName as Supplier, 1 AS NoOrder FROM tmgdocrequest DR WITH (NOLOCK)  join tmgdocrequestdetail drd WITH (NOLOCK)  on drd.DocReqGUID = dr.DocReqGUID and drd.PartnerID = dr.PartnerID JOIN tmgCompany comp WITH (NOLOCK)  on comp.CompanyID = Right(Drd.Supplier,( len(drd.Supplier) - Charindex(''~'',drd.Supplier))) JOIN tmgDocRequestComments dc WITH (NOLOCK) on dc.DocReqGUID = dr.DocReqGUID and dr.PartnerID = dc.PartnerID WHERE dc.EffDate BETWEEN DateAdd(d,-30,GETDATE()) AND GETDATE()  and  dr.PartnerID = @PartnerID@ ) AS LookupViewInner WHERE                                         @whereclause@';

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
