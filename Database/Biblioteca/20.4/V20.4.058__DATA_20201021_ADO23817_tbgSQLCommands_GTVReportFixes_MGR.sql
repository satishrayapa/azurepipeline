SET XACT_ABORT ON;
BEGIN TRANSACTION;

SET IDENTITY_INSERT dbo.tbgSQLCommandsHist OFF;
GO	

DECLARE @partner AS INT;
SET @partner = 4000;
------------------------------------Top Declaration Count by Brokers------------------------------------
DECLARE @CurrentSQLGuid1 AS VARCHAR(36) = '50477EED-E581-4CC3-9CE3-B3F0F616702D';
DECLARE @CurrentSQLDescription1 AS NVARCHAR(100) = 'Top Declaration Count by Brokers';
DECLARE @CurrentSQLLongDescription1 AS NVARCHAR(MAX) = 'This report shows the brokers with the highest total number of declarations filed.';
DECLARE @CurrentCreatedBy1 AS VARCHAR(50) = 'ae63a9d5-059c-4a0f-a497-8fba1081272f';
DECLARE @CurrentApprovedBy1 AS VARCHAR(50) = '';

DECLARE @CurrentSQLScript1 AS NVARCHAR(MAX) = 'SELECT TOP 5 CASE BrokerName WHEN '''' THEN ''(Broker name not available)'' ELSE BrokerName END AS [BrokerName]  ,COUNT(DISTINCT DeclarationNum) AS DeclarationCount from txdgvimportheader h WITH (NOLOCK) WHERE 1=1 AND @IMPORTDATERANGE  AND PartnerID = @PartnerID GROUP BY BrokerName ORDER BY Count(DISTINCT DeclarationNum) DESC ';


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


------------------------------------Regions by Duty------------------------------------
DECLARE @CurrentSQLGuid2 AS VARCHAR(36) = '7D803073-7C9A-4A22-BE93-DD86242C95B0';
DECLARE @CurrentSQLDescription2 AS NVARCHAR(100) = 'Regions by Duty';
DECLARE @CurrentSQLLongDescription2 AS NVARCHAR(MAX) = 'This report shows total declared duty of all imports, grouped by geographical region.';
DECLARE @CurrentCreatedBy2 AS VARCHAR(50) = 'kduval';
DECLARE @CurrentApprovedBy2 AS VARCHAR(50) = '';

DECLARE @CurrentSQLScript2 AS NVARCHAR(MAX) = 'SELECT  ISNULL(cg.GroupName, h.ImportCountry) AS ImportRegion ,
        CAST(SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 2)) AS [EstBaseTotalDuty (@CurrencyCode)]
FROM    txdGVImportHeader h WITH (NOLOCK)
        LEFT JOIN tmfCountryGroup cg WITH (NOLOCK) ON h.ImportCountry = cg.CountryCode
                                        AND h.PartnerID = cg.PartnerID
JOIN dbo.txdGVImportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.EntryGuid = h.EntryGuid
WHERE 1=1 AND @IMPORTDATERANGE AND h.PartnerID = @PartnerID 
        AND h.ImportCountry <> '''' and cg.ActiveFlag = ''Y''
GROUP BY ISNULL(cg.GroupName, h.ImportCountry)
ORDER BY [EstBaseTotalDuty (@CurrencyCode)] DESC';


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


------------------------------------Declared Value by Region------------------------------------
DECLARE @CurrentSQLGuid3 AS VARCHAR(36) = 'E96D8AE1-B80A-4C2B-9D53-7385C7D55FFE';
DECLARE @CurrentSQLDescription3 AS NVARCHAR(100) = 'Declared Value by Region';
DECLARE @CurrentSQLLongDescription3 AS NVARCHAR(MAX) = 'Shows total declared value of all imports, grouped by geographical region. ';
DECLARE @CurrentCreatedBy3 AS VARCHAR(50) = 'kduval';
DECLARE @CurrentApprovedBy3 AS VARCHAR(50) = '';

DECLARE @CurrentSQLScript3 AS NVARCHAR(MAX) = 'SELECT  ISNULL(cg.GroupName, h.ImportCountry) AS ImportRegion ,
        CAST(SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 2)) AS [EstBaseTotalValue (@CurrencyCode)]
FROM    txdGVImportHeader h
        LEFT JOIN tmfCountryGroup cg ON h.ImportCountry = cg.CountryCode
                                        AND h.PartnerID = cg.PartnerID
JOIN dbo.txdGVImportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.EntryGuid = h.EntryGuid
WHERE 1=1 AND @IMPORTDATERANGE AND h.PartnerID = @PartnerID 
        AND h.ImportCountry <> '''' and cg.ActiveFlag = ''Y''
GROUP BY ISNULL(cg.GroupName, h.ImportCountry)
ORDER BY [EstBaseTotalValue (@CurrencyCode)] DESC';


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



SET IDENTITY_INSERT dbo.tbgSQLCommandsHist ON;
GO	

COMMIT TRANSACTION
SET XACT_ABORT OFF;