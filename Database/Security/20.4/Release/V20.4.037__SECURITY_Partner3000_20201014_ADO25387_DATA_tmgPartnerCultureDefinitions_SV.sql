
IF EXISTS(select * from tmgPartnerCultureDefinitions with(nolock)  where PartnerId = 3000 and FieldName ='fmgMaintenance_aspx')
        BEGIN
             Delete  tmgPartnerCultureDefinitions
             where PartnerId = 3000 and FieldName ='fmgMaintenance_aspx'
        END