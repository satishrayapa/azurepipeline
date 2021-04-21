DECLARE @CurrentSQLGuid1 AS VARCHAR(36) = '1e0d0bb2-730b-418a-8a61-ab8b4a7e435c';
DECLARE @CurrentSQLDescription1 AS NVARCHAR(500) = 'DPS Lookup: Clear Parties';
DECLARE @CurrentSQLLongDescription1 AS NVARCHAR(MAX) = 'Displays all parties that have a status of Clear';
DECLARE @CurrentSQLScript1 AS NVARCHAR(MAX) = 
	'SELECT *  ,ROW_NUMBER() OVER (   ORDER BY @orderby@   ) AS [RowNum] FROM (  SELECT ''['' + ''Edit'' + '']'' + ''(/Maintenance/fmgCompanyMaintenance.aspx?CompanyID='' + comp.CompanyID + '')'' AS Edit   ,ISNULL(''[Search](/DTS/fxdDPSQuery.aspx?CompanyID='' + comp.CompanyID + '')'', '''') AS Search   ,ISNULL(g.Decode, comp.CompanyType) AS CompanyType   ,comp.CompanyID   ,comp.DTSStatus   ,comp.CompanyName   ,comp.CompanyCountryCode   ,comp.DTSLastScreenedDate AS LastScreenedDate   ,1 AS NoOrder  FROM tmgCompany comp(NOLOCK)  LEFT JOIN tmgGlobalCodes g(NOLOCK) ON g.partnerid = comp.partnerid   AND g.code = comp.CompanyType   AND g.fieldname = ''CompanyType''  WHERE comp.DTSStatus = ''Clear''   AND DTSSearchFlag = ''Y''   AND comp.PartnerID = @PartnerID  ) AS LookupViewInner WHERE @whereclause@'
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
			,'svadlamani'
			,'svadlamani'
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
			,'svadlamani'
			,'svadlamani'
			,HASHBYTES('MD5', LEFT(@CurrentSQLScript1, 4000))
			,'General SQL'
			,'20.3'
			,'N'
			,'N'
			);
	END

