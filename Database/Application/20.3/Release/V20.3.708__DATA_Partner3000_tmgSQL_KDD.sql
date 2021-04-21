
IF NOT EXISTS (SELECT TOP 1 1 FROM dbo.tmgSQL WITH (NOLOCK) WHERE SQLGUID IN ('89ee1ada-6965-4c61-bdb6-d7255ffee74d','66c49da0-39e9-4df1-8d24-09cbc8bb91dc','7b3920af-571a-44fa-9a1b-9a156df91542'))
BEGIN	

DECLARE @PartnerID AS INT = (SELECT PartnerID FROM dbo.tmfDefaults WITH (NOLOCK))

INSERT INTO dbo.tmgSQL
        ( PartnerID ,
          EffDate ,
          SQLGUID ,
          SQLDescription ,
          SQLCmd ,
          TxnDate ,
          SQLLongDescription ,
          DeletedFlag ,
          KeepDuringRollback
        )
VALUES  ( @PartnerID , -- PartnerID - int
          GETDATE() , -- EffDate - datetime
          '89ee1ada-6965-4c61-bdb6-d7255ffee74d' , -- SQLGUID - varchar(50)
          N'Standard DPS Extract- Generate Deltas' , -- SQLDescription - nvarchar(200)
          N'EXEC dbo.usp_DBARebuildIndexes @ReadOnly = 0,
    @TableName = ''tmdFullStandardDPSExtractToday'';

DECLARE @rows AS INTEGER;
SET @rows = 1;

WHILE ( @rows > 0 )
    BEGIN
        BEGIN TRAN;
        UPDATE TOP ( 100000 )
                dbo.tmdFullStandardDPSExtractToday
        SET     HashSum = HASHBYTES(''SHA1'',
                                    CAST(RegListID AS VARCHAR)
                                    + ListCountryCode + ListCountryName
                                    + RegListName + Organization + Website
                                    + CAST(RegEntityID AS VARCHAR)
                                    + CAST(RegEffDate AS VARCHAR)
                                    + CAST(RegExpDate AS VARCHAR)
                                    + RegEntityStatusID + AltNameType
                                    + AltFullName + Address + City
                                    + SubCountryCode + SubCountry + PostalCode
                                    + CountryCode + CountryName + Reason
                                    + CAST(ReasonEffDate AS VARCHAR)
                                    + CAST(ReasonExpDate AS VARCHAR)
                                    + ReasonRemarks + ExceptionName
                                    + ExceptionDescription
                                    + CAST(ExceptionEffDate AS VARCHAR)
                                    + CAST(ExceptionExpDate AS VARCHAR))
        WHERE   HashSum IS NULL;
        SET @rows = @@rowcount;
        COMMIT TRAN;																				
    END;

EXEC dbo.usp_DBARebuildIndexes @ReadOnly = 0,
    @TableName = ''tmdFullStandardDPSExtractToday'';



INSERT  INTO dbo.ttdStagingUnprocessedStandardDPSNightlyExtract
        ( PartnerID ,
          EffDate ,
          RegListID ,
          RegEntityID ,
          RegEffDate ,
          RegExpDate ,
          ReasonEffDate ,
          ReasonExpDate ,
          ExceptionEffDate ,
          ExceptionExpDate ,
          DeltaType ,
          DeletedFlag ,
          KeepDuringRollback
        )
        SELECT DISTINCT
                @PartnerID ,
                GETDATE() ,
                RegListID ,
                RegEntityID ,
                RegEffDate ,
                RegExpDate ,
                ReasonEffDate ,
                ReasonExpDate ,
                ExceptionEffDate ,
                ExceptionExpDate ,
                ''Record Add/Update'' ,
                ''N'' ,
                ''N''
        FROM    dbo.tmdFullStandardDPSExtractToday today
        WHERE   NOT EXISTS ( SELECT TOP 1
                                    1
                             FROM   dbo.tmdFullStandardDPSExtractYesterday yest
                             WHERE  yest.HashSum = today.HashSum );



INSERT  INTO dbo.ttdStagingUnprocessedStandardDPSNightlyExtract
        ( PartnerID ,
          EffDate ,
          RegListID ,
          RegEntityID ,
          RegEffDate ,
          RegExpDate ,
          ReasonEffDate ,
          ReasonExpDate ,
          ExceptionEffDate ,
          ExceptionExpDate ,
          DeltaType ,
          DeletedFlag ,
          KeepDuringRollback
        )
        SELECT DISTINCT
                @PartnerID ,
                GETDATE() ,
                RegListID ,
                RegEntityID ,
                RegEffDate ,
                RegExpDate ,
                ReasonEffDate ,
                ReasonExpDate ,
                ExceptionEffDate ,
                ExceptionExpDate ,
                ''Record Expiry'' ,
                ''N'' ,
                ''N''
        FROM    dbo.tmdFullStandardDPSExtractYesterday yesterday
        WHERE   NOT EXISTS ( SELECT TOP 1
                                    1
                             FROM   dbo.tmdFullStandardDPSExtractToday today
                             WHERE  today.HashSum = yesterday.HashSum )
                AND EXISTS ( SELECT TOP 1
                                    1
                             FROM   dbo.tmdFullStandardDPSExtractToday today1
                             WHERE  today1.RegListID = yesterday.RegListID );


                                       
EXEC dbo.usp_DBARebuildIndexes @ReadOnly = 0,
    @TableName = ''ttdStagingUnprocessedStandardDPSNightlyExtract'';' , -- SQLCmd - ntext
          GETDATE() , -- TxnDate - datetime
          N'identify delta records to go out to the client' , -- SQLLongDescription - ntext
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )

INSERT INTO dbo.tmgSQL
        ( PartnerID ,
          EffDate ,
          SQLGUID ,
          SQLDescription ,
          SQLCmd ,
          TxnDate ,
          SQLLongDescription ,
          DeletedFlag ,
          KeepDuringRollback
        )
VALUES  ( @PartnerID , -- PartnerID - int
          GETDATE() , -- EffDate - datetime
          '66c49da0-39e9-4df1-8d24-09cbc8bb91dc' , -- SQLGUID - varchar(50)
          N'Standard DPS Extract - Generate Batch' , -- SQLDescription - nvarchar(200)
          N'
DECLARE @RegListId INTEGER;
SET @RegListId = ( SELECT TOP 1
                            RegListID
                   FROM     dbo.tmdFullStandardDPSExtractToday WITH ( NOLOCK )
                   ORDER BY RegListID
                 );				 
				


EXEC dbo.usp_DBARebuildIndexes @ReadOnly = 0,
    @TableName = ''ttdStagingInprocessStandardDPSNightlyExtract'';



INSERT  INTO dbo.ttdStagingInprocessStandardDPSNightlyExtract
        ( PartnerID ,
          EffDate ,
          RegListID ,
          RegEntityID ,
          DeletedFlag ,
          KeepDuringRollback
        )
        SELECT DISTINCT TOP 50000
                PartnerID ,
                GETDATE() ,
                RegListID ,
                RegEntityID ,
                ''N'' ,
                ''N''
        FROM    dbo.ttdStagingUnprocessedStandardDPSNightlyExtract nightly
                WITH ( NOLOCK )
        WHERE   nightly.RegListID = @RegListId;',
          GETDATE() , -- TxnDate - datetime
          N'Generates the next batch of records to go out in the next file' , -- SQLLongDescription - ntext
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )

INSERT INTO dbo.tmgSQL
        ( PartnerID ,
          EffDate ,
          SQLGUID ,
          SQLDescription ,
          SQLCmd ,
          TxnDate ,
          SQLLongDescription ,
          DeletedFlag ,
          KeepDuringRollback
        )
VALUES  ( @PartnerID , -- PartnerID - int
          GETDATE() , -- EffDate - datetime
          '7b3920af-571a-44fa-9a1b-9a156df91542' , -- SQLGUID - varchar(50)
          N'Standard DPS Extract - Restart Extract/Cleanup' , -- SQLDescription - nvarchar(200)
          N'DECLARE @RegListId INTEGER;
SET @RegListId = ( SELECT   ISNULL(( SELECT TOP 1
                                            RegListID
                                     FROM   dbo.ttdStagingInprocessStandardDPSNightlyExtract
                                   ),
                                   ( SELECT TOP 1
                                            RegListID
                                     FROM   dbo.tmdFullStandardDPSExtractToday
                                     ORDER BY RegListID
                                   ))
                 );
														
INSERT  INTO dbo.ttdStagingUnprocessedStandardDPSNightlyExtractHIST
        SELECT  *
        FROM    dbo.ttdStagingUnprocessedStandardDPSNightlyExtract unp
        WHERE   EXISTS ( SELECT TOP 1
                                1
                         FROM   dbo.ttdStagingInprocessStandardDPSNightlyExtract inproc
                         WHERE  inproc.RegListID = unp.RegListID
                                AND inproc.RegEntityID = unp.RegEntityID );
			
DELETE  unp
FROM    dbo.ttdStagingUnprocessedStandardDPSNightlyExtract unp
WHERE   EXISTS ( SELECT TOP 1
                        1
                 FROM   dbo.ttdStagingInprocessStandardDPSNightlyExtract inproc
                 WHERE  inproc.RegListID = unp.RegListID
                        AND inproc.RegEntityID = unp.RegEntityID );
					
EXEC dbo.usp_DBARebuildIndexes @ReadOnly = 0,
    @TableName = ''ttdStagingUnprocessedStandardDPSNightlyExtract'';

					
IF NOT EXISTS ( SELECT TOP 1
                        1
                FROM    dbo.ttdStagingUnprocessedStandardDPSNightlyExtract
                WHERE   RegListID = @RegListId )
    BEGIN
												
        DELETE  FROM dbo.tmdFullStandardDPSExtractYesterday
        WHERE   RegListID = @RegListId;
												
        INSERT  INTO dbo.tmdFullStandardDPSExtractYesterday
                SELECT  *
                FROM    dbo.tmdFullStandardDPSExtractToday
                WHERE   RegListID = @RegListId;
												
        DELETE  FROM dbo.tmdFullStandardDPSExtractToday
        WHERE   RegListID = @RegListId;
												
        EXEC dbo.usp_DBARebuildIndexes @ReadOnly = 0,
            @TableName = ''tmdFullStandardDPSExtractYesterday'';
												
        EXEC dbo.usp_DBARebuildIndexes @ReadOnly = 0,
            @TableName = ''tmdFullStandardDPSExtractToday'';
												
    END;

TRUNCATE TABLE ttdStagingInprocessStandardDPSNightlyExtract;' , -- SQLCmd - ntext
          GETDATE() , -- TxnDate - datetime
          N'restart extract if more records to process otherwise cleanup' , -- SQLLongDescription - ntext
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )




END
      

