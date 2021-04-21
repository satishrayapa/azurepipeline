SET XACT_ABORT ON;
BEGIN TRANSACTION;

SET IDENTITY_INSERT dbo.tbgSQLCommandsHist ON;
GO	

DECLARE @partner AS INT
SET @partner = 4000

DECLARE @description AS NVARCHAR (max)
SET @description = N'Top Ports of Unlading by Payments - YoY'

DECLARE @longdescription AS NVARCHAR (max)
SET @longdescription = N'This comparison report shows the ports of unlading with the highest associated total payments on all declarations filed for the current year compared to the highest associated total payments on all declarations filed for the previous year.'

------------------------------------Top Ports of Unlading by Payments - YoY----------------------------------------
DECLARE @sqlguid AS UNIQUEIDENTIFIER
SET @sqlguid = '266E1FA5-405A-44ED-B184-AF3D32AE0FFC'

DECLARE @CreatedBy AS VARCHAR(50) = '71fdb7c8-b594-4a54-848e-49c4f55cc1ce';
DECLARE @ApprovedBy AS VARCHAR(50) = '';

DECLARE @newsqlcmd AS VARCHAR (max)
SET @newsqlcmd = 'SELECT
	d.PartnerID,
	d.PortOfUnlading,
	datepart(year, h.ImportDate) AS ImportYear,
	CAST(SUM(d.EstBaseTotalLinePayments) AS NUMERIC(28, 2)) AS EstBaseTotalDeclarationPayments
INTO #CurrentYear
FROM txdgvimportheader h WITH (NOLOCK)
JOIN txdgvimportdetail d WITH (NOLOCK)
	ON h.EntryGuid = d.EntryGuid
	AND h.PartnerID = d.PartnerID
WHERE 1=1
	AND d.PartnerID = @PartnerID
	AND datepart(year, h.ImportDate) = DATEPART(year, GetDate())
GROUP BY
	d.PartnerID,
	d.PortOfUnlading,
	datepart(year, h.ImportDate)
SELECT
	d.PartnerID,
	d.PortOfUnlading,
	datepart(year, h.ImportDate) AS ImportYear,
	CAST(SUM(d.EstBaseTotalLinePayments) AS NUMERIC(28, 2)) AS EstBaseTotalDeclarationPayments
INTO #LastYear
FROM txdGVImportHeader h WITH (NOLOCK)
JOIN txdgvimportdetail d WITH (NOLOCK)
	ON h.EntryGuid = d.EntryGuid
	AND h.PartnerID = d.PartnerID
WHERE 1=1
	AND datepart(year, h.ImportDate) = DATEPART(year, dateadd(year, - 1, GetDate()))
	AND h.ImportDate <= (GETDATE() - 365)
GROUP BY
	d.PartnerID,
	d.PortOfUnlading,
	datepart(year, h.ImportDate)
SELECT TOP 10
	h.PortOfUnlading,
	isnull(sum(h.EstBaseTotalDeclarationPayments), 0) AS [@CurrentYear],
	isnull(sum(h2.EstBaseTotalDeclarationPayments), 0) AS [@LastYear]
FROM #CurrentYear h
LEFT JOIN #LastYear h2
	ON h.PortOfUnlading = h2.PortOfUnlading
	AND h.PartnerID = h2.PartnerID
GROUP BY h.PortOfUnlading
ORDER BY sum(h.EstBaseTotalDeclarationPayments) DESC'

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
          @CreatedBy , -- CreatedBy - varchar(50)
          @ApprovedBy , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.4' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )

COMMIT TRANSACTION
SET XACT_ABORT OFF;