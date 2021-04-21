--------------------------------------------------------------------------------------------------------------
--MODIFY EXISTING COLUMN
--The usp_DBACopyTableIndexesByColumn stored proc searches for an index on the modified column.  If it exists,
--it will drop that index to allow column changes.
--The usp_DBACreateTableIndexes stored proc recreates the dropped index.
--------------------------------------------------------------------------------------------------------------
				
IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'Question' --your column here
			AND Object_ID = OBJECT_ID('tmdDecisionTreeQuestion')) --Your Table Here
BEGIN
	--Do not change 1st and 5th parameter.  
	--4th parameter is the updated data type; 6th paramter is the updated column length if any
	EXEC usp_DBACopyTableIndexesByColumn '','tmdDecisionTreeQuestion','Question','nvarchar',1,2000

	ALTER TABLE tmdDecisionTreeQuestion --Your Table Here
	ALTER COLUMN Question [nvarchar] (2000) NOT NULL --your column here

	--Do not change 1st paramter.  
	EXEC usp_DBACreateTableIndexes '','tmdDecisionTreeQuestion' --Your Table Here
END		

IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'Question' --your column here
			AND Object_ID = OBJECT_ID('tmdDecisionTreeQuestionHist')) --Your Table Here
BEGIN
	--Do not change 1st and 5th parameter.  
	--4th parameter is the updated data type; 6th paramter is the updated column length if any
	EXEC usp_DBACopyTableIndexesByColumn '','tmdDecisionTreeQuestionHist','Question','nvarchar',1,2000

	ALTER TABLE tmdDecisionTreeQuestionHist --Your Table Here
	ALTER COLUMN Question [nvarchar] (2000) NOT NULL --your column here

	--Do not change 1st paramter.  
	EXEC usp_DBACreateTableIndexes '','tmdDecisionTreeQuestionHist' --Your Table Here
END

                   
IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'Question' --your column here
                     AND Object_ID = OBJECT_ID('tmdDecisionTreeSessionAnswer')) --Your Table Here
BEGIN
       --Do not change 1st and 5th parameter.  
       --4th parameter is the updated data type; 6th paramter is the updated column length if any
       EXEC usp_DBACopyTableIndexesByColumn '','tmdDecisionTreeSessionAnswer','Question','nvarchar',1,2000

       ALTER TABLE tmdDecisionTreeSessionAnswer --Your Table Here
       ALTER COLUMN Question [nvarchar] (2000) NOT NULL --your column here

       --Do not change 1st paramter.  
       EXEC usp_DBACreateTableIndexes '','tmdDecisionTreeSessionAnswer' --Your Table Here
END           

IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'Question' --your column here
                     AND Object_ID = OBJECT_ID('tmdDecisionTreeSessionAnswerHist')) --Your Table Here
BEGIN
       --Do not change 1st and 5th parameter.  
       --4th parameter is the updated data type; 6th paramter is the updated column length if any
       EXEC usp_DBACopyTableIndexesByColumn '','tmdDecisionTreeSessionAnswerHist','Question','nvarchar',1,2000

       ALTER TABLE tmdDecisionTreeSessionAnswerHist --Your Table Here
       ALTER COLUMN Question [nvarchar] (2000) NOT NULL --your column here

       --Do not change 1st paramter.  
       EXEC usp_DBACreateTableIndexes '','tmdDecisionTreeSessionAnswerHist' --Your Table Here
END