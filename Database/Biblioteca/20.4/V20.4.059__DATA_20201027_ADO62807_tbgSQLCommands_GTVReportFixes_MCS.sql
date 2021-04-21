SET XACT_ABORT ON;
BEGIN TRANSACTION;

SET IDENTITY_INSERT dbo.tbgSQLCommandsHist ON;
GO	

DECLARE @partner AS INT
SET @partner = 4000

DECLARE @description AS NVARCHAR (max)
SET @description = N'Importers by Excise Tax - YoY'

DECLARE @longdescription AS NVARCHAR (max)
SET @longdescription = N'This comparison report shows the importers with the highest associated total line excise tax paid on all declarations filed for the current year compared to the highest associated total line excise tax paid on all declarations filed for the previous year.'

------------------------------------Importers by Excise Tax - YoY----------------------------------------
DECLARE @sqlguid AS UNIQUEIDENTIFIER
SET @sqlguid = '53BB95DC-C44E-480E-9C83-316D1E608BAF'

DECLARE @newsqlcmd AS VARCHAR (max)
SET @newsqlcmd = 'SELECT
	 h.PartnerID,
	 h.ImporterName,
	 datepart(year, h.ImportDate) AS ImportYear,
	 CAST(SUM(d.EstBaseTotalLineExciseAmt) AS NUMERIC(28, 2)) AS [EstBaseTotalExciseTax(@CurrencyCode)]
INTO #CurrentYear 
FROM txdgvimportheader h WITH (NOLOCK) 
JOIN txdgvimportdetail d WITH (NOLOCK) 
	ON h.entryguid = d.entryguid
	AND h.partnerid = d.partnerid 
WHERE 1=1
	AND h.PartnerID = @PartnerID
	AND datepart(year, h.ImportDate) = DATEPART(year, GetDate()) 
GROUP BY
		h.PartnerID,
		h.ImporterName,
		datepart(year, h.ImportDate)

SELECT
	 h.PartnerID,
	 h.ImporterName,
	 datepart(year, h.ImportDate) AS ImportYear,
	 CAST(SUM(d.EstBaseTotalLineExciseAmt) AS NUMERIC(28, 2)) AS [EstBaseTotalExciseTax(@CurrencyCode)]
INTO #LastYear 
FROM txdgvimportheader h WITH (NOLOCK) 
JOIN txdgvimportdetail d WITH (NOLOCK) 
	ON h.entryguid = d.entryguid
	AND h.partnerid = d.partnerid
WHERE 1=1
	 And datepart(year, h.ImportDate) = DATEPART(year, dateadd(year, - 1, GetDate()))
	 And h.ImportDate <= (GETDATE()-365)
GROUP BY
		h.PartnerID,
		h.ImporterName,
		datepart(year, h.ImportDate)

SELECT TOP 10
	h.ImporterName,
	isnull(sum(h.[EstBaseTotalExciseTax(@CurrencyCode)]), 0) AS [@CurrentYear],
	isnull(sum(h2.[EstBaseTotalExciseTax(@CurrencyCode)]), 0) AS [@LastYear]
FROM #CurrentYear h
LEFT JOIN #LastYear h2 
	ON h.ImporterName = h2.ImporterName
	AND h.PartnerID = h2.PartnerID
GROUP BY
	 h.ImporterName 
ORDER BY
	 sum(h.[EstBaseTotalExciseTax(@CurrencyCode)]) 
DESC'

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
                AND Version = '20.4';

--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version = '20.4';

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
VALUES  ( @partner , -- PartnerID - int
          GETDATE() , -- EffDate - datetime
          @sqlguid , -- SQLGUID - uniqueidentifier
          @newsqlcmd , -- SQLCommand - varchar(max)
          @description , -- Description - nvarchar(100)
          @longdescription , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'jmerwin' , -- CreatedBy - varchar(50)
          'jmerwin' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.4' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )

COMMIT TRANSACTION
SET XACT_ABORT OFF;