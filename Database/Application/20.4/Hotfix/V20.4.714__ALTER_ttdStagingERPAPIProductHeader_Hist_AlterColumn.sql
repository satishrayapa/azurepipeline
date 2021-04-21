--------------------------------------------------------------------------------------------------------------
--MODIFY EXISTING COLUMN
--------------------------------------------------------------------------------------------------------------
IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'Note' --your column here
			AND Object_ID = OBJECT_ID('ttdStagingERPAPIProductHeader')) --your table here
BEGIN
	ALTER TABLE ttdStagingERPAPIProductHeader --Your Table Here
	ALTER COLUMN Note nvarchar (MAX) NOT NULL --your column here
END

GO
IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'Note' --your column here
			AND Object_ID = OBJECT_ID('ttdStagingERPAPIProductHeaderHist')) --your table here
BEGIN
	ALTER TABLE ttdStagingERPAPIProductHeaderHist --Your Table Here
	ALTER COLUMN Note nvarchar (MAX) NOT NULL --your column here
END