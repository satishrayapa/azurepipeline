DECLARE @FieldName varchar(30) = 'MXBPMFIFOWARNING'
DECLARE @Code varchar(36) = 'NumberOfDays'
DECLARE @Decode varchar(300) = '30'
DECLARE @StaticFlag  varchar(1) = 'N'

DELETE FROM tmgGlobalCodes WHERE FieldName = @FieldName AND Code = @Code

INSERT INTO tmgGlobalCodes
SELECT PartnerID, getdate(), @FieldName, @Code, @Decode, @StaticFlag, 'N', 'N'
FROM tmfDefaults WITH (NOLOCK)