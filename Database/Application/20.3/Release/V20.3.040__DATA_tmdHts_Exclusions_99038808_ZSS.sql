-- tmdhts_Exclusions updates
IF EXISTS (select * from dbo.sysobjects where id = object_id(N'[dbo].[tmdhts_Exclusions]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN  
	UPDATE dbo.tmdHTS_Exclusions
	SET EndEffDate = '2020-12-31'
	WHERE	Exclusion='99038808' AND EndEffDate='2020-05-14' 
			AND HTSNum IN ('8421210000','8421398015','8481100090','8481909040','8483509040','9011108000','9011900000')
END
