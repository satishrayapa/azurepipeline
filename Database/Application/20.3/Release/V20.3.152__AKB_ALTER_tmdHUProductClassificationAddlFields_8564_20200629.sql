IF EXISTS (SELECT TOP 1 1 FROM sys.tables WHERE Name = 'tmdHUProductClassificationAddlFields' AND Type = 'U')
BEGIN
    IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'KeepDurinHUollback' AND Object_ID = Object_ID('tmdHUProductClassificationAddlFields')) 
    BEGIN
            EXEC sp_rename 'tmdHUProductClassificationAddlFields.KeepDurinHUollback', 'KeepDuringRollback', 'COLUMN';
    END
END