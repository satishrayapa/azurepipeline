DECLARE @CurrentSQLGuid1 AS VARCHAR(36) = '96643fd0-194e-40e3-892e-db835796a94b';
DECLARE @CurrentSQLDescription1 AS NVARCHAR(500) = 'Solicitation Lookup: Available Products';
DECLARE @CurrentSQLLongDescription1 AS NVARCHAR(MAX) = 'Displays Product and Supplier information for products with statuses of ''Active'' and ''Accepted''';
DECLARE @CurrentSQLScript1 AS NVARCHAR(MAX) = 
	'SELECT * ,    ROW_NUMBER() OVER ( ORDER BY @orderby@, ProductNum ) AS [RowNum]             FROM                  ( SELECT  pc.ProductNum, MAX(ISNULL(pc.ProductDesc, ''MISSING'')) AS ''ProductDesc'',  drd.CertAgreement AS ''Agreement'', ISNULL(pc.SupplierID, ''MISSING'') AS SupplierID, ISNULL(comp.CompanyContactEmail, ''MISSING'') AS ''SupplierEmail'', 1 AS NoOrder        FROM tmdproductClassification pc WITH (NOLOCK) LEFT JOIN tmgCompany comp WITH (NOLOCK)  ON pc.supplierid = comp.companyid AND pc.PartnerID = comp.PartnerID LEFT JOIN tmgDocRequestDetail drd WITH (NOLOCK) ON pc.ProductNum = drd.Identifier AND pc.SupplierID = replace(drd.supplier, cast(drd.PartnerID as varchar(20)) + ''~'', '''') AND pc.PartnerID = drd.PartnerID AND ( drd.CertAgreement = ''NAFTA-US'' OR drd.CertAgreement = '''' ) LEFT JOIN  ( SELECT PartnerID,ProductNum,ManufacturerID, COUNT(ProductNum) as pCount FROM tmgProductNumFTACert pnfc WITH (NOLOCK) WHERE (CertificateStartDate BETWEEN ''01/01/'' +  cast(year(getdate()) as varchar(4))           AND ''12/31/'' +  cast(year(getdate()) as varchar(4)) OR CertificateEndDate BETWEEN ''01/01/'' +  cast(year(getdate()) as varchar(4))           AND ''12/31/'' +  cast(year(getdate()) as varchar(4))) AND Status = ''Active'' AND CertType in (''NAFTA-US (NQ)'', ''NAFTA-US'')  GROUP BY ProductNum,ManufacturerID,PartnerID ) p  ON p.PartnerID = pc.PartnerID AND p.ProductNum = pc.ProductNum AND p.ManufacturerID = pc.SupplierID   /*--joins to doc requests to make sure no current solicitation for this part exists */  LEFT JOIN  (  SELECT drdx.PartnerID, drdx.Identifier, REPLACE(drdx.Supplier, CAST(drdx.PartnerID AS VARCHAR) + ''~'', '''') AS Supplier FROM tmgDocRequestDetail drdx WITH (NOLOCK)  JOIN tmgDocRequest dr WITH (NOLOCK) ON drdx.DocReqGUID = dr.DocReqGUID AND drdx.PartnerID = dr.PartnerID LEFT JOIN (SELECT PartnerId, DocReqDetailGuid FROM tmgDocRequestDetailAttachments a WITH (NOLOCK) WHERE a.Status = ''Accepted'' ) dra ON dra.DocReqDetailGuid = drdx.DocReqDetailGUID AND dra.PartnerId = drdx.PartnerID WHERE drdx.StatusFlag NOT IN (''Final'', ''Not Sent'') AND dr.Status <> ''Archived'' AND dra.DocReqDetailGuid IS NULL AND ( dr.periodbegindate BETWEEN ''01/01/'' +  cast(year(getdate()) as varchar(4))           AND ''12/31/'' +  cast(year(getdate()) as varchar(4)) OR dr.periodenddate BETWEEN ''01/01/'' +  cast(year(getdate()) as varchar(4))           AND ''12/31/'' +  cast(year(getdate()) as varchar(4)))        ) x  ON x.PartnerID = pc.PartnerID AND x.Identifier = pc.ProductNum AND x.Supplier = pc.SupplierID WHERE pc.SupplierID <> '''' AND p.pCount IS NULL AND x.Supplier IS NULL AND pc.Partnerid=@PartnerID@                 /*-- @@SELECTED@@ --replaces with AND pc.CountryOfOrigin IN (agreement country list) */  GROUP BY pc.Productguid, pc.ProductNum, drd.CertAgreement, pc.SupplierID, comp.CompanyContactEmail, drd.DocReqDetailGuid ) AS LookupViewInner WHERE                                @whereclause@'
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
