SET XACT_ABORT ON;
BEGIN TRANSACTION;

SET IDENTITY_INSERT dbo.tbgSQLCommandsHist ON;
GO	

DECLARE @partner AS INT
SET @partner = 4000
------------------------------------Ports of Unlading by Value - YoY----------------------------------------
DECLARE @sqlguid AS UNIQUEIDENTIFIER
SET @sqlguid = '5B73E37D-E1AF-435D-9880-ACCDB0998E3B'

DECLARE @newsqlcmd AS VARCHAR (max)
SET @newsqlcmd = 'SELECT  d.PartnerID ,
        d.PortOfUnlading ,
        DATEPART(YEAR, h.ImportDate) AS ImportYear ,
        CAST(SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 2)) AS EstBaseTotalDeclarationValue
INTO    #CurrentYear
FROM    txdGVImportHeader h WITH ( NOLOCK )
        JOIN txdGVImportDetail d WITH ( NOLOCK ) ON h.EntryGuid = d.EntryGuid
                                                    AND h.PartnerID = d.PartnerID
WHERE 1=1 AND h.PartnerID = @partnerid 
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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          N'Ports of Unlading by Value - YoY' , -- Description - nvarchar(100)
          N'This comparison report shows the ports of unlading with the highest associated total declaration value on all declarations filed for the current year compared to the highest associated total declaration value on all declarations filed for the previous year. ' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          N'Ports of Unlading by Value - YoY' , -- Description - nvarchar(100)
          N'This comparison report shows the ports of unlading with the highest associated total declaration value on all declarations filed for the current year compared to the highest associated total declaration value on all declarations filed for the previous year. ' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

----------------------------------------------------------Ports of Unlading by Value - YoY---------------------------------------------------------


------------------------------------Avg Duty Paid by Importer IDs----------------------------------------
--DECLARE @sqlguid AS UNIQUEIDENTIFIER
SET @sqlguid = '8FC798DF-6456-4521-BBF4-5C5DF8D7D3E7'

--DECLARE @newsqlcmd AS VARCHAR (max)
SET @newsqlcmd = 'SELECT TOP 10
        h.ImporterID ,
		CAST(SUM(d.EstBaseTotalLineDuty)
		/ SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 4)) AS [DutyPerUnitValue(@CurrencyCode)]
FROM    txdGVImportHeader h WITH ( NOLOCK )
        JOIN txdGVImportDetail d WITH ( NOLOCK ) ON h.EntryGuid = d.EntryGuid
                                                    AND h.PartnerID = d.PartnerID
WHERE 1=1 AND @IMPORTDATERANGE AND h.PartnerID = @PartnerID
GROUP BY h.ImporterID
ORDER BY [DutyPerUnitValue(@CurrencyCode)] DESC'

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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    

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
          N'Average Duty Paid by ImporterID' , -- Description - nvarchar(100)
          N'This report shows the highest duty paid per unit of declaration value with the related importer IDs.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          N'Average Duty Paid by ImporterID' , -- Description - nvarchar(100)
          N'This report shows the highest duty paid per unit of declaration value with the related importer IDs.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					
		

----------------------------------------------------------Avg Duty Paid by Importer IDs---------------------------------------------------------


------------------------------------Avg Duty Paid by Ports of Unlading----------------------------------------
--DECLARE @sqlguid AS UNIQUEIDENTIFIER
SET @sqlguid = '97D122A4-1DB0-46E0-84E1-2EA86DAE7085'

--DECLARE @newsqlcmd AS VARCHAR (max)
SET @newsqlcmd = 'SELECT TOP 10
        d.PortOfUnlading ,
        CAST(SUM(d.EstBaseTotalLineDuty)
        / SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 4)) AS [DutyPerUnitValue(@CurrencyCode)]
FROM    txdGVImportHeader h WITH ( NOLOCK )
        JOIN txdGVImportDetail d WITH ( NOLOCK ) ON h.EntryGuid = d.EntryGuid
                                                    AND h.PartnerID = d.PartnerID
WHERE 1=1 AND @IMPORTDATERANGE AND h.PartnerID = @PartnerID  
GROUP BY d.PortOfUnlading
ORDER BY [DutyPerUnitValue(@CurrencyCode)] DESC'

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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    

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
          N'Average Duty Paid by Port of Unlading' , -- Description - nvarchar(100)
          N'This report shows the highest duty paid per unit of declaration value with the related ports of unlading.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          N'Average Duty Paid by Port of Unlading' , -- Description - nvarchar(100)
          N'This report shows the highest duty paid per unit of declaration value with the related ports of unlading.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

----------------------------------------------------------Avg Duty Paid by Ports of Unlading---------------------------------------------------------



------------------------------------Avg Duty Paid by Importers----------------------------------------
--DECLARE @sqlguid AS UNIQUEIDENTIFIER
SET @sqlguid = '7E2BA982-95F2-4A39-BE50-077AE56065F1'

--DECLARE @newsqlcmd AS VARCHAR (max)
SET @newsqlcmd = 'SELECT TOP 10
        h.ImporterName ,
        CAST(SUM(d.EstBaseTotalLineDuty)
        / SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 4)) AS [DutyPerUnitValue(@CurrencyCode)]
FROM    txdGVImportHeader h WITH ( NOLOCK )
        JOIN txdGVImportDetail d WITH ( NOLOCK ) ON h.EntryGuid = d.EntryGuid
                                                    AND h.PartnerID = d.PartnerID
WHERE 1=1 AND @IMPORTDATERANGE AND h.PartnerID = @PartnerID 
GROUP BY h.ImporterName
ORDER BY [DutyPerUnitValue(@CurrencyCode)] DESC'

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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    

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
          N'Avg Duty Paid by Importers' , -- Description - nvarchar(100)
          N'This report shows the highest duty paid per unit of declaration value with the related importers.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          N'Avg Duty Paid by Importers' , -- Description - nvarchar(100)
          N'This report shows the highest duty paid per unit of declaration value with the related importers.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

----------------------------------------------------------Avg Duty Paid by Importers---------------------------------------------------------

------------------------------------Average Duty Paid by HS Number----------------------------------------
--DECLARE @sqlguid AS UNIQUEIDENTIFIER
SET @sqlguid = '72A15B96-D84B-4F09-B750-C043D6D35CE3'

--DECLARE @newsqlcmd AS VARCHAR (max)
SET @newsqlcmd = 'SELECT TOP 10
        d.HsNum ,
        CAST(SUM(d.EstBaseTotalLineDuty)
        / SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 4)) AS [DutyPerUnitValue(@CurrencyCode)]
FROM    txdGVImportHeader h WITH ( NOLOCK )
        JOIN txdGVImportDetail d WITH ( NOLOCK ) ON h.EntryGuid = d.EntryGuid
                                                    AND h.PartnerID = d.PartnerID
WHERE 1=1 AND @IMPORTDATERANGE AND h.PartnerID = @PartnerID 
GROUP BY d.HsNum
ORDER BY [DutyPerUnitValue(@CurrencyCode)] DESC'

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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    

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
          N'Average Duty Paid by HS Number' , -- Description - nvarchar(100)
          N'This report shows the highest duty paid per unit of declaration value with the related HS numbers.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          N'Average Duty Paid by HS Number' , -- Description - nvarchar(100)
          N'This report shows the highest duty paid per unit of declaration value with the related HS numbers.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

----------------------------------------------------------Average Duty Paid by HS Number---------------------------------------------------------

------------------------------------Avg Duty Paid by Business Units----------------------------------------
--DECLARE @sqlguid AS UNIQUEIDENTIFIER
SET @sqlguid = 'C51B0549-E2DC-4ED6-8A8C-68C3DBD206F1'

--DECLARE @newsqlcmd AS VARCHAR (max)
SET @newsqlcmd = 'SELECT TOP 10
        d.BusinessUnit ,
        CAST(SUM(d.EstBaseTotalLineDuty)
        / SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 4)) AS [DutyPerUnitValue(@CurrencyCode)]
FROM    txdGVImportHeader h WITH ( NOLOCK )
        JOIN txdGVImportDetail d WITH ( NOLOCK ) ON h.EntryGuid = d.EntryGuid
                                                    AND h.PartnerID = d.PartnerID
WHERE 1=1 AND @IMPORTDATERANGE AND h.PartnerID = @PartnerID 
GROUP BY d.BusinessUnit
ORDER BY [DutyPerUnitValue(@CurrencyCode)] DESC'



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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    

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
          N'Average Duty Paid by Business Unit' , -- Description - nvarchar(100)
          N'This report shows the highest duty paid per unit of declaration value with the related business units.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          N'Average Duty Paid by Business Unit' , -- Description - nvarchar(100)
          N'This report shows the highest duty paid per unit of declaration value with the related business units.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

----------------------------------------------------------Avg Duty Paid by Business Units---------------------------------------------------------

------------------------------------Average Duty Paid by Products----------------------------------------
--DECLARE @sqlguid AS UNIQUEIDENTIFIER
SET @sqlguid = 'F5DC323D-7926-4859-9D34-1952FD87A328'

--DECLARE @newsqlcmd AS VARCHAR (max)
SET @newsqlcmd = 'SELECT TOP 10
        d.ProductNum ,
        CAST(SUM(d.EstBaseTotalLineDuty)
        / SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 4)) AS [DutyPerUnitValue(@CurrencyCode)]
FROM    txdGVImportHeader h WITH ( NOLOCK )
        JOIN txdGVImportDetail d WITH ( NOLOCK ) ON h.EntryGuid = d.EntryGuid
                                                    AND h.PartnerID = d.PartnerID
WHERE 1=1 AND @IMPORTDATERANGE AND h.PartnerID = @PartnerID 
GROUP BY d.ProductNum
ORDER BY [DutyPerUnitValue(@CurrencyCode)] DESC'



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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    

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
          N'Average Duty Paid by Products' , -- Description - nvarchar(100)
          N'This report shows the highest duty paid per unit of declaration value with the related products. ' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          N'Average Duty Paid by Products' , -- Description - nvarchar(100)
          N'This report shows the highest duty paid per unit of declaration value with the related products. ' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

----------------------------------------------------------Average Duty Paid by Products---------------------------------------------------------


------------------------------------Average Duty Paid by Brokers----------------------------------------
--DECLARE @sqlguid AS UNIQUEIDENTIFIER
SET @sqlguid = '3C9FC8FC-FACB-47E6-B198-20F7D7F52A1C'

--DECLARE @newsqlcmd AS VARCHAR (max)
SET @newsqlcmd = 'SELECT TOP 10
        h.BrokerName ,
        CAST(SUM(d.EstBaseTotalLineDuty)
        / SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 4)) AS [DutyPerUnitValue(@CurrencyCode)]
FROM    txdGVImportHeader h WITH ( NOLOCK )
        JOIN txdGVImportDetail d WITH ( NOLOCK ) ON h.EntryGuid = d.EntryGuid
                                                    AND h.PartnerID = d.PartnerID
WHERE 1=1 AND @IMPORTDATERANGE AND h.PartnerID = @PartnerID 
GROUP BY h.BrokerName
ORDER BY [DutyPerUnitValue(@CurrencyCode)] DESC'




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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    

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
          N'Average Duty Paid by Broker' , -- Description - nvarchar(100)
          N'This report shows the highest duty paid per unit of declaration value with the related brokers.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          N'Average Duty Paid by Broker' , -- Description - nvarchar(100)
          N'This report shows the highest duty paid per unit of declaration value with the related brokers.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

----------------------------------------------------------Average Duty Paid by Brokers---------------------------------------------------------


------------------------------------Average Duty Paid by Countries of Import----------------------------------------
--DECLARE @sqlguid AS UNIQUEIDENTIFIER
SET @sqlguid = '98232C84-82D1-40D1-A6B1-B54432EF9F02'

--DECLARE @newsqlcmd AS VARCHAR (max)
SET @newsqlcmd = 'SELECT  h.ImportCountry ,
        CAST(SUM(d.EstBaseTotalLineDuty) / SUM(d.EstBaseTotalLineValue) AS NUMERIC(28,
                                                              4)) AS [DutyPerUnitValue(@CurrencyCode)]
FROM    txdGVImportHeader h WITH ( NOLOCK )
        JOIN txdGVImportDetail d WITH ( NOLOCK ) ON h.EntryGuid = d.EntryGuid
                                                    AND h.PartnerID = d.PartnerID
WHERE 1=1 AND @IMPORTDATERANGE AND h.PartnerID = @PartnerID 
GROUP BY h.ImportCountry
HAVING  SUM(d.EstBaseTotalLineValue) > 0
ORDER BY [DutyPerUnitValue(@CurrencyCode)] DESC'



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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    

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
          N'Duty Paid Per Dollar By Import Country' , -- Description - nvarchar(100)
          N'This report shows the highest duty paid per unit of declaration value with the related countries of import.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          N'Duty Paid Per Dollar By Import Country' , -- Description - nvarchar(100)
          N'This report shows the highest duty paid per unit of declaration value with the related countries of import.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

----------------------------------------------------------Average Duty Paid by Countries of Import---------------------------------------------------------


------------------------------------Total Shipment Value by Month----------------------------------------
--DECLARE @sqlguid AS UNIQUEIDENTIFIER
SET @sqlguid = '3660A408-C595-44CA-9F85-8A99A2E8C3DB'

--DECLARE @newsqlcmd AS VARCHAR (max)
SET @newsqlcmd = 'SELECT  CAST(DATEPART(MONTH, ExportDate) AS VARCHAR(50)) + ''-''
        + CAST(DATEPART(YEAR, ExportDate) AS VARCHAR(50)) AS ExportMonth ,
        CAST(SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 2)) AS [EstBaseTotalShipmentValue (@CurrencyCode)]
FROM    txdGVExportHeader h WITH ( NOLOCK )
JOIN dbo.txdGVExportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.ExportGUID = h.ExportGuid
WHERE 1=1 AND @EXPORTDATERANGE AND h.PartnerID = @PartnerID 
GROUP BY YEAR(h.ExportDate) ,
        MONTH(h.ExportDate)
ORDER BY YEAR(h.ExportDate) ,
        MONTH(h.ExportDate)'


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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    

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
          N'Total Shipment Value by Month' , -- Description - nvarchar(100)
          N'This report shows the total value of all exports declared during each month of the selected reporting period.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          N'Total Shipment Value by Month' , -- Description - nvarchar(100)
          N'This report shows the total value of all exports declared during each month of the selected reporting period.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

----------------------------------------------------------Total Shipment Value by Month---------------------------------------------------------


------------------------------------Total Shipment Value by Month - YoY----------------------------------------
--DECLARE @sqlguid AS UNIQUEIDENTIFIER
SET @sqlguid = 'CE917944-4BD4-495F-95A5-A4040742F66F'

--DECLARE @newsqlcmd AS VARCHAR (max)
SET @newsqlcmd = 'SELECT  h.PartnerID ,
        DATEPART(YEAR, ExportDate) AS ExportYear ,
        DATEPART(MONTH, ExportDate) AS ExportMonth ,
        CAST(SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 2)) AS EstBaseTotalLineValue
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
        CAST(SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 2)) AS EstBaseTotalLineValue
INTO    #LastYear
FROM    txdGVExportHeader h WITH (NOLOCK)
JOIN dbo.txdGVExportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.ExportGUID = h.ExportGuid
WHERE   DATEPART(YEAR, ExportDate) = DATEPART(YEAR,
                                              DATEADD(YEAR, -1, GETDATE()))
        AND ExportDate <= ( GETDATE() - 365 )
GROUP BY h.PartnerID ,
        DATEPART(YEAR, ExportDate) ,
        DATEPART(MONTH, ExportDate)
SELECT TOP 10
        h.ExportMonth ,
        ISNULL(SUM(d.EstBaseTotalLineValue), 0) AS [@CurrentYear] ,
        ISNULL(SUM(d2.EstBaseTotalLineValue), 0) AS [@LastYear]
FROM    #CurrentYear d
        LEFT JOIN #LastYear d2 ON h.ExportMonth = h2.ExportMonth
                                  AND h.PartnerID = h2.PartnerID
GROUP BY h.ExportMonth
ORDER BY h.ExportMonth ASC'





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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    

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
          N'Total Shipment Value by Month - YoY' , -- Description - nvarchar(100)
          N'This report shows the total value of all exports declared during each month of the current year compared to the total value of all exports during the same month(s) during the previous year.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          N'Total Shipment Value by Month - YoY' , -- Description - nvarchar(100)
          N'This report shows the total value of all exports declared during each month of the current year compared to the total value of all exports during the same month(s) during the previous year.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

----------------------------------------------------------Total Shipment Value by Month - YoY---------------------------------------------------------


------------------------------------Total Shipment Value By Month (Waterfall)----------------------------------------
--DECLARE @sqlguid AS UNIQUEIDENTIFIER
SET @sqlguid = 'C7973533-1263-4859-A6D0-2AF75FA50508'

--DECLARE @newsqlcmd AS VARCHAR (max)
SET @newsqlcmd = 'SELECT  CAST(DATEPART(MONTH, ExportDate) AS VARCHAR(50)) + ''-''
        + CAST(DATEPART(YEAR, ExportDate) AS VARCHAR(50)) AS ExportMonth ,
        CAST(SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 2)) AS [EstBaseTotalShipmentValue (@CurrencyCode)]
FROM    txdGVExportHeader h WITH ( NOLOCK )
JOIN dbo.txdGVExportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.ExportGUID = h.ExportGuid
WHERE 1=1 AND @EXPORTDATERANGE AND h.PartnerID = @PartnerID 
GROUP BY YEAR(h.ExportDate) ,
        MONTH(h.ExportDate)
ORDER BY YEAR(h.ExportDate) ,
        MONTH(h.ExportDate)'

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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    

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
          N'Total Shipment Value By Month (Waterfall)' , -- Description - nvarchar(100)
          N'This report shows the total value of all exports declared during each month of the selected date range. Each month builds upon the previous month to display the gross total for the period.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          N'Total Shipment Value By Month (Waterfall)' , -- Description - nvarchar(100)
          N'This report shows the total value of all exports declared during each month of the selected date range. Each month builds upon the previous month to display the gross total for the period.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

----------------------------------------------------------Total Shipment Value By Month (Waterfall)---------------------------------------------------------

------------------------------------Total Shipment Value YTD - YoY----------------------------------------
--DECLARE @sqlguid AS UNIQUEIDENTIFIER
SET @sqlguid = 'CE3A088F-0A60-46DF-948D-7DE318FF85B7'

--DECLARE @newsqlcmd AS VARCHAR (max)
SET @newsqlcmd = 'SELECT  h.PartnerID ,
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
WHERE   DATEPART(YEAR, h.ExportDate) = DATEPART(YEAR,
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
WHERE b.PartnerID = @PartnerID'


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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    

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
          N'Total Shipment Value YTD - YoY' , -- Description - nvarchar(100)
          N'This report shows the total value of all exports declared since January 1st of the current calendar year compared to the value of exports during the same time period in the previous year.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          N'Total Shipment Value YTD - YoY' , -- Description - nvarchar(100)
          N'This report shows the total value of all exports declared since January 1st of the current calendar year compared to the value of exports during the same time period in the previous year.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

----------------------------------------------------------Total Shipment Value YTD - YoY---------------------------------------------------------


------------------------------------Total Shipment Value YTD----------------------------------------
--DECLARE @sqlguid AS UNIQUEIDENTIFIER
SET @sqlguid = '23BF348B-2E88-41B2-B730-1EC000BA4244'

--DECLARE @newsqlcmd AS VARCHAR (max)
SET @newsqlcmd = 'SELECT  DATEPART(MONTH, MAX(h.ExportDate)) AS ExportMonth ,
        DATEPART(YEAR, MAX(h.ExportDate)) AS ExportYear ,
        CAST(SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 2)) AS Value
INTO    #YTDTotalShipmentValue
FROM    txdGVExportHeader h WITH ( NOLOCK )
JOIN dbo.txdGVExportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.ExportGUID = h.ExportGuid
WHERE 1=1 AND @ExportDateRange AND h.PartnerID = @PartnerID 
GROUP BY YEAR(h.ExportDate) ,
        MONTH(h.ExportDate)
ORDER BY YEAR(h.ExportDate) ,
        MONTH(h.ExportDate)
SELECT  b.ExportMonth ,
        ( SELECT    SUM(a.Value)
          FROM      #YTDTotalShipmentValue a
          WHERE     ( a.ExportMonth <= b.ExportMonth
                      AND a.ExportYear = b.ExportYear
                    )
                    OR ( a.ExportYear < b.ExportYear )
        ) AS [EstBaseTotalShipmentValue (@CURRENCYCODE)]
FROM    #YTDTotalShipmentValue b'


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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    

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
          N'Total Shipment Value YTD' , -- Description - nvarchar(100)
          N'This report shows the total value of all exports declared since January 1st of the current calendar year.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          N'Total Shipment Value YTD' , -- Description - nvarchar(100)
          N'This report shows the total value of all exports declared since January 1st of the current calendar year.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

----------------------------------------------------------Total Shipment Value YTD---------------------------------------------------------


------------------------------------Total Shipment Value YTD (Waterfall)----------------------------------------
--DECLARE @sqlguid AS UNIQUEIDENTIFIER
SET @sqlguid = '9DA834FA-6E62-4A9D-B275-C4752B18ACF6'

--DECLARE @newsqlcmd AS VARCHAR (max)
SET @newsqlcmd = 'SELECT  DATEPART(MONTH, MAX(h.ExportDate)) AS ExportMonth ,
        DATEPART(YEAR, MAX(h.ExportDate)) AS ExportYear ,
        CAST(SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 2)) AS Value
INTO    #YTDTotalShipmentValue
FROM    txdGVExportHeader h WITH ( NOLOCK )
JOIN dbo.txdGVExportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.ExportGUID = h.ExportGuid
WHERE 1=1 AND @ExportDateRange AND h.PartnerID = @PartnerID 
GROUP BY YEAR(h.ExportDate) ,
        MONTH(h.ExportDate)
ORDER BY YEAR(h.ExportDate) ,
        MONTH(h.ExportDate)
SELECT  b.ExportMonth ,
        ( SELECT    SUM(a.Value)
          FROM      #YTDTotalShipmentValue a
          WHERE     ( a.ExportMonth <= b.ExportMonth
                      AND a.ExportYear = b.ExportYear
                    )
                    OR ( a.ExportYear < b.ExportYear )
        ) AS [EstBaseTotalShipmentValue (@CURRENCYCODE)]
FROM    #YTDTotalShipmentValue b'



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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    


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
          N'Total Shipment Value YTD (Waterfall)' , -- Description - nvarchar(100)
          N'This report shows the total shipment value of all exports declared during each month. Each month builds upon the previous month to display the gross total value since January 1st of the current year.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          N'Total Shipment Value YTD (Waterfall)' , -- Description - nvarchar(100)
          N'This report shows the total shipment value of all exports declared during each month. Each month builds upon the previous month to display the gross total value since January 1st of the current year.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

----------------------------------------------------------Total Shipment Value YTD (Waterfall)---------------------------------------------------------


------------------------------------Total Shipment Value by Quarter - YoY----------------------------------------
--DECLARE @sqlguid AS UNIQUEIDENTIFIER
SET @sqlguid = 'F1F18209-12F2-4F51-8B6C-0BB177A5235F'

--DECLARE @newsqlcmd AS VARCHAR (max)
SET @newsqlcmd = 'SELECT  h.PartnerID ,
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
WHERE   DATEPART(YEAR, ExportDate) = DATEPART(YEAR,
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
ORDER BY h.Value DESC '


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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          N'Total Shipment Value by Quarter - YoY' , -- Description - nvarchar(100)
          N'This report shows the total value of all exports declared during each quarter of the current year compared to the total value of all exports during the same quarter(s) during the previous year.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          N'Total Shipment Value by Quarter - YoY' , -- Description - nvarchar(100)
          N'This report shows the total value of all exports declared during each quarter of the current year compared to the total value of all exports during the same quarter(s) during the previous year.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

----------------------------------------------------------Total Shipment Value by Quarter - YoY---------------------------------------------------------

------------------------------------Total Shipment Weight by Month (Waterfall)----------------------------------------
--DECLARE @sqlguid AS UNIQUEIDENTIFIER
SET @sqlguid = '29EA4D4A-2D60-45EE-8965-F90489391727'

--DECLARE @newsqlcmd AS VARCHAR (max)
SET @newsqlcmd = 'SELECT  CAST(DATEPART(MONTH, ExportDate) AS VARCHAR(50)) + ''-''
        + CAST(DATEPART(YEAR, ExportDate) AS VARCHAR(50)) AS ExportMonth ,
        CAST(SUM(d.NetWeight) AS NUMERIC(28, 0)) AS TotalWeightShipped
FROM    txdGVExportHeader h WITH ( NOLOCK )
JOIN dbo.txdGVExportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.ExportGUID = h.ExportGuid
WHERE 1=1 AND @EXPORTDATERANGE AND h.PartnerID = @PartnerID 
GROUP BY YEAR(h.ExportDate) ,
        MONTH(h.ExportDate)
ORDER BY YEAR(h.ExportDate) ,
        MONTH(h.ExportDate)'


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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          N'Total Shipment Weight by Month (Waterfall)' , -- Description - nvarchar(100)
          N'This report shows the total shipment weight of all exports declared during each month. Each month builds upon the previous month to display the gross total weight for the period.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          N'Total Shipment Weight by Month (Waterfall)' , -- Description - nvarchar(100)
          N'This report shows the total shipment weight of all exports declared during each month. Each month builds upon the previous month to display the gross total weight for the period.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

----------------------------------------------------------Total Shipment Weight by Month (Waterfall)---------------------------------------------------------


------------------------------------Total Shipment Weight by Month----------------------------------------
--DECLARE @sqlguid AS UNIQUEIDENTIFIER
SET @sqlguid = 'BE10374C-A650-4097-8787-C6B81411C58D'

--DECLARE @newsqlcmd AS VARCHAR (max)
SET @newsqlcmd = 'SELECT  CAST(DATEPART(MONTH, ExportDate) AS VARCHAR(50)) + ''-''
        + CAST(DATEPART(YEAR, ExportDate) AS VARCHAR(50)) AS ExportMonth ,
        CAST(SUM(d.NetWeight) AS NUMERIC(28, 0)) AS TotalWeightShipped
FROM    txdGVExportHeader h WITH ( NOLOCK )
JOIN dbo.txdGVExportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.ExportGUID = h.ExportGuid
WHERE 1=1 AND @EXPORTDATERANGE AND h.PartnerID = @PartnerID 
GROUP BY YEAR(h.ExportDate) ,
        MONTH(h.ExportDate)
ORDER BY YEAR(h.ExportDate) ,
        MONTH(h.ExportDate)'

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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          N'Total Shipment Weight by Month' , -- Description - nvarchar(100)
          N'This report shows the total weight of all exports declared during each month of the selected reporting period.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          N'Total Shipment Weight by Month' , -- Description - nvarchar(100)
          N'This report shows the total weight of all exports declared during each month of the selected reporting period.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

----------------------------------------------------------Total Shipment Weight by Month---------------------------------------------------------


------------------------------------Total Shipment Weight by Month - YoY----------------------------------------
--DECLARE @sqlguid AS UNIQUEIDENTIFIER
SET @sqlguid = '76D27B59-E963-4D63-A549-2236E2B19995'

--DECLARE @newsqlcmd AS VARCHAR (max)
SET @newsqlcmd = 'SELECT  h.PartnerID ,
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
WHERE   DATEPART(YEAR, ExportDate) = DATEPART(YEAR,
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
ORDER BY h.ExportMonth ASC'



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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          N'Total Shipment Weight by Month - YoY' , -- Description - nvarchar(100)
          N'This report shows the total weight of all exports declared during each month of the current calendar year compared to the total weight of all exports during the same month(s) of the previous year.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          N'Total Shipment Weight by Month - YoY' , -- Description - nvarchar(100)
          N'This report shows the total weight of all exports declared during each month of the current calendar year compared to the total weight of all exports during the same month(s) of the previous year.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

----------------------------------------------------------Total Shipment Weight by Month - YoY---------------------------------------------------------


------------------------------------Total Shipment Weight YTD - YoY----------------------------------------
--DECLARE @sqlguid AS UNIQUEIDENTIFIER
SET @sqlguid = 'F11EB1B4-822B-4588-9237-42EF69C112BB'

--DECLARE @newsqlcmd AS VARCHAR (max)
SET @newsqlcmd = 'SELECT  h.PartnerID ,
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
WHERE   DATEPART(YEAR, h.ExportDate) = DATEPART(YEAR,
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
WHERE   b.PartnerID = @PartnerID'




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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          N'Total Shipment Weight YTD - YoY' , -- Description - nvarchar(100)
          N'This report shows the total weight of all exports declared since January 1st of the current calendar year compared to the total weight of exports declared during the same time period in the previous year.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          N'Total Shipment Weight YTD - YoY' , -- Description - nvarchar(100)
          N'This report shows the total weight of all exports declared since January 1st of the current calendar year compared to the total weight of exports declared during the same time period in the previous year.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

----------------------------------------------------------Total Shipment Weight YTD - YoY---------------------------------------------------------


------------------------------------Total Shipment Weight YTD----------------------------------------
--DECLARE @sqlguid AS UNIQUEIDENTIFIER
SET @sqlguid = '46B97D2E-2536-4FB2-9EF4-78DE8911876E'

--DECLARE @newsqlcmd AS VARCHAR (max)
SET @newsqlcmd = 'SELECT  DATEPART(MONTH, MAX(h.ExportDate)) AS ExportMonth ,
        DATEPART(YEAR, MAX(h.ExportDate)) AS ExportYear ,
        CAST(SUM(d.NetWeight) AS NUMERIC(28, 0)) AS Weight
INTO    #YTDTotalShipmentWeight
FROM    txdGVExportHeader h WITH ( NOLOCK )
JOIN dbo.txdGVExportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.ExportGUID = h.ExportGuid
WHERE 1=1 AND h.PartnerID = @PartnerID AND @EXPORTDATERANGE 
GROUP BY YEAR(h.ExportDate) ,
        MONTH(h.ExportDate)
ORDER BY YEAR(h.ExportDate) ,
        MONTH(h.ExportDate)
SELECT  b.ExportMonth ,
        ( SELECT    SUM(a.Weight)
          FROM      #YTDTotalShipmentWeight a
          WHERE     ( a.ExportMonth <= b.ExportMonth
                      AND a.ExportYear = b.ExportYear
                    )
                    OR ( a.ExportYear < b.ExportYear )
        ) AS [EstBaseTotalShipmentWeight (@CurrencyCode)]
FROM    #YTDTotalShipmentWeight b'


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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          N'Total Shipment Weight YTD' , -- Description - nvarchar(100)
          N'This report shows the total weight of all exports declared since January 1st of the current calendar year.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          N'Total Shipment Weight YTD' , -- Description - nvarchar(100)
          N'This report shows the total weight of all exports declared since January 1st of the current calendar year.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

----------------------------------------------------------Total Shipment Weight YTD---------------------------------------------------------


------------------------------------Total Shipment Weight YTD (Waterfall)----------------------------------------
--DECLARE @sqlguid AS UNIQUEIDENTIFIER
SET @sqlguid = '33B0E6D0-97DD-45DC-A889-48F9D1E3BA20'

--DECLARE @newsqlcmd AS VARCHAR (max)
SET @newsqlcmd = 'SELECT  DATEPART(MONTH, MAX(h.ExportDate)) AS ExportMonth ,
        DATEPART(YEAR, MAX(h.ExportDate)) AS ExportYear ,
        CAST(SUM(d.NetWeight) AS NUMERIC(28, 0)) AS Weight
INTO    #YTDTotalShipmentWeight
FROM    txdGVExportHeader h WITH ( NOLOCK )
JOIN dbo.txdGVExportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.ExportGUID = h.ExportGuid
WHERE 1=1 AND h.PartnerID = @PartnerID AND @EXPORTDATERANGE 
GROUP BY YEAR(h.ExportDate) ,
        MONTH(h.ExportDate)
ORDER BY YEAR(h.ExportDate) ,
        MONTH(h.ExportDate)
SELECT  b.ExportMonth ,
        ( SELECT    SUM(a.Weight)
          FROM      #YTDTotalShipmentWeight a
          WHERE     ( a.ExportMonth <= b.ExportMonth
                      AND a.ExportYear = b.ExportYear
                    )
                    OR ( a.ExportYear < b.ExportYear )
        ) AS [EstBaseTotalShipmentWeight (@CurrencyCode)]
FROM    #YTDTotalShipmentWeight b'


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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          N'Total Shipment Weight YTD (Waterfall)' , -- Description - nvarchar(100)
          N'This report shows the total shipment weight of all exports declared during each month in the current calendar year. Each month builds upon the previous month to display the gross total weight for the year to date.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          N'Total Shipment Weight YTD (Waterfall)' , -- Description - nvarchar(100)
          N'This report shows the total shipment weight of all exports declared during each month in the current calendar year. Each month builds upon the previous month to display the gross total weight for the year to date.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

----------------------------------------------------------Total Shipment Weight YTD (Waterfall)---------------------------------------------------------


------------------------------------Total Shipment Weight by Quarter----------------------------------------
--DECLARE @sqlguid AS UNIQUEIDENTIFIER
SET @sqlguid = 'FFFFA8DA-FB77-493F-B1AE-0AA89DD2A209'

--DECLARE @newsqlcmd AS VARCHAR (max)
SET @newsqlcmd = 'SELECT  ''Q'' + DATENAME(QUARTER, ExportDate) + ''-''
        + CAST(DATEPART(YEAR, ExportDate) AS VARCHAR(50)) AS ExportQuarter ,
        CAST(SUM(d.NetWeight) AS NUMERIC(28, 0)) AS TotalWeightShipped
FROM    txdGVExportHeader h WITH ( NOLOCK )
JOIN dbo.txdGVExportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.ExportGUID = h.ExportGuid
WHERE 1=1 AND @EXPORTDATERANGE AND h.PartnerID = @PartnerID 
GROUP BY DATEPART(YEAR, ExportDate) ,
        DATENAME(QUARTER, ExportDate)
ORDER BY DATEPART(YEAR, ExportDate) ,
        DATENAME(QUARTER, ExportDate)'



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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          N'Total Shipment Weight by Quarter' , -- Description - nvarchar(100)
          N'This report shows the total weight of all exports declared during each quarter of the selected date range.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          N'Total Shipment Weight by Quarter' , -- Description - nvarchar(100)
          N'This report shows the total weight of all exports declared during each quarter of the selected date range.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

----------------------------------------------------------Total Shipment Weight by Quarter---------------------------------------------------------


------------------------------------Total Shipment Weight by Quarter - YoY----------------------------------------
--DECLARE @sqlguid AS UNIQUEIDENTIFIER
SET @sqlguid = 'FB9214E8-8AE8-4C75-83EC-38F115F2CD75'

--DECLARE @newsqlcmd AS VARCHAR (max)
SET @newsqlcmd = 'SELECT  h.PartnerID ,
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
WHERE   DATEPART(YEAR, ExportDate) = DATEPART(YEAR,
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
ORDER BY h.TotalWeightShipped DESC'




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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          N'Total Shipment Weight by Quarter - YoY' , -- Description - nvarchar(100)
          N'This report shows the total weight of all exports declared during each quarter of the current calendar year compared to the total weight of all exports declared during the same quarter(s) of the previous year.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          N'Total Shipment Weight by Quarter - YoY' , -- Description - nvarchar(100)
          N'This report shows the total weight of all exports declared during each quarter of the current calendar year compared to the total weight of all exports declared during the same quarter(s) of the previous year.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

----------------------------------------------------------Total Shipment Weight by Quarter - YoY---------------------------------------------------------


------------------------------------Total Shipment Weight by Quarter (Waterfall)----------------------------------------
--DECLARE @sqlguid AS UNIQUEIDENTIFIER
SET @sqlguid = '489EDE22-BF93-4707-B3D9-97BF5F25B159'

--DECLARE @newsqlcmd AS VARCHAR (max)
SET @newsqlcmd = 'SELECT  ''Q'' + DATENAME(QUARTER, ExportDate) + ''-''
        + CAST(DATEPART(YEAR, ExportDate) AS VARCHAR(50)) AS ExportQuarter ,
        CAST(SUM(d.NetWeight) AS NUMERIC(28, 0)) AS TotalWeightShipped
FROM    txdGVExportHeader h WITH ( NOLOCK )
JOIN dbo.txdGVExportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.ExportGUID = h.ExportGuid
WHERE 1=1 AND @EXPORTDATERANGE AND h.PartnerID = @PartnerID 
GROUP BY DATEPART(YEAR, ExportDate) ,
        DATENAME(QUARTER, ExportDate)
ORDER BY DATEPART(YEAR, ExportDate) ,
        DATENAME(QUARTER, ExportDate)'

		


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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          N'Total Shipment Weight by Quarter (Waterfall)' , -- Description - nvarchar(100)
          N'This report shows the total weight of all exports declared during each quarter. Each quarter builds upon the previous quarter to display the gross total weight for the reporting period.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          N'Total Shipment Weight by Quarter (Waterfall)' , -- Description - nvarchar(100)
          N'This report shows the total weight of all exports declared during each quarter. Each quarter builds upon the previous quarter to display the gross total weight for the reporting period.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

----------------------------------------------------------Total Shipment Weight by Quarter (Waterfall)---------------------------------------------------------


------------------------------------All Hazardous Material Shipped by Port of Unlading----------------------------------------
--DECLARE @sqlguid AS UNIQUEIDENTIFIER
SET @sqlguid = '2A554C1D-A555-44DE-9E3F-A550BEA0EBB3'

--DECLARE @newsqlcmd AS VARCHAR (max)
SET @newsqlcmd = 'SELECT  h.PortOfUnlading ,
        CAST(SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 2)) AS [EstBaseTotalShipmentValue(@CurrencyCode)] ,
        COUNT(h.HazMatFlag) AS TotalHazMatVolume ,
        CAST(SUM(d.EstBaseTotalLineValue) / COUNT(h.HazMatFlag) AS NUMERIC(28,
                                                              2)) AS [EstBaseAvgValuePerDeclaration(@CurrencyCode)]
FROM    txdGVExportHeader h WITH ( NOLOCK )
JOIN dbo.txdGVExportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.ExportGUID = h.ExportGuid
WHERE 1=1 AND @EXPORTDATERANGE 
AND h.HazMatFlag = ''Y'' 
AND h.PartnerID = @PartnerID 
GROUP BY h.PortOfUnlading
ORDER BY SUM(d.EstBaseTotalLineValue) DESC'



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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          N'All Hazardous Material Shipped by Port of Unlading' , -- Description - nvarchar(100)
          N'This report shows all Ports of Unlading associated with the shipment of hazardous material, the estimated base total Shipment Value of all shipments during the period, the total number of shipments of that Port of Unlading during the period, and the estimated base average value per declaration for each Port of Unlading.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          N'All Hazardous Material Shipped by Port of Unlading' , -- Description - nvarchar(100)
          N'This report shows all Ports of Unlading associated with the shipment of hazardous material, the estimated base total Shipment Value of all shipments during the period, the total number of shipments of that Port of Unlading during the period, and the estimated base average value per declaration for each Port of Unlading.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

----------------------------------------------------------All Hazardous Material Shipped by Port of Unlading ---------------------------------------------------------



------------------------------------All Hazardous Material Shipped by Port of Lading ----------------------------------------
--DECLARE @sqlguid AS UNIQUEIDENTIFIER
SET @sqlguid = '52812B0F-5C78-4AD1-9357-4F3EB95D2A8E'

--DECLARE @newsqlcmd AS VARCHAR (max)
SET @newsqlcmd = 'SELECT  h.PortOfLading ,
        CAST(SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 2)) AS [EstBaseTotalShipmentValue(@CurrencyCode)] ,
        COUNT(h.HazMatFlag) AS TotalHazMatVolume ,
        CAST(SUM(d.EstBaseTotalLineValue) / COUNT(h.HazMatFlag) AS NUMERIC(28,
                                                              2)) AS [EstBaseAvgValuePerDeclaration(@CurrencyCode)]
FROM    txdGVExportHeader h WITH ( NOLOCK )
JOIN dbo.txdGVExportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.ExportGUID = h.ExportGuid
WHERE 1=1 AND @EXPORTDATERANGE 
AND h.HazMatFlag = ''Y'' 
AND h.PartnerID = @PartnerID 
GROUP BY h.PortOfLading
ORDER BY SUM(d.EstBaseTotalLineValue) DESC'


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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          N'All Hazardous Material Shipped by Port of Lading' , -- Description - nvarchar(100)
          N'This report shows all Ports of Lading associated with the shipment of hazardous material, the estimated base total Shipment Value of all shipments during the period, the total number of shipments of that Port of Lading during the period, and the estimated base average value per declaration for each Port of Lading.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          N'All Hazardous Material Shipped by Port of Lading' , -- Description - nvarchar(100)
          N'This report shows all Ports of Lading associated with the shipment of hazardous material, the estimated base total Shipment Value of all shipments during the period, the total number of shipments of that Port of Lading during the period, and the estimated base average value per declaration for each Port of Lading.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

----------------------------------------------------------All Hazardous Material Shipped by Port of Lading ---------------------------------------------------------


------------------------------------All Hazardous Material Shipped by Carrier----------------------------------------
--DECLARE @sqlguid AS UNIQUEIDENTIFIER
SET @sqlguid = '76E4D27E-40F5-473D-966D-319B33E51FAA'

--DECLARE @newsqlcmd AS VARCHAR (max)
SET @newsqlcmd = 'SELECT  h.CarrierName ,
        CAST(SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 2)) AS [EstBaseTotalShipmentValue(@CurrencyCode)] ,
        COUNT(h.HazMatFlag) AS TotalHazMatVolume ,
        CAST(SUM(d.EstBaseTotalLineValue) / COUNT(h.HazMatFlag) AS NUMERIC(28,
                                                              2)) AS [EstBaseAvgValuePerDeclaration(@CurrencyCode)]
FROM    txdGVExportHeader h WITH ( NOLOCK )
JOIN dbo.txdGVExportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.ExportGUID = h.ExportGuid
WHERE 1=1 AND @EXPORTDATERANGE 
AND h.HazMatFlag = ''Y'' 
AND h.PartnerID = @PartnerID 
GROUP BY h.CarrierName
ORDER BY SUM(d.EstBaseTotalLineValue) DESC'



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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          N'All Hazardous Material Shipped by Carrier' , -- Description - nvarchar(100)
          N'This report shows all Carriers associated with the shipment of hazardous material, the estimated base total Shipment Value of all shipments during the period, the total number of shipments of that Carrier during the period, and the estimated base average value per declaration for each Carrier.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          N'All Hazardous Material Shipped by Carrier' , -- Description - nvarchar(100)
          N'This report shows all Carriers associated with the shipment of hazardous material, the estimated base total Shipment Value of all shipments during the period, the total number of shipments of that Carrier during the period, and the estimated base average value per declaration for each Carrier.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

----------------------------------------------------------All Hazardous Material Shipped by Carrier ---------------------------------------------------------



------------------------------------All Hazardous Material Shipped by Forwarder ----------------------------------------
--DECLARE @sqlguid AS UNIQUEIDENTIFIER
SET @sqlguid = 'C1E13EC8-6033-4521-BA48-285C41CD142A'

--DECLARE @newsqlcmd AS VARCHAR (max)
SET @newsqlcmd = 'SELECT  h.ForwarderCompanyName ,
        CAST(SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 2)) AS [EstBaseTotalShipmentValue(@CurrencyCode)] ,
        COUNT(h.HazMatFlag) AS TotalHazMatVolume ,
        CAST(SUM(d.EstBaseTotalLineValue) / COUNT(h.HazMatFlag) AS NUMERIC(28,
                                                              2)) AS [EstBaseAvgValuePerDeclaration(@CurrencyCode)]
FROM    txdGVExportHeader h WITH ( NOLOCK )
JOIN dbo.txdGVExportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.ExportGUID = h.ExportGuid
WHERE 1=1 AND @EXPORTDATERANGE 
AND h.HazMatFlag = ''Y'' 
AND h.PartnerID = @PartnerID 
GROUP BY h.ForwarderCompanyName
ORDER BY SUM(d.EstBaseTotalLineValue) DESC'



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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          N'All Hazardous Material Shipped by Forwarder' , -- Description - nvarchar(100)
          N'This report shows all Forwarders associated with the shipment of hazardous material, the estimated base total Shipment vValue of all shipments during the period, the total number of shipments of that Forwarder during the period, and the estimated base average value per declaration for each Forwarder.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          N'All Hazardous Material Shipped by Forwarder' , -- Description - nvarchar(100)
          N'This report shows all Forwarders associated with the shipment of hazardous material, the estimated base total Shipment vValue of all shipments during the period, the total number of shipments of that Forwarder during the period, and the estimated base average value per declaration for each Forwarder.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

----------------------------------------------------------All Hazardous Material Shipped by Forwarder ---------------------------------------------------------


------------------------------------All Hazardous Material Shipped by Export Country----------------------------------------
--DECLARE @sqlguid AS UNIQUEIDENTIFIER
SET @sqlguid = '0C2D382E-E358-48DE-9095-F4DE1B576CBD'

--DECLARE @newsqlcmd AS VARCHAR (max)
SET @newsqlcmd = 'SELECT  h.ExportCountry ,
        CAST(SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 2)) AS [EstBaseTotalShipmentValue(@CurrencyCode)] ,
        COUNT(h.HazMatFlag) AS TotalHazMatVolume ,
        CAST(SUM(d.EstBaseTotalLineValue) / COUNT(h.HazMatFlag) AS NUMERIC(28,
                                                              2)) AS [EstBaseAvgValuePerDeclaration(@CurrencyCode)]
FROM    txdGVExportHeader h WITH ( NOLOCK )
JOIN dbo.txdGVExportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.ExportGUID = h.ExportGuid
WHERE 1=1 AND @EXPORTDATERANGE 
AND h.HazMatFlag = ''Y'' 
AND h.PartnerID = @PartnerID   
GROUP BY h.ExportCountry
ORDER BY SUM(d.EstBaseTotalLineValue) DESC'


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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          N'All Hazardous Material Shipped by Export Country' , -- Description - nvarchar(100)
          N'This report shows all Export Countries associated with the shipment of hazardous material, the estimated base total Shipment Value of all shipments during the period, the total number of shipments of that Export Country during the period, and the estimated base average value per declaration for each Export Country.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          N'All Hazardous Material Shipped by Export Country' , -- Description - nvarchar(100)
          N'This report shows all Export Countries associated with the shipment of hazardous material, the estimated base total Shipment Value of all shipments during the period, the total number of shipments of that Export Country during the period, and the estimated base average value per declaration for each Export Country.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

----------------------------------------------------------All Hazardous Material Shipped by Export Country---------------------------------------------------------



------------------------------------Hazardous Material Exported by Export Country - YoY----------------------------------------
--DECLARE @sqlguid AS UNIQUEIDENTIFIER
SET @sqlguid = 'CC401E6E-8FF9-46DB-B90F-C6A22837834B'

--DECLARE @newsqlcmd AS VARCHAR (max)
SET @newsqlcmd = 'SELECT  h.PartnerID ,
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
WHERE   DATEPART(YEAR, ExportDate) = DATEPART(YEAR,
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
ORDER BY SUM(d.EstBaseTotalShipmentValue) DESC'




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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          N'Hazardous Material Exported by Export Country - YoY' , -- Description - nvarchar(100)
          N'This comparison report shows the Export Countries with the  associated total value of hazardous materials on all shipments filed for the current year compared to the total value of hazardous materials on all shipments exported out of the same countries the previous year. ' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          N'Hazardous Material Exported by Export Country - YoY' , -- Description - nvarchar(100)
          N'This comparison report shows the Export Countries with the  associated total value of hazardous materials on all shipments filed for the current year compared to the total value of hazardous materials on all shipments exported out of the same countries the previous year. ' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

----------------------------------------------------------Hazardous Material Exported by Export Country - YoY---------------------------------------------------------



------------------------------------All Hazardous Material Shipped by Mode of Transport----------------------------------------
--DECLARE @sqlguid AS UNIQUEIDENTIFIER
SET @sqlguid = '8633C98E-8021-4B73-A7D0-7ED9A756148C'

--DECLARE @newsqlcmd AS VARCHAR (max)
SET @newsqlcmd = 'SELECT  h.ModeOfTransport ,
        CAST(SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 2)) AS [EstBaseTotalShipmentValue(@CurrencyCode)] ,
        COUNT(h.HazMatFlag) AS TotalHazMatVolume ,
        CAST(SUM(d.EstBaseTotalLineValue) / COUNT(h.HazMatFlag) AS NUMERIC(28,
                                                              2)) AS [EstBaseAvgValuePerDeclaration(@CurrencyCode)]
FROM    txdGVExportHeader h WITH ( NOLOCK )
JOIN dbo.txdGVExportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.ExportGUID = h.ExportGuid
WHERE 1=1 AND @EXPORTDATERANGE 
AND h.HazMatFlag = ''Y'' 
AND h.PartnerID = @PartnerID 
GROUP BY h.ModeOfTransport
ORDER BY SUM(d.EstBaseTotalLineValue) DESC'



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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          N'All Hazardous Material Shipped by Mode of Transport' , -- Description - nvarchar(100)
          N'This report shows all Modes of Transport associated with the shipment of hazardous material, the estimated base total Shipment Value of all shipments during the period, the total number of shipments of that Mode of Transport during the period, and the estimated base average value per declaration for each Mode of Transport.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          N'All Hazardous Material Shipped by Mode of Transport' , -- Description - nvarchar(100)
          N'This report shows all Modes of Transport associated with the shipment of hazardous material, the estimated base total Shipment Value of all shipments during the period, the total number of shipments of that Mode of Transport during the period, and the estimated base average value per declaration for each Mode of Transport.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

----------------------------------------------------------All Hazardous Material Shipped by Mode of Transport---------------------------------------------------------


------------------------------------All Hazardous Material Exported by ECN Number----------------------------------------
--DECLARE @sqlguid AS UNIQUEIDENTIFIER
SET @sqlguid = '3EC59AC2-86AE-4537-B62C-43F01E49122E'

--DECLARE @newsqlcmd AS VARCHAR (max)
SET @newsqlcmd = 'SELECT TOP 10
        d.ECNNum ,
        CAST(SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 2)) AS [EstBaseTotalShipmentValue(@CurrencyCode)] ,
        COUNT(DISTINCT d.ExportGUID) AS TotalShipments ,
        CAST(SUM(d.EstBaseTotalLineValue) / COUNT(DISTINCT d.ExportGUID) AS NUMERIC(28,
                                                              2)) AS [EstBaseAvgValuePerShipment(@CurrencyCode)]
FROM    txdGVExportHeader h WITH ( NOLOCK )
        JOIN txdGVExportDetail d WITH ( NOLOCK ) ON h.ExportGuid = d.ExportGUID
                                                    AND h.PartnerID = d.PartnerID
WHERE 1=1 AND @EXPORTDATERANGE 
AND d.HazMatFlag = ''Y''  
AND h.PartnerID = @PartnerID 
GROUP BY d.ECNNum
ORDER BY SUM(d.EstBaseTotalLineValue) DESC'




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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          N'All Hazardous Material Exported by ECN Number' , -- Description - nvarchar(100)
          N'This report shows all ECN Numbers associated with the shipment of hazardous material, the estimated base total Shipment Value of all shipments during the period, the total number of shipments of that ECN during the period, and the estimated base average value per declaration for each ECN Number.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          N'All Hazardous Material Exported by ECN Number' , -- Description - nvarchar(100)
          N'This report shows all ECN Numbers associated with the shipment of hazardous material, the estimated base total Shipment Value of all shipments during the period, the total number of shipments of that ECN during the period, and the estimated base average value per declaration for each ECN Number.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

----------------------------------------------------------All Hazardous Material Exported by ECN Number---------------------------------------------------------


------------------------------------All Hazardous Material Shipped by Import Country ----------------------------------------
--DECLARE @sqlguid AS UNIQUEIDENTIFIER
SET @sqlguid = 'BDF8FB24-DB86-4038-BF49-E8086800D6DA'

--DECLARE @newsqlcmd AS VARCHAR (max)
SET @newsqlcmd = 'SELECT  h.ImportCountry ,
        CAST(SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 2)) AS [EstBaseTotalShipmentValue(@CurrencyCode)] ,
        COUNT(h.HazMatFlag) AS TotalHazMatVolume ,
        CAST(SUM(d.EstBaseTotalLineValue) / COUNT(h.HazMatFlag) AS NUMERIC(28,
                                                              2)) AS [EstBaseAvgValuePerDeclaration(@CurrencyCode)]
FROM    txdGVExportHeader h WITH ( NOLOCK )
JOIN dbo.txdGVExportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.ExportGUID = h.ExportGuid
WHERE 1=1 AND @EXPORTDATERANGE 
AND h.HazMatFlag = ''Y'' 
AND h.PartnerID = @PartnerID 
GROUP BY h.ImportCountry
ORDER BY SUM(d.EstBaseTotalLineValue) DESC'


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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          N'All Hazardous Material Shipped by Import Country ' , -- Description - nvarchar(100)
          N'This report shows all Import Countries associated with the shipment of hazardous material, the estimated base total Shipment Value of all shipments during the period, the total number of shipments of that Import Country during the period, and the estimated base average value per declaration for each Import Country.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          N'All Hazardous Material Shipped by Import Country ' , -- Description - nvarchar(100)
          N'This report shows all Import Countries associated with the shipment of hazardous material, the estimated base total Shipment Value of all shipments during the period, the total number of shipments of that Import Country during the period, and the estimated base average value per declaration for each Import Country.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

----------------------------------------------------------All Hazardous Material Shipped by Import Country ---------------------------------------------------------


------------------------------------All Hazardous Material Exported by Business Division----------------------------------------
--DECLARE @sqlguid AS UNIQUEIDENTIFIER
SET @sqlguid = 'CCF10932-336C-4AEF-ACC6-CB931D5F0158'

--DECLARE @newsqlcmd AS VARCHAR (max)
SET @newsqlcmd = 'SELECT TOP 10
        d.BusinessUnit ,
        CAST(SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 2)) AS [EstBaseTotalShipmentValue(@CurrencyCode)] ,
        COUNT(DISTINCT d.ExportGUID) AS TotalShipments ,
        CAST(SUM(d.EstBaseTotalLineValue) / COUNT(DISTINCT d.ExportGUID) AS NUMERIC(28,
                                                              2)) AS [EstBaseAvgValuePerShipment(@CurrencyCode)]
FROM    txdGVExportHeader h WITH ( NOLOCK )
        JOIN txdGVExportDetail d WITH ( NOLOCK ) ON h.ExportGuid = d.ExportGUID
                                                    AND h.PartnerID = d.PartnerID
WHERE 1=1 AND @EXPORTDATERANGE 
AND d.HazMatFlag = ''Y''  
AND h.PartnerID = @PartnerID 
GROUP BY d.BusinessUnit
ORDER BY SUM(d.EstBaseTotalLineValue) DESC'



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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          N'All Hazardous Material Exported by Business Division' , -- Description - nvarchar(100)
          N'This report shows all Business Divisions associated with the shipment of hazardous material, the estimated base total Shipment Value of all shipments during the period, the total number of shipments of that Business Division during the period, and the estimated base average value per declaration for each Business Division.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          N'All Hazardous Material Exported by Business Division' , -- Description - nvarchar(100)
          N'This report shows all Business Divisions associated with the shipment of hazardous material, the estimated base total Shipment Value of all shipments during the period, the total number of shipments of that Business Division during the period, and the estimated base average value per declaration for each Business Division.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

----------------------------------------------------------All Hazardous Material Exported by Business Division---------------------------------------------------------


------------------------------------All Hazardous Material Exported by Export Tariff Number----------------------------------------
--DECLARE @sqlguid AS UNIQUEIDENTIFIER
SET @sqlguid = '7868300B-88DE-4C51-B646-D4B7C630DA3B'

--DECLARE @newsqlcmd AS VARCHAR (max)
SET @newsqlcmd = 'SELECT  d.ExportTariffNum AS ExportTariffNumber ,
        CAST(SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 2)) AS [EstBaseTotalShipmentValue(@CurrencyCode)] ,
        COUNT(DISTINCT d.ExportGUID) AS TotalShipments ,
        CAST(SUM(d.EstBaseTotalLineValue) / COUNT(DISTINCT d.ExportGUID) AS NUMERIC(28,
                                                              2)) AS [EstBaseAvgValuePerShipment(@CurrencyCode)]
FROM    txdGVExportHeader h WITH ( NOLOCK )
        JOIN txdGVExportDetail d WITH ( NOLOCK ) ON h.ExportGuid = d.ExportGUID
                                                    AND h.PartnerID = d.PartnerID
WHERE 1=1 AND @EXPORTDATERANGE 
AND d.HazMatFlag = ''Y''  
AND h.PartnerID = @PartnerID 
GROUP BY d.ExportTariffNum
ORDER BY SUM(d.EstBaseTotalLineValue) DESC'



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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          N'All Hazardous Material Exported by Export Tariff Number' , -- Description - nvarchar(100)
          N'This report shows all Export Tariff Numbers associated with the shipment of hazardous material, the estimated base total Shipment Value of all shipments during the period, the total number of shipments of that Export Tariff Number during the period, and the estimated base average value per declaration for each Export Tariff Number.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          N'All Hazardous Material Exported by Export Tariff Number' , -- Description - nvarchar(100)
          N'This report shows all Export Tariff Numbers associated with the shipment of hazardous material, the estimated base total Shipment Value of all shipments during the period, the total number of shipments of that Export Tariff Number during the period, and the estimated base average value per declaration for each Export Tariff Number.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

----------------------------------------------------------All Hazardous Material Exported by Export Tariff Number---------------------------------------------------------



------------------------------------Total Declaration Duty YTD----------------------------------------
--DECLARE @sqlguid AS UNIQUEIDENTIFIER
SET @sqlguid = 'E1F7969C-3882-4DC2-B255-D8345B89628E'

--DECLARE @newsqlcmd AS VARCHAR (max)
SET @newsqlcmd = 'SELECT  DATEPART(YEAR, MAX(h.ImportDate)) AS ImportYear ,
        DATEPART(MONTH, MAX(h.ImportDate)) AS ImportMonth ,
        CAST(SUM(d.EstBaseTotalLineDuty) AS NUMERIC(28, 2)) AS TotalDeclarationDuty
INTO    #YTDTotalDeclarationDuty
FROM    txdGVImportHeader h WITH ( NOLOCK )
JOIN dbo.txdGVImportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.EntryGuid = h.EntryGuid
WHERE 1=1 AND h.PartnerID = @PartnerID AND @IMPORTDATERANGE 
GROUP BY YEAR(h.ImportDate) ,
        MONTH(h.ImportDate)
ORDER BY YEAR(h.ImportDate) ,
        MONTH(h.ImportDate)
SELECT  b.ImportMonth ,
        ( SELECT    SUM(a.TotalDeclarationDuty)
          FROM      #YTDTotalDeclarationDuty a
          WHERE     ( a.ImportMonth <= b.ImportMonth
                      AND a.ImportYear = b.ImportYear
                    )
                    OR ( a.ImportYear < b.ImportYear )
        ) AS [EstBaseTotalDuty (@CurrencyCode)]
FROM    #YTDTotalDeclarationDuty b'



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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          N'Total Declaration Duty YTD' , -- Description - nvarchar(100)
          N'This report shows the total declaration duty paid year-to-date.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          N'Total Declaration Duty YTD' , -- Description - nvarchar(100)
          N'This report shows the total declaration duty paid year-to-date.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

----------------------------------------------------------Total Declaration Duty YTD---------------------------------------------------------


------------------------------------Total Declaration Duty YTD - YoY----------------------------------------
--DECLARE @sqlguid AS UNIQUEIDENTIFIER
SET @sqlguid = 'A6F4A464-054E-4FE2-977C-7480DAC172E5'

--DECLARE @newsqlcmd AS VARCHAR (max)
SET @newsqlcmd = 'SELECT  h.PartnerID ,
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
WHERE   DATEPART(YEAR, h.ImportDate) = DATEPART(YEAR,
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
WHERE b.PartnerID = @PartnerID'



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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          N'Total Declaration Duty YTD - YoY' , -- Description - nvarchar(100)
          N'This comparison report shows the total declaration duty paid year-to-date for the current year compared to the total declaration duty paid year-to-date for the previous year.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          N'Total Declaration Duty YTD - YoY' , -- Description - nvarchar(100)
          N'This comparison report shows the total declaration duty paid year-to-date for the current year compared to the total declaration duty paid year-to-date for the previous year.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

----------------------------------------------------------Total Declaration Duty YTD - YoY---------------------------------------------------------


------------------------------------Total Declaration Duty YTD (Waterfall)----------------------------------------
--DECLARE @sqlguid AS UNIQUEIDENTIFIER
SET @sqlguid = '21A6083E-725D-45BE-BB1F-DDB841D9064B'

--DECLARE @newsqlcmd AS VARCHAR (max)
SET @newsqlcmd = 'SELECT  DATEPART(YEAR, MAX(h.ImportDate)) AS ImportYear ,
        DATEPART(MONTH, MAX(h.ImportDate)) AS ImportMonth ,
        CAST(SUM(d.EstBaseTotalLineDuty) AS NUMERIC(28, 2)) AS TotalDeclarationDuty
INTO    #YTDTotalDeclarationDuty
FROM    txdGVImportHeader h WITH ( NOLOCK )
JOIN dbo.txdGVImportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.EntryGuid = h.EntryGuid
WHERE 1=1 AND h.PartnerID = @PartnerID AND @IMPORTDATERANGE 
GROUP BY YEAR(h.ImportDate) ,
        MONTH(h.ImportDate)
ORDER BY YEAR(h.ImportDate) ,
        MONTH(h.ImportDate)
SELECT  b.ImportMonth ,
        ( SELECT    SUM(a.TotalDeclarationDuty)
          FROM      #YTDTotalDeclarationDuty a
          WHERE     ( a.ImportMonth <= b.ImportMonth
                      AND a.ImportYear = b.ImportYear
                    )
                    OR ( a.ImportYear < b.ImportYear )
        ) AS [EstBaseTotalDuty (@CurrencyCode)]
FROM    #YTDTotalDeclarationDuty b'



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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          N'Total Declaration Duty YTD (Waterfall)' , -- Description - nvarchar(100)
          N'This report shows the total declaration duty paid year-to-date.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          N'Total Declaration Duty YTD (Waterfall)' , -- Description - nvarchar(100)
          N'This report shows the total declaration duty paid year-to-date.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

----------------------------------------------------------Total Declaration Duty YTD (Waterfall)---------------------------------------------------------


------------------------------------Total Declaration Duty by Quarter (Waterfall)----------------------------------------
--DECLARE @sqlguid AS UNIQUEIDENTIFIER
SET @sqlguid = '9952AE8E-95E8-47A4-8065-E72D3B88E5E8'

--DECLARE @newsqlcmd AS VARCHAR (max)
SET @newsqlcmd = 'SELECT  ''Q'' + DATENAME(QUARTER, ImportDate) + ''-''
        + CAST(DATEPART(YEAR, ImportDate) AS VARCHAR(50)) AS ImportQuarter ,
        CAST(SUM(d.EstBaseTotalLineDuty) AS NUMERIC(28, 2)) AS [EstBaseTotalDuty (@CurrencyCode)]
FROM    txdGVImportHeader h WITH ( NOLOCK )
JOIN dbo.txdGVImportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.EntryGuid = h.EntryGuid
WHERE 1=1 AND @IMPORTDATERANGE AND h.PartnerID = @PartnerID 
GROUP BY h.PartnerID ,
        DATEPART(YEAR, ImportDate) ,
        DATENAME(QUARTER, ImportDate)
ORDER BY DATEPART(YEAR, ImportDate) ,
        DATENAME(QUARTER, ImportDate)'



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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          N'Total Declaration Duty by Quarter (Waterfall)' , -- Description - nvarchar(100)
          N'This report shows the total declaration duty paid by quarter.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          N'Total Declaration Duty by Quarter (Waterfall)' , -- Description - nvarchar(100)
          N'This report shows the total declaration duty paid by quarter.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

----------------------------------------------------------Total Declaration Duty by Quarter (Waterfall)---------------------------------------------------------


------------------------------------Total Declaration Duty By Quarter - YoY----------------------------------------
--DECLARE @sqlguid AS UNIQUEIDENTIFIER
SET @sqlguid = 'A96C2F66-FD2C-4085-BFD9-088A8ECB8789'

--DECLARE @newsqlcmd AS VARCHAR (max)
SET @newsqlcmd = 'SELECT  h.PartnerID ,
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
WHERE   DATEPART(YEAR, ImportDate) = DATEPART(YEAR,
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
        SUM(y.TotalDeclarationDuty) DESC'



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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          N'Total Declaration Duty By Quarter - YoY' , -- Description - nvarchar(100)
          N'This comparison report shows the total declaration duty paid by quarter for the current year compared to the total declaration duty paid by quarter for the previous year. ' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          N'Total Declaration Duty By Quarter - YoY' , -- Description - nvarchar(100)
          N'This comparison report shows the total declaration duty paid by quarter for the current year compared to the total declaration duty paid by quarter for the previous year. ' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

----------------------------------------------------------Total Declaration Duty By Quarter - YoY---------------------------------------------------------



------------------------------------Total Declaration Duty By Quarter----------------------------------------
--DECLARE @sqlguid AS UNIQUEIDENTIFIER
SET @sqlguid = '0E312F4E-6897-4FB6-AB38-7D3CE1B59F0A'

--DECLARE @newsqlcmd AS VARCHAR (max)
SET @newsqlcmd = 'SELECT  ''Q'' + DATENAME(QUARTER, ImportDate) + ''-''
        + CAST(DATEPART(YEAR, ImportDate) AS VARCHAR(50)) AS ImportQuarter ,
        CAST(SUM(d.EstBaseTotalLineDuty) AS NUMERIC(28, 2)) AS [EstBaseTotalDuty (@CurrencyCode)]
FROM    txdGVImportHeader h WITH ( NOLOCK )
JOIN dbo.txdGVImportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.EntryGuid = h.EntryGuid
WHERE 1=1 AND @IMPORTDATERANGE AND h.PartnerID = @PartnerID 
GROUP BY h.PartnerID ,
        DATEPART(YEAR, ImportDate) ,
        DATENAME(QUARTER, ImportDate)
ORDER BY DATEPART(YEAR, ImportDate) ,
        DATENAME(QUARTER, ImportDate)'



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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          N'Total Declaration Duty By Quarter' , -- Description - nvarchar(100)
          N'This report shows the total declaration duty paid by quarter. ' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          N'Total Declaration Duty By Quarter' , -- Description - nvarchar(100)
          N'This report shows the total declaration duty paid by quarter. ' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

----------------------------------------------------------Total Declaration Duty By Quarter---------------------------------------------------------


------------------------------------Top Declaration Duty by Month----------------------------------------
--DECLARE @sqlguid AS UNIQUEIDENTIFIER
SET @sqlguid = '9537C26A-B847-4063-9629-918721518099'

--DECLARE @newsqlcmd AS VARCHAR (max)
SET @newsqlcmd = 'SELECT TOP 10
        CAST(DATEPART(MONTH, ImportDate) AS VARCHAR(50)) + ''-''
        + CAST(DATEPART(YEAR, ImportDate) AS VARCHAR(50)) AS ImportMonth ,
        CAST(SUM(d.EstBaseTotalLineDuty) AS NUMERIC(28, 2)) AS [EstBaseTotalDuty (@CurrencyCode)]
FROM    txdGVImportHeader h WITH ( NOLOCK )
JOIN dbo.txdGVImportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.EntryGuid = h.EntryGuid
WHERE 1=1 AND @IMPORTDATERANGE AND h.PartnerID = @PartnerID 
GROUP BY YEAR(h.ImportDate) ,
        MONTH(h.ImportDate)
ORDER BY YEAR(h.ImportDate) ,
        MONTH(h.ImportDate)'



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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          N'Top Declaration Duty by Month' , -- Description - nvarchar(100)
          N'' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          N'Top Declaration Duty by Month' , -- Description - nvarchar(100)
          N'' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

----------------------------------------------------------Top Declaration Duty by Month---------------------------------------------------------


------------------------------------Total Declaration Duty By Month----------------------------------------
--DECLARE @sqlguid AS UNIQUEIDENTIFIER
SET @sqlguid = '875B9E37-923D-4F4D-BEFC-32EDE8092C4E'

--DECLARE @newsqlcmd AS VARCHAR (max)
SET @newsqlcmd = 'SELECT  CAST(DATEPART(MONTH, ImportDate) AS VARCHAR(50)) + ''-''
        + CAST(DATEPART(YEAR, ImportDate) AS VARCHAR(50)) AS ImportMonth ,
        CAST(SUM(d.EstBaseTotalLineDuty) AS NUMERIC(28, 2)) AS [EstBaseTotalDuty (@CurrencyCode)]
FROM    txdGVImportHeader h WITH ( NOLOCK )
JOIN dbo.txdGVImportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.EntryGuid = h.EntryGuid
WHERE 1=1 AND @IMPORTDATERANGE AND h.PartnerID = @PartnerID 
GROUP BY YEAR(h.ImportDate) ,
        MONTH(h.ImportDate)
ORDER BY YEAR(h.ImportDate) ,
        MONTH(h.ImportDate)'



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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          N'Total Declaration Duty By Month' , -- Description - nvarchar(100)
          N'This report shows the total declaration duty paid by month. ' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          N'Total Declaration Duty By Month' , -- Description - nvarchar(100)
          N'This report shows the total declaration duty paid by month. ' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

----------------------------------------------------------Total Declaration Duty By Month---------------------------------------------------------


------------------------------------Total Declaration Duty By Month - YoY----------------------------------------
--DECLARE @sqlguid AS UNIQUEIDENTIFIER
SET @sqlguid = 'EE24F97D-B7CC-4C5B-AD98-FF3B7C1C427D'

--DECLARE @newsqlcmd AS VARCHAR (max)
SET @newsqlcmd = 'SELECT  h.PartnerID ,
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
WHERE   DATEPART(YEAR, ImportDate) = DATEPART(YEAR,
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
        y.TotalDeclarationDuty DESC'



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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          N'Total Declaration Duty By Month - YoY' , -- Description - nvarchar(100)
          N'This comparison report shows the total declaration duty paid by month for the current year compared to the total declaration duty paid by month for the previous year.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          N'Total Declaration Duty By Month - YoY' , -- Description - nvarchar(100)
          N'This comparison report shows the total declaration duty paid by month for the current year compared to the total declaration duty paid by month for the previous year.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

----------------------------------------------------------Total Declaration Duty By Month - YoY---------------------------------------------------------


------------------------------------Total Declaration Duty by Month (Waterfall)----------------------------------------
--DECLARE @sqlguid AS UNIQUEIDENTIFIER
SET @sqlguid = '3D2DEA0C-C85C-4F03-8EEF-7E4EB2A2A032'

--DECLARE @newsqlcmd AS VARCHAR (max)
SET @newsqlcmd = 'SELECT  CAST(DATEPART(MONTH, ImportDate) AS VARCHAR(50)) + ''-''
        + CAST(DATEPART(YEAR, ImportDate) AS VARCHAR(50)) AS ImportMonth ,
        CAST(SUM(d.EstBaseTotalLineDuty) AS NUMERIC(28, 2)) AS [EstBaseTotalDuty (@CurrencyCode)]
FROM    txdGVImportHeader h WITH ( NOLOCK )
JOIN dbo.txdGVImportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.EntryGuid = h.EntryGuid
WHERE 1=1 AND @IMPORTDATERANGE AND h.PartnerID = @PartnerID 
GROUP BY YEAR(h.ImportDate) ,
        MONTH(h.ImportDate)
ORDER BY YEAR(h.ImportDate) ,
        MONTH(h.ImportDate)'


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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          N'Total Declaration Duty by Month (Waterfall)' , -- Description - nvarchar(100)
          N'This report shows the total declaration duty paid by month.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          N'Total Declaration Duty by Month (Waterfall)' , -- Description - nvarchar(100)
          N'This report shows the total declaration duty paid by month.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

----------------------------------------------------------Total Declaration Duty by Month (Waterfall)---------------------------------------------------------


------------------------------------Value and Volume of Mode of Transport----------------------------------------
--DECLARE @sqlguid AS UNIQUEIDENTIFIER
SET @sqlguid = '21742F76-A876-48D0-BC59-73EEB92491EC'

--DECLARE @newsqlcmd AS VARCHAR (max)
SET @newsqlcmd = 'SELECT  h.ModeOfTransport ,
        COUNT(DISTINCT h.EntryGuid) AS DeclarationCount ,
        CAST(( SUM(d.EstBaseTotalLineValue) ) AS NUMERIC(28, 2)) AS [EstBaseTotalValue (@CurrencyCode)]
FROM    txdGVImportHeader h WITH ( NOLOCK )
JOIN dbo.txdGVImportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.EntryGuid = h.EntryGuid
WHERE 1=1 AND @IMPORTDATERANGE AND h.PartnerID = @PartnerID  
GROUP BY h.ModeOfTransport
ORDER BY DeclarationCount DESC'




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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          N'Value and Volume of Mode of Transport' , -- Description - nvarchar(100)
          N'This report shows the total number of declarations per mode of transport and the total associated value.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          N'Value and Volume of Mode of Transport' , -- Description - nvarchar(100)
          N'This report shows the total number of declarations per mode of transport and the total associated value.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

----------------------------------------------------------Value and Volume of Mode of Transport---------------------------------------------------------


------------------------------------Declared Value by Region----------------------------------------
--DECLARE @sqlguid AS UNIQUEIDENTIFIER
SET @sqlguid = 'E96D8AE1-B80A-4C2B-9D53-7385C7D55FFE'

--DECLARE @newsqlcmd AS VARCHAR (max)
SET @newsqlcmd = 'SELECT  ISNULL(cg.GroupName, h.ImportCountry) AS ImportRegion ,
        CAST(SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 2)) AS [EstBaseTotalValue (@CurrencyCode)]
FROM    txdGVImportHeader h
        LEFT JOIN tmfCountryGroup cg ON h.ImportCountry = cg.CountryCode
                                        AND h.PartnerID = cg.PartnerID
JOIN dbo.txdGVImportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.EntryGuid = h.EntryGuid
WHERE 1=1 AND @IMPORTDATERANGE AND h.PartnerID = @PartnerID 
        AND h.ImportCountry <> ''''
GROUP BY ISNULL(cg.GroupName, h.ImportCountry)
ORDER BY [EstBaseTotalValue (@CurrencyCode)] DESC'



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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          N'Declared Value by Region' , -- Description - nvarchar(100)
          N'Shows total declared value of all imports, grouped by geographical region. ' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          N'Declared Value by Region' , -- Description - nvarchar(100)
          N'Shows total declared value of all imports, grouped by geographical region. ' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

----------------------------------------------------------Declared Value by Region---------------------------------------------------------


------------------------------------Regions by Duty----------------------------------------
--DECLARE @sqlguid AS UNIQUEIDENTIFIER
SET @sqlguid = '7D803073-7C9A-4A22-BE93-DD86242C95B0'

--DECLARE @newsqlcmd AS VARCHAR (max)
SET @newsqlcmd = 'SELECT  ISNULL(cg.GroupName, h.ImportCountry) AS ImportRegion ,
        CAST(SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 2)) AS [EstBaseTotalDuty (@CurrencyCode)]
FROM    txdGVImportHeader h WITH (NOLOCK)
        LEFT JOIN tmfCountryGroup cg WITH (NOLOCK) ON h.ImportCountry = cg.CountryCode
                                        AND h.PartnerID = cg.PartnerID
JOIN dbo.txdGVImportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.EntryGuid = h.EntryGuid
WHERE 1=1 AND @IMPORTDATERANGE AND h.PartnerID = @PartnerID 
        AND h.ImportCountry <> ''''
GROUP BY ISNULL(cg.GroupName, h.ImportCountry)
ORDER BY [EstBaseTotalDuty (@CurrencyCode)] DESC'



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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          N'Regions by Duty' , -- Description - nvarchar(100)
          N'This report shows total declared duty of all imports, grouped by geographical region.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          N'Regions by Duty' , -- Description - nvarchar(100)
          N'This report shows total declared duty of all imports, grouped by geographical region.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

----------------------------------------------------------Regions by Duty---------------------------------------------------------


------------------------------------Total Import Value by Month----------------------------------------
--DECLARE @sqlguid AS UNIQUEIDENTIFIER
SET @sqlguid = '5E595EAE-D207-4905-B5B2-DE1F2690C73E'

--DECLARE @newsqlcmd AS VARCHAR (max)
SET @newsqlcmd = 'SELECT  CAST(DATEPART(MONTH, ImportDate) AS VARCHAR(50)) + ''-''
        + CAST(DATEPART(YEAR, ImportDate) AS VARCHAR(50)) AS ImportMonth ,
        CAST(SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 2)) AS [EstBaseTotalValue (@CurrencyCode)]
FROM    txdGVImportHeader h WITH ( NOLOCK )
JOIN dbo.txdGVImportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.EntryGuid = h.EntryGuid
WHERE 1=1 AND @IMPORTDATERANGE AND h.PartnerID = @PartnerID 
GROUP BY YEAR(h.ImportDate) ,
        MONTH(h.ImportDate)
ORDER BY YEAR(h.ImportDate) ,
        MONTH(h.ImportDate)'


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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          N'Total Import Value by Month' , -- Description - nvarchar(100)
          N'This report shows the total value of imports by month. ' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          N'Total Import Value by Month' , -- Description - nvarchar(100)
          N'This report shows the total value of imports by month. ' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

----------------------------------------------------------Total Import Value by Month---------------------------------------------------------


------------------------------------Total Import Value by Month - YoY----------------------------------------
--DECLARE @sqlguid AS UNIQUEIDENTIFIER
SET @sqlguid = 'DBC077C8-A9EB-42FE-AE43-8AD08BA451E8'

--DECLARE @newsqlcmd AS VARCHAR (max)
SET @newsqlcmd = 'SELECT  h.PartnerID ,
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
WHERE   DATEPART(YEAR, ImportDate) = DATEPART(YEAR,
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
ORDER BY y.ImportMonth ASC'



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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          N'Total Import Value by Month - YoY' , -- Description - nvarchar(100)
          N'This comparison report shows the total value of imports by month for the current year compared to the total value of imports by month for the previous year.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          N'Total Import Value by Month - YoY' , -- Description - nvarchar(100)
          N'This comparison report shows the total value of imports by month for the current year compared to the total value of imports by month for the previous year.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

----------------------------------------------------------Total Import Value by Month - YoY---------------------------------------------------------



------------------------------------Total Import Value by Month - Waterfall----------------------------------------
--DECLARE @sqlguid AS UNIQUEIDENTIFIER
SET @sqlguid = '7F5F14F3-EF4C-49B6-A6CE-8F5B8D664C7E'

--DECLARE @newsqlcmd AS VARCHAR (max)
SET @newsqlcmd = 'SELECT  CAST(DATEPART(MONTH, ImportDate) AS VARCHAR(50)) + ''-''
        + CAST(DATEPART(YEAR, ImportDate) AS VARCHAR(50)) AS ImportMonth ,
        CAST(SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 2)) AS [EstBaseTotalValue (@CurrencyCode)]
FROM    txdGVImportHeader h WITH ( NOLOCK )
JOIN dbo.txdGVImportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.EntryGuid = h.EntryGuid
WHERE 1=1 AND @IMPORTDATERANGE AND h.PartnerID = @PartnerID 
GROUP BY YEAR(h.ImportDate) ,
        MONTH(h.ImportDate)
ORDER BY YEAR(h.ImportDate) ,
        MONTH(h.ImportDate)'



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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          N'Total Import Value by Month - Waterfall' , -- Description - nvarchar(100)
          N'This report shows the total value of imports by month.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          N'Total Import Value by Month - Waterfall' , -- Description - nvarchar(100)
          N'This report shows the total value of imports by month.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

----------------------------------------------------------Total Import Value by Month - Waterfall---------------------------------------------------------



------------------------------------Total Import Value by Quarter - YoY----------------------------------------
--DECLARE @sqlguid AS UNIQUEIDENTIFIER
SET @sqlguid = 'D945E167-A62A-4D1D-A5F9-1C73E1C21257'

--DECLARE @newsqlcmd AS VARCHAR (max)
SET @newsqlcmd = 'SELECT  h.PartnerID ,
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
WHERE   DATEPART(YEAR, ImportDate) = DATEPART(YEAR,
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
ORDER BY y.EstBaseTotalDeclarationValue DESC'


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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          N'Total Import Value by Quarter - YoY' , -- Description - nvarchar(100)
          N'This comparison report shows the total value of imports by quarter for the current year compared to the total value of imports by quarter for the previous year.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          N'Total Import Value by Quarter - YoY' , -- Description - nvarchar(100)
          N'This comparison report shows the total value of imports by quarter for the current year compared to the total value of imports by quarter for the previous year.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

----------------------------------------------------------Total Import Value by Quarter - YoY---------------------------------------------------------



------------------------------------Total Import Value YTD----------------------------------------
--DECLARE @sqlguid AS UNIQUEIDENTIFIER
SET @sqlguid = 'DD843843-DB93-4C5A-AD54-85E74D41A1E1'

--DECLARE @newsqlcmd AS VARCHAR (max)
SET @newsqlcmd = 'SELECT  DATEPART(MONTH, MAX(h.ImportDate)) AS ImportMonth ,
        DATEPART(YEAR, MAX(h.ImportDate)) AS ImportYear ,
        CAST(SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 2)) AS Value
INTO    #YTDTotalDeclarationValue
FROM    txdGVImportHeader h WITH ( NOLOCK )
JOIN dbo.txdGVImportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.EntryGuid = h.EntryGuid
WHERE 1=1 AND h.PartnerID = @PartnerID AND @IMPORTDATERANGE 
GROUP BY YEAR(h.ImportDate) ,
        MONTH(h.ImportDate)
ORDER BY YEAR(h.ImportDate) ,
        MONTH(h.ImportDate)
SELECT  b.ImportMonth ,
        ( SELECT    SUM(a.Value)
          FROM      #YTDTotalDeclarationValue a
          WHERE     ( a.ImportMonth <= b.ImportMonth
                      AND a.ImportYear = b.ImportYear
                    )
                    OR ( a.ImportYear < b.ImportYear )
        ) AS [EstBaseTotalValue (@CurrencyCode)]
FROM    #YTDTotalDeclarationValue b'


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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          N'Total Import Value YTD' , -- Description - nvarchar(100)
          N'This report shows the total value of imports year-to-date.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          N'Total Import Value YTD' , -- Description - nvarchar(100)
          N'This report shows the total value of imports year-to-date.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

----------------------------------------------------------Total Import Value YTD---------------------------------------------------------


------------------------------------Total Import Value YTD (Waterfall)----------------------------------------
--DECLARE @sqlguid AS UNIQUEIDENTIFIER
SET @sqlguid = '880E357D-25D1-45BB-A19B-6FB6A3FA956B'

--DECLARE @newsqlcmd AS VARCHAR (max)
SET @newsqlcmd = 'SELECT  DATEPART(MONTH, MAX(h.ImportDate)) AS ImportMonth ,
        DATEPART(YEAR, MAX(h.ImportDate)) AS ImportYear ,
        CAST(SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 2)) AS Value
INTO    #YTDTotalDeclarationValue
FROM    txdGVImportHeader h WITH ( NOLOCK )
JOIN dbo.txdGVImportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.EntryGuid = h.EntryGuid
WHERE 1=1 AND h.PartnerID = @PartnerID AND @IMPORTDATERANGE 
GROUP BY YEAR(h.ImportDate) ,
        MONTH(h.ImportDate)
ORDER BY YEAR(h.ImportDate) ,
        MONTH(h.ImportDate)
SELECT  b.ImportMonth ,
        ( SELECT    SUM(a.Value)
          FROM      #YTDTotalDeclarationValue a
          WHERE     ( a.ImportMonth <= b.ImportMonth
                      AND a.ImportYear = b.ImportYear
                    )
                    OR ( a.ImportYear < b.ImportYear )
        ) AS [EstBaseTotalValue (@CurrencyCode)]
FROM    #YTDTotalDeclarationValue b'


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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          N'Total Import Value YTD (Waterfall)' , -- Description - nvarchar(100)
          N'This report shows the total value of imports year-to-date.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          N'Total Import Value YTD (Waterfall)' , -- Description - nvarchar(100)
          N'This report shows the total value of imports year-to-date.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

----------------------------------------------------------Total Import Value YTD (Waterfall)---------------------------------------------------------


------------------------------------Total Import Value YTD - YoY----------------------------------------
--DECLARE @sqlguid AS UNIQUEIDENTIFIER
SET @sqlguid = '4926C792-378E-46D3-96C3-22582E194E81'

--DECLARE @newsqlcmd AS VARCHAR (max)
SET @newsqlcmd = 'SELECT  h.PartnerID ,
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
WHERE   DATEPART(YEAR, h.ImportDate) = DATEPART(YEAR,
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
WHERE b.PartnerID = @PartnerID'



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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          N'Total Import Value YTD - YoY' , -- Description - nvarchar(100)
          N'This comparison report shows the total value of imports year-to-date for the current year compared to the total value of imports year-to-date for the previous year.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          N'Total Import Value YTD - YoY' , -- Description - nvarchar(100)
          N'This comparison report shows the total value of imports year-to-date for the current year compared to the total value of imports year-to-date for the previous year.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

----------------------------------------------------------Total Import Value YTD - YoY---------------------------------------------------------



------------------------------------All Routed Export Forwarders----------------------------------------
--DECLARE @sqlguid AS UNIQUEIDENTIFIER
SET @sqlguid = '66E79AFF-3ABF-4F7B-9631-0B61160340DE'

--DECLARE @newsqlcmd AS VARCHAR (max)
SET @newsqlcmd = 'SELECT  h.ForwarderCompanyName ,
        CAST(SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 2)) AS [EstBaseTotalShipmentValue(@CurrencyCode)] ,
        COUNT(h.ExportGUID) AS RoutedExportCount ,
        CAST(SUM(d.EstBaseTotalLineValue) / COUNT(h.ExportGuid) AS NUMERIC(28,
                                                              2)) AS [EstBaseAvgValuePerDeclaration(@CurrencyCode)]
FROM    txdGVExportHeader h WITH ( NOLOCK )
JOIN dbo.txdGVExportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.ExportGUID = h.ExportGuid
WHERE 1=1 AND @EXPORTDATERANGE AND h.PartnerID = @PartnerID  
        AND h.RoutedExportFlag = ''Y''
GROUP BY h.ForwarderCompanyName
ORDER BY COUNT(h.ExportGuid) DESC'


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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          N'All Routed Export Forwarders' , -- Description - nvarchar(100)
          N'This report shows all Forwarders associated with routed exports, the estimated base total Shipment Value of all routed exports during the period, the total number of routed exports of that Forwarder during the period, and the estimated base average value per shipment for each Forwarder.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          N'All Routed Export Forwarders' , -- Description - nvarchar(100)
          N'This report shows all Forwarders associated with routed exports, the estimated base total Shipment Value of all routed exports during the period, the total number of routed exports of that Forwarder during the period, and the estimated base average value per shipment for each Forwarder.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

----------------------------------------------------------All Routed Export Forwarders---------------------------------------------------------



------------------------------------All Routed Mode of Transport----------------------------------------
--DECLARE @sqlguid AS UNIQUEIDENTIFIER
SET @sqlguid = 'A72B71CD-7EDA-46F8-96B2-9F3A8C6FC852'

--DECLARE @newsqlcmd AS VARCHAR (max)
SET @newsqlcmd = 'SELECT  h.ModeOfTransport ,
        CAST(SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 2)) AS [EstBaseTotalShipmentValue(@CurrencyCode)] ,
        COUNT(h.ExportGuid) AS RoutedExportCount ,
        CAST(SUM(d.EstBaseTotalLineValue) / COUNT(h.ExportGuid) AS NUMERIC(28,
                                                              2)) AS [EstBaseAvgValuePerDeclaration(@CurrencyCode)]
FROM    txdGVExportHeader h WITH ( NOLOCK )
JOIN dbo.txdGVExportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.ExportGUID = h.ExportGuid
WHERE 1=1 AND @EXPORTDATERANGE AND h.PartnerID = @PartnerID  
        AND h.RoutedExportFlag = ''Y''
GROUP BY h.ModeOfTransport
ORDER BY COUNT(h.ExportGuid) DESC'




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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          N'All Routed Mode of Transport' , -- Description - nvarchar(100)
          N'This report shows all Modes of Transport associated with routed exports, the estimated base total Shipment Value of all routed exports during the period, the total number of routed exports of that Mode of Transport during the period, and the estimated base average value per shipment for each Mode of Transport.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          N'All Routed Mode of Transport' , -- Description - nvarchar(100)
          N'This report shows all Modes of Transport associated with routed exports, the estimated base total Shipment Value of all routed exports during the period, the total number of routed exports of that Mode of Transport during the period, and the estimated base average value per shipment for each Mode of Transport.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

----------------------------------------------------------All Routed Mode of Transport---------------------------------------------------------



------------------------------------All Routed Ports of Lading----------------------------------------
--DECLARE @sqlguid AS UNIQUEIDENTIFIER
SET @sqlguid = '64BCB503-801A-4B75-BD82-303845D5B8AD'

--DECLARE @newsqlcmd AS VARCHAR (max)
SET @newsqlcmd = 'SELECT  h.PortOfLading ,
        CAST(SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 2)) AS [EstBaseTotalShipmentValue(@CurrencyCode)] ,
        COUNT(h.ExportGuid) AS RoutedExportCount ,
        CAST(SUM(d.EstBaseTotalLineValue) / COUNT(h.ExportGuid) AS NUMERIC(28,
                                                              2)) AS [EstBaseAvgValuePerDeclaration(@CurrencyCode)]
FROM    txdGVExportHeader h WITH ( NOLOCK )
JOIN dbo.txdGVExportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.ExportGUID = h.ExportGuid
WHERE 1=1 AND @EXPORTDATERANGE AND h.PartnerID = @PartnerID  
        AND h.RoutedExportFlag = ''Y''
GROUP BY h.PortOfLading
ORDER BY COUNT(h.ExportGuid) DESC'



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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          N'All Routed Ports of Lading' , -- Description - nvarchar(100)
          N'This report shows all Ports of Lading associated with routed exports, the estimated base total Shipment Value of all routed exports during the period, the total number of routed exports of that Port of Lading during the period, and the estimated base average value per shipment for each Port of Lading.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          N'All Routed Ports of Lading' , -- Description - nvarchar(100)
          N'This report shows all Ports of Lading associated with routed exports, the estimated base total Shipment Value of all routed exports during the period, the total number of routed exports of that Port of Lading during the period, and the estimated base average value per shipment for each Port of Lading.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

----------------------------------------------------------All Routed Ports of Lading---------------------------------------------------------



------------------------------------All Routed Export Carrier----------------------------------------
--DECLARE @sqlguid AS UNIQUEIDENTIFIER
SET @sqlguid = '4E82E1C8-A471-47CF-A76B-559E0FB1B3BF'

--DECLARE @newsqlcmd AS VARCHAR (max)
SET @newsqlcmd = 'SELECT  h.CarrierName ,
        CAST(SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 2)) AS [EstBaseTotalShipmentValue(@CurrencyCode)] ,
        COUNT(h.ExportGuid) AS RoutedExportCount ,
        CAST(SUM(d.EstBaseTotalLineValue) / COUNT(h.ExportGuid) AS NUMERIC(28,
                                                              2)) AS [EstBaseAvgValuePerDeclaration(@CurrencyCode)]
FROM    txdGVExportHeader h WITH ( NOLOCK )
JOIN dbo.txdGVExportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.ExportGUID = h.ExportGuid
WHERE 1=1 AND @EXPORTDATERANGE AND h.PartnerID = @PartnerID  
        AND h.RoutedExportFlag = ''Y''
GROUP BY h.CarrierName
ORDER BY COUNT(h.ExportGuid) DESC'



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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          N'All Routed Export Carrier' , -- Description - nvarchar(100)
          N'This report shows all Carriers associated with routed exports, the estimated base total Shipment Value of all routed exports during the period, the total number of routed exports of that Carrier during the period, and the estimated base average value per shipment for each Carrier.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          N'All Routed Export Carrier' , -- Description - nvarchar(100)
          N'This report shows all Carriers associated with routed exports, the estimated base total Shipment Value of all routed exports during the period, the total number of routed exports of that Carrier during the period, and the estimated base average value per shipment for each Carrier.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

----------------------------------------------------------All Routed Export Carrier---------------------------------------------------------



------------------------------------All Routed Export Countries----------------------------------------
--DECLARE @sqlguid AS UNIQUEIDENTIFIER
SET @sqlguid = '35E7BBF9-A28B-4CAF-9927-AB56CB2E51D9'

--DECLARE @newsqlcmd AS VARCHAR (max)
SET @newsqlcmd = 'SELECT  h.ExportCountry ,
        CAST(SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 2)) AS [EstBaseTotalShipmentValue(@CurrencyCode)] ,
        COUNT(h.ExportGuid) AS RoutedExportCount ,
        CAST(SUM(d.EstBaseTotalLineValue) / COUNT(h.ExportGuid) AS NUMERIC(28,
                                                              2)) AS [EstBaseAvgValuePerDeclaration(@CurrencyCode)]
FROM    txdGVExportHeader h WITH ( NOLOCK )
JOIN dbo.txdGVExportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.ExportGUID = h.ExportGuid
WHERE 1=1 AND @EXPORTDATERANGE AND h.PartnerID = @PartnerID  
        AND h.RoutedExportFlag = ''Y''
GROUP BY h.ExportCountry
ORDER BY COUNT(h.ExportGuid) DESC'



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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          N'All Routed Export Countries' , -- Description - nvarchar(100)
          N'This report shows all Export Countries associated with routed exports, the estimated base total Shipment Value of all routed exports during the period, the total number of routed exports of that Export Country during the reporting period, and the estimated base average value per shipment for each Export Country.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          N'All Routed Export Countries' , -- Description - nvarchar(100)
          N'This report shows all Export Countries associated with routed exports, the estimated base total Shipment Value of all routed exports during the period, the total number of routed exports of that Export Country during the reporting period, and the estimated base average value per shipment for each Export Country.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

----------------------------------------------------------All Routed Export Countries---------------------------------------------------------


------------------------------------All Routed Import Countries----------------------------------------
--DECLARE @sqlguid AS UNIQUEIDENTIFIER
SET @sqlguid = 'C6C45CF3-0C23-424E-89D5-5C6791F9328F'

--DECLARE @newsqlcmd AS VARCHAR (max)
SET @newsqlcmd = 'SELECT  h.ImportCountry ,
        CAST(SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 2)) AS [EstBaseTotalShipmentValue(@CurrencyCode)] ,
        COUNT(h.ExportGuid) AS RoutedExportCount ,
        CAST(SUM(d.EstBaseTotalLineValue) / COUNT(h.ExportGuid) AS NUMERIC(28,
                                                              2)) AS [EstBaseAvgValuePerDeclaration(@CurrencyCode)]
FROM    txdGVExportHeader h WITH ( NOLOCK )
JOIN dbo.txdGVExportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.ExportGUID = h.ExportGuid
WHERE 1=1 AND @EXPORTDATERANGE AND h.PartnerID = @PartnerID  
        AND h.RoutedExportFlag = ''Y''
GROUP BY h.ImportCountry
ORDER BY COUNT(h.ExportGuid) DESC'



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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          N'All Routed Import Countries' , -- Description - nvarchar(100)
          N'This report shows all Import Countries associated with routed exports, the estimated base total Shipment Value of all routed exports during the period, the total number of routed exports of that Import Country during the period, and the estimated base average value per shipment for each Import Country.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          N'All Routed Import Countries' , -- Description - nvarchar(100)
          N'This report shows all Import Countries associated with routed exports, the estimated base total Shipment Value of all routed exports during the period, the total number of routed exports of that Import Country during the period, and the estimated base average value per shipment for each Import Country.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

----------------------------------------------------------All Routed Import Countries---------------------------------------------------------



------------------------------------All Routed Ports of Unlading----------------------------------------
--DECLARE @sqlguid AS UNIQUEIDENTIFIER
SET @sqlguid = '9AD1F064-17CB-4A35-A8B1-E8A9150DEAFE'

--DECLARE @newsqlcmd AS VARCHAR (max)
SET @newsqlcmd = 'SELECT  h.PortOfUnlading ,
        CAST(SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 2)) AS [EstBaseTotalShipmentValue(@CurrencyCode)] ,
        COUNT(h.ExportGuid) AS RoutedExportCount ,
        CAST(SUM(d.EstBaseTotalLineValue) / COUNT(h.ExportGuid) AS NUMERIC(28,
                                                              2)) AS [EstBaseAvgValuePerDeclaration(@CurrencyCode)]
FROM    txdGVExportHeader h WITH ( NOLOCK )
JOIN dbo.txdGVExportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.ExportGUID = h.ExportGuid
WHERE 1=1 AND @EXPORTDATERANGE AND h.PartnerID = @PartnerID  
        AND h.RoutedExportFlag = ''Y''
GROUP BY h.PortOfUnlading
ORDER BY COUNT(h.ExportGuid) DESC'


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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          N'All Routed Ports of Unlading' , -- Description - nvarchar(100)
          N'This report shows all Ports of Unlading associated with routed exports, the estimated base total Shipment Value of all routed exports during the period, the total number of routed exports of that Port of Unlading during the period, and the estimated base average value per shipment for each Port of Unlading.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          N'All Routed Ports of Unlading' , -- Description - nvarchar(100)
          N'This report shows all Ports of Unlading associated with routed exports, the estimated base total Shipment Value of all routed exports during the period, the total number of routed exports of that Port of Unlading during the period, and the estimated base average value per shipment for each Port of Unlading.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

----------------------------------------------------------All Routed Ports of Unlading---------------------------------------------------------
	

	
------------------------------------Total Value Shipped by Port of Lading----------------------------------------
--DECLARE @sqlguid AS UNIQUEIDENTIFIER
SET @sqlguid = 'DFD01F30-D270-4FB2-9C5D-7B6DD1F31AD8'

--DECLARE @newsqlcmd AS VARCHAR (max)
SET @newsqlcmd = 'SELECT TOP 10
        h.PortOfLading ,
        CAST(SUM(d.EstBaseTotalLineValue) AS NUMERIC(20, 2)) AS [EstBaseTotalShipmentValue(@CurrencyCode)]
FROM    txdGVExportHeader h WITH ( NOLOCK )
JOIN dbo.txdGVExportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.ExportGUID = h.ExportGuid
WHERE 1=1 AND @EXPORTDATERANGE AND h.PartnerID = @PartnerID 
GROUP BY h.PortOfLading
ORDER BY SUM(d.EstBaseTotalLineValue) DESC'



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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          N'Total Value Shipped by Port of Lading' , -- Description - nvarchar(100)
          N'This report shows the top Ports of Lading associated with the highest estimated base total Shipment Value exported during the reporting period and the estimated base total value of the shipments made for each product.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          N'Total Value Shipped by Port of Lading' , -- Description - nvarchar(100)
          N'This report shows the top Ports of Lading associated with the highest estimated base total Shipment Value exported during the reporting period and the estimated base total value of the shipments made for each product.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

----------------------------------------------------------Total Value Shipped by Port of Lading---------------------------------------------------------



------------------------------------Value Shipped by Port of Lading - YoY ----------------------------------------
--DECLARE @sqlguid AS UNIQUEIDENTIFIER
SET @sqlguid = '3E186D09-4980-4976-85FD-1B40C46DFE2B'

--DECLARE @newsqlcmd AS VARCHAR (max)
SET @newsqlcmd = 'SELECT  h.PartnerID ,
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
WHERE   DATEPART(YEAR, ExportDate) = DATEPART(YEAR,
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
ORDER BY SUM(y.EstBaseTotalShipmentValue) DESC'



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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          N'Value Shipped by Port of Lading - YoY ' , -- Description - nvarchar(100)
          N'This comparison report shows the Ports of Lading with the highest associated total Shipment Value on all shipments for the current calendar year compared to the associated total Shipment Value on all shipments filed for the previous calendar year. ' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          N'Value Shipped by Port of Lading - YoY ' , -- Description - nvarchar(100)
          N'This comparison report shows the Ports of Lading with the highest associated total Shipment Value on all shipments for the current calendar year compared to the associated total Shipment Value on all shipments filed for the previous calendar year. ' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

----------------------------------------------------------Value Shipped by Port of Lading - YoY ---------------------------------------------------------



------------------------------------All Value Shipped by Port of Lading  ----------------------------------------
--DECLARE @sqlguid AS UNIQUEIDENTIFIER
SET @sqlguid = '3484BA58-1C4E-46FC-A645-19B857F89C36'

--DECLARE @newsqlcmd AS VARCHAR (max)
SET @newsqlcmd = 'SELECT  h.PortOfLading ,
        CAST(SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 2)) AS [EstBaseTotalShipmentValue(@CurrencyCode)] ,
        COUNT(h.ExportGuid) AS TotalShipments ,
        CAST(SUM(d.EstBaseTotalLineValue) / COUNT(h.ExportGuid) AS NUMERIC(28,
                                                              2)) AS [EstBaseAvgValuePerDeclaration(@CurrencyCode)]
FROM    txdGVExportHeader h WITH ( NOLOCK )
JOIN dbo.txdGVExportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.ExportGUID = h.ExportGuid
WHERE 1=1 AND @EXPORTDATERANGE AND h.PartnerID =  @PartnerID 
GROUP BY h.PortOfLading
ORDER BY SUM(d.EstBaseTotalLineValue) DESC'



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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          N'All Value Shipped by Port of Lading ' , -- Description - nvarchar(100)
          N'This report shows all Ports of Lading and the associated total line value on all shipments, the count of shipments, and the average value per shipment for each Port of Lading.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          N'All Value Shipped by Port of Lading ' , -- Description - nvarchar(100)
          N'This report shows all Ports of Lading and the associated total line value on all shipments, the count of shipments, and the average value per shipment for each Port of Lading.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

----------------------------------------------------------All Value Shipped by Port of Lading ---------------------------------------------------------
	



------------------------------------Total Value Shipped by Carrier----------------------------------------
--DECLARE @sqlguid AS UNIQUEIDENTIFIER
SET @sqlguid = '6242D585-21A3-469C-AA25-B0BA3A5E9925'

--DECLARE @newsqlcmd AS VARCHAR (max)
SET @newsqlcmd = 'SELECT TOP 10
        h.CarrierName ,
        CAST(SUM(d.EstBaseTotalLineValue) AS NUMERIC(20, 2)) AS EstBaseTotalShipmentValue
FROM    txdGVExportHeader h WITH ( NOLOCK )
JOIN dbo.txdGVExportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.ExportGUID = h.ExportGuid
WHERE 1=1 AND @EXPORTDATERANGE AND h.PartnerID = @PartnerID 
GROUP BY h.CarrierName
ORDER BY SUM(d.EstBaseTotalLineValue) DESC'



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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          N'Total Value Shipped by Carrier' , -- Description - nvarchar(100)
          N'This report shows the top Carriers associated with the highest estimated base total Shipment Value exported during the reporting period and the estimated base total value of the shipments made for each product.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          N'Total Value Shipped by Carrier' , -- Description - nvarchar(100)
          N'This report shows the top Carriers associated with the highest estimated base total Shipment Value exported during the reporting period and the estimated base total value of the shipments made for each product.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

----------------------------------------------------------Total Value Shipped by Carrier---------------------------------------------------------



------------------------------------Total Value Shipped by Import Country----------------------------------------
--DECLARE @sqlguid AS UNIQUEIDENTIFIER
SET @sqlguid = '9EEB21CE-FE36-4055-B8A8-752E2F1F85BE'

--DECLARE @newsqlcmd AS VARCHAR (max)
SET @newsqlcmd = 'SELECT TOP 10
        h.ImportCountry ,
        CAST(SUM(d.EstBaseTotalLineValue) AS NUMERIC(20, 2)) AS [EstBaseTotalShipmentValue(@CurrencyCode)]
FROM    txdGVExportHeader h WITH ( NOLOCK )
JOIN dbo.txdGVExportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.ExportGUID = h.ExportGuid
WHERE 1=1 AND @EXPORTDATERANGE AND h.PartnerID = @PartnerID 
GROUP BY h.ImportCountry
ORDER BY SUM(d.EstBaseTotalLineValue) DESC'



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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          N'Total Value Shipped by Import Country' , -- Description - nvarchar(100)
          N'This report shows the top Import Countries associated with the highest estimated base total Shipment Value exported during the reporting period and the estimated base total value of the shipments made for each product.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          N'Total Value Shipped by Import Country' , -- Description - nvarchar(100)
          N'This report shows the top Import Countries associated with the highest estimated base total Shipment Value exported during the reporting period and the estimated base total value of the shipments made for each product.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

----------------------------------------------------------Total Value Shipped by Import Country---------------------------------------------------------



------------------------------------All Value Shipped by Port of Unlading ----------------------------------------
--DECLARE @sqlguid AS UNIQUEIDENTIFIER
SET @sqlguid = '861341D1-F5FC-410F-8C19-2D0A96C00F9C'

--DECLARE @newsqlcmd AS VARCHAR (max)
SET @newsqlcmd = 'SELECT  h.PortOfUnlading ,
        CAST(SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 2)) AS [EstBaseTotalShipmentValue(@CurrencyCode)] ,
        COUNT(h.ExportGuid) AS TotalShipments ,
        CAST(SUM(d.EstBaseTotalLineValue) / COUNT(h.ExportGuid) AS NUMERIC(28,
                                                              2)) AS [EstBaseAvgValuePerDeclaration(@CurrencyCode)]
FROM    txdGVExportHeader h WITH ( NOLOCK )
JOIN dbo.txdGVExportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.ExportGUID = h.ExportGuid
WHERE 1=1 AND @EXPORTDATERANGE AND h.PartnerID =  @PartnerID 
GROUP BY h.PortOfUnlading
ORDER BY SUM(d.EstBaseTotalLineValue) DESC'



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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          N'All Value Shipped by Port of Unlading ' , -- Description - nvarchar(100)
          N'This report shows all Ports of Unlading and the associated total line value on all shipments, the count of shipments, and the average value per shipment for each Port of Unlading.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          N'All Value Shipped by Port of Unlading ' , -- Description - nvarchar(100)
          N'This report shows all Ports of Unlading and the associated total line value on all shipments, the count of shipments, and the average value per shipment for each Port of Unlading.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

----------------------------------------------------------All Value Shipped by Port of Unlading ---------------------------------------------------------


------------------------------------Value Shipped by Port of Unlading - YoY ----------------------------------------
--DECLARE @sqlguid AS UNIQUEIDENTIFIER
SET @sqlguid = 'EF3DDA73-550D-438A-A614-FBE5A8EC6F4F'

--DECLARE @newsqlcmd AS VARCHAR (max)
SET @newsqlcmd = 'SELECT  h.PartnerID ,
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
WHERE   DATEPART(YEAR, ExportDate) = DATEPART(YEAR,
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
ORDER BY SUM(y.EstBaseTotalShipmentValue) DESC'


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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          N'Value Shipped by Port of Unlading - YoY ' , -- Description - nvarchar(100)
          N'This comparison report shows the Ports of Unlading with the highest associated total Shipment Value on all shipments for the current calendar year compared to the associated total Shipment Value on all shipments filed for the previous calendar year. ' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          N'Value Shipped by Port of Unlading - YoY ' , -- Description - nvarchar(100)
          N'This comparison report shows the Ports of Unlading with the highest associated total Shipment Value on all shipments for the current calendar year compared to the associated total Shipment Value on all shipments filed for the previous calendar year. ' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

----------------------------------------------------------Value Shipped by Port of Unlading - YoY ---------------------------------------------------------


------------------------------------Total Value Shipped by Port of Unlading----------------------------------------
--DECLARE @sqlguid AS UNIQUEIDENTIFIER
SET @sqlguid = '95CAB34D-0025-417F-8E20-0A49A1A0707C'

--DECLARE @newsqlcmd AS VARCHAR (max)
SET @newsqlcmd = 'SELECT TOP 10
        h.PortOfUnlading ,
        CAST(SUM(d.EstBaseTotalLineValue) AS NUMERIC(20, 2)) AS EstBaseTotalShipmentValue
FROM    txdGVExportHeader h WITH ( NOLOCK )
JOIN dbo.txdGVExportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.ExportGUID = h.ExportGuid
WHERE 1=1 AND @EXPORTDATERANGE AND h.PartnerID = @PartnerID 
GROUP BY h.PortOfUnlading
ORDER BY SUM(d.EstBaseTotalLineValue) DESC'



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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          N'Total Value Shipped by Port of Unlading' , -- Description - nvarchar(100)
          N'This report shows the top Ports of Unlading associated with the highest estimated base total Shipment Value exported during the reporting period and the estimated base total value of the shipments made for each product.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          N'Total Value Shipped by Port of Unlading' , -- Description - nvarchar(100)
          N'This report shows the top Ports of Unlading associated with the highest estimated base total Shipment Value exported during the reporting period and the estimated base total value of the shipments made for each product.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

----------------------------------------------------------Total Value Shipped by Port of Unlading---------------------------------------------------------


------------------------------------All Value Exported by ECN Number ----------------------------------------
--DECLARE @sqlguid AS UNIQUEIDENTIFIER
SET @sqlguid = '8463A9DD-53C4-4B6F-8B8E-8859D079085A'

--DECLARE @newsqlcmd AS VARCHAR (max)
SET @newsqlcmd = 'SELECT  d.ECNNum ,
        CAST(SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 2)) AS [EstBaseTotalShipmentValue(@CurrencyCode)] ,
        COUNT(d.ExportDetailGuid) AS TotalShipments ,
        CAST(SUM(d.EstBaseTotalLineValue) / COUNT(d.ExportDetailGuid) AS NUMERIC(28,
                                                              2)) AS [EstBaseAvgValuePerDeclaration(@CurrencyCode)]
FROM    txdGVExportHeader h WITH ( NOLOCK )
        JOIN txdGVExportDetail d WITH ( NOLOCK ) ON h.ExportGuid = d.ExportGUID
                                                    AND h.PartnerID = d.PartnerID
WHERE 1=1 AND @EXPORTDATERANGE AND h.PartnerID = @PartnerID 
GROUP BY d.ECNNum
ORDER BY SUM(d.EstBaseTotalLineValue) DESC'




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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          N'All Value Exported by ECN Number' , -- Description - nvarchar(100)
          N'This report shows all ECN Numbers and the associated total line value on all shipments, the count of shipments, and the average value per shipment for each ECN Number.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          N'All Value Exported by ECN Number' , -- Description - nvarchar(100)
          N'This report shows all ECN Numbers and the associated total line value on all shipments, the count of shipments, and the average value per shipment for each ECN Number.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

----------------------------------------------------------All Value Exported by ECN Number---------------------------------------------------------



------------------------------------All Value Shipped by Mode of Transport ----------------------------------------
--DECLARE @sqlguid AS UNIQUEIDENTIFIER
SET @sqlguid = 'EB955489-AC46-49B1-8398-9777AB2763E2'

--DECLARE @newsqlcmd AS VARCHAR (max)
SET @newsqlcmd = 'SELECT  h.ModeOfTransport ,
        CAST(SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 2)) AS [EstBaseTotalShipmentValue(@CurrencyCode)] ,
        COUNT(h.ExportGuid) AS TotalShipments ,
        CAST(SUM(d.EstBaseTotalLineValue) / COUNT(h.ExportGuid) AS NUMERIC(28,
                                                              2)) AS [EstBaseAvgValuePerDeclaration(@CurrencyCode)]
FROM    txdGVExportHeader h WITH ( NOLOCK )
JOIN dbo.txdGVExportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.ExportGUID = h.ExportGuid
WHERE 1=1 AND @EXPORTDATERANGE AND h.PartnerID =  @PartnerID 
GROUP BY h.ModeOfTransport
ORDER BY SUM(d.EstBaseTotalLineValue) DESC'



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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          N'All Value Shipped by Mode of Transport ' , -- Description - nvarchar(100)
          N'This report shows all Modes of Transport and the associated estimated total line value on all shipments, the count of shipments, and the average value per shipment for each Mode of Transport.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          N'All Value Shipped by Mode of Transport ' , -- Description - nvarchar(100)
          N'This report shows all Modes of Transport and the associated estimated total line value on all shipments, the count of shipments, and the average value per shipment for each Mode of Transport.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

----------------------------------------------------------All Value Shipped by Mode of Transport ---------------------------------------------------------



------------------------------------Total Value Shipped by Export Country----------------------------------------
--DECLARE @sqlguid AS UNIQUEIDENTIFIER
SET @sqlguid = 'B5178F43-0DCE-4444-A8E1-4DA3F101EF0D'

--DECLARE @newsqlcmd AS VARCHAR (max)
SET @newsqlcmd = 'SELECT TOP 10
        h.ExportCountry ,
        CAST(SUM(d.EstBaseTotalLineValue) AS NUMERIC(20, 2)) AS [EstBaseTotalShipmentValue(@CurrencyCode)]
FROM    txdGVExportHeader h WITH ( NOLOCK )
JOIN dbo.txdGVExportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.ExportGUID = h.ExportGuid
WHERE 1=1 AND @EXPORTDATERANGE AND h.PartnerID = @PartnerID 
GROUP BY h.ExportCountry
ORDER BY SUM(d.EstBaseTotalLineValue) DESC'


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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          N'Total Value Shipped by Export Country' , -- Description - nvarchar(100)
          N'This report shows the top Export Countries associated with the highest estimated base total Shipment Value exported during the reporting period and the estimated base total value of the shipments made for each product.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          N'Total Value Shipped by Export Country' , -- Description - nvarchar(100)
          N'This report shows the top Export Countries associated with the highest estimated base total Shipment Value exported during the reporting period and the estimated base total value of the shipments made for each product.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

----------------------------------------------------------Total Value Shipped by Export Country---------------------------------------------------------



------------------------------------Value Shipped by Export Country - YoY----------------------------------------
--DECLARE @sqlguid AS UNIQUEIDENTIFIER
SET @sqlguid = '7D8827DB-2D34-4B23-A798-754DF2DF88CD'

--DECLARE @newsqlcmd AS VARCHAR (max)
SET @newsqlcmd = 'SELECT  h.PartnerID ,
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
WHERE   DATEPART(YEAR, ExportDate) = DATEPART(YEAR,
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
ORDER BY SUM(y.EstBaseTotalShipmentValue) DESC'


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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          N'Value Shipped by Export Country - YoY' , -- Description - nvarchar(100)
          N'This comparison report shows the Export Countries with the highest associated total Shipment Value on all shipments for the current calendar year compared to the associated total Shipment Value on all shipments filed for the previous calendar year. ' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          N'Value Shipped by Export Country - YoY' , -- Description - nvarchar(100)
          N'This comparison report shows the Export Countries with the highest associated total Shipment Value on all shipments for the current calendar year compared to the associated total Shipment Value on all shipments filed for the previous calendar year. ' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

----------------------------------------------------------Value Shipped by Export Country - YoY---------------------------------------------------------



------------------------------------All Value Shipped by Export Country ----------------------------------------
--DECLARE @sqlguid AS UNIQUEIDENTIFIER
SET @sqlguid = '5A9D27FE-14F0-49CC-80C1-FEC2E7FACC0A'

--DECLARE @newsqlcmd AS VARCHAR (max)
SET @newsqlcmd = 'SELECT  h.ExportCountry ,
        CAST(SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 2)) AS [EstBaseTotalShipmentValue(@CurrencyCode)] ,
        COUNT(h.ExportGuid) AS TotalShipments ,
        CAST(SUM(d.EstBaseTotalLineValue) / COUNT(h.ExportGuid) AS NUMERIC(28,
                                                              2)) AS [EstBaseAvgValuePerDeclaration(@CurrencyCode)]
FROM    txdGVExportHeader h WITH ( NOLOCK )
JOIN dbo.txdGVExportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.ExportGUID = h.ExportGuid
WHERE 1=1 AND @EXPORTDATERANGE AND h.PartnerID =  @PartnerID 
GROUP BY h.ExportCountry
ORDER BY SUM(d.EstBaseTotalLineValue) DESC'



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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          N'All Value Shipped by Export Country ' , -- Description - nvarchar(100)
          N'This report shows the associated estimated total line value on all shipments, the count of shipments, and the average value per shipment for each Export Country.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          N'All Value Shipped by Export Country ' , -- Description - nvarchar(100)
          N'This report shows the associated estimated total line value on all shipments, the count of shipments, and the average value per shipment for each Export Country.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

----------------------------------------------------------All Value Shipped by Export Country ---------------------------------------------------------



------------------------------------Value Shipped by Import Country - YoY ----------------------------------------
--DECLARE @sqlguid AS UNIQUEIDENTIFIER
SET @sqlguid = '713F528F-17D3-4F36-9677-F5F20B29E578'

--DECLARE @newsqlcmd AS VARCHAR (max)
SET @newsqlcmd = 'SELECT  h.PartnerID ,
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
WHERE   DATEPART(YEAR, ExportDate) = DATEPART(YEAR,
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
ORDER BY SUM(y.EstBaseTotalShipmentValue) DESC '



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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          N'Value Shipped by Import Country - YoY ' , -- Description - nvarchar(100)
          N'This comparison report shows the Import Countries with the highest associated total Shipment Value on all shipments for the current calendar year compared to the associated total Shipment Value on all shipments filed for the previous calendar year. ' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          N'Value Shipped by Import Country - YoY ' , -- Description - nvarchar(100)
          N'This comparison report shows the Import Countries with the highest associated total Shipment Value on all shipments for the current calendar year compared to the associated total Shipment Value on all shipments filed for the previous calendar year. ' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

----------------------------------------------------------Value Shipped by Import Country - YoY ---------------------------------------------------------



------------------------------------All Value Shipped by Import Country ----------------------------------------
--DECLARE @sqlguid AS UNIQUEIDENTIFIER
SET @sqlguid = '12DA7D64-5D69-4DE0-898B-078FE245D451'

--DECLARE @newsqlcmd AS VARCHAR (max)
SET @newsqlcmd = 'SELECT  h.ImportCountry ,
        CAST(SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 2)) AS [EstBaseTotalShipmentValue(@CurrencyCode)] ,
        COUNT(h.ExportGuid) AS TotalShipments ,
        CAST(SUM(d.EstBaseTotalLineValue) / COUNT(h.ExportGuid) AS NUMERIC(28,
                                                              2)) AS [EstBaseAvgValuePerDeclaration(@CurrencyCode)]
FROM    txdGVExportHeader h WITH ( NOLOCK )
JOIN dbo.txdGVExportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.ExportGUID = h.ExportGuid
WHERE 1=1 AND @EXPORTDATERANGE AND h.PartnerID =  @PartnerID 
GROUP BY h.ImportCountry
ORDER BY SUM(d.EstBaseTotalLineValue) DESC'



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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          N'All Value Shipped by Import Country ' , -- Description - nvarchar(100)
          N'This report shows the associated estimated total line value on all shipments, the count of shipments, and the average value per shipment for each Import Country.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          N'All Value Shipped by Import Country ' , -- Description - nvarchar(100)
          N'This report shows the associated estimated total line value on all shipments, the count of shipments, and the average value per shipment for each Import Country.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

----------------------------------------------------------All Value Shipped by Import Country ---------------------------------------------------------



------------------------------------Value Shipped by Carrier - YoY ----------------------------------------
--DECLARE @sqlguid AS UNIQUEIDENTIFIER
SET @sqlguid = '0452138E-5693-46DB-B121-BE0A4AC3B1B0'

--DECLARE @newsqlcmd AS VARCHAR (max)
SET @newsqlcmd = 'SELECT  h.PartnerID ,
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
WHERE   DATEPART(YEAR, ExportDate) = DATEPART(YEAR,
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
ORDER BY SUM(y.EstBaseTotalShipmentValue) DESC'




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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          N'Value Shipped by Carrier - YoY ' , -- Description - nvarchar(100)
          N'This comparison report shows the Carriers with the highest associated total Shipment Value on all shipments for the current year to date compared to the associated Shipment Value on all shipments during the same period in the previous year. ' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          N'Value Shipped by Carrier - YoY ' , -- Description - nvarchar(100)
          N'This comparison report shows the Carriers with the highest associated total Shipment Value on all shipments for the current year to date compared to the associated Shipment Value on all shipments during the same period in the previous year. ' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

----------------------------------------------------------Value Shipped by Carrier - YoY ---------------------------------------------------------



------------------------------------All Value Shipped by Carrier----------------------------------------
--DECLARE @sqlguid AS UNIQUEIDENTIFIER
SET @sqlguid = '29C90163-98F3-4D5F-B68B-EF75446B971A'

--DECLARE @newsqlcmd AS VARCHAR (max)
SET @newsqlcmd = 'SELECT  h.CarrierName ,
        CAST(SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 2)) AS [EstBaseTotalShipmentValue(@CurrencyCode)] ,
        COUNT(h.ExportGuid) AS TotalShipments ,
        CAST(SUM(d.EstBaseTotalLineValue) / COUNT(h.ExportGuid) AS NUMERIC(28,
                                                              2)) AS [EstBaseAvgValuePerDeclaration(@CurrencyCode)]
FROM    txdGVExportHeader h WITH ( NOLOCK )
JOIN dbo.txdGVExportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.ExportGUID = h.ExportGuid
WHERE 1=1 AND @EXPORTDATERANGE AND h.PartnerID =  @PartnerID 
GROUP BY h.CarrierName
ORDER BY SUM(d.EstBaseTotalLineValue) DESC'





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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          N'All Value Shipped by Carrier' , -- Description - nvarchar(100)
          N'This report shows all Carriers and the associated total line value on all shipments, the count of shipments, and the average value per shipment for each Carrier.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          N'All Value Shipped by Carrier' , -- Description - nvarchar(100)
          N'This report shows all Carriers and the associated total line value on all shipments, the count of shipments, and the average value per shipment for each Carrier.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

----------------------------------------------------------All Value Shipped by Carrier---------------------------------------------------------


------------------------------------All Value Shipped by Forwarder ----------------------------------------
--DECLARE @sqlguid AS UNIQUEIDENTIFIER
SET @sqlguid = '55D0AC20-6661-4D5B-81BE-08C8F43E852F'

--DECLARE @newsqlcmd AS VARCHAR (max)
SET @newsqlcmd = 'SELECT  h.ForwarderCompanyName ,
        CAST(SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 2)) AS [EstBaseTotalShipmentValue(@CurrencyCode)] ,
        COUNT(h.ExportGuid) AS TotalShipments ,
        CAST(SUM(d.EstBaseTotalLineValue) / COUNT(h.ExportGuid) AS NUMERIC(28,
                                                              2)) AS [EstBaseAvgValuePerDeclaration(@CurrencyCode)]
FROM    txdGVExportHeader h WITH ( NOLOCK )
JOIN dbo.txdGVExportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.ExportGUID = h.ExportGuid
WHERE 1=1 AND @EXPORTDATERANGE AND h.PartnerID =  @PartnerID 
GROUP BY h.ForwarderCompanyName
ORDER BY SUM(d.EstBaseTotalLineValue) DESC'





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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          N'All Value Shipped by Forwarder ' , -- Description - nvarchar(100)
          N'This report shows all Forwarders and the associated total line value on all shipments, the count of shipments, and the average value per shipment for each Forwarder.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          N'All Value Shipped by Forwarder ' , -- Description - nvarchar(100)
          N'This report shows all Forwarders and the associated total line value on all shipments, the count of shipments, and the average value per shipment for each Forwarder.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

----------------------------------------------------------All Value Shipped by Forwarder ---------------------------------------------------------



------------------------------------Total Value Shipped by Forwarder----------------------------------------
--DECLARE @sqlguid AS UNIQUEIDENTIFIER
SET @sqlguid = 'AA4E687E-6C73-4B2B-A270-B518B4CE90AC'

--DECLARE @newsqlcmd AS VARCHAR (max)
SET @newsqlcmd = 'SELECT TOP 10
        h.ForwarderCompanyName ,
        CAST(SUM(d.EstBaseTotalLineValue) AS NUMERIC(20, 2)) AS EstBaseTotalShipmentValue
FROM    txdGVExportHeader h WITH ( NOLOCK )
JOIN dbo.txdGVExportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.ExportGUID = h.ExportGuid
WHERE 1=1 AND @EXPORTDATERANGE AND h.PartnerID = @PartnerID 
GROUP BY h.ForwarderCompanyName
ORDER BY SUM(d.EstBaseTotalLineValue) DESC'





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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          N'Total Value Shipped by Forwarder' , -- Description - nvarchar(100)
          N'This report shows the top Forwarders associated with the highest estimated base total Shipment Value exported during the reporting period and the estimated base total value of the shipments made for each product.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          N'Total Value Shipped by Forwarder' , -- Description - nvarchar(100)
          N'This report shows the top Forwarders associated with the highest estimated base total Shipment Value exported during the reporting period and the estimated base total value of the shipments made for each product.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

----------------------------------------------------------Total Value Shipped by Forwarder---------------------------------------------------------


------------------------------------Total Value Shipped by Mode of Transport----------------------------------------
--DECLARE @sqlguid AS UNIQUEIDENTIFIER
SET @sqlguid = '37BC2829-00B7-4DA6-8540-0907B9EDE8FE'

--DECLARE @newsqlcmd AS VARCHAR (max)
SET @newsqlcmd = 'SELECT TOP 10
        h.ModeOfTransport ,
        CAST(SUM(d.EstBaseTotalLineValue) AS NUMERIC(20, 2)) AS [EstBaseTotalShipmentValue(@CurrencyCode)]
FROM    txdGVExportHeader h WITH ( NOLOCK )
JOIN dbo.txdGVExportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.ExportGUID = h.ExportGuid
WHERE 1=1 AND @EXPORTDATERANGE AND h.PartnerID = @PartnerID 
GROUP BY h.ModeOfTransport
ORDER BY SUM(d.EstBaseTotalLineValue) DESC'



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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          N'Total Value Shipped by Mode of Transport' , -- Description - nvarchar(100)
          N'This report shows the top Modes of Transport associated with the highest estimated base total Shipment Value exported during the reporting period and the estimated base total value of the shipments made for each product.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          N'Total Value Shipped by Mode of Transport' , -- Description - nvarchar(100)
          N'This report shows the top Modes of Transport associated with the highest estimated base total Shipment Value exported during the reporting period and the estimated base total value of the shipments made for each product.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

----------------------------------------------------------Total Value Shipped by Mode of Transport---------------------------------------------------------



------------------------------------Value Shipped by Import Country - YoY ----------------------------------------
--DECLARE @sqlguid AS UNIQUEIDENTIFIER
SET @sqlguid = 'EA11143A-9C38-4772-A177-707F00EBE248'

--DECLARE @newsqlcmd AS VARCHAR (max)
SET @newsqlcmd = 'SELECT  h.PartnerID ,
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
WHERE   DATEPART(YEAR, ExportDate) = DATEPART(YEAR,
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
ORDER BY SUM(y.EstBaseTotalShipmentValue) DESC'


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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          N'Value Shipped by Import Country - YoY ' , -- Description - nvarchar(100)
          N'This comparison report shows the Modes of Transport with the highest associated total Shipment Value on all shipments for the current calendar year compared to the associated total Shipment Value on all shipments filed for the previous calendar year. ' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          N'Value Shipped by Import Country - YoY ' , -- Description - nvarchar(100)
          N'This comparison report shows the Modes of Transport with the highest associated total Shipment Value on all shipments for the current calendar year compared to the associated total Shipment Value on all shipments filed for the previous calendar year. ' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

----------------------------------------------------------Value Shipped by Import Country - YoY ---------------------------------------------------------



------------------------------------Weight Shipped by Export Country - YoY----------------------------------------
--DECLARE @sqlguid AS UNIQUEIDENTIFIER
SET @sqlguid = '1DCC57C0-6647-4FCC-8286-B457F78282F9'

--DECLARE @newsqlcmd AS VARCHAR (max)
SET @newsqlcmd = 'SELECT  h.PartnerID ,
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
WHERE   DATEPART(YEAR, ExportDate) = DATEPART(YEAR,
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
ORDER BY SUM(y.TotalWeightShipped) DESC'




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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          N'Weight Shipped by Export Country - YoY' , -- Description - nvarchar(100)
          N'This comparison report shows all Export Countries and the associated total weight shipped during the current year to date compared to the total weight shipped during the previous year.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          N'Weight Shipped by Export Country - YoY' , -- Description - nvarchar(100)
          N'This comparison report shows all Export Countries and the associated total weight shipped during the current year to date compared to the total weight shipped during the previous year.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

----------------------------------------------------------Weight Shipped by Export Country - YoY---------------------------------------------------------



------------------------------------All Weight Shipped by Export Country ----------------------------------------
--DECLARE @sqlguid AS UNIQUEIDENTIFIER
SET @sqlguid = '1187D1B2-FB1B-425F-9123-F691EDCF4688'

--DECLARE @newsqlcmd AS VARCHAR (max)
SET @newsqlcmd = 'SELECT  h.ExportCountry ,
        CAST(SUM(d.NetWeight) AS NUMERIC(28, 0)) AS TotalWeightShipped ,
        CAST(SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 2)) AS [EstBaseTotalShipmentValue(@CurrencyCode)] ,
        COUNT(h.ExportGuid) AS TotalShipments ,
        CAST(SUM(d.EstBaseTotalLineValue) / COUNT(h.ExportGuid) AS NUMERIC(28,
                                                              2)) AS [EstBaseAvgValuePerDeclaration(@CurrencyCode)]
FROM    txdGVExportHeader h WITH ( NOLOCK )
JOIN dbo.txdGVExportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.ExportGUID = h.ExportGuid
WHERE 1=1 AND @EXPORTDATERANGE AND h.PartnerID =  @PartnerID 
GROUP BY h.ExportCountry
ORDER BY SUM(d.EstBaseTotalLineValue) DESC'


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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          N'All Weight Shipped by Export Country ' , -- Description - nvarchar(100)
          N'This report shows all Export Countries associated with shipments made during the reporting period, the total weight shipped during the reporting period, the estimated base total Shipment Value, the total number of shipments made during the reporting period, and the estimated base average value per declaration for each Export Country.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          N'All Weight Shipped by Export Country ' , -- Description - nvarchar(100)
          N'This report shows all Export Countries associated with shipments made during the reporting period, the total weight shipped during the reporting period, the estimated base total Shipment Value, the total number of shipments made during the reporting period, and the estimated base average value per declaration for each Export Country.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

----------------------------------------------------------All Weight Shipped by Export Country ---------------------------------------------------------



------------------------------------Total Weight Shipped By Export Country----------------------------------------
--DECLARE @sqlguid AS UNIQUEIDENTIFIER
SET @sqlguid = '1C59C32E-75C5-45B7-83F7-5D055F82A0F3'

--DECLARE @newsqlcmd AS VARCHAR (max)
SET @newsqlcmd = 'SELECT TOP 10
        h.ExportCountry ,
        CAST(SUM(d.NetWeight) AS NUMERIC(28, 0)) AS TotalWeightShipped
FROM    txdGVExportHeader h WITH ( NOLOCK )
JOIN dbo.txdGVExportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.ExportGUID = h.ExportGuid
WHERE 1=1 AND @EXPORTDATERANGE AND h.PartnerID = @PartnerID  
GROUP BY h.ExportCountry
ORDER BY SUM(d.NetWeight) DESC'


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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          N'Total Weight Shipped By Export Country' , -- Description - nvarchar(100)
          N'This report shows the top Export Countries associated with the greatest total weight shipped during the reporting period and the total weight of shipments made for each Export Country.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          N'Total Weight Shipped By Export Country' , -- Description - nvarchar(100)
          N'This report shows the top Export Countries associated with the greatest total weight shipped during the reporting period and the total weight of shipments made for each Export Country.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

----------------------------------------------------------Total Weight Shipped By Export Country---------------------------------------------------------



------------------------------------All Weight Shipped by Mode of Transport ----------------------------------------
--DECLARE @sqlguid AS UNIQUEIDENTIFIER
SET @sqlguid = '32B0776F-6658-4475-AFF6-3CC049CDAC71'

--DECLARE @newsqlcmd AS VARCHAR (max)
SET @newsqlcmd = 'SELECT  h.ModeOfTransport ,
        CAST(SUM(d.NetWeight) AS NUMERIC(28, 0)) AS TotalWeightShipped ,
        CAST(SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 2)) AS [EstBaseTotalShipmentValue(@CurrencyCode)] ,
        COUNT(h.ExportGuid) AS TotalShipments ,
        CAST(SUM(d.EstBaseTotalLineValue) / COUNT(h.ExportGuid) AS NUMERIC(28,
                                                              2)) AS [EstBaseAvgValuePerDeclaration(@CurrencyCode)]
FROM    txdGVExportHeader h WITH ( NOLOCK )
JOIN dbo.txdGVExportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.ExportGUID = h.ExportGuid
WHERE 1=1 AND @EXPORTDATERANGE AND h.PartnerID =  @PartnerID 
GROUP BY h.ModeOfTransport
ORDER BY SUM(d.EstBaseTotalLineValue) DESC'



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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          N'All Weight Shipped by Mode of Transport ' , -- Description - nvarchar(100)
          N'This report shows all Modes of Transport associated with shipments made during the reporting period, the total weight shipped during the reporting period, the estimated base total Shipment Value, the total number of shipments made during the reporting period, and the estimated base average value per declaration for each Mode of Transport.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          N'All Weight Shipped by Mode of Transport ' , -- Description - nvarchar(100)
          N'This report shows all Modes of Transport associated with shipments made during the reporting period, the total weight shipped during the reporting period, the estimated base total Shipment Value, the total number of shipments made during the reporting period, and the estimated base average value per declaration for each Mode of Transport.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

----------------------------------------------------------All Weight Shipped by Mode of Transport ---------------------------------------------------------




------------------------------------All Weight Shipped by Port of Unlading ----------------------------------------
--DECLARE @sqlguid AS UNIQUEIDENTIFIER
SET @sqlguid = 'E485CF19-B43E-4DF3-B8E8-A5D36B96AC9D'

--DECLARE @newsqlcmd AS VARCHAR (max)
SET @newsqlcmd = 'SELECT  h.PortOfUnlading ,
        CAST(SUM(d.NetWeight) AS NUMERIC(28, 0)) AS TotalWeightShipped ,
        CAST(SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 2)) AS [EstBaseTotalShipmentValue(@CurrencyCode)] ,
        COUNT(h.ExportGuid) AS TotalShipments ,
        CAST(SUM(d.EstBaseTotalLineValue) / COUNT(h.ExportGuid) AS NUMERIC(28,
                                                              2)) AS [EstBaseAvgValuePerDeclaration(@CurrencyCode)]
FROM    txdGVExportHeader h WITH ( NOLOCK )
JOIN dbo.txdGVExportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.ExportGUID = h.ExportGuid
WHERE 1=1 AND @EXPORTDATERANGE AND h.PartnerID =  @PartnerID 
GROUP BY h.PortOfUnlading
ORDER BY SUM(d.EstBaseTotalLineValue) DESC'



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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          N'All Weight Shipped by Port of Unlading ' , -- Description - nvarchar(100)
          N'This report shows all Ports of Unlading associated with shipments made during the reporting period, the total weight shipped during the reporting period, the estimated base total Shipment Value, the total number of shipments made during the reporting period, and the estimated base average value per declaration for each Port of Unlading.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          N'All Weight Shipped by Port of Unlading ' , -- Description - nvarchar(100)
          N'This report shows all Ports of Unlading associated with shipments made during the reporting period, the total weight shipped during the reporting period, the estimated base total Shipment Value, the total number of shipments made during the reporting period, and the estimated base average value per declaration for each Port of Unlading.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

----------------------------------------------------------All Weight Shipped by Port of Unlading ---------------------------------------------------------



------------------------------------Weight Shipped by Mode of Transport - YoY----------------------------------------
--DECLARE @sqlguid AS UNIQUEIDENTIFIER
SET @sqlguid = 'EA5DD95D-F73C-4555-B430-B5E841A064E0'

--DECLARE @newsqlcmd AS VARCHAR (max)
SET @newsqlcmd = 'SELECT  h.PartnerID ,
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
WHERE   DATEPART(YEAR, ExportDate) = DATEPART(YEAR,
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
ORDER BY SUM(y.TotalWeightShipped) DESC'



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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          N'Weight Shipped by Mode of Transport - YoY' , -- Description - nvarchar(100)
          N'This comparison report shows all Modes of Transport and the associated total weight shipped during the current year to date compared to the total weight shipped during the previous year.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          N'Weight Shipped by Mode of Transport - YoY' , -- Description - nvarchar(100)
          N'This comparison report shows all Modes of Transport and the associated total weight shipped during the current year to date compared to the total weight shipped during the previous year.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

----------------------------------------------------------Weight Shipped by Mode of Transport - YoY---------------------------------------------------------



------------------------------------Total Weight Shipped by Mode of Transport----------------------------------------
--DECLARE @sqlguid AS UNIQUEIDENTIFIER
SET @sqlguid = '0F85F4B7-037B-4D84-A9BC-BCF8F7737C34'

--DECLARE @newsqlcmd AS VARCHAR (max)
SET @newsqlcmd = 'SELECT TOP 10
        h.ModeOfTransport ,
        CAST(SUM(d.NetWeight) AS NUMERIC(28, 0)) AS TotalWeightShipped
FROM    txdGVExportHeader h WITH ( NOLOCK )
JOIN dbo.txdGVExportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.ExportGUID = h.ExportGuid
WHERE 1=1 AND @EXPORTDATERANGE AND h.PartnerID = @PartnerID  
GROUP BY h.ModeOfTransport
ORDER BY SUM(d.NetWeight) DESC'


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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          N'Total Weight Shipped by Mode of Transport' , -- Description - nvarchar(100)
          N'This report shows the top Modes of Transport associated with the greatest total weight shipped during the reporting period and the total weight of shipments made for each Mode of Transport.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          N'Total Weight Shipped by Mode of Transport' , -- Description - nvarchar(100)
          N'This report shows the top Modes of Transport associated with the greatest total weight shipped during the reporting period and the total weight of shipments made for each Mode of Transport.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

----------------------------------------------------------Weight Shipped by Mode of Transport - YoY---------------------------------------------------------



------------------------------------Weight Shipped by Business Division - YoY----------------------------------------
--DECLARE @sqlguid AS UNIQUEIDENTIFIER
SET @sqlguid = '5418E205-531C-4234-A669-FE3DBB28CAA4'

--DECLARE @newsqlcmd AS VARCHAR (max)
SET @newsqlcmd = 'SELECT  h.PartnerID ,
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
WHERE   DATEPART(YEAR, ExportDate) = DATEPART(YEAR,
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
ORDER BY SUM(y.TotalWeightShipped) DESC'





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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          N'Weight Shipped by Business Division - YoY' , -- Description - nvarchar(100)
          N'This comparison report shows all Business Divisions and the associated Total Weight shipped during the current year to date compared to the Total Weight shipped during the previous year.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          N'Weight Shipped by Business Division - YoY' , -- Description - nvarchar(100)
          N'This comparison report shows all Business Divisions and the associated Total Weight shipped during the current year to date compared to the Total Weight shipped during the previous year.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

----------------------------------------------------------Weight Shipped by Business Division - YoY---------------------------------------------------------



------------------------------------Weight Shipped by Export Tariff Number - YoY----------------------------------------
--DECLARE @sqlguid AS UNIQUEIDENTIFIER
SET @sqlguid = '55926D41-D693-44E8-AF19-7CC367B97A82'

--DECLARE @newsqlcmd AS VARCHAR (max)
SET @newsqlcmd = 'SELECT  h.PartnerID ,
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
WHERE   DATEPART(YEAR, ExportDate) = DATEPART(YEAR,
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
ORDER BY SUM(y.TotalWeightShipped) DESC'


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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          N'Weight Shipped by Export Tariff Number - YoY' , -- Description - nvarchar(100)
          N'This comparison report shows all Export Tariff Numbers and the associated total weight shipped during the current year to date compared to the total weight shipped during the previous year.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          N'Weight Shipped by Export Tariff Number - YoY' , -- Description - nvarchar(100)
          N'This comparison report shows all Export Tariff Numbers and the associated total weight shipped during the current year to date compared to the total weight shipped during the previous year.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

----------------------------------------------------------Weight Shipped by Export Tariff Number - YoY---------------------------------------------------------



------------------------------------Total Weight Shipped by Port of Unlading----------------------------------------
--DECLARE @sqlguid AS UNIQUEIDENTIFIER
SET @sqlguid = 'AA083860-2719-4B53-AB47-B19CDB152724'

--DECLARE @newsqlcmd AS VARCHAR (max)
SET @newsqlcmd = 'SELECT TOP 10
        h.PortOfUnlading ,
        CAST(SUM(d.NetWeight) AS NUMERIC(28, 0)) AS TotalWeightShipped
FROM    txdGVExportHeader h WITH ( NOLOCK )
JOIN dbo.txdGVExportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.ExportGUID = h.ExportGuid
WHERE 1=1 AND @EXPORTDATERANGE AND h.PartnerID = @PartnerID 
GROUP BY h.PortOfUnlading
ORDER BY SUM(d.NetWeight) DESC'



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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          N'Total Weight Shipped by Port of Unlading' , -- Description - nvarchar(100)
          N'This report shows the top Ports of Unlading associated with the greatest total weight shipped during the reporting period and the total weight of shipments made for each Port of Unlading.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          N'Total Weight Shipped by Port of Unlading' , -- Description - nvarchar(100)
          N'This report shows the top Ports of Unlading associated with the greatest total weight shipped during the reporting period and the total weight of shipments made for each Port of Unlading.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

----------------------------------------------------------Total Weight Shipped by Port of Unlading---------------------------------------------------------



------------------------------------Total Weight Shipped By Forwarder----------------------------------------
--DECLARE @sqlguid AS UNIQUEIDENTIFIER
SET @sqlguid = '4890BB05-8B50-40DB-B124-7512B505665E'

--DECLARE @newsqlcmd AS VARCHAR (max)
SET @newsqlcmd = 'SELECT TOP 10
        h.ForwarderCompanyName ,
        CAST(SUM(d.NetWeight) AS NUMERIC(28, 0)) AS TotalWeightShipped
FROM    txdGVExportHeader h WITH ( NOLOCK )
JOIN dbo.txdGVExportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.ExportGUID = h.ExportGuid
WHERE 1=1 AND @EXPORTDATERANGE AND h.PartnerID = @PartnerID  
GROUP BY h.ForwarderCompanyName
ORDER BY SUM(d.NetWeight) DESC'



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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          N'Total Weight Shipped By Forwarder' , -- Description - nvarchar(100)
          N'This report shows the top Forwarders associated with the greatest total weight shipped during the reporting period and the total weight of shipments made for each Forwarder.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          N'Total Weight Shipped By Forwarder' , -- Description - nvarchar(100)
          N'This report shows the top Forwarders associated with the greatest total weight shipped during the reporting period and the total weight of shipments made for each Forwarder.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

----------------------------------------------------------Total Weight Shipped By Forwarder---------------------------------------------------------



------------------------------------Weight Shipped by Port of Unlading - YoY----------------------------------------
--DECLARE @sqlguid AS UNIQUEIDENTIFIER
SET @sqlguid = '8BBDBB87-71AA-4F22-B42A-6E995B14605F'

--DECLARE @newsqlcmd AS VARCHAR (max)
SET @newsqlcmd = 'SELECT  h.PartnerID ,
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
WHERE   DATEPART(YEAR, ExportDate) = DATEPART(YEAR,
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
ORDER BY SUM(y.TotalWeightShipped) DESC'


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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          N'Weight Shipped by Port of Unlading - YoY' , -- Description - nvarchar(100)
          N'This comparison report shows all Ports of Unlading and the associated total weight shipped during the current year to date compared to the total weight shipped during the previous year.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          N'Weight Shipped by Port of Unlading - YoY' , -- Description - nvarchar(100)
          N'This comparison report shows all Ports of Unlading and the associated total weight shipped during the current year to date compared to the total weight shipped during the previous year.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

----------------------------------------------------------Weight Shipped by Port of Unlading - YoY---------------------------------------------------------



------------------------------------All Brokers by Duty----------------------------------------
--DECLARE @sqlguid AS UNIQUEIDENTIFIER
SET @sqlguid = '5A665B2F-EF0E-4DB1-AB68-062A7FD055AA'

--DECLARE @newsqlcmd AS VARCHAR (max)
SET @newsqlcmd = 'SELECT  h.BrokerName ,
        CAST(SUM(d.EstBaseTotalLineDuty) AS NUMERIC(28, 2)) AS [EstBaseTotalDuty (@CurrencyCode)] ,
        COUNT(DISTINCT h.EntryGuid) AS DeclarationCount ,
        CAST(SUM(d.EstBaseTotalLineDuty) / COUNT(DISTINCT h.EntryGuid) AS NUMERIC(28,
                                                              2)) AS [EstBaseAvgDutyPerDeclaration (@CurrencyCode)]
FROM    txdGVImportHeader h WITH ( NOLOCK )
JOIN dbo.txdGVImportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.EntryGuid = h.EntryGuid
WHERE 1=1 AND @IMPORTDATERANGE AND h.PartnerID = @PartnerID 
GROUP BY h.BrokerName
ORDER BY SUM(d.EstBaseTotalLineDuty) DESC'



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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          N'All Brokers by Duty' , -- Description - nvarchar(100)
          N'This report shows all brokers and the associated total line duty paid on all declarations filed, volume of declarations, and the average duty paid per declaration for each broker. ' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          N'All Brokers by Duty' , -- Description - nvarchar(100)
          N'This report shows all brokers and the associated total line duty paid on all declarations filed, volume of declarations, and the average duty paid per declaration for each broker. ' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

----------------------------------------------------------All Brokers by Duty---------------------------------------------------------



------------------------------------All Countries of Import by Duty----------------------------------------
--DECLARE @sqlguid AS UNIQUEIDENTIFIER
SET @sqlguid = '320D16E5-8EF1-4A93-9361-5D34B18C7155'

--DECLARE @newsqlcmd AS VARCHAR (max)
SET @newsqlcmd = 'SELECT  h.ImportCountry ,
        CAST(SUM(d.EstBaseTotalLineDuty) AS NUMERIC(28, 2)) AS [EstBaseTotalDuty (@CurrencyCode)] ,
        COUNT(DISTINCT h.EntryGuid) AS DeclarationCount ,
        CAST(SUM(d.EstBaseTotalLineDuty) / COUNT(DISTINCT h.EntryGuid) AS NUMERIC(28,
                                                              2)) AS [EstBaseAvgDutyPerDeclaration (@CurrencyCode)]
FROM    txdGVImportHeader h WITH ( NOLOCK )
JOIN dbo.txdGVImportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.EntryGuid = h.EntryGuid
WHERE 1=1 AND @IMPORTDATERANGE AND h.PartnerID = @PartnerID 
GROUP BY h.ImportCountry
ORDER BY SUM(d.EstBaseTotalLineDuty) DESC'


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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          N'All Countries of Import by Duty' , -- Description - nvarchar(100)
          N'This report shows all countries of import and the associated total line duty paid on all declarations filed, volume of declarations, and the average duty paid per declaration for each country of import. ' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          N'All Countries of Import by Duty' , -- Description - nvarchar(100)
          N'This report shows all countries of import and the associated total line duty paid on all declarations filed, volume of declarations, and the average duty paid per declaration for each country of import. ' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

----------------------------------------------------------All Countries of Import by Duty---------------------------------------------------------



------------------------------------All Importers by Duty----------------------------------------
--DECLARE @sqlguid AS UNIQUEIDENTIFIER
SET @sqlguid = '9BC0D874-3B0B-45A3-A473-55BFEA9042A5'

--DECLARE @newsqlcmd AS VARCHAR (max)
SET @newsqlcmd = 'SELECT  h.ImporterName ,
        CAST(SUM(d.EstBaseTotalLineDuty) AS NUMERIC(28, 2)) AS [EstBaseTotalDuty (@CurrencyCode)] ,
        COUNT(DISTINCT h.EntryGuid) AS DeclarationCount ,
        CAST(SUM(d.EstBaseTotalLineDuty) / COUNT(DISTINCT h.EntryGuid) AS NUMERIC(28,
                                                              2)) AS [EstBaseAvgDutyPerDeclaration (@CurrencyCode)]
FROM    txdGVImportHeader h WITH ( NOLOCK )
JOIN dbo.txdGVImportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.EntryGuid = h.EntryGuid
WHERE 1=1 AND @IMPORTDATERANGE AND h.PartnerID = @PartnerID 
GROUP BY h.ImporterName
ORDER BY SUM(d.EstBaseTotalLineDuty) DESC'



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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          N'All Importers by Duty' , -- Description - nvarchar(100)
          N'This report shows all importers and the associated total line duty paid on all declarations filed, volume of declarations, and the average duty paid per declaration for each importer. ' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          N'All Importers by Duty' , -- Description - nvarchar(100)
          N'This report shows all importers and the associated total line duty paid on all declarations filed, volume of declarations, and the average duty paid per declaration for each importer. ' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

----------------------------------------------------------All Importers by Duty---------------------------------------------------------



------------------------------------All Value Exported by INCOTerm----------------------------------------
--DECLARE @sqlguid AS UNIQUEIDENTIFIER
SET @sqlguid = '4669CB3D-87E4-408B-95E1-E753A9D1A7B2'

--DECLARE @newsqlcmd AS VARCHAR (max)
SET @newsqlcmd = 'SELECT  h.INCOTerms ,
        CAST(SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 2)) AS [EstBaseTotalShipmentValue(@CurrencyCode)] ,
        COUNT(h.ExportGuid) AS TotalShipments ,
        CAST(SUM(d.EstBaseTotalLineValue) / COUNT(h.ExportGuid) AS NUMERIC(28,
                                                              2)) AS [EstBaseAvgValuePerDeclaration(@CurrencyCode)]
FROM    txdGVExportHeader h WITH ( NOLOCK )
JOIN dbo.txdGVExportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.ExportGUID = h.ExportGuid
WHERE 1=1 AND @EXPORTDATERANGE AND h.PartnerID =  @PartnerID 
GROUP BY h.INCOTerms
ORDER BY SUM(d.EstBaseTotalLineValue) DESC'

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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          N'' , -- Description - nvarchar(100)
          N'This report shows all INCOterms and the associated estimated total line value on all shipments, the count of shipments, and the average value per shipment for each INCOterm. ' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          N'' , -- Description - nvarchar(100)
          N'This report shows all INCOterms and the associated estimated total line value on all shipments, the count of shipments, and the average value per shipment for each INCOterm. ' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

----------------------------------------------------------All Value Exported by INCOTerm---------------------------------------------------------



------------------------------------All Weight Shipped by Carrier ----------------------------------------
--DECLARE @sqlguid AS UNIQUEIDENTIFIER
SET @sqlguid = 'A12DF2E0-10EA-4D3A-8491-9CF45EA57B46'

--DECLARE @newsqlcmd AS VARCHAR (max)
SET @newsqlcmd = 'SELECT  h.CarrierName ,
        CAST(SUM(d.NetWeight) AS NUMERIC(28, 0)) AS TotalWeightShipped ,
        CAST(SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 2)) AS [EstBaseTotalShipmentValue(@CurrencyCode)] ,
        COUNT(h.ExportGuid) AS TotalShipments ,
        CAST(SUM(d.EstBaseTotalLineValue) / COUNT(h.ExportGuid) AS NUMERIC(28,
                                                              2)) AS [EstBaseAvgValuePerDeclaration(@CurrencyCode)]
FROM    txdGVExportHeader h WITH ( NOLOCK )
JOIN dbo.txdGVExportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.ExportGUID = h.ExportGuid
WHERE 1=1 AND @EXPORTDATERANGE AND h.PartnerID =  @PartnerID 
GROUP BY h.CarrierName
ORDER BY SUM(d.EstBaseTotalLineValue) DESC'


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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          N'All Weight Shipped by Carrier ' , -- Description - nvarchar(100)
          N'This report shows all Carriers associated with shipments made during the reporting period, the total weight shipped during the reporting period, the estimated base total Shipment Value, the total number of shipments made during the reporting period, and the estimated base average value per declaration for each Carrier.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          N'All Weight Shipped by Carrier ' , -- Description - nvarchar(100)
          N'This report shows all Carriers associated with shipments made during the reporting period, the total weight shipped during the reporting period, the estimated base total Shipment Value, the total number of shipments made during the reporting period, and the estimated base average value per declaration for each Carrier.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

----------------------------------------------------------All Weight Shipped by Carrier ---------------------------------------------------------



------------------------------------All Weight Shipped by Forwarder ----------------------------------------
--DECLARE @sqlguid AS UNIQUEIDENTIFIER
SET @sqlguid = 'C7F285A8-37B3-40A8-80EB-714F2BB8AB01'

--DECLARE @newsqlcmd AS VARCHAR (max)
SET @newsqlcmd = 'SELECT  h.ForwarderCompanyName ,
        CAST(SUM(d.NetWeight) AS NUMERIC(28, 0)) AS TotalWeightShipped ,
        CAST(SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 2)) AS [EstBaseTotalShipmentValue(@CurrencyCode)] ,
        COUNT(h.ExportGuid) AS TotalShipments ,
        CAST(SUM(d.EstBaseTotalLineValue) / COUNT(h.ExportGuid) AS NUMERIC(28,
                                                              2)) AS [EstBaseAvgValuePerDeclaration(@CurrencyCode)]
FROM    txdGVExportHeader h WITH ( NOLOCK )
JOIN dbo.txdGVExportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.ExportGUID = h.ExportGuid
WHERE 1=1 AND @EXPORTDATERANGE AND h.PartnerID =  @PartnerID 
GROUP BY h.ForwarderCompanyName
ORDER BY SUM(d.EstBaseTotalLineValue) DESC'


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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          N'All Weight Shipped by Forwarder ' , -- Description - nvarchar(100)
          N'This report shows all Forwarders associated with shipments made during the reporting period, the total weight shipped during the reporting period, the estimated base total Shipment Value, the total number of shipments made during the reporting period, and the estimated base average value per declaration for each Forwarder.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          N'All Weight Shipped by Forwarder ' , -- Description - nvarchar(100)
          N'This report shows all Forwarders associated with shipments made during the reporting period, the total weight shipped during the reporting period, the estimated base total Shipment Value, the total number of shipments made during the reporting period, and the estimated base average value per declaration for each Forwarder.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

----------------------------------------------------------All Weight Shipped by Forwarder ---------------------------------------------------------



------------------------------------All Weight Shipped by Import Country ----------------------------------------
--DECLARE @sqlguid AS UNIQUEIDENTIFIER
SET @sqlguid = 'B75178C9-A7D4-475D-A7BA-FC96CDBBC3C6'

--DECLARE @newsqlcmd AS VARCHAR (max)
SET @newsqlcmd = 'SELECT  h.ImportCountry ,
        CAST(SUM(d.NetWeight) AS NUMERIC(28, 0)) AS TotalWeightShipped ,
        CAST(SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 2)) AS [EstBaseTotalShipmentValue(@CurrencyCode)] ,
        COUNT(h.ExportGuid) AS TotalShipments ,
        CAST(SUM(d.EstBaseTotalLineValue) / COUNT(h.ExportGuid) AS NUMERIC(28,
                                                              2)) AS [EstBaseAvgValuePerDeclaration(@CurrencyCode)]
FROM    txdGVExportHeader h WITH ( NOLOCK )
JOIN dbo.txdGVExportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.ExportGUID = h.ExportGuid
WHERE 1=1 AND @EXPORTDATERANGE AND h.PartnerID =  @PartnerID 
GROUP BY h.ImportCountry
ORDER BY SUM(d.EstBaseTotalLineValue) DESC'


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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          N'All Weight Shipped by Import Country ' , -- Description - nvarchar(100)
          N'This report shows all Import Country  associated with shipments made during the reporting period, the total weight shipped during the reporting period, the estimated base total Shipment Value, the total number of shipments made during the reporting period, and the estimated base average value per declaration for each Import Country.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          N'All Weight Shipped by Import Country ' , -- Description - nvarchar(100)
          N'This report shows all Import Country  associated with shipments made during the reporting period, the total weight shipped during the reporting period, the estimated base total Shipment Value, the total number of shipments made during the reporting period, and the estimated base average value per declaration for each Import Country.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

----------------------------------------------------------All Weight Shipped by Import Country ---------------------------------------------------------



------------------------------------All Weight Shipped by Port of Lading ----------------------------------------
--DECLARE @sqlguid AS UNIQUEIDENTIFIER
SET @sqlguid = 'C3F5D1F5-92ED-4CDD-91EB-FA6AAE14B24C'

--DECLARE @newsqlcmd AS VARCHAR (max)
SET @newsqlcmd = 'SELECT  h.PortOfLading ,
        CAST(SUM(d.NetWeight) AS NUMERIC(28, 0)) AS TotalWeightShipped ,
        CAST(SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 2)) AS [EstBaseTotalShipmentValue(@CurrencyCode)] ,
        COUNT(h.ExportGuid) AS TotalShipments ,
        CAST(SUM(d.EstBaseTotalLineValue) / COUNT(h.ExportGuid) AS NUMERIC(28,
                                                              2)) AS [EstBaseAvgValuePerDeclaration(@CurrencyCode)]
FROM    txdGVExportHeader h WITH ( NOLOCK )
JOIN dbo.txdGVExportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.ExportGUID = h.ExportGuid
WHERE 1=1 AND @EXPORTDATERANGE AND h.PartnerID =  @PartnerID 
GROUP BY h.PortOfLading
ORDER BY SUM(d.EstBaseTotalLineValue) DESC'



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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          N'All Weight Shipped by Port of Lading ' , -- Description - nvarchar(100)
          N'This report shows all Ports of Lading associated with shipments made during the reporting period, the total weight shipped during the reporting period, the estimated base total Shipment Value, the total number of shipments made during the reporting period, and the estimated base average value per declaration for each Port of Lading.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          N'All Weight Shipped by Port of Lading ' , -- Description - nvarchar(100)
          N'This report shows all Ports of Lading associated with shipments made during the reporting period, the total weight shipped during the reporting period, the estimated base total Shipment Value, the total number of shipments made during the reporting period, and the estimated base average value per declaration for each Port of Lading.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

----------------------------------------------------------All Weight Shipped by Port of Lading ---------------------------------------------------------



------------------------------------Brokers by Duty - YoY----------------------------------------
--DECLARE @sqlguid AS UNIQUEIDENTIFIER
SET @sqlguid = 'E11A0EA1-406F-4E33-A5FD-569B203A840C'

--DECLARE @newsqlcmd AS VARCHAR (max)
SET @newsqlcmd = 'SELECT  h.PartnerID ,
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
WHERE   DATEPART(YEAR, ImportDate) = DATEPART(YEAR,
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
ORDER BY SUM(y.EstBaseTotalDeclarationDuty) DESC'

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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          N'Brokers by Duty - YoY' , -- Description - nvarchar(100)
          N'This comparison report shows the brokers with the highest associated total duty paid on all declarations filed for the current year compared to the highest associated total duty paid on all declarations filed for the previous year. ' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          N'Brokers by Duty - YoY' , -- Description - nvarchar(100)
          N'This comparison report shows the brokers with the highest associated total duty paid on all declarations filed for the current year compared to the highest associated total duty paid on all declarations filed for the previous year. ' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

----------------------------------------------------------Brokers by Duty - YoY---------------------------------------------------------



------------------------------------Countries of Import by Duty - YoY----------------------------------------
--DECLARE @sqlguid AS UNIQUEIDENTIFIER
SET @sqlguid = '5A8E87F1-24EF-4DF4-9961-BB9DE1FC4507'

--DECLARE @newsqlcmd AS VARCHAR (max)
SET @newsqlcmd = 'SELECT  h.PartnerID ,
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
WHERE   DATEPART(YEAR, ImportDate) = DATEPART(YEAR,
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
ORDER BY SUM(y.EstBaseTotalDeclarationDuty) DESC'




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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          N'Countries of Import by Duty - YoY' , -- Description - nvarchar(100)
          N'This comparison report shows the countries of import with the highest associated total duty paid on all declarations filed for the current year compared to the highest associated total duty paid on all declarations filed for the previous year. ' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          N'Countries of Import by Duty - YoY' , -- Description - nvarchar(100)
          N'This comparison report shows the countries of import with the highest associated total duty paid on all declarations filed for the current year compared to the highest associated total duty paid on all declarations filed for the previous year. ' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

----------------------------------------------------------Countries of Import by Duty - YoY---------------------------------------------------------



------------------------------------Importers by Duty - YoY----------------------------------------
--DECLARE @sqlguid AS UNIQUEIDENTIFIER
SET @sqlguid = '0ED40C23-1698-4603-A577-87939A99BAAD'

--DECLARE @newsqlcmd AS VARCHAR (max)
SET @newsqlcmd = 'SELECT  h.PartnerID ,
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
WHERE   DATEPART(YEAR, ImportDate) = DATEPART(YEAR,
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
ORDER BY SUM(y.EstBaseTotalDeclarationDuty) DESC  '


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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          N'Importers by Duty - YoY' , -- Description - nvarchar(100)
          N'This comparison report shows the importers with the highest associated total duty paid on all declarations filed for the current year compared to the highest associated total duty paid on all declarations filed for the previous year.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          N'Importers by Duty - YoY' , -- Description - nvarchar(100)
          N'This comparison report shows the importers with the highest associated total duty paid on all declarations filed for the current year compared to the highest associated total duty paid on all declarations filed for the previous year.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

----------------------------------------------------------Importers by Duty - YoY---------------------------------------------------------



------------------------------------Top Brokers by Duty----------------------------------------
--DECLARE @sqlguid AS UNIQUEIDENTIFIER
SET @sqlguid = '8742A4AC-0423-4698-A828-CE229631BB48'

--DECLARE @newsqlcmd AS VARCHAR (max)
SET @newsqlcmd = 'SELECT TOP 5
        h.BrokerName ,
        CAST(SUM(d.EstBaseTotalLineDuty) AS NUMERIC(28, 2)) AS [EstBaseTotalDuty (@CurrencyCode)]
FROM    txdGVImportHeader h WITH ( NOLOCK )
JOIN dbo.txdGVImportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.EntryGuid = h.EntryGuid
WHERE 1=1 AND @IMPORTDATERANGE AND h.PartnerID = @PartnerID 
GROUP BY h.BrokerName
ORDER BY SUM(d.EstBaseTotalLineDuty) DESC'




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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          N'Top Brokers by Duty' , -- Description - nvarchar(100)
          N'This report shows the brokers with the highest associated total duty paid on all declarations filed.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          N'Top Brokers by Duty' , -- Description - nvarchar(100)
          N'This report shows the brokers with the highest associated total duty paid on all declarations filed.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

----------------------------------------------------------Top Brokers by Duty---------------------------------------------------------



------------------------------------Top Ports of Unlading by Duty - YoY----------------------------------------
--DECLARE @sqlguid AS UNIQUEIDENTIFIER
SET @sqlguid = '9FB2056C-BF01-418A-BE00-B2ECE29D2008'

--DECLARE @newsqlcmd AS VARCHAR (max)
SET @newsqlcmd = 'SELECT  d.PartnerID ,
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
WHERE   DATEPART(YEAR, h.ImportDate) = DATEPART(YEAR,
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
ORDER BY SUM(y.EstBaseTotalDeclarationDuty) DESC'




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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          N'Top Ports of Unlading by Duty - YoY' , -- Description - nvarchar(100)
          N'This comparison report shows the ports of unlading with the highest associated total duty paid on all declarations filed for the current year compared to the highest associated total duty paid on all declarations filed for the previous year. ' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          N'Top Ports of Unlading by Duty - YoY' , -- Description - nvarchar(100)
          N'This comparison report shows the ports of unlading with the highest associated total duty paid on all declarations filed for the current year compared to the highest associated total duty paid on all declarations filed for the previous year. ' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

----------------------------------------------------------Top Ports of Unlading by Duty - YoY---------------------------------------------------------



------------------------------------Top Value Exported by INCO Term----------------------------------------
--DECLARE @sqlguid AS UNIQUEIDENTIFIER
SET @sqlguid = 'CF1A470E-665F-4D9D-8739-DF2E5BDE76DF'

--DECLARE @newsqlcmd AS VARCHAR (max)
SET @newsqlcmd = 'SELECT TOP 10
        h.INCOTerms ,
        CAST(SUM(d.EstBaseTotalLineValue) AS NUMERIC(20, 2)) AS [EstBaseTotalShipmentValue(@CurrencyCode)]
FROM    txdGVExportHeader h WITH ( NOLOCK )
JOIN dbo.txdGVExportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.ExportGUID = h.ExportGuid
WHERE 1=1 AND @EXPORTDATERANGE AND h.PartnerID = @PartnerID 
GROUP BY h.INCOTerms
ORDER BY SUM(d.EstBaseTotalLineValue) DESC'


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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          N'Top Value Exported by INCO Term' , -- Description - nvarchar(100)
          N'This report shows the top INCOterms associated with the highest estimated base total Shipment Value exported during the reporting period and the estimated base total value of the shipments made for each product.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          N'Top Value Exported by INCO Term' , -- Description - nvarchar(100)
          N'This report shows the top INCOterms associated with the highest estimated base total Shipment Value exported during the reporting period and the estimated base total value of the shipments made for each product.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

----------------------------------------------------------Top Value Exported by INCO Term---------------------------------------------------------



------------------------------------Total Weight Shipped By Carrier----------------------------------------
--DECLARE @sqlguid AS UNIQUEIDENTIFIER
SET @sqlguid = '4294C1CF-1AD2-494C-BE1F-03D010E8FD04'

--DECLARE @newsqlcmd AS VARCHAR (max)
SET @newsqlcmd = 'SELECT TOP 10
        h.CarrierName ,
        CAST(SUM(d.NetWeight) AS NUMERIC(28, 0)) AS TotalWeightShipped
FROM    txdGVExportHeader h WITH ( NOLOCK )
JOIN dbo.txdGVExportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.ExportGUID = h.ExportGuid
WHERE 1=1 AND @EXPORTDATERANGE AND h.PartnerID = @PartnerID  
GROUP BY h.CarrierName
ORDER BY SUM(d.NetWeight) DESC'


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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          N'Total Weight Shipped By Carrier' , -- Description - nvarchar(100)
          N'This report shows the top Carriers associated with the greatest total weight shipped during the reporting period and the total weight of shipments made for each Carrier.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          N'Total Weight Shipped By Carrier' , -- Description - nvarchar(100)
          N'This report shows the top Carriers associated with the greatest total weight shipped during the reporting period and the total weight of shipments made for each Carrier.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

----------------------------------------------------------Total Weight Shipped By Carrier---------------------------------------------------------



------------------------------------Total Weight Shipped by Import Country----------------------------------------
--DECLARE @sqlguid AS UNIQUEIDENTIFIER
SET @sqlguid = 'E2B1AA7F-E457-49B6-99DB-D6E778831E52'

--DECLARE @newsqlcmd AS VARCHAR (max)
SET @newsqlcmd = 'SELECT TOP 10
        h.ImportCountry ,
        CAST(SUM(d.NetWeight) AS NUMERIC(28, 0)) AS TotalWeightShipped
FROM    txdGVExportHeader h WITH ( NOLOCK )
JOIN dbo.txdGVExportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.ExportGUID = h.ExportGuid
WHERE 1=1 AND @EXPORTDATERANGE AND h.PartnerID = @PartnerID  
GROUP BY h.ImportCountry
ORDER BY SUM(d.NetWeight) DESC'




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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          N'Total Weight Shipped by Import Country' , -- Description - nvarchar(100)
          N'This report shows the top Import Countries associated with the greatest total weight shipped during the reporting period and the total weight of shipments made for each Import Country.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          N'Total Weight Shipped by Import Country' , -- Description - nvarchar(100)
          N'This report shows the top Import Countries associated with the greatest total weight shipped during the reporting period and the total weight of shipments made for each Import Country.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

----------------------------------------------------------Total Weight Shipped by Import Country---------------------------------------------------------



------------------------------------Total Weight Shipped by Port of Lading----------------------------------------
--DECLARE @sqlguid AS UNIQUEIDENTIFIER
SET @sqlguid = '9039498D-C4F9-4553-87E9-6BC6E64CCC93'

--DECLARE @newsqlcmd AS VARCHAR (max)
SET @newsqlcmd = 'SELECT TOP 10
        h.PortOfLading ,
        CAST(SUM(d.NetWeight) AS NUMERIC(28, 0)) AS TotalWeightShipped
FROM    txdGVExportHeader h WITH ( NOLOCK )
JOIN dbo.txdGVExportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.ExportGUID = h.ExportGuid
WHERE 1=1 AND @EXPORTDATERANGE AND h.PartnerID = @PartnerID 
GROUP BY h.PortOfLading
ORDER BY SUM(d.NetWeight) DESC'



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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          N'Total Weight Shipped by Port of Lading' , -- Description - nvarchar(100)
          N'This report shows the top Ports of Lading associated with the greatest total weight shipped during the reporting period and the total weight of shipments made for each Port of Lading.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          N'Total Weight Shipped by Port of Lading' , -- Description - nvarchar(100)
          N'This report shows the top Ports of Lading associated with the greatest total weight shipped during the reporting period and the total weight of shipments made for each Port of Lading.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

----------------------------------------------------------Total Weight Shipped by Port of Lading---------------------------------------------------------



------------------------------------Value Exported by INCOTerm - YoY ----------------------------------------
--DECLARE @sqlguid AS UNIQUEIDENTIFIER
SET @sqlguid = '76EBE768-0A42-4D15-B18B-4566E4FD3D1E'

--DECLARE @newsqlcmd AS VARCHAR (max)
SET @newsqlcmd = 'SELECT  h.PartnerID ,
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
WHERE   DATEPART(YEAR, ExportDate) = DATEPART(YEAR,
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
ORDER BY SUM(y.EstBaseTotalShipmentValue) DESC'


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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          N'Value Exported by INCOTerm - YoY ' , -- Description - nvarchar(100)
          N'This comparison report shows the INCOterms with the highest associated total Shipment Value on all shipments for the current calendar year compared to the associated total Shipment Value on all shipments filed for the previous calendar year. ' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          N'Value Exported by INCOTerm - YoY ' , -- Description - nvarchar(100)
          N'This comparison report shows the INCOterms with the highest associated total Shipment Value on all shipments for the current calendar year compared to the associated total Shipment Value on all shipments filed for the previous calendar year. ' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

----------------------------------------------------------Value Exported by INCOTerm - YoY ---------------------------------------------------------



------------------------------------Weight Shipped by Carrier - YoY----------------------------------------
--DECLARE @sqlguid AS UNIQUEIDENTIFIER
SET @sqlguid = 'F6F31106-673A-41BE-9ED5-553CA0F308A2'

--DECLARE @newsqlcmd AS VARCHAR (max)
SET @newsqlcmd = 'SELECT  h.PartnerID ,
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
WHERE   DATEPART(YEAR, ExportDate) = DATEPART(YEAR,
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
ORDER BY SUM(y.TotalWeightShipped) DESC'





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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          N'Weight Shipped by Carrier - YoY' , -- Description - nvarchar(100)
          N'This comparison report shows all Carriers and the associated total weight shipped during the current year to date compared to the total weight shipped during the previous year.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          N'Weight Shipped by Carrier - YoY' , -- Description - nvarchar(100)
          N'This comparison report shows all Carriers and the associated total weight shipped during the current year to date compared to the total weight shipped during the previous year.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

----------------------------------------------------------Weight Shipped by Carrier - YoY---------------------------------------------------------
	


------------------------------------Weight Shipped by ECN Number - YoY----------------------------------------
--DECLARE @sqlguid AS UNIQUEIDENTIFIER
SET @sqlguid = 'CF330AB3-D9ED-4B36-9AA8-3CA19963A225'

--DECLARE @newsqlcmd AS VARCHAR (max)
SET @newsqlcmd = 'SELECT  h.PartnerID ,
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
WHERE   DATEPART(YEAR, ExportDate) = DATEPART(YEAR,
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
ORDER BY SUM(y.TotalWeightShipped) DESC'




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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          N'Weight Shipped by ECN Number - YoY' , -- Description - nvarchar(100)
          N'This comparison report shows all ECN Numbers and the associated total weight shipped during the current year to date compared to the total weight shipped during the previous year.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          N'Weight Shipped by ECN Number - YoY' , -- Description - nvarchar(100)
          N'This comparison report shows all ECN Numbers and the associated total weight shipped during the current year to date compared to the total weight shipped during the previous year.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

----------------------------------------------------------Weight Shipped by ECN Number - YoY---------------------------------------------------------



------------------------------------Weight Shipped by Forwarder - YoY----------------------------------------
--DECLARE @sqlguid AS UNIQUEIDENTIFIER
SET @sqlguid = 'DA103C15-C678-4917-A6E1-5D672FE032D4'

--DECLARE @newsqlcmd AS VARCHAR (max)
SET @newsqlcmd = 'SELECT  h.PartnerID ,
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
WHERE   DATEPART(YEAR, ExportDate) = DATEPART(YEAR,
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
ORDER BY SUM(y.TotalWeightShipped) DESC'



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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          N'Weight Shipped by Forwarder - YoY' , -- Description - nvarchar(100)
          N'This comparison report shows all Forwarders and the associated total weight shipped during the current year to date compared to the total weight shipped during the previous year.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          N'Weight Shipped by Forwarder - YoY' , -- Description - nvarchar(100)
          N'This comparison report shows all Forwarders and the associated total weight shipped during the current year to date compared to the total weight shipped during the previous year.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

----------------------------------------------------------Weight Shipped by Forwarder - YoY---------------------------------------------------------



------------------------------------Weight Shipped by Import Country - YoY----------------------------------------
--DECLARE @sqlguid AS UNIQUEIDENTIFIER
SET @sqlguid = '456F550E-59DC-417E-9C64-29339D6F16AE'

--DECLARE @newsqlcmd AS VARCHAR (max)
SET @newsqlcmd = 'SELECT  h.PartnerID ,
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
WHERE   DATEPART(YEAR, ExportDate) = DATEPART(YEAR,
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
ORDER BY SUM(y.TotalWeightShipped) DESC'


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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          N'Weight Shipped by Import Country - YoY' , -- Description - nvarchar(100)
          N'This comparison report shows all Forwarders and the associated total weight shipped during the current year to date compared to the total weight shipped during the previous year.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          N'Weight Shipped by Import Country - YoY' , -- Description - nvarchar(100)
          N'This comparison report shows all Forwarders and the associated total weight shipped during the current year to date compared to the total weight shipped during the previous year.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

----------------------------------------------------------Weight Shipped by Import Country - YoY---------------------------------------------------------



------------------------------------Weight Shipped by Por of Lading - YoY----------------------------------------
--DECLARE @sqlguid AS UNIQUEIDENTIFIER
SET @sqlguid = 'B32803D4-24FE-4C93-9CFE-75F7836480E2'

--DECLARE @newsqlcmd AS VARCHAR (max)
SET @newsqlcmd = 'SELECT  h.PartnerID ,
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
WHERE   DATEPART(YEAR, ExportDate) = DATEPART(YEAR,
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
ORDER BY SUM(y.TotalWeightShipped) DESC'



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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          N'Weight Shipped by Por of Lading - YoY' , -- Description - nvarchar(100)
          N'This comparison report shows all Ports of Lading and the associated total weight shipped during the current year to date compared to the total weight shipped during the previous year.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          N'Weight Shipped by Por of Lading - YoY' , -- Description - nvarchar(100)
          N'This comparison report shows all Ports of Lading and the associated total weight shipped during the current year to date compared to the total weight shipped during the previous year.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

----------------------------------------------------------Weight Shipped by Por of Lading - YoY---------------------------------------------------------



------------------------------------Weight Shipped by Product Number - YoY----------------------------------------
--DECLARE @sqlguid AS UNIQUEIDENTIFIER
SET @sqlguid = '6C120482-645E-4473-B85A-BCEE534B6B0B'

--DECLARE @newsqlcmd AS VARCHAR (max)
SET @newsqlcmd = 'SELECT  h.PartnerID ,
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
WHERE   DATEPART(YEAR, ExportDate) = DATEPART(YEAR,
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
ORDER BY SUM(y.TotalWeightShipped) DESC'




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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          N'Weight Shipped by Product Number - YoY' , -- Description - nvarchar(100)
          N'This comparison report shows all Product Numbers and the associated total weight shipped during the current year to date compared to the total weight shipped during the previous year.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          N'Weight Shipped by Product Number - YoY' , -- Description - nvarchar(100)
          N'This comparison report shows all Product Numbers and the associated total weight shipped during the current year to date compared to the total weight shipped during the previous year.' , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          'kduval' , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

----------------------------------------------------------Weight Shipped by Product Number - YoY---------------------------------------------------------


DECLARE @reportdesc NVARCHAR(100)
DECLARE @reportlongdesc NVARCHAR(max)
DECLARE @user VARCHAR(10) = 'jmurillo'

------------------------------------ All ImporterID by Duty ----------------------------------------
SET @reportdesc = N'All ImporterID by Duty'
SET @reportlongdesc = N'This report shows all importer IDs and the associated total line duty paid on all declarations filed, volume of declarations, and the average duty paid per declaration for each importer ID.'
SET @sqlguid = 'CBD0B451-E59B-4801-8965-3F753D96FE86'
SET @newsqlcmd = 'SELECT  h.ImporterID ,
	CAST(SUM(d.EstBaseTotalLineDuty) AS NUMERIC(28, 2)) as [EstBaseTotalDuty (@CurrencyCode)]  ,
	COUNT(DISTINCT h.EntryGUID) AS DeclarationCount  ,
	CAST(SUM(d.EstBaseTotalLineDuty)/COUNT(DISTINCT h.EntryGUID) as Numeric(28,2)) as [EstBaseAvgDutyPerDeclaration (@CurrencyCode)] 
FROM txdGVImportHeader h WITH (NOLOCK)
JOIN txdGVImportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.EntryGUID = h.EntryGUID
WHERE 1=1 AND @IMPORTDATERANGE AND h.PartnerID = @PartnerID 
GROUP BY h.ImporterID 
ORDER BY SUM(d.EstBaseTotalLineDuty) DESC'

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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          @reportdesc , -- Description - nvarchar(100)
          @reportlongdesc , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @user , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          @reportdesc , -- Description - nvarchar(100)
          @reportlongdesc , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @user , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

----------------------------------------------------------All ImporterID by Duty ---------------------------------------------------------

------------------------------------ ImporterID by Duty - YoY ----------------------------------------
SET @reportdesc = N'ImporterID by Duty - YoY'
SET @reportlongdesc = N'This comparison report shows the importer IDs with the highest associated total duty paid on all declarations filed for the current year compared to the highest associated total duty paid on all declarations filed for the previous year.'
SET @sqlguid = '5E8B3FA5-4A24-4453-AFBC-BC2E83FD27B1'
SET @newsqlcmd = 'SELECT h.PartnerID  ,
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
WHERE datepart(year, ImportDate) = DATEPART(year, dateadd(year, - 1, GetDate()))    and ImportDate <= (GETDATE()-365) 
GROUP BY h.PartnerID  ,h.ImporterID  ,datepart(year, ImportDate)  

SELECT TOP 10 d.ImporterID  ,
	isnull(sum(d.EstBaseTotalDeclarationDuty), 0) AS [@CurrentYear]  ,
	isnull(sum(d2.EstBaseTotalDeclarationDuty), 0) AS [@LastYear] 
FROM #CurrentYearID d 
LEFT JOIN #LastYearID d2   
ON d.PartnerID = d2.PartnerID AND d.ImporterID = d2.ImporterID
GROUP BY d.ImporterID 
ORDER BY sum(d.EstBaseTotalDeclarationDuty) DESC'



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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          @reportdesc , -- Description - nvarchar(100)
          @reportlongdesc , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @user , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          @reportdesc , -- Description - nvarchar(100)
          @reportlongdesc , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @user , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

---------------------------------------------------------- ImporterID by Duty - YoY ---------------------------------------------------------
	
------------------------------------ Top Countries of Import by Duty ----------------------------------------
SET @reportdesc = N'Top Countries of Import by Duty'
SET @reportlongdesc = N'This report shows the countries of import with the highest associated total duty paid on all declarations filed.'
SET @sqlguid = '85DAFC76-A60F-45DD-9312-A718EDA70703'
SET @newsqlcmd = 'SELECT TOP 10 h.ImportCountry  ,
	CAST(SUM(d.EstBaseTotalLineDuty) AS NUMERIC(28, 2)) as [EstBaseTotalDuty (@CurrencyCode)] 
FROM txdGVImportHeader h WITH (NOLOCK) 
JOIN txdGVImportDetail d WITH (NOLOCK)
  ON h.PartnerID = d.PartnerID AND h.EntryGuid = d.EntryGuid
WHERE 1=1 AND @IMPORTDATERANGE AND h.PartnerID = @PartnerID 
GROUP BY h.ImportCountry 
ORDER BY SUM(d.EstBaseTotalLineDuty) DESC'



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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          @reportdesc , -- Description - nvarchar(100)
          @reportlongdesc , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @user , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          @reportdesc , -- Description - nvarchar(100)
          @reportlongdesc , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @user , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

---------------------------------------------------------- Top Countries of Import by Duty ---------------------------------------------------------

------------------------------------ Top ImporterID by Duty ----------------------------------------
SET @reportdesc = N'Top ImporterID by Duty'
SET @reportlongdesc = N'This report shows the importer IDs with the highest associated total duty paid on all declarations filed.'
SET @sqlguid = '1F0A131C-4013-4FDA-8F50-F4C1A09F4D7F'
SET @newsqlcmd = 'SELECT TOP 5 h.ImporterID  ,
	CAST(SUM(d.EstBaseTotalLineDuty) AS NUMERIC(28, 2)) as [EstBaseTotalDuty (@CurrencyCode)] 
FROM txdGVImportHeader h WITH (NOLOCK) 
JOIN txdGVImportDetail d WITH (NOLOCK)
  ON h.PartnerID = d.PartnerID AND h.EntryGuid = d.EntryGuid
WHERE 1=1 AND @IMPORTDATERANGE AND h.PartnerID = @PartnerID 
GROUP BY h.ImporterID 
ORDER BY SUM(d.EstBaseTotalLineDuty) DESC'



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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          @reportdesc , -- Description - nvarchar(100)
          @reportlongdesc , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @user , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          @reportdesc , -- Description - nvarchar(100)
          @reportlongdesc , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @user , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

---------------------------------------------------------- Top ImporterID by Duty ---------------------------------------------------------

------------------------------------ Top Importers by Duty ----------------------------------------
SET @reportdesc = N'Top Importers by Duty'
SET @reportlongdesc = N'This report shows the importers with the highest associated total duty paid on all declarations filed.'
SET @sqlguid = '922DF93D-CCDD-4108-868E-8489F2E43EDA'
SET @newsqlcmd = 'SELECT TOP 5 h.ImporterName  ,
	CAST(SUM(d.EstBaseTotalLineDuty) AS NUMERIC(28, 2)) as [EstBaseTotalDuty (@CurrencyCode)] 
FROM txdGVImportHeader h WITH (NOLOCK) 
JOIN txdGVImportDetail d WITH (NOLOCK)
  ON h.PartnerID = d.PartnerID AND h.EntryGuid = d.EntryGuid
WHERE 1=1 AND @IMPORTDATERANGE AND h.PartnerID = @PartnerID 
GROUP BY h.ImporterName 
ORDER BY SUM(d.EstBaseTotalLineDuty) DESC'



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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          @reportdesc , -- Description - nvarchar(100)
          @reportlongdesc , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @user , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          @reportdesc , -- Description - nvarchar(100)
          @reportlongdesc , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @user , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

---------------------------------------------------------- Top Importers by Duty ---------------------------------------------------------

------------------------------------ All Brokers by Fees ----------------------------------------
SET @reportdesc = N'All Brokers by Fees'
SET @reportlongdesc = N'This report shows all brokers and the associated total fees paid on all declarations filed, volume of declarations, and the average fees paid per declaration for each broker.'
SET @sqlguid = '240BFB01-BF73-41E5-BC80-F5673A4030EA'
SET @newsqlcmd = 'SELECT h.BrokerName  ,
  CAST(SUM(d.EstBaseFees) AS NUMERIC(28, 2)) AS [EstBaseTotalFees(@CurrencyCode)]  ,
  COUNT(DISTINCT h.EntryGUID) AS DeclarationCount  ,
  CAST(SUM(d.EstBaseFees) / COUNT(DISTINCT h.EntryGUID) AS NUMERIC(28, 2)) AS [EstBaseAvgFeesPerDeclaration (@CurrencyCode)] 
FROM txdGVImportHeader h WITH (NOLOCK)
JOIN txdGVImportDetail d WITH (NOLOCK)
  ON h.PartnerID = d.PartnerID AND h.EntryGuid = d.EntryGuid
WHERE 1=1 AND @IMPORTDATERANGE AND h.PartnerID = @PartnerID 
GROUP BY h.BrokerName 
ORDER BY SUM(d.EstBaseFees) DESC'



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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          @reportdesc , -- Description - nvarchar(100)
          @reportlongdesc , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @user , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          @reportdesc , -- Description - nvarchar(100)
          @reportlongdesc , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @user , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

---------------------------------------------------------- All Brokers by Fees ---------------------------------------------------------

------------------------------------ All Countries of Import by Fees ----------------------------------------
SET @reportdesc = N'All Countries of Import by Fees'
SET @reportlongdesc = N'This report shows all countries of import and the associated total fees paid on all declarations filed, volume of declarations, and the average fees paid per declaration for each country of import.'
SET @sqlguid = '7B6A08D3-D0DF-4641-A4EE-27CD6C6C4CEE'
SET @newsqlcmd = 'SELECT h.ImportCountry  ,
  CAST(SUM(d.EstBaseFees) AS NUMERIC(28, 2)) AS [EstBaseTotalFees (@CurrencyCode)]  ,
  COUNT(DISTINCT h.EntryGUID) AS DeclarationCount  ,
  CAST(SUM(d.EstBaseFees) / COUNT(DISTINCT h.EntryGUID) AS NUMERIC(28, 2)) AS [EstBaseAvgFeesPerDeclaration (@CurrencyCode)] 
FROM txdGVImportHeader h WITH (NOLOCK)
JOIN txdGVImportDetail d WITH (NOLOCK)
  ON h.PartnerID = d.PartnerID AND h.EntryGuid = d.EntryGuid
WHERE 1=1 AND @IMPORTDATERANGE AND h.PartnerID = @PartnerID 
GROUP BY h.ImportCountry 
ORDER BY SUM(d.EstBaseFees) DESC'



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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          @reportdesc , -- Description - nvarchar(100)
          @reportlongdesc , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @user , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          @reportdesc , -- Description - nvarchar(100)
          @reportlongdesc , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @user , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

---------------------------------------------------------- All Countries of Import by Fees ---------------------------------------------------------

------------------------------------ All ImporterID by Fees ----------------------------------------
SET @reportdesc = N'All ImporterID by Fees'
SET @reportlongdesc = N'This report shows all importer IDs and the associated total fees paid on all declarations filed, volume of declarations, and the average fees paid per declaration for each importer ID.  '
SET @sqlguid = '6D2B6AB3-9609-4983-BB32-B5CFDE293414'
SET @newsqlcmd = 'SELECT h.ImporterID  ,
  CAST(SUM(d.EstBaseFees) AS NUMERIC(28, 2)) AS [EstBaseTotalFees (@CurrencyCode)]  ,
  COUNT(DISTINCT h.EntryGUID) AS DeclarationCount  ,
  CAST(SUM(d.EstBaseFees) / COUNT(DISTINCT h.EntryGUID) AS NUMERIC(28, 2)) AS [EstBaseAvgFeesPerDeclaration (@CurrencyCode)] 
FROM txdGVImportHeader h WITH (NOLOCK)
JOIN txdGVImportDetail d WITH (NOLOCK)
  ON h.PartnerID = d.PartnerID AND h.EntryGuid = d.EntryGuid 
WHERE 1=1 AND @IMPORTDATERANGE AND h.PartnerID = @PartnerID 
GROUP BY h.ImporterID 
ORDER BY SUM(d.EstBaseFees) DESC'



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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          @reportdesc , -- Description - nvarchar(100)
          @reportlongdesc , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @user , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          @reportdesc , -- Description - nvarchar(100)
          @reportlongdesc , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @user , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

---------------------------------------------------------- All ImporterID by Fees ---------------------------------------------------------

------------------------------------ All Brokers By Value ----------------------------------------
SET @reportdesc = N'All Brokers By Value'
SET @reportlongdesc = N'This report shows all brokers and the associated total line value on all declarations filed, volume of declarations, and the average value per declaration for each broker.'
SET @sqlguid = '7D0F3F99-64D3-4A41-A378-FE35E30367F2'
SET @newsqlcmd = 'SELECT   h.BrokerName,  
  CAST(SUM(d.EstBaseTotalLineValue) as Numeric(28,2)) as [EstBaseTotalValue (@CurrencyCode)],   
  COUNT(DISTINCT h.EntryGUID) AS DeclarationCount,   
  CAST(SUM(d.EstBaseTotalLineValue)/COUNT(DISTINCT h.EntryGUID) as Numeric(28,2)) as [EstBaseAvgValuePerDeclaration (@CurrencyCode)] 
FROM txdGVImportHeader h WITH (NOLOCK) 
JOIN txdGVImportDetail d WITH (NOLOCK)
  ON h.PartnerID = d.PartnerID AND h.EntryGuid = d.EntryGuid
WHERE 1=1 AND @IMPORTDATERANGE AND h.PartnerID = @PartnerID  
GROUP BY h.BrokerName  
ORDER BY SUM(d.EstBaseTotalLineValue) DESC'



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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          @reportdesc , -- Description - nvarchar(100)
          @reportlongdesc , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @user , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          @reportdesc , -- Description - nvarchar(100)
          @reportlongdesc , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @user , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

---------------------------------------------------------- All Brokers By Value ---------------------------------------------------------

------------------------------------ All Countries Of Import By Value ----------------------------------------
SET @reportdesc = N'All Countries Of Import By Value'
SET @reportlongdesc = N'This report shows all countries of import and the associated total line value on all declarations filed, volume of declarations, and the average value per declaration for each country of import.'
SET @sqlguid = 'C1A876A4-30E8-4884-9A26-3BF52DF389F0'
SET @newsqlcmd = 'SELECT   h.ImportCountry,   
  CAST(SUM(d.EstBaseTotalLineValue) as Numeric(28,2)) as [EstBaseTotalValue (@CurrencyCode)],           
  COUNT(DISTINCT h.EntryGUID) AS DeclarationCount,  
  CAST(SUM(d.EstBaseTotalLineValue)/COUNT(DISTINCT h.EntryGUID) as Numeric(28,2)) as [EstBaseAvgValuePerDeclaration (@CurrencyCode)] 
FROM txdGVImportHeader h WITH (NOLOCK)
JOIN txdGVImportDetail d WITH (NOLOCK)
  ON h.PartnerID = d.PartnerID AND h.EntryGuid = d.EntryGuid  
WHERE 1=1 AND h.PartnerID = @PartnerID AND @IMPORTDATERANGE  
GROUP BY h.ImportCountry   
ORDER BY SUM(d.EstBaseTotalLineValue) DESC'



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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          @reportdesc , -- Description - nvarchar(100)
          @reportlongdesc , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @user , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          @reportdesc , -- Description - nvarchar(100)
          @reportlongdesc , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @user , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

---------------------------------------------------------- All Countries Of Import By Value ---------------------------------------------------------

------------------------------------ All ImporterID by Value ----------------------------------------
SET @reportdesc = N'All ImporterID by Value'
SET @reportlongdesc = N'This report shows all importer IDs and the associated total line value on all declarations filed, volume of declarations, and the average value per declaration for each importer ID.'
SET @sqlguid = 'D3B771BB-3B1C-4256-B2D9-A66A5A616340'
SET @newsqlcmd = 'SELECT   h.ImporterID,  
  CAST(SUM(d.EstBaseTotalLineValue) as Numeric(28,2)) as [EstBaseTotalDeclarationValue (@CurrencyCode)],          
  COUNT(DISTINCT h.EntryGUID) AS DeclarationCount,  
  CAST(SUM(d.EstBaseTotalLineValue)/COUNT(DISTINCT h.EntryGUID) as Numeric(28,2)) as [EstBaseAvgValuePerDeclaration (@CurrencyCode)] 
FROM txdGVImportHeader h WITH (NOLOCK)
JOIN txdGVImportDetail d WITH (NOLOCK)
  ON h.PartnerID = d.PartnerID AND h.EntryGuid = d.EntryGuid
WHERE 1=1 AND @IMPORTDATERANGE AND h.PartnerID = @PartnerID 
GROUP BY h.ImporterID   
ORDER BY SUM(d.EstBaseTotalLineValue) DESC'



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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          @reportdesc , -- Description - nvarchar(100)
          @reportlongdesc , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @user , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          @reportdesc , -- Description - nvarchar(100)
          @reportlongdesc , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @user , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

---------------------------------------------------------- All ImporterID by Value ---------------------------------------------------------

------------------------------------ All Importers by Import Value ----------------------------------------
SET @reportdesc = N'All Importers by Import Value'
SET @reportlongdesc = N'This report shows all importers and the associated total line value on all declarations filed, volume of declarations, and the average value per declaration for each importer.'
SET @sqlguid = 'F32FB287-B7D9-4E63-9E31-DA2AE4BB218F'
SET @newsqlcmd = 'SELECT   h.ImporterName,  
  CAST(SUM(d.EstBaseTotalLineValue) as Numeric(28,2)) as [EstBaseTotalDeclarationValue (@CurrencyCode)],          
  COUNT(DISTINCT h.EntryGUID) AS DeclarationCount,  
  CAST(SUM(d.EstBaseTotalLineValue)/COUNT(DISTINCT h.EntryGUID) as Numeric(28,2)) as [EstBaseAvgValuePerDeclaration (@CurrencyCode)] 
FROM txdGVImportHeader h WITH (NOLOCK)
JOIN txdGVImportDetail d WITH (NOLOCK)
  ON h.PartnerID = d.PartnerID AND h.EntryGuid = d.EntryGuid 
WHERE 1=1 AND @IMPORTDATERANGE AND h.PartnerID = @PartnerID 
GROUP BY h.ImporterName   
ORDER BY SUM(d.EstBaseTotalLineValue) DESC'



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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          @reportdesc , -- Description - nvarchar(100)
          @reportlongdesc , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @user , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          @reportdesc , -- Description - nvarchar(100)
          @reportlongdesc , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @user , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

---------------------------------------------------------- All Importers by Import Value ---------------------------------------------------------

------------------------------------ Brokers by Value - YoY ----------------------------------------
SET @reportdesc = N'Brokers by Value - YoY'
SET @reportlongdesc = N'This comparison report shows the brokers with the highest associated total declaration value on all declarations filed for the current year compared to the highest associated total declaration value on all declarations filed for the previous year. '
SET @sqlguid = '112F07D0-911C-4A5D-A6FA-39EEAC4F5597'
SET @newsqlcmd = 'select h.PartnerID, 
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
WHERE        datepart(year, h.ImportDate) =  DATEPART(year, dateadd(year, -1, GetDate())) 
  and ImportDate <= (GETDATE()-365) 
group by h.PartnerID, h.BrokerName, datepart(year, h.ImportDate)   

SELECT TOP 10 d.BrokerName,         
  isnull(sum(d.EstBaseTotalDeclarationValue), 0) as [@CurrentYear],       
  isnull(sum(d2.EstBaseTotalDeclarationValue), 0) as [@LastYear] 
FROM #CurrentYear d 
left join #LastYear d2 
  on d.BrokerName = d2.BrokerName and d.PartnerID = d2.PartnerID 
Group By d.BrokerName 
ORDER BY sum(d.EstBaseTotalDeclarationValue) DESC'



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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          @reportdesc , -- Description - nvarchar(100)
          @reportlongdesc , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @user , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          @reportdesc , -- Description - nvarchar(100)
          @reportlongdesc , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @user , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

---------------------------------------------------------- Brokers by Value - YoY ---------------------------------------------------------

------------------------------------ Countries of Import by Import Value - YoY ----------------------------------------
SET @reportdesc = N'Countries of Import by Import Value - YoY'
SET @reportlongdesc = N'This comparison report shows the countries of import with the highest associated total declaration value on all declarations filed for the current year compared to the highest associated total declaration value on all declarations filed for the previous year. '
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
WHERE datepart(year, ImportDate) = DATEPART(year, dateadd(year, - 1, GetDate()))  AND ImportDate <= (GETDATE() - 365) 
GROUP BY h.PartnerID  ,ImportCountry  ,datepart(year, ImportDate)  

SELECT TOP 10 d.ImportCountry  ,
  isnull(sum(d.EstBaseTotalDeclarationValue), 0) AS [@CurrentYear]  ,
  isnull(sum(d2.EstBaseTotalDeclarationValue), 0) AS [@LastYear] 
FROM #CurrentYear d 
LEFT JOIN #LastYear d2 ON d.ImportCountry = d2.ImportCountry  AND d.PartnerID = d2.PartnerID 
GROUP BY d.ImportCountry 
ORDER BY sum(d.EstBaseTotalDeclarationValue) DESC'



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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          @reportdesc , -- Description - nvarchar(100)
          @reportlongdesc , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @user , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          @reportdesc , -- Description - nvarchar(100)
          @reportlongdesc , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @user , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

---------------------------------------------------------- Countries of Import by Import Value - YoY ---------------------------------------------------------

------------------------------------ Importer by Import Value - YoY ----------------------------------------
SET @reportdesc = N'Importer by Import Value - YoY'
SET @reportlongdesc = N'This comparison report shows the Importers with the highest associated total declaration value on all declarations filed for the current year compared to the highest associated total declaration value on all declarations filed for the previous year.'
SET @sqlguid = '3617A554-5B1D-4F48-9339-5FC5710FC777'
SET @newsqlcmd = 'select   h.PartnerID, 
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
WHERE   datepart(year, ImportDate) =  DATEPART(year, dateadd(year, -1, GetDate())) and ImportDate <= (GETDATE()-365) 
group by h.PartnerID, ImporterName, datepart(year, ImportDate), datepart(month, ImportDate)   

SELECT TOP 10   d.ImporterName,    
  isnull(sum(d.EstBaseTotalDeclarationValue), 0) as [@CurrentYear],  
  isnull(sum(d2.EstBaseTotalDeclarationValue), 0) as [@LastYear] 
FROM #CurrentYearID d 
left join #LastYearID d2 
  on   d.ImporterName= d2.ImporterName and  d.ImportMonth = d2.ImportMonth and  d.PartnerID = d2.PartnerID 
  Group By d.ImporterName 
  ORDER BY sum(d.EstBaseTotalDeclarationValue) DESC'



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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          @reportdesc , -- Description - nvarchar(100)
          @reportlongdesc , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @user , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          @reportdesc , -- Description - nvarchar(100)
          @reportlongdesc , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @user , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

---------------------------------------------------------- Importer by Import Value - YoY ---------------------------------------------------------

------------------------------------ ImporterID by Value - YoY ----------------------------------------
SET @reportdesc = N'ImporterID by Value - YoY'
SET @reportlongdesc = N'This comparison report shows the Importer IDs with the highest associated total declaration value on all declarations filed for the current year compared to the highest associated total declaration value on all declarations filed for the previous year.'
SET @sqlguid = '42ACDE85-5C3C-4CE1-A5C9-228987C08ECF'
SET @newsqlcmd = 'SELECT h.PartnerID, 
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
WHERE datepart(year, ImportDate) =  DATEPART(year, dateadd(year, -1, GetDate())) and ImportDate <= (GETDATE()-365) 
group by h.PartnerID, ImporterID, datepart(year, ImportDate)   

SELECT TOP 10   d.ImporterID,    
  isnull(sum(d.EstBaseTotalDeclarationValue), 0) as [@CurrentYear],  
  isnull(sum(d2.EstBaseTotalDeclarationValue), 0) as [@LastYear] 
FROM #CurrentYearID d 
left join #LastYearID d2 
  on   d.ImporterID = d2.ImporterID and d.PartnerID = d2.PartnerID 
Group By d.ImporterID 
ORDER BY sum(d.EstBaseTotalDeclarationValue) DESC'



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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          @reportdesc , -- Description - nvarchar(100)
          @reportlongdesc , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @user , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          @reportdesc , -- Description - nvarchar(100)
          @reportlongdesc , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @user , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

---------------------------------------------------------- ImporterID by Value - YoY ---------------------------------------------------------

------------------------------------ Top Brokers by Value  ----------------------------------------
SET @reportdesc = N'Top Brokers by Value '
SET @reportlongdesc = N'This report shows the brokers with the highest associated total declaration value on all declarations filed.'
SET @sqlguid = '2B274B3A-9F3D-49F3-A7E1-09B46E6B1109'
SET @newsqlcmd = 'SELECT TOP 5   h.BrokerName,   
  CAST(SUM(d.EstBaseTotalLineValue) as Numeric(28,2)) as [EstBaseTotalValue (@CurrencyCode)] 
FROM txdGVImportHeader h WITH (NOLOCK)
JOIN txdGVImportDetail d WITH (NOLOCK)
  ON h.PartnerID = d.PartnerID AND h.EntryGuid = d.EntryGuid 
WHERE 1=1 AND @IMPORTDATERANGE AND h.PartnerID = @PartnerID  
GROUP BY h.BrokerName  
ORDER BY SUM(d.EstBaseTotalLineValue) DESC'



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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          @reportdesc , -- Description - nvarchar(100)
          @reportlongdesc , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @user , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          @reportdesc , -- Description - nvarchar(100)
          @reportlongdesc , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @user , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

---------------------------------------------------------- Top Brokers by Value  ---------------------------------------------------------

------------------------------------ Top Countries of Import by Import Value ----------------------------------------
SET @reportdesc = N'Top Countries of Import by Import Value'
SET @reportlongdesc = N'This report shows the countries of import with the highest associated total declaration value on all declarations filed. '
SET @sqlguid = '986C76C6-6661-4F13-9A7C-40FB9FE7FA08'
SET @newsqlcmd = 'SELECT TOP 10 h.ImportCountry  ,
  CAST(SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 2)) AS [EstBaseTotalValue (@CurrencyCode)] 
FROM txdGVImportHeader h WITH (NOLOCK)
JOIN txdGVImportDetail d WITH (NOLOCK)
  ON h.PartnerID = d.PartnerID AND h.EntryGuid = d.EntryGuid
WHERE 1=1 AND @IMPORTDATERANGE AND h.PartnerID = @PartnerID 
GROUP BY h.ImportCountry 
ORDER BY SUM(d.EstBaseTotalLineValue) DESC'



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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          @reportdesc , -- Description - nvarchar(100)
          @reportlongdesc , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @user , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          @reportdesc , -- Description - nvarchar(100)
          @reportlongdesc , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @user , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

---------------------------------------------------------- Top Countries of Import by Import Value ---------------------------------------------------------

------------------------------------ Top ImporterID by Value ----------------------------------------
SET @reportdesc = N'Top ImporterID by Value'
SET @reportlongdesc = N'This report shows the top ImporterIDs by total import value.'
SET @sqlguid = '8DFE3D72-EA92-430A-8157-3934B10B1ECF'
SET @newsqlcmd = 'SELECT TOP 5   h.ImporterID,  
  CAST(SUM(d.EstBaseTotalLineValue) as Numeric(28,2)) as [EstBaseTotalValue (@CurrencyCode)] 
FROM txdGVImportHeader h WITH (NOLOCK)
JOIN txdGVImportDetail d WITH (NOLOCK)
  ON h.PartnerID = d.PartnerID AND h.EntryGuid = d.EntryGuid
WHERE 1=1 AND @IMPORTDATERANGE AND h.PartnerID = @PartnerID 
GROUP BY h.ImporterID   
ORDER BY SUM(d.EstBaseTotalLineValue) DESC'



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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          @reportdesc , -- Description - nvarchar(100)
          @reportlongdesc , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @user , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          @reportdesc , -- Description - nvarchar(100)
          @reportlongdesc , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @user , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

---------------------------------------------------------- Top ImporterID by Value ---------------------------------------------------------

------------------------------------ Top Importers by Import Value ----------------------------------------
SET @reportdesc = N'Top Importers by Import Value'
SET @reportlongdesc = N'This report shows the top Importers by total import value.'
SET @sqlguid = '91CF0C35-FB40-4D37-B9D8-3A9A1B562B44'
SET @newsqlcmd = 'SELECT TOP 5   h.ImporterName,  
  CAST(SUM(d.EstBaseTotalLineValue) as Numeric(28,2)) as [EstBaseTotalValue (@CurrencyCode)] 
FROM txdGVImportHeader h WITH (NOLOCK)
JOIN txdGVImportDetail d WITH (NOLOCK)
  ON h.PartnerID = d.PartnerID AND h.EntryGuid = d.EntryGuid 
WHERE 1=1 AND @IMPORTDATERANGE AND h.PartnerID = @PartnerID 
GROUP BY h.ImporterName   
ORDER BY SUM(d.EstBaseTotalLineValue) DESC'



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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          @reportdesc , -- Description - nvarchar(100)
          @reportlongdesc , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @user , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          @reportdesc , -- Description - nvarchar(100)
          @reportlongdesc , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @user , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

---------------------------------------------------------- Top Importers by Import Value ---------------------------------------------------------

------------------------------------ All Value Exported by Inland Carrier ----------------------------------------
SET @reportdesc = N'All Value Exported by Inland Carrier'
SET @reportlongdesc = N'This report shows all Inland Carrier company names and the associated total line value on all shipments, the number of shipments, and the average value per shipment for each Inland Carrier. '
SET @sqlguid = 'EC89D672-ED65-45A5-B21E-9BFE8BC984F2'
SET @newsqlcmd = 'SELECT   h.InlandCarrierCompanyName,   
  CAST(SUM(d.EstBaseTotalLineValue) as Numeric(28,2)) as [EstBaseTotalShipmentValue(@CurrencyCode)],   
  COUNT(h.ExportGUID) AS TotalShipments,   
  CAST(SUM(d.EstBaseTotalLineValue)/COUNT(h.ExportGUID) as Numeric(28,2)) as [EstBaseAvgValuePerDeclaration(@CurrencyCode)]
FROM txdGVExportHeader h WITH (NOLOCK)
JOIN txdGVExportDetail d WITH (NOLOCK)
  ON h.PartnerID = d.PartnerID AND h.ExportGuid = d.ExportGuid
WHERE 1=1 AND @EXPORTDATERANGE AND h.PartnerID =  @PartnerID 
GROUP BY h.InlandCarrierCompanyName 
ORDER BY SUM(d.EstBaseTotalLineValue) DESC '



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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          @reportdesc , -- Description - nvarchar(100)
          @reportlongdesc , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @user , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          @reportdesc , -- Description - nvarchar(100)
          @reportlongdesc , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @user , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

---------------------------------------------------------- All Value Exported by Inland Carrier ---------------------------------------------------------

------------------------------------ Top Value Exported by Inland Carrier ----------------------------------------
SET @reportdesc = N'Top Value Exported by Inland Carrier'
SET @reportlongdesc = N'This report shows the top Inland Carriers associated with the highest estimated base total Shipment Value exported during the reporting period and the estimated base total value of the shipments made for each product.'
SET @sqlguid = '9CB96A91-113D-4D29-87DA-1CBA4924C01D'
SET @newsqlcmd = 'SELECT top 10   h.InlandCarrierCompanyName,   
  cast(sum(d.EstBaseTotalLineValue) as numeric(20,2)) as [EstBaseTotalShipmentValue(@CurrencyCode)] 
FROM txdGVExportHeader h WITH (NOLOCK)
JOIN txdGVExportDetail d WITH (NOLOCK)
  ON h.PartnerID = d.PartnerID AND h.ExportGuid = d.ExportGuid 
WHERE 1=1 AND @EXPORTDATERANGE AND h.PartnerID = @PartnerID 
Group By h.InlandCarrierCompanyName 
ORDER BY sum(d.EstBaseTotalLineValue) DESC'



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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          @reportdesc , -- Description - nvarchar(100)
          @reportlongdesc , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @user , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          @reportdesc , -- Description - nvarchar(100)
          @reportlongdesc , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @user , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

---------------------------------------------------------- Top Value Exported by Inland Carrier ---------------------------------------------------------

------------------------------------  ----------------------------------------
SET @reportdesc = N''
SET @reportlongdesc = N'This comparison report shows the Inland Carrier with the highest associated total Shipment Value on all shipments for the current calendar year compared to the associated total Shipment Value on all shipments filed for the previous calendar year.'
SET @sqlguid = '0B5FC017-63DF-4649-9D53-A72321F2FAD3'
SET @newsqlcmd = 'select   h.PartnerID, 
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
WHERE   datepart(year, ExportDate) =  DATEPART(year, dateadd(year, -1, GetDate())) and ExportDate <= (GETDATE()-365) 
group by h.PartnerID, InlandCarrierCompanyName, datepart(year, ExportDate)   

SELECT TOP 10   d.InlandCarrierCompanyName,    
  isnull(sum(d.EstBaseTotalShipmentValue), 0) as [@CurrentYear],  
  isnull(sum(d2.EstBaseTotalShipmentValue), 0) as [@LastYear] 
FROM #CurrentYear d
left join #LastYear d2 
  on   d.InlandCarrierCompanyName = d2.InlandCarrierCompanyName and d.PartnerID = d2.PartnerID 
Group By d.InlandCarrierCompanyName 
ORDER BY sum(d.EstBaseTotalShipmentValue) DESC'



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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          @reportdesc , -- Description - nvarchar(100)
          @reportlongdesc , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @user , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          @reportdesc , -- Description - nvarchar(100)
          @reportlongdesc , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @user , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

----------------------------------------------------------  ---------------------------------------------------------

------------------------------------ All Value Exported by Seller ----------------------------------------
SET @reportdesc = N'All Value Exported by Seller'
SET @reportlongdesc = N'This report shows all Seller company names and the associated estimated total line value on all shipments, the count of shipments, and the average value per shipment for each Seller company. '
SET @sqlguid = '11BDCE3E-9DBA-42C8-B370-A46F21634A24'
SET @newsqlcmd = 'SELECT   h.SellerCompanyName,   
  CAST(SUM(d.EstBaseTotalLineValue) as Numeric(28,2)) as [EstBaseTotalShipmentValue(@CurrencyCode)],   
  COUNT(h.ExportGUID) AS TotalShipments,   
  CAST(SUM(d.EstBaseTotalLineValue)/COUNT(h.ExportGUID) as Numeric(28,2)) as [EstBaseAvgValuePerDeclaration(@CurrencyCode)] 
FROM txdGVExportHeader h WITH (NOLOCK)
JOIN txdGVExportDetail d WITH (NOLOCK)
  ON h.PartnerID = d.PartnerID AND h.ExportGuid = d.ExportGuid
WHERE 1=1 AND @EXPORTDATERANGE AND h.PartnerID =  @PartnerID 
GROUP BY h.SellerCompanyName 
ORDER BY SUM(d.EstBaseTotalLineValue) DESC'



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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          @reportdesc , -- Description - nvarchar(100)
          @reportlongdesc , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @user , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          @reportdesc , -- Description - nvarchar(100)
          @reportlongdesc , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @user , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

---------------------------------------------------------- All Value Exported by Seller ---------------------------------------------------------

------------------------------------ Top Value Exported by Seller ----------------------------------------
SET @reportdesc = N'Top Value Exported by Seller'
SET @reportlongdesc = N'This report shows the top Sellers associated with the highest estimated base total Shipment Value exported during the reporting period and the estimated base total value of the shipments made for each product.'
SET @sqlguid = '09BEBFDD-6EF4-4DB8-9557-E61FA6D9EE5F'
SET @newsqlcmd = 'SELECT top 10   h.SellerCompanyName,   
  cast(sum(d.EstBaseTotalLineValue) as numeric(20,2)) as [EstBaseTotalShipmentValue(@CurrencyCode)] 
FROM txdGVExportHeader h WITH (NOLOCK)
JOIN txdGVExportDetail d WITH (NOLOCK)
  ON h.PartnerID = d.PartnerID AND h.ExportGuid = d.ExportGuid
WHERE 1=1 AND @EXPORTDATERANGE AND h.PartnerID = @PartnerID 
Group By h.SellerCompanyName 
ORDER BY sum(d.EstBaseTotalLineValue) DESC'



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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          @reportdesc , -- Description - nvarchar(100)
          @reportlongdesc , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @user , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          @reportdesc , -- Description - nvarchar(100)
          @reportlongdesc , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @user , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

---------------------------------------------------------- Top Value Exported by Seller ---------------------------------------------------------

------------------------------------  ----------------------------------------
SET @reportdesc = N''
SET @reportlongdesc = N'This comparison report shows the Seller company names with the highest associated total Shipment Value on all shipments for the current calendar year compared to the associated total Shipment Value on all shipments filed for the previous calendar year.'
SET @sqlguid = 'A5ADF254-9AE4-4BF2-B15B-FA70D77FB67D'
SET @newsqlcmd = 'select   h.PartnerID, 
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
WHERE   datepart(year, ExportDate) =  DATEPART(year, dateadd(year, -1, GetDate())) and ExportDate <= (GETDATE()-365) 
group by h.PartnerID, SellerCompanyName, datepart(year, ExportDate)   

SELECT TOP 10   d.SellerCompanyName,    
  isnull(sum(d.EstBaseTotalShipmentValue), 0) as [@CurrentYear],  
  isnull(sum(d2.EstBaseTotalShipmentValue), 0) as [@LastYear] 
FROM #CurrentYear d 
left join #LastYear d2 
  on   d.SellerCompanyName= d2.SellerCompanyName and  d.PartnerID = d2.PartnerID 
Group By d.SellerCompanyName 
ORDER BY sum(d.EstBaseTotalShipmentValue) DESC'



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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          @reportdesc , -- Description - nvarchar(100)
          @reportlongdesc , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @user , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          @reportdesc , -- Description - nvarchar(100)
          @reportlongdesc , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @user , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

----------------------------------------------------------  ---------------------------------------------------------

------------------------------------ All Value Exported by Ship From ----------------------------------------
SET @reportdesc = N'All Value Exported by Ship From'
SET @reportlongdesc = N'This report shows all Ship From company names and the associated estimated total line value on all shipments, the count of shipments, and the average value per shipment for each Ship From company. '
SET @sqlguid = 'D938334F-9216-4D5F-BE3C-7C47EB70AE5B'
SET @newsqlcmd = 'SELECT   h.ShipFromCompanyName,   
  CAST(SUM(d.EstBaseTotalLineValue) as Numeric(28,2)) as [EstBaseTotalShipmentValue(@CurrencyCode)],   
  COUNT(h.ExportGUID) AS TotalShipments,   
  CAST(SUM(d.EstBaseTotalLineValue)/COUNT(h.ExportGUID) as Numeric(28,2)) as [EstBaseAvgValuePerDeclaration(@CurrencyCode)] 
FROM txdGVExportHeader h WITH (NOLOCK)
JOIN txdGVExportDetail d WITH (NOLOCK)
  ON h.PartnerID = d.PartnerID AND h.ExportGuid = d.ExportGuid
WHERE 1=1 AND @EXPORTDATERANGE AND h.PartnerID =  @PartnerID 
GROUP BY h.ShipFromCompanyName 
ORDER BY SUM(d.EstBaseTotalLineValue) DESC'



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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          @reportdesc , -- Description - nvarchar(100)
          @reportlongdesc , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @user , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          @reportdesc , -- Description - nvarchar(100)
          @reportlongdesc , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @user , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

---------------------------------------------------------- All Value Exported by Ship From ---------------------------------------------------------

------------------------------------ Top Value Exported by Ship From ----------------------------------------
SET @reportdesc = N'Top Value Exported by Ship From'
SET @reportlongdesc = N'This report shows the top Ship From company names associated with the highest estimated base total Shipment Value exported during the reporting period and the estimated base total value of the shipments made for each product.'
SET @sqlguid = '95224C5E-8A13-48A4-AFA0-C95A847A974B'
SET @newsqlcmd = 'SELECT top 10   h.ShipFromCompanyName,   
  cast(sum(d.EstBaseTotalLineValue) as numeric(20,2)) as [EstBaseTotalShipmentValue(@CurrencyCode)] 
FROM txdGVExportHeader h WITH (NOLOCK)
JOIN txdGVExportDetail d WITH (NOLOCK)
  ON h.PartnerID = d.PartnerID AND h.ExportGuid = d.ExportGuid 
WHERE 1=1 AND @EXPORTDATERANGE AND h.PartnerID = @PartnerID 
Group By h.ShipFromCompanyName 
ORDER BY sum(d.EstBaseTotalLineValue) DESC'



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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          @reportdesc , -- Description - nvarchar(100)
          @reportlongdesc , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @user , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          @reportdesc , -- Description - nvarchar(100)
          @reportlongdesc , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @user , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

---------------------------------------------------------- Top Value Exported by Ship From ---------------------------------------------------------

------------------------------------ Value Exported by Ship From - YoY  ----------------------------------------
SET @reportdesc = N'Value Exported by Ship From - YoY '
SET @reportlongdesc = N'This comparison report shows the Ship From company names with the highest associated total Shipment Value on all shipments for the current calendar year compared to the associated total Shipment Value on all shipments filed for the previous calendar year.'
SET @sqlguid = '5973D5E0-8388-4BD7-B439-9D325D4E53F8'
SET @newsqlcmd = 'select   h.PartnerID, 
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
WHERE   datepart(year, ExportDate) =  DATEPART(year, dateadd(year, -1, GetDate())) 
  and ExportDate <= (GETDATE()-365) 
group by h.PartnerID, ShipFromCompanyName, datepart(year, ExportDate)   

SELECT TOP 10   d.ShipFromCompanyName,    
  isnull(sum(d.EstBaseTotalShipmentValue), 0) as [@CurrentYear],  
  isnull(sum(d2.EstBaseTotalShipmentValue), 0) as [@LastYear] 
FROM #CurrentYear d 
left join #LastYear d2 
on   d.ShipFromCompanyName = d2.ShipFromCompanyName and  d.PartnerID = d2.PartnerID 
Group By d.ShipFromCompanyName 
ORDER BY sum(d.EstBaseTotalShipmentValue) DESC'



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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          @reportdesc , -- Description - nvarchar(100)
          @reportlongdesc , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @user , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          @reportdesc , -- Description - nvarchar(100)
          @reportlongdesc , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @user , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

---------------------------------------------------------- Value Exported by Ship From - YoY  ---------------------------------------------------------

------------------------------------ All Value Exported by Ship To ----------------------------------------
SET @reportdesc = N'All Value Exported by Ship To'
SET @reportlongdesc = N'This report shows all Ship To company names and the associated estimated total line value on all shipments, the count of shipments, and the average value per shipment for each Ship To company. '
SET @sqlguid = 'B7F2C297-F34A-4972-9BC2-99DD9FF4316C'
SET @newsqlcmd = 'SELECT   h.ShipToCompanyName,   
  CAST(SUM(d.EstBaseTotalLineValue) as Numeric(28,2)) as [EstBaseTotalShipmentValue(@CurrencyCode)],   
  COUNT(h.ExportGUID) AS TotalShipments,   
  CAST(SUM(d.EstBaseTotalLineValue)/COUNT(h.ExportGUID) as Numeric(28,2)) as [EstBaseAvgValuePerDeclaration(@CurrencyCode)] 
FROM txdGVExportHeader h WITH (NOLOCK)
JOIN txdGVExportDetail d WITH (NOLOCK)
  ON h.PartnerID = d.PartnerID AND h.ExportGuid = d.ExportGuid
WHERE 1=1 AND @EXPORTDATERANGE AND h.PartnerID =  @PartnerID 
GROUP BY h.ShipToCompanyName 
ORDER BY SUM(d.EstBaseTotalLineValue) DESC'



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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          @reportdesc , -- Description - nvarchar(100)
          @reportlongdesc , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @user , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          @reportdesc , -- Description - nvarchar(100)
          @reportlongdesc , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @user , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

---------------------------------------------------------- All Value Exported by Ship To ---------------------------------------------------------

------------------------------------ Top Value Exported by Ship To ----------------------------------------
SET @reportdesc = N'Top Value Exported by Ship To'
SET @reportlongdesc = N'This report shows the top Ship To company names associated with the highest estimated base total Shipment Value exported during the reporting period and the estimated base total value of the shipments made for each product.'
SET @sqlguid = 'B424AFB5-963C-4697-8EDD-4B3F692B43DB'
SET @newsqlcmd = 'SELECT top 10   h.ShipToCompanyName,   
cast(sum(d.EstBaseTotalLineValue) as numeric(20,2)) as [EstBaseTotalShipmentValue(@CurrencyCode)] 
FROM txdGVExportHeader h WITH (NOLOCK)
JOIN txdGVExportDetail d WITH (NOLOCK)
  ON h.PartnerID = d.PartnerID AND h.ExportGuid = d.ExportGuid  
WHERE 1=1 AND @EXPORTDATERANGE AND h.PartnerID = @PartnerID 
Group By h.ShipToCompanyName 
ORDER BY sum(d.EstBaseTotalLineValue) DESC'



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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          @reportdesc , -- Description - nvarchar(100)
          @reportlongdesc , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @user , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          @reportdesc , -- Description - nvarchar(100)
          @reportlongdesc , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @user , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

---------------------------------------------------------- Top Value Exported by Ship To ---------------------------------------------------------

------------------------------------ Value Exported by Ship To - YoY  ----------------------------------------
SET @reportdesc = N'Value Exported by Ship To - YoY '
SET @reportlongdesc = N'This comparison report shows the Ship To company names with the highest associated total Shipment Value on all shipments for the current calendar year compared to the associated total Shipment Value on all shipments filed for the previous calendar year.'
SET @sqlguid = '50B44CB4-BE51-422B-B1E6-148837555B36'
SET @newsqlcmd = 'select   h.PartnerID, 
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
WHERE   datepart(year, ExportDate) =  DATEPART(year, dateadd(year, -1, GetDate())) and ExportDate <= (GETDATE()-365) 
group by h.PartnerID, ShipToCompanyName, datepart(year, ExportDate)   

SELECT TOP 10   d.ShipToCompanyName,    
  isnull(sum(d.EstBaseTotalShipmentValue), 0) as [@CurrentYear],  
  isnull(sum(d2.EstBaseTotalShipmentValue), 0) as [@LastYear] 
FROM #CurrentYear d 
left join #LastYear d2 
  on   d.ShipToCompanyName= d2.ShipToCompanyName 
  and  d.PartnerID = d2.PartnerID 
Group By d.ShipToCompanyName 
ORDER BY sum(d.EstBaseTotalShipmentValue) DESC'



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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          @reportdesc , -- Description - nvarchar(100)
          @reportlongdesc , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @user , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          @reportdesc , -- Description - nvarchar(100)
          @reportlongdesc , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @user , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

---------------------------------------------------------- Value Exported by Ship To - YoY  ---------------------------------------------------------

------------------------------------ All Value Exported by Ultimate Consignee ----------------------------------------
SET @reportdesc = N'All Value Exported by Ultimate Consignee'
SET @reportlongdesc = N'This report shows all Ultimate Consignee company names and the associated estimated total line value on all shipments, the count of shipments, and the average value per shipment for each Ultimate Consignee company. '
SET @sqlguid = '8B0CF620-A392-4A2F-9714-8AFE72B70B1F'
SET @newsqlcmd = 'SELECT   h.UltimateConsigneeCompanyName,   
  CAST(SUM(d.EstBaseTotalLineValue) as Numeric(28,2)) as [EstBaseTotalShipmentValue(@CurrencyCode)],   
  COUNT(h.ExportGUID) AS TotalShipments,   
  CAST(SUM(d.EstBaseTotalLineValue)/COUNT(h.ExportGUID) as Numeric(28,2)) as [EstBaseAvgValuePerDeclaration(@CurrencyCode)] 
FROM txdGVExportHeader h WITH (NOLOCK)
JOIN txdGVExportDetail d WITH (NOLOCK)
  ON h.PartnerID = d.PartnerID AND h.ExportGuid = d.ExportGuid 
WHERE 1=1 AND @EXPORTDATERANGE AND h.PartnerID =  @PartnerID 
GROUP BY h.UltimateConsigneeCompanyName 
ORDER BY SUM(d.EstBaseTotalLineValue) DESC'



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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          @reportdesc , -- Description - nvarchar(100)
          @reportlongdesc , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @user , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          @reportdesc , -- Description - nvarchar(100)
          @reportlongdesc , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @user , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

---------------------------------------------------------- All Value Exported by Ultimate Consignee ---------------------------------------------------------

------------------------------------ Top Value Exported by Ultimate Consignee ----------------------------------------
SET @reportdesc = N'Top Value Exported by Ultimate Consignee'
SET @reportlongdesc = N'This report shows the top Ultimate Consignee company names associated with the highest estimated base total Shipment Value exported during the reporting period and the estimated base total value of the shipments made for each product.'
SET @sqlguid = 'B344015E-32E4-44FF-A058-F54D4F6407C6'
SET @newsqlcmd = 'SELECT top 10   h.UltimateConsigneeCompanyName,   
  cast(sum(d.EstBaseTotalLineValue) as numeric(20,2)) as [EstBaseTotalShipmentValue(@CurrencyCode)] 
FROM txdGVExportHeader h WITH (NOLOCK)
JOIN txdGVExportDetail d WITH (NOLOCK)
  ON h.PartnerID = d.PartnerID AND h.ExportGuid = d.ExportGuid
WHERE 1=1 AND @EXPORTDATERANGE AND h.PartnerID = @PartnerID 
Group By h.UltimateConsigneeCompanyName 
ORDER BY sum(d.EstBaseTotalLineValue) DESC'



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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          @reportdesc , -- Description - nvarchar(100)
          @reportlongdesc , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @user , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          @reportdesc , -- Description - nvarchar(100)
          @reportlongdesc , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @user , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

---------------------------------------------------------- Top Value Exported by Ultimate Consignee ---------------------------------------------------------

------------------------------------  ----------------------------------------
SET @reportdesc = N''
SET @reportlongdesc = N'This comparison report shows the Ultimate Consignee company names with the highest associated total Shipment Value on all shipments for the current calendar year compared to the associated total Shipment Value on all shipments filed for the previous calendar year.'
SET @sqlguid = 'F427119D-DE7B-4323-A0CF-4234951B478F'
SET @newsqlcmd = 'select   h.PartnerID, 
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
WHERE   datepart(year, ExportDate) =  DATEPART(year, dateadd(year, -1, GetDate())) 
  and ExportDate <= (GETDATE()-365) 
group by h.PartnerID, UltimateConsigneeCompanyName, datepart(year, ExportDate)   

SELECT TOP 10   d.UltimateConsigneeCompanyName,    
  isnull(sum(d.EstBaseTotalShipmentValue), 0) as [@CurrentYear],  
  isnull(sum(d2.EstBaseTotalShipmentValue), 0) as [@LastYear] 
FROM #CurrentYear d 
left join #LastYear d2 
  on   d.UltimateConsigneeCompanyName = d2.UltimateConsigneeCompanyName and  d.PartnerID = d2.PartnerID 
Group By d.UltimateConsigneeCompanyName 
ORDER BY sum(d.EstBaseTotalShipmentValue) DESC'



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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          @reportdesc , -- Description - nvarchar(100)
          @reportlongdesc , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @user , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          @reportdesc , -- Description - nvarchar(100)
          @reportlongdesc , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @user , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

----------------------------------------------------------  ---------------------------------------------------------

------------------------------------ All Brokers: Value vs. Duty ----------------------------------------
SET @reportdesc = N'All Brokers: Value vs. Duty'
SET @reportlongdesc = N'This comparison report shows all brokers and the associated total declaration value compared to the total duty paid on all declarations filed. This report is used to compare the amount of value imported relating to a broker to the amount of duty paid relating to that broker''s filings.'
SET @sqlguid = '7126C116-BFDB-4A09-9DD2-ECC2E9684459'
SET @newsqlcmd = 'SELECT  h.BrokerName,   
  CAST(SUM(d.EstBaseTotalLineValue) as Numeric(28,2)) as [EstBaseTotalValue (@CurrencyCode)],  
  CAST(SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 2)) as [EstBaseTotalDuty (@CurrencyCode)] 
FROM txdGVImportHeader h WITH (NOLOCK)
JOIN txdGVImportDetail d WITH (NOLOCK)
  ON h.PartnerID = d.PartnerID AND h.EntryGuid = d.EntryGuid
WHERE 1=1 AND @IMPORTDATERANGE AND h.PartnerID = @PartnerID  
GROUP BY h.BrokerName  
ORDER BY SUM(d.EstBaseTotalLineValue) DESC '



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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          @reportdesc , -- Description - nvarchar(100)
          @reportlongdesc , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @user , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          @reportdesc , -- Description - nvarchar(100)
          @reportlongdesc , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @user , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

---------------------------------------------------------- All Brokers: Value vs. Duty ---------------------------------------------------------

------------------------------------ All Countries of Import: Value vs. Duty ----------------------------------------
SET @reportdesc = N'All Countries of Import: Value vs. Duty'
SET @reportlongdesc = N'This comparison report shows all countries of import and the associated total declaration value compared to the total duty paid on all declarations filed. This report is used to compare the amount of value imported into a country to the amount of duty paid to that country of import.'
SET @sqlguid = 'E440144B-F5F5-4FB6-81E1-FE607B5AB1E2'
SET @newsqlcmd = 'SELECT  h.ImportCountry,    
  CAST(SUM(d.EstBaseTotalLineValue) as Numeric(28,2)) as [EstBaseTotalValue (@CurrencyCode)],  
  CAST(SUM(d.EstBaseTotalLineDuty) AS NUMERIC(28, 2)) as [EstBaseTotalDuty (@CurrencyCode)] 
FROM txdGVImportHeader h WITH (NOLOCK)
JOIN txdGVImportDetail d WITH (NOLOCK)
  ON h.PartnerID = d.PartnerID AND h.EntryGuid = d.EntryGuid
WHERE 1=1 AND @IMPORTDATERANGE AND h.PartnerID = @PartnerID   
GROUP BY h.ImportCountry   
ORDER BY SUM(d.EstBaseTotalLineValue) DESC'



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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          @reportdesc , -- Description - nvarchar(100)
          @reportlongdesc , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @user , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          @reportdesc , -- Description - nvarchar(100)
          @reportlongdesc , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @user , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

---------------------------------------------------------- All Countries of Import: Value vs. Duty ---------------------------------------------------------

------------------------------------ All ImporterID: Value vs. Duty ----------------------------------------
SET @reportdesc = N'All ImporterID: Value vs. Duty'
SET @reportlongdesc = N'This comparison report shows the importer IDs with their associated total declaration value compared to the total duty paid on all declarations filed. This report is used to compare the amount of value imported to the amount of duty paid by that importer ID.'
SET @sqlguid = '2DDCEC4E-19C7-4759-8EC3-E42AF9ECC724'
SET @newsqlcmd = 'SELECT  h.ImporterID,    
  CAST(SUM(d.EstBaseTotalLineValue) as Numeric(28,2)) as [EstBaseTotalValue (@CurrencyCode)],  
  CAST(SUM(d.EstBaseTotalLineDuty) AS NUMERIC(28, 2)) as [EstBaseTotalDuty (@CurrencyCode)] 
FROM txdGVImportHeader h WITH (NOLOCK)
JOIN txdGVImportDetail d WITH (NOLOCK)
  ON h.PartnerID = d.PartnerID AND h.EntryGuid = d.EntryGuid
WHERE 1=1 AND @IMPORTDATERANGE AND h.PartnerID = @PartnerID   
GROUP BY h.ImporterID   
ORDER BY SUM(d.EstBaseTotalLineValue) DESC'



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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          @reportdesc , -- Description - nvarchar(100)
          @reportlongdesc , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @user , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          @reportdesc , -- Description - nvarchar(100)
          @reportlongdesc , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @user , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

---------------------------------------------------------- All ImporterID: Value vs. Duty ---------------------------------------------------------

------------------------------------ All Importers: Import Value vs. Duty ----------------------------------------
SET @reportdesc = N'All Importers: Import Value vs. Duty'
SET @reportlongdesc = N'This comparison report shows the importes with their associated total declaration value compared to the total duty paid on all declarations filed. This report is used to compare the amount of value imported to the amount of duty paid by that importer.'
SET @sqlguid = '8BD31759-E918-42FE-9FC6-363A22307708'
SET @newsqlcmd = 'SELECT  h.ImporterName,    
  CAST(SUM(d.EstBaseTotalLineValue) as Numeric(28,2)) as [EstBaseTotalValue (@CurrencyCode)],  
  CAST(SUM(d.EstBaseTotalLineDuty) AS NUMERIC(28, 2)) as [EstBaseTotalDuty (@CurrencyCode)] 
FROM txdGVImportHeader h WITH (NOLOCK)
JOIN txdGVImportDetail d WITH (NOLOCK)
  ON h.PartnerID = d.PartnerID AND h.EntryGuid = d.EntryGuid 
WHERE 1=1 AND @IMPORTDATERANGE AND h.PartnerID = @PartnerID   
GROUP BY h.ImporterName 
ORDER BY SUM(d.EstBaseTotalLineValue) DESC'



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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          @reportdesc , -- Description - nvarchar(100)
          @reportlongdesc , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @user , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          @reportdesc , -- Description - nvarchar(100)
          @reportlongdesc , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @user , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

---------------------------------------------------------- All Importers: Import Value vs. Duty ---------------------------------------------------------

------------------------------------ All Ports of Unlading: Value vs. Duty ----------------------------------------
SET @reportdesc = N'All Ports of Unlading: Value vs. Duty'
SET @reportlongdesc = N'This comparison report shows all ports of unlading and the associated total declaration value compared to the total duty paid on all declarations filed. This report is used to compare the amount of value imported relating to a port of unlading to the amount of duty paid for that port.'
SET @sqlguid = 'BF11B0AF-5F4B-485F-AF5C-77422FEEC1D1'
SET @newsqlcmd = 'SELECT d.PortOfUnlading,   
  CAST(SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 2)) AS [EstBaseTotalValue (@CurrencyCode)],   
  CAST(SUM(d.EstBaseTotalLineDuty) AS NUMERIC(28, 2)) AS [EstBaseTotalDuty (@CurrencyCode)]  
FROM txdGVImportHeader h WITH (NOLOCK)
JOIN txdGVImportDetail d WITH (NOLOCK)
  ON h.PartnerID = d.PartnerID AND h.EntryGuid = d.EntryGuid
WHERE 1=1 AND @IMPORTDATERANGE AND h.PartnerID = @PartnerID  
GROUP BY d.PortOfUnlading 
ORDER BY SUM(d.EstBaseTotalLineValue) DESC'



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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          @reportdesc , -- Description - nvarchar(100)
          @reportlongdesc , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @user , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          @reportdesc , -- Description - nvarchar(100)
          @reportlongdesc , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @user , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

---------------------------------------------------------- All Ports of Unlading: Value vs. Duty ---------------------------------------------------------

------------------------------------ Top Brokers: Value vs. Duty ----------------------------------------
SET @reportdesc = N'Top Brokers: Value vs. Duty'
SET @reportlongdesc = N'This comparison report shows the brokers with the highest associated total declaration value compared to the total duty paid on all declarations filed. This report is used to compare the amount of value imported relating to a broker to the amount of duty paid relating to that broker''s filings.'
SET @sqlguid = '46F9D775-C4A1-4925-AB5F-88D433544D32'
SET @newsqlcmd = 'SELECT TOP 5   h.BrokerName,   
  CAST(SUM(d.EstBaseTotalLineValue) as Numeric(28,2)) as [EstBaseTotalValue (@CurrencyCode)],  
  CAST(SUM(d.EstBaseTotalLineDuty) AS NUMERIC(28, 2)) as [EstBaseTotalDuty (@CurrencyCode)] 
FROM txdGVImportHeader h WITH (NOLOCK)
JOIN txdGVImportDetail d WITH (NOLOCK)
  ON h.PartnerID = d.PartnerID AND h.EntryGuid = d.EntryGuid
WHERE 1=1 AND @IMPORTDATERANGE AND h.PartnerID = @PartnerID  
GROUP BY h.BrokerName  
ORDER BY SUM(d.EstBaseTotalLineValue) DESC'



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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          @reportdesc , -- Description - nvarchar(100)
          @reportlongdesc , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @user , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          @reportdesc , -- Description - nvarchar(100)
          @reportlongdesc , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @user , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

---------------------------------------------------------- Top Brokers: Value vs. Duty ---------------------------------------------------------

------------------------------------ Top Countries of Import: Value vs. Duty ----------------------------------------
SET @reportdesc = N'Top Countries of Import: Value vs. Duty'
SET @reportlongdesc = N'This comparison report shows the countries of import with the highest associated total declaration value compared to the total duty paid on all declarations filed. This report is used to compare the amount of value imported into a country to the amount of duty paid to that country of import.   '
SET @sqlguid = '92312C83-7E1B-49D8-9BBF-3F42BB495AF2'
SET @newsqlcmd = 'SELECT TOP 10   h.ImportCountry,    
  CAST(SUM(d.EstBaseTotalLineValue) as Numeric(28,2)) as [EstBaseTotalValue (@CurrencyCode)],  
  CAST(SUM(d.EstBaseTotalLineDuty) AS NUMERIC(28, 2)) as [EstBaseTotalDuty (@CurrencyCode)] 
FROM txdGVImportHeader h WITH (NOLOCK)
JOIN txdGVImportDetail d WITH (NOLOCK)
  ON h.PartnerID = d.PartnerID AND h.EntryGuid = d.EntryGuid 
WHERE 1=1 AND @IMPORTDATERANGE AND h.PartnerID = @PartnerID   
GROUP BY h.ImportCountry   
ORDER BY SUM(d.EstBaseTotalLineValue) DESC'



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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          @reportdesc , -- Description - nvarchar(100)
          @reportlongdesc , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @user , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          @reportdesc , -- Description - nvarchar(100)
          @reportlongdesc , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @user , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

---------------------------------------------------------- Top Countries of Import: Value vs. Duty ---------------------------------------------------------

------------------------------------ Top ImporterID: Value vs. Duty ----------------------------------------
SET @reportdesc = N'Top ImporterID: Value vs. Duty'
SET @reportlongdesc = N'This comparison report shows the importer IDs with the highest associated total declaration value compared to the total duty paid on all declarations filed. This report is used to compare the amount of value imported to the amount of duty paid by that importer ID.   '
SET @sqlguid = '71D8FFA9-33D9-4818-8D45-B3E1D1ECDA0D'
SET @newsqlcmd = 'SELECT TOP 10   h.ImporterID,    
  CAST(SUM(d.EstBaseTotalLineValue) as Numeric(28,2)) as [EstBaseTotalValue (@CurrencyCode)],  
  CAST(SUM(d.EstBaseTotalLineDuty) AS NUMERIC(28, 2)) as [EstBaseTotalDuty (@CurrencyCode)] 
FROM txdGVImportHeader h WITH (NOLOCK)
JOIN txdGVImportDetail d WITH (NOLOCK)
  ON h.PartnerID = d.PartnerID AND h.EntryGuid = d.EntryGuid 
WHERE 1=1 AND @IMPORTDATERANGE AND h.PartnerID = @PartnerID   
GROUP BY h.ImporterID   
ORDER BY SUM(d.EstBaseTotalLineValue) DESC'



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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          @reportdesc , -- Description - nvarchar(100)
          @reportlongdesc , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @user , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          @reportdesc , -- Description - nvarchar(100)
          @reportlongdesc , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @user , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

---------------------------------------------------------- Top ImporterID: Value vs. Duty ---------------------------------------------------------

------------------------------------ Top Importers: Import Value vs. Duty ----------------------------------------
SET @reportdesc = N'Top Importers: Import Value vs. Duty'
SET @reportlongdesc = N'This comparison report shows the importers with the highest associated total declaration value compared to the total duty paid on all declarations filed. This report is used to compare the amount of value imported to the amount of duty paid by that importer.'
SET @sqlguid = 'B2B1AFF0-FA1F-42EA-A477-84E97B01B258'
SET @newsqlcmd = 'SELECT TOP 10   h.ImporterName,    
  CAST(SUM(d.EstBaseTotalLineValue) as Numeric(28,2)) as [EstBaseTotalValue (@CurrencyCode)],  
  CAST(SUM(d.EstBaseTotalLineDuty) AS NUMERIC(28, 2)) as [EstBaseTotalDuty (@CurrencyCode)] 
FROM txdGVImportHeader h WITH (NOLOCK)
JOIN txdGVImportDetail d WITH (NOLOCK)
  ON h.PartnerID = d.PartnerID AND h.EntryGuid = d.EntryGuid  
WHERE 1=1 AND @IMPORTDATERANGE AND h.PartnerID = @PartnerID   
GROUP BY h.ImporterName 
ORDER BY SUM(d.EstBaseTotalLineValue) DESC'



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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          @reportdesc , -- Description - nvarchar(100)
          @reportlongdesc , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @user , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          @reportdesc , -- Description - nvarchar(100)
          @reportlongdesc , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @user , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

---------------------------------------------------------- Top Importers: Import Value vs. Duty ---------------------------------------------------------

------------------------------------ Top Ports of Unlading: Value vs. Duty ----------------------------------------
SET @reportdesc = N'Top Ports of Unlading: Value vs. Duty'
SET @reportlongdesc = N'This comparison report shows the ports of unlading with the highest associated total declaration value compared to the total duty paid on all declarations filed. This report is used to compare the amount of value imported relating to a port of unlading to the amount of duty paid for that port.'
SET @sqlguid = '66BFDD71-93E6-44CE-93AE-47CFC025F442'
SET @newsqlcmd = 'SELECT TOP 10 d.PortOfUnlading,   
  CAST(SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 2)) AS [EstBaseTotalValue (@CurrencyCode)],   
  CAST(SUM(d.EstBaseTotalLineDuty) AS NUMERIC(28, 2)) AS [EstBaseTotalDuty (@CurrencyCode)]  
FROM txdgvimportheader h WITH (NOLOCK)  
JOIN txdgvimportdetail d WITH (NOLOCK) 
  ON h.EntryGuid = d.EntryGuid   AND h.PartnerID = d.PartnerID  
WHERE 1=1 AND @IMPORTDATERANGE AND h.PartnerID = @PartnerID  
GROUP BY d.PortOfUnlading  
ORDER BY SUM(d.EstBaseTotalLineValue) DESC'



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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          @reportdesc , -- Description - nvarchar(100)
          @reportlongdesc , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @user , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          @reportdesc , -- Description - nvarchar(100)
          @reportlongdesc , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @user , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

---------------------------------------------------------- Top Ports of Unlading: Value vs. Duty ---------------------------------------------------------

------------------------------------ Brokers by Fees - YoY ----------------------------------------
SET @reportdesc = N'Brokers by Fees - YoY'
SET @reportlongdesc = N'This comparison report shows the brokers with the highest associated total fees paid on all declarations filed for the current year compared to the highest associated total fees paid on all declarations filed for the previous year.'
SET @sqlguid = 'F2C378BB-9229-4945-AFCB-E588F4C3E01E'
SET @newsqlcmd = 'SELECT h.PartnerID  ,
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
WHERE datepart(year, ImportDate) = DATEPART(year, dateadd(year, - 1, GetDate()))  AND ImportDate <= (GETDATE() - 365) 
GROUP BY h.PartnerID  ,BrokerName  ,datepart(year, ImportDate)  

SELECT TOP 10 d.BrokerName  ,
  isnull(sum(d.EstBaseTotalFees), 0) AS [@CurrentYear]  ,
  isnull(sum(d2.EstBaseTotalFees), 0) AS [@LastYear] 
FROM #CurrentYear d
LEFT JOIN #LastYear d2 
  ON d.BrokerName = d2.BrokerName  AND d.PartnerID = d2.PartnerID 
GROUP BY d.BrokerName 
ORDER BY sum(d.EstBaseTotalFees) DESC'



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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          @reportdesc , -- Description - nvarchar(100)
          @reportlongdesc , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @user , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          @reportdesc , -- Description - nvarchar(100)
          @reportlongdesc , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @user , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

---------------------------------------------------------- Brokers by Fees - YoY ---------------------------------------------------------

------------------------------------ Countries of Export by Fees - YoY ----------------------------------------
SET @reportdesc = N'Countries of Export by Fees - YoY'
SET @reportlongdesc = N'This comparison report shows the countries of export with the highest associated total fees paid on all declarations filed for the current year compared to the highest associated total fees paid on all declarations filed for the previous year.  '
SET @sqlguid = 'B61B8FE3-CA5F-4C63-8850-2A5C249B67B7'
SET @newsqlcmd = 'SELECT h.PartnerID  ,
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
WHERE datepart(year, ImportDate) = DATEPART(year, dateadd(year, - 1, GetDate()))  AND ImportDate <= (GETDATE() - 365) 
GROUP BY h.PartnerID  ,d.ExportCountry  ,datepart(year, ImportDate)  

SELECT TOP 10 d.ExportCountry  ,
  isnull(sum(d.EstBaseTotalFees), 0) AS [@CurrentYear]  ,
  isnull(sum(d2.EstBaseTotalFees), 0) AS [@LastYear] 
FROM #CurrentYearEC d 
LEFT JOIN #LastYearEC d2 
  ON d.ExportCountry = d2.ExportCountry  AND d.PartnerID = d2.PartnerID 
GROUP BY d.ExportCountry 
ORDER BY sum(d.EstBaseTotalFees) DESC'



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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          @reportdesc , -- Description - nvarchar(100)
          @reportlongdesc , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @user , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          @reportdesc , -- Description - nvarchar(100)
          @reportlongdesc , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @user , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

---------------------------------------------------------- Countries of Export by Fees - YoY ---------------------------------------------------------

------------------------------------ Countries of Import by Fees - YoY ----------------------------------------
SET @reportdesc = N'Countries of Import by Fees - YoY'
SET @reportlongdesc = N'This comparison report shows the countries of import with the highest associated total fees paid on all declarations filed for the current year compared to the highest associated total fees paid on all declarations filed for the previous year.  '
SET @sqlguid = 'E18B382E-FCBA-4E11-9AC1-A81DD43B674B'
SET @newsqlcmd = 'SELECT h.PartnerID  ,
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
WHERE datepart(year, ImportDate) = DATEPART(year, dateadd(year, - 1, GetDate()))  AND ImportDate <= (GETDATE() - 365) 
GROUP BY h.PartnerID  ,ImportCountry  ,datepart(year, ImportDate)  

SELECT TOP 10 d.ImportCountry  ,isnull(sum(d.EstBaseTotalFees), 0) AS [@CurrentYear]  ,isnull(sum(d2.EstBaseTotalFees), 0) AS [@LastYear] 
FROM #CurrentYear d 
LEFT JOIN #LastYear d2 
  ON d.ImportCountry = d2.ImportCountry  AND d.PartnerID = d2.PartnerID 
GROUP BY d.ImportCountry 
ORDER BY sum(d.EstBaseTotalFees) DESC'



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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          @reportdesc , -- Description - nvarchar(100)
          @reportlongdesc , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @user , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          @reportdesc , -- Description - nvarchar(100)
          @reportlongdesc , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @user , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

---------------------------------------------------------- Countries of Import by Fees - YoY ---------------------------------------------------------

------------------------------------ ImporterID by Fees - YoY ----------------------------------------
SET @reportdesc = N'ImporterID by Fees - YoY'
SET @reportlongdesc = N'This comparison report shows the importer IDs with the highest associated total fees paid on all declarations filed for the current year compared to the highest associated total fees paid on all declarations filed for the previous year.  '
SET @sqlguid = 'B4C3BEFF-8F41-47C1-AF11-1CCFD5EBEFBE'
SET @newsqlcmd = 'SELECT h.PartnerID  ,
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
WHERE datepart(year, ImportDate) = DATEPART(year, dateadd(year, - 1, GetDate()))  AND ImportDate <= (GETDATE() - 365) 
GROUP BY h.PartnerID  ,ImporterID  ,datepart(year, ImportDate)  

SELECT TOP 10 d.ImporterID  ,
  isnull(sum(d.EstBaseTotalFees), 0) AS [@CurrentYear]  ,
  isnull(sum(d2.EstBaseTotalFees), 0) AS [@LastYear] 
FROM #CurrentYearID d 
LEFT JOIN #LastYearID d2 
  ON d.ImporterID = d2.ImporterID  AND d.PartnerID = d2.PartnerID 
GROUP BY d.ImporterID 
ORDER BY sum(d.EstBaseTotalFees) DESC'



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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          @reportdesc , -- Description - nvarchar(100)
          @reportlongdesc , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @user , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          @reportdesc , -- Description - nvarchar(100)
          @reportlongdesc , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @user , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

---------------------------------------------------------- ImporterID by Fees - YoY ---------------------------------------------------------

------------------------------------ Top Brokers by Fees ----------------------------------------
SET @reportdesc = N'Top Brokers by Fees'
SET @reportlongdesc = N'This report shows the brokers with the highest associated total fees paid on all declarations filed.'
SET @sqlguid = '49F63637-D448-4F21-8619-59A130B06DAA'
SET @newsqlcmd = 'SELECT TOP 5 h.BrokerName  ,
  CAST(SUM(d.EstBaseFees) AS NUMERIC(28, 2)) AS [EstBaseTotalFees (@CurrencyCode)] 
FROM txdGVImportHeader h WITH (NOLOCK)
JOIN txdGVImportDetail d WITH (NOLOCK)
  ON h.PartnerID = d.PartnerID AND h.EntryGuid = d.EntryGuid
WHERE 1=1 AND @IMPORTDATERANGE AND h.PartnerID = @PartnerID 
GROUP BY h.BrokerName 
ORDER BY SUM(d.EstBaseFees) DESC'



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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          @reportdesc , -- Description - nvarchar(100)
          @reportlongdesc , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @user , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          @reportdesc , -- Description - nvarchar(100)
          @reportlongdesc , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @user , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

---------------------------------------------------------- Top Brokers by Fees ---------------------------------------------------------

------------------------------------ Top Countries of Import by Fees ----------------------------------------
SET @reportdesc = N'Top Countries of Import by Fees'
SET @reportlongdesc = N'This report shows the countries of import with the highest associated total fees paid on all declarations filed. '
SET @sqlguid = '4044C818-94EC-477E-8F6F-2A821F6D9EB2'
SET @newsqlcmd = 'SELECT TOP 10 h.ImportCountry  ,
  CAST(SUM(d.EstBaseFees) AS NUMERIC(28, 2)) AS [EstBaseTotalFees (@CurrencyCode)] 
FROM txdGVImportHeader h WITH (NOLOCK)
JOIN txdGVImportDetail d WITH (NOLOCK)
  ON h.PartnerID = d.PartnerID AND h.EntryGuid = d.EntryGuid
WHERE 1=1 AND @IMPORTDATERANGE AND h.PartnerID = @PartnerID 
GROUP BY h.ImportCountry 
ORDER BY SUM(d.EstBaseFees) DESC'



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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          @reportdesc , -- Description - nvarchar(100)
          @reportlongdesc , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @user , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          @reportdesc , -- Description - nvarchar(100)
          @reportlongdesc , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @user , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

---------------------------------------------------------- Top Countries of Import by Fees ---------------------------------------------------------

------------------------------------ Top ImporterID by Fees ----------------------------------------
SET @reportdesc = N'Top ImporterID by Fees'
SET @reportlongdesc = N'This report shows the importer IDs with the highest associated total fees paid on all declarations filed.'
SET @sqlguid = 'CCC2D4BC-F00F-4E5B-A679-3A1C0AC84B2F'
SET @newsqlcmd = 'SELECT TOP 5 h.ImporterID  ,
  CAST(SUM(d.EstBaseFees) AS NUMERIC(28, 2)) AS [EstBaseTotalFees (@CurrencyCode)] 
FROM txdGVImportHeader h WITH (NOLOCK)
JOIN txdGVImportDetail d WITH (NOLOCK)
  ON h.PartnerID = d.PartnerID AND h.EntryGuid = d.EntryGuid
WHERE 1=1 AND @IMPORTDATERANGE AND h.PartnerID = @PartnerID 
GROUP BY h.ImporterID 
ORDER BY SUM(d.EstBaseFees) DESC '



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
                AND Version IN ( '20.2', '20.3', '20.4' );    


--delete old records from sqlcommand table
DELETE dbo.tbgSQLCommands
WHERE   SQLGUID = @sqlguid
                AND Version IN ( '20.2', '20.3', '20.4' );    



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
          @reportdesc , -- Description - nvarchar(100)
          @reportlongdesc , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @user , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.2' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )	
		
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
          @reportdesc , -- Description - nvarchar(100)
          @reportlongdesc , -- LongDescription - nvarchar(max)
          GETDATE() , -- CreatedDate - datetime
          @user , -- CreatedBy - varchar(50)
          '' , -- ApprovedBy - varchar(50)
          HASHBYTES('MD5',LEFT(@newsqlcmd,4000)) , -- SQLHash - varbinary(16)
          'GTV Report' , -- SQLType - varchar(50)
          '20.3' , -- Version - varchar(50)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )					

---------------------------------------------------------- Top ImporterID by Fees ---------------------------------------------------------






      

COMMIT TRANSACTION;
SET XACT_ABORT OFF;
