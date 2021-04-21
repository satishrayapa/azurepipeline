DECLARE @CurrentSQLGuid1 AS VARCHAR(36) = 'f62c8dcb-b571-4835-ab8f-7e1797f0c22b';
DECLARE @CurrentSQLDescription1 AS NVARCHAR(500) = 'DPS Lookup: Hits per Company Partner';
DECLARE @CurrentSQLLongDescription1 AS NVARCHAR(MAX) = 'Displays the number of hits returned on each company partner based on their last screened date';
DECLARE @CurrentSQLScript1 AS NVARCHAR(MAX) = 'SELECT * , ROW_NUMBER() OVER ( ORDER BY @orderby@, NumHits)  AS [RowNum] FROM (  SELECT  ''[''+ ''Edit'' + '']'' + ''(/Maintenance/fmgCompanyMaintenance.aspx?CompanyID='' + c.CompanyID + '')'' AS Edit,     ''['' + ''Search'' + '']'' + ''(/DTS/fxdDPSQuery.aspx?CompanyID='' + c.CompanyID +''&Search=Y)'' as Search,             MAX(convert(datetime, c.DTSLastScreenedDate, 101)) as LastScreenedDate, c.CompanyID, c.CompanyName, c.CompanyCity, C.CompanyState,           c.CompanyCountry, SUM(h.NumHits) AS NumHits, 1 AS NoOrder  FROM txdDTSSearchResultsHist h WITH (NOLOCK)  INNER JOIN tmgCompany c WITH (NOLOCK) ON    c.CompanyID = h.CompanyID    --AND c.DTSLastScreenedDate = h.EffDate    AND c.PartnerID = h.PartnerId  WHERE    h.PartnerId = (SELECT PartnerID FROM tmfDefaults)   AND h.EffDate > (GETDATE() - @VALUE@)  GROUP BY c.CompanyID, c.CompanyName, c.CompanyCity, c.CompanyState, c.CompanyCountry  ) AS LookupViewInner WHERE @WhereClause@';

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
