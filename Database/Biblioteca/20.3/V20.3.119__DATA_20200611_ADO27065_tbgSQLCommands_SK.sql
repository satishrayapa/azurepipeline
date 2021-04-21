DECLARE @CurrentSQLGuid1 AS VARCHAR(36) = '036954d1-0c0e-4e9f-8577-2e659b320099';
DECLARE @CurrentSQLDescription1 AS NVARCHAR(500) = 'Solicitation Lookup: Outstanding Products';
DECLARE @CurrentSQLLongDescription1 AS NVARCHAR(MAX) = 'Displays supplier Information for products that have a PeriodBeginDate in the current year and have a solicitation that is not complete';
DECLARE @CurrentSQLScript1 AS NVARCHAR(MAX) = 
	'SELECT * ,    ROW_NUMBER() OVER ( ORDER BY @orderby@, SupplierID ) AS [RowNum]             FROM                  ( SELECT  ''['' + ''View'' + ''](/Maintenance/fmgCompanyMaintenance.aspx?CompanyID='' + pc.SupplierID + '')'' as [View],     ISNULL(pc.SupplierID,''MISSING'') AS SupplierID,         Comp.CompanyName as Supplier, drd.CertAgreement as ''FTA'',     COUNT(drd.Identifier) as [Outstanding Products], 1 AS NoOrder  FROM tmgDocRequest DR WITH (NOLOCK)  JOIN tmgDocRequestDetail DRD WITH (NOLOCK) ON      DR.PartnerID = DRD.PartnerID AND      DR.DocReqGUID = DRD.DocReqGUID  LEFT JOIN tmdproductClassification pc WITH (nolock)  ON pc.PartnerID = DR.PartnerID AND pc.ProductNum = drd.identifier               LEFT JOIN txdcertdetailstatus cds WITH(NOLOCK) ON cds.Detailguid = drd.docreqdetailguid and cds.PartnerID = drd.PartnerID JOIN tmgCompany comp WITH (nolock) on  drd.PartnerID = comp.PartnerID and  replace(drd.Supplier, cast(drd.PartnerID as varchar) + ''~'', '''') = comp.CompanyID        WHERE  dr.PartnerID = (SELECT PartnerID FROM tmfDefaults WITH (NOLOCK))      AND YEAR(DR.PeriodBeginDate) = year(getdate())     AND DR.Status IN (''SENT'',''NOT COMPLETE'',''ACTION REQUIRED'',''REJECTED'')       AND ( CDS.PartnerID IS NULL  OR cds.Generated<>''Y'') GROUP BY pc.SupplierID, comp.CompanyName, DRd.supplier, drd.CertAgreement, DRD.PartnerID ) AS LookupViewInner WHERE                                         @whereclause@  '
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
