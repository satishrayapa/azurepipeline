
IF EXISTS (SELECT TOP 1 1 FROM sys.tables
			WHERE Name = 'trdReportMassResultBOMs' --Your Table Here
			AND Type = 'U')
BEGIN
			ALTER TABLE trdReportMassResultBOMs
			DROP COLUMN IF EXISTS DeletedFlag,
			COLUMN IF EXISTS KeepDuringRollback
END
GO 
IF EXISTS (SELECT TOP 1 1 FROM sys.tables
			WHERE Name = 'trdReportMassResultBOMs' --Your Table Here
			AND Type = 'U')
BEGIN
	IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'CorrelatedHS' --Any 1 of your NEW columns here
				AND Object_ID = Object_ID('trdReportMassResultBOMs')) --Your Table Here
	BEGIN
			PRINT 'Column Already Exists... Skipping.'
	END
	ELSE
	BEGIN
			ALTER TABLE trdReportMassResultBOMs 
			ADD CorrelatedHS varchar(12)
	END
	IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'DeletedFlag' --Any 1 of your NEW columns here
				AND Object_ID = Object_ID('trdReportMassResultBOMs')) --Your Table Here
	BEGIN
			PRINT 'Column Already Exists... Skipping.'
	END
	ELSE
	BEGIN
			ALTER TABLE trdReportMassResultBOMs 
			ADD DeletedFlag varchar(1)
	END
	IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'KeepDuringRollback' --Any 1 of your NEW columns here
				AND Object_ID = Object_ID('trdReportMassResultBOMs')) --Your Table Here
	BEGIN
			PRINT 'Column Already Exists... Skipping.'
	END
	ELSE
	BEGIN
			ALTER TABLE trdReportMassResultBOMs 
			ADD KeepDuringRollback varchar(1)
	END
END
GO
IF EXISTS (SELECT TOP 1 1 FROM sys.tables
			WHERE Name = 'trdReportMassResultBOMs' --Your Table Here
			AND Type = 'U')
BEGIN

			UPdate trdReportMassResultBOMs
			Set DeletedFlag = 'N',
			KeepDuringRollback = 'N'
END