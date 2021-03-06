declare @baselinePartner as int = 3000

-------------------boiler plate tests to determine if this is for baseline, do not change-----------------------
declare @isBaseline as bit = 0
declare @isBaselineTemp as varchar(30) = '${isBaseline}' --flyway will pass in for AWS when creating a new partner database

if not @isBaselineTemp = '$' + '{isBaseline}' and not @isBaselineTemp = '0' --either flyway passes 1 or we fallback to on-prem way of looking for 3000
	set @isBaseline = @isBaselineTemp
else
begin
	--on-prem we create new partners from 3000 so lets check for that

    --if there is only one defaults record and it is for 3000
    if exists (select TOP 1 1 from sys.tables where Name = 'tmfDefaults' AND Type = 'U') 
            exec sp_executesql N'select @isBaseline = count(*) from tmfDefaults where partnerID = @base and not exists (select top 1 1 from tmfDefaults where partnerID <> @base)', 
                    N'@isBaseline int output, @base int', @isBaseline output, @base = @baselinePartner;
       
    --based on db_name (ie IP_3000 or IP_3000_REG)
    if @isBaseline = 0
            select @isBaseline = case when DB_NAME() like '%[_]' + cast(@baselinePartner as varchar(10)) or DB_NAME() like '%[_]'+ cast(@baselinePartner as varchar(10)) +'[_]%' then 1 else 0 end
       
    --if there is only one security record and it is for 3000
    if @isBaseline = 0 and exists (select TOP 1 1 from sys.tables where Name = 'tmgPartnerDataConnection' AND Type = 'U') 
            exec sp_executesql N'select @isBaseline = count(*) from tmgPartnerDataConnection where partnerID = @base and not exists (select top 1 1 from tmgPartnerDataConnection where partnerID <> @base)', 
                    N'@isBaseline int output, @base int', @isBaseline output, @base = @baselinePartner;
end
-------------------boiler plate tests to determine if this is for baseline, do not change-----------------------


IF @isBaseline = 1
BEGIN
IF EXISTS (select * from dbo.sysobjects where id = object_id(N'[dbo].[tmgglobalcodesheader]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN  
	IF Object_ID('tempdb..#tmgglobalcodesheader') IS NOT NULL DROP TABLE #tmgglobalcodesheader
	Select * into #tmgglobalcodesheader from dbo.tmgglobalcodesheader where 1 = 2
	INSERT INTO #tmgglobalcodesheader(PARTNERID, EFFDATE, MODULE, GLOBALCODEDESCRIPTION, GLOBALCODEFIELDNAME, STANDARD, DELETEDFLAG, KEEPDURINGROLLBACK) 
	VALUES ('3000',GETDATE(),'DPS','DPS Company Screening Status Override Options used to classify the reason a company status was overriden','OverRideReasonCode','Y','N','N'),
					   ('3000',GETDATE(),'Export','Codes used for Transportation Companies involved on an Export or Import shipment','CARRIERID','Y','N','N'),
					   ('3000',GETDATE(),'Export','Weight Units of Measure','WeightUom','Y','N','N'),
					   ('3000',GETDATE(),'Export','Transaction Quantity Units of Measure','TxnQtyUom','Y','N','N'),
					   ('3000',GETDATE(),'Export','Shipment Container Type used to categorize an Equipment on Export and Import documents','CONTAINERTYPE','Y','N','N'),
					   ('3000',GETDATE(),'Export','Export Currency Code used on Import and Export documents and declarations','ExportCurrencyCode','Y','N','N'),
					   ('3000',GETDATE(),'Export','Document Note Types used when adding notes related to Export and Import Documents','ExportNoteType','Y','N','N'),
					   ('3000',GETDATE(),'Export','Shipment Additional Fees Types used to categorize fees on Import and Export documents','FeeType','Y','N','N'),
					   ('3000',GETDATE(),'Export','Dangerous Goods categories for reporting on documents and declarations in Export and Import','HazmatClass','Y','N','N'),
					   ('3000',GETDATE(),'Export','Shipment Incoterms Codes','Incoterms','Y','N','N'),
					   ('3000',GETDATE(),'Export','Shipment Mode of Transport','ModeOfTransport','Y','N','N'),
					   ('3000',GETDATE(),'Export','Reporting Quantity Units of Measure used in Export and Import document Lines/Detail','RptQtyUom','Y','N','N'),
					   ('3000',GETDATE(),'Export','Deprecated - Brazilian Siscomex Status','SISCOMEX BR Status','Y','N','N'),
					   ('3000',GETDATE(),'Export','Deprecated - Brazilian Export DU-E Cargo Status','SISCOMEX DU-E CARGO STATUS','Y','N','N'),
					   ('3000',GETDATE(),'Export','Deprecated - Brazilian Export DU-E Export Mode','SISCOMEX DU-E EXP MODE','Y','N','N'),
					   ('3000',GETDATE(),'Export','Deprecated - Brazilian Export DU-E Hold Status','SISCOMEX DU-E HOLD','Y','N','N'),
					   ('3000',GETDATE(),'Export','Deprecated - Brazilian Export DU-E Nota Fiscal Exemptions','SISCOMEX DU-E NFE EXEMPTION','Y','N','N'),
					   ('3000',GETDATE(),'Export','Deprecated - Brazilian Export DU-E Previous Document','SISCOMEX DUE PreviousDocument','Y','N','N'),
					   ('3000',GETDATE(),'Export','Deprecated - Brazilian Export DU-E Priority Treatment','SISCOMEX DUE PriorityTreatment','Y','N','N'),
					   ('3000',GETDATE(),'Export','Deprecated - Brazilian Export DU-E Special Control','SISCOMEX DU-E SPECIAL CONTROL','Y','N','N'),
					   ('3000',GETDATE(),'Export','Deprecated - Brazilian Export DU-E Special Situation','SISCOMEX DU-E SPECIAL SIT','Y','N','N'),
					   ('3000',GETDATE(),'Export','Deprecated - Brazilian Export DU-E Special Transport','SISCOMEX DU-E SPECIAL TRANSP','Y','N','N'),
					   ('3000',GETDATE(),'Export','Deprecated - Brazilian Export DU-E Status','SISCOMEX DU-E Status','Y','N','N'),
					   ('3000',GETDATE(),'Export','Deprecated - Brazilian Export DU-E Warehouse Type','SISCOMEX DU-E Warehouse Type','Y','N','N'),
					   ('3000',GETDATE(),'Export','Deprecated - Brazilian Export Nota Fiscal Fiscal Codes (CFOPs)','SISCOMEX Export CFOP','Y','N','N'),
					   ('3000',GETDATE(),'Export','Deprecated - Brazilian Nota Fiscal Type','SISCOMEX ReferencedInvoiceType','Y','N','N'),
					   ('3000',GETDATE(),'Export','Export Sourcing of Fields Configuration used to define rules for Export Document Details/Lines','SRC-EMDetail','Y','N','N'),
					   ('3000',GETDATE(),'Export','Export Sourcing of Fields Configuration used to define rules for Export Document Header','SRC-EMHeader','Y','N','N'),
					   ('3000',GETDATE(),'Export','Shipment Void Reasons used when tagging a void Export or Import shipment','VoidReasonCode','Y','N','N'),
					   ('3000',GETDATE(),'Export','Export Sourcing of Fields Configuration used to define rules for Export Document Parties','SRC-EMParties','Y','N','N'),
					   ('3000',GETDATE(),'GC','Product Flash Point list used to indicate the lowest temperature at which product''s vapours ignite','FlashPoint','Y','N','N'),
					   ('3000',GETDATE(),'GC','GC End Use type codes ','GCENDUSE','Y','N','N'),
					   ('3000',GETDATE(),'GC','Weight Units of Measure','WeightUom','Y','N','N'),
					   ('3000',GETDATE(),'GC','Transaction Quantity Units of Measure','TxnQtyUom','Y','N','N'),
					   ('3000',GETDATE(),'GC','Currency Codes used in Product Classification ','CurrencyCode','Y','N','N'),
					   ('3000',GETDATE(),'GC','Product Classification Assurance Level provided by the user when classifying a product','AssuranceLevel','Y','N','N'),
					   ('3000',GETDATE(),'GC','World Customs Organizations General Rules for the Interpretation of the Harmonized System codes','GRI','Y','N','N'),
					   ('3000',GETDATE(),'GC','Product Type Codes used in Global Classification','ProductTypeCode','Y','N','N'),
					   ('3000',GETDATE(),'GC','Product Packing Groups used in Product Classification Screen','PackingGroup','Y','N','N'),
					   ('3000',GETDATE(),'GC','Company Business Divisions used to assign products to certain Business Divisions','BusinessDivision','Y','N','N'),
					   ('3000',GETDATE(),'IMMEX','MX pa??s de origen del pedimento en Data Stage / MX Data Stage country of origin field for customs declarations','DATASTAGEOPTCTYORIG','Y','N','N'),
					   ('3000',GETDATE(),'IMMEX','MX Data Stage descripciones del pedimento en Data Stage / MX Data Stage descriptions fields for customs declarations','DATASTAGEOPTDESC','Y','N','N'),
					   ('3000',GETDATE(),'IMMEX','MX tipo de cambio del pedimento / MX Data Stage exchange rates field for customs declarations','DATASTAGEOPTEXRATE','Y','N','N'),
					   ('3000',GETDATE(),'IMMEX','MX fraccion arancelaria en Data Stage / MX Data Stage harmonized system for customs declarations','DATASTAGEOPTHS','Y','N','N'),
					   ('3000',GETDATE(),'IMMEX','MX valor comercial de la partida en Data Stage / MX Data Stage commercial value for customs declarations item','DATASTAGEOPTMXVALD','Y','N','N'),
					   ('3000',GETDATE(),'IMMEX','MX valor comercial total del pedimento en Data Stage / MX Data Stage total commercial value for customs declarations','DATASTAGEOPTMXVALT','Y','N','N'),
					   ('3000',GETDATE(),'IMMEX','MX indicador para cu??ndo se encontr?? el pedimento en Data Stage / MX Data Stage flag to indicate when customs declarations was found','DATASTAGEOPTPED','Y','N','N'),
					   ('3000',GETDATE(),'IMMEX','MX fecha de pago del pedimento en Data Stage / MX Data Stage payment date for customs declarations','DATASTAGEOPTPYDATE','Y','N','N'),
					   ('3000',GETDATE(),'IMMEX','MX valor en d??lares de la partida en Data Stage / MX Data Stage dollar value for customs declarations item','DATASTAGEOPTUSVALD','Y','N','N'),
					   ('3000',GETDATE(),'IMMEX','MX valor total en d??lares del pedimento en Data Stage / MX Data Stage total dollar value for customs declarations','DATASTAGEOPTUSVALT','Y','N','N'),
					   ('3000',GETDATE(),'IMMEX','MX clave del pedimento de exportaci??n / MX Export customs declaration type','ExportPedimentoCode','Y','N','N'),
					   ('3000',GETDATE(),'IMMEX','MX tipo de factura para el prop??sito del proceso, como activo fijo, insumo y etc. / MX Invoice type used to define process purpose, such as fixed asset, raw material and etc.','ImportInvoiceType','Y','N','N'),
					   ('3000',GETDATE(),'IMMEX','MX clave del pedimento de importaci??n / MX Import customs declaration type','ImportPedimentoCode','Y','N','N'),
					   ('3000',GETDATE(),'IMMEX','MX Periodo correspondiente a los pedimentos o folios a reportar en informe de descargos del Anexo 31 / MX Period used to report customs declarations or folios in Annex 31 consumption report','MXANNEX31','Y','N','N'),
					   ('3000',GETDATE(),'IMMEX','MX Clave del destino aduanero asociado al informe descargos del Anexo 31 / MX Customs destination key considered in Anexo 31 consumption report','MXANNEX31PEDCODE','Y','N','N'),
					   ('3000',GETDATE(),'IMMEX','MX Tipo de Operaci??n del Documento de Operacion para Despacho Aduanero (DODA) / MX Customs Clearance Operation Document Operation Type (DODA)','MXDODAOperationType','Y','N','N'),
					   ('3000',GETDATE(),'IMMEX','MX R??gimen aduanero al que se destinan las mercanc??as del pedimento (Ap??ndice 16 del Anexo 22) / MX Customs regulations for goods in customs declaration (Appendix 16 from Annex 22)','PedimentoRegimen','Y','N','N'),
					   ('3000',GETDATE(),'Import','Transaction Quantity Units of Measure','TxnQtyUom','Y','N','N'),
					   ('3000',GETDATE(),'Import','Weight Units of Measure','WeightUom','Y','N','N'),
					   ('3000',GETDATE(),'Import','Shipment Container Type used to categorize an Equipment on Export and Import documents','CONTAINERTYPE','Y','N','N'),
					   ('3000',GETDATE(),'Import','Export Currency Code used on Import and Export documents and declarations','ExportCurrencyCode','Y','N','N'),
					   ('3000',GETDATE(),'Import','Document Note Types used when adding notes related to Export and Import Documents','ExportNoteType','Y','N','N'),
					   ('3000',GETDATE(),'Import','Shipment Additional Fees Types used to categorize fees on Import and Export documents','FeeType','Y','N','N'),
					   ('3000',GETDATE(),'Import','Shipment Incoterms Codes','Incoterms','Y','N','N'),
					   ('3000',GETDATE(),'Import','Shipment Mode of Transport','ModeOfTransport','Y','N','N'),
					   ('3000',GETDATE(),'Import','Reporting Quantity Units of Measure used in Export and Import document Lines/Detail','RptQtyUom','Y','N','N'),
					   ('3000',GETDATE(),'Import','Shipment Void Reasons used when tagging a void Export or Import shipment','VoidReasonCode','Y','N','N');

				MERGE dbo.tmgglobalcodesheader dt
					USING #tmgglobalcodesheader te
						ON  dt.PartnerID			= te.PartnerID 		
						AND dt.Module		= te.Module
						AND dt.GlobalCodeFieldName	= te.GlobalCodeFieldName		
				WHEN MATCHED
						THEN UPDATE SET
							dt.EffDate		= te.EffDate
							,dt.GlobalCodeDescription		= te.GlobalCodeDescription
							,dt.Standard		= te.Standard
							,dt.DeletedFlag		= te.DeletedFlag
							,dt.KeepDuringRollback		= te.KeepDuringRollback
				WHEN NOT MATCHED BY TARGET
						THEN INSERT (PartnerID, EffDate, Module, GlobalCodeDescription, GlobalCodeFieldName, Standard, DeletedFlag, KeepDuringRollback) 
						VALUES (te.PartnerID, te.EffDate, te.Module, te.GlobalCodeDescription, te.GlobalCodeFieldName, te.Standard, te.DeletedFlag, te.KeepDuringRollback);

				IF OBJECT_ID('tempdb..#tmgglobalcodesheader') IS NOT NULL DROP TABLE #tmgglobalcodesheader
	END
END