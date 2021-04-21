DECLARE @CurrentSQLGuid1 AS VARCHAR(36) = '1a6d97b3-5c0b-4f3e-b0fd-cdbf140409af';
DECLARE @CurrentSQLDescription1 AS NVARCHAR(500) = 'Customer Request Completion Rate';
DECLARE @CurrentSQLLongDescription1 AS NVARCHAR(MAX) = '';
DECLARE @CurrentSQLScript1 AS NVARCHAR(MAX) = 
	'SELECT * , ROW_NUMBER() OVER ( ORDER BY @orderby@  ) AS [RowNum] FROM (select crh.CompanyID as Customer, 
comp.CompanyName,
count(crd.requestdetailguid) as TotalParts, 
sum(case when cd.partnerid is null then 0 else 1 end) as Completed, 
sum(case when cd.partnerid is null then 1 else 0 end) as Outstanding, 
cast(sum(case when cd.partnerid is null then 0 else 1 end) as numeric (28,20))/cast(count(crd.requestdetailguid) as numeric (28,20))*100 as PercentageCompleted,
1 as NoOrder
FROM txdFTACertRequestHeader CRH with(nolock)
join txdftacertrequestdetail crd with(nolock)
on crh.partnerid = crd.partnerid
and crh.RequestGuid = crd.RequestGuid
LEFT JOIN txdcertdetail cd WITH (NOLOCK) 
ON crd.requestdetailguid = cd.detailguid
AND crd.partnerid = cd.partnerid
Join tmgCompany comp with(nolock)
on crh.CompanyID=comp.CompanyID
and crh.PartnerID=comp.PartnerID
where requeststatus <> ''new''
group by comp.CompanyID,crh.companyid,comp.CompanyName ) AS LookupViewInner WHERE @whereclause@'
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
