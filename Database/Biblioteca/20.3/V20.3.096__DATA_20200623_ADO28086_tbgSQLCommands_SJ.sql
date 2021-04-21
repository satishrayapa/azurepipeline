DECLARE @CurrentSQLGuid1 AS VARCHAR(36) = '8b178c2d-de65-4a5f-89bd-e1d18a87b476';
DECLARE @CurrentSQLDescription1 AS NVARCHAR(500) = 'DPS Lookup: Companies Screened in the past 7,30,90 days';
DECLARE @CurrentSQLLongDescription1 AS NVARCHAR(MAX) = 'Displays all companies that have been screened in the past 7, 30 or 90 days, as the user selects';
DECLARE @CurrentSQLScript1 AS NVARCHAR(MAX) = 
	'SELECT * ,  ROW_NUMBER() OVER ( ORDER BY @orderby@ ) AS [RowNum]  FROM   (     SELECT      ''[''+ ''Edit'' + '']'' + ''(/Maintenance/fmgCompanyMaintenance.aspx?CompanyID='' + comp.CompanyID + '')'' AS Edit,    comp.CompanyID,    ISNULL(g.Decode, comp.CompanyType) as CompanyType,    comp.CompanyName,    comp.CompanyAddress1,    comp.CompanyAddress2,    comp.CompanyAddress3,    comp.CompanyAddress4,    comp.CompanyCity,    comp.CompanyState,     comp.CompanyPostalCode,    comp.CompanyCountryCode,    comp.DTSStatus,    comp.DTSOverrideDate,    comp.DTSLastValidatedDate,    comp.DTSLastScreenedDate,    1 as NoOrder   FROM tmgCompany comp (NOLOCK)   LEFT JOIN tmgGlobalCodes g (NOLOCK) ON    g.PartnerID = comp.PartnerID AND    g.Code = comp.CompanyType AND    g.FieldName = ''CompanyType''   WHERE     comp.DTSLastScreenedDate > GETDATE() - @VALUE@    AND comp.PartnerID = @PartnerID  ) AS LookupViewInner  WHERE                                  @whereclause@';

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
