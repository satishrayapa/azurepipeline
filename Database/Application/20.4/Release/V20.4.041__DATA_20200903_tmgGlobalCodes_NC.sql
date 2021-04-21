IF EXISTS (select * from dbo.sysobjects where id = object_id(N'[dbo].[tmgglobalcodes]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN  
	IF EXISTS (select * from dbo.sysobjects where id = object_id(N'[dbo].[tmfDefaults]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	BEGIN
		IF Object_ID('tempdb..#tmgglobalcodes') IS NOT NULL DROP TABLE #tmgglobalcodes

		Declare @FieldName AS Varchar(30)
		Set @FieldName = 'USReconAccountingClassCode'

			DELETE FROM dbo.tmgglobalcodes WHERE FieldName = @FieldName

			Create Table #tmgglobalcodes([PartnerID] int, [FieldName] varchar(30), [Code] nvarchar(36), [Decode] nvarchar(300))
			INSERT INTO #tmgglobalcodes(PartnerID, FieldName, Code, Decode)  
				(
				SELECT DISTINCT PartnerID, @FieldName, '001', 'Duty' FROM dbo.tmfDefaults
				UNION ALL 
				SELECT DISTINCT PartnerID, @FieldName, '016', 'Distilled Spirits IR Tax' FROM dbo.tmfDefaults
				UNION ALL 
				SELECT DISTINCT PartnerID, @FieldName, '017', 'Wines IR Tax' FROM dbo.tmfDefaults
				UNION ALL 
				SELECT DISTINCT PartnerID, @FieldName, '018', 'Tobacco Products IR Tax' FROM dbo.tmfDefaults
				UNION ALL 
				SELECT DISTINCT PartnerID, @FieldName, '022', 'Other IR Tax' FROM dbo.tmfDefaults
				UNION ALL 
				SELECT DISTINCT PartnerID, @FieldName, '044', 'Interest' FROM dbo.tmfDefaults
				UNION ALL 
				SELECT DISTINCT PartnerID, @FieldName, '053', 'Beef Fee' FROM dbo.tmfDefaults
				UNION ALL 
				SELECT DISTINCT PartnerID, @FieldName, '054', 'Pork Fee' FROM dbo.tmfDefaults
				UNION ALL 
				SELECT DISTINCT PartnerID, @FieldName, '055', 'Honey Fee' FROM dbo.tmfDefaults
				UNION ALL 
				SELECT DISTINCT PartnerID, @FieldName, '056', 'Cotton Fee' FROM dbo.tmfDefaults
				UNION ALL 
				SELECT DISTINCT PartnerID, @FieldName, '057', 'Raspberry Fee' FROM dbo.tmfDefaults
				UNION ALL 
				SELECT DISTINCT PartnerID, @FieldName, '079', 'Sugar Fee' FROM dbo.tmfDefaults
				UNION ALL 
				SELECT DISTINCT PartnerID, @FieldName, '090', 'Potato Fee' FROM dbo.tmfDefaults
				UNION ALL 
				SELECT DISTINCT PartnerID, @FieldName, '102', 'Lime Fee' FROM dbo.tmfDefaults
				UNION ALL 
				SELECT DISTINCT PartnerID, @FieldName, '103', 'Mushroom Fee' FROM dbo.tmfDefaults
				UNION ALL 
				SELECT DISTINCT PartnerID, @FieldName, '104', 'Watermelon Fee' FROM dbo.tmfDefaults
				UNION ALL 
				SELECT DISTINCT PartnerID, @FieldName, '105', 'Softwood Lumber Fee' FROM dbo.tmfDefaults
				UNION ALL 
				SELECT DISTINCT PartnerID, @FieldName, '106', 'Blueberry Fee' FROM dbo.tmfDefaults
				UNION ALL 
				SELECT DISTINCT PartnerID, @FieldName, '107', 'Avocado Fee' FROM dbo.tmfDefaults
				UNION ALL 
				SELECT DISTINCT PartnerID, @FieldName, '108', 'Mango Fee' FROM dbo.tmfDefaults
				UNION ALL 
				SELECT DISTINCT PartnerID, @FieldName, '109', 'Sorghum Fee' FROM dbo.tmfDefaults
				UNION ALL 
				SELECT DISTINCT PartnerID, @FieldName, '110', 'Dairy Product Fee' FROM dbo.tmfDefaults
				UNION ALL 
				SELECT DISTINCT PartnerID, @FieldName, '311', 'Informal Merchandise Processing Fee' FROM dbo.tmfDefaults
				UNION ALL 
				SELECT DISTINCT PartnerID, @FieldName, '496', 'Dutiable Mail Fee' FROM dbo.tmfDefaults
				UNION ALL 
				SELECT DISTINCT PartnerID, @FieldName, '499', 'Formal Merchandise Processing Fee' FROM dbo.tmfDefaults
				UNION ALL 
				SELECT DISTINCT PartnerID, @FieldName, '500', 'Manual Entry Surcharge' FROM dbo.tmfDefaults
				UNION ALL 
				SELECT DISTINCT PartnerID, @FieldName, '501', 'Harbor Maintenance Fee' FROM dbo.tmfDefaults
				UNION ALL 
				SELECT DISTINCT PartnerID, @FieldName, '672', 'Coffee Imports to Puerto Rico Duty Assessment' FROM dbo.tmfDefaults
				)
			

			MERGE dbo.tmgglobalcodes dt
				USING #tmgglobalcodes te
					ON  dt.PartnerID			= te.PartnerID 		
					AND dt.FieldName		= te.FieldName
					AND dt.Code	= te.Code		
			WHEN MATCHED
					THEN UPDATE SET
						dt.EffDate		= GETDATE()
						,dt.Decode		= te.Decode
			WHEN NOT MATCHED BY TARGET
					THEN INSERT (PartnerID, EffDate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback) 
					VALUES (te.PartnerID, GETDATE(), @FieldName, te.Code, te.Decode, 'N', 'N', 'N');

			IF OBJECT_ID('tempdb..#tmgglobalcodes') IS NOT NULL DROP TABLE #tmgglobalcodes
	End
END