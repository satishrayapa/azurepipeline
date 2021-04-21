IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingERPAPIMovementHeader' and type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingERPAPIMovementHeader(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[movementGUID] varchar(50) NOT NULL
	,[recordOperation] nvarchar(255) NOT NULL
	,[recordStamp] nvarchar(255) NOT NULL
	,[systemCode] nvarchar(255) NOT NULL
	,[documentNumber] nvarchar(255) NOT NULL
	,[itemNumber] nvarchar(255) NOT NULL
	,[quantity] nvarchar(255) NOT NULL
	,[date] varchar(255) NOT NULL
	,[reference] nvarchar(255) NOT NULL
	,[batchNumber] nvarchar(255) NOT NULL
	,[idExternalSystem] nvarchar(255) NOT NULL
	,[externalSystemDate] varchar(255) NOT NULL
	,[insertionDate] varchar(255) NOT NULL
	,[transactionType] nvarchar(255) NOT NULL
	,[movementType] nvarchar(255) NOT NULL
	,[measureUnit] nvarchar(255) NOT NULL
	,[cost] nvarchar(255) NOT NULL
	,[currency] nvarchar(255) NOT NULL
	,[documentComplement] nvarchar(255) NOT NULL
	,[documentItemDescription] nvarchar(255) NOT NULL
	,[documentItemProcessDescription] nvarchar(255) NOT NULL
	,[flexField1] nvarchar(255) NOT NULL
	,[flexField2] nvarchar(255) NOT NULL
	,[flexField3] nvarchar(255) NOT NULL
	,[flexField4] nvarchar(255) NOT NULL
	,[flexField5] nvarchar(255) NOT NULL
	,[flexField6] nvarchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_tddStagingERPAPIMovementHeader] 
ON ttdStagingERPAPIMovementHeader 
(
	[PartnerId]
	,[MovementGUID]
)

ALTER TABLE dbo.ttdStagingERPAPIMovementHeader ADD CONSTRAINT [PK_ttdStagingERPAPIMovementHeader] PRIMARY KEY
(
	[PartnerId] ASC
	,[movementGUID] ASC
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingERPAPIMovementHeaderHist' AND type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingERPAPIMovementHeaderHist(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[movementGUID] varchar(50) NOT NULL
	,[recordOperation] nvarchar(255) NOT NULL
	,[recordStamp] nvarchar(255) NOT NULL
	,[systemCode] nvarchar(255) NOT NULL
	,[documentNumber] nvarchar(255) NOT NULL
	,[itemNumber] nvarchar(255) NOT NULL
	,[quantity] nvarchar(255) NOT NULL
	,[date] varchar(255) NOT NULL
	,[reference] nvarchar(255) NOT NULL
	,[batchNumber] nvarchar(255) NOT NULL
	,[idExternalSystem] nvarchar(255) NOT NULL
	,[externalSystemDate] varchar(255) NOT NULL
	,[insertionDate] varchar(255) NOT NULL
	,[transactionType] nvarchar(255) NOT NULL
	,[movementType] nvarchar(255) NOT NULL
	,[measureUnit] nvarchar(255) NOT NULL
	,[cost] nvarchar(255) NOT NULL
	,[currency] nvarchar(255) NOT NULL
	,[documentComplement] nvarchar(255) NOT NULL
	,[documentItemDescription] nvarchar(255) NOT NULL
	,[documentItemProcessDescription] nvarchar(255) NOT NULL
	,[flexField1] nvarchar(255) NOT NULL
	,[flexField2] nvarchar(255) NOT NULL
	,[flexField3] nvarchar(255) NOT NULL
	,[flexField4] nvarchar(255) NOT NULL
	,[flexField5] nvarchar(255) NOT NULL
	,[flexField6] nvarchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_tddStagingERPAPIMovementHeaderHist] 
ON ttdStagingERPAPIMovementHeaderHist 
(
	[PartnerId]
	,[MovementGUID]
)

ALTER TABLE dbo.ttdStagingERPAPIMovementHeaderHist ADD CONSTRAINT [PK_ttdStagingERPAPIMovementHeaderHist] PRIMARY KEY
(
	[PartnerId] ASC
	,[EffDate] ASC
	,[movementGUID] ASC
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingERPAPIMovementProduct' and type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingERPAPIMovementProduct(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[movementGUID] varchar(50) NOT NULL
	,[movementProductGUID] varchar(50) NOT NULL
	,[partNumber] nvarchar(255) NOT NULL
	,[flexField1] nvarchar(255) NOT NULL
	,[flexField2] nvarchar(255) NOT NULL
	,[flexField3] nvarchar(255) NOT NULL
	,[flexField4] nvarchar(255) NOT NULL
	,[flexField5] nvarchar(255) NOT NULL
	,[flexField6] nvarchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingERPAPIMovementProduct] 
ON ttdStagingERPAPIMovementProduct 
(
	[PartnerId]
	,[movementGUID]
	,[movementProductGUID]
)

ALTER TABLE dbo.ttdStagingERPAPIMovementProduct ADD CONSTRAINT [PK_ttdStagingERPAPIMovementProduct] PRIMARY KEY
(
	[PartnerId] ASC
	,[movementGUID] ASC
	,[movementProductGUID] ASC
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingERPAPIMovementProductHist' AND type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingERPAPIMovementProductHist(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[movementGUID] varchar(50) NOT NULL
	,[movementProductGUID] varchar(50) NOT NULL
	,[partNumber] nvarchar(255) NOT NULL
	,[flexField1] nvarchar(255) NOT NULL
	,[flexField2] nvarchar(255) NOT NULL
	,[flexField3] nvarchar(255) NOT NULL
	,[flexField4] nvarchar(255) NOT NULL
	,[flexField5] nvarchar(255) NOT NULL
	,[flexField6] nvarchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingERPAPIMovementProductHist] 
ON ttdStagingERPAPIMovementProductHist
(
	[PartnerId]
	,[movementGUID]
	,[movementProductGUID]
)

ALTER TABLE dbo.ttdStagingERPAPIMovementProductHist ADD CONSTRAINT [PK_ttdStagingERPAPIMovementProductHist] PRIMARY KEY
(
	[PartnerId] ASC
	,[EffDate] ASC
	,[movementGUID] ASC
	,[movementProductGUID] ASC
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingERPAPIMovementProductOrganization' and type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingERPAPIMovementProductOrganization(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[movementProductGUID] varchar(50) NOT NULL
	,[movementProdOrgGUID] varchar(50) NOT NULL
	,[organizationCode] nvarchar(255) NOT NULL
	,[organizationTypeCode] nvarchar(255) NOT NULL
	,[flexField1] nvarchar(255) NOT NULL
	,[flexField2] nvarchar(255) NOT NULL
	,[flexField3] nvarchar(255) NOT NULL
	,[flexField4] nvarchar(255) NOT NULL
	,[flexField5] nvarchar(255) NOT NULL
	,[flexField6] nvarchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingERPAPIMovementProductOrganization] 
ON ttdStagingERPAPIMovementProductOrganization
(
	[PartnerId]
	,[movementProductGUID]
	,[movementProdOrgGUID]
)

ALTER TABLE dbo.ttdStagingERPAPIMovementProductOrganization ADD CONSTRAINT [PK_ttdStagingERPAPIMovementProductOrganization] PRIMARY KEY
(
	[PartnerId] ASC
	,[movementProductGUID] ASC
	,[movementProdOrgGUID] ASC
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingERPAPIMovementProductOrganizationHist' AND type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingERPAPIMovementProductOrganizationHist(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[movementProductGUID] varchar(50) NOT NULL
	,[movementProdOrgGUID] varchar(50) NOT NULL
	,[organizationCode] nvarchar(255) NOT NULL
	,[organizationTypeCode] nvarchar(255) NOT NULL
	,[flexField1] nvarchar(255) NOT NULL
	,[flexField2] nvarchar(255) NOT NULL
	,[flexField3] nvarchar(255) NOT NULL
	,[flexField4] nvarchar(255) NOT NULL
	,[flexField5] nvarchar(255) NOT NULL
	,[flexField6] nvarchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingERPAPIMovementProductOrganizationHist] 
ON ttdStagingERPAPIMovementProductOrganizationHist
(
	[PartnerId]
	,[movementProductGUID]
	,[movementProdOrgGUID]
)

ALTER TABLE dbo.ttdStagingERPAPIMovementProductOrganizationHist ADD CONSTRAINT [PK_ttdStagingERPAPIMovementProductOrganizationHist] PRIMARY KEY
(
	[PartnerId] ASC
	,[EffDate] ASC
	,[movementProductGUID] ASC
	,[movementProdOrgGUID] ASC
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingERPAPIMovementWarehouse' and type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingERPAPIMovementWarehouse(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[movementGUID] varchar(50) NOT NULL
	,[movementWarehouseGUID] varchar(50) NOT NULL
	,[warehouseCode] nvarchar(255) NOT NULL
	,[flexField1] nvarchar(255) NOT NULL
	,[flexField2] nvarchar(255) NOT NULL
	,[flexField3] nvarchar(255) NOT NULL
	,[flexField4] nvarchar(255) NOT NULL
	,[flexField5] nvarchar(255) NOT NULL
	,[flexField6] nvarchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingERPAPIMovementWarehouse] 
ON ttdStagingERPAPIMovementWarehouse
(
	[PartnerId]
	,[movementGUID]
	,[movementWarehouseGUID]
)

ALTER TABLE dbo.ttdStagingERPAPIMovementWarehouse ADD CONSTRAINT [PK_ttdStagingERPAPIMovementWarehouse] PRIMARY KEY
(
	[PartnerId] ASC
	,[movementGUID] ASC
	,[movementWarehouseGUID] ASC
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingERPAPIMovementWarehouseHist' AND type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingERPAPIMovementWarehouseHist(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[movementGUID] varchar(50) NOT NULL
	,[movementWarehouseGUID] varchar(50) NOT NULL
	,[warehouseCode] nvarchar(255) NOT NULL
	,[flexField1] nvarchar(255) NOT NULL
	,[flexField2] nvarchar(255) NOT NULL
	,[flexField3] nvarchar(255) NOT NULL
	,[flexField4] nvarchar(255) NOT NULL
	,[flexField5] nvarchar(255) NOT NULL
	,[flexField6] nvarchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingERPAPIMovementWarehouseHist] 
ON ttdStagingERPAPIMovementWarehouseHist
(
	[PartnerId]
	,[movementGUID]
	,[movementWarehouseGUID]
)

ALTER TABLE dbo.ttdStagingERPAPIMovementWarehouseHist ADD CONSTRAINT [PK_ttdStagingERPAPIMovementWarehouseHist] PRIMARY KEY
(
	[PartnerId] ASC
	,[EffDate] ASC
	,[movementGUID] ASC
	,[movementWarehouseGUID] ASC
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingERPAPIMovementWarehouseOrg' and type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingERPAPIMovementWarehouseOrg(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[movementWarehouseGUID] varchar(50) NOT NULL
	,[movementWarehouseOrgGUID] varchar(50) NOT NULL
	,[organizationCode] nvarchar(255) NOT NULL
	,[organizationTypeCode] nvarchar(255) NOT NULL
	,[flexField1] nvarchar(255) NOT NULL
	,[flexField2] nvarchar(255) NOT NULL
	,[flexField3] nvarchar(255) NOT NULL
	,[flexField4] nvarchar(255) NOT NULL
	,[flexField5] nvarchar(255) NOT NULL
	,[flexField6] nvarchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingERPAPIMovementWarehouseOrg] 
ON ttdStagingERPAPIMovementWarehouseOrg
(
	[PartnerId]
	,[movementWarehouseGUID]
	,[movementWarehouseOrgGUID]
)

ALTER TABLE dbo.ttdStagingERPAPIMovementWarehouseOrg ADD CONSTRAINT [PK_ttdStagingERPAPIMovementWarehouseOrg] PRIMARY KEY
(
	[PartnerId] ASC
	,[movementWarehouseGUID] ASC
	,[movementWarehouseOrgGUID] ASC
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingERPAPIMovementWarehouseOrgHist' AND type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingERPAPIMovementWarehouseOrgHist(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[movementWarehouseGUID] varchar(50) NOT NULL
	,[movementWarehouseOrgGUID] varchar(50) NOT NULL
	,[organizationCode] nvarchar(255) NOT NULL
	,[organizationTypeCode] nvarchar(255) NOT NULL
	,[flexField1] nvarchar(255) NOT NULL
	,[flexField2] nvarchar(255) NOT NULL
	,[flexField3] nvarchar(255) NOT NULL
	,[flexField4] nvarchar(255) NOT NULL
	,[flexField5] nvarchar(255) NOT NULL
	,[flexField6] nvarchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingERPAPIMovementWarehouseOrgHist] 
ON ttdStagingERPAPIMovementWarehouseOrgHist
(
	[PartnerId]
	,[movementWarehouseGUID]
	,[movementWarehouseOrgGUID]
)

ALTER TABLE dbo.ttdStagingERPAPIMovementWarehouseOrgHist ADD CONSTRAINT [PK_ttdStagingERPAPIMovementWarehouseOrgHist] PRIMARY KEY
(
	[PartnerId] ASC
	,[EffDate] ASC
	,[movementWarehouseGUID] ASC
	,[movementWarehouseOrgGUID] ASC
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingERPAPIMovementProdOrd' and type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingERPAPIMovementProdOrd(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[movementGUID] varchar(50) NOT NULL
	,[movementProdOrderGUID] varchar(50) NOT NULL
	,[recordOperation] nvarchar(255) NOT NULL
	,[orderNumber] nvarchar(255) NOT NULL
	,[orderType] nvarchar(255) NOT NULL
	,[orderReferenceDate] varchar(255) NOT NULL
	,[orderDate] varchar(255) NOT NULL
	,[orderConclusionDate] varchar(255) NOT NULL
	,[orderVersion] nvarchar(255) NOT NULL
	,[orderReferenceTarget] nvarchar(255) NOT NULL
	,[flexField1] nvarchar(255) NOT NULL
	,[flexField2] nvarchar(255) NOT NULL
	,[flexField3] nvarchar(255) NOT NULL
	,[flexField4] nvarchar(255) NOT NULL
	,[flexField5] nvarchar(255) NOT NULL
	,[flexField6] nvarchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingERPAPIMovementProdOrd] 
ON ttdStagingERPAPIMovementProdOrd
(
	[PartnerId]
	,[movementGUID]
	,[movementProdOrderGUID]
)

ALTER TABLE dbo.ttdStagingERPAPIMovementProdOrd ADD CONSTRAINT [PK_ttdStagingERPAPIMovementProdOrd] PRIMARY KEY
(
	[PartnerId] ASC
	,[movementGUID] ASC
	,[movementProdOrderGUID] ASC
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingERPAPIMovementProdOrdHist' AND type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingERPAPIMovementProdOrdHist(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[movementGUID] varchar(50) NOT NULL
	,[movementProdOrderGUID] varchar(50) NOT NULL
	,[recordOperation] nvarchar(255) NOT NULL
	,[orderNumber] nvarchar(255) NOT NULL
	,[orderType] nvarchar(255) NOT NULL
	,[orderReferenceDate] varchar(255) NOT NULL
	,[orderDate] varchar(255) NOT NULL
	,[orderConclusionDate] varchar(255) NOT NULL
	,[orderVersion] nvarchar(255) NOT NULL
	,[orderReferenceTarget] nvarchar(255) NOT NULL
	,[flexField1] nvarchar(255) NOT NULL
	,[flexField2] nvarchar(255) NOT NULL
	,[flexField3] nvarchar(255) NOT NULL
	,[flexField4] nvarchar(255) NOT NULL
	,[flexField5] nvarchar(255) NOT NULL
	,[flexField6] nvarchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingERPAPIMovementProdOrdHist] 
ON ttdStagingERPAPIMovementProdOrdHist
(
	[PartnerId]
	,[movementGUID]
	,[movementProdOrderGUID]
)

ALTER TABLE dbo.ttdStagingERPAPIMovementProdOrdHist ADD CONSTRAINT [PK_ttdStagingERPAPIMovementProdOrdHist] PRIMARY KEY
(
	[PartnerId] ASC
	,[EffDate] ASC
	,[movementGUID]
	,[movementProdOrderGUID] ASC
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingERPAPIMovementProdOrdOrg' and type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingERPAPIMovementProdOrdOrg(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[movementProdOrderGUID] varchar(50) NOT NULL
	,[movementProdOrdOrgGUID] varchar(50) NOT NULL
	,[organizationCode] nvarchar(255) NOT NULL
	,[organizationTypeCode] nvarchar(255) NOT NULL
	,[flexField1] nvarchar(255) NOT NULL
	,[flexField2] nvarchar(255) NOT NULL
	,[flexField3] nvarchar(255) NOT NULL
	,[flexField4] nvarchar(255) NOT NULL
	,[flexField5] nvarchar(255) NOT NULL
	,[flexField6] nvarchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingERPAPIMovementProdOrdOrg] 
ON ttdStagingERPAPIMovementProdOrdOrg
(
	[PartnerId]
	,[movementProdOrderGUID]
	,[movementProdOrdOrgGUID]
)

ALTER TABLE dbo.ttdStagingERPAPIMovementProdOrdOrg ADD CONSTRAINT [PK_ttdStagingERPAPIMovementProdOrdOrg] PRIMARY KEY
(
	[PartnerId] ASC
	,[movementProdOrderGUID] ASC
	,[movementProdOrdOrgGUID] ASC
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingERPAPIMovementProdOrdOrgHist' AND type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingERPAPIMovementProdOrdOrgHist(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[movementProdOrderGUID] varchar(50) NOT NULL
	,[movementProdOrdOrgGUID] varchar(50) NOT NULL
	,[organizationCode] nvarchar(255) NOT NULL
	,[organizationTypeCode] nvarchar(255) NOT NULL
	,[flexField1] nvarchar(255) NOT NULL
	,[flexField2] nvarchar(255) NOT NULL
	,[flexField3] nvarchar(255) NOT NULL
	,[flexField4] nvarchar(255) NOT NULL
	,[flexField5] nvarchar(255) NOT NULL
	,[flexField6] nvarchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingERPAPIMovementProdOrdOrgHist] 
ON ttdStagingERPAPIMovementProdOrdOrgHist
(
	[PartnerId]
	,[movementProdOrderGUID]
	,[movementProdOrdOrgGUID]
)

ALTER TABLE dbo.ttdStagingERPAPIMovementProdOrdOrgHist ADD CONSTRAINT [PK_ttdStagingERPAPIMovementProdOrdOrgHist] PRIMARY KEY
(
	[PartnerId] ASC
	,[EffDate] ASC
	,[movementProdOrderGUID] ASC
	,[movementProdOrdOrgGUID] ASC
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingERPAPIMovementProdOrdStruct' and type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingERPAPIMovementProdOrdStruct(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[movementGUID] varchar(50) NOT NULL
	,[movementProdOrdStructGUID] varchar(50) NOT NULL
	,[recordOperation] nvarchar(255) NOT NULL
	,[orderNumber] nvarchar(255) NOT NULL
	,[coeficientInterface] nvarchar(255) NOT NULL
	,[lossValueType] nvarchar(255) NOT NULL
	,[lossValue] nvarchar(255) NOT NULL
	,[flexField1] nvarchar(255) NOT NULL
	,[flexField2] nvarchar(255) NOT NULL
	,[flexField3] nvarchar(255) NOT NULL
	,[flexField4] nvarchar(255) NOT NULL
	,[flexField5] nvarchar(255) NOT NULL
	,[flexField6] nvarchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingERPAPIMovementProdOrdStruct] 
ON ttdStagingERPAPIMovementProdOrdStruct
(
	[PartnerId]
	,[movementGUID]
	,[movementProdOrdStructGUID]
)

ALTER TABLE dbo.ttdStagingERPAPIMovementProdOrdStruct ADD CONSTRAINT [PK_ttdStagingERPAPIMovementProdOrdStruct] PRIMARY KEY
(
	[PartnerId] ASC
	,[movementGUID] ASC
	,[movementProdOrdStructGUID] ASC
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingERPAPIMovementProdOrdStructHist' AND type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingERPAPIMovementProdOrdStructHist(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[movementGUID] varchar(50) NOT NULL
	,[movementProdOrdStructGUID] varchar(50) NOT NULL
	,[recordOperation] nvarchar(255) NOT NULL
	,[orderNumber] nvarchar(255) NOT NULL
	,[coeficientInterface] nvarchar(255) NOT NULL
	,[lossValueType] nvarchar(255) NOT NULL
	,[lossValue] nvarchar(255) NOT NULL
	,[flexField1] nvarchar(255) NOT NULL
	,[flexField2] nvarchar(255) NOT NULL
	,[flexField3] nvarchar(255) NOT NULL
	,[flexField4] nvarchar(255) NOT NULL
	,[flexField5] nvarchar(255) NOT NULL
	,[flexField6] nvarchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingERPAPIMovementProdOrdStructHist] 
ON ttdStagingERPAPIMovementProdOrdStructHist
(
	[PartnerId]
	,[movementGUID]
	,[movementProdOrdStructGUID]
)

ALTER TABLE dbo.ttdStagingERPAPIMovementProdOrdStructHist ADD CONSTRAINT [PK_ttdStagingERPAPIMovementProdOrdStructHist] PRIMARY KEY
(
	[PartnerId] ASC
	,[EffDate] ASC
	,[movementGUID] ASC
	,[movementProdOrdStructGUID] ASC
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingERPAPIMovementProdOrdStructOrg' and type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingERPAPIMovementProdOrdStructOrg(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[movementProdOrdStructGUID] varchar(50) NOT NULL
	,[movementProdOrdStructOrgGUID] varchar(50) NOT NULL
	,[organizationCode] nvarchar(255) NOT NULL
	,[organizationTypeCode] nvarchar(255) NOT NULL
	,[flexField1] nvarchar(255) NOT NULL
	,[flexField2] nvarchar(255) NOT NULL
	,[flexField3] nvarchar(255) NOT NULL
	,[flexField4] nvarchar(255) NOT NULL
	,[flexField5] nvarchar(255) NOT NULL
	,[flexField6] nvarchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingERPAPIMovementProdOrdStructOrg] 
ON ttdStagingERPAPIMovementProdOrdStructOrg
(
	[PartnerId]
	,[movementProdOrdStructGUID]
	,[movementProdOrdStructOrgGUID]
)

ALTER TABLE dbo.ttdStagingERPAPIMovementProdOrdStructOrg ADD CONSTRAINT [PK_ttdStagingERPAPIMovementProdOrdStructOrg] PRIMARY KEY
(
	[PartnerId] ASC
	,[movementProdOrdStructGUID] ASC
	,[movementProdOrdStructOrgGUID] ASC
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingERPAPIMovementProdOrdStructOrgHist' AND type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingERPAPIMovementProdOrdStructOrgHist(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[movementProdOrdStructGUID] varchar(50) NOT NULL
	,[movementProdOrdStructOrgGUID] varchar(50) NOT NULL
	,[organizationCode] nvarchar(255) NOT NULL
	,[organizationTypeCode] nvarchar(255) NOT NULL
	,[flexField1] nvarchar(255) NOT NULL
	,[flexField2] nvarchar(255) NOT NULL
	,[flexField3] nvarchar(255) NOT NULL
	,[flexField4] nvarchar(255) NOT NULL
	,[flexField5] nvarchar(255) NOT NULL
	,[flexField6] nvarchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingERPAPIMovementProdOrdStructOrgHist] 
ON ttdStagingERPAPIMovementProdOrdStructOrgHist
(
	[PartnerId]
	,[movementProdOrdStructGUID]
	,[movementProdOrdStructOrgGUID]
)

ALTER TABLE dbo.ttdStagingERPAPIMovementProdOrdStructOrgHist ADD CONSTRAINT [PK_ttdStagingERPAPIMovementProdOrdStructOrgHist] PRIMARY KEY
(
	[PartnerId] ASC
	,[EffDate] ASC
	,[movementProdOrdStructGUID] ASC
	,[movementProdOrdStructOrgGUID] ASC
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingERPAPIMovementProdOrdStructAltProd' and type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingERPAPIMovementProdOrdStructAltProd(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[movementProdOrdStructGUID] varchar(50) NOT NULL
	,[movementProdOrdStructAltProdGUID] varchar(50) NOT NULL
	,[partNumber] nvarchar(255) NOT NULL
	,[flexField1] nvarchar(255) NOT NULL
	,[flexField2] nvarchar(255) NOT NULL
	,[flexField3] nvarchar(255) NOT NULL
	,[flexField4] nvarchar(255) NOT NULL
	,[flexField5] nvarchar(255) NOT NULL
	,[flexField6] nvarchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingERPAPIMovementProdOrdStructAltProd] 
ON ttdStagingERPAPIMovementProdOrdStructAltProd
(
	[PartnerId]
	,[movementProdOrdStructGUID]
	,[movementProdOrdStructAltProdGUID]
)

ALTER TABLE dbo.ttdStagingERPAPIMovementProdOrdStructAltProd ADD CONSTRAINT [PK_ttdStagingERPAPIMovementProdOrdStructAltProd] PRIMARY KEY
(
	[PartnerId] ASC
	,[movementProdOrdStructGUID] ASC
	,[movementProdOrdStructAltProdGUID] ASC
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingERPAPIMovementProdOrdStructAltProdHist' AND type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingERPAPIMovementProdOrdStructAltProdHist(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[movementProdOrdStructGUID] varchar(50) NOT NULL
	,[movementProdOrdStructAltProdGUID] varchar(50) NOT NULL
	,[partNumber] nvarchar(255) NOT NULL
	,[flexField1] nvarchar(255) NOT NULL
	,[flexField2] nvarchar(255) NOT NULL
	,[flexField3] nvarchar(255) NOT NULL
	,[flexField4] nvarchar(255) NOT NULL
	,[flexField5] nvarchar(255) NOT NULL
	,[flexField6] nvarchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX [IX_ttdStagingERPAPIMovementProdOrdStructAltProdHist] 
ON ttdStagingERPAPIMovementProdOrdStructAltProdHist
(
	[PartnerId]
	,[movementProdOrdStructGUID]
	,[movementProdOrdStructAltProdGUID]
)

ALTER TABLE dbo.ttdStagingERPAPIMovementProdOrdStructAltProdHist ADD CONSTRAINT [PK_ttdStagingERPAPIMovementProdOrdStructAltProdHist] PRIMARY KEY
(
	[PartnerId] ASC
	,[EffDate] ASC
	,[movementProdOrdStructGUID] ASC
	,[movementProdOrdStructAltProdGUID] ASC
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingERPAPIMovementProdOrdStructAltProdOrg' and type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingERPAPIMovementProdOrdStructAltProdOrg(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[movementProdOrdStructAltProdGUID] varchar(50) NOT NULL
	,[movementProdOrdStructAltProdOrgGUID] varchar(50) NOT NULL
	,[organizationCode] nvarchar(255) NOT NULL
	,[organizationTypeCode] nvarchar(255) NOT NULL
	,[flexField1] nvarchar(255) NOT NULL
	,[flexField2] nvarchar(255) NOT NULL
	,[flexField3] nvarchar(255) NOT NULL
	,[flexField4] nvarchar(255) NOT NULL
	,[flexField5] nvarchar(255) NOT NULL
	,[flexField6] nvarchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX ttdStagingERPAPIMovementProdOrdStructAltProdOrg 
ON ttdStagingERPAPIMovementProdOrdStructAltProdOrg
(
	[PartnerId]
	,[movementProdOrdStructAltProdGUID]
	,[movementProdOrdStructAltProdOrgGUID]
)

ALTER TABLE dbo.ttdStagingERPAPIMovementProdOrdStructAltProdOrg ADD CONSTRAINT [PK_ttdStagingERPAPIMovementProdOrdStructAltProdOrg] PRIMARY KEY
(
	[PartnerId] ASC
	,[movementProdOrdStructAltProdGUID]
	,[movementProdOrdStructAltProdOrgGUID] ASC
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingERPAPIMovementProdOrdStructAltProdOrgHist' AND type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingERPAPIMovementProdOrdStructAltProdOrgHist(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[movementProdOrdStructAltProdGUID] varchar(50) NOT NULL
	,[movementProdOrdStructAltProdOrgGUID] varchar(50) NOT NULL
	,[organizationCode] nvarchar(255) NOT NULL
	,[organizationTypeCode] nvarchar(255) NOT NULL
	,[flexField1] nvarchar(255) NOT NULL
	,[flexField2] nvarchar(255) NOT NULL
	,[flexField3] nvarchar(255) NOT NULL
	,[flexField4] nvarchar(255) NOT NULL
	,[flexField5] nvarchar(255) NOT NULL
	,[flexField6] nvarchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX ttdStagingERPAPIMovementProdOrdStructAltProdOrgHist
ON ttdStagingERPAPIMovementProdOrdStructAltProdOrgHist
(
	[PartnerId]
	,[movementProdOrdStructAltProdGUID]
	,[movementProdOrdStructAltProdOrgGUID]
)

ALTER TABLE dbo.ttdStagingERPAPIMovementProdOrdStructAltProdOrgHist ADD CONSTRAINT [PK_ttdStagingERPAPIMovementProdOrdStructAltProdOrgHist] PRIMARY KEY
(
	[PartnerId] ASC
	,[EffDate] ASC
	,[movementProdOrdStructAltProdGUID] ASC
	,[movementProdOrdStructAltProdOrgGUID] ASC
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingERPAPIMovementDocItemHS' and type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingERPAPIMovementDocItemHS(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[movementGUID] varchar(50) NOT NULL
	,[movementDocItemHSGUID] varchar(50) NOT NULL
	,[code] nvarchar(255) NOT NULL
	,[name] nvarchar(255) NOT NULL
	,[version] nvarchar(255) NOT NULL
	,[flexField1] nvarchar(255) NOT NULL
	,[flexField2] nvarchar(255) NOT NULL
	,[flexField3] nvarchar(255) NOT NULL
	,[flexField4] nvarchar(255) NOT NULL
	,[flexField5] nvarchar(255) NOT NULL
	,[flexField6] nvarchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX IX_ttdStagingERPAPIMovementDocItemHS
ON ttdStagingERPAPIMovementDocItemHS
(
	[PartnerId]
	,[movementGUID]
	,[movementDocItemHSGUID]
)

ALTER TABLE dbo.ttdStagingERPAPIMovementDocItemHS ADD CONSTRAINT [PK_ttdStagingERPAPIMovementDocItemHS] PRIMARY KEY
(
	[PartnerId] ASC
	,[movementGUID] ASC
	,[movementDocItemHSGUID] ASC
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingERPAPIMovementDocItemHSHist' AND type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingERPAPIMovementDocItemHSHist(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[movementGUID] varchar(50) NOT NULL
	,[movementDocItemHSGUID] varchar(50) NOT NULL
	,[code] nvarchar(255) NOT NULL
	,[name] nvarchar(255) NOT NULL
	,[version] nvarchar(255) NOT NULL
	,[flexField1] nvarchar(255) NOT NULL
	,[flexField2] nvarchar(255) NOT NULL
	,[flexField3] nvarchar(255) NOT NULL
	,[flexField4] nvarchar(255) NOT NULL
	,[flexField5] nvarchar(255) NOT NULL
	,[flexField6] nvarchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX IX_ttdStagingERPAPIMovementDocItemHSHist
ON ttdStagingERPAPIMovementDocItemHSHist
(
	[PartnerId]
	,[movementGUID]
	,[movementDocItemHSGUID]
)

ALTER TABLE dbo.ttdStagingERPAPIMovementDocItemHSHist ADD CONSTRAINT [PK_ttdStagingERPAPIMovementDocItemHSHist] PRIMARY KEY
(
	[PartnerId] ASC
	,[EffDate] ASC
	,[movementGUID]
	,[movementDocItemHSGUID] ASC
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingERPAPIMovementDocItemHSType' and type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingERPAPIMovementDocItemHSType(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[movementDocItemHSGUID] varchar(50) NOT NULL
	,[movementDocItemHSTypeGUID] varchar(50) NOT NULL
	,[name] nvarchar(255) NOT NULL
	,[version] nvarchar(255) NOT NULL
	,[flexField1] nvarchar(255) NOT NULL
	,[flexField2] nvarchar(255) NOT NULL
	,[flexField3] nvarchar(255) NOT NULL
	,[flexField4] nvarchar(255) NOT NULL
	,[flexField5] nvarchar(255) NOT NULL
	,[flexField6] nvarchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX IX_ttdStagingERPAPIMovementDocItemHSType
ON ttdStagingERPAPIMovementDocItemHSType
(
	[PartnerId]
	,[movementDocItemHSGUID]
	,[movementDocItemHSTypeGUID]
)

ALTER TABLE dbo.ttdStagingERPAPIMovementDocItemHSType ADD CONSTRAINT [PK_ttdStagingERPAPIMovementDocItemHSType] PRIMARY KEY
(
	[PartnerId] ASC
	,[movementDocItemHSGUID] ASC
	,[movementDocItemHSTypeGUID] ASC
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingERPAPIMovementDocItemHSTypeHist' AND type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingERPAPIMovementDocItemHSTypeHist(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[movementDocItemHSGUID] varchar(50) NOT NULL
	,[movementDocItemHSTypeGUID] varchar(50) NOT NULL
	,[name] nvarchar(255) NOT NULL
	,[version] nvarchar(255) NOT NULL
	,[flexField1] nvarchar(255) NOT NULL
	,[flexField2] nvarchar(255) NOT NULL
	,[flexField3] nvarchar(255) NOT NULL
	,[flexField4] nvarchar(255) NOT NULL
	,[flexField5] nvarchar(255) NOT NULL
	,[flexField6] nvarchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX IX_ttdStagingERPAPIMovementDocItemHSTypeHist
ON ttdStagingERPAPIMovementDocItemHSTypeHist
(
	[PartnerId]
	,[movementDocItemHSGUID]
	,[movementDocItemHSTypeGUID]
)

ALTER TABLE dbo.ttdStagingERPAPIMovementDocItemHSTypeHist ADD CONSTRAINT [PK_ttdStagingERPAPIMovementDocItemHSTypeHist] PRIMARY KEY
(
	[PartnerId] ASC
	,[EffDate] ASC
	,[movementDocItemHSGUID] ASC
	,[movementDocItemHSTypeGUID] ASC
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingERPAPIMovementDocSenderPartner' and type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingERPAPIMovementDocSenderPartner(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[movementGUID] varchar(50) NOT NULL
	,[movementDocSenderPartnerGUID] varchar(50) NOT NULL
	,[partnerCode] nvarchar(255) NOT NULL
	,[partnerSubCode] nvarchar(255) NOT NULL
	,[flexField1] nvarchar(255) NOT NULL
	,[flexField2] nvarchar(255) NOT NULL
	,[flexField3] nvarchar(255) NOT NULL
	,[flexField4] nvarchar(255) NOT NULL
	,[flexField5] nvarchar(255) NOT NULL
	,[flexField6] nvarchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX IX_ttdStagingERPAPIMovementDocSenderPartner
ON ttdStagingERPAPIMovementDocSenderPartner
(
	[PartnerId]
	,[movementGUID]
	,[movementDocSenderPartnerGUID]
)

ALTER TABLE dbo.ttdStagingERPAPIMovementDocSenderPartner ADD CONSTRAINT [PK_ttdStagingERPAPIMovementDocSenderPartner] PRIMARY KEY
(
	[PartnerId] ASC
	,[movementGUID] ASC
	,[movementDocSenderPartnerGUID] ASC
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingERPAPIMovementDocSenderPartnerHist' AND type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingERPAPIMovementDocSenderPartnerHist(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[movementGUID] varchar(50) NOT NULL
	,[movementDocSenderPartnerGUID] varchar(50) NOT NULL
	,[partnerCode] nvarchar(255) NOT NULL
	,[partnerSubCode] nvarchar(255) NOT NULL
	,[flexField1] nvarchar(255) NOT NULL
	,[flexField2] nvarchar(255) NOT NULL
	,[flexField3] nvarchar(255) NOT NULL
	,[flexField4] nvarchar(255) NOT NULL
	,[flexField5] nvarchar(255) NOT NULL
	,[flexField6] nvarchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX IX_ttdStagingERPAPIMovementDocSenderPartnerHist
ON ttdStagingERPAPIMovementDocSenderPartnerHist
(
	[PartnerId]
	,[movementGUID]
	,[movementDocSenderPartnerGUID]
)

ALTER TABLE dbo.ttdStagingERPAPIMovementDocSenderPartnerHist ADD CONSTRAINT [PK_ttdStagingERPAPIMovementDocSenderPartnerHist] PRIMARY KEY
(
	[PartnerId] ASC
	,[EffDate] ASC
	,[movementGUID] ASC
	,[movementDocSenderPartnerGUID] ASC
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingERPAPIMovementDocRecipientPartner' and type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingERPAPIMovementDocRecipientPartner(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[movementGUID] varchar(50) NOT NULL
	,[movementDocRecipientPartnerGUID] varchar(50) NOT NULL
	,[partnerCode] nvarchar(255) NOT NULL
	,[partnerSubCode] nvarchar(255) NOT NULL
	,[flexField1] nvarchar(255) NOT NULL
	,[flexField2] nvarchar(255) NOT NULL
	,[flexField3] nvarchar(255) NOT NULL
	,[flexField4] nvarchar(255) NOT NULL
	,[flexField5] nvarchar(255) NOT NULL
	,[flexField6] nvarchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX IX_ttdStagingERPAPIMovementDocRecipientPartner
ON ttdStagingERPAPIMovementDocRecipientPartner
(
	[PartnerId]
	,[movementGUID]
	,[movementDocRecipientPartnerGUID]
)

ALTER TABLE dbo.ttdStagingERPAPIMovementDocRecipientPartner ADD CONSTRAINT [PK_ttdStagingERPAPIMovementDocRecipientPartner] PRIMARY KEY
(
	[PartnerId] ASC
	,[movementGUID] ASC
	,[movementDocRecipientPartnerGUID] ASC
)
END
GO

IF EXISTS (SELECT * FROM SYS.TABLES WHERE NAME = 'ttdStagingERPAPIMovementDocRecipientPartnerHist' AND type = 'U')
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
CREATE TABLE dbo.ttdStagingERPAPIMovementDocRecipientPartnerHist(
	[PartnerId] INT NOT NULL
	,[EffDate] datetime NOT NULL
	,[movementGUID] varchar(50) NOT NULL
	,[movementDocRecipientPartnerGUID] varchar(50) NOT NULL
	,[partnerCode] nvarchar(255) NOT NULL
	,[partnerSubCode] nvarchar(255) NOT NULL
	,[flexField1] nvarchar(255) NOT NULL
	,[flexField2] nvarchar(255) NOT NULL
	,[flexField3] nvarchar(255) NOT NULL
	,[flexField4] nvarchar(255) NOT NULL
	,[flexField5] nvarchar(255) NOT NULL
	,[flexField6] nvarchar(255) NOT NULL
	,[KeepDuringRollback] varchar(1) NOT NULL
	,[DeletedFlag] varchar(1) NOT NULL
	

) ON [PRIMARY]

CREATE NONCLUSTERED INDEX IX_ttdStagingERPAPIMovementDocRecipientPartnerHist
ON ttdStagingERPAPIMovementDocRecipientPartnerHist
(
	[PartnerId]
	,[movementGUID]
	,[movementDocRecipientPartnerGUID]
)

ALTER TABLE dbo.ttdStagingERPAPIMovementDocRecipientPartnerHist ADD CONSTRAINT [PK_ttdStagingERPAPIMovementDocRecipientPartnerHist] PRIMARY KEY
(
	[PartnerId] ASC
	,[EffDate] ASC
	,[movementGUID] ASC
	,[movementDocRecipientPartnerGUID] ASC
)
END
GO