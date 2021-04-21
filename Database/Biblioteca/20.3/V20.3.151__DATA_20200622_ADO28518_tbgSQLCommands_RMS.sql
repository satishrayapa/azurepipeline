DECLARE @CurrentSQLGuid1 AS VARCHAR(36) = 'fd462eeb-2693-4793-b003-d6a67893521d';
DECLARE @CurrentSQLDescription1 AS NVARCHAR(500) = 'Classification Lookup: GCP2IM Validations Standard/US';
DECLARE @CurrentSQLLongDescription1 AS NVARCHAR(MAX) = 'Displays information about the validation errors that occur when running GCP2IM ';
DECLARE @CurrentSQLScript1 AS NVARCHAR(MAX) = 
	'SELECT * ,    ROW_NUMBER() OVER ( ORDER BY @orderby@, ProductNum ) AS [RowNum]
            FROM                  (SELECT t.ProductNum
                ,''GC000'' AS ErrorCode
                ,''The product number has duplicates that are also FtzActive'' AS Error
                ,q.EffDate AS ''Error occured on''
    ,1 AS NoOrder
FROM (
                SELECT ProductNum
                                ,ProductGuid
                FROM tmd@COUNTRY_CODE@ProductClassification WITH (NOLOCK)
                WHERE PartnerId = @PartnerID@
                                AND ProductNum <> ''''
                                AND ProductNum IN (
                                                SELECT ProductNum
                                                FROM tmd@COUNTRY_CODE@ProductClassification pc WITH (NOLOCK)
                                                WHERE PartnerId = @PartnerID@
                                                                AND FtzActiveFlag = ''Y''
                                                GROUP BY ProductNum
                                                HAVING COUNT(*) > 1
                                                )
                ) AS t
JOIN tmdProductClassificationModificationQueue q ON q.PartnerId = @PartnerID@
                AND t.ProductGuid = q.ProductGuid
WHERE EffDate = (
                                SELECT TOP 1 EffDate
                                FROM tmdProductClassificationModificationQueue WITH (NOLOCK)
                                WHERE PartnerId = q.PartnerId
                                                AND ProductGuid = q.ProductGuid
                                ORDER BY EffDate DESC
                                )

UNION ALL

SELECT t.ProductNum
                ,''GC001'' AS ErrorCode
                ,''This record has a blank product number'' AS Error
                ,q.EffDate AS ''Error occured on''
    ,1 AS NoOrder
FROM (
                SELECT DISTINCT pc.ProductNum
                                ,pc.ProductGuid
                FROM tmd@COUNTRY_CODE@ProductClassification pc WITH (NOLOCK)
                JOIN tmdProductClassificationModificationQueue q WITH (NOLOCK) ON pc.PartnerId = @PartnerID@
                                AND q.PartnerId = @PartnerID@
                                AND pc.ProductGuid = q.ProductGuid
                WHERE q.CountryCode = ''@COUNTRY_CODE@''
                                AND q.NotificationSent = ''Y''
                ) AS t
JOIN tmdProductClassificationModificationQueue q WITH (NOLOCK) ON q.PartnerId = @PartnerID@
                AND t.ProductGuid = q.ProductGuid
WHERE t.ProductNum = ''''
                AND EffDate = (
                                SELECT TOP 1 EffDate
                                FROM tmdProductClassificationModificationQueue
                                WHERE PartnerId = q.PartnerId
                                                AND ProductGuid = q.ProductGuid
                                ORDER BY EffDate DESC
                                )

UNION ALL

SELECT t.ProductNum
                ,''GC002'' AS ErrorCode
                ,''There is FTZ historical data that exists for this product number'' AS Error
                ,q.EffDate AS ''Error occured on''
    ,1 AS NoOrder
FROM (
                SELECT DISTINCT pc.ProductNum
                                ,pc.ProductGuid
                FROM tmd@COUNTRY_CODE@ProductClassification pc WITH (NOLOCK)
                JOIN tmdProductClassificationModificationQueue q WITH (NOLOCK) ON pc.PartnerId = @PartnerID@
                                AND q.PartnerId = @PartnerID@
                                AND pc.ProductGuid = q.ProductGuid
                WHERE q.CountryCode = ''@COUNTRY_CODE@''
                                AND q.NotificationSent = ''Y''
                                AND ProductNum IN (
                                                SELECT ProductNum
                                                FROM ttdStagingFifoProcessing o WITH (NOLOCK)
                                                WHERE o.PartnerId = @PartnerID@
                                                                AND EXISTS (
                                                                                SELECT 1
                                                                                FROM tmd@COUNTRY_CODE@ProductClassification pc WITH (NOLOCK)
                                                                                JOIN tmdProductClassificationModificationQueue q WITH (NOLOCK) ON pc.PartnerId = @PartnerID@
                                                                                                AND q.PartnerId = @PartnerID@
                                                                                                AND pc.ProductGuid = q.ProductGuid
                                                                                WHERE q.CountryCode = ''@COUNTRY_CODE@''
                                                                                                AND q.NotificationSent = ''Y''
                                                                                                AND ProductNum = o.ProductNum
                                                                                )
                                                
                                                UNION
                                                
                                                SELECT ProductNum
                                                FROM txdFifoProcessing o WITH (NOLOCK)
                                                WHERE o.PartnerId = @PartnerID@
                                                                AND EXISTS (
                                                                                SELECT 1
                                                                                FROM tmd@COUNTRY_CODE@ProductClassification pc WITH (NOLOCK)
                                                                                JOIN tmdProductClassificationModificationQueue q WITH (NOLOCK) ON pc.PartnerId = @PartnerID@
                                                                                                AND q.PartnerId = @PartnerID@
                                                                                                AND pc.ProductGuid = q.ProductGuid
                                                                                WHERE q.CountryCode = ''@COUNTRY_CODE@''
                                                                                                AND q.NotificationSent = ''Y''
                                                                                                AND ProductNum = o.ProductNum
                                                                                )
                                                
                                                UNION
                                                
                                                SELECT ProductNum
                                                FROM txdShipIM o WITH (NOLOCK)
                                                WHERE o.PartnerId = @PartnerID@
                                                                AND EXISTS (
                                                                                SELECT 1
                                                                                FROM tmd@COUNTRY_CODE@ProductClassification pc WITH (NOLOCK)
                                                                                JOIN tmdProductClassificationModificationQueue q WITH (NOLOCK) ON pc.PartnerId = @PartnerID@
                                                                                                AND q.PartnerId = @PartnerID@
                                                                                                AND pc.ProductGuid = q.ProductGuid
                                                                                WHERE q.CountryCode = ''@COUNTRY_CODE@''
                                                                                                AND q.NotificationSent = ''Y''
                                                                                                AND ProductNum = o.ProductNum
                                                                                )
                                                
                                                UNION
                                                
                                                SELECT ProductNum
                                                FROM txdShipIMHist o WITH (NOLOCK)
                                                WHERE o.PartnerId = @PartnerID@
                                                                AND EXISTS (
                                                                                SELECT 1
                                                                                FROM tmd@COUNTRY_CODE@ProductClassification pc WITH (NOLOCK)
                                                                                JOIN tmdProductClassificationModificationQueue q WITH (NOLOCK) ON pc.PartnerId = @PartnerID@
                                                                                                AND q.PartnerId = @PartnerID@
                                                                                                AND pc.ProductGuid = q.ProductGuid
                                                                                WHERE q.CountryCode = ''@COUNTRY_CODE@''
                                                                                                AND q.NotificationSent = ''Y''
                                                                                                AND ProductNum = o.ProductNum
                                                                                )
                                                
                                                UNION
                                                
                                                SELECT ProductNum
                                                FROM txdReceiptHist o WITH (NOLOCK)
                                                WHERE o.PartnerId = @PartnerID@
                                                                AND EXISTS (
                                                                                SELECT 1
                                                                                FROM tmd@COUNTRY_CODE@ProductClassification pc WITH (NOLOCK)
                                                                                JOIN tmdProductClassificationModificationQueue q WITH (NOLOCK) ON pc.PartnerId = @PartnerID@
                                                                                                AND q.PartnerId = @PartnerID@
                                                                                                AND pc.ProductGuid = q.ProductGuid
                                                                                WHERE q.CountryCode = ''@COUNTRY_CODE@''
                                                                                                AND q.NotificationSent = ''Y''
                                                                                                AND ProductNum = o.ProductNum
                                                                                )
                                                )
                ) AS t
JOIN tmdProductClassificationModificationQueue q WITH (NOLOCK) ON q.PartnerId = @PartnerID@
                AND t.ProductGuid = q.ProductGuid
WHERE q.PreviousFtzActiveFlag = ''Y''
                AND q.CurrentFtzActiveFlag = ''N''
                AND EffDate = (
                                SELECT TOP 1 EffDate
                                FROM tmdProductClassificationModificationQueue WITH (NOLOCK)
                                WHERE PartnerId = q.PartnerId
                                                AND ProductGuid = q.ProductGuid
                                ORDER BY EffDate DESC
                                )) AS LookupViewInner
            WHERE                               @whereclause@

'
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
			SELECT Count(LongDescription)
			FROM (
				SELECT LongDescription
				FROM tbgSQLcommands WITH (NOLOCK)
				WHERE SQLGUID = CAST(@CurrentSQLGuid1 AS UNIQUEIDENTIFIER)
					AND Version = '20.3'
					AND SQLType = 'General SQL'
				
				UNION
				
				SELECT @CurrentSQLLongDescription1 AS LongDescription
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