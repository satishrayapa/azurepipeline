alter table tmgUser alter column userpassword varchar(172) not null
go
alter table tmgUserHIST alter column userpassword varchar(172) not null
go
IF EXISTS (SELECT TOP 1 1 FROM sys.tables
			WHERE Name = 'tmgUserDELETED' --Your Table Here
			AND Type = 'U')
BEGIN
	exec( 'alter table tmgUserDELETED alter column userpassword varchar(172) not null' )
end
go
alter table tmgUserPasswordResetHistory alter column oldpassword varchar(172) not null
go
IF EXISTS (SELECT TOP 1 1 FROM sys.tables
			WHERE Name = 'tradeopsusers' --Your Table Here
			AND Type = 'U')
BEGIN
	exec( 'alter table tradeopsusers alter column UserPassword varchar(172) not null' )
end