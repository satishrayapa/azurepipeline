DECLARE @CorrectBaselineDB AS VARCHAR(50)
SET @CorrectBaselineDB = 'IP_3000_BASELINE'

DECLARE @CorrectProductionDB AS VARCHAR(50)
SET @CorrectProductionDB = 'IP_3000'

DECLARE @CorrectQADB AS VARCHAR(50)
SET @CorrectQADB = 'IP_3000_QA_Baseline'

DECLARE @CurrentDB AS VARCHAR(50)
SET @CurrentDB = (Select db_name())



IF (@CurrentDB IN (@CorrectProductionDB, @CorrectQADB, @CorrectBaselineDB))
BEGIN

IF EXISTS (
		SELECT TOP 1 1
		FROM tmgSQL WITH (NOLOCK)
		WHERE SQLGUID = '497c7e34-2487-4ac6-9065-c47dcde11104'
			AND PartnerID = '3000'
		)
BEGIN
	UPDATE tmgSQL
	SET SQLLongDescription = 'Displays changes done by users relating to product classifications within the selected country profile'
	WHERE SQLGUID = '497c7e34-2487-4ac6-9065-c47dcde11104'
		AND PartnerID = '3000'
END

IF EXISTS (
		SELECT TOP 1 1
		FROM tmgSQL WITH (NOLOCK)
		WHERE SQLGUID = '85ba048a-bedb-484a-bff3-52263ca4ce0e'
			AND PartnerID = '3000'
		)
BEGIN
	UPDATE tmgSQL
	SET SQLLongDescription = 'Displays ProductNum, ProductDesc, and AssuranceLevel for products that have a low level of classification assurance from a specified country'
	WHERE SQLGUID = '85ba048a-bedb-484a-bff3-52263ca4ce0e'
		AND PartnerID = '3000'
END

IF EXISTS (
		SELECT TOP 1 1
		FROM tmgSQL WITH (NOLOCK)
		WHERE SQLGUID = 'cca6d524-7383-4dff-8e7c-7cb4f70332fa'
			AND PartnerID = '3000'
		)
BEGIN
	UPDATE tmgSQL
	SET SQLLongDescription = 'Displays products in the selected country where the ECN Number is not EAR99'
	WHERE SQLGUID = 'cca6d524-7383-4dff-8e7c-7cb4f70332fa'
		AND PartnerID = '3000'
END

IF EXISTS (
		SELECT TOP 1 1
		FROM tmgSQL WITH (NOLOCK)
		WHERE SQLGUID = '69a70978-6fe4-4917-8c64-e147e0be5fe6'
			AND PartnerID = '3000'
		)
BEGIN
	UPDATE tmgSQL
	SET SQLLongDescription = 'Displays number of edits recorded in Audit Log for selected country by user'
	WHERE SQLGUID = '69a70978-6fe4-4917-8c64-e147e0be5fe6'
		AND PartnerID = '3000'
END

IF EXISTS (
		SELECT TOP 1 1
		FROM tmgSQL WITH (NOLOCK)
		WHERE SQLGUID = '74236680-f99b-4ab6-9e34-4be3991edcc2'
			AND PartnerID = '3000'
		)
BEGIN
	UPDATE tmgSQL
	SET SQLLongDescription = 'Displays Request information for all Requests with a status that is not Closed'
	WHERE SQLGUID = '74236680-f99b-4ab6-9e34-4be3991edcc2'
		AND PartnerID = '3000'
END

IF EXISTS (
		SELECT TOP 1 1
		FROM tmgSQL WITH (NOLOCK)
		WHERE SQLGUID = '92e5b6b6-56ae-41f5-84e9-fee76e0a433d'
			AND PartnerID = '3000'
		)
BEGIN
	UPDATE tmgSQL
	SET SQLLongDescription = 'Displays all products in the selected country profile for quick navigation and high-level extract'
	WHERE SQLGUID = '92e5b6b6-56ae-41f5-84e9-fee76e0a433d'
		AND PartnerID = '3000'
END

IF EXISTS (
		SELECT TOP 1 1
		FROM tmgSQL WITH (NOLOCK)
		WHERE SQLGUID = '16e3db90-53a9-4e63-baa6-eb77b41d6cd0'
			AND PartnerID = '3000'
		)
BEGIN
	UPDATE tmgSQL
	SET SQLLongDescription = 'Displays product information for FTZ active parts in selected country'
	WHERE SQLGUID = '16e3db90-53a9-4e63-baa6-eb77b41d6cd0'
		AND PartnerID = '3000'
END

IF EXISTS (
		SELECT TOP 1 1
		FROM tmgSQL WITH (NOLOCK)
		WHERE SQLGUID = 'fd462eeb-2693-4793-b003-d6a67893521d'
			AND PartnerID = '3000'
		)
BEGIN
	UPDATE tmgSQL
	SET SQLLongDescription = 'Displays information about the validation errors that occur when running GCP2IM '
	WHERE SQLGUID = 'fd462eeb-2693-4793-b003-d6a67893521d'
		AND PartnerID = '3000'
END

IF EXISTS (
		SELECT TOP 1 1
		FROM tmgSQL WITH (NOLOCK)
		WHERE SQLGUID = '28a23a57-3427-41b9-83ec-ea03b7869859'
			AND PartnerID = '3000'
		)
BEGIN
	UPDATE tmgSQL
	SET SQLLongDescription = 'Displays all products missing weight values (net or gross)'
	WHERE SQLGUID = '28a23a57-3427-41b9-83ec-ea03b7869859'
		AND PartnerID = '3000'
END

IF EXISTS (
		SELECT TOP 1 1
		FROM tmgSQL WITH (NOLOCK)
		WHERE SQLGUID = 'da986e44-a197-4939-bf02-ca9330e1dfb1'
			AND PartnerID = '3000'
		)
BEGIN
	UPDATE tmgSQL
	SET SQLLongDescription = 'Displays products with Invalid HS Numbers'
	WHERE SQLGUID = 'da986e44-a197-4939-bf02-ca9330e1dfb1'
		AND PartnerID = '3000'
END

IF EXISTS (
		SELECT TOP 1 1
		FROM tmgSQL WITH (NOLOCK)
		WHERE SQLGUID = '7013fd15-076a-47ac-8b4f-f559214c45e1'
			AND PartnerID = '3000'
		)
BEGIN
	UPDATE tmgSQL
	SET SQLLongDescription = 'Displays products where RptQtyUOM is not in the list of Standard Reporting UOM defined in Global Codes'
	WHERE SQLGUID = '7013fd15-076a-47ac-8b4f-f559214c45e1'
		AND PartnerID = '3000'
END

IF EXISTS (
		SELECT TOP 1 1
		FROM tmgSQL WITH (NOLOCK)
		WHERE SQLGUID = 'e1703c4d-603b-4aaa-bc1c-00ebc32c5dbd'
			AND PartnerID = '3000'
		)
BEGIN
	UPDATE tmgSQL
	SET SQLLongDescription = 'Displays US products with US antidumping case numbers populated'
	WHERE SQLGUID = 'e1703c4d-603b-4aaa-bc1c-00ebc32c5dbd'
		AND PartnerID = '3000'
END

IF EXISTS (
		SELECT TOP 1 1
		FROM tmgSQL WITH (NOLOCK)
		WHERE SQLGUID = '4397acae-d3b9-47b5-8da8-d5be67206469'
			AND PartnerID = '3000'
		)
BEGIN
	UPDATE tmgSQL
	SET SQLLongDescription = 'Displays product information for products within selected country without a specified HS Number'
	WHERE SQLGUID = '4397acae-d3b9-47b5-8da8-d5be67206469'
		AND PartnerID = '3000'
END

IF EXISTS (
		SELECT TOP 1 1
		FROM tmgSQL WITH (NOLOCK)
		WHERE SQLGUID = '81d3b754-8008-411b-aaae-20135777a168'
			AND PartnerID = '3000'
		)
BEGIN
	UPDATE tmgSQL
	SET SQLLongDescription = 'Displays US products with US countervailing case numbers populated'
	WHERE SQLGUID = '81d3b754-8008-411b-aaae-20135777a168'
		AND PartnerID = '3000'
END

IF EXISTS (
		SELECT TOP 1 1
		FROM tmgSQL WITH (NOLOCK)
		WHERE SQLGUID = '3a5be1e5-42f7-4d7a-90dd-e8d87ad896eb'
			AND PartnerID = '3000'
		)
BEGIN
	UPDATE tmgSQL
	SET SQLLongDescription = 'Displays the US  E and C regulations for US products'
	WHERE SQLGUID = '3a5be1e5-42f7-4d7a-90dd-e8d87ad896eb'
		AND PartnerID = '3000'
END

IF EXISTS (
		SELECT TOP 1 1
		FROM tmgSQL WITH (NOLOCK)
		WHERE SQLGUID = 'd0b5bfe6-8214-4143-9785-f9e399a96ca5'
			AND PartnerID = '3000'
		)
BEGIN
	UPDATE tmgSQL
	SET SQLLongDescription = 'Displays the US  WHO regulations for US products'
	WHERE SQLGUID = 'd0b5bfe6-8214-4143-9785-f9e399a96ca5'
		AND PartnerID = '3000'
END

IF EXISTS (
		SELECT TOP 1 1
		FROM tmgSQL WITH (NOLOCK)
		WHERE SQLGUID = 'a2b51265-9156-4784-b829-8407e4904119'
			AND PartnerID = '3000'
		)
BEGIN
	UPDATE tmgSQL
	SET SQLLongDescription = 'Displays the US Consumer Product Safety Commission regulations for US products'
	WHERE SQLGUID = 'a2b51265-9156-4784-b829-8407e4904119'
		AND PartnerID = '3000'
END

IF EXISTS (
		SELECT TOP 1 1
		FROM tmgSQL WITH (NOLOCK)
		WHERE SQLGUID = 'cdf311ae-9151-4cc6-ad1b-62b93158ba63'
			AND PartnerID = '3000'
		)
BEGIN
	UPDATE tmgSQL
	SET SQLLongDescription = 'Displays the US Department of Transportation regulations for US products'
	WHERE SQLGUID = 'cdf311ae-9151-4cc6-ad1b-62b93158ba63'
		AND PartnerID = '3000'
END

IF EXISTS (
		SELECT TOP 1 1
		FROM tmgSQL WITH (NOLOCK)
		WHERE SQLGUID = '84db6e93-12d9-4439-bf03-b0794f887154'
			AND PartnerID = '3000'
		)
BEGIN
	UPDATE tmgSQL
	SET SQLLongDescription = 'Displays the US Customs and Border Protection regulations for US products'
	WHERE SQLGUID = '84db6e93-12d9-4439-bf03-b0794f887154'
		AND PartnerID = '3000'
END

IF EXISTS (
		SELECT TOP 1 1
		FROM tmgSQL WITH (NOLOCK)
		WHERE SQLGUID = '7b8c07ad-7a1b-4baf-a2fa-3b124e3b8e4a'
			AND PartnerID = '3000'
		)
BEGIN
	UPDATE tmgSQL
	SET SQLLongDescription = 'Displays the US Alcohol Tobacco, Firearms and Explosives Bureau regulations for US products'
	WHERE SQLGUID = '7b8c07ad-7a1b-4baf-a2fa-3b124e3b8e4a'
		AND PartnerID = '3000'
END

IF EXISTS (
		SELECT TOP 1 1
		FROM tmgSQL WITH (NOLOCK)
		WHERE SQLGUID = '9e3f9f6c-bf4e-4366-91ff-b40801d4c6a3'
			AND PartnerID = '3000'
		)
BEGIN
	UPDATE tmgSQL
	SET SQLLongDescription = 'Displays the US Fish and Wildlife Service regulations for US products'
	WHERE SQLGUID = '9e3f9f6c-bf4e-4366-91ff-b40801d4c6a3'
		AND PartnerID = '3000'
END

IF EXISTS (
		SELECT TOP 1 1
		FROM tmgSQL WITH (NOLOCK)
		WHERE SQLGUID = '165f13dd-33fb-42e6-9023-dcbef0c16c37'
			AND PartnerID = '3000'
		)
BEGIN
	UPDATE tmgSQL
	SET SQLLongDescription = 'Displays the US Office of Textiles and Apparel regulations for US products'
	WHERE SQLGUID = '165f13dd-33fb-42e6-9023-dcbef0c16c37'
		AND PartnerID = '3000'
END

IF EXISTS (
		SELECT TOP 1 1
		FROM tmgSQL WITH (NOLOCK)
		WHERE SQLGUID = 'a58e745d-3ee5-4844-99a4-2efe92d09bbc'
			AND PartnerID = '3000'
		)
BEGIN
	UPDATE tmgSQL
	SET SQLLongDescription = 'Displays the US Federal Communications Commission regulations for US products'
	WHERE SQLGUID = 'a58e745d-3ee5-4844-99a4-2efe92d09bbc'
		AND PartnerID = '3000'
END

IF EXISTS (
		SELECT TOP 1 1
		FROM tmgSQL WITH (NOLOCK)
		WHERE SQLGUID = 'c36b1fe2-e71e-42db-a495-321776e02818'
			AND PartnerID = '3000'
		)
BEGIN
	UPDATE tmgSQL
	SET SQLLongDescription = 'Displays the US Animal & Plant Health Inspection Service regulations for US products'
	WHERE SQLGUID = 'c36b1fe2-e71e-42db-a495-321776e02818'
		AND PartnerID = '3000'
END

IF EXISTS (
		SELECT TOP 1 1
		FROM tmgSQL WITH (NOLOCK)
		WHERE SQLGUID = 'f159dd37-3136-4920-9d7f-59db7d124881'
			AND PartnerID = '3000'
		)
BEGIN
	UPDATE tmgSQL
	SET SQLLongDescription = 'Displays the US Food & Drug regulations for US products'
	WHERE SQLGUID = 'f159dd37-3136-4920-9d7f-59db7d124881'
		AND PartnerID = '3000'
END

IF EXISTS (
		SELECT TOP 1 1
		FROM tmgSQL WITH (NOLOCK)
		WHERE SQLGUID = '22fa5110-38ae-4b61-9a41-c0ae405744b9'
			AND PartnerID = '3000'
		)
BEGIN
	UPDATE tmgSQL
	SET SQLLongDescription = 'Displays the US National Marine Fisheries Service regulations for US products'
	WHERE SQLGUID = '22fa5110-38ae-4b61-9a41-c0ae405744b9'
		AND PartnerID = '3000'
END

IF EXISTS (
		SELECT TOP 1 1
		FROM tmgSQL WITH (NOLOCK)
		WHERE SQLGUID = 'ddbfc1d7-60f6-4b4a-bb65-e817e862589e'
			AND PartnerID = '3000'
		)
BEGIN
	UPDATE tmgSQL
	SET SQLLongDescription = 'Displays the US Environmental Protection Agency regulations for US products'
	WHERE SQLGUID = 'ddbfc1d7-60f6-4b4a-bb65-e817e862589e'
		AND PartnerID = '3000'
END

IF EXISTS (
		SELECT TOP 1 1
		FROM tmgSQL WITH (NOLOCK)
		WHERE SQLGUID = '6dcc8243-61eb-408d-984a-fa41bb50f699'
			AND PartnerID = '3000'
		)
BEGIN
	UPDATE tmgSQL
	SET SQLLongDescription = 'Displays the US Department of Agriculture regulations for US products'
	WHERE SQLGUID = '6dcc8243-61eb-408d-984a-fa41bb50f699'
		AND PartnerID = '3000'
END

IF EXISTS (
		SELECT TOP 1 1
		FROM tmgSQL WITH (NOLOCK)
		WHERE SQLGUID = '9b51e137-f4f0-4bc0-b3bd-4fa01e238546'
			AND PartnerID = '3000'
		)
BEGIN
	UPDATE tmgSQL
	SET SQLLongDescription = 'Displays the US Federal Trade Commission regulations for US products'
	WHERE SQLGUID = '9b51e137-f4f0-4bc0-b3bd-4fa01e238546'
		AND PartnerID = '3000'
END

IF EXISTS (
		SELECT TOP 1 1
		FROM tmgSQL WITH (NOLOCK)
		WHERE SQLGUID = 'e90ccfa8-ab73-493f-8813-93b4ac4fe614'
			AND PartnerID = '3000'
		)
BEGIN
	UPDATE tmgSQL
	SET SQLLongDescription = 'Displays the US Department of Labor regulations for US products'
	WHERE SQLGUID = 'e90ccfa8-ab73-493f-8813-93b4ac4fe614'
		AND PartnerID = '3000'
END

IF EXISTS (
		SELECT TOP 1 1
		FROM tmgSQL WITH (NOLOCK)
		WHERE SQLGUID = '5104333f-6c28-40c1-9564-6353902d0675'
			AND PartnerID = '3000'
		)
BEGIN
	UPDATE tmgSQL
	SET SQLLongDescription = 'Displays the most common HS Chapters for the selected country profile and the number of occurances.'
	WHERE SQLGUID = '5104333f-6c28-40c1-9564-6353902d0675'
		AND PartnerID = '3000'
END

IF EXISTS (
		SELECT TOP 1 1
		FROM tmgSQL WITH (NOLOCK)
		WHERE SQLGUID = 'afef7b6f-936d-4887-8d3e-d4a9ad836c50'
			AND PartnerID = '3000'
		)
BEGIN
	UPDATE tmgSQL
	SET SQLLongDescription = 'Displays products that have been recently triggered to be sent in an outbound interface'
	WHERE SQLGUID = 'afef7b6f-936d-4887-8d3e-d4a9ad836c50'
		AND PartnerID = '3000'
END

IF EXISTS (
		SELECT TOP 1 1
		FROM tmgSQL WITH (NOLOCK)
		WHERE SQLGUID = '7a3bc757-a00e-45a8-8354-33cb31bf5e72'
			AND PartnerID = '3000'
		)
BEGIN
	UPDATE tmgSQL
	SET SQLLongDescription = 'Displays all Products in the selected country profile'
	WHERE SQLGUID = '7a3bc757-a00e-45a8-8354-33cb31bf5e72'
		AND PartnerID = '3000'
END
END
