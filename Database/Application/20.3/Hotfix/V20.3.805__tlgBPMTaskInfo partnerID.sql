IF (SELECT COUNT(*) FROM dbo.syscolumns WHERE name IN ('PartnerD')
			AND ID = OBJECT_ID('tlgBPMTaskInfo')	) = 0
BEGIN
	print 'column already correct'
END
ELSE
BEGIN
	exec sp_RENAME 'tlgBPMTaskInfo.PartnerD' , 'PartnerId', 'COLUMN';
END