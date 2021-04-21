SET XACT_ABORT ON;
BEGIN TRANSACTION;

SET IDENTITY_INSERT dbo.tbgSQLCommandsHist ON;
GO	

DECLARE @partner AS INT
SET @partner = 4000

DECLARE @description AS NVARCHAR (max)
SET @description = N'Declaration Volume By Ports Of Unlading - YoY'

DECLARE @longdescription AS NVARCHAR (max)
SET @longdescription = N'This comparison report shows the ports of unlading and the total number of declarations for the current year compared to the total number of declarations for the previous year.'

------------------------------------Declaration Volume By Ports Of Unlading - YoY----------------------------------------
DECLARE @sqlguid AS UNIQUEIDENTIFIER
SET @sqlguid = '07A892C1-2AEB-48D8-9C1C-AF7B00A53C38'

DECLARE @newsqlcmd AS VARCHAR (max)
SET @newsqlcmd = 'SELECT h.PartnerID,
    d.PortOfUnlading,
    datepart(year, h.ImportDate) AS ImportYear,
    COUNT(DISTINCT h.DeclarationNum) AS DeclarationCount
INTO #CurrentYearPU
FROM txdgvimportheader h WITH (NOLOCK)
JOIN txdgvimportdetail d WITH (NOLOCK) ON h.EntryGuid = d.EntryGuid
	AND h.PartnerID = d.PartnerID
 WHERE 1=1
	AND h.PartnerID = @PartnerID
	AND datepart(year, h.ImportDate) = DATEPART(year, GetDate())
GROUP BY h.PartnerID,
	PortOfUnlading,
	datepart(year, h.ImportDate)

SELECT h.PartnerID,
	d.PortOfUnlading,
	datepart(year, h.ImportDate) AS ImportYear,
	COUNT(DISTINCT h.DeclarationNum) AS DeclarationCount
INTO #LastYearPU
FROM txdGVImportHeader h WITH (NOLOCK)
JOIN txdgvimportdetail d WITH (NOLOCK) ON h.EntryGuid = d.EntryGuid
	AND h.PartnerID = d.PartnerID
WHERE datepart(year, h.ImportDate) = DATEPART(year, dateadd(year, - 1, GetDate()))
	AND h.ImportDate <= (GETDATE() - 365)
GROUP BY h.PartnerID,
	PortOfUnlading,
	datepart(year, ImportDate)

SELECT TOP 10 h.PortOfUnlading,
	isnull(sum(h.DeclarationCount), 0) AS [@CurrentYear],
	isnull(sum(h2.DeclarationCount), 0) AS [@LastYear]
FROM #CurrentYearPU h
JOIN #LastYearPU h2 ON h.PortOfUnlading = h2.PortOfUnlading
	AND h.PartnerID = h2.PartnerID
GROUP BY h.PortOfUnlading
ORDER BY sum(h.DeclarationCount) DESC'

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
          '17.1 SQL Updates' , -- CreatedBy - varchar(50)
          'jmerwin' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.4' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )

        
------------------------------------Countries of Import by Import Value - YoY----------------------------------------
SET @sqlguid = 'A1B59D4A-8257-4317-B164-2EB5B5613980'

SET @newsqlcmd = 'SELECT h.PartnerID  ,
  ImportCountry  ,
  datepart(year, ImportDate) AS ImportYear  ,
  CAST(SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 2)) AS EstBaseTotalDeclarationValue 
INTO #CurrentYear 
FROM txdGVImportHeader h WITH (NOLOCK)
JOIN txdGVImportDetail d WITH (NOLOCK)
  ON h.PartnerID = d.PartnerID AND h.EntryGuid = d.EntryGuid 
WHERE 1=1 AND h.PartnerID = @PartnerID  AND datepart(year, ImportDate) = DATEPART(year, GetDate()) 
GROUP BY h.PartnerID  ,ImportCountry  ,datepart(year, ImportDate)  

SELECT h.PartnerID  ,
  ImportCountry  ,
  datepart(year, ImportDate) AS ImportYear  ,
  CAST(SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 2)) AS EstBaseTotalDeclarationValue 
INTO #LastYear 
FROM txdGVImportHeader h WITH (NOLOCK)
JOIN txdGVImportDetail d WITH (NOLOCK)
  ON h.PartnerID = d.PartnerID AND h.EntryGuid = d.EntryGuid
WHERE 1=1 AND datepart(year, ImportDate) = DATEPART(year, dateadd(year, - 1, GetDate()))  AND ImportDate <= (GETDATE() - 365) 
GROUP BY h.PartnerID  ,ImportCountry  ,datepart(year, ImportDate)  

SELECT TOP 10 d.ImportCountry  ,
  isnull(sum(d.EstBaseTotalDeclarationValue), 0) AS [@CurrentYear]  ,
  isnull(sum(d2.EstBaseTotalDeclarationValue), 0) AS [@LastYear] 
FROM #CurrentYear d 
LEFT JOIN #LastYear d2 ON d.ImportCountry = d2.ImportCountry  AND d.PartnerID = d2.PartnerID 
GROUP BY d.ImportCountry 
ORDER BY sum(d.EstBaseTotalDeclarationValue) DESC'
SET @description = N'Countries of Import by Import Value - YoY'
SET @longdescription = N'This comparison report shows the countries of import with the highest associated total declaration value on all declarations filed for the current year compared to the highest associated total declaration value on all declarations filed for the previous year.'

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
          '41c55542-19fa-4d26-86ca-e21c53ec1a5d' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.4' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )


        ------------------------------------Total Shipment Value by Month - YoY----------------------------------------
SET @sqlguid = 'CE917944-4BD4-495F-95A5-A4040742F66F'

SET @newsqlcmd = 'SELECT  h.PartnerID ,
        DATEPART(YEAR, ExportDate) AS ExportYear ,
        DATEPART(MONTH, ExportDate) AS ExportMonth ,
        CAST(SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 2)) AS EstBaseTotalLineValue
INTO    #CurrentYear
FROM    txdGVExportHeader h WITH ( NOLOCK )
JOIN dbo.txdGVExportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.ExportGUID = h.ExportGuid
 WHERE 1=1  AND  DATEPART(YEAR, h.ExportDate) = DATEPART(YEAR, GETDATE())  AND h.PartnerID = @PartnerID 
AND DATEPART(YEAR, ExportDate) = DATEPART(YEAR, GETDATE())
GROUP BY h.PartnerID ,
        DATEPART(YEAR, ExportDate) ,
        DATEPART(MONTH, ExportDate)
SELECT  h.PartnerID ,
        DATEPART(YEAR, ExportDate) AS ExportYear ,
        DATEPART(MONTH, ExportDate) AS ExportMonth ,
        CAST(SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 2)) AS EstBaseTotalLineValue
INTO    #LastYear
FROM    txdGVExportHeader h WITH (NOLOCK)
JOIN dbo.txdGVExportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.ExportGUID = h.ExportGuid
WHERE   1=1  AND  DATEPART(YEAR, ExportDate) = DATEPART(YEAR,
                                              DATEADD(YEAR, -1, GETDATE()))
        AND ExportDate <= ( GETDATE() - 365 )
GROUP BY h.PartnerID ,
        DATEPART(YEAR, ExportDate) ,
        DATEPART(MONTH, ExportDate)
SELECT TOP 10
        d.ExportMonth ,
        ISNULL(SUM(d.EstBaseTotalLineValue), 0) AS [@CurrentYear] ,
        ISNULL(SUM(d2.EstBaseTotalLineValue), 0) AS [@LastYear]
FROM    #CurrentYear d
        LEFT JOIN #LastYear d2 ON d.ExportMonth = d2.ExportMonth
                                  AND d.PartnerID = d2.PartnerID
GROUP BY d.ExportMonth
ORDER BY d.ExportMonth ASC'
SET @description = N'Total Shipment Value by Month - YoY'
SET @longdescription = N'This report shows the total value of all exports declared during each month of the current year compared to the total value of all exports during the same month(s) during the previous year.'

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
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.4' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )

------------------------------------All Brokers: Value vs. Duty----------------------------------------
SET @sqlguid = '7126C116-BFDB-4A09-9DD2-ECC2E9684459'

SET @newsqlcmd = 'SELECT  h.BrokerName,   
  CAST(SUM(d.EstBaseTotalLineValue) as Numeric(28,2)) as [EstBaseTotalValue (@CurrencyCode)],  
  CAST(SUM(d.EstBaseTotalLineDuty) AS NUMERIC(28, 2)) as [EstBaseTotalDuty (@CurrencyCode)] 
FROM txdGVImportHeader h WITH (NOLOCK)
JOIN txdGVImportDetail d WITH (NOLOCK)
  ON h.PartnerID = d.PartnerID AND h.EntryGuid = d.EntryGuid
WHERE 1=1 AND h.PartnerID = @PartnerID  
GROUP BY h.BrokerName  
ORDER BY SUM(d.EstBaseTotalLineValue) DESC, SUM(d.EstBaseTotalLineDuty) DESC'
SET @description = N'All Brokers: Value vs. Duty'
SET @longdescription = N'This comparison report shows all brokers and the associated total declaration value compared to the total duty paid on all declarations filed. This report is used to compare the amount of value imported relating to a broker to the amount of duty paid relating to that broker''s filings.'

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
          'jmerwin' , -- CreatedBy - varchar(50)
          'jmerwin' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.4' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)	


------------------------------------Ports of Unlading by Value - YoY----------------------------------------
SET @sqlguid = '5B73E37D-E1AF-435D-9880-ACCDB0998E3B'

SET @newsqlcmd = 'SELECT  d.PartnerID ,
        d.PortOfUnlading ,
        DATEPART(YEAR, h.ImportDate) AS ImportYear ,
        CAST(SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 2)) AS EstBaseTotalDeclarationValue
INTO    #CurrentYear
FROM    txdGVImportHeader h WITH ( NOLOCK )
        JOIN txdGVImportDetail d WITH ( NOLOCK ) ON h.EntryGuid = d.EntryGuid
                                                    AND h.PartnerID = d.PartnerID
WHERE 1=1 AND h.PartnerID = @PartnerID 
AND DATEPART(YEAR, h.ImportDate) = DATEPART(YEAR, GETDATE())
GROUP BY d.PartnerID ,
        d.PortOfUnlading ,
        DATEPART(YEAR, h.ImportDate)
SELECT  h.PartnerID ,
        PortOfUnlading ,
        DATEPART(YEAR, h.ImportDate) AS ImportYear ,
        CAST(SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 2)) AS EstBaseTotalDeclarationValue
INTO    #LastYear
FROM    txdGVImportHeader h WITH ( NOLOCK )
        JOIN txdGVImportDetail d WITH ( NOLOCK ) ON h.EntryGuid = d.EntryGuid
                                                    AND h.PartnerID = d.PartnerID
WHERE   DATEPART(YEAR, ImportDate) = DATEPART(YEAR,
                                              DATEADD(YEAR, -1, GETDATE()))
GROUP BY h.PartnerID ,
        d.PortOfUnlading ,
        DATEPART(YEAR, h.ImportDate)
SELECT TOP 10
        y.PortOfUnlading ,
        ISNULL(SUM(y.EstBaseTotalDeclarationValue), 0) AS [@CurrentYear] ,
        ISNULL(SUM(y2.EstBaseTotalDeclarationValue), 0) AS [@LastYear]
FROM    #CurrentYear y
        JOIN #LastYear y2 ON y.PortOfUnlading = y2.PortOfUnlading
                             AND y.PartnerID = y2.PartnerID
GROUP BY y.PortOfUnlading
ORDER BY SUM(y.EstBaseTotalDeclarationValue) DESC'
SET @description = N'Ports of Unlading by Value - YoY'
SET @longdescription = N'This comparison report shows the ports of unlading with the highest associated total declaration value on all declarations filed for the current year compared to the highest associated total declaration value on all declarations filed for the previous year. '


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
VALUES  ( @partner , -- PartnerID - int
          GETDATE() , -- EffDate - datetime
          @sqlguid , -- SQLGUID - uniqueidentifier
          @newsqlcmd , -- SQLCommand - varchar(max)
          @description , -- Description - nvarchar(100)
          @longdescription , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          '17.1 SQL Updates' , -- CreatedBy - varchar(50)
          'jmerwin' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.4' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	

COMMIT TRANSACTION
SET XACT_ABORT OFF;