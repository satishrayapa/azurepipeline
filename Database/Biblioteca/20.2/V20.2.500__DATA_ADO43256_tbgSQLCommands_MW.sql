
SET XACT_ABORT ON;
--BEGIN TRANSACTION;

SET IDENTITY_INSERT dbo.tbgSQLCommandsHist ON;
GO	

DECLARE @partner AS INT
SET @partner = 4000

DECLARE @sqlguid AS UNIQUEIDENTIFIER
DECLARE @newsqlcmd AS VARCHAR (max)
DECLARE @reportdesc NVARCHAR(100)

DECLARE @reportlongdesc NVARCHAR(max)
DECLARE @user VARCHAR(10) = 'jmurillo'
---------------------------------------------------------- All Brokers By Value ---------------------------------------------------------

------------------------------------ All Countries Of Import by Import Value ----------------------------------------
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
WHERE 1=1 
  AND h.PartnerID = @PartnerID 
  AND @IMPORTDATERANGE  
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
WHERE 1=1
  AND @IMPORTDATERANGE 
  AND h.PartnerID = @PartnerID 
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
		

------------------------------------------------------------Importers by Duty - YoY---------------------------------------------------------



--------------------------------------Top Brokers by Duty----------------------------------------
SET @sqlguid = '8742A4AC-0423-4698-A828-CE229631BB48'
SET @newsqlcmd = 'SELECT TOP 5
        h.BrokerName ,
        CAST(SUM(d.EstBaseTotalLineDuty) AS NUMERIC(28, 2)) AS [EstBaseTotalDuty (@CurrencyCode)]
FROM    txdGVImportHeader h WITH ( NOLOCK )
JOIN dbo.txdGVImportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.EntryGuid = h.EntryGuid
WHERE 1=1 
AND @IMPORTDATERANGE 
AND h.PartnerID = @PartnerID 
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
		

------------------------------------------------------------All Brokers by Duty---------------------------------------------------------



--------------------------------------All Countries of Import by Duty----------------------------------------
SET @sqlguid = '320D16E5-8EF1-4A93-9361-5D34B18C7155'
SET @newsqlcmd = 'SELECT  h.ImportCountry ,
        CAST(SUM(d.EstBaseTotalLineDuty) AS NUMERIC(28, 2)) AS [EstBaseTotalDuty (@CurrencyCode)] ,
        COUNT(DISTINCT h.EntryGuid) AS DeclarationCount ,
        CAST(SUM(d.EstBaseTotalLineDuty) / COUNT(DISTINCT h.EntryGuid) AS NUMERIC(28,
                                                              2)) AS [EstBaseAvgDutyPerDeclaration (@CurrencyCode)]
FROM    txdGVImportHeader h WITH ( NOLOCK )
JOIN dbo.txdGVImportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.EntryGuid = h.EntryGuid
WHERE 1=1 
AND @IMPORTDATERANGE 
AND h.PartnerID = @PartnerID 
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
		

------------------------------------------------------------Weight Shipped by Port of Unlading - YoY---------------------------------------------------------



--------------------------------------All Brokers by Duty----------------------------------------
SET @sqlguid = '5A665B2F-EF0E-4DB1-AB68-062A7FD055AA'
SET @newsqlcmd = 'SELECT  h.BrokerName ,
        CAST(SUM(d.EstBaseTotalLineDuty) AS NUMERIC(28, 2)) AS [EstBaseTotalDuty (@CurrencyCode)] ,
        COUNT(DISTINCT h.EntryGuid) AS DeclarationCount ,
        CAST(SUM(d.EstBaseTotalLineDuty) / COUNT(DISTINCT h.EntryGuid) AS NUMERIC(28,
                                                              2)) AS [EstBaseAvgDutyPerDeclaration (@CurrencyCode)]
FROM    txdGVImportHeader h WITH ( NOLOCK )
JOIN dbo.txdGVImportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.EntryGuid = h.EntryGuid
WHERE 1=1 
AND @IMPORTDATERANGE 
AND h.PartnerID = @PartnerID 
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
		

------------------------------------------------------------Top Declaration Duty by Month---------------------------------------------------------


--------------------------------------Total Declaration Duty By Month----------------------------------------
SET @sqlguid = '875B9E37-923D-4F4D-BEFC-32EDE8092C4E'
SET @newsqlcmd = 'SELECT  CAST(DATEPART(MONTH, ImportDate) AS VARCHAR(50)) + ''-''
        + CAST(DATEPART(YEAR, ImportDate) AS VARCHAR(50)) AS ImportMonth ,
        CAST(SUM(d.EstBaseTotalLineDuty) AS NUMERIC(28, 2)) AS [EstBaseTotalDuty (@CurrencyCode)]
FROM    txdGVImportHeader h WITH ( NOLOCK )
JOIN dbo.txdGVImportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.EntryGuid = h.EntryGuid
WHERE 1=1          
AND @IMPORTDATERANGE  
AND h.PartnerID = @PartnerID 
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
		

------------------------------------------------------------ All Countries Of Import By Value ---------------------------------------------------------

-------------------------------------- All ImporterID by Import Value ----------------------------------------
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
WHERE 1=1 
  AND @IMPORTDATERANGE 
  AND h.PartnerID = @PartnerID 
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
		

------------------------------------------------------------ Top Countries of Import by Import Value ---------------------------------------------------------

-------------------------------------- Top ImporterID by Import Value ----------------------------------------
SET @reportdesc = N'Top ImporterID by Value'
SET @reportlongdesc = N'This report shows the top ImporterIDs by total import value.'
SET @sqlguid = '8DFE3D72-EA92-430A-8157-3934B10B1ECF'
SET @newsqlcmd = 'SELECT TOP 5   h.ImporterID,  
  CAST(SUM(d.EstBaseTotalLineValue) as Numeric(28,2)) as [EstBaseTotalValue (@CurrencyCode)] 
FROM txdGVImportHeader h WITH (NOLOCK)
JOIN txdGVImportDetail d WITH (NOLOCK)
  ON h.PartnerID = d.PartnerID AND h.EntryGuid = d.EntryGuid
WHERE 1=1 
  AND @IMPORTDATERANGE 
  AND h.PartnerID = @PartnerID 
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
		

------------------------------------------------------------ Top Countries of Import by Duty ---------------------------------------------------------

-------------------------------------- Top ImporterID by Duty ----------------------------------------
SET @reportdesc = N'Top ImporterID by Duty'
SET @reportlongdesc = N'This report shows the importer IDs with the highest associated total duty paid on all declarations filed.'
SET @sqlguid = '1F0A131C-4013-4FDA-8F50-F4C1A09F4D7F'
SET @newsqlcmd = 'SELECT TOP 5 h.ImporterID  ,
	CAST(SUM(d.EstBaseTotalLineDuty) AS NUMERIC(28, 2)) as [EstBaseTotalDuty (@CurrencyCode)] 
FROM txdGVImportHeader h WITH (NOLOCK) 
JOIN txdGVImportDetail d WITH (NOLOCK)
  ON h.PartnerID = d.PartnerID AND h.EntryGuid = d.EntryGuid
WHERE 1=1 
  AND @IMPORTDATERANGE
  AND h.PartnerID = @PartnerID 
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
		

------------------------------------------------------------ Top ImporterID by Duty ---------------------------------------------------------

-------------------------------------- Top Importers by Duty ----------------------------------------
SET @reportdesc = N'Top Importers by Duty'
SET @reportlongdesc = N'This report shows the importers with the highest associated total duty paid on all declarations filed.'
SET @sqlguid = '922DF93D-CCDD-4108-868E-8489F2E43EDA'
SET @newsqlcmd = 'SELECT TOP 5 h.ImporterName  ,
	CAST(SUM(d.EstBaseTotalLineDuty) AS NUMERIC(28, 2)) as [EstBaseTotalDuty (@CurrencyCode)] 
FROM txdGVImportHeader h WITH (NOLOCK) 
JOIN txdGVImportDetail d WITH (NOLOCK)
  ON h.PartnerID = d.PartnerID AND h.EntryGuid = d.EntryGuid
WHERE 1=1
  AND @IMPORTDATERANGE 
  AND h.PartnerID = @PartnerID 
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
		

------------------------------------------------------------All Countries of Import by Duty---------------------------------------------------------



--------------------------------------All Importers by Duty----------------------------------------
SET @sqlguid = '9BC0D874-3B0B-45A3-A473-55BFEA9042A5'
SET @newsqlcmd = 'SELECT  h.ImporterName ,
        CAST(SUM(d.EstBaseTotalLineDuty) AS NUMERIC(28, 2)) AS [EstBaseTotalDuty (@CurrencyCode)] ,
        COUNT(DISTINCT h.EntryGuid) AS DeclarationCount ,
        CAST(SUM(d.EstBaseTotalLineDuty) / COUNT(DISTINCT h.EntryGuid) AS NUMERIC(28,
                                                              2)) AS [EstBaseAvgDutyPerDeclaration (@CurrencyCode)]
FROM    txdGVImportHeader h WITH ( NOLOCK )
JOIN dbo.txdGVImportDetail d WITH (NOLOCK) ON d.PartnerID = h.PartnerID AND d.EntryGuid = h.EntryGuid
WHERE 1=1 
AND @IMPORTDATERANGE 
AND h.PartnerID = @PartnerID 
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
		

------------------------------------------------------------ Brokers by Value - YoY ---------------------------------------------------------

-------------------------------------- Countries of Import by Import Value - YoY ----------------------------------------
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
WHERE 1=1  AND h.PartnerID = @PartnerID  AND datepart(year, ImportDate) = DATEPART(year, GetDate()) 
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
		

------------------------------------------------------------ Top Brokers by Value  ---------------------------------------------------------

-------------------------------------- Top Countries of Import by Import Value ----------------------------------------
SET @reportdesc = N'Top Countries of Import by Import Value'
SET @reportlongdesc = N'This report shows the countries of import with the highest associated total declaration value on all declarations filed. '
SET @sqlguid = '986C76C6-6661-4F13-9A7C-40FB9FE7FA08'
SET @newsqlcmd = 'SELECT TOP 10 h.ImportCountry  ,
  CAST(SUM(d.EstBaseTotalLineValue) AS NUMERIC(28, 2)) AS [EstBaseTotalValue (@CurrencyCode)] 
FROM txdGVImportHeader h WITH (NOLOCK)
JOIN txdGVImportDetail d WITH (NOLOCK)
  ON h.PartnerID = d.PartnerID AND h.EntryGuid = d.EntryGuid
WHERE 1=1
  AND @IMPORTDATERANGE  AND h.PartnerID = @PartnerID 
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