DECLARE @CurrentSQLGuid1 AS VARCHAR(36) = '8b9b6b33-203d-4204-86f5-838b4eea38a1';
DECLARE @CurrentSQLDescription1 AS NVARCHAR(500) = 'Request Lookup: Closed Classification Requests';
DECLARE @CurrentSQLLongDescription1 AS NVARCHAR(MAX) = 'Displays classification requests that have been closed.';
DECLARE @CurrentSQLScript1 AS NVARCHAR(MAX) = 
	'SELECT * ,
ROW_NUMBER() OVER ( ORDER BY @orderby@, Status, RequestDate asc ) AS [RowNum]
FROM    
( 
Select 
  ''['' + ''Edit'' + '']'' + ''(/Maintenance/Edit.aspx?ProductNum='' + cd.ProductNum + ''&ID='' + CAST (cd.ProductGuid AS VARCHAR(50)) + ''&TYPE=1&COUNTRY=US)'' AS Edit,
	isnull(gc.Decode, ch.Status) as Status,
	ch.RequestorName, 
	convert(varchar(10), ch.requestdate, 101) as RequestDate, 
	ch.Priority, 
	ch.DueDate,
	ch.AssignedTo,
	isnull(cd.ProductNum, '''') as ProductNum,
	isnull(cd.ProductDesc, '''') as ProductDesc, 
	isnull(cd.HsNum, '''') as HsNum,
	isnull(cd.CountryOfOrigin, '''') as CountryOfOrigin,
	1 AS NoOrder
from tmdClassificationRequestHeader ch (nolock) 
left join tmdClassificationRequestDetail cd (nolock) on 
	ch.RequestGuid = cd.RequestGuid and 
	ch.PartnerID = cd.PartnerID    
left join tmgGlobalCodes gc (nolock) on 
	ch.Status = gc.Code and
	ch.PartnerID = gc.PartnerID and
	gc.FieldName = ''ClassRequest''
where 
	ch.Status = ''Closed'' and
	ch.Country = ''@COUNTRY_CODE@'' and 
	ch.PartnerID = @PartnerID
) AS LookupViewInner
WHERE                               
	@whereclause@'
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
