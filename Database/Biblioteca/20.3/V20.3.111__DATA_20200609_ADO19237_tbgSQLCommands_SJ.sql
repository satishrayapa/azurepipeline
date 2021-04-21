DECLARE @CurrentSQLGuid1 AS VARCHAR(36) = '9c22ecee-4cfe-4402-a740-191638973c58';
DECLARE @CurrentSQLDescription1 AS NVARCHAR(500) = 'BOM Lookup';
DECLARE @CurrentSQLLongDescription1 AS NVARCHAR(MAX) = 'Provides finished good and component level BOM details';
DECLARE @CurrentSQLScript1 AS NVARCHAR(MAX) = 
	'SELECT * ,    ROW_NUMBER() OVER ( ORDER BY BOMStartDate, BOMEndDate, FinishedGood, Component ) AS [RowNum]             FROM                  ( SELECT ''['' + ''View'' + ''](/Interfaces/fidBOMAnalysisUpload.aspx?BOM='' + IM.BOMGUID + '')'' as [View], BillOfMaterials as Name, Convert (varchar,BOMStartDate,101) as BOMStartDate, Convert (varchar,BOMEndDate,101) as BOMEndDate, IM.ProductNum as FinishedGood,  CONVERT(DECIMAL(15,4),IM.Value) as FGNetCost, CONVERT(DECIMAL(10,4),IM.CommercialValue) as FGTransactionValue, IM.HTSNum as FGHSNum, IM.CountryOfOrigin as FGCountryOfOrigin,  PC.ProductNum as Component, CONVERT(DECIMAL(15,4),PC.Value) as CNetCost, CONVERT(DECIMAL(10,4),PC.AccumulationValue) as CTransactionValue, PC.HTSNum as CHSNum, PC.QtyPerIM as QtyPerIM,  PC.TracedValue as CTracedValue, PC.ManufacturerID as CManufacturerID, 1 AS NoOrder FROM dbo.txdBOMIM IM WITH (NOLOCK)  INNER JOIN dbo.txdBOMPC PC WITH (NOLOCK) ON IM.BOMGUID = PC.BOMGUID And IM.PartnerId = PC.PartnerId WHERE IM.BOMType = ''FTA'' AND IM.PartnerID=@PartnerID@      ) AS LookupViewInner WHERE                                         @whereclause@'
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
