IF EXISTS (select TOP 1 1 from dbo.sysobjects where id = object_id(N'[dbo].[tlgApplicationLaunchTree]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
AND NOT EXISTS (SELECT TOP 1 1 FROM dbo.tlgApplicationLaunchTree WITH (NOLOCK) WHERE WorkFlow IN ('StandardDPSExtract_Preparation', 'StandardDPSExtract_GFE', 'StandardDPSExtract_CompressFiles'))

BEGIN	
DECLARE @PartnerID AS INT = (SELECT PartnerID FROM dbo.tmfDefaults WITH (NOLOCK))
INSERT INTO dbo.tlgApplicationLaunchTree
        ( PartnerID ,
          EffDate ,
          WorkFlow ,
          SequenceNo ,
          ApplicationToLaunch ,
          Command ,
          DeletedFlag ,
          KeepDuringRollback
        )
VALUES  ( @PartnerID, -- PartnerID - int
          GETDATE() , -- EffDate - datetime
          'StandardDPSExtract_Preparation' , -- WorkFlow - varchar(255)
          1 , -- SequenceNo - int
          'dxdExecuteSQLBatch.dll' , -- ApplicationToLaunch - varchar(255)
          'StandardDPSExtract_Preparation_ClearPRW' , -- Command - varchar(255)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )

INSERT INTO dbo.tlgApplicationLaunchTree
        ( PartnerID ,
          EffDate ,
          WorkFlow ,
          SequenceNo ,
          ApplicationToLaunch ,
          Command ,
          DeletedFlag ,
          KeepDuringRollback
        )
VALUES  ( @PartnerID, -- PartnerID - int
          GETDATE() , -- EffDate - datetime
          'StandardDPSExtract_Preparation' , -- WorkFlow - varchar(255)
          2 , -- SequenceNo - int
          'dxdContentSubscriptionExtract.dll' , -- ApplicationToLaunch - varchar(255)
          'UpdateExtractStatus' , -- Command - varchar(255)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )


INSERT INTO dbo.tlgApplicationLaunchTree
        ( PartnerID ,
          EffDate ,
          WorkFlow ,
          SequenceNo ,
          ApplicationToLaunch ,
          Command ,
          DeletedFlag ,
          KeepDuringRollback
        )
VALUES  ( @PartnerID, -- PartnerID - int
          GETDATE() , -- EffDate - datetime
          'StandardDPSExtract_Preparation' , -- WorkFlow - varchar(255)
          3 , -- SequenceNo - int
          'dxdExtractBulkLoader.dll' , -- ApplicationToLaunch - varchar(255)
          'StandardDPSExtract_Preparation_BulkLoader' , -- Command - varchar(255)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )

INSERT INTO dbo.tlgApplicationLaunchTree
        ( PartnerID ,
          EffDate ,
          WorkFlow ,
          SequenceNo ,
          ApplicationToLaunch ,
          Command ,
          DeletedFlag ,
          KeepDuringRollback
        )
VALUES  ( @PartnerID, -- PartnerID - int
          GETDATE() , -- EffDate - datetime
          'StandardDPSExtract_GFE' , -- WorkFlow - varchar(255)
          1 , -- SequenceNo - int
          'dxdExecuteSQLBatch.dll' , -- ApplicationToLaunch - varchar(255)
          'StandardDPSExtract_GFE_ClearPRW' , -- Command - varchar(255)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )



INSERT INTO dbo.tlgApplicationLaunchTree
        ( PartnerID ,
          EffDate ,
          WorkFlow ,
          SequenceNo ,
          ApplicationToLaunch ,
          Command ,
          DeletedFlag ,
          KeepDuringRollback
        )
VALUES  ( @PartnerID, -- PartnerID - int
          GETDATE() , -- EffDate - datetime
          'StandardDPSExtract_GFE' , -- WorkFlow - varchar(255)
          2 , -- SequenceNo - int
          'dxgGenericFileExportWorkflow.dll' , -- ApplicationToLaunch - varchar(255)
          'StandardDPSExtract_GFE' , -- Command - varchar(255)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )


INSERT INTO dbo.tlgApplicationLaunchTree
        ( PartnerID ,
          EffDate ,
          WorkFlow ,
          SequenceNo ,
          ApplicationToLaunch ,
          Command ,
          DeletedFlag ,
          KeepDuringRollback
        )
VALUES  ( @PartnerID, -- PartnerID - int
          GETDATE() , -- EffDate - datetime
          'StandardDPSExtract_CompressFiles' , -- WorkFlow - varchar(255)
          1 , -- SequenceNo - int
          'dxdExecuteSQLBatch.dll' , -- ApplicationToLaunch - varchar(255)
          'StandardDPSExtract_CompressFiles_ClearPRW' , -- Command - varchar(255)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )



INSERT INTO dbo.tlgApplicationLaunchTree
        ( PartnerID ,
          EffDate ,
          WorkFlow ,
          SequenceNo ,
          ApplicationToLaunch ,
          Command ,
          DeletedFlag ,
          KeepDuringRollback
        )
VALUES  ( @PartnerID, -- PartnerID - int
          GETDATE() , -- EffDate - datetime
          'StandardDPSExtract_CompressFiles' , -- WorkFlow - varchar(255)
          2 , -- SequenceNo - int
          'dxgGenericCompressor.dll' , -- ApplicationToLaunch - varchar(255)
          'StandardDPSExtract_CompressFiles' , -- Command - varchar(255)
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )

END	