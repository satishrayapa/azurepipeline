--------------------------------------------------------------------------------------------------------------
--CREATE A NONCLUSTERED INDEX
--Use this script to create a non-clustered index on an existing table. 
--It will ensure that the naming convention is followed and will create the next name in numerical order.
--Note if creating a clustered index there is no need to use this. Just make the name CIX_TableName
--------------------------------------------------------------------------------------------------------------

DECLARE @indexPrefix varchar(60) = 'IX_tablename_'
DECLARE @table varchar(60) = 'dbo.tablename'
DECLARE @indexColumns varchar(800) = 'PartnerID,ExitDocID DESC,TxnCode,StatusCode,HtsIndex' --can include DESC
DECLARE @includedColumns varchar(800) = ''

---------------------no changes below here---------------------
DECLARE	@sql NVARCHAR(4000)
DECLARE	@indexnumber INT
DECLARE	@created BIT

SET @indexnumber = 1
DECLARE @name varchar(100)
SELECT top 1 @name = a.name from (
				SELECT 
				   i.name, 
				   substring(isnull((SELECT ',' + upper(c.name) + case when ic.is_descending_key = 1 then ' DESC' else '' end
					  FROM sys.index_columns ic
					  JOIN sys.columns c on c.column_id = ic.column_id and c.object_id = ic.object_id
					 WHERE ic.index_ID = i.index_ID and ic.object_id = i.object_id
					 and ic.is_included_column = 0
					 order by ic.key_ordinal
					FOR XML PATH('')), ','), 2,1000) [index_columns], 
				   substring(isnull((SELECT ',' + upper(c.name)
					  FROM sys.index_columns ic
					  JOIN sys.columns c on c.column_id = ic.column_id and c.object_id = ic.object_id
					 WHERE ic.index_ID = i.index_ID and ic.object_id = i.object_id
					 and ic.is_included_column = 1
					 order by ic.key_ordinal
					FOR XML PATH('')), ','), 2,1000) [included_columns]
				FROM sys.indexes i
				where i.object_id = OBJECT_ID(@table) 
				GROUP BY i.index_id, i.NAME, i.object_id
			) a
			where a.name like @indexPrefix + '%' and a.index_columns = upper(@indexColumns) and a.included_columns = upper(@includedColumns)
			
SET @created = CASE WHEN @name is not null THEN 1 ELSE 0 END

if @created = 0
begin
WHILE @created = 0 
	BEGIN
		IF EXISTS ( SELECT	TOP 1 1
					FROM	sys.indexes
					WHERE	OBJECT_ID = OBJECT_ID(@table)
							AND name = @indexPrefix + CAST(@indexnumber AS VARCHAR(2)) ) 
			BEGIN SET @indexnumber = @indexnumber + 1 END
		ELSE 
			BEGIN		
			set @sql = 'CREATE NONCLUSTERED INDEX [' + @indexPrefix + '' + CAST(@indexnumber as varchar(2)) + '] ON ' + @table + ' (' + @indexColumns + ')'
			if len(@includedColumns) > 0
			begin
				set @sql = @sql + ' INCLUDE ( ' + @includedColumns + ')'
			end

			EXEC sp_executesql @SQL
			print 'created index: ' + @indexPrefix + '' + CAST(@indexnumber as varchar(2)) 
			SET @created = 1
		END
	END
end
else
BEGIN
	print 'index already exists: ' + @name
END