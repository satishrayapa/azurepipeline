IF EXISTS (select * from dbo.sysobjects where id = object_id(N'[dbo].[tmgGlobalCodes]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN  
    DELETE FROM tmgGlobalCodes
    WHERE FieldName='SPICode1' AND Code IN ('S', 'S+') --Just doing this for S+ to correct spacing in the decode field

    INSERT INTO tmgGlobalCodes
        (PartnerID, EffDate, FieldName, Code, Decode, StaticFlag, DeletedFlag, KeepDuringRollback)  
    SELECT PartnerID, GETDATE(), 'SPICode1', 'S', 'S-U.S.-Mexico-Canada Agreement (USMCA)', 'Y', 'N', 'N'
    FROM tmfDefaults d WITH (NOLOCK)
    WHERE NOT EXISTS (SELECT TOP 1 1 FROM tmgGlobalCodes x WITH (NOLOCK) WHERE x.PartnerID=d.PartnerID AND FieldName = 'SPICode1' AND Code = 'S')

    UNION ALL

    SELECT PartnerID, GETDATE(), 'SPICode1', 'S+', 'S+-U.S.-Mexico-Canada Agreement (USMCA)', 'Y', 'N', 'N'
    FROM tmfDefaults d WITH (NOLOCK)
    WHERE NOT EXISTS (SELECT TOP 1 1 FROM tmgGlobalCodes x WITH (NOLOCK) WHERE x.PartnerID=d.PartnerID AND FieldName = 'SPICode1' AND Code = 'S+')
END
