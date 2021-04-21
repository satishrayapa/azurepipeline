DECLARE @CurrentSQLGuid1 AS VARCHAR(36) = '303cdb68-eb69-4476-ad8e-47cdbd7411ef';
DECLARE @CurrentSQLDescription1 AS NVARCHAR(500) = 'China Classification:SDE History Lookup';
DECLARE @CurrentSQLLongDescription1 AS NVARCHAR(MAX) = 'SDE History Lookup';
DECLARE @CurrentSQLScript1 AS NVARCHAR(MAX) = 'SELECT *
	,ROW_NUMBER() OVER (
		ORDER BY @orderby@
			,ProductNum
			,CurrentHSNum
			,LogDate DESC
		) AS [RowNum]
FROM (
	SELECT pc.ProductNum
		,B.CurrentHsNum
		,''['' + A.ContentSDE + '':'' + A.SDEValue + '']'' + '' is updated to '' + ''['' + B.CurrentContentSDE + '':'' + B.CurrentSDEValue + '']'' AS LOG
		,b.CurrentDate AS LogDate
		,1 AS NoOrder
	FROM (
		SELECT row_number() OVER (
				PARTITION BY hh.SDEGuid ORDER BY hh.EffDate DESC
				) AS Row
			,hh.ProductGuid
			,hh.EffDate
			,hh.SDEGuid
			,hh.HsNum
			,dh.SequenceNum
			,dh.ContentSDE
			,dh.SDEValue
		FROM tmdCNSDEHeaderHist hh
		JOIN tmdCNSDEDetailHist dh ON hh.SDEGuid = dh.SDEGuid
			AND hh.EffDate = dh.EffDate
		) AS A
	JOIN (
		SELECT row_number() OVER (
				PARTITION BY h.SDEGuid ORDER BY h.EffDate DESC
				) AS CurrentRow
			,h.ProductGuid
			,h.EffDate AS CurrentDate
			,h.SDEGuid AS CurrentSDEGuid
			,h.HsNum AS CurrentHsNum
			,d.SequenceNum AS CurrentSequenceNum
			,d.ContentSDE AS CurrentContentSDE
			,d.SDEValue AS CurrentSDEValue
		FROM (
			SELECT *
			FROM tmdCNSDEHeaderHist WITH (NOLOCK)
			WHERE PartnerID = (
					SELECT PartnerID
					FROM tmfDefaults WITH (NOLOCK)
					)
			
			UNION
			
			SELECT *
			FROM tmdCNSDEHeader WITH (NOLOCK)
			WHERE PartnerID = (
					SELECT PartnerID
					FROM tmfDefaults WITH (NOLOCK)
					)
			) AS h
		JOIN (
			SELECT *
			FROM tmdCNSDEDetailHist WITH (NOLOCK)
			WHERE PartnerID = (
					SELECT PartnerID
					FROM tmfDefaults WITH (NOLOCK)
					)
			
			UNION
			
			SELECT *
			FROM tmdCNSDEDetail WITH (NOLOCK)
			WHERE PartnerID = (
					SELECT PartnerID
					FROM tmfDefaults WITH (NOLOCK)
					)
			) AS d ON h.EffDate = d.EffDate
			AND h.SDEGUID = d.SDEGuid
		) AS B ON A.SDEGuid = B.CurrentSDEGUID
		AND A.Row = B.CurrentROW
		AND A.SequenceNum = B.CurrentSequenceNum
	JOIN tmdCNProductClassification pc WITH (NOLOCK) ON pc.ProductGuid = B.ProductGuid
		AND pc.PartnerID = (
			SELECT PartnerID
			FROM tmfdefaults WITH (NOLOCK)
			)
	) AS LookupViewInner
WHERE @whereclause@';

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