DECLARE @CurrentSQLGuid1 AS VARCHAR(36) = '3a5be1e5-42f7-4d7a-90dd-e8d87ad896eb';
DECLARE @CurrentSQLDescription1 AS NVARCHAR(500) = 'Classification Lookup: CI - US E&C';
DECLARE @CurrentSQLLongDescription1 AS NVARCHAR(MAX) = 'Displays the US  E and C regulations for US products';
DECLARE @CurrentSQLScript1 AS NVARCHAR(MAX) = 'SELECT * ,
									ROW_NUMBER() OVER ( ORDER BY @orderby@, ProductNum asc ) AS [RowNum]
								FROM    
									(
										select 
 ''[Edit](/Maintenance/Edit.aspx?ID='' + cast(uspc.ProductGuid as varchar(50)) + ''&TYPE=1&COUNTRY=US)'' As Edit,
											 
											uspc.ProductNum,  
											uspc.ProductDesc, 
''['' +uspc.HsNum + ''](/Content/fugGlobalTariffsDetail.aspx?HsNumber=''+uspc.HsNum+''&Country=us)'' as HsNum,
											CIControls.ControlType,
											CIControls.TranslationValue,
CIControls.AgencyCode,
											1 AS NoOrder
										from tmdUSProductClassification uspc WITH (NOLOCK) 
										join vid_CI_US_Controls CIControls  WITH (NOLOCK) on 
											CIControls.AgencyCode = ''USE&C'' and
											uspc.ProductGuid = CIControls.ProductGuid and
											uspc.PartnerID = CIControls.PartnerID
										WHERE 									
											uspc.PartnerID = @PartnerID
									) AS LookupViewInner
								WHERE                               
									@whereclause@';

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
			,'rsheth'
			,'rsheth'
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
		,'rsheth'
		,'rsheth'
		,HASHBYTES('MD5', LEFT(@CurrentSQLScript1, 4000))
		,'General SQL'
		,'20.3'
		,'N'
		,'N'
		);
END



