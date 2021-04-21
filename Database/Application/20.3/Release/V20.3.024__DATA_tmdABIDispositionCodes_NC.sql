IF EXISTS (select * from dbo.sysobjects where id = object_id(N'[dbo].[tmdABIDispositionCodes]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN  
	IF Object_ID('tempdb..#tmdABIDispositionCodes') IS NOT NULL DROP TABLE #tmdABIDispositionCodes
	Select * into #tmdABIDispositionCodes from dbo.tmdABIDispositionCodes where 1 = 2

	INSERT INTO #tmdABIDispositionCodes(Code, ShortDesc)
	Values ('JAP', 'Unconcur Request Approved'),
		   ('JDE', 'Unconcur Request Denied')		

	MERGE dbo.tmdABIDispositionCodes dt
		USING #tmdABIDispositionCodes te
			ON  dt.Code			= te.Code 					
	WHEN MATCHED
			THEN UPDATE SET
				dt.ShortDesc		= te.ShortDesc				
	WHEN NOT MATCHED BY TARGET
			THEN INSERT (Code, ShortDesc) 
			VALUES (te.Code, te.ShortDesc);

	IF OBJECT_ID('tempdb..#tmdABIDispositionCodes') IS NOT NULL DROP TABLE #tmdABIDispositionCodes
END