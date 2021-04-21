
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'usrtxdCNHandbookConsDetail'
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
	CREATE TABLE [dbo].[usrtxdCNHandbookConsDetail]
	(
		 PartnerId INT
		,UserName NVARCHAR(4000)
		,FileGUID NVARCHAR(50)
		,eHandbookNum NVARCHAR(4000)
		,FGSeqID NVARCHAR(4000)
		,PCProductSeqNum NVARCHAR(4000)
		,BOMVersion NVARCHAR(4000)
		,NetConsumptionQty NVARCHAR(4000)
		,NetConsumptionRate NVARCHAR(4000)
		,AttritionRate NVARCHAR(4000)
		,ConsumptionDeclareStatus NVARCHAR(4000)
		,BondedMaterialRatio NVARCHAR(4000)
		,ModifyMarkCode NVARCHAR(4000)
		,BOMValidDate NVARCHAR(4000)
		,Remark NVARCHAR(4000)
	)
END
