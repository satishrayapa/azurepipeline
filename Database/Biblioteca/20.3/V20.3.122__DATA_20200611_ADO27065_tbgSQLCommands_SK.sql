DECLARE @CurrentSQLGuid1 AS VARCHAR(36) = '46e13ff4-7cbc-40e7-a8d6-39793267f2fb';
DECLARE @CurrentSQLDescription1 AS NVARCHAR(500) = 'Solicitation Lookup: Invalid Products';
DECLARE @CurrentSQLLongDescription1 AS NVARCHAR(MAX) = 'Displays product and supplier information for products that are available but do not have an active record or a current solicitation for the part';
DECLARE @CurrentSQLScript1 AS NVARCHAR(MAX) = 
	'SELECT *   ,ROW_NUMBER() OVER (    ORDER BY @orderby@     ,ProductNum    ) AS [RowNum]  FROM (   SELECT '' ['' + pc.ProductNum + ''](/ Maintenance / Edit.aspx?ID = '' + cast(pc.ProductGuid AS VARCHAR(50)) + '' & TYPE = 1 & COUNTRY = US) '' AS ProductNum    ,MAX(ISNULL(pc.ProductDesc, '' MISSING '')) AS '' ProductDesc ''    ,ISNULL('' ['' + pc.SupplierID + ''] '' + '' (/ Maintenance / fmgCompanyMaintenance.aspx?CompanyID = '' + pc.SupplierID + '') '', '' MISSING '') AS SupplierID    ,ISNULL(comp.CompanyContactEmail, '' MISSING '') AS '' SupplierEmail ''    ,1 AS NoOrder   FROM tmdproductClassification pc WITH (NOLOCK)   LEFT JOIN tmgCompany comp WITH (NOLOCK) ON pc.supplierid = comp.companyid    AND pc.PartnerID = comp.PartnerID   LEFT JOIN tmgcompanyemails emails WITH (NOLOCK) ON emails.partnerid = comp.partnerid    AND emails.companyid = comp.companyid   /*--joins to tmgProductNumFTACert to make sure no active records for this part exist */   LEFT JOIN (    SELECT PartnerID     ,ProductNum     ,ManufacturerID     ,COUNT(ProductNum) AS pCount    FROM tmgProductNumFTACert pnfc WITH (NOLOCK)    WHERE (      CertificateStartDate BETWEEN '' 01 / 01 / '' + cast(year(getdate()) AS VARCHAR(4))       AND '' 12 / 31 / '' + cast(year(getdate()) AS VARCHAR(4))      OR CertificateEndDate BETWEEN '' 01 / 01 / '' + cast(year(getdate()) AS VARCHAR(4))       AND '' 12 / 31 / '' + cast(year(getdate()) AS VARCHAR(4))      )     AND STATUS = '' Active ''     AND CertType IN (      '' NAFTA - US(NQ) ''      ,'' NAFTA - US ''      )    GROUP BY ProductNum     ,ManufacturerID     ,PartnerID    ) p ON p.PartnerID = pc.PartnerID    AND p.ProductNum = pc.ProductNum    AND p.ManufacturerID = pc.SupplierID   /*--joins to doc requests to make sure no current solicitation for this part exists  */   LEFT JOIN (    SELECT drdx.PartnerID     ,drdx.Identifier     ,REPLACE(drdx.Supplier, CAST(drdx.PartnerID AS VARCHAR) + '' ~ '', '''') AS Supplier    FROM tmgDocRequestDetail drdx WITH (NOLOCK)    JOIN tmgDocRequest dr WITH (NOLOCK) ON drdx.DocReqGUID = dr.DocReqGUID     AND drdx.PartnerID = dr.PartnerID    LEFT JOIN (     SELECT PartnerId      ,DocReqDetailGuid     FROM tmgDocRequestDetailAttachments a WITH (NOLOCK)     WHERE a.STATUS = '' Accepted ''     ) dra ON dra.DocReqDetailGuid = drdx.DocReqDetailGUID     AND dra.PartnerId = drdx.PartnerID    WHERE drdx.StatusFlag NOT IN (      '' Final ''      ,'' NOT Sent ''      )     AND dr.STATUS <> '' Archived ''     AND dra.DocReqDetailGuid IS NULL     AND (      dr.periodbegindate BETWEEN '' 01 / 01 / '' + cast(year(getdate()) AS VARCHAR(4))       AND '' 12 / 31 / '' + cast(year(getdate()) AS VARCHAR(4))      OR dr.periodenddate BETWEEN '' 01 / 01 / '' + cast(year(getdate()) AS VARCHAR(4))       AND '' 12 / 31 / '' + cast(year(getdate()) AS VARCHAR(4))      )    ) x ON x.PartnerID = pc.PartnerID    AND x.Identifier = pc.ProductNum    AND x.Supplier = pc.SupplierID   WHERE pc.SupplierID <> ''''    AND p.pCount IS NULL    AND x.Supplier IS NULL    AND pc.PartnerID = @PartnerId@    AND (     comp.partnerid IS NULL     OR comp.companytype <> '' supid ''     OR emails.useremail LIKE '' % % ''     OR comp.companycontactemail LIKE '' % % ''     OR emails.useremail = ''''     OR emails.useremail LIKE '' % '' + CHAR(10) + '' % ''     OR comp.companycontactemail LIKE '' % '' + CHAR(10) + '' % ''     )   /*-- @@SELECTED@@ --replaces with AND pc.CountryOfOrigin IN (agreement country list) */   GROUP BY pc.Productguid    ,pc.ProductNum    ,pc.SupplierID    ,comp.CompanyID    ,comp.CompanyContactEmail   ) AS LookupViewInner  WHERE  @whereclause@'
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
