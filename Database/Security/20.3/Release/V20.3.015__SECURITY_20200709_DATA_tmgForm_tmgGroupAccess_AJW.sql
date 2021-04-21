DECLARE @pagename VARCHAR(80)
SET @pagename = 'fidFTACoreParts_aspx'

DELETE  dbo.tmgForm
WHERE   Description = @pagename
DELETE  dbo.tmgGroupAccess
WHERE   FormGUID = @pagename

INSERT  INTO dbo.tmgForm
        ( FormGUID ,
          Description ,
          SystemTypeID ,
          EffDate ,
          DeletedFlag ,
          KeepDuringRollback
        )
VALUES  ( @pagename , -- FormGUID - varchar(50)
          @pagename , -- Description - varchar(80)
          1 , -- SystemTypeID - int
          GETDATE() , -- EffDate - datetime
          'N' , -- DeletedFlag - varchar(1)
          'N'  -- KeepDuringRollback - varchar(1)
        )

INSERT  INTO dbo.tmgGroupAccess
        ( GroupGUID ,
          FormGUID ,
          AccessType ,
          EffDate ,
          DeletedFlag ,
          KeepDuringRollback
        )
        SELECT  DISTINCT
                ga.GroupGUID , -- GroupGUID - varchar(50)
                @pagename , -- FormGUID - varchar(50)
                ga.AccessType , -- AccessType - varchar(3)
                GETDATE() , -- EffDate - datetime
                'N' , -- DeletedFlag - varchar(1)
                'N'  -- KeepDuringRollback - varchar(1)
        FROM    dbo.tmgGroupAccess ga
		JOIN dbo.tmgGroup g
		ON ga.GroupGuid = g.GroupGuid
		WHERE FormGUID = 'fmgSolicitationAdministration_aspx'
		GROUP BY ga.GroupGUID, ga.AccessType