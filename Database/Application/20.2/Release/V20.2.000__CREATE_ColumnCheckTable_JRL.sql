if not exists (select name from sys.types where name = 'ColumnCheckTable')
begin
CREATE TYPE [dbo].[ColumnCheckTable] AS TABLE(
	[ColumnName] [nvarchar](150) NULL,
	[ColumnType] [nvarchar](128) NULL,
	[ColumnLength] [int] NULL,
	[ColumnScale] [int] NULL,
	[ColumnPrecision] [int] NULL
)
end