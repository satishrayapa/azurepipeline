SET XACT_ABORT ON;
BEGIN TRANSACTION;

SET IDENTITY_INSERT dbo.tbgSQLCommandsHist OFF;
GO	

DECLARE @partner AS INT
SET @partner = 4000
------------------------------------Total Shipment Value by Month - YoY------------------------------------
DECLARE @CurrentSQLGuid1 AS VARCHAR(36) = 'CE917944-4BD4-495F-95A5-A4040742F66F';
DECLARE @CurrentSQLDescription1 AS NVARCHAR(100) = 'Total Shipment Value by Month - YoY';
DECLARE @CurrentSQLLongDescription1 AS NVARCHAR(MAX) = 'This report shows the total value of all exports declared during each month of the current year compared to the total value of all exports during the same month(s) during the previous year.';
DECLARE @CurrentCreatedBy1 AS VARCHAR(50) = 'kduval';
DECLARE @CurrentApprovedBy1 AS VARCHAR(50) = '';

DECLARE @CurrentSQLScript1 AS NVARCHAR(MAX) = 'SELECT  h.PartnerID ,
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
WHERE 1=1 AND  DATEPART(YEAR, ExportDate) = DATEPART(YEAR,
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
ORDER BY d.ExportMonth ASC';


--insert old records into hist
INSERT INTO dbo.tbgSQLCommandsHist
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
          KeepDuringRollback   )
        SELECT  PartnerID ,
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
        FROM    dbo.tbgSQLCommands WITH ( NOLOCK )
        WHERE   SQLGUID = @CurrentSQLGuid1
                AND Version = '20.4';

--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @CurrentSQLGuid1
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
          @CurrentSQLGuid1 , -- SQLGUID - uniqueidentifier
          @CurrentSQLScript1 , -- SQLCommand - varchar(max)
          @CurrentSQLDescription1 , -- Description - nvarchar(100)
          @CurrentSQLLongDescription1 , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @CurrentCreatedBy1 , -- CreatedBy - varchar(50)
          @CurrentApprovedBy1 , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@CurrentSQLScript1,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.4' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )


------------------------------------Value Exported by Ship To - YoY ------------------------------------
DECLARE @CurrentSQLGuid2 AS VARCHAR(36) = '50B44CB4-BE51-422B-B1E6-148837555B36';
DECLARE @CurrentSQLDescription2 AS NVARCHAR(100) = 'Value Exported by Ship To - YoY ';
DECLARE @CurrentSQLLongDescription2 AS NVARCHAR(MAX) = 'This comparison report shows the Ship To company names with the highest associated total Shipment Value on all shipments for the current calendar year compared to the associated total Shipment Value on all shipments filed for the previous calendar year.';
DECLARE @CurrentCreatedBy2 AS VARCHAR(50) = 'jmurillo';
DECLARE @CurrentApprovedBy2 AS VARCHAR(50) = '';

DECLARE @CurrentSQLScript2 AS NVARCHAR(MAX) = 'select   h.PartnerID, 
  ShipToCompanyName, 
  datepart(year, ExportDate) as ExportYear, 
  CAST(SUM(d.EstBaseTotalLineValue) as Numeric(28,2)) as EstBaseTotalShipmentValue 
INTO #CurrentYear  
FROM txdGVExportHeader h WITH (NOLOCK)
JOIN txdGVExportDetail d WITH (NOLOCK)
  ON h.PartnerID = d.PartnerID AND h.ExportGuid = d.ExportGuid
WHERE 1=1 AND @EXPORTDATERANGE AND h.PartnerID = @PartnerID 
  and  datepart(year, ExportDate) =  DATEPART(year, GetDate())  
group by h.PartnerID, ShipToCompanyName, datepart(year, ExportDate)  

select   h.PartnerID, 
  ShipToCompanyName, 
  datepart(year, ExportDate) as ExportYear,
  CAST(SUM(d.EstBaseTotalLineValue) as Numeric(28,2)) as EstBaseTotalShipmentValue 
INTO #LastYear  
FROM txdGVExportHeader h WITH (NOLOCK)
JOIN txdGVExportDetail d WITH (NOLOCK)
  ON h.PartnerID = d.PartnerID 
  AND h.ExportGuid = d.ExportGuid
WHERE 1=1 AND   datepart(year, ExportDate) =  DATEPART(year, dateadd(year, -1, GetDate())) and ExportDate <= (GETDATE()-365) 
group by h.PartnerID, ShipToCompanyName, datepart(year, ExportDate)   

SELECT TOP 10   d.ShipToCompanyName,    
  isnull(sum(d.EstBaseTotalShipmentValue), 0) as [@CurrentYear],  
  isnull(sum(d2.EstBaseTotalShipmentValue), 0) as [@LastYear] 
FROM #CurrentYear d 
left join #LastYear d2 
  on   d.ShipToCompanyName= d2.ShipToCompanyName 
  and  d.PartnerID = d2.PartnerID 
Group By d.ShipToCompanyName 
ORDER BY sum(d.EstBaseTotalShipmentValue) DESC';


--insert old records into hist
INSERT INTO dbo.tbgSQLCommandsHist
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
          KeepDuringRollback   )
        SELECT  PartnerID ,
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
        FROM    dbo.tbgSQLCommands WITH ( NOLOCK )
        WHERE   SQLGUID = @CurrentSQLGuid2
                AND Version = '20.4';

--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @CurrentSQLGuid2
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
          @CurrentSQLGuid2 , -- SQLGUID - uniqueidentifier
          @CurrentSQLScript2 , -- SQLCommand - varchar(max)
          @CurrentSQLDescription2 , -- Description - nvarchar(100)
          @CurrentSQLLongDescription2 , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @CurrentCreatedBy2 , -- CreatedBy - varchar(50)
          @CurrentApprovedBy2 , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@CurrentSQLScript2,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.4' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )


------------------------------------------------------------------------
DECLARE @CurrentSQLGuid3 AS VARCHAR(36) = 'F427119D-DE7B-4323-A0CF-4234951B478F';
DECLARE @CurrentSQLDescription3 AS NVARCHAR(100) = '';
DECLARE @CurrentSQLLongDescription3 AS NVARCHAR(MAX) = 'This comparison report shows the Ultimate Consignee company names with the highest associated total Shipment Value on all shipments for the current calendar year compared to the associated total Shipment Value on all shipments filed for the previous calendar year.';
DECLARE @CurrentCreatedBy3 AS VARCHAR(50) = 'jmurillo';
DECLARE @CurrentApprovedBy3 AS VARCHAR(50) = '';

DECLARE @CurrentSQLScript3 AS NVARCHAR(MAX) = 'select   h.PartnerID, 
  UltimateConsigneeCompanyName, 
  datepart(year, ExportDate) as ExportYear, 
  CAST(SUM(d.EstBaseTotalLineValue) as Numeric(28,2)) as EstBaseTotalShipmentValue 
INTO #CurrentYear  
FROM txdGVExportHeader h WITH (NOLOCK)
JOIN txdGVExportDetail d WITH (NOLOCK)
  ON h.PartnerID = d.PartnerID AND h.ExportGuid = d.ExportGuid
WHERE 1=1 AND @EXPORTDATERANGE AND h.PartnerID = @PartnerID 
  and  datepart(year, ExportDate) =  DATEPART(year, GetDate())  
group by h.PartnerID, UltimateConsigneeCompanyName, datepart(year, ExportDate)  

select   h.PartnerID, 
  UltimateConsigneeCompanyName, 
  datepart(year, ExportDate) as ExportYear, 
  CAST(SUM(d.EstBaseTotalLineValue) as Numeric(28,2)) as EstBaseTotalShipmentValue 
INTO #LastYear  
FROM txdGVExportHeader h WITH (NOLOCK)
JOIN txdGVExportDetail d WITH (NOLOCK)
  ON h.PartnerID = d.PartnerID AND h.ExportGuid = d.ExportGuid
WHERE 1=1 AND   datepart(year, ExportDate) =  DATEPART(year, dateadd(year, -1, GetDate())) 
  and ExportDate <= (GETDATE()-365) 
group by h.PartnerID, UltimateConsigneeCompanyName, datepart(year, ExportDate)   

SELECT TOP 10   d.UltimateConsigneeCompanyName,    
  isnull(sum(d.EstBaseTotalShipmentValue), 0) as [@CurrentYear],  
  isnull(sum(d2.EstBaseTotalShipmentValue), 0) as [@LastYear] 
FROM #CurrentYear d 
left join #LastYear d2 
  on   d.UltimateConsigneeCompanyName = d2.UltimateConsigneeCompanyName and  d.PartnerID = d2.PartnerID 
Group By d.UltimateConsigneeCompanyName 
ORDER BY sum(d.EstBaseTotalShipmentValue) DESC';


--insert old records into hist
INSERT INTO dbo.tbgSQLCommandsHist
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
          KeepDuringRollback   )
        SELECT  PartnerID ,
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
        FROM    dbo.tbgSQLCommands WITH ( NOLOCK )
        WHERE   SQLGUID = @CurrentSQLGuid3
                AND Version = '20.4';

--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @CurrentSQLGuid3
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
          @CurrentSQLGuid3 , -- SQLGUID - uniqueidentifier
          @CurrentSQLScript3 , -- SQLCommand - varchar(max)
          @CurrentSQLDescription3 , -- Description - nvarchar(100)
          @CurrentSQLLongDescription3 , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @CurrentCreatedBy3 , -- CreatedBy - varchar(50)
          @CurrentApprovedBy3 , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@CurrentSQLScript3,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.4' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )


------------------------------------Value Exported by Ship From - YoY ------------------------------------
DECLARE @CurrentSQLGuid4 AS VARCHAR(36) = '5973D5E0-8388-4BD7-B439-9D325D4E53F8';
DECLARE @CurrentSQLDescription4 AS NVARCHAR(100) = 'Value Exported by Ship From - YoY ';
DECLARE @CurrentSQLLongDescription4 AS NVARCHAR(MAX) = 'This comparison report shows the Ship From company names with the highest associated total Shipment Value on all shipments for the current calendar year compared to the associated total Shipment Value on all shipments filed for the previous calendar year.';
DECLARE @CurrentCreatedBy4 AS VARCHAR(50) = 'jmurillo';
DECLARE @CurrentApprovedBy4 AS VARCHAR(50) = '';

DECLARE @CurrentSQLScript4 AS NVARCHAR(MAX) = 'select   h.PartnerID, 
  ShipFromCompanyName, 
  datepart(year, ExportDate) as ExportYear, 
  CAST(SUM(d.EstBaseTotalLineValue) as Numeric(28,2)) as EstBaseTotalShipmentValue 
INTO #CurrentYear  
FROM txdGVExportHeader h WITH (NOLOCK)
JOIN txdGVExportDetail d WITH (NOLOCK)
  ON h.PartnerID = d.PartnerID AND h.ExportGuid = d.ExportGuid
WHERE 1=1 AND @EXPORTDATERANGE AND h.PartnerID = @PartnerID 
  and  datepart(year, ExportDate) =  DATEPART(year, GetDate())  
group by h.PartnerID, ShipFromCompanyName, datepart(year, ExportDate)  

select   h.PartnerID, 
  ShipFromCompanyName, 
  datepart(year, ExportDate) as ExportYear, 
  CAST(SUM(d.EstBaseTotalLineValue) as Numeric(28,2)) as EstBaseTotalShipmentValue 
INTO #LastYear  
FROM txdGVExportHeader h WITH (NOLOCK)
JOIN txdGVExportDetail d WITH (NOLOCK)
  ON h.PartnerID = d.PartnerID AND h.ExportGuid = d.ExportGuid
WHERE 1=1 AND   datepart(year, ExportDate) =  DATEPART(year, dateadd(year, -1, GetDate())) 
  and ExportDate <= (GETDATE()-365) 
group by h.PartnerID, ShipFromCompanyName, datepart(year, ExportDate)   

SELECT TOP 10   d.ShipFromCompanyName,    
  isnull(sum(d.EstBaseTotalShipmentValue), 0) as [@CurrentYear],  
  isnull(sum(d2.EstBaseTotalShipmentValue), 0) as [@LastYear] 
FROM #CurrentYear d 
left join #LastYear d2 
on   d.ShipFromCompanyName = d2.ShipFromCompanyName and  d.PartnerID = d2.PartnerID 
Group By d.ShipFromCompanyName 
ORDER BY sum(d.EstBaseTotalShipmentValue) DESC';


--insert old records into hist
INSERT INTO dbo.tbgSQLCommandsHist
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
          KeepDuringRollback   )
        SELECT  PartnerID ,
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
        FROM    dbo.tbgSQLCommands WITH ( NOLOCK )
        WHERE   SQLGUID = @CurrentSQLGuid4
                AND Version = '20.4';

--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @CurrentSQLGuid4
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
          @CurrentSQLGuid4 , -- SQLGUID - uniqueidentifier
          @CurrentSQLScript4 , -- SQLCommand - varchar(max)
          @CurrentSQLDescription4 , -- Description - nvarchar(100)
          @CurrentSQLLongDescription4 , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @CurrentCreatedBy4 , -- CreatedBy - varchar(50)
          @CurrentApprovedBy4 , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@CurrentSQLScript4,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.4' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )


------------------------------------------------------------------------
DECLARE @CurrentSQLGuid5 AS VARCHAR(36) = '0B5FC017-63DF-4649-9D53-A72321F2FAD3';
DECLARE @CurrentSQLDescription5 AS NVARCHAR(100) = '';
DECLARE @CurrentSQLLongDescription5 AS NVARCHAR(MAX) = 'This comparison report shows the Inland Carrier with the highest associated total Shipment Value on all shipments for the current calendar year compared to the associated total Shipment Value on all shipments filed for the previous calendar year.';
DECLARE @CurrentCreatedBy5 AS VARCHAR(50) = 'jmurillo';
DECLARE @CurrentApprovedBy5 AS VARCHAR(50) = '';

DECLARE @CurrentSQLScript5 AS NVARCHAR(MAX) = 'select   h.PartnerID, 
  InlandCarrierCompanyName, datepart(year, ExportDate) as ExportYear, 
  CAST(SUM(d.EstBaseTotalLineValue) as Numeric(28,2)) as EstBaseTotalShipmentValue 
INTO #CurrentYear  
FROM txdGVExportHeader h WITH (NOLOCK)
JOIN txdGVExportDetail d WITH (NOLOCK)
  ON h.PartnerID = d.PartnerID AND h.ExportGuid = d.ExportGuid
WHERE 1=1 AND @EXPORTDATERANGE AND h.PartnerID = @PartnerID 
  and  datepart(year, ExportDate) =  DATEPART(year, GetDate())  
group by h.PartnerID, InlandCarrierCompanyName, datepart(year, ExportDate)  

select   h.PartnerID, 
  InlandCarrierCompanyName, datepart(year, ExportDate) as ExportYear, 
  CAST(SUM(d.EstBaseTotalLineValue) as Numeric(28,2)) as EstBaseTotalShipmentValue 
INTO #LastYear  
FROM txdGVExportHeader h WITH (NOLOCK)
JOIN txdGVExportDetail d WITH (NOLOCK)
  ON h.PartnerID = d.PartnerID AND h.ExportGuid = d.ExportGuid 
WHERE 1=1 AND   datepart(year, ExportDate) =  DATEPART(year, dateadd(year, -1, GetDate())) and ExportDate <= (GETDATE()-365) 
group by h.PartnerID, InlandCarrierCompanyName, datepart(year, ExportDate)   

SELECT TOP 10   d.InlandCarrierCompanyName,    
  isnull(sum(d.EstBaseTotalShipmentValue), 0) as [@CurrentYear],  
  isnull(sum(d2.EstBaseTotalShipmentValue), 0) as [@LastYear] 
FROM #CurrentYear d
left join #LastYear d2 
  on   d.InlandCarrierCompanyName = d2.InlandCarrierCompanyName and d.PartnerID = d2.PartnerID 
Group By d.InlandCarrierCompanyName 
ORDER BY sum(d.EstBaseTotalShipmentValue) DESC';


--insert old records into hist
INSERT INTO dbo.tbgSQLCommandsHist
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
          KeepDuringRollback   )
        SELECT  PartnerID ,
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
        FROM    dbo.tbgSQLCommands WITH ( NOLOCK )
        WHERE   SQLGUID = @CurrentSQLGuid5
                AND Version = '20.4';

--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @CurrentSQLGuid5
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
          @CurrentSQLGuid5 , -- SQLGUID - uniqueidentifier
          @CurrentSQLScript5 , -- SQLCommand - varchar(max)
          @CurrentSQLDescription5 , -- Description - nvarchar(100)
          @CurrentSQLLongDescription5 , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @CurrentCreatedBy5 , -- CreatedBy - varchar(50)
          @CurrentApprovedBy5 , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@CurrentSQLScript5,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.4' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )


------------------------------------------------------------------------
DECLARE @CurrentSQLGuid6 AS VARCHAR(36) = 'A5ADF254-9AE4-4BF2-B15B-FA70D77FB67D';
DECLARE @CurrentSQLDescription6 AS NVARCHAR(100) = '';
DECLARE @CurrentSQLLongDescription6 AS NVARCHAR(MAX) = 'This comparison report shows the Seller company names with the highest associated total Shipment Value on all shipments for the current calendar year compared to the associated total Shipment Value on all shipments filed for the previous calendar year.';
DECLARE @CurrentCreatedBy6 AS VARCHAR(50) = 'jmurillo';
DECLARE @CurrentApprovedBy6 AS VARCHAR(50) = '';

DECLARE @CurrentSQLScript6 AS NVARCHAR(MAX) = 'select   h.PartnerID, 
  SellerCompanyName, 
  datepart(year, ExportDate) as ExportYear, 
  CAST(SUM(d.EstBaseTotalLineValue) as Numeric(28,2)) as EstBaseTotalShipmentValue 
INTO #CurrentYear  
FROM txdGVExportHeader h WITH (NOLOCK)
JOIN txdGVExportDetail d WITH (NOLOCK)
  ON h.PartnerID = d.PartnerID AND h.ExportGuid = d.ExportGuid
WHERE 1=1 AND @EXPORTDATERANGE AND h.PartnerID = @PartnerID and  datepart(year, ExportDate) =  DATEPART(year, GetDate())  
group by h.PartnerID, SellerCompanyName, datepart(year, ExportDate)  

select   h.PartnerID, 
  SellerCompanyName, 
  datepart(year, ExportDate) as ExportYear, 
  CAST(SUM(d.EstBaseTotalLineValue) as Numeric(28,2)) as EstBaseTotalShipmentValue 
INTO #LastYear  
FROM txdGVExportHeader h WITH (NOLOCK)
JOIN txdGVExportDetail d WITH (NOLOCK)
  ON h.PartnerID = d.PartnerID AND h.ExportGuid = d.ExportGuid
WHERE 1=1 AND   datepart(year, ExportDate) =  DATEPART(year, dateadd(year, -1, GetDate())) and ExportDate <= (GETDATE()-365) 
group by h.PartnerID, SellerCompanyName, datepart(year, ExportDate)   

SELECT TOP 10   d.SellerCompanyName,    
  isnull(sum(d.EstBaseTotalShipmentValue), 0) as [@CurrentYear],  
  isnull(sum(d2.EstBaseTotalShipmentValue), 0) as [@LastYear] 
FROM #CurrentYear d 
left join #LastYear d2 
  on   d.SellerCompanyName= d2.SellerCompanyName and  d.PartnerID = d2.PartnerID 
Group By d.SellerCompanyName 
ORDER BY sum(d.EstBaseTotalShipmentValue) DESC';


--insert old records into hist
INSERT INTO dbo.tbgSQLCommandsHist
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
          KeepDuringRollback   )
        SELECT  PartnerID ,
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
        FROM    dbo.tbgSQLCommands WITH ( NOLOCK )
        WHERE   SQLGUID = @CurrentSQLGuid6
                AND Version = '20.4';

--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @CurrentSQLGuid6
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
          @CurrentSQLGuid6 , -- SQLGUID - uniqueidentifier
          @CurrentSQLScript6 , -- SQLCommand - varchar(max)
          @CurrentSQLDescription6 , -- Description - nvarchar(100)
          @CurrentSQLLongDescription6 , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @CurrentCreatedBy6 , -- CreatedBy - varchar(50)
          @CurrentApprovedBy6 , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@CurrentSQLScript6,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.4' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )


------------------------------------Weight Shipped by Product Number - YoY------------------------------------
DECLARE @CurrentSQLGuid7 AS VARCHAR(36) = '6C120482-645E-4473-B85A-BCEE534B6B0B';
DECLARE @CurrentSQLDescription7 AS NVARCHAR(100) = 'Weight Shipped by Product Number - YoY';
DECLARE @CurrentSQLLongDescription7 AS NVARCHAR(MAX) = 'This comparison report shows all Product Numbers and the associated total weight shipped during the current year to date compared to the total weight shipped during the previous year.';
DECLARE @CurrentCreatedBy7 AS VARCHAR(50) = 'kduval';
DECLARE @CurrentApprovedBy7 AS VARCHAR(50) = '';

DECLARE @CurrentSQLScript7 AS NVARCHAR(MAX) = 'SELECT  h.PartnerID ,
        d.ProductNum ,
        DATEPART(YEAR, ExportDate) AS ExportYear ,
        CAST(SUM(d.NetWeight) AS NUMERIC(28, 0)) AS TotalWeightShipped
INTO    #CurrentYear
FROM    txdGVExportHeader h WITH ( NOLOCK )
        JOIN txdGVExportDetail d WITH ( NOLOCK ) ON h.ExportGuid = d.ExportGUID
                                                    AND h.PartnerID = d.PartnerID
WHERE 1=1 AND @EXPORTDATERANGE AND h.PartnerID = @PartnerID 
        AND DATEPART(YEAR, ExportDate) = DATEPART(YEAR, GETDATE())
GROUP BY h.PartnerID ,
        d.ProductNum ,
        DATEPART(YEAR, ExportDate)
SELECT  h.PartnerID ,
        d.ProductNum ,
        DATEPART(YEAR, ExportDate) AS ExportYear ,
        CAST(SUM(d.NetWeight) AS NUMERIC(28, 0)) AS TotalWeightShipped
INTO    #LastYear
FROM    txdGVExportHeader h WITH ( NOLOCK )
        JOIN txdGVExportDetail d WITH ( NOLOCK ) ON h.ExportGuid = d.ExportGUID
                                                    AND h.PartnerID = d.PartnerID
WHERE 1=1 AND   DATEPART(YEAR, ExportDate) = DATEPART(YEAR,
                                              DATEADD(YEAR, -1, GETDATE()))
        AND ExportDate <= ( GETDATE() - 365 )
GROUP BY h.PartnerID ,
        d.ProductNum ,
        DATEPART(YEAR, ExportDate)
SELECT TOP 10
        y.ProductNum ,
        ISNULL(SUM(y.TotalWeightShipped), 0) AS [@CurrentYear] ,
        ISNULL(SUM(y2.TotalWeightShipped), 0) AS [@LastYear]
FROM    #CurrentYear y
        LEFT JOIN #LastYear y2 ON y.ProductNum = y2.ProductNum
                                  AND y.PartnerID = y2.PartnerID
GROUP BY y.ProductNum
ORDER BY SUM(y.TotalWeightShipped) DESC';


--insert old records into hist
INSERT INTO dbo.tbgSQLCommandsHist
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
          KeepDuringRollback   )
        SELECT  PartnerID ,
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
        FROM    dbo.tbgSQLCommands WITH ( NOLOCK )
        WHERE   SQLGUID = @CurrentSQLGuid7
                AND Version = '20.4';

--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @CurrentSQLGuid7
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
          @CurrentSQLGuid7 , -- SQLGUID - uniqueidentifier
          @CurrentSQLScript7 , -- SQLCommand - varchar(max)
          @CurrentSQLDescription7 , -- Description - nvarchar(100)
          @CurrentSQLLongDescription7 , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @CurrentCreatedBy7 , -- CreatedBy - varchar(50)
          @CurrentApprovedBy7 , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@CurrentSQLScript7,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.4' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )


------------------------------------Weight Shipped by Import Country - YoY------------------------------------
DECLARE @CurrentSQLGuid8 AS VARCHAR(36) = '456F550E-59DC-417E-9C64-29339D6F16AE';
DECLARE @CurrentSQLDescription8 AS NVARCHAR(100) = 'Weight Shipped by Import Country - YoY';
DECLARE @CurrentSQLLongDescription8 AS NVARCHAR(MAX) = 'This comparison report shows all Forwarders and the associated total weight shipped during the current year to date compared to the total weight shipped during the previous year.';
DECLARE @CurrentCreatedBy8 AS VARCHAR(50) = 'kduval';
DECLARE @CurrentApprovedBy8 AS VARCHAR(50) = '';

DECLARE @CurrentSQLScript8 AS NVARCHAR(MAX) = 'SELECT  h.PartnerID ,
        ImportCountry ,
        DATEPART(YEAR, ExportDate) AS ExportYear ,
        CAST(SUM(d.NetWeight) AS NUMERIC(28, 0)) AS TotalWeightShipped
INTO    #CurrentYear
FROM    txdGVExportHeader h WITH ( NOLOCK )
JOIN dbo.txdGVExportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.ExportGUID = h.ExportGuid
WHERE 1=1 AND @EXPORTDATERANGE AND h.PartnerID = @PartnerID 
        AND DATEPART(YEAR, ExportDate) = DATEPART(YEAR, GETDATE())
GROUP BY h.PartnerID ,
        ImportCountry ,
        DATEPART(YEAR, ExportDate)
SELECT  h.PartnerID ,
        ImportCountry ,
        DATEPART(YEAR, ExportDate) AS ExportYear ,
        CAST(SUM(d.NetWeight) AS NUMERIC(28, 0)) AS TotalWeightShipped
INTO    #LastYear
FROM    txdGVExportHeader h WITH (NOLOCK)
JOIN dbo.txdGVExportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.ExportGUID = h.ExportGuid
WHERE 1=1 AND   DATEPART(YEAR, ExportDate) = DATEPART(YEAR,
                                              DATEADD(YEAR, -1, GETDATE()))
        AND ExportDate <= ( GETDATE() - 365 )
GROUP BY h.PartnerID ,
        ImportCountry ,
        DATEPART(YEAR, ExportDate)
SELECT TOP 10
        y.ImportCountry ,
        ISNULL(SUM(y.TotalWeightShipped), 0) AS [@CurrentYear] ,
        ISNULL(SUM(y2.TotalWeightShipped), 0) AS [@LastYear]
FROM    #CurrentYear y
        LEFT JOIN #LastYear y2 ON y.ImportCountry = y2.ImportCountry
                                  AND y.PartnerID = y2.PartnerID
GROUP BY y.ImportCountry
ORDER BY SUM(y.TotalWeightShipped) DESC';


--insert old records into hist
INSERT INTO dbo.tbgSQLCommandsHist
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
          KeepDuringRollback   )
        SELECT  PartnerID ,
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
        FROM    dbo.tbgSQLCommands WITH ( NOLOCK )
        WHERE   SQLGUID = @CurrentSQLGuid8
                AND Version = '20.4';

--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @CurrentSQLGuid8
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
          @CurrentSQLGuid8 , -- SQLGUID - uniqueidentifier
          @CurrentSQLScript8 , -- SQLCommand - varchar(max)
          @CurrentSQLDescription8 , -- Description - nvarchar(100)
          @CurrentSQLLongDescription8 , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @CurrentCreatedBy8 , -- CreatedBy - varchar(50)
          @CurrentApprovedBy8 , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@CurrentSQLScript8,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.4' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )


------------------------------------Weight Shipped by Por of Lading - YoY------------------------------------
DECLARE @CurrentSQLGuid9 AS VARCHAR(36) = 'B32803D4-24FE-4C93-9CFE-75F7836480E2';
DECLARE @CurrentSQLDescription9 AS NVARCHAR(100) = 'Weight Shipped by Por of Lading - YoY';
DECLARE @CurrentSQLLongDescription9 AS NVARCHAR(MAX) = 'This comparison report shows all Ports of Lading and the associated total weight shipped during the current year to date compared to the total weight shipped during the previous year.';
DECLARE @CurrentCreatedBy9 AS VARCHAR(50) = 'kduval';
DECLARE @CurrentApprovedBy9 AS VARCHAR(50) = '';

DECLARE @CurrentSQLScript9 AS NVARCHAR(MAX) = 'SELECT  h.PartnerID ,
        PortOfLading ,
        DATEPART(YEAR, ExportDate) AS ExportYear ,
        CAST(SUM(d.NetWeight) AS NUMERIC(28, 0)) AS TotalWeightShipped
INTO    #CurrentYear
FROM    txdGVExportHeader h WITH ( NOLOCK )
JOIN dbo.txdGVExportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.ExportGUID = h.ExportGuid
WHERE 1=1 AND @EXPORTDATERANGE AND h.PartnerID = @PartnerID 
        AND DATEPART(YEAR, ExportDate) = DATEPART(YEAR, GETDATE())
GROUP BY h.PartnerID ,
        PortOfLading ,
        DATEPART(YEAR, ExportDate)
SELECT  h.PartnerID ,
        PortOfLading ,
        DATEPART(YEAR, ExportDate) AS ExportYear ,
        CAST(SUM(d.NetWeight) AS NUMERIC(28, 0)) AS TotalWeightShipped
INTO    #LastYear
FROM    txdGVExportHeader h WITH (NOLOCK)
JOIN dbo.txdGVExportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.ExportGUID = h.ExportGuid
WHERE 1=1 AND   DATEPART(YEAR, ExportDate) = DATEPART(YEAR,
                                              DATEADD(YEAR, -1, GETDATE()))
        AND ExportDate <= ( GETDATE() - 365 )
GROUP BY h.PartnerID ,
        PortOfLading ,
        DATEPART(YEAR, ExportDate)
SELECT TOP 10
        y.PortOfLading ,
        ISNULL(SUM(y.TotalWeightShipped), 0) AS [@CurrentYear] ,
        ISNULL(SUM(y2.TotalWeightShipped), 0) AS [@LastYear]
FROM    #CurrentYear y
        LEFT JOIN #LastYear y2 ON y.PortOfLading = y2.PortOfLading
                                  AND y.PartnerID = y2.PartnerID
GROUP BY y.PortOfLading
ORDER BY SUM(y.TotalWeightShipped) DESC';


--insert old records into hist
INSERT INTO dbo.tbgSQLCommandsHist
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
          KeepDuringRollback   )
        SELECT  PartnerID ,
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
        FROM    dbo.tbgSQLCommands WITH ( NOLOCK )
        WHERE   SQLGUID = @CurrentSQLGuid9
                AND Version = '20.4';

--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @CurrentSQLGuid9
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
          @CurrentSQLGuid9 , -- SQLGUID - uniqueidentifier
          @CurrentSQLScript9 , -- SQLCommand - varchar(max)
          @CurrentSQLDescription9 , -- Description - nvarchar(100)
          @CurrentSQLLongDescription9 , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @CurrentCreatedBy9 , -- CreatedBy - varchar(50)
          @CurrentApprovedBy9 , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@CurrentSQLScript9,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.4' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )


------------------------------------Value Exported by INCOTerm - YoY ------------------------------------
DECLARE @CurrentSQLGuid10 AS VARCHAR(36) = '76EBE768-0A42-4D15-B18B-4566E4FD3D1E';
DECLARE @CurrentSQLDescription10 AS NVARCHAR(100) = 'Value Exported by INCOTerm - YoY ';
DECLARE @CurrentSQLLongDescription10 AS NVARCHAR(MAX) = 'This comparison report shows the INCOterms with the highest associated total Shipment Value on all shipments for the current calendar year compared to the associated total Shipment Value on all shipments filed for the previous calendar year. ';
DECLARE @CurrentCreatedBy10 AS VARCHAR(50) = 'kduval';
DECLARE @CurrentApprovedBy10 AS VARCHAR(50) = '';

DECLARE @CurrentSQLScript10 AS NVARCHAR(MAX) = 'SELECT  h.PartnerID ,
        INCOTerms ,
        DATEPART(YEAR, ExportDate) AS ExportYear ,
        CAST(SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 2)) AS EstBaseTotalShipmentValue
INTO    #CurrentYear
FROM    txdGVExportHeader h WITH ( NOLOCK )
JOIN dbo.txdGVExportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.ExportGUID = h.ExportGuid
WHERE 1=1 AND @EXPORTDATERANGE AND h.PartnerID = @PartnerID 
        AND DATEPART(YEAR, ExportDate) = DATEPART(YEAR, GETDATE())
GROUP BY h.PartnerID ,
        INCOTerms ,
        DATEPART(YEAR, ExportDate)
SELECT  h.PartnerID ,
        INCOTerms ,
        DATEPART(YEAR, ExportDate) AS ExportYear ,
        CAST(SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 2)) AS EstBaseTotalShipmentValue
INTO    #LastYear
FROM    txdGVExportHeader h WITH (NOLOCK)
JOIN dbo.txdGVExportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.ExportGUID = h.ExportGuid
WHERE 1=1 AND   DATEPART(YEAR, ExportDate) = DATEPART(YEAR,
                                              DATEADD(YEAR, -1, GETDATE()))
        AND ExportDate <= ( GETDATE() - 365 )
GROUP BY h.PartnerID ,
        INCOTerms ,
        DATEPART(YEAR, ExportDate)
SELECT TOP 10
        y.INCOTerms ,
        ISNULL(SUM(y.EstBaseTotalShipmentValue), 0) AS [@CurrentYear] ,
        ISNULL(SUM(y2.EstBaseTotalShipmentValue), 0) AS [@LastYear]
FROM    #CurrentYear y
        LEFT JOIN #LastYear y2 ON y.INCOTerms = y2.INCOTerms
                                  AND y.PartnerID = y2.PartnerID
GROUP BY y.INCOTerms
ORDER BY SUM(y.EstBaseTotalShipmentValue) DESC';


--insert old records into hist
INSERT INTO dbo.tbgSQLCommandsHist
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
          KeepDuringRollback   )
        SELECT  PartnerID ,
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
        FROM    dbo.tbgSQLCommands WITH ( NOLOCK )
        WHERE   SQLGUID = @CurrentSQLGuid10
                AND Version = '20.4';

--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @CurrentSQLGuid10
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
          @CurrentSQLGuid10 , -- SQLGUID - uniqueidentifier
          @CurrentSQLScript10 , -- SQLCommand - varchar(max)
          @CurrentSQLDescription10 , -- Description - nvarchar(100)
          @CurrentSQLLongDescription10 , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @CurrentCreatedBy10 , -- CreatedBy - varchar(50)
          @CurrentApprovedBy10 , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@CurrentSQLScript10,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.4' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )


------------------------------------Weight Shipped by Carrier - YoY------------------------------------
DECLARE @CurrentSQLGuid11 AS VARCHAR(36) = 'F6F31106-673A-41BE-9ED5-553CA0F308A2';
DECLARE @CurrentSQLDescription11 AS NVARCHAR(100) = 'Weight Shipped by Carrier - YoY';
DECLARE @CurrentSQLLongDescription11 AS NVARCHAR(MAX) = 'This comparison report shows all Carriers and the associated total weight shipped during the current year to date compared to the total weight shipped during the previous year.';
DECLARE @CurrentCreatedBy11 AS VARCHAR(50) = 'kduval';
DECLARE @CurrentApprovedBy11 AS VARCHAR(50) = '';

DECLARE @CurrentSQLScript11 AS NVARCHAR(MAX) = 'SELECT  h.PartnerID ,
        h.CarrierName ,
        DATEPART(YEAR, ExportDate) AS ExportYear ,
        CAST(SUM(d.NetWeight) AS NUMERIC(28, 0)) AS TotalWeightShipped
INTO    #CurrentYear
FROM    txdGVExportHeader h WITH ( NOLOCK )
JOIN dbo.txdGVExportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.ExportGUID = h.ExportGuid
WHERE 1=1 AND @EXPORTDATERANGE AND h.PartnerID = @PartnerID 
        AND DATEPART(YEAR, ExportDate) = DATEPART(YEAR, GETDATE())
GROUP BY h.PartnerID ,
        CarrierName ,
        DATEPART(YEAR, ExportDate)
SELECT  h.PartnerID ,
        h.CarrierName ,
        DATEPART(YEAR, ExportDate) AS ExportYear ,
        CAST(SUM(d.NetWeight) AS NUMERIC(28, 0)) AS TotalWeightShipped
INTO    #LastYear
FROM    txdGVExportHeader h WITH (NOLOCK)
JOIN dbo.txdGVExportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.ExportGUID = h.ExportGuid
WHERE 1=1 AND   DATEPART(YEAR, ExportDate) = DATEPART(YEAR,
                                              DATEADD(YEAR, -1, GETDATE()))
        AND ExportDate <= ( GETDATE() - 365 )
GROUP BY h.PartnerID ,
        CarrierName ,
        DATEPART(YEAR, ExportDate)
SELECT TOP 10
        y.CarrierName ,
        ISNULL(SUM(y.TotalWeightShipped), 0) AS [@CurrentYear] ,
        ISNULL(SUM(y2.TotalWeightShipped), 0) AS [@LastYear]
FROM    #CurrentYear y
        LEFT JOIN #LastYear y2 ON y.CarrierName = y2.CarrierName
                                  AND y.PartnerID = y2.PartnerID
GROUP BY y.CarrierName
ORDER BY SUM(y.TotalWeightShipped) DESC';


--insert old records into hist
INSERT INTO dbo.tbgSQLCommandsHist
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
          KeepDuringRollback   )
        SELECT  PartnerID ,
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
        FROM    dbo.tbgSQLCommands WITH ( NOLOCK )
        WHERE   SQLGUID = @CurrentSQLGuid11
                AND Version = '20.4';

--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @CurrentSQLGuid11
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
          @CurrentSQLGuid11 , -- SQLGUID - uniqueidentifier
          @CurrentSQLScript11 , -- SQLCommand - varchar(max)
          @CurrentSQLDescription11 , -- Description - nvarchar(100)
          @CurrentSQLLongDescription11 , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @CurrentCreatedBy11 , -- CreatedBy - varchar(50)
          @CurrentApprovedBy11 , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@CurrentSQLScript11,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.4' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )


------------------------------------Weight Shipped by Forwarder - YoY------------------------------------
DECLARE @CurrentSQLGuid12 AS VARCHAR(36) = 'DA103C15-C678-4917-A6E1-5D672FE032D4';
DECLARE @CurrentSQLDescription12 AS NVARCHAR(100) = 'Weight Shipped by Forwarder - YoY';
DECLARE @CurrentSQLLongDescription12 AS NVARCHAR(MAX) = 'This comparison report shows all Forwarders and the associated total weight shipped during the current year to date compared to the total weight shipped during the previous year.';
DECLARE @CurrentCreatedBy12 AS VARCHAR(50) = 'kduval';
DECLARE @CurrentApprovedBy12 AS VARCHAR(50) = '';

DECLARE @CurrentSQLScript12 AS NVARCHAR(MAX) = 'SELECT  h.PartnerID ,
        ForwarderCompanyName ,
        DATEPART(YEAR, ExportDate) AS ExportYear ,
        CAST(SUM(d.NetWeight) AS NUMERIC(28, 0)) AS TotalWeightShipped
INTO    #CurrentYear
FROM    txdGVExportHeader h WITH ( NOLOCK )
JOIN dbo.txdGVExportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.ExportGUID = h.ExportGuid
WHERE 1=1 AND @EXPORTDATERANGE AND h.PartnerID = @PartnerID 
        AND DATEPART(YEAR, ExportDate) = DATEPART(YEAR, GETDATE())
GROUP BY h.PartnerID ,
        ForwarderCompanyName ,
        DATEPART(YEAR, ExportDate)
SELECT  h.PartnerID ,
        ForwarderCompanyName ,
        DATEPART(YEAR, ExportDate) AS ExportYear ,
        CAST(SUM(d.NetWeight) AS NUMERIC(28, 0)) AS TotalWeightShipped
INTO    #LastYear
FROM    txdGVExportHeader h WITH (NOLOCK)
JOIN dbo.txdGVExportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.ExportGUID = h.ExportGuid
WHERE 1=1 AND   DATEPART(YEAR, ExportDate) = DATEPART(YEAR,
                                              DATEADD(YEAR, -1, GETDATE()))
        AND ExportDate <= ( GETDATE() - 365 )
GROUP BY h.PartnerID ,
        ForwarderCompanyName ,
        DATEPART(YEAR, ExportDate)
SELECT TOP 10
        y.ForwarderCompanyName ,
        ISNULL(SUM(y.TotalWeightShipped), 0) AS [@CurrentYear] ,
        ISNULL(SUM(y2.TotalWeightShipped), 0) AS [@LastYear]
FROM    #CurrentYear y
        LEFT JOIN #LastYear y2 ON y.ForwarderCompanyName = y2.ForwarderCompanyName
                                  AND y.PartnerID = y2.PartnerID
GROUP BY y.ForwarderCompanyName
ORDER BY SUM(y.TotalWeightShipped) DESC';


--insert old records into hist
INSERT INTO dbo.tbgSQLCommandsHist
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
          KeepDuringRollback   )
        SELECT  PartnerID ,
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
        FROM    dbo.tbgSQLCommands WITH ( NOLOCK )
        WHERE   SQLGUID = @CurrentSQLGuid12
                AND Version = '20.4';

--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @CurrentSQLGuid12
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
          @CurrentSQLGuid12 , -- SQLGUID - uniqueidentifier
          @CurrentSQLScript12 , -- SQLCommand - varchar(max)
          @CurrentSQLDescription12 , -- Description - nvarchar(100)
          @CurrentSQLLongDescription12 , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @CurrentCreatedBy12 , -- CreatedBy - varchar(50)
          @CurrentApprovedBy12 , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@CurrentSQLScript12,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.4' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )


------------------------------------Weight Shipped by ECN Number - YoY------------------------------------
DECLARE @CurrentSQLGuid13 AS VARCHAR(36) = 'CF330AB3-D9ED-4B36-9AA8-3CA19963A225';
DECLARE @CurrentSQLDescription13 AS NVARCHAR(100) = 'Weight Shipped by ECN Number - YoY';
DECLARE @CurrentSQLLongDescription13 AS NVARCHAR(MAX) = 'This comparison report shows all ECN Numbers and the associated total weight shipped during the current year to date compared to the total weight shipped during the previous year.';
DECLARE @CurrentCreatedBy13 AS VARCHAR(50) = 'kduval';
DECLARE @CurrentApprovedBy13 AS VARCHAR(50) = '';

DECLARE @CurrentSQLScript13 AS NVARCHAR(MAX) = 'SELECT  h.PartnerID ,
        d.ECNNum ,
        DATEPART(YEAR, ExportDate) AS ExportYear ,
        CAST(SUM(d.NetWeight) AS NUMERIC(28, 0)) AS TotalWeightShipped
INTO    #CurrentYear
FROM    txdGVExportHeader h WITH ( NOLOCK )
        JOIN txdGVExportDetail d WITH ( NOLOCK ) ON h.ExportGuid = d.ExportGUID
                                                    AND h.PartnerID = d.PartnerID
WHERE 1=1 AND @EXPORTDATERANGE AND h.PartnerID = @PartnerID 
        AND DATEPART(YEAR, ExportDate) = DATEPART(YEAR, GETDATE())
GROUP BY h.PartnerID ,
        d.ECNNum ,
        DATEPART(YEAR, ExportDate)
SELECT  h.PartnerID ,
        d.ECNNum ,
        DATEPART(YEAR, ExportDate) AS ExportYear ,
        CAST(SUM(d.NetWeight) AS NUMERIC(28, 0)) AS TotalWeightShipped
INTO    #LastYear
FROM    txdGVExportHeader h WITH ( NOLOCK )
        JOIN txdGVExportDetail d WITH ( NOLOCK ) ON h.ExportGuid = d.ExportGUID
                                                    AND h.PartnerID = d.PartnerID
WHERE 1=1 AND   DATEPART(YEAR, ExportDate) = DATEPART(YEAR,
                                              DATEADD(YEAR, -1, GETDATE()))
        AND ExportDate <= ( GETDATE() - 365 )
GROUP BY h.PartnerID ,
        d.ECNNum ,
        DATEPART(YEAR, ExportDate)
SELECT TOP 10
        y.ECNNum ,
        ISNULL(SUM(y.TotalWeightShipped), 0) AS [@CurrentYear] ,
        ISNULL(SUM(y2.TotalWeightShipped), 0) AS [@LastYear]
FROM    #CurrentYear y
        LEFT JOIN #LastYear y2 ON y.ECNNum = y2.ECNNum
                                  AND y.PartnerID = y2.PartnerID
GROUP BY y.ECNNum
ORDER BY SUM(y.TotalWeightShipped) DESC';


--insert old records into hist
INSERT INTO dbo.tbgSQLCommandsHist
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
          KeepDuringRollback   )
        SELECT  PartnerID ,
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
        FROM    dbo.tbgSQLCommands WITH ( NOLOCK )
        WHERE   SQLGUID = @CurrentSQLGuid13
                AND Version = '20.4';

--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @CurrentSQLGuid13
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
          @CurrentSQLGuid13 , -- SQLGUID - uniqueidentifier
          @CurrentSQLScript13 , -- SQLCommand - varchar(max)
          @CurrentSQLDescription13 , -- Description - nvarchar(100)
          @CurrentSQLLongDescription13 , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @CurrentCreatedBy13 , -- CreatedBy - varchar(50)
          @CurrentApprovedBy13 , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@CurrentSQLScript13,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.4' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )


------------------------------------Weight Shipped by Port of Unlading - YoY------------------------------------
DECLARE @CurrentSQLGuid14 AS VARCHAR(36) = '8BBDBB87-71AA-4F22-B42A-6E995B14605F';
DECLARE @CurrentSQLDescription14 AS NVARCHAR(100) = 'Weight Shipped by Port of Unlading - YoY';
DECLARE @CurrentSQLLongDescription14 AS NVARCHAR(MAX) = 'This comparison report shows all Ports of Unlading and the associated total weight shipped during the current year to date compared to the total weight shipped during the previous year.';
DECLARE @CurrentCreatedBy14 AS VARCHAR(50) = 'kduval';
DECLARE @CurrentApprovedBy14 AS VARCHAR(50) = '';

DECLARE @CurrentSQLScript14 AS NVARCHAR(MAX) = 'SELECT  h.PartnerID ,
        PortOfUnlading ,
        DATEPART(YEAR, ExportDate) AS ExportYear ,
        CAST(SUM(d.NetWeight) AS NUMERIC(28, 0)) AS TotalWeightShipped
INTO    #CurrentYear
FROM    txdGVExportHeader h WITH ( NOLOCK )
JOIN dbo.txdGVExportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.ExportGUID = h.ExportGuid
WHERE 1=1 AND @EXPORTDATERANGE AND h.PartnerID = @PartnerID 
        AND DATEPART(YEAR, ExportDate) = DATEPART(YEAR, GETDATE())
GROUP BY h.PartnerID ,
        PortOfUnlading ,
        DATEPART(YEAR, ExportDate)
SELECT  h.PartnerID ,
        PortOfUnlading ,
        DATEPART(YEAR, ExportDate) AS ExportYear ,
        CAST(SUM(d.NetWeight) AS NUMERIC(28, 0)) AS TotalWeightShipped
INTO    #LastYear
FROM    txdGVExportHeader h
JOIN dbo.txdGVExportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.ExportGUID = h.ExportGuid
WHERE 1=1 AND   DATEPART(YEAR, ExportDate) = DATEPART(YEAR,
                                              DATEADD(YEAR, -1, GETDATE()))
        AND ExportDate <= ( GETDATE() - 365 )
GROUP BY h.PartnerID ,
        PortOfUnlading ,
        DATEPART(YEAR, ExportDate)
SELECT TOP 10
        y.PortOfUnlading ,
        ISNULL(SUM(y.TotalWeightShipped), 0) AS [@CurrentYear] ,
        ISNULL(SUM(y2.TotalWeightShipped), 0) AS [@LastYear]
FROM    #CurrentYear y
        LEFT JOIN #LastYear y2 ON y.PortOfUnlading = y2.PortOfUnlading
                                  AND y.PartnerID = y2.PartnerID
GROUP BY y.PortOfUnlading
ORDER BY SUM(y.TotalWeightShipped) DESC';


--insert old records into hist
INSERT INTO dbo.tbgSQLCommandsHist
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
          KeepDuringRollback   )
        SELECT  PartnerID ,
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
        FROM    dbo.tbgSQLCommands WITH ( NOLOCK )
        WHERE   SQLGUID = @CurrentSQLGuid14
                AND Version = '20.4';

--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @CurrentSQLGuid14
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
          @CurrentSQLGuid14 , -- SQLGUID - uniqueidentifier
          @CurrentSQLScript14 , -- SQLCommand - varchar(max)
          @CurrentSQLDescription14 , -- Description - nvarchar(100)
          @CurrentSQLLongDescription14 , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @CurrentCreatedBy14 , -- CreatedBy - varchar(50)
          @CurrentApprovedBy14 , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@CurrentSQLScript14,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.4' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )


------------------------------------Weight Shipped by Export Tariff Number - YoY------------------------------------
DECLARE @CurrentSQLGuid15 AS VARCHAR(36) = '55926D41-D693-44E8-AF19-7CC367B97A82';
DECLARE @CurrentSQLDescription15 AS NVARCHAR(100) = 'Weight Shipped by Export Tariff Number - YoY';
DECLARE @CurrentSQLLongDescription15 AS NVARCHAR(MAX) = 'This comparison report shows all Export Tariff Numbers and the associated total weight shipped during the current year to date compared to the total weight shipped during the previous year.';
DECLARE @CurrentCreatedBy15 AS VARCHAR(50) = 'kduval';
DECLARE @CurrentApprovedBy15 AS VARCHAR(50) = '';

DECLARE @CurrentSQLScript15 AS NVARCHAR(MAX) = 'SELECT  h.PartnerID ,
        d.ExportTariffNum ,
        DATEPART(YEAR, ExportDate) AS ExportYear ,
        CAST(SUM(d.NetWeight) AS NUMERIC(28, 0)) AS TotalWeightShipped
INTO    #CurrentYear
FROM    txdGVExportHeader h WITH ( NOLOCK )
        JOIN txdGVExportDetail d WITH ( NOLOCK ) ON h.ExportGuid = d.ExportGUID
                                                    AND h.PartnerID = d.PartnerID
WHERE 1=1 AND @EXPORTDATERANGE AND h.PartnerID = @PartnerID 
        AND DATEPART(YEAR, ExportDate) = DATEPART(YEAR, GETDATE())
GROUP BY h.PartnerID ,
        d.ExportTariffNum ,
        DATEPART(YEAR, ExportDate)
SELECT  h.PartnerID ,
        d.ExportTariffNum ,
        DATEPART(YEAR, ExportDate) AS ExportYear ,
        CAST(SUM(d.NetWeight) AS NUMERIC(28, 0)) AS TotalWeightShipped
INTO    #LastYear
FROM    txdGVExportHeader h WITH ( NOLOCK )
        JOIN txdGVExportDetail d WITH ( NOLOCK ) ON h.ExportGuid = d.ExportGUID
                                                    AND h.PartnerID = d.PartnerID
WHERE 1=1 AND   DATEPART(YEAR, ExportDate) = DATEPART(YEAR,
                                              DATEADD(YEAR, -1, GETDATE()))
        AND ExportDate <= ( GETDATE() - 365 )
GROUP BY h.PartnerID ,
        d.ExportTariffNum ,
        DATEPART(YEAR, ExportDate)
SELECT TOP 10
        y.ExportTariffNum ,
        ISNULL(SUM(y.TotalWeightShipped), 0) AS [@CurrentYear] ,
        ISNULL(SUM(y2.TotalWeightShipped), 0) AS [@LastYear]
FROM    #CurrentYear y
        LEFT JOIN #LastYear y2 ON y.ExportTariffNum = y2.ExportTariffNum
                                  AND y.PartnerID = y2.PartnerID
GROUP BY y.ExportTariffNum
ORDER BY SUM(y.TotalWeightShipped) DESC';


--insert old records into hist
INSERT INTO dbo.tbgSQLCommandsHist
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
          KeepDuringRollback   )
        SELECT  PartnerID ,
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
        FROM    dbo.tbgSQLCommands WITH ( NOLOCK )
        WHERE   SQLGUID = @CurrentSQLGuid15
                AND Version = '20.4';

--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @CurrentSQLGuid15
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
          @CurrentSQLGuid15 , -- SQLGUID - uniqueidentifier
          @CurrentSQLScript15 , -- SQLCommand - varchar(max)
          @CurrentSQLDescription15 , -- Description - nvarchar(100)
          @CurrentSQLLongDescription15 , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @CurrentCreatedBy15 , -- CreatedBy - varchar(50)
          @CurrentApprovedBy15 , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@CurrentSQLScript15,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.4' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )


------------------------------------Weight Shipped by Business Division - YoY------------------------------------
DECLARE @CurrentSQLGuid16 AS VARCHAR(36) = '5418E205-531C-4234-A669-FE3DBB28CAA4';
DECLARE @CurrentSQLDescription16 AS NVARCHAR(100) = 'Weight Shipped by Business Division - YoY';
DECLARE @CurrentSQLLongDescription16 AS NVARCHAR(MAX) = 'This comparison report shows all Business Divisions and the associated Total Weight shipped during the current year to date compared to the Total Weight shipped during the previous year.';
DECLARE @CurrentCreatedBy16 AS VARCHAR(50) = 'kduval';
DECLARE @CurrentApprovedBy16 AS VARCHAR(50) = '';

DECLARE @CurrentSQLScript16 AS NVARCHAR(MAX) = 'SELECT  h.PartnerID ,
        d.BusinessUnit ,
        DATEPART(YEAR, ExportDate) AS ExportYear ,
        CAST(SUM(d.NetWeight) AS NUMERIC(28, 0)) AS TotalWeightShipped
INTO    #CurrentYear
FROM    txdGVExportHeader h WITH ( NOLOCK )
        JOIN txdGVExportDetail d WITH ( NOLOCK ) ON h.ExportGuid = d.ExportGUID
                                                    AND h.PartnerID = d.PartnerID
WHERE 1=1 AND @EXPORTDATERANGE AND h.PartnerID = @PartnerID 
        AND DATEPART(YEAR, ExportDate) = DATEPART(YEAR, GETDATE())
GROUP BY h.PartnerID ,
        d.BusinessUnit ,
        DATEPART(YEAR, ExportDate)
SELECT  h.PartnerID ,
        d.BusinessUnit ,
        DATEPART(YEAR, ExportDate) AS ExportYear ,
        CAST(SUM(d.NetWeight) AS NUMERIC(28, 0)) AS TotalWeightShipped
INTO    #LastYear
FROM    txdGVExportHeader h WITH ( NOLOCK )
        JOIN txdGVExportDetail d WITH ( NOLOCK ) ON h.ExportGuid = d.ExportGUID
                                                    AND h.PartnerID = d.PartnerID
WHERE 1=1 AND   DATEPART(YEAR, ExportDate) = DATEPART(YEAR,
                                              DATEADD(YEAR, -1, GETDATE()))
        AND ExportDate <= ( GETDATE() - 365 )
GROUP BY h.PartnerID ,
        d.BusinessUnit ,
        DATEPART(YEAR, ExportDate)
SELECT TOP 10
        y.BusinessUnit ,
        ISNULL(SUM(y.TotalWeightShipped), 0) AS [@CurrentYear] ,
        ISNULL(SUM(y2.TotalWeightShipped), 0) AS [@LastYear]
FROM    #CurrentYear y
        LEFT JOIN #LastYear y2 ON y.BusinessUnit = y2.BusinessUnit
                                  AND y.PartnerID = y2.PartnerID
GROUP BY y.BusinessUnit
ORDER BY SUM(y.TotalWeightShipped) DESC';


--insert old records into hist
INSERT INTO dbo.tbgSQLCommandsHist
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
          KeepDuringRollback   )
        SELECT  PartnerID ,
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
        FROM    dbo.tbgSQLCommands WITH ( NOLOCK )
        WHERE   SQLGUID = @CurrentSQLGuid16
                AND Version = '20.4';

--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @CurrentSQLGuid16
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
          @CurrentSQLGuid16 , -- SQLGUID - uniqueidentifier
          @CurrentSQLScript16 , -- SQLCommand - varchar(max)
          @CurrentSQLDescription16 , -- Description - nvarchar(100)
          @CurrentSQLLongDescription16 , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @CurrentCreatedBy16 , -- CreatedBy - varchar(50)
          @CurrentApprovedBy16 , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@CurrentSQLScript16,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.4' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )


------------------------------------Weight Shipped by Mode of Transport - YoY------------------------------------
DECLARE @CurrentSQLGuid17 AS VARCHAR(36) = 'EA5DD95D-F73C-4555-B430-B5E841A064E0';
DECLARE @CurrentSQLDescription17 AS NVARCHAR(100) = 'Weight Shipped by Mode of Transport - YoY';
DECLARE @CurrentSQLLongDescription17 AS NVARCHAR(MAX) = 'This comparison report shows all Modes of Transport and the associated total weight shipped during the current year to date compared to the total weight shipped during the previous year.';
DECLARE @CurrentCreatedBy17 AS VARCHAR(50) = 'kduval';
DECLARE @CurrentApprovedBy17 AS VARCHAR(50) = '';

DECLARE @CurrentSQLScript17 AS NVARCHAR(MAX) = 'SELECT  h.PartnerID ,
        ModeOfTransport ,
        DATEPART(YEAR, ExportDate) AS ExportYear ,
        CAST(SUM(d.NetWeight) AS NUMERIC(28, 0)) AS TotalWeightShipped
INTO    #CurrentYear
FROM    txdGVExportHeader h WITH ( NOLOCK )
JOIN dbo.txdGVExportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.ExportGUID = h.ExportGuid
WHERE 1=1 AND @EXPORTDATERANGE AND h.PartnerID = @PartnerID 
        AND DATEPART(YEAR, ExportDate) = DATEPART(YEAR, GETDATE())
GROUP BY h.PartnerID ,
        ModeOfTransport ,
        DATEPART(YEAR, ExportDate)
SELECT  h.PartnerID ,
        ModeOfTransport ,
        DATEPART(YEAR, ExportDate) AS ExportYear ,
        CAST(SUM(d.NetWeight) AS NUMERIC(28, 0)) AS TotalWeightShipped
INTO    #LastYear
FROM    txdGVExportHeader h
JOIN dbo.txdGVExportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.ExportGUID = h.ExportGuid
WHERE 1=1 AND   DATEPART(YEAR, ExportDate) = DATEPART(YEAR,
                                              DATEADD(YEAR, -1, GETDATE()))
        AND ExportDate <= ( GETDATE() - 365 )
GROUP BY h.PartnerID ,
        ModeOfTransport ,
        DATEPART(YEAR, ExportDate)
SELECT TOP 10
        y.ModeOfTransport ,
        ISNULL(SUM(y.TotalWeightShipped), 0) AS [@CurrentYear] ,
        ISNULL(SUM(y2.TotalWeightShipped), 0) AS [@LastYear]
FROM    #CurrentYear y
        LEFT JOIN #LastYear y2 ON y.ModeOfTransport = y2.ModeOfTransport
                                  AND y.PartnerID = y2.PartnerID
GROUP BY y.ModeOfTransport
ORDER BY SUM(y.TotalWeightShipped) DESC';


--insert old records into hist
INSERT INTO dbo.tbgSQLCommandsHist
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
          KeepDuringRollback   )
        SELECT  PartnerID ,
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
        FROM    dbo.tbgSQLCommands WITH ( NOLOCK )
        WHERE   SQLGUID = @CurrentSQLGuid17
                AND Version = '20.4';

--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @CurrentSQLGuid17
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
          @CurrentSQLGuid17 , -- SQLGUID - uniqueidentifier
          @CurrentSQLScript17 , -- SQLCommand - varchar(max)
          @CurrentSQLDescription17 , -- Description - nvarchar(100)
          @CurrentSQLLongDescription17 , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @CurrentCreatedBy17 , -- CreatedBy - varchar(50)
          @CurrentApprovedBy17 , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@CurrentSQLScript17,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.4' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )


------------------------------------Value Shipped by Import Country - YoY ------------------------------------
DECLARE @CurrentSQLGuid18 AS VARCHAR(36) = 'EA11143A-9C38-4772-A177-707F00EBE248';
DECLARE @CurrentSQLDescription18 AS NVARCHAR(100) = 'Value Shipped by Import Country - YoY ';
DECLARE @CurrentSQLLongDescription18 AS NVARCHAR(MAX) = 'This comparison report shows the Modes of Transport with the highest associated total Shipment Value on all shipments for the current calendar year compared to the associated total Shipment Value on all shipments filed for the previous calendar year. ';
DECLARE @CurrentCreatedBy18 AS VARCHAR(50) = 'kduval';
DECLARE @CurrentApprovedBy18 AS VARCHAR(50) = '';

DECLARE @CurrentSQLScript18 AS NVARCHAR(MAX) = 'SELECT  h.PartnerID ,
        h.ModeOfTransport ,
        DATEPART(YEAR, ExportDate) AS ExportYear ,
        CAST(SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 2)) AS EstBaseTotalShipmentValue
INTO    #CurrentYear
FROM    txdGVExportHeader h WITH ( NOLOCK )
JOIN dbo.txdGVExportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.ExportGUID = h.ExportGuid
WHERE 1=1 AND @EXPORTDATERANGE AND h.PartnerID = @PartnerID 
        AND DATEPART(YEAR, ExportDate) = DATEPART(YEAR, GETDATE())
GROUP BY h.PartnerID ,
        ModeOfTransport ,
        DATEPART(YEAR, ExportDate)
SELECT  h.PartnerID ,
        h.ModeOfTransport ,
        DATEPART(YEAR, ExportDate) AS ExportYear ,
        CAST(SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 2)) AS EstBaseTotalShipmentValue
INTO    #LastYear
FROM    txdGVExportHeader h WITH ( NOLOCK )
JOIN dbo.txdGVExportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.ExportGUID = h.ExportGuid
WHERE 1=1 AND   DATEPART(YEAR, ExportDate) = DATEPART(YEAR,
                                              DATEADD(YEAR, -1, GETDATE()))
        AND ExportDate <= ( GETDATE() - 365 )
GROUP BY h.PartnerID ,
        ModeOfTransport ,
        DATEPART(YEAR, ExportDate)
SELECT TOP 10
        y.ModeOfTransport ,
        ISNULL(SUM(y.EstBaseTotalShipmentValue), 0) AS [@CurrentYear] ,
        ISNULL(SUM(y2.EstBaseTotalShipmentValue), 0) AS [@LastYear]
FROM    #CurrentYear y
        LEFT JOIN #LastYear y2 ON y.ModeOfTransport = y2.ModeOfTransport
                                  AND y.PartnerID = y2.PartnerID
GROUP BY y.ModeOfTransport
ORDER BY SUM(y.EstBaseTotalShipmentValue) DESC';


--insert old records into hist
INSERT INTO dbo.tbgSQLCommandsHist
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
          KeepDuringRollback   )
        SELECT  PartnerID ,
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
        FROM    dbo.tbgSQLCommands WITH ( NOLOCK )
        WHERE   SQLGUID = @CurrentSQLGuid18
                AND Version = '20.4';

--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @CurrentSQLGuid18
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
          @CurrentSQLGuid18 , -- SQLGUID - uniqueidentifier
          @CurrentSQLScript18 , -- SQLCommand - varchar(max)
          @CurrentSQLDescription18 , -- Description - nvarchar(100)
          @CurrentSQLLongDescription18 , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @CurrentCreatedBy18 , -- CreatedBy - varchar(50)
          @CurrentApprovedBy18 , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@CurrentSQLScript18,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.4' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )


------------------------------------Weight Shipped by Export Country - YoY------------------------------------
DECLARE @CurrentSQLGuid19 AS VARCHAR(36) = '1DCC57C0-6647-4FCC-8286-B457F78282F9';
DECLARE @CurrentSQLDescription19 AS NVARCHAR(100) = 'Weight Shipped by Export Country - YoY';
DECLARE @CurrentSQLLongDescription19 AS NVARCHAR(MAX) = 'This comparison report shows all Export Countries and the associated total weight shipped during the current year to date compared to the total weight shipped during the previous year.';
DECLARE @CurrentCreatedBy19 AS VARCHAR(50) = 'kduval';
DECLARE @CurrentApprovedBy19 AS VARCHAR(50) = '';

DECLARE @CurrentSQLScript19 AS NVARCHAR(MAX) = 'SELECT  h.PartnerID ,
        ExportCountry ,
        DATEPART(YEAR, ExportDate) AS ExportYear ,
        CAST(SUM(d.NetWeight) AS NUMERIC(28, 0)) AS TotalWeightShipped
INTO    #CurrentYear
FROM    txdGVExportHeader h WITH ( NOLOCK )
JOIN dbo.txdGVExportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.ExportGUID = h.ExportGuid
WHERE 1=1 AND @EXPORTDATERANGE AND h.PartnerID = @PartnerID 
        AND DATEPART(YEAR, ExportDate) = DATEPART(YEAR, GETDATE())
GROUP BY h.PartnerID ,
        ExportCountry ,
        DATEPART(YEAR, ExportDate);
SELECT  h.PartnerID ,
        ExportCountry ,
        DATEPART(YEAR, ExportDate) AS ExportYear ,
        CAST(SUM(d.NetWeight) AS NUMERIC(28, 0)) AS TotalWeightShipped
INTO    #LastYear
FROM    txdGVExportHeader h
JOIN dbo.txdGVExportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.ExportGUID = h.ExportGuid
WHERE 1=1 AND   DATEPART(YEAR, ExportDate) = DATEPART(YEAR,
                                              DATEADD(YEAR, -1, GETDATE()))
        AND ExportDate <= ( GETDATE() - 365 )
GROUP BY h.PartnerID ,
        ExportCountry ,
        DATEPART(YEAR, ExportDate);
SELECT TOP 10
        y.ExportCountry ,
        ISNULL(SUM(y.TotalWeightShipped), 0) AS [@CurrentYear] ,
        ISNULL(SUM(y2.TotalWeightShipped), 0) AS [@LastYear]
FROM    #CurrentYear y
        LEFT JOIN #LastYear y2 ON y.ExportCountry = y2.ExportCountry
                                  AND y.PartnerID = y2.PartnerID
GROUP BY y.ExportCountry
ORDER BY SUM(y.TotalWeightShipped) DESC';


--insert old records into hist
INSERT INTO dbo.tbgSQLCommandsHist
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
          KeepDuringRollback   )
        SELECT  PartnerID ,
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
        FROM    dbo.tbgSQLCommands WITH ( NOLOCK )
        WHERE   SQLGUID = @CurrentSQLGuid19
                AND Version = '20.4';

--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @CurrentSQLGuid19
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
          @CurrentSQLGuid19 , -- SQLGUID - uniqueidentifier
          @CurrentSQLScript19 , -- SQLCommand - varchar(max)
          @CurrentSQLDescription19 , -- Description - nvarchar(100)
          @CurrentSQLLongDescription19 , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @CurrentCreatedBy19 , -- CreatedBy - varchar(50)
          @CurrentApprovedBy19 , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@CurrentSQLScript19,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.4' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )


------------------------------------Value Shipped by Carrier - YoY ------------------------------------
DECLARE @CurrentSQLGuid20 AS VARCHAR(36) = '0452138E-5693-46DB-B121-BE0A4AC3B1B0';
DECLARE @CurrentSQLDescription20 AS NVARCHAR(100) = 'Value Shipped by Carrier - YoY ';
DECLARE @CurrentSQLLongDescription20 AS NVARCHAR(MAX) = 'This comparison report shows the Carriers with the highest associated total Shipment Value on all shipments for the current year to date compared to the associated Shipment Value on all shipments during the same period in the previous year. ';
DECLARE @CurrentCreatedBy20 AS VARCHAR(50) = 'kduval';
DECLARE @CurrentApprovedBy20 AS VARCHAR(50) = '';

DECLARE @CurrentSQLScript20 AS NVARCHAR(MAX) = 'SELECT  h.PartnerID ,
        h.CarrierName ,
        DATEPART(YEAR, ExportDate) AS ExportYear ,
        CAST(SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 2)) AS EstBaseTotalShipmentValue
INTO    #CurrentYear
FROM    txdGVExportHeader h WITH ( NOLOCK )
JOIN dbo.txdGVExportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.ExportGUID = h.ExportGuid
WHERE 1=1 AND @EXPORTDATERANGE AND h.PartnerID = @PartnerID 
        AND DATEPART(YEAR, ExportDate) = DATEPART(YEAR, GETDATE())
GROUP BY h.PartnerID ,
        CarrierName ,
        DATEPART(YEAR, ExportDate)
SELECT  h.PartnerID ,
        h.CarrierName ,
        DATEPART(YEAR, ExportDate) AS ExportYear ,
        CAST(SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 2)) AS EstBaseTotalShipmentValue
INTO    #LastYear
FROM    txdGVExportHeader h WITH ( NOLOCK )
JOIN dbo.txdGVExportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.ExportGUID = h.ExportGuid
WHERE 1=1 AND   DATEPART(YEAR, ExportDate) = DATEPART(YEAR,
                                              DATEADD(YEAR, -1, GETDATE()))
        AND ExportDate <= ( GETDATE() - 365 )
GROUP BY h.PartnerID ,
        CarrierName ,
        DATEPART(YEAR, ExportDate)
SELECT TOP 10
        y.CarrierName ,
        ISNULL(SUM(y.EstBaseTotalShipmentValue), 0) AS [@CurrentYear] ,
        ISNULL(SUM(y2.EstBaseTotalShipmentValue), 0) AS [@LastYear]
FROM    #CurrentYear y
        LEFT JOIN #LastYear y2 ON y.CarrierName = y2.CarrierName
                                  AND y.PartnerID = y2.PartnerID
GROUP BY y.CarrierName
ORDER BY SUM(y.EstBaseTotalShipmentValue) DESC';


--insert old records into hist
INSERT INTO dbo.tbgSQLCommandsHist
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
          KeepDuringRollback   )
        SELECT  PartnerID ,
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
        FROM    dbo.tbgSQLCommands WITH ( NOLOCK )
        WHERE   SQLGUID = @CurrentSQLGuid20
                AND Version = '20.4';

--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @CurrentSQLGuid20
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
          @CurrentSQLGuid20 , -- SQLGUID - uniqueidentifier
          @CurrentSQLScript20 , -- SQLCommand - varchar(max)
          @CurrentSQLDescription20 , -- Description - nvarchar(100)
          @CurrentSQLLongDescription20 , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @CurrentCreatedBy20 , -- CreatedBy - varchar(50)
          @CurrentApprovedBy20 , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@CurrentSQLScript20,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.4' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )


------------------------------------Value Shipped by Import Country - YoY ------------------------------------
DECLARE @CurrentSQLGuid21 AS VARCHAR(36) = '713F528F-17D3-4F36-9677-F5F20B29E578';
DECLARE @CurrentSQLDescription21 AS NVARCHAR(100) = 'Value Shipped by Import Country - YoY ';
DECLARE @CurrentSQLLongDescription21 AS NVARCHAR(MAX) = 'This comparison report shows the Import Countries with the highest associated total Shipment Value on all shipments for the current calendar year compared to the associated total Shipment Value on all shipments filed for the previous calendar year. ';
DECLARE @CurrentCreatedBy21 AS VARCHAR(50) = 'kduval';
DECLARE @CurrentApprovedBy21 AS VARCHAR(50) = '';

DECLARE @CurrentSQLScript21 AS NVARCHAR(MAX) = 'SELECT  h.PartnerID ,
        h.ImportCountry ,
        DATEPART(YEAR, ExportDate) AS ExportYear ,
        CAST(SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 2)) AS EstBaseTotalShipmentValue
INTO    #CurrentYear
FROM    txdGVExportHeader h WITH ( NOLOCK )
JOIN dbo.txdGVExportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.ExportGUID = h.ExportGuid
WHERE 1=1 AND @EXPORTDATERANGE AND h.PartnerID = @PartnerID 
        AND DATEPART(YEAR, ExportDate) = DATEPART(YEAR, GETDATE())
GROUP BY h.PartnerID ,
        ImportCountry ,
        DATEPART(YEAR, ExportDate)
SELECT  h.PartnerID ,
        h.ImportCountry ,
        DATEPART(YEAR, ExportDate) AS ExportYear ,
        CAST(SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 2)) AS EstBaseTotalShipmentValue
INTO    #LastYear
FROM    txdGVExportHeader h WITH ( NOLOCK )
JOIN dbo.txdGVExportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.ExportGUID = h.ExportGuid
WHERE 1=1 AND   DATEPART(YEAR, ExportDate) = DATEPART(YEAR,
                                              DATEADD(YEAR, -1, GETDATE()))
        AND ExportDate <= ( GETDATE() - 365 )
GROUP BY h.PartnerID ,
        ImportCountry ,
        DATEPART(YEAR, ExportDate)
SELECT TOP 10
        y.ImportCountry ,
        ISNULL(SUM(y.EstBaseTotalShipmentValue), 0) AS [@CurrentYear] ,
        ISNULL(SUM(y2.EstBaseTotalShipmentValue), 0) AS [@LastYear]
FROM    #CurrentYear y
        LEFT JOIN #LastYear y2 ON y.ImportCountry = y2.ImportCountry
                                  AND y.PartnerID = y2.PartnerID
GROUP BY y.ImportCountry
ORDER BY SUM(y.EstBaseTotalShipmentValue) DESC ';


--insert old records into hist
INSERT INTO dbo.tbgSQLCommandsHist
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
          KeepDuringRollback   )
        SELECT  PartnerID ,
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
        FROM    dbo.tbgSQLCommands WITH ( NOLOCK )
        WHERE   SQLGUID = @CurrentSQLGuid21
                AND Version = '20.4';

--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @CurrentSQLGuid21
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
          @CurrentSQLGuid21 , -- SQLGUID - uniqueidentifier
          @CurrentSQLScript21 , -- SQLCommand - varchar(max)
          @CurrentSQLDescription21 , -- Description - nvarchar(100)
          @CurrentSQLLongDescription21 , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @CurrentCreatedBy21 , -- CreatedBy - varchar(50)
          @CurrentApprovedBy21 , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@CurrentSQLScript21,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.4' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )


------------------------------------Value Shipped by Port of Unlading - YoY ------------------------------------
DECLARE @CurrentSQLGuid22 AS VARCHAR(36) = 'EF3DDA73-550D-438A-A614-FBE5A8EC6F4F';
DECLARE @CurrentSQLDescription22 AS NVARCHAR(100) = 'Value Shipped by Port of Unlading - YoY ';
DECLARE @CurrentSQLLongDescription22 AS NVARCHAR(MAX) = 'This comparison report shows the Ports of Unlading with the highest associated total Shipment Value on all shipments for the current calendar year compared to the associated total Shipment Value on all shipments filed for the previous calendar year. ';
DECLARE @CurrentCreatedBy22 AS VARCHAR(50) = 'kduval';
DECLARE @CurrentApprovedBy22 AS VARCHAR(50) = '';

DECLARE @CurrentSQLScript22 AS NVARCHAR(MAX) = 'SELECT  h.PartnerID ,
        h.PortOfUnlading ,
        DATEPART(YEAR, ExportDate) AS ExportYear ,
        CAST(SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 2)) AS EstBaseTotalShipmentValue
INTO    #CurrentYear
FROM    txdGVExportHeader h WITH ( NOLOCK )
JOIN dbo.txdGVExportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.ExportGUID = h.ExportGuid
WHERE 1=1 AND @EXPORTDATERANGE AND h.PartnerID = @PartnerID 
        AND DATEPART(YEAR, ExportDate) = DATEPART(YEAR, GETDATE())
GROUP BY h.PartnerID ,
        PortOfUnlading ,
        DATEPART(YEAR, ExportDate)
SELECT  h.PartnerID ,
        h.PortOfUnlading ,
        DATEPART(YEAR, ExportDate) AS ExportYear ,
        CAST(SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 2)) AS EstBaseTotalShipmentValue
INTO    #LastYear
FROM    txdGVExportHeader h WITH ( NOLOCK )
JOIN dbo.txdGVExportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.ExportGUID = h.ExportGuid
WHERE 1=1 AND   DATEPART(YEAR, ExportDate) = DATEPART(YEAR,
                                              DATEADD(YEAR, -1, GETDATE()))
        AND ExportDate <= ( GETDATE() - 365 )
GROUP BY h.PartnerID ,
        PortOfUnlading ,
        DATEPART(YEAR, ExportDate)
SELECT TOP 10
        y.PortOfUnlading ,
        ISNULL(SUM(y.EstBaseTotalShipmentValue), 0) AS [@CurrentYear] ,
        ISNULL(SUM(y2.EstBaseTotalShipmentValue), 0) AS [@LastYear]
FROM    #CurrentYear y
        LEFT JOIN #LastYear y2 ON y.PortOfUnlading = y2.PortOfUnlading
                                  AND y.PartnerID = y2.PartnerID
GROUP BY y.PortOfUnlading
ORDER BY SUM(y.EstBaseTotalShipmentValue) DESC';


--insert old records into hist
INSERT INTO dbo.tbgSQLCommandsHist
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
          KeepDuringRollback   )
        SELECT  PartnerID ,
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
        FROM    dbo.tbgSQLCommands WITH ( NOLOCK )
        WHERE   SQLGUID = @CurrentSQLGuid22
                AND Version = '20.4';

--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @CurrentSQLGuid22
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
          @CurrentSQLGuid22 , -- SQLGUID - uniqueidentifier
          @CurrentSQLScript22 , -- SQLCommand - varchar(max)
          @CurrentSQLDescription22 , -- Description - nvarchar(100)
          @CurrentSQLLongDescription22 , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @CurrentCreatedBy22 , -- CreatedBy - varchar(50)
          @CurrentApprovedBy22 , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@CurrentSQLScript22,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.4' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )


------------------------------------Value Shipped by Port of Lading - YoY ------------------------------------
DECLARE @CurrentSQLGuid23 AS VARCHAR(36) = '3E186D09-4980-4976-85FD-1B40C46DFE2B';
DECLARE @CurrentSQLDescription23 AS NVARCHAR(100) = 'Value Shipped by Port of Lading - YoY ';
DECLARE @CurrentSQLLongDescription23 AS NVARCHAR(MAX) = 'This comparison report shows the Ports of Lading with the highest associated total Shipment Value on all shipments for the current calendar year compared to the associated total Shipment Value on all shipments filed for the previous calendar year. ';
DECLARE @CurrentCreatedBy23 AS VARCHAR(50) = 'kduval';
DECLARE @CurrentApprovedBy23 AS VARCHAR(50) = '';

DECLARE @CurrentSQLScript23 AS NVARCHAR(MAX) = 'SELECT  h.PartnerID ,
        h.PortOfLading ,
        DATEPART(YEAR, ExportDate) AS ExportYear ,
        CAST(SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 2)) AS EstBaseTotalShipmentValue
INTO    #CurrentYear
FROM    txdGVExportHeader h WITH ( NOLOCK )
JOIN dbo.txdGVExportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.ExportGUID = h.ExportGuid
WHERE 1=1 AND @EXPORTDATERANGE AND h.PartnerID = @PartnerID 
        AND DATEPART(YEAR, ExportDate) = DATEPART(YEAR, GETDATE())
GROUP BY h.PartnerID ,
        PortOfLading ,
        DATEPART(YEAR, ExportDate)
SELECT  h.PartnerID ,
        h.PortOfLading ,
        DATEPART(YEAR, ExportDate) AS ExportYear ,
        CAST(SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 2)) AS EstBaseTotalShipmentValue
INTO    #LastYear
FROM    txdGVExportHeader h WITH ( NOLOCK )
JOIN dbo.txdGVExportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.ExportGUID = h.ExportGuid
WHERE 1=1 AND   DATEPART(YEAR, ExportDate) = DATEPART(YEAR,
                                              DATEADD(YEAR, -1, GETDATE()))
        AND ExportDate <= ( GETDATE() - 365 )
GROUP BY h.PartnerID ,
        PortOfLading ,
        DATEPART(YEAR, ExportDate)
SELECT TOP 10
        y.PortOfLading ,
        ISNULL(SUM(y.EstBaseTotalShipmentValue), 0) AS [@CurrentYear] ,
        ISNULL(SUM(y2.EstBaseTotalShipmentValue), 0) AS [@LastYear]
FROM    #CurrentYear y
        LEFT JOIN #LastYear y2 ON y.PortOfLading = y2.PortOfLading
                                  AND y.PartnerID = y2.PartnerID
GROUP BY y.PortOfLading
ORDER BY SUM(y.EstBaseTotalShipmentValue) DESC';


--insert old records into hist
INSERT INTO dbo.tbgSQLCommandsHist
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
          KeepDuringRollback   )
        SELECT  PartnerID ,
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
        FROM    dbo.tbgSQLCommands WITH ( NOLOCK )
        WHERE   SQLGUID = @CurrentSQLGuid23
                AND Version = '20.4';

--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @CurrentSQLGuid23
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
          @CurrentSQLGuid23 , -- SQLGUID - uniqueidentifier
          @CurrentSQLScript23 , -- SQLCommand - varchar(max)
          @CurrentSQLDescription23 , -- Description - nvarchar(100)
          @CurrentSQLLongDescription23 , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @CurrentCreatedBy23 , -- CreatedBy - varchar(50)
          @CurrentApprovedBy23 , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@CurrentSQLScript23,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.4' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )


------------------------------------Hazardous Material Exported by Export Country - YoY------------------------------------
DECLARE @CurrentSQLGuid24 AS VARCHAR(36) = 'CC401E6E-8FF9-46DB-B90F-C6A22837834B';
DECLARE @CurrentSQLDescription24 AS NVARCHAR(100) = 'Hazardous Material Exported by Export Country - YoY';
DECLARE @CurrentSQLLongDescription24 AS NVARCHAR(MAX) = 'This comparison report shows the Export Countries with the  associated total value of hazardous materials on all shipments filed for the current year compared to the total value of hazardous materials on all shipments exported out of the same countries the previous year. ';
DECLARE @CurrentCreatedBy24 AS VARCHAR(50) = 'kduval';
DECLARE @CurrentApprovedBy24 AS VARCHAR(50) = '';

DECLARE @CurrentSQLScript24 AS NVARCHAR(MAX) = 'SELECT  h.PartnerID ,
        h.ExportCountry ,
        h.HazMatFlag ,
        DATEPART(YEAR, ExportDate) AS ExportYear ,
        CAST(SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 2)) AS EstBaseTotalShipmentValue
INTO    #CurrentYear
FROM    txdGVExportHeader h WITH ( NOLOCK )
        JOIN txdGVExportDetail d WITH ( NOLOCK ) ON h.ExportGuid = d.ExportGUID
                                                    AND h.PartnerID = d.PartnerID
WHERE 1=1 AND h.PartnerID = @PartnerID AND DATEPART(YEAR, ExportDate) = DATEPART(YEAR, GETDATE())
GROUP BY h.PartnerID ,
        h.ExportCountry ,
        h.HazMatFlag ,
        DATEPART(YEAR, ExportDate)
SELECT  h.PartnerID ,
        h.ExportCountry ,
        DATEPART(YEAR, ExportDate) AS ExportYear ,
        CAST(SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 2)) AS EstBaseTotalShipmentValue
INTO    #LastYear
FROM    txdGVExportHeader h WITH ( NOLOCK )
        JOIN txdGVExportDetail d WITH ( NOLOCK ) ON h.ExportGuid = d.ExportGUID
                                                    AND h.PartnerID = d.PartnerID
WHERE 1=1 AND   DATEPART(YEAR, ExportDate) = DATEPART(YEAR,
                                              DATEADD(YEAR, -1, GETDATE()))
        AND ExportDate <= ( GETDATE() - 365 )
GROUP BY h.PartnerID ,
        h.ExportCountry ,
        DATEPART(YEAR, ExportDate)
SELECT TOP 10
        d.ExportCountry ,
        ISNULL(SUM(d.EstBaseTotalShipmentValue), 0) AS [@CurrentYear] ,
        ISNULL(SUM(d2.EstBaseTotalShipmentValue), 0) AS [@LastYear]
FROM    #CurrentYear d
        LEFT JOIN #LastYear d2 ON d.ExportCountry = d2.ExportCountry
                                  AND d.PartnerID = d2.PartnerID
WHERE   d.HazMatFlag = ''Y''
GROUP BY d.ExportCountry
ORDER BY SUM(d.EstBaseTotalShipmentValue) DESC';


--insert old records into hist
INSERT INTO dbo.tbgSQLCommandsHist
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
          KeepDuringRollback   )
        SELECT  PartnerID ,
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
        FROM    dbo.tbgSQLCommands WITH ( NOLOCK )
        WHERE   SQLGUID = @CurrentSQLGuid24
                AND Version = '20.4';

--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @CurrentSQLGuid24
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
          @CurrentSQLGuid24 , -- SQLGUID - uniqueidentifier
          @CurrentSQLScript24 , -- SQLCommand - varchar(max)
          @CurrentSQLDescription24 , -- Description - nvarchar(100)
          @CurrentSQLLongDescription24 , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @CurrentCreatedBy24 , -- CreatedBy - varchar(50)
          @CurrentApprovedBy24 , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@CurrentSQLScript24,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.4' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )


------------------------------------Total Shipment Weight by Quarter - YoY------------------------------------
DECLARE @CurrentSQLGuid25 AS VARCHAR(36) = 'FB9214E8-8AE8-4C75-83EC-38F115F2CD75';
DECLARE @CurrentSQLDescription25 AS NVARCHAR(100) = 'Total Shipment Weight by Quarter - YoY';
DECLARE @CurrentSQLLongDescription25 AS NVARCHAR(MAX) = 'This report shows the total weight of all exports declared during each quarter of the current calendar year compared to the total weight of all exports declared during the same quarter(s) of the previous year.';
DECLARE @CurrentCreatedBy25 AS VARCHAR(50) = 'kduval';
DECLARE @CurrentApprovedBy25 AS VARCHAR(50) = '';

DECLARE @CurrentSQLScript25 AS NVARCHAR(MAX) = 'SELECT  h.PartnerID ,
        DATEPART(YEAR, ExportDate) AS ExportYear ,
        ''Q'' + DATENAME(QUARTER, ExportDate) AS ExportQuarter ,
        CAST(SUM(d.NetWeight) AS NUMERIC(28, 0)) AS TotalWeightShipped
INTO    #CurrentYear
FROM    txdGVExportHeader h WITH ( NOLOCK )
JOIN dbo.txdGVExportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.ExportGUID = h.ExportGuid
WHERE 1=1 AND @EXPORTDATERANGE AND h.PartnerID = @PartnerID 
AND DATEPART(YEAR, ExportDate) = DATEPART(YEAR, GETDATE())
GROUP BY h.PartnerID ,
        DATEPART(YEAR, ExportDate) ,
        DATENAME(QUARTER, ExportDate)
SELECT  h.PartnerID ,
        DATEPART(YEAR, ExportDate) AS ExportYear ,
        ''Q'' + DATENAME(QUARTER, ExportDate) AS ExportQuarter ,
        CAST(SUM(TotalNetWeight) AS NUMERIC(28, 0)) AS TotalWeightShipped
INTO    #LastYear
FROM    txdGVExportHeader h WITH (NOLOCK)
JOIN dbo.txdGVExportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.ExportGUID = h.ExportGuid
WHERE 1=1 AND   DATEPART(YEAR, ExportDate) = DATEPART(YEAR,
                                              DATEADD(YEAR, -1, GETDATE()))
        AND ExportDate <= ( GETDATE() - 365 )
GROUP BY h.PartnerID ,
        DATEPART(YEAR, ExportDate) ,
        DATENAME(QUARTER, ExportDate)
SELECT TOP 10
        h.ExportQuarter ,
        ISNULL(h.TotalWeightShipped, 0) AS [@CurrentYear] ,
        ISNULL(h2.TotalWeightShipped, 0) AS [@LastYear]
FROM    #CurrentYear h
        LEFT JOIN #LastYear h2 ON h.ExportQuarter = h2.ExportQuarter
                                  AND h.PartnerID = h2.PartnerID
ORDER BY h.TotalWeightShipped DESC';


--insert old records into hist
INSERT INTO dbo.tbgSQLCommandsHist
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
          KeepDuringRollback   )
        SELECT  PartnerID ,
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
        FROM    dbo.tbgSQLCommands WITH ( NOLOCK )
        WHERE   SQLGUID = @CurrentSQLGuid25
                AND Version = '20.4';

--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @CurrentSQLGuid25
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
          @CurrentSQLGuid25 , -- SQLGUID - uniqueidentifier
          @CurrentSQLScript25 , -- SQLCommand - varchar(max)
          @CurrentSQLDescription25 , -- Description - nvarchar(100)
          @CurrentSQLLongDescription25 , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @CurrentCreatedBy25 , -- CreatedBy - varchar(50)
          @CurrentApprovedBy25 , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@CurrentSQLScript25,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.4' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )


------------------------------------Total Shipment Weight by Month - YoY------------------------------------
DECLARE @CurrentSQLGuid26 AS VARCHAR(36) = '76D27B59-E963-4D63-A549-2236E2B19995';
DECLARE @CurrentSQLDescription26 AS NVARCHAR(100) = 'Total Shipment Weight by Month - YoY';
DECLARE @CurrentSQLLongDescription26 AS NVARCHAR(MAX) = 'This report shows the total weight of all exports declared during each month of the current calendar year compared to the total weight of all exports during the same month(s) of the previous year.';
DECLARE @CurrentCreatedBy26 AS VARCHAR(50) = 'kduval';
DECLARE @CurrentApprovedBy26 AS VARCHAR(50) = '';

DECLARE @CurrentSQLScript26 AS NVARCHAR(MAX) = 'SELECT  h.PartnerID ,
        DATEPART(YEAR, ExportDate) AS ExportYear ,
        DATEPART(MONTH, ExportDate) AS ExportMonth ,
        CAST(SUM(d.NetWeight) AS NUMERIC(28, 0)) AS TotalWeightShipped
INTO    #CurrentYear
FROM    txdGVExportHeader h WITH ( NOLOCK )
JOIN dbo.txdGVExportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.ExportGUID = h.ExportGuid
WHERE 1=1 AND @EXPORTDATERANGE AND h.PartnerID = @PartnerID 
AND DATEPART(YEAR, ExportDate) = DATEPART(YEAR, GETDATE())
GROUP BY h.PartnerID ,
        DATEPART(YEAR, ExportDate) ,
        DATEPART(MONTH, ExportDate)
SELECT  h.PartnerID ,
        DATEPART(YEAR, ExportDate) AS ExportYear ,
        DATEPART(MONTH, ExportDate) AS ExportMonth ,
        CAST(SUM(d.NetWeight) AS NUMERIC(28, 0)) AS TotalWeightShipped
INTO    #LastYear
FROM    txdGVExportHeader h WITH (NOLOCK)
JOIN dbo.txdGVExportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.ExportGUID = h.ExportGuid
WHERE 1=1 AND   DATEPART(YEAR, ExportDate) = DATEPART(YEAR,
                                              DATEADD(YEAR, -1, GETDATE()))
        AND ExportDate <= ( GETDATE() - 365 )
GROUP BY h.PartnerID ,
        DATEPART(YEAR, ExportDate) ,
        DATEPART(MONTH, ExportDate)
SELECT TOP 10
        h.ExportMonth ,
        ISNULL(SUM(h.TotalWeightShipped), 0) AS [@CurrentYear] ,
        ISNULL(SUM(h2.TotalWeightShipped), 0) AS [@LastYear]
FROM    #CurrentYear h
        LEFT JOIN #LastYear h2 ON h.ExportMonth = h2.ExportMonth
                                  AND h.PartnerID = h2.PartnerID
GROUP BY h.ExportMonth
ORDER BY h.ExportMonth ASC';


--insert old records into hist
INSERT INTO dbo.tbgSQLCommandsHist
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
          KeepDuringRollback   )
        SELECT  PartnerID ,
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
        FROM    dbo.tbgSQLCommands WITH ( NOLOCK )
        WHERE   SQLGUID = @CurrentSQLGuid26
                AND Version = '20.4';

--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @CurrentSQLGuid26
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
          @CurrentSQLGuid26 , -- SQLGUID - uniqueidentifier
          @CurrentSQLScript26 , -- SQLCommand - varchar(max)
          @CurrentSQLDescription26 , -- Description - nvarchar(100)
          @CurrentSQLLongDescription26 , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @CurrentCreatedBy26 , -- CreatedBy - varchar(50)
          @CurrentApprovedBy26 , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@CurrentSQLScript26,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.4' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )


------------------------------------Total Shipment Value by Quarter - YoY------------------------------------
DECLARE @CurrentSQLGuid27 AS VARCHAR(36) = 'F1F18209-12F2-4F51-8B6C-0BB177A5235F';
DECLARE @CurrentSQLDescription27 AS NVARCHAR(100) = 'Total Shipment Value by Quarter - YoY';
DECLARE @CurrentSQLLongDescription27 AS NVARCHAR(MAX) = 'This report shows the total value of all exports declared during each quarter of the current year compared to the total value of all exports during the same quarter(s) during the previous year.';
DECLARE @CurrentCreatedBy27 AS VARCHAR(50) = 'kduval';
DECLARE @CurrentApprovedBy27 AS VARCHAR(50) = '';

DECLARE @CurrentSQLScript27 AS NVARCHAR(MAX) = 'SELECT  h.PartnerID ,
        DATEPART(YEAR, ExportDate) AS ExportYear ,
        ''Q'' + DATENAME(QUARTER, ExportDate) AS ExportQuarter ,
        CAST(SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 2)) AS Value
INTO    #CurrentYear
FROM    txdGVExportHeader h WITH ( NOLOCK )
JOIN dbo.txdGVExportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.ExportGUID = h.ExportGuid
WHERE 1=1 AND @EXPORTDATERANGE AND h.PartnerID = @PartnerID 
AND DATEPART(YEAR, ExportDate) = DATEPART(YEAR, GETDATE())
GROUP BY h.PartnerID ,
        DATEPART(YEAR, ExportDate) ,
        DATENAME(QUARTER, ExportDate)
SELECT  h.PartnerID ,
        DATEPART(YEAR, ExportDate) AS ExportYear ,
        ''Q'' + DATENAME(QUARTER, ExportDate) AS ExportQuarter ,
        CAST(SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 2)) AS Value
INTO    #LastYear
FROM    txdGVExportHeader h WITH (NOLOCK)
JOIN dbo.txdGVExportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.ExportGUID = h.ExportGuid
WHERE 1=1 AND   DATEPART(YEAR, ExportDate) = DATEPART(YEAR,
                                              DATEADD(YEAR, -1, GETDATE()))
        AND ExportDate <= ( GETDATE() - 365 )
GROUP BY h.PartnerID ,
        DATEPART(YEAR, ExportDate) ,
        DATENAME(QUARTER, ExportDate)
SELECT TOP 10
        h.ExportQuarter ,
        ISNULL(h.Value, 0) AS [@CurrentYear] ,
        ISNULL(h2.Value, 0) AS [@LastYear]
FROM    #CurrentYear h
        LEFT JOIN #LastYear h2 ON h.ExportQuarter = h2.ExportQuarter
                                  AND h.PartnerID = h2.PartnerID
ORDER BY h.Value DESC ';


--insert old records into hist
INSERT INTO dbo.tbgSQLCommandsHist
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
          KeepDuringRollback   )
        SELECT  PartnerID ,
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
        FROM    dbo.tbgSQLCommands WITH ( NOLOCK )
        WHERE   SQLGUID = @CurrentSQLGuid27
                AND Version = '20.4';

--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @CurrentSQLGuid27
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
          @CurrentSQLGuid27 , -- SQLGUID - uniqueidentifier
          @CurrentSQLScript27 , -- SQLCommand - varchar(max)
          @CurrentSQLDescription27 , -- Description - nvarchar(100)
          @CurrentSQLLongDescription27 , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @CurrentCreatedBy27 , -- CreatedBy - varchar(50)
          @CurrentApprovedBy27 , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@CurrentSQLScript27,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.4' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )


------------------------------------Total Shipment Weight YTD - YoY------------------------------------
DECLARE @CurrentSQLGuid28 AS VARCHAR(36) = 'F11EB1B4-822B-4588-9237-42EF69C112BB';
DECLARE @CurrentSQLDescription28 AS NVARCHAR(100) = 'Total Shipment Weight YTD - YoY';
DECLARE @CurrentSQLLongDescription28 AS NVARCHAR(MAX) = 'This report shows the total weight of all exports declared since January 1st of the current calendar year compared to the total weight of exports declared during the same time period in the previous year.';
DECLARE @CurrentCreatedBy28 AS VARCHAR(50) = 'kduval';
DECLARE @CurrentApprovedBy28 AS VARCHAR(50) = '';

DECLARE @CurrentSQLScript28 AS NVARCHAR(MAX) = 'SELECT  h.PartnerID ,
        DATEPART(MONTH, MAX(h.ExportDate)) AS ExportMonth ,
        CAST(SUM(d.NetWeight) AS NUMERIC(28, 0)) AS Weight
INTO    #YTDTotalShipmentWeight
FROM    txdGVExportHeader h WITH ( NOLOCK )
JOIN dbo.txdGVExportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.ExportGUID = h.ExportGuid
WHERE 1=1 AND @EXPORTDATERANGE AND h.PartnerID = @PartnerID 
AND DATEPART(YEAR, h.ExportDate) = DATEPART(YEAR, GETDATE())
GROUP BY h.PartnerID ,
        YEAR(h.ExportDate) ,
        MONTH(h.ExportDate)
ORDER BY YEAR(h.ExportDate) ,
        MONTH(h.ExportDate)
SELECT  h.PartnerID ,
        DATEPART(MONTH, MAX(h.ExportDate)) AS ExportMonth ,
        CAST(SUM(d.NetWeight) AS NUMERIC(28, 0)) AS Weight
INTO    #YTDTotalShipmentWeight2
FROM    txdGVExportHeader h WITH ( NOLOCK )
JOIN dbo.txdGVExportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.ExportGUID = h.ExportGuid
WHERE 1=1 AND   DATEPART(YEAR, h.ExportDate) = DATEPART(YEAR,
                                                DATEADD(YEAR, -1, GETDATE()))
        AND ExportDate <= ( GETDATE() - 365 )
GROUP BY h.PartnerID ,
        YEAR(h.ExportDate) ,
        MONTH(h.ExportDate)
ORDER BY YEAR(h.ExportDate) ,
        MONTH(h.ExportDate)
SELECT  b.ExportMonth ,
        ISNULL(( SELECT SUM(a.Weight)
                 FROM   #YTDTotalShipmentWeight a
                 WHERE  a.ExportMonth <= b.ExportMonth
                        AND a.PartnerID = b.PartnerID
               ), 0) AS [@CurrentYear] ,
        ISNULL(( SELECT SUM(c.Weight)
                 FROM   #YTDTotalShipmentWeight2 c
                 WHERE  c.ExportMonth <= b.ExportMonth
                        AND c.PartnerID = b.PartnerID
               ), 0) AS [@LastYear]
FROM    #YTDTotalShipmentWeight b
WHERE   b.PartnerID = @PartnerID';


--insert old records into hist
INSERT INTO dbo.tbgSQLCommandsHist
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
          KeepDuringRollback   )
        SELECT  PartnerID ,
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
        FROM    dbo.tbgSQLCommands WITH ( NOLOCK )
        WHERE   SQLGUID = @CurrentSQLGuid28
                AND Version = '20.4';

--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @CurrentSQLGuid28
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
          @CurrentSQLGuid28 , -- SQLGUID - uniqueidentifier
          @CurrentSQLScript28 , -- SQLCommand - varchar(max)
          @CurrentSQLDescription28 , -- Description - nvarchar(100)
          @CurrentSQLLongDescription28 , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @CurrentCreatedBy28 , -- CreatedBy - varchar(50)
          @CurrentApprovedBy28 , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@CurrentSQLScript28,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.4' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )


------------------------------------Total Shipment Value YTD - YoY------------------------------------
DECLARE @CurrentSQLGuid29 AS VARCHAR(36) = 'CE3A088F-0A60-46DF-948D-7DE318FF85B7';
DECLARE @CurrentSQLDescription29 AS NVARCHAR(100) = 'Total Shipment Value YTD - YoY';
DECLARE @CurrentSQLLongDescription29 AS NVARCHAR(MAX) = 'This report shows the total value of all exports declared since January 1st of the current calendar year compared to the value of exports during the same time period in the previous year.';
DECLARE @CurrentCreatedBy29 AS VARCHAR(50) = 'kduval';
DECLARE @CurrentApprovedBy29 AS VARCHAR(50) = '';

DECLARE @CurrentSQLScript29 AS NVARCHAR(MAX) = 'SELECT  h.PartnerID ,
        DATEPART(MONTH, MAX(h.ExportDate)) AS ExportMonth ,
        CAST(SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 2)) AS Value
INTO    #YTDTotalShipmentValue
FROM    txdGVExportHeader h WITH ( NOLOCK )
JOIN dbo.txdGVExportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.ExportGUID = h.ExportGuid
WHERE 1=1 AND @EXPORTDATERANGE AND h.PartnerID = @PartnerID 
AND DATEPART(YEAR, h.ExportDate) = DATEPART(YEAR, GETDATE())
GROUP BY h.PartnerID ,
        YEAR(h.ExportDate) ,
        MONTH(h.ExportDate)
ORDER BY YEAR(h.ExportDate) ,
        MONTH(h.ExportDate)
SELECT  h.PartnerID ,
        DATEPART(MONTH, MAX(h.ExportDate)) AS ExportMonth ,
        CAST(SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 2)) AS Value
INTO    #YTDTotalShipmentValue2
FROM    txdGVExportHeader h WITH ( NOLOCK )
JOIN dbo.txdGVExportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.ExportGUID = h.ExportGuid
WHERE 1=1 AND   DATEPART(YEAR, h.ExportDate) = DATEPART(YEAR,
                                                DATEADD(YEAR, -1, GETDATE()))
        AND ExportDate <= ( GETDATE() - 365 )
GROUP BY h.PartnerID ,
        YEAR(h.ExportDate) ,
        MONTH(h.ExportDate)
ORDER BY YEAR(h.ExportDate) ,
        MONTH(h.ExportDate)
SELECT  b.ExportMonth ,
        ISNULL(( SELECT SUM(a.Value)
                 FROM   #YTDTotalShipmentValue a
                 WHERE  a.ExportMonth <= b.ExportMonth
                        AND a.PartnerID = b.PartnerID
               ), 0) AS [@CurrentYear] ,
        ISNULL(( SELECT SUM(c.Value)
                 FROM   #YTDTotalShipmentValue2 c
                 WHERE  c.ExportMonth <= b.ExportMonth
                        AND c.PartnerID = b.PartnerID
               ), 0) AS [@LastYear]
FROM    #YTDTotalShipmentValue b
WHERE b.PartnerID = @PartnerID';


--insert old records into hist
INSERT INTO dbo.tbgSQLCommandsHist
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
          KeepDuringRollback   )
        SELECT  PartnerID ,
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
        FROM    dbo.tbgSQLCommands WITH ( NOLOCK )
        WHERE   SQLGUID = @CurrentSQLGuid29
                AND Version = '20.4';

--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @CurrentSQLGuid29
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
          @CurrentSQLGuid29 , -- SQLGUID - uniqueidentifier
          @CurrentSQLScript29 , -- SQLCommand - varchar(max)
          @CurrentSQLDescription29 , -- Description - nvarchar(100)
          @CurrentSQLLongDescription29 , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @CurrentCreatedBy29 , -- CreatedBy - varchar(50)
          @CurrentApprovedBy29 , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@CurrentSQLScript29,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.4' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )


------------------------------------WCO Export Tariff Numbers by Value - YoY------------------------------------
DECLARE @CurrentSQLGuid30 AS VARCHAR(36) = '348748D6-43CA-4882-9BDC-D27BBF3B0CC8';
DECLARE @CurrentSQLDescription30 AS NVARCHAR(100) = 'WCO Export Tariff Numbers by Value - YoY';
DECLARE @CurrentSQLLongDescription30 AS NVARCHAR(MAX) = 'This comparison report shows the WCO export tariff numbers with the highest associated total shipment value on all shipments for the current year compared to the highest associated total shipment value on all shipments filed for the previous year.';
DECLARE @CurrentCreatedBy30 AS VARCHAR(50) = 'C7437BEB-8910-4DDC-9DC1-DCDE65FB46C1';
DECLARE @CurrentApprovedBy30 AS VARCHAR(50) = '';

DECLARE @CurrentSQLScript30 AS NVARCHAR(MAX) = 'SELECT h.PartnerID,  d.ExportWCOTariffNum,  datepart(year, ExportDate) AS ExportYear,  CAST(SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 2)) AS EstBaseTotalLineValue INTO #CurrentYear FROM txdgvexportheader h WITH (NOLOCK) JOIN txdgvExportdetail d WITH (NOLOCK) ON h.exportguid = d.exportguid  AND h.partnerid = d.partnerid WHERE 1=1  AND @EXPORTDATERANGE  AND h.PartnerID = @PartnerID  AND datepart(year, ExportDate) = DATEPART(year, GetDate()) GROUP BY h.PartnerID,  d.ExportWCOTariffNum,  datepart(year, ExportDate)  SELECT h.PartnerID,  d.ExportWCOTariffNum,  datepart(year, ExportDate) AS ExportYear,  CAST(SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 2)) AS EstBaseTotalLineValue INTO #LastYear FROM txdgvexportheader h WITH (NOLOCK) JOIN txdgvexportdetail d WITH (NOLOCK) ON h.exportguid = d.exportguid  AND h.partnerid = d.partnerid WHERE 1=1 AND datepart(year, ExportDate) = DATEPART(year, dateadd(year, - 1, GetDate()))  AND ExportDate <= (GETDATE() - 365) GROUP BY h.PartnerID,  d.ExportWCOTariffNum,  datepart(year, ExportDate)  SELECT TOP 10 h.ExportWCOTariffNum,  isnull(sum(h.EstBaseTotalLineValue), 0) AS [@CurrentYear],  isnull(sum(h2.EstBaseTotalLineValue), 0) AS [@LastYear] FROM #CurrentYear h LEFT JOIN #LastYear h2 ON h.ExportWCOTariffNum = h2.ExportWCOTariffNum  AND h.PartnerID = h2.PartnerID GROUP BY h.ExportWCOTariffNum ORDER BY sum(h.EstBaseTotalLineValue) DESC';


--insert old records into hist
INSERT INTO dbo.tbgSQLCommandsHist
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
          KeepDuringRollback   )
        SELECT  PartnerID ,
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
        FROM    dbo.tbgSQLCommands WITH ( NOLOCK )
        WHERE   SQLGUID = @CurrentSQLGuid30
                AND Version = '20.4';

--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @CurrentSQLGuid30
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
          @CurrentSQLGuid30 , -- SQLGUID - uniqueidentifier
          @CurrentSQLScript30 , -- SQLCommand - varchar(max)
          @CurrentSQLDescription30 , -- Description - nvarchar(100)
          @CurrentSQLLongDescription30 , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @CurrentCreatedBy30 , -- CreatedBy - varchar(50)
          @CurrentApprovedBy30 , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@CurrentSQLScript30,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.4' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )


------------------------------------Value Exported by Export Country - YoY------------------------------------
DECLARE @CurrentSQLGuid31 AS VARCHAR(36) = '42757104-1DF4-4D83-8CAC-BF180D581A48';
DECLARE @CurrentSQLDescription31 AS NVARCHAR(100) = 'Value Exported by Export Country - YoY';
DECLARE @CurrentSQLLongDescription31 AS NVARCHAR(MAX) = 'This comparison report shows the Export Countries with the highest associated number of non EAR99 lines on all shipments for the current calendar year compared to the highest associated number of non EAR99 lines on all shipments filed for the previous calendar year. ';
DECLARE @CurrentCreatedBy31 AS VARCHAR(50) = 'jmerwin';
DECLARE @CurrentApprovedBy31 AS VARCHAR(50) = 'jmerwin';

DECLARE @CurrentSQLScript31 AS NVARCHAR(MAX) = 'select h.PartnerID, h.ExportCountry, datepart(year, h.ExportDate) as ExportYear, COUNT(d.ExportDetailGUID) as TotalLineCount INTO #CurrentYear from txdGVExportHeader h WITH (NOLOCK) join txdGVExportDetail d WITH (NOLOCK) ON h.ExportGUID = d.ExportGUID AND h.PartnerID = d.PartnerID WHERE 1=1 AND @EXPORTDATERANGE AND h.PartnerID = @PartnerID and datepart(year, h.ExportDate) = DATEPART(year, GetDate()) group by h.PartnerID, h.ExportCountry, datepart(year, h.ExportDate)  select h.PartnerID, h.ExportCountry, datepart(year, h.ExportDate) as ExportYear, COUNT(d.ExportDetailGUID) as TotalLineCount INTO #LastYear from txdGVExportHeader h WITH (NOLOCK) join txdGVExportDetail d WITH (NOLOCK) ON h.ExportGUID = d.ExportGUID AND h.PartnerID = d.PartnerID WHERE 1=1 AND datepart(year, h.ExportDate) = DATEPART(year, dateadd(year, -1, GetDate())) and h.ExportDate <= (GETDATE()-365) group by h.PartnerID, h.ExportCountry, datepart(year, h.ExportDate)   SELECT TOP 10 h.ExportCountry, isnull(sum(h.TotalLineCount), 0) as [@CurrentYear], isnull(sum(h2.TotalLineCount), 0) as [@LastYear] FROM #CurrentYear h left join #LastYear h2 on h.ExportCountry = h2.ExportCountry and h.PartnerID = h2.PartnerID Group By h.ExportCountry ORDER BY sum(h.TotalLineCount) DESC';


--insert old records into hist
INSERT INTO dbo.tbgSQLCommandsHist
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
          KeepDuringRollback   )
        SELECT  PartnerID ,
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
        FROM    dbo.tbgSQLCommands WITH ( NOLOCK )
        WHERE   SQLGUID = @CurrentSQLGuid31
                AND Version = '20.4';

--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @CurrentSQLGuid31
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
          @CurrentSQLGuid31 , -- SQLGUID - uniqueidentifier
          @CurrentSQLScript31 , -- SQLCommand - varchar(max)
          @CurrentSQLDescription31 , -- Description - nvarchar(100)
          @CurrentSQLLongDescription31 , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @CurrentCreatedBy31 , -- CreatedBy - varchar(50)
          @CurrentApprovedBy31 , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@CurrentSQLScript31,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.4' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )


------------------------------------------------------------------------
DECLARE @CurrentSQLGuid32 AS VARCHAR(36) = '4402835A-0FAD-474E-85E3-B574932D2365';
DECLARE @CurrentSQLDescription32 AS NVARCHAR(100) = '';
DECLARE @CurrentSQLLongDescription32 AS NVARCHAR(MAX) = 'This comparison report shows the Product Numbers with the highest associated total Shipment Value on all shipments for the current calendar year compared to the associated total Shipment Value on all shipments filed for the previous calendar year. ';
DECLARE @CurrentCreatedBy32 AS VARCHAR(50) = 'jmerwin';
DECLARE @CurrentApprovedBy32 AS VARCHAR(50) = 'jmerwin';

DECLARE @CurrentSQLScript32 AS NVARCHAR(MAX) = 'SELECT h.PartnerID  ,d.ProductNum  ,datepart(year, ExportDate) AS ExportYear  ,CAST(SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 2)) AS EstBaseTotalLineValue INTO #CurrentYear from txdgvexportheader h WITH (NOLOCK) join txdgvExportdetail d WITH (NOLOCK)  ON h.exportguid = d.exportguid  AND h.partnerid = d.partnerid WHERE 1=1 AND @EXPORTDATERANGE AND h.PartnerID = @PartnerID AND datepart(year, ExportDate) = DATEPART(year, GetDate()) GROUP BY h.PartnerID  ,d.ProductNum  ,datepart(year, ExportDate)  SELECT h.PartnerID  ,d.ProductNum  ,datepart(year, ExportDate) AS ExportYear  ,CAST(SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 2)) AS EstBaseTotalLineValue INTO #LastYear from txdgvexportheader h WITH (NOLOCK) join txdgvexportdetail d WITH (NOLOCK)  ON h.exportguid = d.exportguid  AND h.partnerid = d.partnerid WHERE 1=1 AND datepart(year, ExportDate) = DATEPART(year, dateadd(year, - 1, GetDate())) and ExportDate <= (GETDATE()-365) GROUP BY h.PartnerID  ,d.ProductNum  ,datepart(year, ExportDate)  SELECT TOP 10 h.ProductNum  ,isnull(sum(h.EstBaseTotalLineValue), 0) AS [@CurrentYear]  ,isnull(sum(h2.EstBaseTotalLineValue), 0) AS [@LastYear] FROM #CurrentYear h LEFT JOIN #LastYear h2   ON h.ProductNum= h2.ProductNum  AND h.PartnerID = h2.PartnerID GROUP BY h.ProductNum ORDER BY sum(h.EstBaseTotalLineValue) DESC';


--insert old records into hist
INSERT INTO dbo.tbgSQLCommandsHist
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
          KeepDuringRollback   )
        SELECT  PartnerID ,
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
        FROM    dbo.tbgSQLCommands WITH ( NOLOCK )
        WHERE   SQLGUID = @CurrentSQLGuid32
                AND Version = '20.4';

--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @CurrentSQLGuid32
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
          @CurrentSQLGuid32 , -- SQLGUID - uniqueidentifier
          @CurrentSQLScript32 , -- SQLCommand - varchar(max)
          @CurrentSQLDescription32 , -- Description - nvarchar(100)
          @CurrentSQLLongDescription32 , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @CurrentCreatedBy32 , -- CreatedBy - varchar(50)
          @CurrentApprovedBy32 , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@CurrentSQLScript32,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.4' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )


------------------------------------Value Shipped by Export Tariff Number - YoY------------------------------------
DECLARE @CurrentSQLGuid33 AS VARCHAR(36) = '7803B70A-E23E-43F2-A1AC-FBD0A3213602';
DECLARE @CurrentSQLDescription33 AS NVARCHAR(100) = 'Value Shipped by Export Tariff Number - YoY';
DECLARE @CurrentSQLLongDescription33 AS NVARCHAR(MAX) = 'This comparison report shows the Export Tariff Numbers with the highest associated total Shipment Value on all shipments for the current calendar year compared to the associated total Shipment Value on all shipments filed for the previous calendar year. ';
DECLARE @CurrentCreatedBy33 AS VARCHAR(50) = 'jmerwin';
DECLARE @CurrentApprovedBy33 AS VARCHAR(50) = 'jmerwin';

DECLARE @CurrentSQLScript33 AS NVARCHAR(MAX) = 'SELECT h.PartnerID  ,d.ExportTariffNum  ,datepart(year, ExportDate) AS ExportYear  ,CAST(SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 2)) AS EstBaseTotalLineValue INTO #CurrentYear from txdgvexportheader h WITH (NOLOCK) join txdgvExportdetail d WITH (NOLOCK)  ON h.exportguid = d.exportguid  AND h.partnerid = d.partnerid WHERE 1=1 AND @EXPORTDATERANGE AND h.PartnerID = @PartnerID AND datepart(year, ExportDate) = DATEPART(year, GetDate()) GROUP BY h.PartnerID  ,d.ExportTariffNum  ,datepart(year, ExportDate)  SELECT h.PartnerID  ,d.ExportTariffNum  ,datepart(year, ExportDate) AS ExportYear  ,CAST(SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 2)) AS EstBaseTotalLineValue INTO #LastYear from txdgvexportheader h WITH (NOLOCK) join txdgvexportdetail d WITH (NOLOCK)  ON h.exportguid = d.exportguid  AND h.partnerid = d.partnerid WHERE 1=1 AND datepart(year, ExportDate) = DATEPART(year, dateadd(year, - 1, GetDate())) and ExportDate <= (GETDATE()-365) GROUP BY h.PartnerID  ,d.ExportTariffNum  ,datepart(year, ExportDate)  SELECT TOP 10 h.ExportTariffNum  ,isnull(sum(h.EstBaseTotalLineValue), 0) AS [@CurrentYear]  ,isnull(sum(h2.EstBaseTotalLineValue), 0) AS [@LastYear] FROM #CurrentYear h LEFT JOIN #LastYear h2   ON h.ExportTariffNum = h2.ExportTariffNum  AND h.PartnerID = h2.PartnerID GROUP BY h.ExportTariffNum ORDER BY sum(h.EstBaseTotalLineValue) DESC';


--insert old records into hist
INSERT INTO dbo.tbgSQLCommandsHist
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
          KeepDuringRollback   )
        SELECT  PartnerID ,
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
        FROM    dbo.tbgSQLCommands WITH ( NOLOCK )
        WHERE   SQLGUID = @CurrentSQLGuid33
                AND Version = '20.4';

--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @CurrentSQLGuid33
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
          @CurrentSQLGuid33 , -- SQLGUID - uniqueidentifier
          @CurrentSQLScript33 , -- SQLCommand - varchar(max)
          @CurrentSQLDescription33 , -- Description - nvarchar(100)
          @CurrentSQLLongDescription33 , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @CurrentCreatedBy33 , -- CreatedBy - varchar(50)
          @CurrentApprovedBy33 , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@CurrentSQLScript33,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.4' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )


------------------------------------Value Shipped by ECN - YoY------------------------------------
DECLARE @CurrentSQLGuid34 AS VARCHAR(36) = 'C56377B7-EC70-4068-89B8-8641D8527509';
DECLARE @CurrentSQLDescription34 AS NVARCHAR(100) = 'Value Shipped by ECN - YoY';
DECLARE @CurrentSQLLongDescription34 AS NVARCHAR(MAX) = 'This comparison report shows the ECN Numbers with the highest associated total Shipment Value on all shipments for the current year to date compared to the associated Shipment Value on all shipments during the same period in the previous year. ';
DECLARE @CurrentCreatedBy34 AS VARCHAR(50) = 'jmerwin';
DECLARE @CurrentApprovedBy34 AS VARCHAR(50) = 'jmerwin';

DECLARE @CurrentSQLScript34 AS NVARCHAR(MAX) = 'SELECT h.PartnerID  ,d.ECNNum  ,datepart(year, ExportDate) AS ExportYear  ,CAST(SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 2)) AS EstBaseTotalLineValue INTO #CurrentYear from txdgvexportheader h WITH (NOLOCK) join txdgvExportdetail d WITH (NOLOCK)  ON h.exportguid = d.exportguid  AND h.partnerid = d.partnerid WHERE 1=1 AND @EXPORTDATERANGE AND h.PartnerID = @PartnerID AND datepart(year, ExportDate) = DATEPART(year, GetDate()) GROUP BY h.PartnerID  ,d.ECNNum  ,datepart(year, ExportDate)  SELECT h.PartnerID  ,d.ECNNum  ,datepart(year, ExportDate) AS ExportYear  ,CAST(SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 2)) AS EstBaseTotalLineValue INTO #LastYear from txdgvexportheader h WITH (NOLOCK) join txdgvexportdetail d WITH (NOLOCK)  ON h.exportguid = d.exportguid  AND h.partnerid = d.partnerid WHERE 1=1 AND datepart(year, ExportDate) = DATEPART(year, dateadd(year, - 1, GetDate())) and ExportDate <= (GETDATE()-365) GROUP BY h.PartnerID  ,d.ECNNum  ,datepart(year, ExportDate)  SELECT TOP 10 h.ECNNum  ,isnull(sum(h.EstBaseTotalLineValue), 0) AS [@CurrentYear]  ,isnull(sum(h2.EstBaseTotalLineValue), 0) AS [@LastYear] FROM #CurrentYear h LEFT JOIN #LastYear h2   ON h.ECNNum= h2.ECNNum  AND h.PartnerID = h2.PartnerID GROUP BY h.ECNNum ORDER BY sum(h.EstBaseTotalLineValue) DESC';


--insert old records into hist
INSERT INTO dbo.tbgSQLCommandsHist
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
          KeepDuringRollback   )
        SELECT  PartnerID ,
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
        FROM    dbo.tbgSQLCommands WITH ( NOLOCK )
        WHERE   SQLGUID = @CurrentSQLGuid34
                AND Version = '20.4';

--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @CurrentSQLGuid34
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
          @CurrentSQLGuid34 , -- SQLGUID - uniqueidentifier
          @CurrentSQLScript34 , -- SQLCommand - varchar(max)
          @CurrentSQLDescription34 , -- Description - nvarchar(100)
          @CurrentSQLLongDescription34 , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @CurrentCreatedBy34 , -- CreatedBy - varchar(50)
          @CurrentApprovedBy34 , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@CurrentSQLScript34,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.4' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )


------------------------------------Value Shipped by Business Division - YoY------------------------------------
DECLARE @CurrentSQLGuid35 AS VARCHAR(36) = 'E53CD3CC-0FCD-48A2-9246-704A6DBFBE36';
DECLARE @CurrentSQLDescription35 AS NVARCHAR(100) = 'Value Shipped by Business Division - YoY';
DECLARE @CurrentSQLLongDescription35 AS NVARCHAR(MAX) = 'This comparison report shows the Business Divisions with the highest associated total Shipment Value on all shipments for the current year to date compared to the associated Shipment Value on all shipments during the same period in the previous year. ';
DECLARE @CurrentCreatedBy35 AS VARCHAR(50) = 'jmerwin';
DECLARE @CurrentApprovedBy35 AS VARCHAR(50) = 'jmerwin';

DECLARE @CurrentSQLScript35 AS NVARCHAR(MAX) = 'SELECT h.PartnerID  ,d.BusinessUnit  ,datepart(year, ExportDate) AS ExportYear  ,CAST(SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 2)) AS EstBaseTotalLineValue INTO #CurrentYear from txdgvexportheader h WITH (NOLOCK) join txdgvExportdetail d WITH (NOLOCK)  ON h.exportguid = d.exportguid  AND h.partnerid = d.partnerid WHERE 1=1 AND @EXPORTDATERANGE AND h.PartnerID = @PartnerID AND datepart(year, ExportDate) = DATEPART(year, GetDate()) GROUP BY h.PartnerID  ,d.BusinessUnit  ,datepart(year, ExportDate)  SELECT h.PartnerID  ,d.BusinessUnit  ,datepart(year, ExportDate) AS ExportYear  ,CAST(SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 2)) AS EstBaseTotalLineValue INTO #LastYear from txdgvexportheader h WITH (NOLOCK) join txdgvexportdetail d WITH (NOLOCK)  ON h.exportguid = d.exportguid  AND h.partnerid = d.partnerid WHERE 1=1 AND datepart(year, ExportDate) = DATEPART(year, dateadd(year, - 1, GetDate())) and ExportDate <= (GETDATE()-365) GROUP BY h.PartnerID  ,d.BusinessUnit  ,datepart(year, ExportDate)  SELECT TOP 10 h.BusinessUnit  ,isnull(sum(h.EstBaseTotalLineValue), 0) AS [@CurrentYear]  ,isnull(sum(h2.EstBaseTotalLineValue), 0) AS [@LastYear] FROM #CurrentYear h LEFT JOIN #LastYear h2   ON h.BusinessUnit = h2.BusinessUnit  AND h.PartnerID = h2.PartnerID GROUP BY h.BusinessUnit ORDER BY sum(h.EstBaseTotalLineValue) DESC';


--insert old records into hist
INSERT INTO dbo.tbgSQLCommandsHist
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
          KeepDuringRollback   )
        SELECT  PartnerID ,
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
        FROM    dbo.tbgSQLCommands WITH ( NOLOCK )
        WHERE   SQLGUID = @CurrentSQLGuid35
                AND Version = '20.4';

--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @CurrentSQLGuid35
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
          @CurrentSQLGuid35 , -- SQLGUID - uniqueidentifier
          @CurrentSQLScript35 , -- SQLCommand - varchar(max)
          @CurrentSQLDescription35 , -- Description - nvarchar(100)
          @CurrentSQLLongDescription35 , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @CurrentCreatedBy35 , -- CreatedBy - varchar(50)
          @CurrentApprovedBy35 , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@CurrentSQLScript35,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.4' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )



SET IDENTITY_INSERT dbo.tbgSQLCommandsHist ON;
GO	

COMMIT TRANSACTION
SET XACT_ABORT OFF;

SET XACT_ABORT ON;
BEGIN TRANSACTION;

SET IDENTITY_INSERT dbo.tbgSQLCommandsHist OFF;
GO	

DECLARE @partner AS INT
SET @partner = 4000------------------------------------Business Units by Value - YoY------------------------------------
DECLARE @CurrentSQLGuid1 AS VARCHAR(36) = '1F05D1D6-F16A-4A61-B5A2-269278DF50F1';
DECLARE @CurrentSQLDescription1 AS NVARCHAR(100) = 'Business Units by Value - YoY';
DECLARE @CurrentSQLLongDescription1 AS NVARCHAR(MAX) = 'This comparison report shows the business units with the highest associated total line value on all declarations filed for the current year compared to the highest associated total line value on all declarations filed for the previous year.';
DECLARE @CurrentCreatedBy1 AS VARCHAR(50) = 'jmerwin';
DECLARE @CurrentApprovedBy1 AS VARCHAR(50) = 'jmerwin';

DECLARE @CurrentSQLScript1 AS NVARCHAR(MAX) = 'SELECT
	 h.PartnerID,
	 d.BusinessUnit,
	 datepart(year, ImportDate) AS ImportYear,
	 CAST(SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 2)) AS EstBaseTotalLineValue 
INTO #CurrentYear 
FROM txdgvimportheader h WITH (NOLOCK) 
JOIN txdgvimportdetail d WITH (NOLOCK)
	ON h.entryguid = d.entryguid
	AND h.partnerid = d.partnerid 
WHERE 1=1
	AND h.PartnerID = @PartnerID
	AND datepart(year, ImportDate) = DATEPART(year, GetDate()) 
GROUP BY
	h.PartnerID,
	d.BusinessUnit,
	datepart(year, ImportDate)

SELECT
	 h.PartnerID,
	 d.BusinessUnit,
	 datepart(year, ImportDate) AS ImportYear,
	 CAST(SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 2)) AS EstBaseTotalLineValue 
INTO #LastYear 
FROM txdgvimportheader h WITH (NOLOCK) 
JOIN txdgvimportdetail d WITH (NOLOCK) 
	ON h.entryguid = d.entryguid
	AND h.partnerid = d.partnerid 
WHERE 1=1 AND
	 datepart(year, ImportDate) = DATEPART(year, dateadd(year, - 1, GetDate()))
	 and ImportDate <= (GETDATE()-365) 
GROUP BY
	 h.PartnerID,
	 d.BusinessUnit,
	 datepart(year, ImportDate)

SELECT
	 TOP 10 h.BusinessUnit,
	 isnull(sum(h.EstBaseTotalLineValue), 0) AS [@CurrentYear],
	 isnull(sum(h2.EstBaseTotalLineValue), 0) AS [@LastYear] 
FROM #CurrentYear h
LEFT JOIN #LastYear h2
	ON h.BusinessUnit = h2.BusinessUnit
	AND h.PartnerID = h2.PartnerID
GROUP BY h.BusinessUnit 
ORDER BY sum(h.EstBaseTotalLineValue) DESC';


--insert old records into hist
INSERT INTO dbo.tbgSQLCommandsHist
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
          KeepDuringRollback   )
        SELECT  PartnerID ,
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
        FROM    dbo.tbgSQLCommands WITH ( NOLOCK )
        WHERE   SQLGUID = @CurrentSQLGuid1
                AND Version = '20.4';

--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @CurrentSQLGuid1
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
          @CurrentSQLGuid1 , -- SQLGUID - uniqueidentifier
          @CurrentSQLScript1 , -- SQLCommand - varchar(max)
          @CurrentSQLDescription1 , -- Description - nvarchar(100)
          @CurrentSQLLongDescription1 , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @CurrentCreatedBy1 , -- CreatedBy - varchar(50)
          @CurrentApprovedBy1 , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@CurrentSQLScript1,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.4' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )


------------------------------------Ports of Unlading by Value - YoY------------------------------------
DECLARE @CurrentSQLGuid2 AS VARCHAR(36) = '5B73E37D-E1AF-435D-9880-ACCDB0998E3B';
DECLARE @CurrentSQLDescription2 AS NVARCHAR(100) = 'Ports of Unlading by Value - YoY';
DECLARE @CurrentSQLLongDescription2 AS NVARCHAR(MAX) = 'This comparison report shows the ports of unlading with the highest associated total declaration value on all declarations filed for the current year compared to the highest associated total declaration value on all declarations filed for the previous year. ';
DECLARE @CurrentCreatedBy2 AS VARCHAR(50) = '17.1 SQL Updates';
DECLARE @CurrentApprovedBy2 AS VARCHAR(50) = 'jmerwin';

DECLARE @CurrentSQLScript2 AS NVARCHAR(MAX) = 'SELECT  d.PartnerID ,
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
WHERE 1=1 AND   DATEPART(YEAR, ImportDate) = DATEPART(YEAR,
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
ORDER BY SUM(y.EstBaseTotalDeclarationValue) DESC';


--insert old records into hist
INSERT INTO dbo.tbgSQLCommandsHist
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
          KeepDuringRollback   )
        SELECT  PartnerID ,
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
        FROM    dbo.tbgSQLCommands WITH ( NOLOCK )
        WHERE   SQLGUID = @CurrentSQLGuid2
                AND Version = '20.4';

--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @CurrentSQLGuid2
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
          @CurrentSQLGuid2 , -- SQLGUID - uniqueidentifier
          @CurrentSQLScript2 , -- SQLCommand - varchar(max)
          @CurrentSQLDescription2 , -- Description - nvarchar(100)
          @CurrentSQLLongDescription2 , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @CurrentCreatedBy2 , -- CreatedBy - varchar(50)
          @CurrentApprovedBy2 , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@CurrentSQLScript2,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.4' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )


------------------------------------Countries of Import by Fees - YoY------------------------------------
DECLARE @CurrentSQLGuid3 AS VARCHAR(36) = 'E18B382E-FCBA-4E11-9AC1-A81DD43B674B';
DECLARE @CurrentSQLDescription3 AS NVARCHAR(100) = 'Countries of Import by Fees - YoY';
DECLARE @CurrentSQLLongDescription3 AS NVARCHAR(MAX) = 'This comparison report shows the countries of import with the highest associated total fees paid on all declarations filed for the current year compared to the highest associated total fees paid on all declarations filed for the previous year.  ';
DECLARE @CurrentCreatedBy3 AS VARCHAR(50) = 'jmurillo';
DECLARE @CurrentApprovedBy3 AS VARCHAR(50) = '';

DECLARE @CurrentSQLScript3 AS NVARCHAR(MAX) = 'SELECT h.PartnerID  ,
  ImportCountry  ,datepart(year, ImportDate) AS ImportYear  ,
  CAST(SUM(d.EstBaseFees) AS NUMERIC(28, 2)) AS EstBaseTotalFees 
INTO #CurrentYear 
FROM txdGVImportHeader h WITH (NOLOCK)
JOIN txdGVImportDetail d WITH (NOLOCK)
  ON h.PartnerID = d.PartnerID AND h.EntryGuid = d.EntryGuid 
WHERE 1=1 AND h.PartnerID = @PartnerID  AND datepart(year, ImportDate) = DATEPART(year, GetDate()) 
GROUP BY h.PartnerID  ,ImportCountry  ,datepart(year, ImportDate)  

SELECT h.PartnerID  ,
  ImportCountry  ,
  datepart(year, ImportDate) AS ImportYear  ,
  CAST(SUM(d.EstBaseFees) AS NUMERIC(28, 2)) AS EstBaseTotalFees 
INTO #LastYear 
FROM txdGVImportHeader h WITH (NOLOCK)
JOIN txdGVImportDetail d WITH (NOLOCK)
  ON h.PartnerID = d.PartnerID AND h.EntryGuid = d.EntryGuid
WHERE 1=1 AND datepart(year, ImportDate) = DATEPART(year, dateadd(year, - 1, GetDate()))  AND ImportDate <= (GETDATE() - 365) 
GROUP BY h.PartnerID  ,ImportCountry  ,datepart(year, ImportDate)  

SELECT TOP 10 d.ImportCountry  ,isnull(sum(d.EstBaseTotalFees), 0) AS [@CurrentYear]  ,isnull(sum(d2.EstBaseTotalFees), 0) AS [@LastYear] 
FROM #CurrentYear d 
LEFT JOIN #LastYear d2 
  ON d.ImportCountry = d2.ImportCountry  AND d.PartnerID = d2.PartnerID 
GROUP BY d.ImportCountry 
ORDER BY sum(d.EstBaseTotalFees) DESC';


--insert old records into hist
INSERT INTO dbo.tbgSQLCommandsHist
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
          KeepDuringRollback   )
        SELECT  PartnerID ,
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
        FROM    dbo.tbgSQLCommands WITH ( NOLOCK )
        WHERE   SQLGUID = @CurrentSQLGuid3
                AND Version = '20.4';

--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @CurrentSQLGuid3
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
          @CurrentSQLGuid3 , -- SQLGUID - uniqueidentifier
          @CurrentSQLScript3 , -- SQLCommand - varchar(max)
          @CurrentSQLDescription3 , -- Description - nvarchar(100)
          @CurrentSQLLongDescription3 , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @CurrentCreatedBy3 , -- CreatedBy - varchar(50)
          @CurrentApprovedBy3 , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@CurrentSQLScript3,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.4' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )


------------------------------------Countries of Export by Fees - YoY------------------------------------
DECLARE @CurrentSQLGuid4 AS VARCHAR(36) = 'B61B8FE3-CA5F-4C63-8850-2A5C249B67B7';
DECLARE @CurrentSQLDescription4 AS NVARCHAR(100) = 'Countries of Export by Fees - YoY';
DECLARE @CurrentSQLLongDescription4 AS NVARCHAR(MAX) = 'This comparison report shows the countries of export with the highest associated total fees paid on all declarations filed for the current year compared to the highest associated total fees paid on all declarations filed for the previous year.  ';
DECLARE @CurrentCreatedBy4 AS VARCHAR(50) = 'jmurillo';
DECLARE @CurrentApprovedBy4 AS VARCHAR(50) = '';

DECLARE @CurrentSQLScript4 AS NVARCHAR(MAX) = 'SELECT h.PartnerID  ,
  d.ExportCountry  ,datepart(year, ImportDate) AS ImportYear  ,
  CAST(SUM(d.EstBaseFees) AS NUMERIC(28, 2)) AS EstBaseTotalFees 
INTO #CurrentYearEC 
FROM txdgvimportheader h WITH (NOLOCK) 
JOIN txdGVImportDetail d WITH (NOLOCK) 
  ON h.EntryGuid = d.EntryGuid  AND h.PartnerID = d.PartnerID 
WHERE 1=1 AND h.PartnerID = @PartnerID  AND datepart(year, ImportDate) = DATEPART(year, GetDate()) 
GROUP BY h.PartnerID  ,d.ExportCountry  ,datepart(year, ImportDate)  

SELECT h.PartnerID  ,
  d.ExportCountry  ,
  datepart(year, ImportDate) AS ImportYear  ,
  CAST(SUM(d.EstBaseFees) AS NUMERIC(28, 2)) AS EstBaseTotalFees 
INTO #LastYearEC 
FROM txdgvimportheader h WITH (NOLOCK) 
JOIN txdGVImportDetail d WITH (NOLOCK) 
  ON h.EntryGuid = d.EntryGuid  AND h.PartnerID = d.PartnerID 
WHERE 1=1 AND datepart(year, ImportDate) = DATEPART(year, dateadd(year, - 1, GetDate()))  AND ImportDate <= (GETDATE() - 365) 
GROUP BY h.PartnerID  ,d.ExportCountry  ,datepart(year, ImportDate)  

SELECT TOP 10 d.ExportCountry  ,
  isnull(sum(d.EstBaseTotalFees), 0) AS [@CurrentYear]  ,
  isnull(sum(d2.EstBaseTotalFees), 0) AS [@LastYear] 
FROM #CurrentYearEC d 
LEFT JOIN #LastYearEC d2 
  ON d.ExportCountry = d2.ExportCountry  AND d.PartnerID = d2.PartnerID 
GROUP BY d.ExportCountry 
ORDER BY sum(d.EstBaseTotalFees) DESC';


--insert old records into hist
INSERT INTO dbo.tbgSQLCommandsHist
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
          KeepDuringRollback   )
        SELECT  PartnerID ,
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
        FROM    dbo.tbgSQLCommands WITH ( NOLOCK )
        WHERE   SQLGUID = @CurrentSQLGuid4
                AND Version = '20.4';

--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @CurrentSQLGuid4
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
          @CurrentSQLGuid4 , -- SQLGUID - uniqueidentifier
          @CurrentSQLScript4 , -- SQLCommand - varchar(max)
          @CurrentSQLDescription4 , -- Description - nvarchar(100)
          @CurrentSQLLongDescription4 , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @CurrentCreatedBy4 , -- CreatedBy - varchar(50)
          @CurrentApprovedBy4 , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@CurrentSQLScript4,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.4' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )


------------------------------------ImporterID by Fees - YoY------------------------------------
DECLARE @CurrentSQLGuid5 AS VARCHAR(36) = 'B4C3BEFF-8F41-47C1-AF11-1CCFD5EBEFBE';
DECLARE @CurrentSQLDescription5 AS NVARCHAR(100) = 'ImporterID by Fees - YoY';
DECLARE @CurrentSQLLongDescription5 AS NVARCHAR(MAX) = 'This comparison report shows the importer IDs with the highest associated total fees paid on all declarations filed for the current year compared to the highest associated total fees paid on all declarations filed for the previous year.  ';
DECLARE @CurrentCreatedBy5 AS VARCHAR(50) = 'jmurillo';
DECLARE @CurrentApprovedBy5 AS VARCHAR(50) = '';

DECLARE @CurrentSQLScript5 AS NVARCHAR(MAX) = 'SELECT h.PartnerID  ,
  ImporterID  ,
  datepart(year, ImportDate) AS ImportYear  ,
  CAST(SUM(d.EstBaseFees) AS NUMERIC(28, 2)) AS EstBaseTotalFees 
INTO #CurrentYearID 
FROM txdGVImportHeader h WITH (NOLOCK)
JOIN txdGVImportDetail d WITH (NOLOCK)
  ON h.PartnerID = d.PartnerID AND h.EntryGuid = d.EntryGuid
WHERE 1=1 AND h.PartnerID = @PartnerID  AND datepart(year, ImportDate) = DATEPART(year, GetDate()) 
GROUP BY h.PartnerID  ,ImporterID  ,datepart(year, ImportDate)  

SELECT h.PartnerID  ,
  ImporterID  ,
  datepart(year, ImportDate) AS ImportYear  ,
  CAST(SUM(d.EstBaseFees) AS NUMERIC(28, 2)) AS EstBaseTotalFees 
INTO #LastYearID 
FROM txdGVImportHeader h WITH (NOLOCK)
JOIN txdGVImportDetail d WITH (NOLOCK)
  ON h.PartnerID = d.PartnerID AND h.EntryGuid = d.EntryGuid
WHERE 1=1 AND datepart(year, ImportDate) = DATEPART(year, dateadd(year, - 1, GetDate()))  AND ImportDate <= (GETDATE() - 365) 
GROUP BY h.PartnerID  ,ImporterID  ,datepart(year, ImportDate)  

SELECT TOP 10 d.ImporterID  ,
  isnull(sum(d.EstBaseTotalFees), 0) AS [@CurrentYear]  ,
  isnull(sum(d2.EstBaseTotalFees), 0) AS [@LastYear] 
FROM #CurrentYearID d 
LEFT JOIN #LastYearID d2 
  ON d.ImporterID = d2.ImporterID  AND d.PartnerID = d2.PartnerID 
GROUP BY d.ImporterID 
ORDER BY sum(d.EstBaseTotalFees) DESC';


--insert old records into hist
INSERT INTO dbo.tbgSQLCommandsHist
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
          KeepDuringRollback   )
        SELECT  PartnerID ,
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
        FROM    dbo.tbgSQLCommands WITH ( NOLOCK )
        WHERE   SQLGUID = @CurrentSQLGuid5
                AND Version = '20.4';

--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @CurrentSQLGuid5
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
          @CurrentSQLGuid5 , -- SQLGUID - uniqueidentifier
          @CurrentSQLScript5 , -- SQLCommand - varchar(max)
          @CurrentSQLDescription5 , -- Description - nvarchar(100)
          @CurrentSQLLongDescription5 , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @CurrentCreatedBy5 , -- CreatedBy - varchar(50)
          @CurrentApprovedBy5 , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@CurrentSQLScript5,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.4' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )


------------------------------------Brokers by Fees - YoY------------------------------------
DECLARE @CurrentSQLGuid6 AS VARCHAR(36) = 'F2C378BB-9229-4945-AFCB-E588F4C3E01E';
DECLARE @CurrentSQLDescription6 AS NVARCHAR(100) = 'Brokers by Fees - YoY';
DECLARE @CurrentSQLLongDescription6 AS NVARCHAR(MAX) = 'This comparison report shows the brokers with the highest associated total fees paid on all declarations filed for the current year compared to the highest associated total fees paid on all declarations filed for the previous year.';
DECLARE @CurrentCreatedBy6 AS VARCHAR(50) = 'jmurillo';
DECLARE @CurrentApprovedBy6 AS VARCHAR(50) = '';

DECLARE @CurrentSQLScript6 AS NVARCHAR(MAX) = 'SELECT h.PartnerID  ,
  BrokerName  ,
  datepart(year, ImportDate) AS ImportYear  ,
  CAST(SUM(d.EstBaseFees) AS NUMERIC(28, 2)) AS EstBaseTotalFees 
INTO #CurrentYear 
FROM txdGVImportHeader h WITH (NOLOCK)
JOIN txdGVImportDetail d WITH (NOLOCK)
  ON h.PartnerID = d.PartnerID AND h.EntryGuid = d.EntryGuid 
WHERE 1=1 AND h.PartnerID = @PartnerID  AND datepart(year, ImportDate) = DATEPART(year, GetDate()) 
GROUP BY h.PartnerID  ,BrokerName  ,datepart(year, ImportDate)  

SELECT h.PartnerID  ,
  BrokerName  ,
  datepart(year, ImportDate) AS ImportYear  ,CAST(SUM(d.EstBaseFees) AS NUMERIC(28, 2)) AS EstBaseTotalFees 
INTO #LastYear 
FROM txdGVImportHeader h WITH (NOLOCK)
JOIN txdGVImportDetail d WITH (NOLOCK)
  ON h.PartnerID = d.PartnerID AND h.EntryGuid = d.EntryGuid 
WHERE 1=1 AND datepart(year, ImportDate) = DATEPART(year, dateadd(year, - 1, GetDate()))  AND ImportDate <= (GETDATE() - 365) 
GROUP BY h.PartnerID  ,BrokerName  ,datepart(year, ImportDate)  

SELECT TOP 10 d.BrokerName  ,
  isnull(sum(d.EstBaseTotalFees), 0) AS [@CurrentYear]  ,
  isnull(sum(d2.EstBaseTotalFees), 0) AS [@LastYear] 
FROM #CurrentYear d
LEFT JOIN #LastYear d2 
  ON d.BrokerName = d2.BrokerName  AND d.PartnerID = d2.PartnerID 
GROUP BY d.BrokerName 
ORDER BY sum(d.EstBaseTotalFees) DESC';


--insert old records into hist
INSERT INTO dbo.tbgSQLCommandsHist
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
          KeepDuringRollback   )
        SELECT  PartnerID ,
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
        FROM    dbo.tbgSQLCommands WITH ( NOLOCK )
        WHERE   SQLGUID = @CurrentSQLGuid6
                AND Version = '20.4';

--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @CurrentSQLGuid6
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
          @CurrentSQLGuid6 , -- SQLGUID - uniqueidentifier
          @CurrentSQLScript6 , -- SQLCommand - varchar(max)
          @CurrentSQLDescription6 , -- Description - nvarchar(100)
          @CurrentSQLLongDescription6 , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @CurrentCreatedBy6 , -- CreatedBy - varchar(50)
          @CurrentApprovedBy6 , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@CurrentSQLScript6,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.4' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )


------------------------------------ImporterID by Value - YoY------------------------------------
DECLARE @CurrentSQLGuid7 AS VARCHAR(36) = '42ACDE85-5C3C-4CE1-A5C9-228987C08ECF';
DECLARE @CurrentSQLDescription7 AS NVARCHAR(100) = 'ImporterID by Value - YoY';
DECLARE @CurrentSQLLongDescription7 AS NVARCHAR(MAX) = 'This comparison report shows the Importer IDs with the highest associated total declaration value on all declarations filed for the current year compared to the highest associated total declaration value on all declarations filed for the previous year.';
DECLARE @CurrentCreatedBy7 AS VARCHAR(50) = 'jmurillo';
DECLARE @CurrentApprovedBy7 AS VARCHAR(50) = '';

DECLARE @CurrentSQLScript7 AS NVARCHAR(MAX) = 'SELECT h.PartnerID, 
  ImporterID, 
  datepart(year, ImportDate) as ImportYear, 
  CAST(SUM(d.EstBaseTotalLineValue) as Numeric(28,2)) as EstBaseTotalDeclarationValue 
INTO #CurrentYearID  
FROM txdGVImportHeader h WITH (NOLOCK)
JOIN txdGVImportDetail d WITH (NOLOCK)
  ON h.PartnerID = d.PartnerID AND h.EntryGuid = d.EntryGuid
WHERE 1=1 AND h.PartnerID = @PartnerID and  datepart(year, ImportDate) =  DATEPART(year, GetDate())  
group by h.PartnerID, ImporterID, datepart(year, ImportDate)  

select   h.PartnerID, 
  ImporterID, 
  datepart(year, ImportDate) as ImportYear, 
  CAST(SUM(d.EstBaseTotalLineValue) as Numeric(28,2)) as EstBaseTotalDeclarationValue 
INTO #LastYearID 
FROM txdGVImportHeader h WITH (NOLOCK)
JOIN txdGVImportDetail d WITH (NOLOCK)
  ON h.PartnerID = d.PartnerID AND h.EntryGuid = d.EntryGuid
WHERE 1=1 AND datepart(year, ImportDate) =  DATEPART(year, dateadd(year, -1, GetDate())) and ImportDate <= (GETDATE()-365) 
group by h.PartnerID, ImporterID, datepart(year, ImportDate)   

SELECT TOP 10   d.ImporterID,    
  isnull(sum(d.EstBaseTotalDeclarationValue), 0) as [@CurrentYear],  
  isnull(sum(d2.EstBaseTotalDeclarationValue), 0) as [@LastYear] 
FROM #CurrentYearID d 
left join #LastYearID d2 
  on   d.ImporterID = d2.ImporterID and d.PartnerID = d2.PartnerID 
Group By d.ImporterID 
ORDER BY sum(d.EstBaseTotalDeclarationValue) DESC';


--insert old records into hist
INSERT INTO dbo.tbgSQLCommandsHist
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
          KeepDuringRollback   )
        SELECT  PartnerID ,
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
        FROM    dbo.tbgSQLCommands WITH ( NOLOCK )
        WHERE   SQLGUID = @CurrentSQLGuid7
                AND Version = '20.4';

--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @CurrentSQLGuid7
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
          @CurrentSQLGuid7 , -- SQLGUID - uniqueidentifier
          @CurrentSQLScript7 , -- SQLCommand - varchar(max)
          @CurrentSQLDescription7 , -- Description - nvarchar(100)
          @CurrentSQLLongDescription7 , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @CurrentCreatedBy7 , -- CreatedBy - varchar(50)
          @CurrentApprovedBy7 , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@CurrentSQLScript7,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.4' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )


------------------------------------Importer by Import Value - YoY------------------------------------
DECLARE @CurrentSQLGuid8 AS VARCHAR(36) = '3617A554-5B1D-4F48-9339-5FC5710FC777';
DECLARE @CurrentSQLDescription8 AS NVARCHAR(100) = 'Importer by Import Value - YoY';
DECLARE @CurrentSQLLongDescription8 AS NVARCHAR(MAX) = 'This comparison report shows the Importers with the highest associated total declaration value on all declarations filed for the current year compared to the highest associated total declaration value on all declarations filed for the previous year.';
DECLARE @CurrentCreatedBy8 AS VARCHAR(50) = 'jmurillo';
DECLARE @CurrentApprovedBy8 AS VARCHAR(50) = '';

DECLARE @CurrentSQLScript8 AS NVARCHAR(MAX) = 'select   h.PartnerID, 
  ImporterName, 
  datepart(year, ImportDate) as ImportYear, 
  datepart(month, ImportDate) as ImportMonth, 
  CAST(SUM(d.EstBaseTotalLineValue) as Numeric(28,2)) as EstBaseTotalDeclarationValue 
INTO #CurrentYearID  
FROM txdGVImportHeader h WITH (NOLOCK)
JOIN txdGVImportDetail d WITH (NOLOCK)
  ON h.PartnerID = d.PartnerID AND h.EntryGuid = d.EntryGuid
WHERE 1=1 AND h.PartnerID = @PartnerID and  datepart(year, ImportDate) =  DATEPART(year, GetDate())  
group by h.PartnerID, ImporterName, datepart(year, ImportDate), datepart(month, ImportDate)  

select   h.PartnerID, 
  ImporterName, 
  datepart(year, ImportDate) as ImportYear, 
  datepart(month, ImportDate) as ImportMonth, 
  CAST(SUM(d.EstBaseTotalLineValue) as Numeric(28,2)) as EstBaseTotalDeclarationValue 
INTO #LastYearID 
FROM txdGVImportHeader h WITH (NOLOCK)
JOIN txdGVImportDetail d WITH (NOLOCK)
  ON h.PartnerID = d.PartnerID AND h.EntryGuid = d.EntryGuid
WHERE 1=1 AND   datepart(year, ImportDate) =  DATEPART(year, dateadd(year, -1, GetDate())) and ImportDate <= (GETDATE()-365) 
group by h.PartnerID, ImporterName, datepart(year, ImportDate), datepart(month, ImportDate)   

SELECT TOP 10   d.ImporterName,    
  isnull(sum(d.EstBaseTotalDeclarationValue), 0) as [@CurrentYear],  
  isnull(sum(d2.EstBaseTotalDeclarationValue), 0) as [@LastYear] 
FROM #CurrentYearID d 
left join #LastYearID d2 
  on   d.ImporterName= d2.ImporterName and  d.ImportMonth = d2.ImportMonth and  d.PartnerID = d2.PartnerID 
  Group By d.ImporterName 
  ORDER BY sum(d.EstBaseTotalDeclarationValue) DESC';


--insert old records into hist
INSERT INTO dbo.tbgSQLCommandsHist
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
          KeepDuringRollback   )
        SELECT  PartnerID ,
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
        FROM    dbo.tbgSQLCommands WITH ( NOLOCK )
        WHERE   SQLGUID = @CurrentSQLGuid8
                AND Version = '20.4';

--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @CurrentSQLGuid8
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
          @CurrentSQLGuid8 , -- SQLGUID - uniqueidentifier
          @CurrentSQLScript8 , -- SQLCommand - varchar(max)
          @CurrentSQLDescription8 , -- Description - nvarchar(100)
          @CurrentSQLLongDescription8 , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @CurrentCreatedBy8 , -- CreatedBy - varchar(50)
          @CurrentApprovedBy8 , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@CurrentSQLScript8,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.4' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )


------------------------------------Brokers by Value - YoY------------------------------------
DECLARE @CurrentSQLGuid9 AS VARCHAR(36) = '112F07D0-911C-4A5D-A6FA-39EEAC4F5597';
DECLARE @CurrentSQLDescription9 AS NVARCHAR(100) = 'Brokers by Value - YoY';
DECLARE @CurrentSQLLongDescription9 AS NVARCHAR(MAX) = 'This comparison report shows the brokers with the highest associated total declaration value on all declarations filed for the current year compared to the highest associated total declaration value on all declarations filed for the previous year. ';
DECLARE @CurrentCreatedBy9 AS VARCHAR(50) = 'jmurillo';
DECLARE @CurrentApprovedBy9 AS VARCHAR(50) = '';

DECLARE @CurrentSQLScript9 AS NVARCHAR(MAX) = 'select h.PartnerID, 
  h.BrokerName, 
  datepart(year, h.ImportDate) as ImportYear, 
  CAST(SUM(d.EstBaseTotalLineValue) as Numeric(28,2)) as EstBaseTotalDeclarationValue 
INTO #CurrentYear  
FROM txdGVImportHeader h WITH (NOLOCK)
JOIN txdGVImportDetail d WITH (NOLOCK)
  ON h.PartnerID = d.PartnerID AND h.EntryGuid = d.EntryGuid
WHERE 1=1 AND h.PartnerID = @PartnerID and datepart(year, h.ImportDate) =  DATEPART(year, GetDate())  
group by h.PartnerID, h.BrokerName, datepart(year, h.ImportDate)  

select h.PartnerID, 
  h.BrokerName, 
  datepart(year, h.ImportDate) as ImportYear, 
  CAST(SUM(d.EstBaseTotalLineValue) as Numeric(28,2)) as EstBaseTotalDeclarationValue 
INTO #LastYear  
FROM txdGVImportHeader h WITH (NOLOCK)
JOIN txdGVImportDetail d WITH (NOLOCK)
  ON h.PartnerID = d.PartnerID AND h.EntryGuid = d.EntryGuid
WHERE 1=1 AND        datepart(year, h.ImportDate) =  DATEPART(year, dateadd(year, -1, GetDate())) 
  and ImportDate <= (GETDATE()-365) 
group by h.PartnerID, h.BrokerName, datepart(year, h.ImportDate)   

SELECT TOP 10 d.BrokerName,         
  isnull(sum(d.EstBaseTotalDeclarationValue), 0) as [@CurrentYear],       
  isnull(sum(d2.EstBaseTotalDeclarationValue), 0) as [@LastYear] 
FROM #CurrentYear d 
left join #LastYear d2 
  on d.BrokerName = d2.BrokerName and d.PartnerID = d2.PartnerID 
Group By d.BrokerName 
ORDER BY sum(d.EstBaseTotalDeclarationValue) DESC';


--insert old records into hist
INSERT INTO dbo.tbgSQLCommandsHist
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
          KeepDuringRollback   )
        SELECT  PartnerID ,
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
        FROM    dbo.tbgSQLCommands WITH ( NOLOCK )
        WHERE   SQLGUID = @CurrentSQLGuid9
                AND Version = '20.4';

--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @CurrentSQLGuid9
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
          @CurrentSQLGuid9 , -- SQLGUID - uniqueidentifier
          @CurrentSQLScript9 , -- SQLCommand - varchar(max)
          @CurrentSQLDescription9 , -- Description - nvarchar(100)
          @CurrentSQLLongDescription9 , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @CurrentCreatedBy9 , -- CreatedBy - varchar(50)
          @CurrentApprovedBy9 , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@CurrentSQLScript9,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.4' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )


------------------------------------ImporterID by Duty - YoY------------------------------------
DECLARE @CurrentSQLGuid10 AS VARCHAR(36) = '5E8B3FA5-4A24-4453-AFBC-BC2E83FD27B1';
DECLARE @CurrentSQLDescription10 AS NVARCHAR(100) = 'ImporterID by Duty - YoY';
DECLARE @CurrentSQLLongDescription10 AS NVARCHAR(MAX) = 'This comparison report shows the importer IDs with the highest associated total duty paid on all declarations filed for the current year compared to the highest associated total duty paid on all declarations filed for the previous year.';
DECLARE @CurrentCreatedBy10 AS VARCHAR(50) = 'jmurillo';
DECLARE @CurrentApprovedBy10 AS VARCHAR(50) = '';

DECLARE @CurrentSQLScript10 AS NVARCHAR(MAX) = 'SELECT h.PartnerID  ,
	ImporterID  ,
	datepart(year, ImportDate) AS ImportYear  ,
	CAST(SUM(d.EstBaseTotalLineDuty) AS NUMERIC(28, 2)) AS EstBaseTotalDeclarationDuty 
INTO #CurrentYearID 
FROM txdgvimportheader h WITH (NOLOCK)
JOIN txdgvimportdetail d WITH (NOLOCK)  
ON h.partnerid = d.partnerid AND h.entryguid = d.entryguid 
WHERE 1=1 AND h.PartnerID = @PartnerID  
AND datepart(year, ImportDate) = DATEPART(year, GetDate()) 
GROUP BY h.PartnerID  ,h.ImporterID  ,datepart(year, ImportDate)  

SELECT h.PartnerID  ,
	ImporterID  ,datepart(year, ImportDate) AS ImportYear  ,
	CAST(SUM(d.EstBaseTotalLineDuty) AS NUMERIC(28, 2)) AS EstBaseTotalDeclarationDuty 
INTO #LastYearID 
FROM txdGVImportHeader h WITH (NOLOCK)
JOIN txdgvimportdetail d WITH (NOLOCK)  
ON h.partnerid = d.partnerid AND h.entryguid = d.entryguid 
WHERE 1=1 AND datepart(year, ImportDate) = DATEPART(year, dateadd(year, - 1, GetDate()))    and ImportDate <= (GETDATE()-365) 
GROUP BY h.PartnerID  ,h.ImporterID  ,datepart(year, ImportDate)  

SELECT TOP 10 d.ImporterID  ,
	isnull(sum(d.EstBaseTotalDeclarationDuty), 0) AS [@CurrentYear]  ,
	isnull(sum(d2.EstBaseTotalDeclarationDuty), 0) AS [@LastYear] 
FROM #CurrentYearID d 
LEFT JOIN #LastYearID d2   
ON d.PartnerID = d2.PartnerID AND d.ImporterID = d2.ImporterID
GROUP BY d.ImporterID 
ORDER BY sum(d.EstBaseTotalDeclarationDuty) DESC';


--insert old records into hist
INSERT INTO dbo.tbgSQLCommandsHist
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
          KeepDuringRollback   )
        SELECT  PartnerID ,
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
        FROM    dbo.tbgSQLCommands WITH ( NOLOCK )
        WHERE   SQLGUID = @CurrentSQLGuid10
                AND Version = '20.4';

--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @CurrentSQLGuid10
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
          @CurrentSQLGuid10 , -- SQLGUID - uniqueidentifier
          @CurrentSQLScript10 , -- SQLCommand - varchar(max)
          @CurrentSQLDescription10 , -- Description - nvarchar(100)
          @CurrentSQLLongDescription10 , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @CurrentCreatedBy10 , -- CreatedBy - varchar(50)
          @CurrentApprovedBy10 , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@CurrentSQLScript10,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.4' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )


------------------------------------Top Ports of Unlading by Duty - YoY------------------------------------
DECLARE @CurrentSQLGuid11 AS VARCHAR(36) = '9FB2056C-BF01-418A-BE00-B2ECE29D2008';
DECLARE @CurrentSQLDescription11 AS NVARCHAR(100) = 'Top Ports of Unlading by Duty - YoY';
DECLARE @CurrentSQLLongDescription11 AS NVARCHAR(MAX) = 'This comparison report shows the ports of unlading with the highest associated total duty paid on all declarations filed for the current year compared to the highest associated total duty paid on all declarations filed for the previous year. ';
DECLARE @CurrentCreatedBy11 AS VARCHAR(50) = 'kduval';
DECLARE @CurrentApprovedBy11 AS VARCHAR(50) = '';

DECLARE @CurrentSQLScript11 AS NVARCHAR(MAX) = 'SELECT  d.PartnerID ,
        d.PortOfUnlading ,
        DATEPART(YEAR, h.ImportDate) AS ImportYear ,
        CAST(SUM(d.EstBaseTotalLineDuty) AS NUMERIC(28, 2)) AS EstBaseTotalDeclarationDuty
INTO    #CurrentYear
FROM    txdGVImportHeader h WITH ( NOLOCK )
        JOIN txdGVImportDetail d WITH ( NOLOCK ) ON h.EntryGuid = d.EntryGuid
                                                    AND h.PartnerID = d.PartnerID
WHERE 1=1 AND d.PartnerID = @PartnerID AND DATEPART(YEAR, h.ImportDate) = DATEPART(YEAR, GETDATE())
GROUP BY d.PartnerID ,
        d.PortOfUnlading ,
        DATEPART(YEAR, h.ImportDate)
SELECT  d.PartnerID ,
        d.PortOfUnlading ,
        DATEPART(YEAR, h.ImportDate) AS ImportYear ,
        CAST(SUM(d.EstBaseTotalLineDuty) AS NUMERIC(28, 2)) AS EstBaseTotalDeclarationDuty
INTO    #LastYear
FROM    txdGVImportHeader h
        JOIN txdGVImportDetail d WITH ( NOLOCK ) ON h.EntryGuid = d.EntryGuid
                                                    AND h.PartnerID = d.PartnerID
WHERE 1=1 AND   DATEPART(YEAR, h.ImportDate) = DATEPART(YEAR,
                                                DATEADD(YEAR, -1, GETDATE()))
        AND h.ImportDate <= ( GETDATE() - 365 )
GROUP BY d.PartnerID ,
        d.PortOfUnlading ,
        DATEPART(YEAR, h.ImportDate)
SELECT TOP 10
        y.PortOfUnlading ,
        ISNULL(SUM(y.EstBaseTotalDeclarationDuty), 0) AS [@CurrentYear] ,
        ISNULL(SUM(y2.EstBaseTotalDeclarationDuty), 0) AS [@LastYear]
FROM    #CurrentYear y
        LEFT JOIN #LastYear y2 ON y.PortOfUnlading = y2.PortOfUnlading
                                  AND y.PartnerID = y2.PartnerID
GROUP BY y.PortOfUnlading
ORDER BY SUM(y.EstBaseTotalDeclarationDuty) DESC';


--insert old records into hist
INSERT INTO dbo.tbgSQLCommandsHist
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
          KeepDuringRollback   )
        SELECT  PartnerID ,
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
        FROM    dbo.tbgSQLCommands WITH ( NOLOCK )
        WHERE   SQLGUID = @CurrentSQLGuid11
                AND Version = '20.4';

--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @CurrentSQLGuid11
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
          @CurrentSQLGuid11 , -- SQLGUID - uniqueidentifier
          @CurrentSQLScript11 , -- SQLCommand - varchar(max)
          @CurrentSQLDescription11 , -- Description - nvarchar(100)
          @CurrentSQLLongDescription11 , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @CurrentCreatedBy11 , -- CreatedBy - varchar(50)
          @CurrentApprovedBy11 , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@CurrentSQLScript11,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.4' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )


------------------------------------Countries of Import by Duty - YoY------------------------------------
DECLARE @CurrentSQLGuid12 AS VARCHAR(36) = '5A8E87F1-24EF-4DF4-9961-BB9DE1FC4507';
DECLARE @CurrentSQLDescription12 AS NVARCHAR(100) = 'Countries of Import by Duty - YoY';
DECLARE @CurrentSQLLongDescription12 AS NVARCHAR(MAX) = 'This comparison report shows the countries of import with the highest associated total duty paid on all declarations filed for the current year compared to the highest associated total duty paid on all declarations filed for the previous year. ';
DECLARE @CurrentCreatedBy12 AS VARCHAR(50) = 'kduval';
DECLARE @CurrentApprovedBy12 AS VARCHAR(50) = '';

DECLARE @CurrentSQLScript12 AS NVARCHAR(MAX) = 'SELECT  h.PartnerID ,
        ImportCountry ,
        DATEPART(YEAR, ImportDate) AS ImportYear ,
        CAST(SUM(d.EstBaseTotalLineDuty) AS NUMERIC(28, 2)) AS EstBaseTotalDeclarationDuty
INTO    #CurrentYear
FROM    txdGVImportHeader h WITH ( NOLOCK )
JOIN dbo.txdGVImportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.EntryGuid = h.EntryGuid
WHERE 1=1 AND h.PartnerID = @PartnerID AND DATEPART(YEAR, ImportDate) = DATEPART(YEAR, GETDATE())
GROUP BY h.PartnerID ,
        ImportCountry ,
        DATEPART(YEAR, ImportDate)
SELECT  h.PartnerID ,
        ImportCountry ,
        DATEPART(YEAR, ImportDate) AS ImportYear ,
        CAST(SUM(d.EstBaseTotalLineDuty) AS NUMERIC(28, 2)) AS EstBaseTotalDeclarationDuty
INTO    #LastYear
FROM    txdGVImportHeader h WITH (NOLOCK)
JOIN dbo.txdGVImportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.EntryGuid = h.EntryGuid
WHERE 1=1 AND   DATEPART(YEAR, ImportDate) = DATEPART(YEAR,
                                              DATEADD(YEAR, -1, GETDATE()))
        AND ImportDate <= ( GETDATE() - 365 )
GROUP BY h.PartnerID ,
        ImportCountry ,
        DATEPART(YEAR, ImportDate)
SELECT TOP 10
        y.ImportCountry ,
        ISNULL(SUM(y.EstBaseTotalDeclarationDuty), 0) AS [@CurrentYear] ,
        ISNULL(SUM(y2.EstBaseTotalDeclarationDuty), 0) AS [@LastYear]
FROM    #CurrentYear y
        LEFT JOIN #LastYear y2 ON y.ImportCountry = y2.ImportCountry
                                  AND y.PartnerID = y2.PartnerID
GROUP BY y.ImportCountry
ORDER BY SUM(y.EstBaseTotalDeclarationDuty) DESC';


--insert old records into hist
INSERT INTO dbo.tbgSQLCommandsHist
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
          KeepDuringRollback   )
        SELECT  PartnerID ,
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
        FROM    dbo.tbgSQLCommands WITH ( NOLOCK )
        WHERE   SQLGUID = @CurrentSQLGuid12
                AND Version = '20.4';

--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @CurrentSQLGuid12
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
          @CurrentSQLGuid12 , -- SQLGUID - uniqueidentifier
          @CurrentSQLScript12 , -- SQLCommand - varchar(max)
          @CurrentSQLDescription12 , -- Description - nvarchar(100)
          @CurrentSQLLongDescription12 , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @CurrentCreatedBy12 , -- CreatedBy - varchar(50)
          @CurrentApprovedBy12 , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@CurrentSQLScript12,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.4' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )


------------------------------------Importers by Duty - YoY------------------------------------
DECLARE @CurrentSQLGuid13 AS VARCHAR(36) = '0ED40C23-1698-4603-A577-87939A99BAAD';
DECLARE @CurrentSQLDescription13 AS NVARCHAR(100) = 'Importers by Duty - YoY';
DECLARE @CurrentSQLLongDescription13 AS NVARCHAR(MAX) = 'This comparison report shows the importers with the highest associated total duty paid on all declarations filed for the current year compared to the highest associated total duty paid on all declarations filed for the previous year.';
DECLARE @CurrentCreatedBy13 AS VARCHAR(50) = 'kduval';
DECLARE @CurrentApprovedBy13 AS VARCHAR(50) = '';

DECLARE @CurrentSQLScript13 AS NVARCHAR(MAX) = 'SELECT  h.PartnerID ,
        ImporterName ,
        DATEPART(YEAR, ImportDate) AS ImportYear ,
        CAST(SUM(d.EstBaseTotalLineDuty) AS NUMERIC(28, 2)) AS EstBaseTotalDeclarationDuty
INTO    #CurrentYearID
FROM    txdGVImportHeader h WITH ( NOLOCK )
JOIN dbo.txdGVImportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.EntryGuid = h.EntryGuid
WHERE 1=1 AND h.PartnerID = @PartnerID AND DATEPART(YEAR, ImportDate) = DATEPART(YEAR, GETDATE())
GROUP BY h.PartnerID ,
        ImporterName ,
        DATEPART(YEAR, ImportDate)
SELECT  h.PartnerID ,
        ImporterName ,
        DATEPART(YEAR, ImportDate) AS ImportYear ,
        CAST(SUM(d.EstBaseTotalLineDuty) AS NUMERIC(28, 2)) AS EstBaseTotalDeclarationDuty
INTO    #LastYearID
FROM    txdGVImportHeader h WITH (NOLOCK)
JOIN dbo.txdGVImportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.EntryGuid = h.EntryGuid
WHERE 1=1 AND   DATEPART(YEAR, ImportDate) = DATEPART(YEAR,
                                              DATEADD(YEAR, -1, GETDATE()))
        AND ImportDate <= ( GETDATE() - 365 )
GROUP BY h.PartnerID ,
        ImporterName ,
        DATEPART(YEAR, ImportDate)
SELECT TOP 10
        y.ImporterName ,
        ISNULL(SUM(y.EstBaseTotalDeclarationDuty), 0) AS [@CurrentYear] ,
        ISNULL(SUM(y2.EstBaseTotalDeclarationDuty), 0) AS [@LastYear]
FROM    #CurrentYearID y
        LEFT JOIN #LastYearID y2 ON y.ImporterName = y2.ImporterName
                                    AND y.PartnerID = y2.PartnerID
GROUP BY y.ImporterName
ORDER BY SUM(y.EstBaseTotalDeclarationDuty) DESC  ';


--insert old records into hist
INSERT INTO dbo.tbgSQLCommandsHist
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
          KeepDuringRollback   )
        SELECT  PartnerID ,
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
        FROM    dbo.tbgSQLCommands WITH ( NOLOCK )
        WHERE   SQLGUID = @CurrentSQLGuid13
                AND Version = '20.4';

--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @CurrentSQLGuid13
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
          @CurrentSQLGuid13 , -- SQLGUID - uniqueidentifier
          @CurrentSQLScript13 , -- SQLCommand - varchar(max)
          @CurrentSQLDescription13 , -- Description - nvarchar(100)
          @CurrentSQLLongDescription13 , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @CurrentCreatedBy13 , -- CreatedBy - varchar(50)
          @CurrentApprovedBy13 , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@CurrentSQLScript13,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.4' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )


------------------------------------Brokers by Duty - YoY------------------------------------
DECLARE @CurrentSQLGuid14 AS VARCHAR(36) = 'E11A0EA1-406F-4E33-A5FD-569B203A840C';
DECLARE @CurrentSQLDescription14 AS NVARCHAR(100) = 'Brokers by Duty - YoY';
DECLARE @CurrentSQLLongDescription14 AS NVARCHAR(MAX) = 'This comparison report shows the brokers with the highest associated total duty paid on all declarations filed for the current year compared to the highest associated total duty paid on all declarations filed for the previous year. ';
DECLARE @CurrentCreatedBy14 AS VARCHAR(50) = 'kduval';
DECLARE @CurrentApprovedBy14 AS VARCHAR(50) = '';

DECLARE @CurrentSQLScript14 AS NVARCHAR(MAX) = 'SELECT  h.PartnerID ,
        BrokerName ,
        DATEPART(YEAR, ImportDate) AS ImportYear ,
        CAST(SUM(d.EstBaseTotalLineDuty) AS NUMERIC(28, 2)) AS EstBaseTotalDeclarationDuty
INTO    #CurrentYear
FROM    txdGVImportHeader h WITH ( NOLOCK )
JOIN dbo.txdGVImportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.EntryGuid = h.EntryGuid
WHERE 1=1 AND h.PartnerID = @PartnerID AND DATEPART(YEAR, ImportDate) = DATEPART(YEAR, GETDATE())
GROUP BY h.PartnerID ,
        BrokerName ,
        DATEPART(YEAR, ImportDate)
SELECT  h.PartnerID ,
        BrokerName ,
        DATEPART(YEAR, ImportDate) AS ImportYear ,
        CAST(SUM(d.EstBaseTotalLineDuty) AS NUMERIC(28, 2)) AS EstBaseTotalDeclarationDuty
INTO    #LastYear
FROM    txdGVImportHeader h WITH (NOLOCK)
JOIN dbo.txdGVImportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.EntryGuid = h.EntryGuid
WHERE 1=1 AND   DATEPART(YEAR, ImportDate) = DATEPART(YEAR,
                                              DATEADD(YEAR, -1, GETDATE()))
        AND ImportDate <= ( GETDATE() - 365 )
GROUP BY h.PartnerID ,
        BrokerName ,
        DATEPART(YEAR, ImportDate)
SELECT TOP 10
        y.BrokerName ,
        ISNULL(SUM(y.EstBaseTotalDeclarationDuty), 0) AS [@CurrentYear] ,
        ISNULL(SUM(y2.EstBaseTotalDeclarationDuty), 0) AS [@LastYear]
FROM    #CurrentYear y
        LEFT JOIN #LastYear y2 ON y.BrokerName = y2.BrokerName
                                  AND y.PartnerID = y2.PartnerID
GROUP BY y.BrokerName
ORDER BY SUM(y.EstBaseTotalDeclarationDuty) DESC';


--insert old records into hist
INSERT INTO dbo.tbgSQLCommandsHist
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
          KeepDuringRollback   )
        SELECT  PartnerID ,
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
        FROM    dbo.tbgSQLCommands WITH ( NOLOCK )
        WHERE   SQLGUID = @CurrentSQLGuid14
                AND Version = '20.4';

--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @CurrentSQLGuid14
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
          @CurrentSQLGuid14 , -- SQLGUID - uniqueidentifier
          @CurrentSQLScript14 , -- SQLCommand - varchar(max)
          @CurrentSQLDescription14 , -- Description - nvarchar(100)
          @CurrentSQLLongDescription14 , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @CurrentCreatedBy14 , -- CreatedBy - varchar(50)
          @CurrentApprovedBy14 , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@CurrentSQLScript14,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.4' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )


------------------------------------Total Import Value YTD - YoY------------------------------------
DECLARE @CurrentSQLGuid15 AS VARCHAR(36) = '4926C792-378E-46D3-96C3-22582E194E81';
DECLARE @CurrentSQLDescription15 AS NVARCHAR(100) = 'Total Import Value YTD - YoY';
DECLARE @CurrentSQLLongDescription15 AS NVARCHAR(MAX) = 'This comparison report shows the total value of imports year-to-date for the current year compared to the total value of imports year-to-date for the previous year.';
DECLARE @CurrentCreatedBy15 AS VARCHAR(50) = 'kduval';
DECLARE @CurrentApprovedBy15 AS VARCHAR(50) = '';

DECLARE @CurrentSQLScript15 AS NVARCHAR(MAX) = 'SELECT  h.PartnerID ,
        DATEPART(MONTH, MAX(h.ImportDate)) AS ImportMonth ,
        CAST(SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 2)) AS Value
INTO    #YTDTotalDeclarationValue
FROM    txdGVImportHeader h WITH ( NOLOCK )
JOIN dbo.txdGVImportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.EntryGuid = h.EntryGuid
WHERE 1=1 AND h.PartnerID = @PartnerID AND DATEPART(YEAR, h.ImportDate) = DATEPART(YEAR, GETDATE())
GROUP BY h.PartnerID ,
        YEAR(h.ImportDate) ,
        MONTH(h.ImportDate)
ORDER BY YEAR(h.ImportDate) ,
        MONTH(h.ImportDate)
SELECT  h.PartnerID ,
        DATEPART(MONTH, MAX(h.ImportDate)) AS ImportMonth ,
        CAST(SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 2)) AS Value
INTO    #YTDTotalDeclarationValue2
FROM    txdGVImportHeader h WITH ( NOLOCK )
JOIN dbo.txdGVImportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.EntryGuid = h.EntryGuid
WHERE 1=1 AND   DATEPART(YEAR, h.ImportDate) = DATEPART(YEAR,
                                                DATEADD(YEAR, -1, GETDATE()))
        AND ImportDate <= ( GETDATE() - 365 )
GROUP BY h.PartnerID ,
        YEAR(h.ImportDate) ,
        MONTH(h.ImportDate)
ORDER BY YEAR(h.ImportDate) ,
        MONTH(h.ImportDate)
SELECT  b.ImportMonth ,
        ISNULL(( SELECT SUM(a.Value)
                 FROM   #YTDTotalDeclarationValue a
                 WHERE  a.ImportMonth <= b.ImportMonth
                        AND a.PartnerID = b.PartnerID
               ), 0) AS [@CurrentYear] ,
        ISNULL(( SELECT SUM(c.Value)
                 FROM   #YTDTotalDeclarationValue2 c
                 WHERE  c.ImportMonth <= b.ImportMonth
                        AND c.PartnerID = b.PartnerID
               ), 0) AS [@LastYear]
FROM    #YTDTotalDeclarationValue b
WHERE b.PartnerID = @PartnerID';


--insert old records into hist
INSERT INTO dbo.tbgSQLCommandsHist
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
          KeepDuringRollback   )
        SELECT  PartnerID ,
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
        FROM    dbo.tbgSQLCommands WITH ( NOLOCK )
        WHERE   SQLGUID = @CurrentSQLGuid15
                AND Version = '20.4';

--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @CurrentSQLGuid15
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
          @CurrentSQLGuid15 , -- SQLGUID - uniqueidentifier
          @CurrentSQLScript15 , -- SQLCommand - varchar(max)
          @CurrentSQLDescription15 , -- Description - nvarchar(100)
          @CurrentSQLLongDescription15 , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @CurrentCreatedBy15 , -- CreatedBy - varchar(50)
          @CurrentApprovedBy15 , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@CurrentSQLScript15,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.4' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )


------------------------------------Total Import Value by Quarter - YoY------------------------------------
DECLARE @CurrentSQLGuid16 AS VARCHAR(36) = 'D945E167-A62A-4D1D-A5F9-1C73E1C21257';
DECLARE @CurrentSQLDescription16 AS NVARCHAR(100) = 'Total Import Value by Quarter - YoY';
DECLARE @CurrentSQLLongDescription16 AS NVARCHAR(MAX) = 'This comparison report shows the total value of imports by quarter for the current year compared to the total value of imports by quarter for the previous year.';
DECLARE @CurrentCreatedBy16 AS VARCHAR(50) = 'kduval';
DECLARE @CurrentApprovedBy16 AS VARCHAR(50) = '';

DECLARE @CurrentSQLScript16 AS NVARCHAR(MAX) = 'SELECT  h.PartnerID ,
        DATEPART(YEAR, ImportDate) AS ImportYear ,
        ''Q'' + DATENAME(QUARTER, ImportDate) AS ImportQuarter ,
        CAST(SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 2)) AS EstBaseTotalDeclarationValue
INTO    #CurrentYear
FROM    txdGVImportHeader h WITH ( NOLOCK )
JOIN dbo.txdGVImportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.EntryGuid = h.EntryGuid
WHERE 1=1 AND h.PartnerID = @PartnerID AND DATEPART(YEAR, ImportDate) = DATEPART(YEAR, GETDATE())
GROUP BY h.PartnerID ,
        DATEPART(YEAR, ImportDate) ,
        DATENAME(QUARTER, ImportDate)
SELECT  h.PartnerID ,
        DATEPART(YEAR, ImportDate) AS ImportYear ,
        ''Q'' + DATENAME(QUARTER, ImportDate) AS ImportQuarter ,
        CAST(SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 2)) AS EstBaseTotalDeclarationValue
INTO    #LastYear
FROM    txdGVImportHeader h WITH ( NOLOCK )
JOIN dbo.txdGVImportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.EntryGuid = h.EntryGuid
WHERE 1=1 AND   DATEPART(YEAR, ImportDate) = DATEPART(YEAR,
                                              DATEADD(YEAR, -1, GETDATE()))
        AND ImportDate <= ( GETDATE() - 365 )
GROUP BY h.PartnerID ,
        DATEPART(YEAR, ImportDate) ,
        DATENAME(QUARTER, ImportDate)
SELECT TOP 10
        y.ImportQuarter ,
        ISNULL(y.EstBaseTotalDeclarationValue, 0) AS [@CurrentYear] ,
        ISNULL(y2.EstBaseTotalDeclarationValue, 0) AS [@LastYear]
FROM    #CurrentYear y
        LEFT JOIN #LastYear y2 ON y.ImportQuarter = y2.ImportQuarter
                                  AND y.PartnerID = y2.PartnerID
ORDER BY y.EstBaseTotalDeclarationValue DESC';


--insert old records into hist
INSERT INTO dbo.tbgSQLCommandsHist
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
          KeepDuringRollback   )
        SELECT  PartnerID ,
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
        FROM    dbo.tbgSQLCommands WITH ( NOLOCK )
        WHERE   SQLGUID = @CurrentSQLGuid16
                AND Version = '20.4';

--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @CurrentSQLGuid16
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
          @CurrentSQLGuid16 , -- SQLGUID - uniqueidentifier
          @CurrentSQLScript16 , -- SQLCommand - varchar(max)
          @CurrentSQLDescription16 , -- Description - nvarchar(100)
          @CurrentSQLLongDescription16 , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @CurrentCreatedBy16 , -- CreatedBy - varchar(50)
          @CurrentApprovedBy16 , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@CurrentSQLScript16,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.4' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )


------------------------------------Total Import Value by Month - YoY------------------------------------
DECLARE @CurrentSQLGuid17 AS VARCHAR(36) = 'DBC077C8-A9EB-42FE-AE43-8AD08BA451E8';
DECLARE @CurrentSQLDescription17 AS NVARCHAR(100) = 'Total Import Value by Month - YoY';
DECLARE @CurrentSQLLongDescription17 AS NVARCHAR(MAX) = 'This comparison report shows the total value of imports by month for the current year compared to the total value of imports by month for the previous year.';
DECLARE @CurrentCreatedBy17 AS VARCHAR(50) = 'kduval';
DECLARE @CurrentApprovedBy17 AS VARCHAR(50) = '';

DECLARE @CurrentSQLScript17 AS NVARCHAR(MAX) = 'SELECT  h.PartnerID ,
        DATEPART(YEAR, ImportDate) AS ImportYear ,
        DATEPART(MONTH, ImportDate) AS ImportMonth ,
        CAST(SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 2)) AS EstBaseTotalDeclarationValue
INTO    #CurrentYear
FROM    txdGVImportHeader h WITH ( NOLOCK )
JOIN dbo.txdGVImportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.EntryGuid = h.EntryGuid
WHERE 1=1 AND h.PartnerID = @PartnerID AND DATEPART(YEAR, ImportDate) = DATEPART(YEAR, GETDATE())
GROUP BY h.PartnerID ,
        DATEPART(YEAR, ImportDate) ,
        DATEPART(MONTH, ImportDate)
SELECT  h.PartnerID ,
        DATEPART(YEAR, ImportDate) AS ImportYear ,
        DATEPART(MONTH, ImportDate) AS ImportMonth ,
        CAST(SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 2)) AS EstBaseTotalDeclarationValue
INTO    #LastYear
FROM    txdGVImportHeader h WITH ( NOLOCK )
JOIN dbo.txdGVImportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.EntryGuid = h.EntryGuid
WHERE 1=1 AND   DATEPART(YEAR, ImportDate) = DATEPART(YEAR,
                                              DATEADD(YEAR, -1, GETDATE()))
        AND ImportDate <= ( GETDATE() - 365 )
GROUP BY h.PartnerID ,
        DATEPART(YEAR, ImportDate) ,
        DATEPART(MONTH, ImportDate)
SELECT TOP 10
        y.ImportMonth ,
        ISNULL(SUM(y.EstBaseTotalDeclarationValue), 0) AS [@CurrentYear] ,
        ISNULL(SUM(y2.EstBaseTotalDeclarationValue), 0) AS [@LastYear]
FROM    #CurrentYear y
        LEFT JOIN #LastYear y2 ON y.ImportMonth = y2.ImportMonth
                                  AND y.PartnerID = y2.PartnerID
GROUP BY y.ImportMonth
ORDER BY y.ImportMonth ASC';


--insert old records into hist
INSERT INTO dbo.tbgSQLCommandsHist
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
          KeepDuringRollback   )
        SELECT  PartnerID ,
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
        FROM    dbo.tbgSQLCommands WITH ( NOLOCK )
        WHERE   SQLGUID = @CurrentSQLGuid17
                AND Version = '20.4';

--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @CurrentSQLGuid17
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
          @CurrentSQLGuid17 , -- SQLGUID - uniqueidentifier
          @CurrentSQLScript17 , -- SQLCommand - varchar(max)
          @CurrentSQLDescription17 , -- Description - nvarchar(100)
          @CurrentSQLLongDescription17 , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @CurrentCreatedBy17 , -- CreatedBy - varchar(50)
          @CurrentApprovedBy17 , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@CurrentSQLScript17,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.4' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )


------------------------------------Total Declaration Duty By Month - YoY------------------------------------
DECLARE @CurrentSQLGuid18 AS VARCHAR(36) = 'EE24F97D-B7CC-4C5B-AD98-FF3B7C1C427D';
DECLARE @CurrentSQLDescription18 AS NVARCHAR(100) = 'Total Declaration Duty By Month - YoY';
DECLARE @CurrentSQLLongDescription18 AS NVARCHAR(MAX) = 'This comparison report shows the total declaration duty paid by month for the current year compared to the total declaration duty paid by month for the previous year.';
DECLARE @CurrentCreatedBy18 AS VARCHAR(50) = 'kduval';
DECLARE @CurrentApprovedBy18 AS VARCHAR(50) = '';

DECLARE @CurrentSQLScript18 AS NVARCHAR(MAX) = 'SELECT  h.PartnerID ,
        DATEPART(YEAR, ImportDate) AS ImportYear ,
        DATEPART(MONTH, ImportDate) AS ImportMonth ,
        CAST(SUM(d.EstBaseTotalLineDuty) AS NUMERIC(28, 2)) AS TotalDeclarationDuty
INTO    #CurrentYear
FROM    txdGVImportHeader h WITH ( NOLOCK )
JOIN dbo.txdGVImportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.EntryGuid = h.EntryGuid
WHERE 1=1 AND h.PartnerID = @PartnerID AND DATEPART(YEAR, ImportDate) = DATEPART(YEAR, GETDATE())
GROUP BY h.PartnerID ,
        DATEPART(YEAR, ImportDate) ,
        DATEPART(MONTH, ImportDate)
SELECT  h.PartnerID ,
        DATEPART(YEAR, ImportDate) AS ImportYear ,
        DATEPART(MONTH, ImportDate) AS ImportMonth ,
        CAST(SUM(d.EstBaseTotalLineDuty) AS NUMERIC(28, 2)) AS TotalDeclarationDuty
INTO    #LastYear
FROM    txdGVImportHeader h WITH ( NOLOCK )
JOIN dbo.txdGVImportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.EntryGuid = h.EntryGuid
WHERE 1=1 AND   DATEPART(YEAR, ImportDate) = DATEPART(YEAR,
                                              DATEADD(YEAR, -1, GETDATE()))
        AND ImportDate <= ( GETDATE() - 365 )
GROUP BY h.PartnerID ,
        DATEPART(YEAR, ImportDate) ,
        DATEPART(MONTH, ImportDate)
SELECT TOP 10
        y.ImportMonth ,
        ISNULL(y.TotalDeclarationDuty, 0) AS [@CurrentYear] ,
        ISNULL(y2.TotalDeclarationDuty, 0) AS [@LastYear]
FROM    #CurrentYear y
        LEFT JOIN #LastYear y2 ON y.ImportMonth = y2.ImportMonth
                                  AND y.PartnerID = y2.PartnerID
ORDER BY y.ImportMonth ,
        y.TotalDeclarationDuty DESC';


--insert old records into hist
INSERT INTO dbo.tbgSQLCommandsHist
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
          KeepDuringRollback   )
        SELECT  PartnerID ,
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
        FROM    dbo.tbgSQLCommands WITH ( NOLOCK )
        WHERE   SQLGUID = @CurrentSQLGuid18
                AND Version = '20.4';

--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @CurrentSQLGuid18
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
          @CurrentSQLGuid18 , -- SQLGUID - uniqueidentifier
          @CurrentSQLScript18 , -- SQLCommand - varchar(max)
          @CurrentSQLDescription18 , -- Description - nvarchar(100)
          @CurrentSQLLongDescription18 , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @CurrentCreatedBy18 , -- CreatedBy - varchar(50)
          @CurrentApprovedBy18 , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@CurrentSQLScript18,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.4' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )


------------------------------------Total Declaration Duty By Quarter - YoY------------------------------------
DECLARE @CurrentSQLGuid19 AS VARCHAR(36) = 'A96C2F66-FD2C-4085-BFD9-088A8ECB8789';
DECLARE @CurrentSQLDescription19 AS NVARCHAR(100) = 'Total Declaration Duty By Quarter - YoY';
DECLARE @CurrentSQLLongDescription19 AS NVARCHAR(MAX) = 'This comparison report shows the total declaration duty paid by quarter for the current year compared to the total declaration duty paid by quarter for the previous year. ';
DECLARE @CurrentCreatedBy19 AS VARCHAR(50) = 'kduval';
DECLARE @CurrentApprovedBy19 AS VARCHAR(50) = '';

DECLARE @CurrentSQLScript19 AS NVARCHAR(MAX) = 'SELECT  h.PartnerID ,
        DATEPART(YEAR, ImportDate) AS ImportYear ,
        ''Q'' + DATENAME(QUARTER, ImportDate) AS ImportQuarter ,
        CAST(SUM(d.EstBaseTotalLineDuty) AS NUMERIC(28, 2)) AS TotalDeclarationDuty
INTO    #CurrentYear
FROM    txdGVImportHeader h WITH ( NOLOCK )
JOIN dbo.txdGVImportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.EntryGuid = h.EntryGuid
WHERE 1=1 AND h.PartnerID = @PartnerID AND DATEPART(YEAR, ImportDate) = DATEPART(YEAR, GETDATE())
GROUP BY h.PartnerID ,
        DATEPART(YEAR, ImportDate) ,
        DATENAME(QUARTER, ImportDate)
SELECT  h.PartnerID ,
        DATEPART(YEAR, ImportDate) AS ImportYear ,
        ''Q'' + DATENAME(QUARTER, ImportDate) AS ImportQuarter ,
        CAST(SUM(d.EstBaseTotalLineDuty) AS NUMERIC(28, 2)) AS TotalDeclarationDuty
INTO    #LastYear
FROM    txdGVImportHeader h WITH ( NOLOCK )
JOIN dbo.txdGVImportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.EntryGuid = h.EntryGuid
WHERE 1=1 AND   DATEPART(YEAR, ImportDate) = DATEPART(YEAR,
                                              DATEADD(YEAR, -1, GETDATE()))
        AND ImportDate <= ( GETDATE() - 365 )
GROUP BY h.PartnerID ,
        DATEPART(YEAR, ImportDate) ,
        DATENAME(QUARTER, ImportDate)
SELECT TOP 10
        y.ImportQuarter ,
        ISNULL(SUM(y.TotalDeclarationDuty), 0) AS [@CurrentYear] ,
        ISNULL(SUM(y2.TotalDeclarationDuty), 0) AS [@LastYear]
FROM    #CurrentYear y
        LEFT JOIN #LastYear y2 ON y.ImportQuarter = y2.ImportQuarter
                                  AND y.PartnerID = y2.PartnerID
GROUP BY y.ImportQuarter
ORDER BY y.ImportQuarter ,
        SUM(y.TotalDeclarationDuty) DESC';


--insert old records into hist
INSERT INTO dbo.tbgSQLCommandsHist
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
          KeepDuringRollback   )
        SELECT  PartnerID ,
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
        FROM    dbo.tbgSQLCommands WITH ( NOLOCK )
        WHERE   SQLGUID = @CurrentSQLGuid19
                AND Version = '20.4';

--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @CurrentSQLGuid19
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
          @CurrentSQLGuid19 , -- SQLGUID - uniqueidentifier
          @CurrentSQLScript19 , -- SQLCommand - varchar(max)
          @CurrentSQLDescription19 , -- Description - nvarchar(100)
          @CurrentSQLLongDescription19 , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @CurrentCreatedBy19 , -- CreatedBy - varchar(50)
          @CurrentApprovedBy19 , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@CurrentSQLScript19,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.4' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )


------------------------------------Total Declaration Duty YTD - YoY------------------------------------
DECLARE @CurrentSQLGuid20 AS VARCHAR(36) = 'A6F4A464-054E-4FE2-977C-7480DAC172E5';
DECLARE @CurrentSQLDescription20 AS NVARCHAR(100) = 'Total Declaration Duty YTD - YoY';
DECLARE @CurrentSQLLongDescription20 AS NVARCHAR(MAX) = 'This comparison report shows the total declaration duty paid year-to-date for the current year compared to the total declaration duty paid year-to-date for the previous year.';
DECLARE @CurrentCreatedBy20 AS VARCHAR(50) = 'kduval';
DECLARE @CurrentApprovedBy20 AS VARCHAR(50) = '';

DECLARE @CurrentSQLScript20 AS NVARCHAR(MAX) = 'SELECT  h.PartnerID ,
        DATEPART(MONTH, MAX(h.ImportDate)) AS ImportMonth ,
        CAST(SUM(d.EstBaseTotalLineDuty) AS NUMERIC(28, 2)) AS TotalDeclarationDuty
INTO    #YTDTotalDeclarationDuty
FROM    txdGVImportHeader h WITH ( NOLOCK )
JOIN dbo.txdGVImportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.EntryGuid = h.EntryGuid
WHERE 1=1 AND h.PartnerID = @PartnerID AND DATEPART(YEAR, h.ImportDate) = DATEPART(YEAR, GETDATE())
GROUP BY h.PartnerID ,
        YEAR(h.ImportDate) ,
        MONTH(h.ImportDate)
ORDER BY YEAR(h.ImportDate) ,
        MONTH(h.ImportDate)
SELECT  h.PartnerID ,
        DATEPART(MONTH, MAX(h.ImportDate)) AS ImportMonth ,
        CAST(SUM(d.EstBaseTotalLineDuty) AS NUMERIC(28, 2)) AS TotalDeclarationDuty
INTO    #YTDTotalDeclarationDuty2
FROM    txdGVImportHeader h WITH ( NOLOCK )
JOIN dbo.txdGVImportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.EntryGuid = h.EntryGuid
WHERE 1=1 AND   DATEPART(YEAR, h.ImportDate) = DATEPART(YEAR,
                                                DATEADD(YEAR, -1, GETDATE()))
        AND ImportDate <= ( GETDATE() - 365 )
GROUP BY h.PartnerID ,
        YEAR(h.ImportDate) ,
        MONTH(h.ImportDate)
ORDER BY YEAR(h.ImportDate) ,
        MONTH(h.ImportDate)
SELECT  b.ImportMonth ,
        ISNULL(( SELECT SUM(a.TotalDeclarationDuty)
                 FROM   #YTDTotalDeclarationDuty a
                 WHERE  a.ImportMonth <= b.ImportMonth
                        AND a.PartnerID = b.PartnerID
               ), 0) AS [@CurrentYear] ,
        ISNULL(( SELECT SUM(c.TotalDeclarationDuty)
                 FROM   #YTDTotalDeclarationDuty2 c
                 WHERE  c.ImportMonth <= b.ImportMonth
                        AND c.PartnerID = b.PartnerID
               ), 0) AS [@LastYear]
FROM    #YTDTotalDeclarationDuty b
WHERE b.PartnerID = @PartnerID';


--insert old records into hist
INSERT INTO dbo.tbgSQLCommandsHist
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
          KeepDuringRollback   )
        SELECT  PartnerID ,
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
        FROM    dbo.tbgSQLCommands WITH ( NOLOCK )
        WHERE   SQLGUID = @CurrentSQLGuid20
                AND Version = '20.4';

--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @CurrentSQLGuid20
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
          @CurrentSQLGuid20 , -- SQLGUID - uniqueidentifier
          @CurrentSQLScript20 , -- SQLCommand - varchar(max)
          @CurrentSQLDescription20 , -- Description - nvarchar(100)
          @CurrentSQLLongDescription20 , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @CurrentCreatedBy20 , -- CreatedBy - varchar(50)
          @CurrentApprovedBy20 , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@CurrentSQLScript20,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.4' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )


------------------------------------HS Numbers by Import Value - YoY------------------------------------
DECLARE @CurrentSQLGuid21 AS VARCHAR(36) = '24B1857F-0CCF-438B-8F3A-7EFC3449DCD3';
DECLARE @CurrentSQLDescription21 AS NVARCHAR(100) = 'HS Numbers by Import Value - YoY';
DECLARE @CurrentSQLLongDescription21 AS NVARCHAR(MAX) = 'This comparison report shows the HS Numbers with the highest associated total line value on all declarations filed for the current year compared to the highest associated total line value on all declarations filed for the previous year.';
DECLARE @CurrentCreatedBy21 AS VARCHAR(50) = '180FE977-33AD-41B4-BA11-C09C53553E60';
DECLARE @CurrentApprovedBy21 AS VARCHAR(50) = '';

DECLARE @CurrentSQLScript21 AS NVARCHAR(MAX) = 'SELECT h.PartnerID
	,d.HSNum
	,datepart(year, h.ImportDate) AS ImportYear
	,CAST(SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 2)) AS EstBaseTotalLineValue
INTO #CurrentYear
FROM txdgvimportheader h WITH (NOLOCK)
JOIN txdgvimportdetail d WITH (NOLOCK) ON h.EntryGuid = d.EntryGuid
	AND h.PartnerID = d.PartnerID
WHERE 1=1
	AND h.PartnerID = @PartnerID
	AND datepart(year, ImportDate) = DATEPART(year, GetDate())
GROUP BY h.PartnerID
	,d.HSNum
	,datepart(year, h.ImportDate)

SELECT h.PartnerID
	,d.HSNum
	,datepart(year, h.ImportDate) AS ImportYear
	,CAST(SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 2)) AS EstBaseTotalLineValue
INTO #LastYear
FROM txdgvimportheader h WITH (NOLOCK)
JOIN txdgvimportdetail d WITH (NOLOCK) ON h.EntryGuid = d.EntryGuid
	AND h.PartnerID = d.PartnerID
WHERE 1=1 AND datepart(year, ImportDate) = DATEPART(year, dateadd(year, - 1, GetDate()))
	AND ImportDate <= (GETDATE() - 365)
GROUP BY h.PartnerID
	,d.HSNum
	,datepart(year, h.ImportDate)

SELECT TOP 10 h.HSNum
	,isnull(sum(h.EstBaseTotalLineValue), 0) AS [@CurrentYear]
	,isnull(sum(h2.EstBaseTotalLineValue), 0) AS [@LastYear]
FROM #CurrentYear h
LEFT JOIN #LastYear h2 ON h.HSnum = h2.HSnum
	AND h.PartnerID = h2.PartnerID
GROUP BY h.HSnum
ORDER BY sum(h.EstBaseTotalLineValue) DESC';


--insert old records into hist
INSERT INTO dbo.tbgSQLCommandsHist
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
          KeepDuringRollback   )
        SELECT  PartnerID ,
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
        FROM    dbo.tbgSQLCommands WITH ( NOLOCK )
        WHERE   SQLGUID = @CurrentSQLGuid21
                AND Version = '20.4';

--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @CurrentSQLGuid21
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
          @CurrentSQLGuid21 , -- SQLGUID - uniqueidentifier
          @CurrentSQLScript21 , -- SQLCommand - varchar(max)
          @CurrentSQLDescription21 , -- Description - nvarchar(100)
          @CurrentSQLLongDescription21 , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @CurrentCreatedBy21 , -- CreatedBy - varchar(50)
          @CurrentApprovedBy21 , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@CurrentSQLScript21,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.4' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )


------------------------------------WCO HS Numbers by Import Value - YoY------------------------------------
DECLARE @CurrentSQLGuid22 AS VARCHAR(36) = '0CC2B6FF-D240-4B23-981D-520B36F476AB';
DECLARE @CurrentSQLDescription22 AS NVARCHAR(100) = 'WCO HS Numbers by Import Value - YoY';
DECLARE @CurrentSQLLongDescription22 AS NVARCHAR(MAX) = 'This comparison report shows the WCO HS Numbers with the highest associated total line value on all declarations filed for the current year compared to the highest associated total line value on all declarations filed for the previous year. ';
DECLARE @CurrentCreatedBy22 AS VARCHAR(50) = '60E0A9DC-833C-4018-9F3D-69F994233A51';
DECLARE @CurrentApprovedBy22 AS VARCHAR(50) = '';

DECLARE @CurrentSQLScript22 AS NVARCHAR(MAX) = 'SELECT h.PartnerID  ,d.WCOHSNum  ,datepart(year, ImportDate) AS ImportYear  ,CAST(SUM(EstBaseTotalLineValue) AS NUMERIC(28, 2)) AS EstBaseTotalLineValue INTO #CurrentYearEC FROM txdgvimportheader h WITH (NOLOCK) JOIN txdGVImportDetail d WITH (NOLOCK) ON h.EntryGuid = d.EntryGuid  AND h.PartnerID = d.PartnerID WHERE 1=1  AND h.PartnerID = @PartnerID  AND datepart(year, ImportDate) = DATEPART(year, GetDate()) GROUP BY h.PartnerID  ,d.WCOHSNum  ,datepart(year, ImportDate)  SELECT h.PartnerID  ,d.WCOHSNum  ,datepart(year, ImportDate) AS ImportYear  ,CAST(SUM(EstBaseTotalLineValue) AS NUMERIC(28, 2)) AS EstBaseTotalLineValue INTO #LastYearEC FROM txdgvimportheader h WITH (NOLOCK) JOIN txdGVImportDetail d WITH (NOLOCK) ON h.EntryGuid = d.EntryGuid  AND h.PartnerID = d.PartnerID WHERE 1=1 AND datepart(year, ImportDate) = DATEPART(year, dateadd(year, - 1, GetDate()))  AND ImportDate <= (GETDATE() - 365) GROUP BY h.PartnerID  ,d.WCOHSNum  ,datepart(year, ImportDate)  SELECT TOP 10 h.WCOHSNum  ,isnull(sum(h.EstBaseTotalLineValue), 0) AS [@CurrentYear]  ,isnull(sum(h2.EstBaseTotalLineValue), 0) AS [@LastYear] FROM #CurrentYearEC h LEFT JOIN #LastYearEC h2 ON h.WCOHSNum = h2.WCOHSNum  AND h.PartnerID = h2.PartnerID GROUP BY h.WCOHSNum ORDER BY sum(h.EstBaseTotalLineValue) DESC';


--insert old records into hist
INSERT INTO dbo.tbgSQLCommandsHist
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
          KeepDuringRollback   )
        SELECT  PartnerID ,
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
        FROM    dbo.tbgSQLCommands WITH ( NOLOCK )
        WHERE   SQLGUID = @CurrentSQLGuid22
                AND Version = '20.4';

--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @CurrentSQLGuid22
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
          @CurrentSQLGuid22 , -- SQLGUID - uniqueidentifier
          @CurrentSQLScript22 , -- SQLCommand - varchar(max)
          @CurrentSQLDescription22 , -- Description - nvarchar(100)
          @CurrentSQLLongDescription22 , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @CurrentCreatedBy22 , -- CreatedBy - varchar(50)
          @CurrentApprovedBy22 , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@CurrentSQLScript22,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.4' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )


------------------------------------Products by Fees - YoY------------------------------------
DECLARE @CurrentSQLGuid23 AS VARCHAR(36) = '9A740B32-E077-40C6-9167-6E1718FE4057';
DECLARE @CurrentSQLDescription23 AS NVARCHAR(100) = 'Products by Fees - YoY';
DECLARE @CurrentSQLLongDescription23 AS NVARCHAR(MAX) = 'This comparison report shows the products with the highest associated total fees paid on all declarations filed for the current year compared to the highest associated total fees paid on all declarations filed for the previous year.  ';
DECLARE @CurrentCreatedBy23 AS VARCHAR(50) = '60E0A9DC-833C-4018-9F3D-69F994233A51';
DECLARE @CurrentApprovedBy23 AS VARCHAR(50) = '';

DECLARE @CurrentSQLScript23 AS NVARCHAR(MAX) = 'SELECT h.PartnerID  ,d.ProductNum  ,datepart(year, ImportDate) AS ImportYear  ,CAST(SUM(d.EstBaseFees) AS NUMERIC(28, 2)) AS EstBaseTotalFees INTO #CurrentYear FROM txdgvimportheader h WITH (NOLOCK) JOIN txdgvimportdetail d WITH (NOLOCK) ON h.entryguid = d.entryguid  AND h.partnerid = d.partnerid WHERE 1=1  AND h.PartnerID = @PartnerID  AND datepart(year, ImportDate) = DATEPART(year, GetDate()) GROUP BY h.PartnerID  ,d.ProductNum  ,datepart(year, ImportDate)  SELECT h.PartnerID  ,d.ProductNum  ,datepart(year, ImportDate) AS ImportYear  ,CAST(SUM(d.EstBaseFees) AS NUMERIC(28, 2)) AS EstBaseTotalFees INTO #LastYear FROM txdgvimportheader h WITH (NOLOCK) JOIN txdgvimportdetail d WITH (NOLOCK) ON h.entryguid = d.entryguid  AND h.partnerid = d.partnerid WHERE 1=1 AND datepart(year, ImportDate) = DATEPART(year, dateadd(year, - 1, GetDate()))  AND ImportDate <= (GETDATE() - 365) GROUP BY h.PartnerID  ,d.ProductNum  ,datepart(year, ImportDate)  SELECT TOP 10 h.ProductNum  ,isnull(sum(h.EstBaseTotalFees), 0) AS [@CurrentYear]  ,isnull(sum(h2.EstBaseTotalFees), 0) AS [@LastYear] FROM #CurrentYear h LEFT JOIN #LastYear h2 ON h.ProductNum = h2.ProductNum  AND h.PartnerID = h2.PartnerID GROUP BY h.ProductNum ORDER BY sum(h.EstBaseTotalFees) DESC';


--insert old records into hist
INSERT INTO dbo.tbgSQLCommandsHist
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
          KeepDuringRollback   )
        SELECT  PartnerID ,
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
        FROM    dbo.tbgSQLCommands WITH ( NOLOCK )
        WHERE   SQLGUID = @CurrentSQLGuid23
                AND Version = '20.4';

--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @CurrentSQLGuid23
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
          @CurrentSQLGuid23 , -- SQLGUID - uniqueidentifier
          @CurrentSQLScript23 , -- SQLCommand - varchar(max)
          @CurrentSQLDescription23 , -- Description - nvarchar(100)
          @CurrentSQLLongDescription23 , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @CurrentCreatedBy23 , -- CreatedBy - varchar(50)
          @CurrentApprovedBy23 , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@CurrentSQLScript23,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.4' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )


------------------------------------Ports of Unlading by Fees - YoY------------------------------------
DECLARE @CurrentSQLGuid24 AS VARCHAR(36) = 'A3890394-66FE-4B3C-ADDC-9C161F78150E';
DECLARE @CurrentSQLDescription24 AS NVARCHAR(100) = 'Ports of Unlading by Fees - YoY';
DECLARE @CurrentSQLLongDescription24 AS NVARCHAR(MAX) = 'This comparison report shows the ports of unlading with the highest associated total fees paid on all declarations filed for the current year compared to the highest associated total fees paid on all declarations filed for the previous year.  ';
DECLARE @CurrentCreatedBy24 AS VARCHAR(50) = '60E0A9DC-833C-4018-9F3D-69F994233A51';
DECLARE @CurrentApprovedBy24 AS VARCHAR(50) = '';

DECLARE @CurrentSQLScript24 AS NVARCHAR(MAX) = 'SELECT d.PartnerID  ,d.PortOfUnlading  ,datepart(year, h.ImportDate) AS ImportYear  ,CAST(SUM(d.EstBaseFees) AS NUMERIC(28, 2)) AS EstBaseTotalFees INTO #CurrentYear FROM txdgvimportheader h WITH (NOLOCK) JOIN txdgvimportdetail d WITH (NOLOCK) ON h.EntryGuid = d.EntryGuid  AND h.PartnerID = d.PartnerID WHERE 1=1  AND d.PartnerID = @PartnerID  AND datepart(year, h.ImportDate) = DATEPART(year, GetDate()) GROUP BY d.PartnerID  ,d.PortOfUnlading  ,datepart(year, h.ImportDate)  SELECT d.PartnerID  ,d.PortOfUnlading  ,datepart(year, h.ImportDate) AS ImportYear  ,CAST(SUM(d.EstBaseFees) AS NUMERIC(28, 2)) AS EstBaseTotalFees INTO #LastYear FROM txdGVImportHeader h JOIN txdgvimportdetail d WITH (NOLOCK) ON h.EntryGuid = d.EntryGuid  AND h.PartnerID = d.PartnerID WHERE 1=1 AND datepart(year, h.ImportDate) = DATEPART(year, dateadd(year, - 1, GetDate()))  AND h.ImportDate <= (GETDATE() - 365) GROUP BY d.PartnerID  ,d.PortOfUnlading  ,datepart(year, h.ImportDate)  SELECT TOP 10 h.PortOfUnlading  ,isnull(sum(h.EstBaseTotalFees), 0) AS [@CurrentYear]  ,isnull(sum(h2.EstBaseTotalFees), 0) AS [@LastYear] FROM #CurrentYear h LEFT JOIN #LastYear h2 ON h.PortOfUnlading = h2.PortOfUnlading  AND h.PartnerID = h2.PartnerID GROUP BY h.PortOfUnlading ORDER BY sum(h.EstBaseTotalFees) DESC';


--insert old records into hist
INSERT INTO dbo.tbgSQLCommandsHist
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
          KeepDuringRollback   )
        SELECT  PartnerID ,
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
        FROM    dbo.tbgSQLCommands WITH ( NOLOCK )
        WHERE   SQLGUID = @CurrentSQLGuid24
                AND Version = '20.4';

--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @CurrentSQLGuid24
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
          @CurrentSQLGuid24 , -- SQLGUID - uniqueidentifier
          @CurrentSQLScript24 , -- SQLCommand - varchar(max)
          @CurrentSQLDescription24 , -- Description - nvarchar(100)
          @CurrentSQLLongDescription24 , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @CurrentCreatedBy24 , -- CreatedBy - varchar(50)
          @CurrentApprovedBy24 , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@CurrentSQLScript24,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.4' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )


------------------------------------HS Numbers by Fees - YoY------------------------------------
DECLARE @CurrentSQLGuid25 AS VARCHAR(36) = 'DD072AE3-C185-4231-AEAA-BE3ACBE2845B';
DECLARE @CurrentSQLDescription25 AS NVARCHAR(100) = 'HS Numbers by Fees - YoY';
DECLARE @CurrentSQLLongDescription25 AS NVARCHAR(MAX) = 'This comparison report shows the HS numbers with the highest associated total fees paid on all declarations filed for the current year compared to the highest associated total fees paid on all declarations filed for the previous year. ';
DECLARE @CurrentCreatedBy25 AS VARCHAR(50) = '60E0A9DC-833C-4018-9F3D-69F994233A51';
DECLARE @CurrentApprovedBy25 AS VARCHAR(50) = '';

DECLARE @CurrentSQLScript25 AS NVARCHAR(MAX) = 'SELECT h.PartnerID  ,d.HsNum  ,datepart(year, ImportDate) AS ImportYear  ,CAST(SUM(d.EstBaseFees) AS NUMERIC(28, 2)) AS EstBaseTotalFees INTO #CurrentYear FROM txdgvimportheader h WITH (NOLOCK) JOIN txdgvimportdetail d WITH (NOLOCK) ON h.entryguid = d.entryguid  AND h.partnerid = d.partnerid WHERE 1=1  AND h.PartnerID = @PartnerID  AND datepart(year, ImportDate) = DATEPART(year, GetDate()) GROUP BY h.PartnerID  ,d.HsNum  ,datepart(year, ImportDate)  SELECT h.PartnerID  ,d.HsNum  ,datepart(year, ImportDate) AS ImportYear  ,CAST(SUM(d.EstBaseFees) AS NUMERIC(28, 2)) AS EstBaseTotalFees INTO #LastYear FROM txdgvimportheader h WITH (NOLOCK) JOIN txdgvimportdetail d WITH (NOLOCK) ON h.entryguid = d.entryguid  AND h.partnerid = d.partnerid WHERE 1=1 AND datepart(year, ImportDate) = DATEPART(year, dateadd(year, - 1, GetDate()))  AND ImportDate <= (GETDATE() - 365) GROUP BY h.PartnerID  ,d.HsNum  ,datepart(year, ImportDate)  SELECT TOP 10 h.HsNum  ,isnull(sum(h.EstBaseTotalFees), 0) AS [@CurrentYear]  ,isnull(sum(h2.EstBaseTotalFees), 0) AS [@LastYear] FROM #CurrentYear h LEFT JOIN #LastYear h2 ON h.HsNum = h2.HsNum  AND h.PartnerID = h2.PartnerID GROUP BY h.HsNum ORDER BY sum(h.EstBaseTotalFees) DESC';


--insert old records into hist
INSERT INTO dbo.tbgSQLCommandsHist
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
          KeepDuringRollback   )
        SELECT  PartnerID ,
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
        FROM    dbo.tbgSQLCommands WITH ( NOLOCK )
        WHERE   SQLGUID = @CurrentSQLGuid25
                AND Version = '20.4';

--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @CurrentSQLGuid25
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
          @CurrentSQLGuid25 , -- SQLGUID - uniqueidentifier
          @CurrentSQLScript25 , -- SQLCommand - varchar(max)
          @CurrentSQLDescription25 , -- Description - nvarchar(100)
          @CurrentSQLLongDescription25 , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @CurrentCreatedBy25 , -- CreatedBy - varchar(50)
          @CurrentApprovedBy25 , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@CurrentSQLScript25,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.4' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )


------------------------------------Business Units by Fees - YoY------------------------------------
DECLARE @CurrentSQLGuid26 AS VARCHAR(36) = '8DCD7E87-B8E7-4ADB-86F1-04C88E2A4AA3';
DECLARE @CurrentSQLDescription26 AS NVARCHAR(100) = 'Business Units by Fees - YoY';
DECLARE @CurrentSQLLongDescription26 AS NVARCHAR(MAX) = 'This comparison report shows the business units with the highest associated total fees paid on all declarations filed for the current year compared to the highest associated total fees paid on all declarations filed for the previous year.  ';
DECLARE @CurrentCreatedBy26 AS VARCHAR(50) = '60E0A9DC-833C-4018-9F3D-69F994233A51';
DECLARE @CurrentApprovedBy26 AS VARCHAR(50) = '';

DECLARE @CurrentSQLScript26 AS NVARCHAR(MAX) = 'SELECT h.PartnerID  ,d.BusinessUnit  ,datepart(year, ImportDate) AS ImportYear  ,CAST(SUM(d.EstBaseFees) AS NUMERIC(28, 2)) AS EstBaseTotalFees INTO #CurrentYear FROM txdgvimportheader h WITH (NOLOCK) JOIN txdgvimportdetail d WITH (NOLOCK) ON h.entryguid = d.entryguid  AND h.partnerid = d.partnerid WHERE 1=1  AND h.PartnerID = @PartnerID  AND datepart(year, ImportDate) = DATEPART(year, GetDate()) GROUP BY h.PartnerID  ,d.BusinessUnit  ,datepart(year, ImportDate)  SELECT h.PartnerID  ,d.BusinessUnit  ,datepart(year, ImportDate) AS ImportYear  ,CAST(SUM(d.EstBaseFees) AS NUMERIC(28, 2)) AS EstBaseTotalFees INTO #LastYear FROM txdgvimportheader h WITH (NOLOCK) JOIN txdgvimportdetail d WITH (NOLOCK) ON h.entryguid = d.entryguid  AND h.partnerid = d.partnerid WHERE 1=1 AND datepart(year, ImportDate) = DATEPART(year, dateadd(year, - 1, GetDate()))  AND ImportDate <= (GETDATE() - 365) GROUP BY h.PartnerID  ,d.BusinessUnit  ,datepart(year, ImportDate)  SELECT TOP 10 h.BusinessUnit  ,isnull(sum(h.EstBaseTotalFees), 0) AS [@CurrentYear]  ,isnull(sum(h2.EstBaseTotalFees), 0) AS [@LastYear] FROM #CurrentYear h LEFT JOIN #LastYear h2 ON h.BusinessUnit = h2.BusinessUnit  AND h.PartnerID = h2.PartnerID GROUP BY h.BusinessUnit ORDER BY sum(h.EstBaseTotalFees) DESC';


--insert old records into hist
INSERT INTO dbo.tbgSQLCommandsHist
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
          KeepDuringRollback   )
        SELECT  PartnerID ,
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
        FROM    dbo.tbgSQLCommands WITH ( NOLOCK )
        WHERE   SQLGUID = @CurrentSQLGuid26
                AND Version = '20.4';

--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @CurrentSQLGuid26
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
          @CurrentSQLGuid26 , -- SQLGUID - uniqueidentifier
          @CurrentSQLScript26 , -- SQLCommand - varchar(max)
          @CurrentSQLDescription26 , -- Description - nvarchar(100)
          @CurrentSQLLongDescription26 , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @CurrentCreatedBy26 , -- CreatedBy - varchar(50)
          @CurrentApprovedBy26 , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@CurrentSQLScript26,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.4' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )


------------------------------------Countries of Export by Duty - YoY------------------------------------
DECLARE @CurrentSQLGuid27 AS VARCHAR(36) = 'D78CA534-EAC8-4D4E-B70D-9AAACAD840FF';
DECLARE @CurrentSQLDescription27 AS NVARCHAR(100) = 'Countries of Export by Duty - YoY';
DECLARE @CurrentSQLLongDescription27 AS NVARCHAR(MAX) = 'This comparison report shows the countries of export with the highest associated total duty paid on all declarations filed for the current year compared to the highest associated total duty paid on all declarations filed for the previous year. ';
DECLARE @CurrentCreatedBy27 AS VARCHAR(50) = 'jmerwin';
DECLARE @CurrentApprovedBy27 AS VARCHAR(50) = 'jmerwin';

DECLARE @CurrentSQLScript27 AS NVARCHAR(MAX) = 'SELECT h.PartnerID  ,d.ExportCountry  ,datepart(year, ImportDate) AS ImportYear  ,CAST(SUM(EstBaseTotalLineDuty) AS NUMERIC(28, 2)) AS EstBaseTotalDeclarationDuty INTO #CurrentYearEC from txdgvimportheader h WITH (NOLOCK) JOIN txdGVImportDetail d WITH (NOLOCK) ON  h.EntryGuid = d.EntryGuid and  h.PartnerID = d.PartnerID WHERE 1=1 AND h.PartnerID = @PartnerID  AND datepart(year, ImportDate) = DATEPART(year, GetDate()) GROUP BY h.PartnerID  ,d.ExportCountry  ,datepart(year, ImportDate)  SELECT h.PartnerID   ,d.ExportCountry  ,datepart(year, ImportDate) AS ImportYear  ,CAST(SUM(EstBaseTotalLineDuty) AS NUMERIC(28, 2)) AS EstBaseTotalDeclarationDuty  INTO #LastYearEC from txdgvimportheader h WITH (NOLOCK) JOIN txdGVImportDetail d WITH (NOLOCK) ON  h.EntryGuid = d.EntryGuid and  h.PartnerID = d.PartnerID WHERE 1=1 AND datepart(year, ImportDate) = DATEPART(year, dateadd(year, - 1, GetDate()))    and ImportDate <= (GETDATE()-365) GROUP BY h.PartnerID  ,d.ExportCountry  ,datepart(year, ImportDate)  SELECT TOP 10 h.ExportCountry  ,isnull(sum(h.EstBaseTotalDeclarationDuty), 0) AS [@CurrentYear]  ,isnull(sum(h2.EstBaseTotalDeclarationDuty), 0) AS [@LastYear] FROM #CurrentYearEC h LEFT JOIN #LastYearEC h2   ON h.ExportCountry = h2.ExportCountry  AND h.PartnerID = h2.PartnerID GROUP BY h.ExportCountry ORDER BY sum(h.EstBaseTotalDeclarationDuty) DESC ';


--insert old records into hist
INSERT INTO dbo.tbgSQLCommandsHist
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
          KeepDuringRollback   )
        SELECT  PartnerID ,
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
        FROM    dbo.tbgSQLCommands WITH ( NOLOCK )
        WHERE   SQLGUID = @CurrentSQLGuid27
                AND Version = '20.4';

--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @CurrentSQLGuid27
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
          @CurrentSQLGuid27 , -- SQLGUID - uniqueidentifier
          @CurrentSQLScript27 , -- SQLCommand - varchar(max)
          @CurrentSQLDescription27 , -- Description - nvarchar(100)
          @CurrentSQLLongDescription27 , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @CurrentCreatedBy27 , -- CreatedBy - varchar(50)
          @CurrentApprovedBy27 , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@CurrentSQLScript27,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.4' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )


------------------------------------Countries of Export by Value - YoY------------------------------------
DECLARE @CurrentSQLGuid28 AS VARCHAR(36) = 'CFEA6B0D-2315-4F29-8B9A-BA663E1105C2';
DECLARE @CurrentSQLDescription28 AS NVARCHAR(100) = 'Countries of Export by Value - YoY';
DECLARE @CurrentSQLLongDescription28 AS NVARCHAR(MAX) = 'This comparison report shows the countries of export with the highest associated total declaration value on all declarations filed for the current year compared to the highest associated total declaration value on all declarations filed for the previous year. ';
DECLARE @CurrentCreatedBy28 AS VARCHAR(50) = 'jmerwin';
DECLARE @CurrentApprovedBy28 AS VARCHAR(50) = 'jmerwin';

DECLARE @CurrentSQLScript28 AS NVARCHAR(MAX) = 'select   h.PartnerID, d.ExportCountry, datepart(year, ImportDate) as ImportYear, CAST(SUM(EstBaseTotalLineValue) as Numeric(28,2)) as EstBaseTotalLineValue INTO #CurrentYearEC  from txdgvimportheader h WITH (NOLOCK) JOIN txdGVImportDetail d WITH (NOLOCK) ON  h.EntryGuid = d.EntryGuid and  h.PartnerID = d.PartnerID WHERE 1=1 AND h.PartnerID = @PartnerID and  datepart(year, ImportDate) =  DATEPART(year, GetDate())  group by h.PartnerID, d.ExportCountry, datepart(year, ImportDate)  select   h.PartnerID, d.ExportCountry, datepart(year, ImportDate) as ImportYear, CAST(SUM(EstBaseTotalLineValue) as Numeric(28,2)) as EstBaseTotalLineValue INTO #LastYearEC from txdgvimportheader h WITH (NOLOCK) JOIN txdGVImportDetail d WITH (NOLOCK) ON  h.EntryGuid = d.EntryGuid and  h.PartnerID = d.PartnerID WHERE 1=1 AND   datepart(year, ImportDate) =  DATEPART(year, dateadd(year, -1, GetDate())) and ImportDate <= (GETDATE()-365) group by h.PartnerID, d.ExportCountry, datepart(year, ImportDate)   SELECT TOP 10   h.ExportCountry,    isnull(sum(h.EstBaseTotalLineValue), 0) as [@CurrentYear],  isnull(sum(h2.EstBaseTotalLineValue), 0) as [@LastYear] FROM #CurrentYearEC h left join #LastYearEC h2 on   h.ExportCountry = h2.ExportCountry and  h.PartnerID = h2.PartnerID Group By h.ExportCountry ORDER BY sum(h.EstBaseTotalLineValue) DESC';


--insert old records into hist
INSERT INTO dbo.tbgSQLCommandsHist
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
          KeepDuringRollback   )
        SELECT  PartnerID ,
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
        FROM    dbo.tbgSQLCommands WITH ( NOLOCK )
        WHERE   SQLGUID = @CurrentSQLGuid28
                AND Version = '20.4';

--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @CurrentSQLGuid28
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
          @CurrentSQLGuid28 , -- SQLGUID - uniqueidentifier
          @CurrentSQLScript28 , -- SQLCommand - varchar(max)
          @CurrentSQLDescription28 , -- Description - nvarchar(100)
          @CurrentSQLLongDescription28 , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @CurrentCreatedBy28 , -- CreatedBy - varchar(50)
          @CurrentApprovedBy28 , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@CurrentSQLScript28,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.4' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )


------------------------------------HS Numbers by Duty - YoY------------------------------------
DECLARE @CurrentSQLGuid29 AS VARCHAR(36) = 'D74A0498-1442-4320-A6DA-2CDC9212C3A8';
DECLARE @CurrentSQLDescription29 AS NVARCHAR(100) = 'HS Numbers by Duty - YoY';
DECLARE @CurrentSQLLongDescription29 AS NVARCHAR(MAX) = 'This comparison report shows the HS numbers with the highest associated total line duty paid on all declarations filed for the current year compared to the highest associated total line duty paid on all declarations filed for the previous year.';
DECLARE @CurrentCreatedBy29 AS VARCHAR(50) = 'jmerwin';
DECLARE @CurrentApprovedBy29 AS VARCHAR(50) = 'jmerwin';

DECLARE @CurrentSQLScript29 AS NVARCHAR(MAX) = 'SELECT h.PartnerID  ,d.HsNum  ,datepart(year, ImportDate) AS ImportYear  ,CAST(SUM(d.EstBaseTotalLineDuty) AS NUMERIC(28, 2)) AS EstBaseTotalLineDuty  INTO #CurrentYear from txdgvimportheader h WITH (NOLOCK) join txdgvimportdetail d WITH (NOLOCK)  ON h.entryguid = d.entryguid  AND h.partnerid = d.partnerid WHERE 1=1 AND h.PartnerID = @PartnerID  AND datepart(year, ImportDate) = DATEPART(year, GetDate()) GROUP BY h.PartnerID  ,d.HsNum  ,datepart(year, ImportDate)  SELECT h.PartnerID  ,d.HsNum  ,datepart(year, ImportDate) AS ImportYear  ,CAST(SUM(d.EstBaseTotalLineDuty) AS NUMERIC(28, 2)) AS EstBaseTotalLineDuty INTO #LastYear from txdgvimportheader h WITH (NOLOCK) join txdgvimportdetail d WITH (NOLOCK)  ON h.entryguid = d.entryguid  AND h.partnerid = d.partnerid WHERE 1=1 AND datepart(year, ImportDate) = DATEPART(year, dateadd(year, - 1, GetDate())) and ImportDate <= (GETDATE()-365) GROUP BY h.PartnerID  ,d.HsNum  ,datepart(year, ImportDate)  SELECT TOP 10 h.HsNum  ,isnull(sum(h.EstBaseTotalLineDuty), 0) AS [@CurrentYear]  ,isnull(sum(h2.EstBaseTotalLineDuty), 0) AS [@LastYear] FROM #CurrentYear h LEFT JOIN #LastYear h2   ON h.HsNum = h2.HsNum  AND h.PartnerID = h2.PartnerID GROUP BY h.HsNum ORDER BY sum(h.EstBaseTotalLineDuty) DESC';


--insert old records into hist
INSERT INTO dbo.tbgSQLCommandsHist
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
          KeepDuringRollback   )
        SELECT  PartnerID ,
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
        FROM    dbo.tbgSQLCommands WITH ( NOLOCK )
        WHERE   SQLGUID = @CurrentSQLGuid29
                AND Version = '20.4';

--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @CurrentSQLGuid29
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
          @CurrentSQLGuid29 , -- SQLGUID - uniqueidentifier
          @CurrentSQLScript29 , -- SQLCommand - varchar(max)
          @CurrentSQLDescription29 , -- Description - nvarchar(100)
          @CurrentSQLLongDescription29 , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @CurrentCreatedBy29 , -- CreatedBy - varchar(50)
          @CurrentApprovedBy29 , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@CurrentSQLScript29,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.4' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )


------------------------------------Products by Duty - YoY------------------------------------
DECLARE @CurrentSQLGuid30 AS VARCHAR(36) = 'A074A733-2EBD-453E-8558-72BF0EC688EB';
DECLARE @CurrentSQLDescription30 AS NVARCHAR(100) = 'Products by Duty - YoY';
DECLARE @CurrentSQLLongDescription30 AS NVARCHAR(MAX) = 'This comparison report shows the products with the highest associated total line duty paid on all declarations filed for the current year compared to the highest associated total line duty paid on all declarations filed for the previous year. ';
DECLARE @CurrentCreatedBy30 AS VARCHAR(50) = 'jmerwin';
DECLARE @CurrentApprovedBy30 AS VARCHAR(50) = 'jmerwin';

DECLARE @CurrentSQLScript30 AS NVARCHAR(MAX) = 'SELECT h.PartnerID  ,d.ProductNum  ,datepart(year, ImportDate) AS ImportYear  ,CAST(SUM(d.EstBaseTotalLineDuty) AS NUMERIC(28, 2)) AS EstBaseTotalLineDuty INTO #CurrentYear from txdgvimportheader h WITH (NOLOCK) join txdgvimportdetail d WITH (NOLOCK)  ON h.entryguid = d.entryguid  AND h.partnerid = d.partnerid WHERE 1=1 AND h.PartnerID = @PartnerID  AND datepart(year, ImportDate) = DATEPART(year, GetDate()) GROUP BY h.PartnerID  ,d.ProductNum  ,datepart(year, ImportDate)  SELECT h.PartnerID  ,d.ProductNum  ,datepart(year, ImportDate) AS ImportYear  ,CAST(SUM(d.EstBaseTotalLineDuty) AS NUMERIC(28, 2)) AS EstBaseTotalLineDuty INTO #LastYear from txdgvimportheader h WITH (NOLOCK) join txdgvimportdetail d WITH (NOLOCK)  ON h.entryguid = d.entryguid  AND h.partnerid = d.partnerid WHERE 1=1 AND datepart(year, ImportDate) = DATEPART(year, dateadd(year, - 1, GetDate())) and ImportDate <= (GETDATE()-365) GROUP BY h.PartnerID  ,d.ProductNum  ,datepart(year, ImportDate)  SELECT TOP 10 h.ProductNum  ,isnull(sum(h.EstBaseTotalLineDuty), 0) AS [@CurrentYear]  ,isnull(sum(h2.EstBaseTotalLineDuty), 0) AS [@LastYear] FROM #CurrentYear h LEFT JOIN #LastYear h2   ON h.ProductNum = h2.ProductNum  AND h.PartnerID = h2.PartnerID GROUP BY h.ProductNum ORDER BY sum(h.EstBaseTotalLineDuty) DESC ';


--insert old records into hist
INSERT INTO dbo.tbgSQLCommandsHist
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
          KeepDuringRollback   )
        SELECT  PartnerID ,
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
        FROM    dbo.tbgSQLCommands WITH ( NOLOCK )
        WHERE   SQLGUID = @CurrentSQLGuid30
                AND Version = '20.4';

--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @CurrentSQLGuid30
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
          @CurrentSQLGuid30 , -- SQLGUID - uniqueidentifier
          @CurrentSQLScript30 , -- SQLCommand - varchar(max)
          @CurrentSQLDescription30 , -- Description - nvarchar(100)
          @CurrentSQLLongDescription30 , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @CurrentCreatedBy30 , -- CreatedBy - varchar(50)
          @CurrentApprovedBy30 , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@CurrentSQLScript30,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.4' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )


------------------------------------Products by Value - YoY------------------------------------
DECLARE @CurrentSQLGuid31 AS VARCHAR(36) = 'F01C1301-0F26-4FDE-9069-838EB1043267';
DECLARE @CurrentSQLDescription31 AS NVARCHAR(100) = 'Products by Value - YoY';
DECLARE @CurrentSQLLongDescription31 AS NVARCHAR(MAX) = 'This comparison report shows the products with the highest associated total line value on all declarations filed for the current year compared to the highest associated total line value on all declarations filed for the previous year.';
DECLARE @CurrentCreatedBy31 AS VARCHAR(50) = 'jmerwin';
DECLARE @CurrentApprovedBy31 AS VARCHAR(50) = 'jmerwin';

DECLARE @CurrentSQLScript31 AS NVARCHAR(MAX) = 'select        h.PartnerID, d.ProductNum, datepart(year, h.ImportDate) as ImportYear, CAST(SUM(d.EstBaseTotalLineValue) as Numeric(28,2)) as EstBaseTotalLineValue  INTO #CurrentYear  from txdgvimportheader h WITH (NOLOCK) join txdgvimportdetail d WITH (NOLOCK) on       h.EntryGuid = d.EntryGuid and        h.PartnerID = d.PartnerID WHERE 1=1 AND h.PartnerID = @PartnerID and       datepart(year, ImportDate) =  DATEPART(year, GetDate())  group by h.PartnerID, d.ProductNum, datepart(year, h.ImportDate)  select        h.PartnerID, d.ProductNum, datepart(year, h.ImportDate) as ImportYear, CAST(SUM(d.EstBaseTotalLineValue) as Numeric(28,2)) as EstBaseTotalLineValue  INTO #LastYear  from txdgvimportheader h WITH (NOLOCK) join txdgvimportdetail d WITH (NOLOCK) on       h.EntryGuid = d.EntryGuid and        h.PartnerID = d.PartnerID WHERE 1=1 AND        datepart(year, ImportDate) =  DATEPART(year, dateadd(year, -1, GetDate())) and ImportDate <= (GETDATE()-365) group by h.PartnerID, d.ProductNum, datepart(year, h.ImportDate)   SELECT TOP 10        h.ProductNum,         isnull(sum(h.EstBaseTotalLineValue), 0) as [@CurrentYear],       isnull(sum(h2.EstBaseTotalLineValue), 0) as [@LastYear] FROM #CurrentYear h left join #LastYear h2 on        h.ProductNum = h2.ProductNum and       h.PartnerID = h2.PartnerID Group By h.ProductNum ORDER BY sum(h.EstBaseTotalLineValue) DESC ';


--insert old records into hist
INSERT INTO dbo.tbgSQLCommandsHist
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
          KeepDuringRollback   )
        SELECT  PartnerID ,
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
        FROM    dbo.tbgSQLCommands WITH ( NOLOCK )
        WHERE   SQLGUID = @CurrentSQLGuid31
                AND Version = '20.4';

--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @CurrentSQLGuid31
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
          @CurrentSQLGuid31 , -- SQLGUID - uniqueidentifier
          @CurrentSQLScript31 , -- SQLCommand - varchar(max)
          @CurrentSQLDescription31 , -- Description - nvarchar(100)
          @CurrentSQLLongDescription31 , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @CurrentCreatedBy31 , -- CreatedBy - varchar(50)
          @CurrentApprovedBy31 , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@CurrentSQLScript31,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.4' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )


------------------------------------Business Units by Duty - YoY------------------------------------
DECLARE @CurrentSQLGuid32 AS VARCHAR(36) = 'F34B3ECB-D942-448A-BE05-77E05366BFED';
DECLARE @CurrentSQLDescription32 AS NVARCHAR(100) = 'Business Units by Duty - YoY';
DECLARE @CurrentSQLLongDescription32 AS NVARCHAR(MAX) = 'This comparison report shows the business units with the highest associated total line duty paid on all declarations filed for the current year compared to the highest associated total line duty paid on all declarations filed for the previous year. ';
DECLARE @CurrentCreatedBy32 AS VARCHAR(50) = 'jmerwin';
DECLARE @CurrentApprovedBy32 AS VARCHAR(50) = 'jmerwin';

DECLARE @CurrentSQLScript32 AS NVARCHAR(MAX) = 'SELECT h.PartnerID  ,d.BusinessUnit  ,datepart(year, ImportDate) AS ImportYear  ,CAST(SUM(d.EstBaseTotalLineDuty) AS NUMERIC(28, 2)) AS EstBaseTotalLineDuty INTO #CurrentYear from txdgvimportheader h WITH (NOLOCK) join txdgvimportdetail d WITH (NOLOCK)  ON h.entryguid = d.entryguid  AND h.partnerid = d.partnerid WHERE 1=1 AND h.PartnerID = @PartnerID  AND datepart(year, ImportDate) = DATEPART(year, GetDate()) GROUP BY h.PartnerID  ,d.BusinessUnit  ,datepart(year, ImportDate)  SELECT h.PartnerID  ,d.BusinessUnit  ,datepart(year, ImportDate) AS ImportYear  ,CAST(SUM(d.EstBaseTotalLineDuty) AS NUMERIC(28, 2)) AS EstBaseTotalLineDuty INTO #LastYear from txdgvimportheader h WITH (NOLOCK) join txdgvimportdetail d WITH (NOLOCK)  ON h.entryguid = d.entryguid  AND h.partnerid = d.partnerid WHERE 1=1 AND datepart(year, ImportDate) = DATEPART(year, dateadd(year, - 1, GetDate()))  and ImportDate <= (GETDATE()-365) GROUP BY h.PartnerID  ,d.BusinessUnit  ,datepart(year, ImportDate)  SELECT TOP 10 h.BusinessUnit  ,isnull(sum(h.EstBaseTotalLineDuty), 0) AS [@CurrentYear]  ,isnull(sum(h2.EstBaseTotalLineDuty), 0) AS [@LastYear] FROM #CurrentYear h LEFT JOIN #LastYear h2   ON h.BusinessUnit = h2.BusinessUnit  AND h.PartnerID = h2.PartnerID GROUP BY h.BusinessUnit ORDER BY sum(h.EstBaseTotalLineDuty) DESC';


--insert old records into hist
INSERT INTO dbo.tbgSQLCommandsHist
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
          KeepDuringRollback   )
        SELECT  PartnerID ,
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
        FROM    dbo.tbgSQLCommands WITH ( NOLOCK )
        WHERE   SQLGUID = @CurrentSQLGuid32
                AND Version = '20.4';

--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @CurrentSQLGuid32
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
          @CurrentSQLGuid32 , -- SQLGUID - uniqueidentifier
          @CurrentSQLScript32 , -- SQLCommand - varchar(max)
          @CurrentSQLDescription32 , -- Description - nvarchar(100)
          @CurrentSQLLongDescription32 , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @CurrentCreatedBy32 , -- CreatedBy - varchar(50)
          @CurrentApprovedBy32 , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@CurrentSQLScript32,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.4' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )


------------------------------------Value Shipped by Export Country - YoY------------------------------------
DECLARE @CurrentSQLGuid33 AS VARCHAR(36) = '7D8827DB-2D34-4B23-A798-754DF2DF88CD';
DECLARE @CurrentSQLDescription33 AS NVARCHAR(100) = 'Value Shipped by Export Country - YoY';
DECLARE @CurrentSQLLongDescription33 AS NVARCHAR(MAX) = 'This comparison report shows the Export Countries with the highest associated total Shipment Value on all shipments for the current calendar year compared to the associated total Shipment Value on all shipments filed for the previous calendar year. ';
DECLARE @CurrentCreatedBy33 AS VARCHAR(50) = 'kduval';
DECLARE @CurrentApprovedBy33 AS VARCHAR(50) = '';

DECLARE @CurrentSQLScript33 AS NVARCHAR(MAX) = 'SELECT  h.PartnerID ,
        ExportCountry ,
        DATEPART(YEAR, ExportDate) AS ExportYear ,
        CAST(SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 2)) AS EstBaseTotalShipmentValue
INTO    #CurrentYear
FROM    txdGVExportHeader h WITH ( NOLOCK )
JOIN dbo.txdGVExportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.ExportGUID = h.ExportGuid
WHERE 1=1 AND @EXPORTDATERANGE AND h.PartnerID = @PartnerID 
        AND DATEPART(YEAR, ExportDate) = DATEPART(YEAR, GETDATE())
GROUP BY h.PartnerID ,
        ExportCountry ,
        DATEPART(YEAR, ExportDate)
SELECT  h.PartnerID ,
        ExportCountry ,
        DATEPART(YEAR, ExportDate) AS ExportYear ,
        CAST(SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 2)) AS EstBaseTotalShipmentValue
INTO    #LastYear
FROM    txdGVExportHeader h WITH (NOLOCK)
JOIN dbo.txdGVExportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.ExportGUID = h.ExportGuid
WHERE 1=1 AND   DATEPART(YEAR, ExportDate) = DATEPART(YEAR,
                                              DATEADD(YEAR, -1, GETDATE()))
        AND ExportDate <= ( GETDATE() - 365 )
GROUP BY h.PartnerID ,
        ExportCountry ,
        DATEPART(YEAR, ExportDate)
SELECT TOP 10
        y.ExportCountry ,
        ISNULL(SUM(y.EstBaseTotalShipmentValue), 0) AS [@CurrentYear] ,
        ISNULL(SUM(y2.EstBaseTotalShipmentValue), 0) AS [@LastYear]
FROM    #CurrentYear y
        LEFT JOIN #LastYear y2 ON y.ExportCountry = y2.ExportCountry
                                  AND y.PartnerID = y2.PartnerID
GROUP BY y.ExportCountry
ORDER BY SUM(y.EstBaseTotalShipmentValue) DESC';


--insert old records into hist
INSERT INTO dbo.tbgSQLCommandsHist
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
          KeepDuringRollback   )
        SELECT  PartnerID ,
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
        FROM    dbo.tbgSQLCommands WITH ( NOLOCK )
        WHERE   SQLGUID = @CurrentSQLGuid33
                AND Version = '20.4';

--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @CurrentSQLGuid33
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
          @CurrentSQLGuid33 , -- SQLGUID - uniqueidentifier
          @CurrentSQLScript33 , -- SQLCommand - varchar(max)
          @CurrentSQLDescription33 , -- Description - nvarchar(100)
          @CurrentSQLLongDescription33 , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @CurrentCreatedBy33 , -- CreatedBy - varchar(50)
          @CurrentApprovedBy33 , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@CurrentSQLScript33,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.4' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )


------------------------------------Value Exported by Bill To - YoY------------------------------------
DECLARE @CurrentSQLGuid34 AS VARCHAR(36) = '2F920354-DF04-455A-9B5C-2FFF22249BAB';
DECLARE @CurrentSQLDescription34 AS NVARCHAR(100) = 'Value Exported by Bill To - YoY';
DECLARE @CurrentSQLLongDescription34 AS NVARCHAR(MAX) = 'This comparison report shows the Bill To companies with the highest associated total Shipment Value on all shipments for the current year to date compared to the associated Shipment Value on all shipments during the same period in the previous year. ';
DECLARE @CurrentCreatedBy34 AS VARCHAR(50) = 'jmerwin';
DECLARE @CurrentApprovedBy34 AS VARCHAR(50) = 'jmerwin';

DECLARE @CurrentSQLScript34 AS NVARCHAR(MAX) = 'select   PartnerID, BillToCompanyName, datepart(year, ExportDate) as ExportYear, CAST(SUM(EstBaseTotalShipmentValue) as Numeric(28,2)) as EstBaseTotalShipmentValue INTO #CurrentYear  from txdGVExportHeader h WITH (NOLOCK) WHERE 1=1 AND @EXPORTDATERANGE AND PartnerID = @PartnerID and  datepart(year, ExportDate) =  DATEPART(year, GetDate())  group by PartnerID, BillToCompanyName, datepart(year, ExportDate)  select   PartnerID, BillToCompanyName, datepart(year, ExportDate) as ExportYear, CAST(SUM(EstBaseTotalShipmentValue) as Numeric(28,2)) as EstBaseTotalShipmentValue INTO #LastYear  from txdGVExportHeader  WHERE 1=1 AND   datepart(year, ExportDate) =  DATEPART(year, dateadd(year, -1, GetDate())) and ExportDate <= (GETDATE()-365) group by PartnerID, BillToCompanyName, datepart(year, ExportDate)   SELECT TOP 10   h.BillToCompanyName,    isnull(sum(h.EstBaseTotalShipmentValue), 0) as [@CurrentYear],  isnull(sum(h2.EstBaseTotalShipmentValue), 0) as [@LastYear] FROM #CurrentYear h left join #LastYear h2 on   h.BillToCompanyName= h2.BillToCompanyName and  h.PartnerID = h2.PartnerID Group By h.BillToCompanyName ORDER BY sum(h.EstBaseTotalShipmentValue) DESC';


--insert old records into hist
INSERT INTO dbo.tbgSQLCommandsHist
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
          KeepDuringRollback   )
        SELECT  PartnerID ,
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
        FROM    dbo.tbgSQLCommands WITH ( NOLOCK )
        WHERE   SQLGUID = @CurrentSQLGuid34
                AND Version = '20.4';

--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @CurrentSQLGuid34
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
          @CurrentSQLGuid34 , -- SQLGUID - uniqueidentifier
          @CurrentSQLScript34 , -- SQLCommand - varchar(max)
          @CurrentSQLDescription34 , -- Description - nvarchar(100)
          @CurrentSQLLongDescription34 , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @CurrentCreatedBy34 , -- CreatedBy - varchar(50)
          @CurrentApprovedBy34 , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@CurrentSQLScript34,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.4' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )



SET IDENTITY_INSERT dbo.tbgSQLCommandsHist ON;
GO	

COMMIT TRANSACTION
SET XACT_ABORT OFF;