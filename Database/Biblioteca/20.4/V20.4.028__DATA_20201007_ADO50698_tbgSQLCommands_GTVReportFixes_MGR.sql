SET XACT_ABORT ON;
BEGIN TRANSACTION;

SET IDENTITY_INSERT dbo.tbgSQLCommandsHist ON;
GO	

DECLARE @partner AS INT
DECLARE @sqlguid AS UNIQUEIDENTIFIER
DECLARE @newsqlcmd AS VARCHAR (max)
DECLARE @description AS NVARCHAR (max)
DECLARE @longdescription AS NVARCHAR (max)
DECLARE @version AS VARCHAR (max)

SET @partner = 4000
------------------------------------Unit Value Fluctuations by Declaration Number----------------------------------------
SET @sqlguid = '124F5BB7-A75A-4CDB-8EDA-A35BF82921E5'

SET @newsqlcmd = 'SELECT CASE 
		WHEN NOT EXISTS (
				SELECT 1
				FROM txdEntryValidationSummaryStatus WITH (NOLOCK)
				WHERE CAST(h.EntryGuid AS VARCHAR(50)) = EntryGuid
					AND h.PartnerID = PartnerID
				)
			THEN ''N/A''
		ELSE ''['' + ''View in EV'' + '']'' + ''(/Import/fxdEntrySummaryImproved.aspx?EntryGuid='' + CAST(h.EntryGuid AS VARCHAR(50)) + ''&Tab=LineOverview'' + '')''
		END AS [View in EV]
	,h.DeclarationNum
	,h.ImportCountry
	,h.BrokerName
	,h.ImportDate
	,d.ProductNum
	,d.HsNum
	,CAST((d.UnitValue) AS NUMERIC(28, 4)) AS UnitValue
FROM txdGVImportHeader h WITH (NOLOCK)
JOIN txdGVImportDetail d WITH (NOLOCK) ON h.EntryGUID = d.EntryGUID
	AND h.PartnerID = d.PartnerID
JOIN (
	SELECT h.PartnerID
		,h.ImportCountry
		,d.ProductNum
		,COUNT(DISTINCT UnitValue) AS DistinctUnitValue
	FROM txdGVImportHeader h WITH (NOLOCK)
	JOIN txdGVImportDetail d WITH (NOLOCK) ON h.EntryGUID = d.EntryGUID
		AND h.PartnerID = d.PartnerID
	WHERE 1=1 AND h.PartnerID = @PartnerID
		AND @IMPORTDATERANGE
	GROUP BY h.PartnerID
		,h.ImportCountry
		,d.ProductNum
	HAVING COUNT(DISTINCT UnitValue) > 1
	) b ON h.PartnerID = b.PartnerID
	AND h.ImportCountry = b.ImportCountry
	AND d.ProductNum = b.ProductNum
WHERE 1=1 AND h.PartnerID = @PartnerID
	AND @IMPORTDATERANGE
	AND d.ProductNum <> ''''
GROUP BY h.DeclarationNum
	,d.ProductNum
	,h.ImportCountry
	,d.HsNum
	,d.UnitValue
	,h.EntryGUID
	,h.PartnerID
	,h.BrokerName
	,h.ImportDate
ORDER BY d.ProductNum ASC'
SET @description = N'Unit Value Fluctuations by Declaration Number'
SET @longdescription = N'This report is the most detailed view of the unit value fluctuations displaying the declaration number, import country, product number, HS number, and unit value of the exception. A unit value fluctuation is differing tariff classifications for the same import country and product number.'

--insert old records into hist
INSERT INTO dbo.tbgSQLCommandsHist
        ( PartnerID ,
          EffDate ,
		  SQLID,
          SQLGUID ,
          SQLCommand ,
          Description ,
          LongDescription ,
          CreatedDate ,
          CreatedBy ,
          ApprovedBy ,
          SQLHash ,
          SQLType ,
          Version ,
          DeletedFlag ,
          KeepDuringRollback   )
        SELECT  PartnerID ,
                EffDate ,
				SQLID,
                SQLGUID ,
                SQLCommand ,
                Description ,
                LongDescription ,
                CreatedDate ,
                CreatedBy ,
                ApprovedBy ,
                SQLHash ,
                SQLType ,
                Version ,
                DeletedFlag ,
                KeepDuringRollback
        FROM    dbo.tbgSQLCommands WITH ( NOLOCK )
        WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.4' );    

--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.4' );  

--insert new records				
INSERT INTO dbo.tbgSQLCommands
        ( PartnerID ,
          EffDate ,
          SQLGUID ,
          SQLCommand ,
          Description ,
          LongDescription ,
          CreatedDate ,
          CreatedBy ,
          ApprovedBy ,
          SQLHash ,
          SQLType ,
          Version ,
          DeletedFlag ,
          KeepDuringRollback
        )
SELECT @partner , -- PartnerID - int
          GETDATE() , -- EffDate - datetime
          @sqlguid , -- SQLGUID - uniqueidentifier
          @newsqlcmd , -- SQLCommand - varchar(max)
          @description , -- Description - nvarchar(100)
          @longdescription , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.4' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)	
		  


------------------------------------Duty by Supplier and Product----------------------------------------
SET @sqlguid = '06AC6717-4EDC-4455-8BCA-3BB194269A60'

SET @newsqlcmd = 'SELECT
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
   [EstBaseTotalLineDuty (@CurrencyCode)] DESC'
SET @description = N'Duty by Supplier and Product'
SET @longdescription = N'This report shows total duty paid for each product  by supplier.'

--insert old records into hist
INSERT INTO dbo.tbgSQLCommandsHist
        ( PartnerID ,
          EffDate ,
		  SQLID,
          SQLGUID ,
          SQLCommand ,
          Description ,
          LongDescription ,
          CreatedDate ,
          CreatedBy ,
          ApprovedBy ,
          SQLHash ,
          SQLType ,
          Version ,
          DeletedFlag ,
          KeepDuringRollback   )
        SELECT  PartnerID ,
                EffDate ,
				SQLID,
                SQLGUID ,
                SQLCommand ,
                Description ,
                LongDescription ,
                CreatedDate ,
                CreatedBy ,
                ApprovedBy ,
                SQLHash ,
                SQLType ,
                Version ,
                DeletedFlag ,
                KeepDuringRollback
        FROM    dbo.tbgSQLCommands WITH ( NOLOCK )
        WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.4' );    

--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.4' );  

--insert new records				
INSERT INTO dbo.tbgSQLCommands
        ( PartnerID ,
          EffDate ,
          SQLGUID ,
          SQLCommand ,
          Description ,
          LongDescription ,
          CreatedDate ,
          CreatedBy ,
          ApprovedBy ,
          SQLHash ,
          SQLType ,
          Version ,
          DeletedFlag ,
          KeepDuringRollback
        )
SELECT @partner , -- PartnerID - int
          GETDATE() , -- EffDate - datetime
          @sqlguid , -- SQLGUID - uniqueidentifier
          @newsqlcmd , -- SQLCommand - varchar(max)
          @description , -- Description - nvarchar(100)
          @longdescription , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.4' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)		


--ROLLBACK TRANSACTION;
COMMIT TRANSACTION
SET XACT_ABORT OFF;