SET XACT_ABORT ON;
BEGIN TRANSACTION;

SET IDENTITY_INSERT dbo.tbgSQLCommandsHist ON;
GO	

DECLARE @partner AS INT
SET @partner = 4000

DECLARE @description AS NVARCHAR (max)
DECLARE @longdescription AS NVARCHAR (max)
DECLARE @sqlguid AS UNIQUEIDENTIFIER
DECLARE @newsqlcmd AS VARCHAR (max)

------------------------------------Average Duty Paid by Broker----------------------------------------
SET @sqlguid = '3C9FC8FC-FACB-47E6-B198-20F7D7F52A1C'

SET @newsqlcmd = 'SELECT TOP 10
        h.BrokerName ,
        CAST(SUM(d.EstBaseTotalLineDuty)
        / SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 4)) AS [DutyPerUnitValue(@CurrencyCode)]
FROM    txdGVImportHeader h WITH ( NOLOCK )
        JOIN txdGVImportDetail d WITH ( NOLOCK ) ON h.EntryGuid = d.EntryGuid
                                                    AND h.PartnerID = d.PartnerID
WHERE 1=1 AND @IMPORTDATERANGE AND h.PartnerID = @PartnerID 
GROUP BY h.BrokerName
HAVING SUM(d.EstBaseTotalLineValue) > 0
ORDER BY [DutyPerUnitValue(@CurrencyCode)] DESC'
SET @description = N'Average Duty Paid by Broker'
SET @longdescription = N'This report shows the highest duty paid per unit of declaration value with the related brokers.'

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


------------------------------------Average Duty Paid by Business Unit----------------------------------------
SET @sqlguid = 'C51B0549-E2DC-4ED6-8A8C-68C3DBD206F1'

SET @newsqlcmd = 'SELECT TOP 10
        d.BusinessUnit ,
        CAST(SUM(d.EstBaseTotalLineDuty)
        / SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 4)) AS [DutyPerUnitValue(@CurrencyCode)]
FROM    txdGVImportHeader h WITH ( NOLOCK )
        JOIN txdGVImportDetail d WITH ( NOLOCK ) ON h.EntryGuid = d.EntryGuid
                                                    AND h.PartnerID = d.PartnerID
WHERE 1=1 AND @IMPORTDATERANGE AND h.PartnerID = @PartnerID 
GROUP BY d.BusinessUnit
HAVING SUM(d.EstBaseTotalLineValue) > 0
ORDER BY [DutyPerUnitValue(@CurrencyCode)] DESC'
SET @description = N'Average Duty Paid by Business Unit'
SET @longdescription = N'This report shows the highest duty paid per unit of declaration value with the related business units.'

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


------------------------------------Average Duty Paid by Export Country----------------------------------------
SET @sqlguid = 'D0029138-BC81-47C5-8562-559C9B9EF764'

SET @newsqlcmd = 'Select top 10  d.ExportCountry,  CAST(SUM(d.EstBaseTotalLineDuty)/ SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 4)) as [DutyPerUnitValue(@CurrencyCode)] from txdgvimportheader h WITH (NOLOCK)  join txdgvimportdetail d WITH (NOLOCK) on   h.EntryGuid = d.EntryGuid and   h.PartnerID = d.PartnerID  WHERE 1=1 AND @IMPORTDATERANGE AND h.PartnerID = @PartnerID GROUP BY d.ExportCountry HAVING SUM(d.EstBaseTotalLineValue) > 0 ORDER BY [DutyPerUnitValue(@CurrencyCode)] DESC  '
SET @description = N'Average Duty Paid by Export Country'
SET @longdescription = N'This report shows the duty paid per unit of declaration value for all countries of export.'

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


------------------------------------Average Duty Paid by HS Number----------------------------------------
SET @sqlguid = '72A15B96-D84B-4F09-B750-C043D6D35CE3'

SET @newsqlcmd = 'SELECT TOP 10
        d.HsNum ,
        CAST(SUM(d.EstBaseTotalLineDuty)
        / SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 4)) AS [DutyPerUnitValue(@CurrencyCode)]
FROM    txdGVImportHeader h WITH ( NOLOCK )
        JOIN txdGVImportDetail d WITH ( NOLOCK ) ON h.EntryGuid = d.EntryGuid
                                                    AND h.PartnerID = d.PartnerID
WHERE 1=1 AND @IMPORTDATERANGE AND h.PartnerID = @PartnerID 
GROUP BY d.HsNum
HAVING SUM(d.EstBaseTotalLineValue) > 0
ORDER BY [DutyPerUnitValue(@CurrencyCode)] DESC'
SET @description = N'Average Duty Paid by HS Number'
SET @longdescription = N'This report shows the highest duty paid per unit of declaration value with the related HS numbers.'

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


------------------------------------Average Duty Paid by ImporterID----------------------------------------
SET @sqlguid = '8FC798DF-6456-4521-BBF4-5C5DF8D7D3E7'

SET @newsqlcmd = 'SELECT TOP 10
        h.ImporterID ,
		CAST(SUM(d.EstBaseTotalLineDuty)
		/ SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 4)) AS [DutyPerUnitValue(@CurrencyCode)]
FROM    txdGVImportHeader h WITH ( NOLOCK )
        JOIN txdGVImportDetail d WITH ( NOLOCK ) ON h.EntryGuid = d.EntryGuid
                                                    AND h.PartnerID = d.PartnerID
WHERE 1=1 AND @IMPORTDATERANGE AND h.PartnerID = @PartnerID
GROUP BY h.ImporterID
HAVING SUM(d.EstBaseTotalLineValue) > 0
ORDER BY [DutyPerUnitValue(@CurrencyCode)] DESC'
SET @description = N'Average Duty Paid by ImporterID'
SET @longdescription = N'This report shows the highest duty paid per unit of declaration value with the related importer IDs.'

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


------------------------------------Average Duty Paid by Port of Unlading----------------------------------------
SET @sqlguid = '97D122A4-1DB0-46E0-84E1-2EA86DAE7085'

SET @newsqlcmd = 'SELECT TOP 10
        d.PortOfUnlading ,
        CAST(SUM(d.EstBaseTotalLineDuty)
        / SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 4)) AS [DutyPerUnitValue(@CurrencyCode)]
FROM    txdGVImportHeader h WITH ( NOLOCK )
        JOIN txdGVImportDetail d WITH ( NOLOCK ) ON h.EntryGuid = d.EntryGuid
                                                    AND h.PartnerID = d.PartnerID
WHERE 1=1 AND @IMPORTDATERANGE AND h.PartnerID = @PartnerID  
GROUP BY d.PortOfUnlading
HAVING SUM(d.EstBaseTotalLineValue) > 0
ORDER BY [DutyPerUnitValue(@CurrencyCode)] DESC'
SET @description = N'Average Duty Paid by Port of Unlading'
SET @longdescription = N'This report shows the highest duty paid per unit of declaration value with the related ports of unlading.'

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


------------------------------------Average Duty Paid by Products----------------------------------------
SET @sqlguid = 'F5DC323D-7926-4859-9D34-1952FD87A328'

SET @newsqlcmd = 'SELECT TOP 10
        d.ProductNum ,
        CAST(SUM(d.EstBaseTotalLineDuty)
        / SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 4)) AS [DutyPerUnitValue(@CurrencyCode)]
FROM    txdGVImportHeader h WITH ( NOLOCK )
        JOIN txdGVImportDetail d WITH ( NOLOCK ) ON h.EntryGuid = d.EntryGuid
                                                    AND h.PartnerID = d.PartnerID
WHERE 1=1 AND @IMPORTDATERANGE AND h.PartnerID = @PartnerID 
GROUP BY d.ProductNum
HAVING SUM(d.EstBaseTotalLineValue) > 0
ORDER BY [DutyPerUnitValue(@CurrencyCode)] DESC'
SET @description = N'Average Duty Paid by Products'
SET @longdescription = N'This report shows the highest duty paid per unit of declaration value with the related products.'

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


------------------------------------Avg Duty Paid by Importers----------------------------------------
SET @sqlguid = '7E2BA982-95F2-4A39-BE50-077AE56065F1'

SET @newsqlcmd = 'SELECT TOP 10
        h.ImporterName ,
        CAST(SUM(d.EstBaseTotalLineDuty)
        / SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 4)) AS [DutyPerUnitValue(@CurrencyCode)]
FROM    txdGVImportHeader h WITH ( NOLOCK )
        JOIN txdGVImportDetail d WITH ( NOLOCK ) ON h.EntryGuid = d.EntryGuid
                                                    AND h.PartnerID = d.PartnerID
WHERE 1=1 AND @IMPORTDATERANGE AND h.PartnerID = @PartnerID 
GROUP BY h.ImporterName
HAVING SUM(d.EstBaseTotalLineValue) > 0
ORDER BY [DutyPerUnitValue(@CurrencyCode)] DESC'
SET @description = N'Avg Duty Paid by Importers'
SET @longdescription = N'This report shows the highest duty paid per unit of declaration value with the related importers.'

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


COMMIT TRANSACTION
SET XACT_ABORT OFF;