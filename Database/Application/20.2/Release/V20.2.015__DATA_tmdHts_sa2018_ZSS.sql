BEGIN TRAN

	IF EXISTS (select TOP 1 1 from sys.tables where Name = 'tmdhts_sa2018' --Your Table Here
				AND Type = 'U')
		BEGIN	
			TRUNCATE TABLE [tmdhts_sa2018]
		END
	ELSE
		BEGIN
			CREATE TABLE [dbo].[tmdhts_sa2018](
				[HtsNum] [varchar] (12) NULL
			) ON [PRIMARY]
		END


	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7206100000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7206900000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7207110000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7207120010)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7207120050)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7207190030)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7207190090)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7207200025)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7207200045)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7207200075)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7207200090)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7208101500)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7208103000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7208106000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7208253000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7208256000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7208260030)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7208260060)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7208270030)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7208270060)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7208360030)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7208360060)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7208370030)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7208370060)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7208380015)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7208380030)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7208380090)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7208390015)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7208390030)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7208390090)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7208403030)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7208403060)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7208406030)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7208406060)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7208510030)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7208510045)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7208510060)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7208520000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7208530000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7208540000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7208900000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7209150000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7209160030)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7209160060)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7209160070)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7209160091)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7209170030)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7209170060)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7209170070)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7209170091)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7209181530)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7209181560)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7209182520)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7209182585)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7209186020)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7209186090)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7209250000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7209260000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7209270000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7209280000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7209900000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7210110000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7210120000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7210200000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7210300030)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7210300060)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7210410000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7210490030)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7210490091)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7210490095)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7210500000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7210610000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7210690000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7210703000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7210706030)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7210706060)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7210706090)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7210901000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7210906000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7210909000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7211130000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7211140030)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7211140045)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7211140090)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7211191500)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7211192000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7211193000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7211194500)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7211196000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7211197530)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7211197560)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7211197590)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7211231500)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7211232000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7211233000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7211234500)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7211236030)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7211236060)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7211236090)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7211292030)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7211292090)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7211294500)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7211296030)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7211296080)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7211900000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7212100000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7212200000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7212301030)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7212301090)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7212303000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7212305000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7212401000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7212405000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7212500000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7212600000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7213100000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7213200010)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7213200080)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7213913011)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7213913015)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7213913020)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7213913093)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7213914500)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7213916000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7213990030)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7213990060)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7213990090)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7214100000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7214200000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7214300010)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7214300080)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7214910016)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7214910020)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7214910060)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7214910090)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7214990016)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7214990021)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7214990026)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7214990031)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7214990036)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7214990040)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7214990045)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7214990060)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7214990075)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7214990090)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7215100010)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7215100080)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7215500016)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7215500018)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7215500020)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7215500061)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7215500063)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7215500065)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7215500090)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7215901000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7215903000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7215905000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7216100010)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7216100050)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7216210000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7216220000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7216310000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7216320000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7216330030)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7216330060)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7216330090)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7216400010)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7216400050)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7216500000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7216990010)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7216990090)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7217101000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7217102000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7217103000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7217104040)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7217104045)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7217104090)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7217105030)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7217105090)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7217106000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7217107000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7217108010)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7217108020)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7217108025)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7217108030)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7217108045)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7217108060)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7217108075)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7217108090)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7217109000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7217201500)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7217203000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7217204510)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7217204520)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7217204530)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7217204540)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7217204550)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7217204560)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7217204570)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7217204580)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7217206000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7217207500)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7217301530)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7217301560)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7217303000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7217304504)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7217304511)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7217304520)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7217304530)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7217304541)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7217304550)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7217304560)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7217304590)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7217306000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7217307500)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7217901000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7217905030)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7217905060)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7217905090)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7218100000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7218910015)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7218910030)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7218910060)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7218990015)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7218990030)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7218990045)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7218990060)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7218990090)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7219110030)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7219110060)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7219120002)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7219120006)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7219120021)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7219120026)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7219120051)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7219120056)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7219120066)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7219120071)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7219120081)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7219130002)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7219130031)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7219130051)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7219130071)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7219130081)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7219140030)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7219140065)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7219140090)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7219210005)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7219210020)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7219210040)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7219210060)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7219220005)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7219220015)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7219220020)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7219220025)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7219220035)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7219220040)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7219220045)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7219220070)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7219220075)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7219220080)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7219230030)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7219230060)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7219240030)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7219240060)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7219310010)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7219310050)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7219320005)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7219320020)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7219320025)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7219320035)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7219320036)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7219320038)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7219320042)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7219320044)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7219320045)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7219320060)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7219330005)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7219330020)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7219330025)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7219330035)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7219330036)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7219330038)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7219330042)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7219330044)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7219330045)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7219330070)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7219330080)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7219340005)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7219340020)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7219340025)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7219340030)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7219340035)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7219340050)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7219350005)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7219350015)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7219350030)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7219350035)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7219350050)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7219900010)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7219900020)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7219900025)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7219900060)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7219900080)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7220110000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7220121000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7220125000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7220201010)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7220201015)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7220201060)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7220201080)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7220206005)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7220206010)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7220206015)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7220206060)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7220206080)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7220207005)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7220207010)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7220207015)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7220207060)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7220207080)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7220208000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7220209030)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7220209060)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7220900010)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7220900015)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7220900060)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7220900080)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7221000005)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7221000017)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7221000018)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7221000030)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7221000045)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7221000075)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7222110001)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7222110006)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7222110057)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7222110059)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7222110082)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7222110084)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7222190001)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7222190006)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7222190052)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7222190054)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7222200001)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7222200006)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7222200041)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7222200043)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7222200062)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7222200064)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7222200067)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7222200069)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7222200071)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7222200073)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7222300001)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7222300012)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7222300022)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7222300024)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7222300082)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7222300084)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7222403025)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7222403045)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7222403065)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7222403085)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7222406000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7223001005)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7223001016)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7223001031)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7223001046)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7223001061)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7223001076)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7223005000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7223009000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7224100005)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7224100045)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7224100075)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7224900005)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7224900015)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7224900025)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7224900035)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7224900045)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7224900055)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7224900065)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7224900075)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7225110000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7225190000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7225301110)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7225301180)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7225303005)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7225303050)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7225305110)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7225305180)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7225307000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7225401110)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7225401180)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7225403005)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7225403050)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7225405110)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7225405130)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7225405160)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7225407000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7225501110)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7225501130)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7225501160)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7225506000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7225507000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7225508010)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7225508080)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7225910000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7225920000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7225990010)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7225990090)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7226111000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7226119030)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7226119060)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7226191000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7226199000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7226200000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7226910500)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7226911530)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7226911560)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7226912530)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7226912560)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7226915000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7226917000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7226918000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7226921030)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7226921060)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7226923030)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7226923060)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7226925000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7226927005)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7226927050)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7226928005)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7226928050)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7226990110)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7226990130)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7226990180)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7227100000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7227200030)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7227200080)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7227901030)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7227901060)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7227902030)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7227902060)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7227906005)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7227906010)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7227906020)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7227906030)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7227906035)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7227906040)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7227906090)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7228100010)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7228100030)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7228100060)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7228201000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7228205000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7228302000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7228304000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7228306000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7228308005)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7228308010)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7228308015)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7228308041)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7228308045)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7228308070)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7228400000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7228501010)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7228501020)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7228501040)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7228501060)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7228501080)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7228505005)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7228505015)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7228505040)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7228505070)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7228601030)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7228601060)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7228606000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7228608000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7228703010)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7228703020)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7228703041)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7228703060)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7228703081)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7228706000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7228800000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7229200010)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7229200015)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7229200090)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7229900500)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7229901000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7229905006)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7229905008)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7229905016)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7229905031)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7229905051)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7229909000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7301100000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7302101010)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7302101015)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7302101025)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7302101035)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7302101045)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7302101055)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7302101065)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7302101075)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7302105020)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7302105040)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7302105060)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7302400000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7302901000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7302909000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304110020)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304110050)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304110080)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304191020)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304191030)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304191045)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304191060)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304191080)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304195020)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304195050)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304195080)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304220030)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304220045)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304220060)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304233000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304236030)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304236045)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304236060)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304243010)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304243020)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304243030)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304243040)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304243045)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304243080)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304244010)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304244020)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304244030)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304244040)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304244050)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304244060)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304244080)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304246015)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304246030)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304246045)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304246060)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304246075)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304291010)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304291020)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304291030)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304291040)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304291050)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304291060)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304291080)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304292010)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304292020)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304292030)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304292040)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304292050)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304292060)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304292080)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304293110)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304293120)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304293130)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304293140)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304293150)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304293160)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304293180)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304294110)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304294120)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304294130)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304294140)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304294150)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304294160)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304294180)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304295015)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304295030)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304295045)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304295060)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304295075)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304296115)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304296130)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304296145)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304296160)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304296175)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304313000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304316010)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304316050)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304390002)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304390004)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304390006)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304390008)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304390016)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304390020)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304390024)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304390028)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304390032)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304390036)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304390040)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304390044)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304390048)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304390052)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304390056)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304390062)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304390068)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304390072)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304390076)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304390080)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304413005)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304413015)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304413045)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304416005)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304416015)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304416045)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304490005)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304490015)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304490045)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304490060)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304511000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304515005)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304515015)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304515045)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304515060)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304591000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304592030)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304592040)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304592045)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304592055)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304592060)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304592070)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304592080)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304596000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304598010)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304598015)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304598020)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304598025)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304598030)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304598035)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304598040)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304598045)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304598050)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304598055)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304598060)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304598065)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304598070)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304598080)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304901000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304903000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304905000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7304907000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7305111030)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7305111060)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7305115000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7305121030)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7305121060)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7305125000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7305191030)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7305191060)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7305195000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7305202000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7305204000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7305206000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7305208000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7305312000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7305314000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7305316010)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7305316090)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7305391000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7305395000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7305901000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7305905000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7306110010)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7306110050)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7306191010)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7306191050)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7306195110)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7306195150)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7306213000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7306214000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7306218010)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7306218050)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7306291030)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7306291090)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7306292000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7306293100)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7306294100)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7306296010)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7306296050)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7306298110)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7306298150)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7306301000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7306303000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7306305010)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7306305015)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7306305020)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7306305025)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7306305028)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7306305032)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7306305035)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7306305040)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7306305055)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7306305085)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7306305090)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7306401010)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7306401015)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7306401090)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7306405005)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7306405015)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7306405040)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7306405042)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7306405044)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7306405062)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7306405064)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7306405080)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7306405085)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7306405090)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7306501000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7306503000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7306505010)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7306505030)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7306505050)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7306505070)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7306611000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7306613000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7306615000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7306617030)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7306617060)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7306691000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7306693000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7306695000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7306697030)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7306697060)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7306901000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7306905000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7317003000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7317005503)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7317005505)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7317005507)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7317005560)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7317005580)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7317006560)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7601103000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7601106000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7601203000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7601206000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7601209030)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7601209045)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7601209060)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7601209075)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7601209090)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7604101000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7604103010)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7604103050)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7604105030)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7604105060)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7604210000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7604291000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7604293010)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7604293050)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7604295030)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7604295060)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7605110030)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7605110090)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7605190000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7605210030)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7605210090)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7605290000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7606113030)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7606113060)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7606116000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7606123030)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7606123045)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7606123055)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7606123090)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7606126000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7606913030)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7606913060)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7606913075)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7606913090)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7606916020)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7606916040)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7606916060)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7606916080)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7606923030)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7606923060)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7606923075)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7606923090)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7606926020)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7606926040)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7606926060)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7606926080)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7607113000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7607116000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7607119030)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7607119060)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7607119090)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7607191000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7607193000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7607196000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7607201000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7607205000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7608100030)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7608100090)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7608200030)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7608200090)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7609000000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7614105000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7614902030)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7614902060)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7614904000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7614905000)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7616995160)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (7616995170)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (8708103010)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (8708103050)

	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (8708292100)
	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (8708103030)
	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (8708292130)
	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (8708103020)
	INSERT [dbo].[tmdhts_sa2018] ([HtsNum]) VALUES (8708292120)

COMMIT TRAN
