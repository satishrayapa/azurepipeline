IF EXISTS (SELECT TOP 1 1 FROM sys.tables
            WHERE Name = 'txdCNDeclarationData' 
            AND Type = 'U')
BEGIN
    IF (    
        SELECT COUNT(*) FROM dbo.syscolumns
        WHERE name IN ('TrnHeadTrafCustomsNTrnHeado','TrnHeadTrafCustomsNo')
            AND ID = OBJECT_ID('txdCNDeclarationData')    
        ) = 2
    BEGIN

    --drop extra column
    ALTER TABLE txdCNDeclarationData
    DROP COLUMN TrnHeadTrafCustomsNo;
 
    --rename column 
 
   EXEC sp_rename 'txdCNDeclarationData.TrnHeadTrafCustomsNTrnHeado', 'TrnHeadTrafCustomsNo', 'COLUMN';

    END
    ELSE
    BEGIN
    PRINT 'Alter Not required....'
    END
END