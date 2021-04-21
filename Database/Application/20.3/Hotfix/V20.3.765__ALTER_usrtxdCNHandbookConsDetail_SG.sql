
IF EXISTS (SELECT TOP 1 1 FROM sys.tables
			WHERE Name = 'usrtxdCNHandbookConsDetail' 
			AND Type = 'U')
BEGIN
	IF (	
		SELECT COUNT(*) FROM dbo.syscolumns
		WHERE name IN ('eHandbookNum','FGSeqID','PCProductSeqNum','ModifyMarkCode','BOMValidDate')
			AND ID = OBJECT_ID('usrtxdCNHandbookConsDetail')	
		) = 5
	BEGIN
	-- rename column
	exec sp_RENAME 'usrtxdCNHandbookConsDetail.eHandbookNum' , 'HandbookNum', 'COLUMN';
	exec sp_RENAME 'usrtxdCNHandbookConsDetail.FGSeqID' , 'FGLineNum', 'COLUMN';
	exec sp_RENAME 'usrtxdCNHandbookConsDetail.PCProductSeqNum' , 'RMLineNum', 'COLUMN';
	exec sp_RENAME 'usrtxdCNHandbookConsDetail.ModifyMarkCode' , 'ModifyMark', 'COLUMN';
	exec sp_RENAME 'usrtxdCNHandbookConsDetail.BOMValidDate' , 'BOMStopDate', 'COLUMN';
	END
END