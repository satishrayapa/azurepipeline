IF EXISTS (select * from dbo.sysobjects where id = object_id(N'[dbo].[tmdABIDispositionCodes]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN  
	UPDATE tmdABIDispositionCodes
	SET ShortDesc = 'Post Admission Correction Request Approved'
	WHERE Code = 'JAP'

	UPDATE tmdABIDispositionCodes
	SET ShortDesc = 'Post Admission Correction Request Denied'
	WHERE Code = 'JDE'
END