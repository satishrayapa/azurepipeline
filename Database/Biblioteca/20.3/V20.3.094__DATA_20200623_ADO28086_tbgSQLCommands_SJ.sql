DECLARE @CurrentSQLGuid1 AS VARCHAR(36) = '3600b0b1-905e-40c0-9da4-db7c583bbe33';
DECLARE @CurrentSQLDescription1 AS NVARCHAR(500) = 'DPS Lookup: Companies that have been manually blocked';
DECLARE @CurrentSQLLongDescription1 AS NVARCHAR(MAX) = 'Displays all parties that have a status of Manual Block';
DECLARE @CurrentSQLScript1 AS NVARCHAR(MAX) = 'SELECT * ,  ROW_NUMBER() OVER ( ORDER BY @orderby@ ) AS [RowNum]  FROM   (    SELECT     ''[''+ ''Edit'' + '']'' + ''(/Maintenance/fmgCompanyMaintenance.aspx?CompanyID='' + comp.CompanyID + '')'' AS Edit,    comp.CompanyID,    comp.DTSStatus,    comp.DTSLastScreenedDate,    N.Effdate as ''Note Date'',    N.Username,    comp.CompanyName,    ISNULL(g.Decode, comp.CompanyType) as CompanyType,    N.Notes as ''Manual Block Note'',    1 as NoOrder   FROM tmgCompany comp (nolock)   JOIN txdDTSNotes N (nolock)    ON N.CompanyID = comp.CompanyID          AND N.PartnerID = comp.PartnerID   LEFT JOIN tmgglobalcodes g (nolock)     ON g.partnerid = comp.partnerid     AND g.code = comp.CompanyType     AND g.fieldname = ''CompanyType''   WHERE  DTSStatus = ''Manual Block''   AND N.Notes LIKE ''Company has been set to Blocked%''   AND comp.PartnerID = @PartnerID  ) AS LookupViewInner  WHERE                                  @whereclause@';

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
