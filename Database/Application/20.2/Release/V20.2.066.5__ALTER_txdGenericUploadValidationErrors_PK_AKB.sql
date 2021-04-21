BEGIN
    IF exists (select * from dbo.sysobjects where name = 'PK_txdGenericUploadValidationErrors') 
        begin
            ALTER TABLE [dbo].[txdGenericUploadValidationErrors] DROP CONSTRAINT [PK_txdGenericUploadValidationErrors]
        end
    PRINT 'CREATE PRIMARY KEY......'
    ALTER TABLE [dbo].[txdGenericUploadValidationErrors] ADD CONSTRAINT
        PK_txdGenericUploadValidationErrors PRIMARY KEY NONCLUSTERED 
        (
            [PartnerID] ASC,
            [UploadType] ASC,
            [DestinationTable] ASC,
            [FileGUID] ASC,            
            [ValidationCode] ASC,
            [LineNum] ASC,
            [FieldName] ASC
        ) WITH FILLFACTOR = 90 ON [PRIMARY]
END