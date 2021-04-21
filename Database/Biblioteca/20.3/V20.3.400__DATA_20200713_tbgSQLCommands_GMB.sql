DECLARE @CurrentSQLGuid1 AS VARCHAR(36) = '06AC6717-4EDC-4455-8BCA-3BB194269A60';
DECLARE @CurrentSQLDescription1 AS NVARCHAR(500) = 'Duty by Supplier and Product';
DECLARE @CurrentSQLLongDescription1 AS NVARCHAR(MAX) = 'This report shows total duty paid for each product  by supplier.';
DECLARE @CurrentSQLScript1 AS NVARCHAR(MAX) = 'SELECT
   ProductNum,
   SupplierName,
   CAST(SUM(d.EstBasetotalLineDuty ) AS Numeric(28, 2)) as [EstBaseTotalLineDuty (@CurrencyCode)] 
from
   txdgvimportheader h WITH (NOLOCK) 
   join
      txdgvimportdetail d WITH (NOLOCK) 
      on h.EntryGuid = d.EntryGuid 
      and h.PartnerID = d.PartnerID 
WHERE 1=1 
   AND @IMPORTDATERANGE 
   AND h.PartnerID = @PartnerID 
GROUP BY
   ProductNum,
   SupplierName 
ORDER BY
   [EstBaseTotalLineDuty (@CurrencyCode)] DESC';

IF EXISTS (
		SELECT TOP 1 1
		FROM tbgSQLCommands WITH (NOLOCK)
		WHERE SQLGUID = CAST(@CurrentSQLGuid1 AS UNIQUEIDENTIFIER)
			AND Version = '20.3'
			AND SQLType = 'GTV Report'
		)
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
		AND SQLType = 'GTV Report';

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
		,'gbrooker'
		,'gbrooker'
		,HASHBYTES('MD5', LEFT(@CurrentSQLScript1, 4000))
		,'GTV Report'
		,'20.3'
		,'N'
		,'N'
		);
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
		,'gbrooker'
		,'gbrooker'
		,HASHBYTES('MD5', LEFT(@CurrentSQLScript1, 4000))
		,'GTV Report'
		,'20.3'
		,'N'
		,'N'
		);
END
