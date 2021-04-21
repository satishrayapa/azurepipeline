declare @schema nvarchar(255)
declare @table nvarchar(255)
declare @col nvarchar(255)
declare @type nvarchar(255)
declare @length nvarchar(255)
declare @sql nvarchar(max)

declare maxcols cursor for
select
    c.TABLE_SCHEMA,
    c.TABLE_NAME,
    c.COLUMN_NAME,
	c2.DATA_TYPE,
	c2.CHARACTER_MAXIMUM_LENGTH
from information_schema.tables t
join information_schema.columns c on
    c.TABLE_CATALOG = t.TABLE_CATALOG
    and c.TABLE_SCHEMA = t.TABLE_SCHEMA
    and c.TABLE_NAME = t.TABLE_NAME
    and t.TABLE_TYPE = 'BASE TABLE'
join information_schema.tables t2 on
	t2.table_name = replace(replace(t.table_name, 'GenericGCXMLImport', ''), 'Product', 'ProductClassification') 	
join information_schema.columns c2 on
    c2.TABLE_CATALOG = t2.TABLE_CATALOG
    and c2.TABLE_SCHEMA = t2.TABLE_SCHEMA
    and c2.TABLE_NAME = t2.TABLE_NAME
    and t2.TABLE_TYPE = 'BASE TABLE' and
	c2.column_name = c.COLUMN_NAME
where
	t.table_name like 'ttdStagingGenericGCXMLImport%Product%' and
	(
		c.data_type <> c2.data_type or
		c.character_maximum_length <> c2.character_maximum_length
	) and
	1=1

open maxcols

fetch next from maxcols into @schema, @table, @col, @type, @length

while @@FETCH_STATUS = 0
begin
    set @sql = 'alter table [' + @schema + '].[' + @table + 
        '] alter column [' + @col + '] ' + @type + '(' + case @length when -1 then 'max' else @length end + ')'
    exec sp_executesql @sql

    fetch next from maxcols into @schema, @table, @col, @type, @length
end

close maxcols
deallocate maxcols