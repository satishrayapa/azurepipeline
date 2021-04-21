DECLARE @CurrentSQLGuid1 AS VARCHAR(36) = '5BEE3D5F-1E06-4044-9FDC-65CC075367EA';
DECLARE @CurrentSQLDescription1 AS NVARCHAR(500) = 'DPS Lookup: Overridden Parties';
DECLARE @CurrentSQLLongDescription1 AS NVARCHAR(MAX) = 'Displays all parties that have a status of Overridden';
DECLARE @CurrentSQLScript1 AS NVARCHAR(MAX) = 
	'SELECT * ,ROW_NUMBER() OVER ( ORDER BY @orderby@ ,CompanyID DESC ) AS [RowNum] FROM ( SELECT ''['' + ''Edit'' + '']'' + ''(/Maintenance/fmgCompanyMaintenance.aspx?CompanyID='' + c.CompanyID + '')'' AS Edit ,ISNULL(''[Search](/DTS/fxdDPSQuery.aspx?CompanyID='' + c.CompanyID + '')'', '''') AS Search ,c.CompanyID ,c.CompanyID AS ''CompanyAddressGUID'' ,c.CompanyType ,c.DTSCompanyName ,c.CompanyAddress1 ,c.CompanyAddress2 ,c.CompanyCity ,c.CompanyState ,c.CompanyPostalCode ,c.CompanyCountryCode ,c.DTSStatus ,c.DTSLastScreenedDate ,1 AS NoOrder FROM tmgcompany c WITH (NOLOCK) WHERE c.partnerid = @PartnerID AND c.dtsstatus IN (''Overridden'') UNION SELECT ''['' + ''Edit'' + '']'' + ''(/Maintenance/fmgCompanyMaintenance.aspx?CompanyID='' + a.CompanyID + '')'' AS Edit ,ISNULL(''[Search](/DTS/fxdDPSQuery.aspx?resultguid='' + a.CompanyID + '')'', '''') AS Search ,a.CompanyID ,a.CompanyAddressGUID ,''Secondary Address'' AS CompanyType ,a.DTSCompanyName ,a.CompanyAddress1 ,a.CompanyAddress2 ,a.CompanyCity ,a.CompanyState ,a.CompanyPostalCode ,a.CompanyCountryCode ,a.DTSStatus ,a.DTSLastScreenedDate ,1 AS NoOrder FROM tmgcompanyAddress a WITH (NOLOCK) WHERE a.partnerid = @PartnerID AND a.dtsstatus IN (''Overridden'') ) AS LookupViewInner WHERE @whereclause@'
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
			,'gmgebrishvili'
			,'gmgebrishvili'
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
			,'gmgebrishvili'
			,'gmgebrishvili'
			,HASHBYTES('MD5', LEFT(@CurrentSQLScript1, 4000))
			,'General SQL'
			,'20.3'
			,'N'
			,'N'
			);
	END