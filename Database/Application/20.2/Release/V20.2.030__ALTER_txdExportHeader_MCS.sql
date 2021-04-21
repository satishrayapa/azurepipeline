--------------------------------------------------------------------------------------------------------------
--MODIFY EXISTING COLUMN
--ttdStagingExportHeader 
--   change two fields to nvarchar
--------------------------------------------------------------------------------------------------------------
				
IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'INCOTermsLocation' --your column here
			AND Object_ID = OBJECT_ID('ttdStagingExportHeader')) --Your Table Here
	AND EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'PaymentTerms' --your column here
			AND Object_ID = OBJECT_ID('ttdStagingExportHeader'))
BEGIN
	--Do not change 1st and 5th parameter.  
	--4th parameter is the updated data type; 6th paramter is the updated column length if any
	EXEC usp_DBACopyTableIndexesByColumn '','ttdStagingExportHeader','INCOTermsLocation','nvarchar',1,100
	EXEC usp_DBACopyTableIndexesByColumn '','ttdStagingExportHeader','PaymentTerms','nvarchar',1,50

	ALTER TABLE ttdStagingExportHeader --Your Table Here
	ALTER COLUMN INCOTermsLocation [nvarchar] (100) NOT NULL  --your column here
	ALTER TABLE ttdStagingExportHeader --Your Table Here
	ALTER COLUMN PaymentTerms [nvarchar] (50) NOT NULL  --your column here
	
	--Do not change 1st paramter.  
	EXEC usp_DBACreateTableIndexes '','ttdStagingExportHeader' --Your Table Here
END

--------------------------------------------------------------------------------------------------------------
--MODIFY EXISTING COLUMN
--ttdStagingExportHeaderHist 
--   change two fields to nvarchar
--------------------------------------------------------------------------------------------------------------
				
IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'INCOTermsLocation' --your column here
			AND Object_ID = OBJECT_ID('ttdStagingExportHeaderHist')) --Your Table Here
	AND EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'PaymentTerms' --your column here
			AND Object_ID = OBJECT_ID('ttdStagingExportHeaderHist'))

BEGIN
	--Do not change 1st and 5th parameter.  
	--4th parameter is the updated data type; 6th paramter is the updated column length if any
	EXEC usp_DBACopyTableIndexesByColumn '','ttdStagingExportHeaderHist','INCOTermsLocation','nvarchar',1,100
	EXEC usp_DBACopyTableIndexesByColumn '','ttdStagingExportHeaderHist','PaymentTerms','nvarchar',1,50

	ALTER TABLE ttdStagingExportHeaderHist --Your Table Here
	ALTER COLUMN INCOTermsLocation [nvarchar] (100) NOT NULL  --your column here
	ALTER TABLE ttdStagingExportHeaderHist --Your Table Here
	ALTER COLUMN PaymentTerms [nvarchar] (50) NOT NULL  --your column here
	
	--Do not change 1st paramter.  
	EXEC usp_DBACreateTableIndexes '','ttdStagingExportHeaderHist' --Your Table Here
END

--------------------------------------------------------------------------------------------------------------
--MODIFY EXISTING COLUMN
--txdExportHeader 
--   change two fields to nvarchar
--------------------------------------------------------------------------------------------------------------
				
IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'INCOTermsLocation' --your column here
			AND Object_ID = OBJECT_ID('txdExportHeader')) --Your Table Here
	AND EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'PaymentTerms' --your column here
			AND Object_ID = OBJECT_ID('txdExportHeader'))
BEGIN
	--Do not change 1st and 5th parameter.  
	--4th parameter is the updated data type; 6th paramter is the updated column length if any
	EXEC usp_DBACopyTableIndexesByColumn '','txdExportHeader','INCOTermsLocation','nvarchar',1,100
	EXEC usp_DBACopyTableIndexesByColumn '','txdExportHeader','PaymentTerms','nvarchar',1,50

	ALTER TABLE txdExportHeader --Your Table Here
	ALTER COLUMN INCOTermsLocation [nvarchar] (100) NOT NULL  --your column here
	ALTER TABLE txdExportHeader --Your Table Here
	ALTER COLUMN PaymentTerms [nvarchar] (50) NOT NULL  --your column here
	
	--Do not change 1st paramter.  
	EXEC usp_DBACreateTableIndexes '','txdExportHeader' --Your Table Here
END

--------------------------------------------------------------------------------------------------------------
--MODIFY EXISTING COLUMN
--txdExportHeaderHist 
--  change two fields to nvarchar
--------------------------------------------------------------------------------------------------------------
				
IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'INCOTermsLocation' --your column here
			AND Object_ID = OBJECT_ID('txdExportHeaderHist')) --Your Table Here
	AND EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'PaymentTerms' --your column here
			AND Object_ID = OBJECT_ID('txdExportHeaderHist'))
BEGIN
	--Do not change 1st and 5th parameter.  
	--4th parameter is the updated data type; 6th paramter is the updated column length if any
	EXEC usp_DBACopyTableIndexesByColumn '','txdExportHeaderHist','INCOTermsLocation','nvarchar',1,100
	EXEC usp_DBACopyTableIndexesByColumn '','txdExportHeaderHist','PaymentTerms','nvarchar',1,50

	ALTER TABLE txdExportHeader --Your Table Here
	ALTER COLUMN INCOTermsLocation [nvarchar] (100) NOT NULL  --your column here
	ALTER TABLE txdExportHeader --Your Table Here
	ALTER COLUMN PaymentTerms [nvarchar] (50) NOT NULL  --your column here
	
	--Do not change 1st paramter.  
	EXEC usp_DBACreateTableIndexes '','txdExportHeaderHist' --Your Table Here
END


--------------------------------------------------------------------------------------------------------------
--MODIFY EXISTING COLUMN
--trdExportHeader 
--   change two fields to nvarchar
--------------------------------------------------------------------------------------------------------------
				
IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'INCOTermsLocation' --your column here
			AND Object_ID = OBJECT_ID('trdExportHeader')) --Your Table Here
	AND EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'PaymentTerms' --your column here
			AND Object_ID = OBJECT_ID('trdExportHeader'))
BEGIN
	--Do not change 1st and 5th parameter.  
	--4th parameter is the updated data type; 6th paramter is the updated column length if any
	EXEC usp_DBACopyTableIndexesByColumn '','trdExportHeader','INCOTermsLocation','nvarchar',1,100
	EXEC usp_DBACopyTableIndexesByColumn '','trdExportHeader','PaymentTerms','nvarchar',1,50

	ALTER TABLE trdExportHeader --Your Table Here
	ALTER COLUMN INCOTermsLocation [nvarchar] (100) NOT NULL  --your column here
	ALTER TABLE trdExportHeader --Your Table Here
	ALTER COLUMN PaymentTerms [nvarchar] (50) NOT NULL  --your column here
	
	--Do not change 1st paramter.  
	EXEC usp_DBACreateTableIndexes '','trdExportHeader' --Your Table Here
END

