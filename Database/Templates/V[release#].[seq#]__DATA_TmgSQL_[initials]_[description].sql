insert into tmgsql
select partnerid, getdate(),SQLGUID
,SQLDescription
,SQLCmd,GETDATE()
,SQLLongDescription, 'N', 'N'
from tmfdefaults

insert into tmgSQLUserList
select partnerid, getdate()
,UserGUID
,SQLGUID
,PageName
,'N', 'N'
from tmfdefaults
