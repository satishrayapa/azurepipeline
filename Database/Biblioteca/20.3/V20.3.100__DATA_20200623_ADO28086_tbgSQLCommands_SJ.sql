DECLARE @CurrentSQLGuid1 AS VARCHAR(36) = '2bf48c36-3a3b-4228-a989-5e3a9a3223ed';
DECLARE @CurrentSQLDescription1 AS NVARCHAR(500) = 'DPS Lookup: DPS Lookup';
DECLARE @CurrentSQLLongDescription1 AS NVARCHAR(MAX) = 'Displays DPS status of all Companies/Partners in Company Maintenance';
DECLARE @CurrentSQLScript1 AS NVARCHAR(MAX) = 
	'SELECT * , ROW_NUMBER() OVER ( ORDER BY @orderby@, CompanyID desc )      AS [RowNum] FROM ( select      ''[''+ ''Edit'' + '']'' + ''(/Maintenance/fmgCompanyMaintenance.aspx?CompanyID='' + c.CompanyID + '')'' AS Edit,      ''['' + ''Search'' + '']'' + ''(/DTS/fxdDPSQuery.aspx?CompanyID='' + c.CompanyID +''&Search=Y)'' as Search,  c.CompanyID, c.CompanyID as ''CompanyAddressGUID'', c.CompanyType, c.DTSCompanyName, c.CompanyAddress1,     c.CompanyAddress2, c.CompanyCity, c.CompanyState, c.CompanyPostalCode, c.CompanyCountryCode,           c.DTSStatus, c.DTSLastScreenedDate, 1 AS NoOrder from tmgcompany c WITH (NOLOCK) where c.partnerid = @PartnerID       UNION         select      ''[''+ ''Edit'' + '']'' + ''(/Maintenance/fmgCompanyMaintenance.aspx?CompanyID='' + a.CompanyID + '')'' AS Edit,      ''['' + ''Search'' + '']'' + ''(/DTS/fxdDPSQuery.aspx?CompanyID='' + a.CompanyID +''&Search=Y)'' as Search,      a.CompanyID, a.CompanyAddressGUID, ''Secondary Address'' as CompanyType, a.DTSCompanyName, a.CompanyAddress1,     a.CompanyAddress2, a.CompanyCity, a.CompanyState, a.CompanyPostalCode, a.CompanyCountryCode,           a.DTSStatus, a.DTSLastScreenedDate, 1 AS NoOrder from tmgcompanyAddress a WITH (NOLOCK) where a.partnerid = @PartnerID        AND a.dtsstatus IN (''Blocked'', ''Manual Block'')     )     AS LookupViewInner WHERE @whereclause@ '
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
