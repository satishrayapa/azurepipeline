IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'Agreement' --Any 1 of your NEW columns here
				AND Object_ID = Object_ID('txdHSCorrelation'))
BEGIN
	--Remove previous primary key
	DECLARE @table NVARCHAR(30), @sql NVARCHAR(MAX);

	SELECT @table = N'dbo.txdHSCorrelation';

	SELECT @sql = 'ALTER TABLE ' + @table 
		+ ' DROP CONSTRAINT ' + name + ';'
		FROM sys.key_constraints
		WHERE [type] = 'PK'
		AND [parent_object_id] = OBJECT_ID(@table);

	EXEC (@sql);

	--Rename the Agreement field to be CultureGUID
	EXEC sp_rename 'txdHSCorrelation.Agreement', 'CultureGuid', 'COLUMN';

	--Re-add primary key including CultureGUID
	ALTER TABLE [dbo].[txdHSCorrelation] ADD CONSTRAINT [PK_txdHSCorrelation] PRIMARY KEY NONCLUSTERED
	(
			[PartnerID] ASC,
			[CultureGuid] ASC,
			[OriginalWCOYear] ASC,
			[OriginalHS] ASC,
			[ReplacementWCOYear] ASC,
			[ReplacementHS] ASC
	)
END
