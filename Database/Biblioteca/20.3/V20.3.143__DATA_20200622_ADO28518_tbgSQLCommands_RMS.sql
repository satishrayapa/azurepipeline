DECLARE @CurrentSQLGuid1 AS VARCHAR(36) = 'fde906cf-55fe-4bd4-b209-6ad17d2e9664';
DECLARE @CurrentSQLDescription1 AS NVARCHAR(500) = 'China Classification:SDE Action Required';
DECLARE @CurrentSQLLongDescription1 AS NVARCHAR(MAX) = 'SDE Action Required';
DECLARE @CurrentSQLScript1 AS NVARCHAR(MAX) = '
SELECT * 
,ROW_NUMBER() OVER (
ORDER BY @orderby@
,ProductNum
) AS [RowNum]
FROM (
SELECT DISTINCT cast(pc.ProductGuid AS VARCHAR(50)) AS PRODUCTGUID
,pc.ProductNum AS productNum
,pc.ProductDesc
,pc.AltProductDesc
,pc.ProductTypeCode
,pc.HsNum
,stuff((
SELECT ''|''
,cast(de1.SequenceNum AS VARCHAR(50)) + ''.'' + de1.DeclarableElement
FROM tmfDeclarableElement de1(NOLOCK)
WHERE de1.HsNum = sh.HsNum
AND de1.CultureCode = ''chi''
ORDER BY de1.SequenceNum ASC
FOR XML path('''')
), 1, 1, '''') AS DeclarableSDE
,sh.summarySDE AS SummarySDE
,sh.activeflag AS [ISActive]
,''There are SDE Values not maintained.'' AS IsSDEValueMaintained
,1 AS NoOrder
FROM tmdCNProductClassification pc
LEFT JOIN vid_CNSDE sh WITH (NOLOCK) ON sh.PartnerID = pc.PartnerID
AND cast(pc.ProductGuid AS VARCHAR(50)) = sh.ProductGuid
AND (
pc.HsNum = sh.HsNum
AND sh.HsNumField = ''hsnum''
)
LEFT JOIN tmfDeclarableElement de ON de.PartnerID = sh.PartnerID
AND de.CultureCode = ''chi''
AND de.HsNum = sh.HsNum
WHERE (
/*ContentSDE missing in SDE maintenance*/

pc.PRODUCTGUID IN (
SELECT DISTINCT a.ProductGuid
FROM tmfdeclarableelement d
JOIN tmdcnsdeheader a ON d.HSNum = a.HSNum
AND d.CultureCode = ''chi''
AND a.activeflag = ''Y''
LEFT JOIN tmdcnsdedetail b ON a.sdeguid = b.sdeguid
AND b.SequenceNum = d.SequenceNum
AND b.ContentSDE = d.declarableElement
AND a.PartnerID = b.PartnerID
WHERE b.SequenceNum IS NULL
AND a.PartnerID = (
SELECT PartnerID
FROM tmfdefaults
)
)
/*SDE values are not fully maintained*/
OR pc.PRODUCTGUID IN (
SELECT DISTINCT a.ProductGuid
FROM tmdcnSDEheader a
JOIN tmdcnsdedetail b ON a.sdeguid = b.sdeguid
WHERE SDEValue = ''''
AND a.activeflag = ''Y''
AND a.PartnerID = (
SELECT PartnerID
FROM tmfdefaults
)
)
OR sh.PartnerID IS NULL 
/* SDE does not exists in maintenance*/
)
AND pc.PartnerID = (
SELECT PartnerID
FROM tmfdefaults
)
AND pc.Activeflag = ''Y''
AND pc.HSNUM <> ''''
AND NOT EXISTS (
SELECT TOP 1 *
FROM tmdClassificationMessages WITH (NOLOCK)
WHERE ProductGuid = pc.ProductGuid
AND TableName = ''tmdCNProductClassification''
AND FieldName = ''HSNum''
)
) AS LookupViewInner
WHERE @whereclause@
';

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