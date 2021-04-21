DECLARE @CurrentSQLGuid1 AS VARCHAR(36) = '015cfa8c-1b76-4880-b400-7066c13693c3';
DECLARE @CurrentSQLDescription1 AS NVARCHAR(500) = 'BOM: Analysis Results';
DECLARE @CurrentSQLLongDescription1 AS NVARCHAR(MAX) = 'Displays BOM analysis results such as tariff shifts, De Minimis, and RVC information for valid BOMs with rules found to analyze ';
DECLARE @CurrentSQLScript1 AS NVARCHAR(MAX) = 
	'SELECT * ,    ROW_NUMBER() OVER ( ORDER BY @orderby@, FinishedGoodProductNum ) AS [RowNum]
            FROM                  (
SELECT
	''['' + ''View'' + ''](/Interfaces/fidBOMAnalysisUpload.aspx?BOM='' + IM.BOMGUID + '')'' as [View], 
	im.productnum AS FinishedGoodProductNum,
	im.BillOfMaterials,
	im.Value AS FinishedGoodValue,
	pc.HSNum AS FinishedGoodHSNum,
	rs.RuleCategory,
	rs.Status,
	rr.TariffShiftFlag AS TariffShift,
	rr.DeMinimisFlag AS DeMinimis,
	rr.RVCFlag AS RVC,
	(select top 1 rvctype from txdRulesStatusRVCHist rvc with(nolock) where rvc.statusguid = rr.statusguid) as [RVCType],
	(select top 1 convert(varchar ,convert(decimal(10,4), percentage)) from txdRulesStatusRVCHist rvc with(nolock)  where rvc.statusguid = rr.statusguid)+''%'' AS RVCPercentage,
1 AS NoOrder
FROM txdbomim im WITH (NOLOCK)
JOIN tmdproductclassification pc WITH (NOLOCK) ON
	im.partnerid = pc.partnerid  AND
	im.productnum = pc.productnum
JOIN txdRulesStatushist rs with (nolock) ON
	im.partnerid = rs.partnerid AND
	im.bomguid = rs.heading
JOIN txdrulesstatusreasonhist rr WITH(nolock) ON
	rs.partnerid = im.partnerid AND
	rs.statusguid = rr.statusguid
JOIN (select PartnerID, max(AnalysisNo)as AnalysisNo, rulecategory, heading from txdrulesstatushist where rulecategory <>'''' group by rulecategory, heading, PartnerID ) AS Ana ON
	Ana.PartnerID = im.PartnerID AND
	Ana.AnalysisNo = rs.AnalysisNo AND
	Ana.rulecategory = rs.RuleCategory AND
	im.bomguid = Ana.heading
WHERE rs.RuleCategory <> ''Invalid'' AND rs.Status <> ''No Rule Found to Analyze''
AND im.partnerid = @PartnerID@
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
			,'gmghebrishvili'
			,'gmghebrishvili'
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
		,'gmghebrishvili'
		,'gmghebrishvili'
		,HASHBYTES('MD5', LEFT(@CurrentSQLScript1, 4000))
		,'General SQL'
		,'20.3'
		,'N'
		,'N'
		);
END
