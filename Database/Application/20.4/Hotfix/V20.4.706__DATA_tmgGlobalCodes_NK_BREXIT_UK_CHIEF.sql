
    
BEGIN TRANSACTION

DECLARE @PARTNERID AS INTEGER
SELECT @PARTNERID = def.PartnerID FROM tmfDefaults def  


DECLARE @BackupSQL AS NVARCHAR(1000) = (SELECT 'SELECT * INTO bck.bck_tmgGlobalCodes_UK_CHIEF_UPDATE_' + REPLACE(REPLACE(REPLACE(CONVERT(VARCHAR(19), GETDATE(), 120), '-',''),' ', ''), ':','') + ' FROM tmgGlobalCodes')

EXEC(@BackupSQL)

IF OBJECT_ID('tempdb..#temp') IS NOT NULL DROP TABLE #temp

IF OBJECT_ID('tempdb..#temp0') IS NOT NULL DROP TABLE #temp0

IF OBJECT_ID('tempdb..#INSERTED') IS NOT NULL DROP TABLE #INSERTED


CREATE TABLE #temp ( 
             PartnerID  INT, 
             EffDate DATETIME, 
             FieldName VARCHAR(30),
             Code NVARCHAR(36),
             Decode NVARCHAR(MAX), 
             StaticFlag VARCHAR(1),
             DeletedFlag VARCHAR(1), 
             KeepDuringRollback VARCHAR(1))

CREATE TABLE #temp0 ( 
             PartnerID  INT, 
             EffDate DATETIME, 
             FieldName VARCHAR(30),
             Code NVARCHAR(36),
             Decode NVARCHAR(MAX), 
             StaticFlag VARCHAR(1),
             DeletedFlag VARCHAR(1), 
             KeepDuringRollback VARCHAR(1))
    
    
INSERT INTO #temp0 SELECT @PartnerID, GETDATE(), 'EUMOT', '6','RORO', 'Y', 'N','N'
INSERT INTO #temp0 SELECT @PartnerID, GETDATE(), 'GBCHIEF_MOT', '6','RORO', 'Y', 'N','N'

INSERT INTO #temp0 SELECT @PartnerID, GETDATE(), 'LOCGOODS', 'DOV','Dover', 'Y', 'N','N'
INSERT INTO #temp0 SELECT @PartnerID, GETDATE(), 'LOCGOODS', 'DEU','Dover / Eurotunnel', 'Y', 'N','N'
INSERT INTO #temp0 SELECT @PartnerID, GETDATE(), 'LOCGOODS', 'EUT','Eurotunnel', 'Y', 'N','N'
INSERT INTO #temp0 SELECT @PartnerID, GETDATE(), 'LOCGOODS', 'FXT','Felixstowe', 'Y', 'N','N'
INSERT INTO #temp0 SELECT @PartnerID, GETDATE(), 'LOCGOODS', 'FIS','Fishguard', 'Y', 'N','N'
INSERT INTO #temp0 SELECT @PartnerID, GETDATE(), 'LOCGOODS', 'HRH','Harwich International Port', 'Y', 'N','N'
INSERT INTO #temp0 SELECT @PartnerID, GETDATE(), 'LOCGOODS', 'HEY','Heysham', 'Y', 'N','N'
INSERT INTO #temp0 SELECT @PartnerID, GETDATE(), 'LOCGOODS', 'HLD','Holyhead', 'Y', 'N','N'
INSERT INTO #temp0 SELECT @PartnerID, GETDATE(), 'LOCGOODS', 'HUL','Hull', 'Y', 'N','N'
INSERT INTO #temp0 SELECT @PartnerID, GETDATE(), 'LOCGOODS', 'IMM','Immingham', 'Y', 'N','N'
INSERT INTO #temp0 SELECT @PartnerID, GETDATE(), 'LOCGOODS', 'KIL','Killingholme', 'Y', 'N','N'
INSERT INTO #temp0 SELECT @PartnerID, GETDATE(), 'LOCGOODS', 'LIV','Liverpool', 'Y', 'N','N'
INSERT INTO #temp0 SELECT @PartnerID, GETDATE(), 'LOCGOODS', 'NHV','Newhaven', 'Y', 'N','N'
INSERT INTO #temp0 SELECT @PartnerID, GETDATE(), 'LOCGOODS', 'MIL','Pembroke', 'Y', 'N','N'
INSERT INTO #temp0 SELECT @PartnerID, GETDATE(), 'LOCGOODS', 'PLY','Plymouth', 'Y', 'N','N'
INSERT INTO #temp0 SELECT @PartnerID, GETDATE(), 'LOCGOODS', 'POO','Poole', 'Y', 'N','N'
INSERT INTO #temp0 SELECT @PartnerID, GETDATE(), 'LOCGOODS', 'PTM','Portsmouth', 'Y', 'N','N'
INSERT INTO #temp0 SELECT @PartnerID, GETDATE(), 'LOCGOODS', 'PUF','Purfleet', 'Y', 'N','N'
INSERT INTO #temp0 SELECT @PartnerID, GETDATE(), 'LOCGOODS', 'RMG','Ramsgate', 'Y', 'N','N'
INSERT INTO #temp0 SELECT @PartnerID, GETDATE(), 'LOCGOODS', 'MED','Sheerness', 'Y', 'N','N'
INSERT INTO #temp0 SELECT @PartnerID, GETDATE(), 'LOCGOODS', 'MID','Teesport', 'Y', 'N','N'
INSERT INTO #temp0 SELECT @PartnerID, GETDATE(), 'LOCGOODS', 'LON','Tilbury', 'Y', 'N','N'
INSERT INTO #temp0 SELECT @PartnerID, GETDATE(), 'LOCGOODS', 'TYN','Tyne', 'Y', 'N','N'

INSERT INTO #temp0 SELECT @PartnerID, GETDATE(), 'LOCGOODSHED', 'DOV','Dover', 'Y', 'N','N'
INSERT INTO #temp0 SELECT @PartnerID, GETDATE(), 'LOCGOODSHED', 'DEU','Dover / Eurotunnel', 'Y', 'N','N'
INSERT INTO #temp0 SELECT @PartnerID, GETDATE(), 'LOCGOODSHED', 'EUT','Eurotunnel', 'Y', 'N','N'
INSERT INTO #temp0 SELECT @PartnerID, GETDATE(), 'LOCGOODSHED', 'FXT','Felixstowe', 'Y', 'N','N'
INSERT INTO #temp0 SELECT @PartnerID, GETDATE(), 'LOCGOODSHED', 'FIS','Fishguard', 'Y', 'N','N'
INSERT INTO #temp0 SELECT @PartnerID, GETDATE(), 'LOCGOODSHED', 'HRH','Harwich International Port', 'Y', 'N','N'
INSERT INTO #temp0 SELECT @PartnerID, GETDATE(), 'LOCGOODSHED', 'HEY','Heysham', 'Y', 'N','N'
INSERT INTO #temp0 SELECT @PartnerID, GETDATE(), 'LOCGOODSHED', 'HLD','Holyhead', 'Y', 'N','N'
INSERT INTO #temp0 SELECT @PartnerID, GETDATE(), 'LOCGOODSHED', 'HUL','Hull', 'Y', 'N','N'
INSERT INTO #temp0 SELECT @PartnerID, GETDATE(), 'LOCGOODSHED', 'IMM','Immingham', 'Y', 'N','N'
INSERT INTO #temp0 SELECT @PartnerID, GETDATE(), 'LOCGOODSHED', 'KIL','Killingholme', 'Y', 'N','N'
INSERT INTO #temp0 SELECT @PartnerID, GETDATE(), 'LOCGOODSHED', 'LIV','Liverpool', 'Y', 'N','N'
INSERT INTO #temp0 SELECT @PartnerID, GETDATE(), 'LOCGOODSHED', 'NHV','Newhaven', 'Y', 'N','N'
INSERT INTO #temp0 SELECT @PartnerID, GETDATE(), 'LOCGOODSHED', 'MIL','Pembroke', 'Y', 'N','N'
INSERT INTO #temp0 SELECT @PartnerID, GETDATE(), 'LOCGOODSHED', 'PLY','Plymouth', 'Y', 'N','N'
INSERT INTO #temp0 SELECT @PartnerID, GETDATE(), 'LOCGOODSHED', 'POO','Poole', 'Y', 'N','N'
INSERT INTO #temp0 SELECT @PartnerID, GETDATE(), 'LOCGOODSHED', 'PTM','Portsmouth', 'Y', 'N','N'
INSERT INTO #temp0 SELECT @PartnerID, GETDATE(), 'LOCGOODSHED', 'PUF','Purfleet', 'Y', 'N','N'
INSERT INTO #temp0 SELECT @PartnerID, GETDATE(), 'LOCGOODSHED', 'RMG','Ramsgate', 'Y', 'N','N'
INSERT INTO #temp0 SELECT @PartnerID, GETDATE(), 'LOCGOODSHED', 'MED','Sheerness', 'Y', 'N','N'
INSERT INTO #temp0 SELECT @PartnerID, GETDATE(), 'LOCGOODSHED', 'MID','Teesport', 'Y', 'N','N'
INSERT INTO #temp0 SELECT @PartnerID, GETDATE(), 'LOCGOODSHED', 'LON','Tilbury', 'Y', 'N','N'
INSERT INTO #temp0 SELECT @PartnerID, GETDATE(), 'LOCGOODSHED', 'TYN','Tyne', 'Y', 'N','N'

INSERT INTO #temp0 SELECT @PartnerID, GETDATE(), 'GBCHIEF_LOC', 'DOV','Dover', 'Y', 'N','N'
INSERT INTO #temp0 SELECT @PartnerID, GETDATE(), 'GBCHIEF_LOC', 'DEU','Dover / Eurotunnel', 'Y', 'N','N'
INSERT INTO #temp0 SELECT @PartnerID, GETDATE(), 'GBCHIEF_LOC', 'EUT','Eurotunnel', 'Y', 'N','N'
INSERT INTO #temp0 SELECT @PartnerID, GETDATE(), 'GBCHIEF_LOC', 'FXT','Felixstowe', 'Y', 'N','N'
INSERT INTO #temp0 SELECT @PartnerID, GETDATE(), 'GBCHIEF_LOC', 'FIS','Fishguard', 'Y', 'N','N'
INSERT INTO #temp0 SELECT @PartnerID, GETDATE(), 'GBCHIEF_LOC', 'HRH','Harwich International Port', 'Y', 'N','N'
INSERT INTO #temp0 SELECT @PartnerID, GETDATE(), 'GBCHIEF_LOC', 'HEY','Heysham', 'Y', 'N','N'
INSERT INTO #temp0 SELECT @PartnerID, GETDATE(), 'GBCHIEF_LOC', 'HLD','Holyhead', 'Y', 'N','N'
INSERT INTO #temp0 SELECT @PartnerID, GETDATE(), 'GBCHIEF_LOC', 'HUL','Hull', 'Y', 'N','N'
INSERT INTO #temp0 SELECT @PartnerID, GETDATE(), 'GBCHIEF_LOC', 'IMM','Immingham', 'Y', 'N','N'
INSERT INTO #temp0 SELECT @PartnerID, GETDATE(), 'GBCHIEF_LOC', 'KIL','Killingholme', 'Y', 'N','N'
INSERT INTO #temp0 SELECT @PartnerID, GETDATE(), 'GBCHIEF_LOC', 'LIV','Liverpool', 'Y', 'N','N'
INSERT INTO #temp0 SELECT @PartnerID, GETDATE(), 'GBCHIEF_LOC', 'NHV','Newhaven', 'Y', 'N','N'
INSERT INTO #temp0 SELECT @PartnerID, GETDATE(), 'GBCHIEF_LOC', 'MIL','Pembroke', 'Y', 'N','N'
INSERT INTO #temp0 SELECT @PartnerID, GETDATE(), 'GBCHIEF_LOC', 'PLY','Plymouth', 'Y', 'N','N'
INSERT INTO #temp0 SELECT @PartnerID, GETDATE(), 'GBCHIEF_LOC', 'POO','Poole', 'Y', 'N','N'
INSERT INTO #temp0 SELECT @PartnerID, GETDATE(), 'GBCHIEF_LOC', 'PTM','Portsmouth', 'Y', 'N','N'
INSERT INTO #temp0 SELECT @PartnerID, GETDATE(), 'GBCHIEF_LOC', 'PUF','Purfleet', 'Y', 'N','N'
INSERT INTO #temp0 SELECT @PartnerID, GETDATE(), 'GBCHIEF_LOC', 'RMG','Ramsgate', 'Y', 'N','N'
INSERT INTO #temp0 SELECT @PartnerID, GETDATE(), 'GBCHIEF_LOC', 'MED','Sheerness', 'Y', 'N','N'
INSERT INTO #temp0 SELECT @PartnerID, GETDATE(), 'GBCHIEF_LOC', 'MID','Teesport', 'Y', 'N','N'
INSERT INTO #temp0 SELECT @PartnerID, GETDATE(), 'GBCHIEF_LOC', 'LON','Tilbury', 'Y', 'N','N'
INSERT INTO #temp0 SELECT @PartnerID, GETDATE(), 'GBCHIEF_LOC', 'TYN','Tyne', 'Y', 'N','N'

INSERT INTO #temp0 SELECT @PartnerID, GETDATE(), 'GBCHIEF_UNLOADPLACE', 'DOV','Dover', 'Y', 'N','N'
INSERT INTO #temp0 SELECT @PartnerID, GETDATE(), 'GBCHIEF_UNLOADPLACE', 'DEU','Dover / Eurotunnel', 'Y', 'N','N'
INSERT INTO #temp0 SELECT @PartnerID, GETDATE(), 'GBCHIEF_UNLOADPLACE', 'EUT','Eurotunnel', 'Y', 'N','N'
INSERT INTO #temp0 SELECT @PartnerID, GETDATE(), 'GBCHIEF_UNLOADPLACE', 'FXT','Felixstowe', 'Y', 'N','N'
INSERT INTO #temp0 SELECT @PartnerID, GETDATE(), 'GBCHIEF_UNLOADPLACE', 'FIS','Fishguard', 'Y', 'N','N'
INSERT INTO #temp0 SELECT @PartnerID, GETDATE(), 'GBCHIEF_UNLOADPLACE', 'HRH','Harwich International Port', 'Y', 'N','N'
INSERT INTO #temp0 SELECT @PartnerID, GETDATE(), 'GBCHIEF_UNLOADPLACE', 'HEY','Heysham', 'Y', 'N','N'
INSERT INTO #temp0 SELECT @PartnerID, GETDATE(), 'GBCHIEF_UNLOADPLACE', 'HLD','Holyhead', 'Y', 'N','N'
INSERT INTO #temp0 SELECT @PartnerID, GETDATE(), 'GBCHIEF_UNLOADPLACE', 'HUL','Hull', 'Y', 'N','N'
INSERT INTO #temp0 SELECT @PartnerID, GETDATE(), 'GBCHIEF_UNLOADPLACE', 'IMM','Immingham', 'Y', 'N','N'
INSERT INTO #temp0 SELECT @PartnerID, GETDATE(), 'GBCHIEF_UNLOADPLACE', 'KIL','Killingholme', 'Y', 'N','N'
INSERT INTO #temp0 SELECT @PartnerID, GETDATE(), 'GBCHIEF_UNLOADPLACE', 'LIV','Liverpool', 'Y', 'N','N'
INSERT INTO #temp0 SELECT @PartnerID, GETDATE(), 'GBCHIEF_UNLOADPLACE', 'NHV','Newhaven', 'Y', 'N','N'
INSERT INTO #temp0 SELECT @PartnerID, GETDATE(), 'GBCHIEF_UNLOADPLACE', 'MIL','Pembroke', 'Y', 'N','N'
INSERT INTO #temp0 SELECT @PartnerID, GETDATE(), 'GBCHIEF_UNLOADPLACE', 'PLY','Plymouth', 'Y', 'N','N'
INSERT INTO #temp0 SELECT @PartnerID, GETDATE(), 'GBCHIEF_UNLOADPLACE', 'POO','Poole', 'Y', 'N','N'
INSERT INTO #temp0 SELECT @PartnerID, GETDATE(), 'GBCHIEF_UNLOADPLACE', 'PTM','Portsmouth', 'Y', 'N','N'
INSERT INTO #temp0 SELECT @PartnerID, GETDATE(), 'GBCHIEF_UNLOADPLACE', 'PUF','Purfleet', 'Y', 'N','N'
INSERT INTO #temp0 SELECT @PartnerID, GETDATE(), 'GBCHIEF_UNLOADPLACE', 'RMG','Ramsgate', 'Y', 'N','N'
INSERT INTO #temp0 SELECT @PartnerID, GETDATE(), 'GBCHIEF_UNLOADPLACE', 'MED','Sheerness', 'Y', 'N','N'
INSERT INTO #temp0 SELECT @PartnerID, GETDATE(), 'GBCHIEF_UNLOADPLACE', 'MID','Teesport', 'Y', 'N','N'
INSERT INTO #temp0 SELECT @PartnerID, GETDATE(), 'GBCHIEF_UNLOADPLACE', 'LON','Tilbury', 'Y', 'N','N'
INSERT INTO #temp0 SELECT @PartnerID, GETDATE(), 'GBCHIEF_UNLOADPLACE', 'TYN','Tyne', 'Y', 'N','N'


INSERT INTO #temp0 SELECT @PartnerID, GETDATE(), 'GBCHIEF_DocumentCode_I', 'U110',' The claim based on a ''statement on origin'' for a single shipment', 'Y', 'N','N'
INSERT INTO #temp0 SELECT @PartnerID, GETDATE(), 'GBCHIEF_DocumentCode_I', 'U111','The claim based on a ''statement on origin'' for multiple shipments of identical products to cover a 12-month', 'Y', 'N','N'
INSERT INTO #temp0 SELECT @PartnerID, GETDATE(), 'GBCHIEF_DocumentCode_I', 'U112','The claim based on importers knowledge (must be declared with status code JP)', 'Y', 'N','N'


    INSERT INTO #temp
    SELECT
    @PARTNERID,
    GETDATE(),
    FieldName,
    Code,
    Left(MAX(Decode), 300),
    'Y',
    'N',
    'N'
    FROM #temp0
    GROUP BY FieldName, Code


    CREATE TABLE #INSERTED ( PartnerID  INT, EffDate DATETIME, FieldName VARCHAR(30),Code NVARCHAR(36),DeCode NVARCHAR(300), StaticFlag VARCHAR(1),DeletedFlag VARCHAR(1), KeepDuringRollback VARCHAR(1))
    

    INSERT INTO #INSERTED
    SELECT t.*
    FROM #temp t left join tmgGlobalCodes G
    On t.PartnerID=G.PartnerID AND t.FieldName=G.FieldName And t.Code=G.Code
    WHERE G.PartnerID Is Null


	
    DECLARE @INSERTED INT=(SELECT COUNT(*) As INSERTED FROM #INSERTED)
	
    --Select 'INS', @INSERTED,  * FROM #INSERTED
	
    Print('Inserting new codes...')
    INSERT INTO tmgGlobalCodes
    Select *
    FROM #INSERTED
	
    Print  'INSERTED: ' +  CAST(@INSERTED AS VARCHAR(MAX))



	
    COMMIT TRANSACTION

  