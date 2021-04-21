IF EXISTS (SELECT * FROM sys.xml_schema_collections 
                    WHERE name = N'DE_IMP_FCFCRD' 
                    AND schema_id = SCHEMA_ID(N'dbo'))
BEGIN
   DROP XML SCHEMA COLLECTION dbo.DE_IMP_FCFCRD;
END
 
CREATE XML SCHEMA COLLECTION dbo.DE_IMP_FCFCRD
AS N'<?xml version="1.0" encoding="UTF-16"?>
<xs:schema version="9.0.1.2" elementFormDefault="qualified" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:aie="urn:publicid:IDN+zoll.de:AIE">
	<xs:complexType name="decimal">
		<xs:simpleContent>
			<xs:extension base="xs:decimal">
				<xs:anyAttribute/>
			</xs:extension>
		</xs:simpleContent>
	</xs:complexType>
	<xs:complexType name="integer">
		<xs:simpleContent>
			<xs:extension base="xs:integer">
				<xs:anyAttribute/>
			</xs:extension>
		</xs:simpleContent>
	</xs:complexType>
	<xs:complexType name="token">
		<xs:simpleContent>
			<xs:extension base="xs:token">
				<xs:anyAttribute/>
			</xs:extension>
		</xs:simpleContent>
	</xs:complexType>
	<xs:element name="FCFCRD" id="MES">
		<xs:annotation>
			<xs:documentation>
				<aie:name value="NACHRICHT"/>
				<aie:id value="1"/>
				<aie:status value="R"/>
			</xs:documentation>
		</xs:annotation>
		<xs:complexType>
			<xs:sequence>
				<xs:element name="MetaData" minOccurs="1" maxOccurs="1" id="MTD">
					<xs:annotation>
						<xs:documentation>
							<aie:name value="METADATEN"/>
							<aie:id value="159"/>
							<aie:status value="R"/>
						</xs:documentation>
					</xs:annotation>
					<xs:complexType>
						<xs:sequence>
							<xs:element name="Preparation" minOccurs="1" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="Vorbereitung"/>
										<aie:status value="R"/>
									</xs:documentation>
								</xs:annotation>
								<xs:complexType>
									<xs:sequence>
										<xs:element name="Date" minOccurs="1" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Vorbereitung (Datum)"/>
													<aie:id value="168"/>
													<aie:status value="R"/>
													<aie:format value="Date (n6)"/>
													<aie:pcre value="\A(?!....-(?:02|04|06|09|11)-31|....-02-30|..(?:.[13579]|[02468][26]|[13579][048])-02-29)^(?:20[0-9][0-9])-(?:0[1-9]|1[0-2])-(?:0[1-9]|[12][0-9]|3[01])\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:date">
													<xs:minInclusive value="2000-01-01"/>
													<xs:maxInclusive value="2099-12-31"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="Time" minOccurs="1" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Vorbereitung (Zeit)"/>
													<aie:id value="169"/>
													<aie:status value="R"/>
													<aie:format value="Time (n4)"/>
													<aie:pcre value="\A(?:[01][0-9]|2[0-3]):(?:[0-5][0-9]):(?:00)\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:time">
													<xs:minInclusive value="00:00:00"/>
													<xs:maxInclusive value="23:59:00"/>
													<xs:pattern value="[0-9]{2}:[0-9]{2}:[0-0]{2}"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
									</xs:sequence>
								</xs:complexType>
							</xs:element>
							<xs:element name="InterchangeControlReference" minOccurs="1" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="Datei-Kennung"/>
										<aie:id value="160"/>
										<aie:status value="R"/>
										<aie:format value="an..14"/>
										<aie:pcre value="\A.{1,14}\Z"/>
									</xs:documentation>
								</xs:annotation>
								<xs:simpleType>
									<xs:restriction base="xs:token">
										<xs:minLength value="1"/>
										<xs:maxLength value="14"/>
									</xs:restriction>
								</xs:simpleType>
							</xs:element>
							<xs:element name="MessageReferenceNumber" minOccurs="1" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="Identifikation"/>
										<aie:id value="161"/>
										<aie:status value="R"/>
										<aie:format value="n..6"/>
										<aie:pcre value="\A(?:0|[1-9][0-9]{0,5})\Z"/>
									</xs:documentation>
								</xs:annotation>
								<xs:simpleType>
									<xs:restriction base="xs:integer">
										<xs:minInclusive value="0"/>
										<xs:maxInclusive value="999999"/>
										<xs:totalDigits value="6"/>
										<xs:pattern value="(0|[1-9][0-9]{0,5})"/>
									</xs:restriction>
								</xs:simpleType>
							</xs:element>
							<xs:element name="MessageIdentifier" minOccurs="1" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="Nachrichtennummer"/>
										<aie:id value="163"/>
										<aie:status value="R"/>
										<aie:format value="an..35"/>
										<aie:pcre value="\A.{1,35}\Z"/>
									</xs:documentation>
								</xs:annotation>
								<xs:simpleType>
									<xs:restriction base="xs:token">
										<xs:minLength value="1"/>
										<xs:maxLength value="35"/>
									</xs:restriction>
								</xs:simpleType>
							</xs:element>
							<xs:element name="MessageGroup" minOccurs="1" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="Nachrichtengruppe"/>
										<aie:id value="162"/>
										<aie:status value="R"/>
										<aie:format value="a3"/>
										<aie:pcre value="\A(?:ZAV|ZVV)\Z"/>
										<aie:list value="A0110"/>
									</xs:documentation>
								</xs:annotation>
								<xs:simpleType>
									<xs:restriction base="xs:token">
										<xs:length value="3"/>
										<xs:enumeration value="ZAV"/>
										<xs:enumeration value="ZVV"/>
									</xs:restriction>
								</xs:simpleType>
							</xs:element>
							<xs:element name="Scenario" minOccurs="0" maxOccurs="0">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="Szenario"/>
										<aie:status value="N"/>
									</xs:documentation>
								</xs:annotation>
								<xs:complexType>
									<xs:sequence>
										<xs:element name="ReferenceNumber" minOccurs="0" maxOccurs="0">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Szenario-Nummer"/>
													<aie:id value="165"/>
													<aie:status value="N"/>
													<aie:format value="n5"/>
													<aie:pcre value="\A[1-9][0-9]{4}\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:length value="5"/>
													<xs:pattern value="[1-9][0-9]{4}"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="Note" minOccurs="0" maxOccurs="0">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Szenario-Hinweis"/>
													<aie:id value="164"/>
													<aie:status value="N"/>
													<aie:format value="a2"/>
													<aie:pcre value="\A[A-Z]{2}\Z"/>
													<aie:list value="A0112"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:length value="2"/>
													<xs:pattern value="[A-Z]{2}"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
									</xs:sequence>
								</xs:complexType>
							</xs:element>
							<xs:element name="TestIndicator" minOccurs="0" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="Test-Indikator"/>
										<aie:id value="166"/>
										<aie:status value="O"/>
										<aie:format value="n1"/>
										<aie:pcre value="\A1\Z"/>
										<aie:list value="A0035"/>
									</xs:documentation>
								</xs:annotation>
								<xs:simpleType>
									<xs:restriction base="xs:token">
										<xs:length value="1"/>
										<xs:enumeration value="1"/>
									</xs:restriction>
								</xs:simpleType>
							</xs:element>
							<xs:element name="MessageType" minOccurs="1" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="Typ"/>
										<aie:id value="167"/>
										<aie:status value="R"/>
										<aie:format value="a6"/>
										<aie:pcre value="\AFCFCRD\Z"/>
										<aie:list value="A0057"/>
									</xs:documentation>
								</xs:annotation>
								<xs:simpleType>
									<xs:restriction base="xs:token">
										<xs:length value="6"/>
										<xs:enumeration value="FCFCRD"/>
									</xs:restriction>
								</xs:simpleType>
							</xs:element>
							<xs:element name="InterchangeSender" minOccurs="1" maxOccurs="1" id="MST">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="NACHRICHTENSENDER"/>
										<aie:id value="241"/>
										<aie:status value="R"/>
									</xs:documentation>
								</xs:annotation>
								<xs:complexType>
									<xs:sequence>
										<xs:element name="Identification" minOccurs="1" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
												</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:sequence>
													<xs:element name="ReferenceNumber" minOccurs="1" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="TIN"/>
																<aie:id value="245"/>
																<aie:status value="R"/>
																<aie:format value="an..17"/>
																<aie:pcre value="\A[A-Z]{2}[\x21-\x7E]{1,15}\Z"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:minLength value="1"/>
																<xs:maxLength value="17"/>
																<xs:pattern value="[A-Z]{2}[&#x21;-&#x7E;]{1,15}"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="SubsidiaryNumber" minOccurs="1" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Niederlassungsnummer"/>
																<aie:id value="244"/>
																<aie:status value="R"/>
																<aie:format value="n4"/>
																<aie:pcre value="\A[0-9]{4}\Z"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:length value="4"/>
																<xs:pattern value="[0-9]{4}"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
												</xs:sequence>
											</xs:complexType>
										</xs:element>
									</xs:sequence>
								</xs:complexType>
							</xs:element>
							<xs:element name="InterchangeRecipient" minOccurs="1" maxOccurs="1" id="MED">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="NACHRICHTENEMPFÄNGER"/>
										<aie:id value="170"/>
										<aie:status value="R"/>
									</xs:documentation>
								</xs:annotation>
								<xs:complexType>
									<xs:sequence>
										<xs:element name="Identification" minOccurs="1" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Dienststellennummer"/>
													<aie:status value="R"/>
												</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:sequence>
													<xs:element name="ReferenceNumber" minOccurs="1" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:id value="173"/>
																<aie:format value="an8"/>
																<aie:pcre value="\ADE00[0-9]{4}\Z"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:length value="8"/>
																<xs:pattern value="DE00[0-9]{4}"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
												</xs:sequence>
											</xs:complexType>
										</xs:element>
									</xs:sequence>
								</xs:complexType>
							</xs:element>
						</xs:sequence>
					</xs:complexType>
				</xs:element>
				<xs:element name="Header" minOccurs="1" maxOccurs="1" id="HEA">
					<xs:annotation>
						<xs:documentation>
							<aie:name value="KOPF"/>
							<aie:id value="3647"/>
							<aie:status value="R"/>
						</xs:documentation>
					</xs:annotation>
					<xs:complexType>
						<xs:sequence>
							<xs:element name="MessageVersion" minOccurs="1" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="Nachrichtenversion"/>
										<aie:id value="89"/>
										<aie:status value="R"/>
										<aie:format value="an..7"/>
										<aie:pcre value="\AD\.[1-9][0-9]?\.[1-9]?[0-9]\Z"/>
									</xs:documentation>
								</xs:annotation>
								<xs:simpleType>
									<xs:restriction base="xs:token">
										<xs:minLength value="1"/>
										<xs:maxLength value="7"/>
										<xs:pattern value="D\.[1-9][0-9]?\.[1-9]?[0-9]"/>
									</xs:restriction>
								</xs:simpleType>
							</xs:element>
							<xs:element name="MessageCreationDate" minOccurs="1" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="Datum der Nachricht"/>
										<aie:id value="86"/>
										<aie:status value="R"/>
										<aie:format value="Date (n8)"/>
										<aie:pcre value="\A(?:(?:(?:0[48]|[2468][048]|[13579][26])(?:[02468][048]|[13579][26])|(?:[02468][1-35-79]|[13579][013-57-9])(?:0[48]|[2468][048]|[13579][26]))-02-29|[0-9][0-9][0-9][0-9]-(?:(?:0[13578]|1[02])-(?:0[1-9]|[12][0-9]|3[01])|(?:0[469]|11)-(?:0[1-9]|[12][0-9]|30)|02-(?:0[1-9]|1[0-9]|2[0-8])))\Z"/>
									</xs:documentation>
								</xs:annotation>
								<xs:simpleType>
									<xs:restriction base="xs:date">
									</xs:restriction>
								</xs:simpleType>
							</xs:element>
							<xs:element name="Declaration" minOccurs="1" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
									</xs:documentation>
								</xs:annotation>
								<xs:complexType>
									<xs:sequence>
										<xs:element name="Kind" minOccurs="1" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Anmeldeart"/>
													<aie:id value="11"/>
													<aie:status value="R"/>
													<aie:format value="an1"/>
													<aie:pcre value="\A(?:C|F)\Z"/>
													<aie:list value="A1025"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:length value="1"/>
													<xs:enumeration value="C"/>
													<xs:enumeration value="F"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="Type" minOccurs="1" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Art der Anmeldung"/>
													<aie:id value="14"/>
													<aie:status value="R"/>
													<aie:format value="an..3"/>
													<aie:pcre value="\A(?:VZA|AZ)\Z"/>
													<aie:list value="A1100"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:minLength value="2"/>
													<xs:maxLength value="3"/>
													<xs:enumeration value="VZA"/>
													<xs:enumeration value="AZ"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
									</xs:sequence>
								</xs:complexType>
							</xs:element>
							<xs:element name="LocalReferenceNumber" minOccurs="0" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="Bezugsnummer"/>
										<aie:id value="46"/>
										<aie:status value="O"/>
										<aie:format value="an..35"/>
										<aie:pcre value="\A.{1,35}\Z"/>
									</xs:documentation>
								</xs:annotation>
								<xs:simpleType>
									<xs:restriction base="xs:token">
										<xs:minLength value="1"/>
										<xs:maxLength value="35"/>
									</xs:restriction>
								</xs:simpleType>
							</xs:element>
							<xs:element name="LocalClearanceDate" minOccurs="0" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="Datum der Anschreibung"/>
										<aie:id value="21"/>
										<aie:status value="D"/>
										<aie:format value="Date (n8)"/>
										<aie:pcre value="\A(?:(?:(?:0[48]|[2468][048]|[13579][26])(?:[02468][048]|[13579][26])|(?:[02468][1-35-79]|[13579][013-57-9])(?:0[48]|[2468][048]|[13579][26]))-02-29|[0-9][0-9][0-9][0-9]-(?:(?:0[13578]|1[02])-(?:0[1-9]|[12][0-9]|3[01])|(?:0[469]|11)-(?:0[1-9]|[12][0-9]|30)|02-(?:0[1-9]|1[0-9]|2[0-8])))\Z"/>
									</xs:documentation>
								</xs:annotation>
								<xs:simpleType>
									<xs:restriction base="xs:date">
									</xs:restriction>
								</xs:simpleType>
							</xs:element>
							<xs:element name="PrematureInputFlag" minOccurs="1" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="Vorzeitige Eingabe"/>
										<aie:id value="135"/>
										<aie:status value="R"/>
										<aie:format value="an1"/>
										<aie:pcre value="\A.\Z"/>
										<aie:list value="A2040"/>
									</xs:documentation>
								</xs:annotation>
								<xs:simpleType>
									<xs:restriction base="xs:token">
										<xs:length value="1"/>
									</xs:restriction>
								</xs:simpleType>
							</xs:element>
							<xs:element name="GoodsItemQuantity" minOccurs="1" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="Anzahl Positionen"/>
										<aie:id value="94"/>
										<aie:status value="R"/>
										<aie:format value="n..3"/>
										<aie:pcre value="\A[1-9][0-9]{0,2}\Z"/>
									</xs:documentation>
								</xs:annotation>
								<xs:simpleType>
									<xs:restriction base="xs:integer">
										<xs:minInclusive value="1"/>
										<xs:maxInclusive value="999"/>
										<xs:totalDigits value="3"/>
										<xs:pattern value="[1-9][0-9]{0,2}"/>
									</xs:restriction>
								</xs:simpleType>
							</xs:element>
							<xs:element name="CustomsGoodsStatus" minOccurs="1" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="Zollrechtlicher Status"/>
										<aie:id value="47"/>
										<aie:status value="R"/>
										<aie:format value="an2"/>
										<aie:pcre value="\A.{2}\Z"/>
										<aie:list value="A2100"/>
									</xs:documentation>
								</xs:annotation>
								<xs:simpleType>
									<xs:restriction base="xs:token">
										<xs:length value="2"/>
									</xs:restriction>
								</xs:simpleType>
							</xs:element>
							<xs:element name="CustomsAuthorisation" minOccurs="1" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="Bewilligungsnummer"/>
										<aie:status value="R"/>
									</xs:documentation>
								</xs:annotation>
								<xs:complexType>
									<xs:sequence>
										<xs:element name="LocalClearanceProcedure" minOccurs="1" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Bewilligungsnummer (vereinfachtes Verfahren)"/>
													<aie:id value="45"/>
													<aie:status value="R"/>
													<aie:format value="an..35"/>
													<aie:pcre value="\A(?:[A-Z]{2}[0-9]{4}[A-Z][A-Z0-9][0-9]{1,4}|[A-Z]{2}.{1,4}.{1,29})\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:minLength value="1"/>
													<xs:maxLength value="35"/>
													<xs:pattern value="[A-Z]{2}[0-9]{4}[A-Z][A-Z0-9][0-9]{1,4}"/>
													<xs:pattern value="[A-Z]{2}.{1,4}.{1,29}"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="EndUse" minOccurs="0" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Bewilligungsnummer (Endverwendung)"/>
													<aie:id value="4160"/>
													<aie:status value="D"/>
													<aie:format value="an..35"/>
													<aie:pcre value="\A(?:[A-Z]{2}[0-9]{4}[A-Z][A-Z0-9][0-9]{1,4}|[A-Z]{2}.{1,4}.{1,29})\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:minLength value="1"/>
													<xs:maxLength value="35"/>
													<xs:pattern value="[A-Z]{2}[0-9]{4}[A-Z][A-Z0-9][0-9]{1,4}"/>
													<xs:pattern value="[A-Z]{2}.{1,4}.{1,29}"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
									</xs:sequence>
								</xs:complexType>
							</xs:element>
							<xs:element name="GoodsLocation" minOccurs="0" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="Warenort"/>
										<aie:id value="139"/>
										<aie:status value="O"/>
										<aie:format value="an..35"/>
										<aie:pcre value="\A.{1,35}\Z"/>
									</xs:documentation>
								</xs:annotation>
								<xs:simpleType>
									<xs:restriction base="xs:token">
										<xs:minLength value="1"/>
										<xs:maxLength value="35"/>
									</xs:restriction>
								</xs:simpleType>
							</xs:element>
							<xs:element name="DepartureCountry" minOccurs="1" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="Versendungsland"/>
										<aie:id value="130"/>
										<aie:status value="R"/>
										<aie:format value="an2"/>
										<aie:pcre value="\A.{2}\Z"/>
										<aie:list value="I0300"/>
									</xs:documentation>
								</xs:annotation>
								<xs:simpleType>
									<xs:restriction base="xs:token">
										<xs:length value="2"/>
									</xs:restriction>
								</xs:simpleType>
							</xs:element>
							<xs:element name="CurrencyCode" minOccurs="1" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="WKZ"/>
										<aie:id value="149"/>
										<aie:status value="R"/>
										<aie:format value="an3"/>
										<aie:pcre value="\AEUR\Z"/>
										<aie:list value="I0400"/>
									</xs:documentation>
								</xs:annotation>
								<xs:simpleType>
									<xs:restriction base="xs:token">
										<xs:length value="3"/>
										<xs:enumeration value="EUR"/>
									</xs:restriction>
								</xs:simpleType>
							</xs:element>
							<xs:element name="AdditionalInformation" minOccurs="0" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="Zusätzliche Angaben zur Anmeldung"/>
										<aie:id value="158"/>
										<aie:status value="O"/>
										<aie:format value="an..2000"/>
										<aie:pcre value="\A.{1,2000}\Z"/>
									</xs:documentation>
								</xs:annotation>
								<xs:simpleType>
									<xs:restriction base="xs:token">
										<xs:minLength value="1"/>
										<xs:maxLength value="2000"/>
									</xs:restriction>
								</xs:simpleType>
							</xs:element>
							<xs:element name="TaxNumber" minOccurs="0" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="USt-IdNr."/>
										<aie:id value="125"/>
										<aie:status value="D"/>
										<aie:format value="an..20"/>
										<aie:pcre value="\A(?:[A-Z]{2}.{1,12}|.{1,20})\Z"/>
										<aie:list value="A1835"/>
									</xs:documentation>
								</xs:annotation>
								<xs:simpleType>
									<xs:restriction base="xs:token">
										<xs:minLength value="1"/>
										<xs:maxLength value="20"/>
										<xs:pattern value="[A-Z]{2}.{1,12}"/>
										<xs:pattern value=".{1,20}"/>
									</xs:restriction>
								</xs:simpleType>
							</xs:element>
							<xs:element name="TaxOffice" minOccurs="0" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="Finanzamt"/>
										<aie:id value="66"/>
										<aie:status value="D"/>
										<aie:format value="an4"/>
										<aie:pcre value="\A.{4}\Z"/>
									</xs:documentation>
								</xs:annotation>
								<xs:simpleType>
									<xs:restriction base="xs:token">
										<xs:length value="4"/>
									</xs:restriction>
								</xs:simpleType>
							</xs:element>
							<xs:element name="RepresentativeRelationshipFlag" minOccurs="1" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="Kennzeichen Vertretungsverhältnis"/>
										<aie:id value="131"/>
										<aie:status value="R"/>
										<aie:format value="an1"/>
										<aie:pcre value="\A.\Z"/>
										<aie:list value="A1770"/>
									</xs:documentation>
								</xs:annotation>
								<xs:simpleType>
									<xs:restriction base="xs:token">
										<xs:length value="1"/>
									</xs:restriction>
								</xs:simpleType>
							</xs:element>
							<xs:element name="DeclarationPlace" minOccurs="1" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="Ausstellungsort"/>
										<aie:id value="17"/>
										<aie:status value="R"/>
										<aie:format value="an..35"/>
										<aie:pcre value="\A.{1,35}\Z"/>
									</xs:documentation>
								</xs:annotation>
								<xs:simpleType>
									<xs:restriction base="xs:token">
										<xs:minLength value="1"/>
										<xs:maxLength value="35"/>
									</xs:restriction>
								</xs:simpleType>
							</xs:element>
							<xs:element name="AuthorisationNumber" minOccurs="1" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="BIN"/>
										<aie:id value="48"/>
										<aie:status value="R"/>
										<aie:format value="an25"/>
										<aie:pcre value="\A.{25}\Z"/>
									</xs:documentation>
								</xs:annotation>
								<xs:simpleType>
									<xs:restriction base="xs:token">
										<xs:length value="25"/>
									</xs:restriction>
								</xs:simpleType>
							</xs:element>
						</xs:sequence>
					</xs:complexType>
				</xs:element>
				<xs:element name="Declarant" minOccurs="0" maxOccurs="1" id="DT0">
					<xs:annotation>
						<xs:documentation>
							<aie:name value="ANGABEN ZUM ANMELDER"/>
							<aie:id value="489"/>
							<aie:status value="D"/>
						</xs:documentation>
					</xs:annotation>
					<xs:complexType>
						<xs:sequence>
							<xs:element name="Identification" minOccurs="0" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
									</xs:documentation>
								</xs:annotation>
								<xs:complexType>
									<xs:sequence>
										<xs:element name="ReferenceNumber" minOccurs="0" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="TIN"/>
													<aie:id value="493"/>
													<aie:status value="D"/>
													<aie:format value="an..17"/>
													<aie:pcre value="\A[A-Z]{2}[\x21-\x7E]{1,15}\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:minLength value="1"/>
													<xs:maxLength value="17"/>
													<xs:pattern value="[A-Z]{2}[&#x21;-&#x7E;]{1,15}"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="SubsidiaryNumber" minOccurs="0" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Niederlassungsnummer"/>
													<aie:id value="492"/>
													<aie:status value="D"/>
													<aie:format value="n4"/>
													<aie:pcre value="\A[0-9]{4}\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:length value="4"/>
													<xs:pattern value="[0-9]{4}"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
									</xs:sequence>
								</xs:complexType>
							</xs:element>
							<xs:element name="Name" minOccurs="0" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="Name"/>
										<aie:id value="491"/>
										<aie:status value="D"/>
										<aie:format value="an..120"/>
										<aie:pcre value="\A.{1,120}\Z"/>
									</xs:documentation>
								</xs:annotation>
								<xs:simpleType>
									<xs:restriction base="xs:token">
										<xs:minLength value="1"/>
										<xs:maxLength value="120"/>
									</xs:restriction>
								</xs:simpleType>
							</xs:element>
							<xs:element name="Address" minOccurs="0" maxOccurs="1" id="DT1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="ANMELDER (ADRESSDATEN)"/>
										<aie:id value="494"/>
										<aie:status value="D"/>
									</xs:documentation>
								</xs:annotation>
								<xs:complexType>
									<xs:sequence>
										<xs:element name="Line" minOccurs="1" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Straße und Hausnummer"/>
													<aie:id value="500"/>
													<aie:status value="R"/>
													<aie:format value="an..35"/>
													<aie:pcre value="\A.{1,35}\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:minLength value="1"/>
													<xs:maxLength value="35"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="Country" minOccurs="1" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Land"/>
													<aie:id value="495"/>
													<aie:status value="R"/>
													<aie:format value="an2"/>
													<aie:pcre value="\A[A-Z]{2}\Z"/>
													<aie:list value="I0300"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:length value="2"/>
													<xs:pattern value="[A-Z]{2}"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="Postcode" minOccurs="0" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Postleitzahl"/>
													<aie:id value="499"/>
													<aie:status value="D"/>
													<aie:format value="an..9"/>
													<aie:pcre value="\A.{1,9}\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:minLength value="1"/>
													<xs:maxLength value="9"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="City" minOccurs="1" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Ort"/>
													<aie:id value="496"/>
													<aie:status value="R"/>
													<aie:format value="an..35"/>
													<aie:pcre value="\A.{1,35}\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:minLength value="1"/>
													<xs:maxLength value="35"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="District" minOccurs="0" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Ortsteil"/>
													<aie:id value="497"/>
													<aie:status value="O"/>
													<aie:format value="an..35"/>
													<aie:pcre value="\A.{1,35}\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:minLength value="1"/>
													<xs:maxLength value="35"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
									</xs:sequence>
								</xs:complexType>
							</xs:element>
						</xs:sequence>
					</xs:complexType>
				</xs:element>
				<xs:element name="Representative" minOccurs="0" maxOccurs="1" id="CB0">
					<xs:annotation>
						<xs:documentation>
							<aie:name value="ANGABEN ZUM VERTRETER"/>
							<aie:id value="1791"/>
							<aie:status value="D"/>
						</xs:documentation>
					</xs:annotation>
					<xs:complexType>
						<xs:sequence>
							<xs:element name="Identification" minOccurs="1" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
									</xs:documentation>
								</xs:annotation>
								<xs:complexType>
									<xs:sequence>
										<xs:element name="ReferenceNumber" minOccurs="1" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="TIN"/>
													<aie:id value="1795"/>
													<aie:status value="R"/>
													<aie:format value="an..17"/>
													<aie:pcre value="\A[A-Z]{2}[\x21-\x7E]{1,15}\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:minLength value="1"/>
													<xs:maxLength value="17"/>
													<xs:pattern value="[A-Z]{2}[&#x21;-&#x7E;]{1,15}"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="SubsidiaryNumber" minOccurs="0" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Niederlassungsnummer"/>
													<aie:id value="1794"/>
													<aie:status value="O"/>
													<aie:format value="n4"/>
													<aie:pcre value="\A[0-9]{4}\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:length value="4"/>
													<xs:pattern value="[0-9]{4}"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
									</xs:sequence>
								</xs:complexType>
							</xs:element>
						</xs:sequence>
					</xs:complexType>
				</xs:element>
				<xs:element name="Principal" minOccurs="0" maxOccurs="1" id="UH0">
					<xs:annotation>
						<xs:documentation>
							<aie:name value="ANGABEN ZUM VERTRETENEN (FÜR RECHNUNG)"/>
							<aie:id value="1768"/>
							<aie:status value="D"/>
						</xs:documentation>
					</xs:annotation>
					<xs:complexType>
						<xs:sequence>
							<xs:element name="Identification" minOccurs="0" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
									</xs:documentation>
								</xs:annotation>
								<xs:complexType>
									<xs:sequence>
										<xs:element name="ReferenceNumber" minOccurs="0" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="TIN"/>
													<aie:id value="1772"/>
													<aie:status value="D"/>
													<aie:format value="an..17"/>
													<aie:pcre value="\A[A-Z]{2}[\x21-\x7E]{1,15}\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:minLength value="1"/>
													<xs:maxLength value="17"/>
													<xs:pattern value="[A-Z]{2}[&#x21;-&#x7E;]{1,15}"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="SubsidiaryNumber" minOccurs="0" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Niederlassungsnummer"/>
													<aie:id value="1771"/>
													<aie:status value="D"/>
													<aie:format value="n4"/>
													<aie:pcre value="\A[0-9]{4}\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:length value="4"/>
													<xs:pattern value="[0-9]{4}"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
									</xs:sequence>
								</xs:complexType>
							</xs:element>
							<xs:element name="Name" minOccurs="0" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="Name"/>
										<aie:id value="1770"/>
										<aie:status value="D"/>
										<aie:format value="an..120"/>
										<aie:pcre value="\A.{1,120}\Z"/>
									</xs:documentation>
								</xs:annotation>
								<xs:simpleType>
									<xs:restriction base="xs:token">
										<xs:minLength value="1"/>
										<xs:maxLength value="120"/>
									</xs:restriction>
								</xs:simpleType>
							</xs:element>
							<xs:element name="Address" minOccurs="0" maxOccurs="1" id="UH1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="FÜR RECHNUNG (ADRESSDATEN)"/>
										<aie:id value="1773"/>
										<aie:status value="D"/>
									</xs:documentation>
								</xs:annotation>
								<xs:complexType>
									<xs:sequence>
										<xs:element name="Line" minOccurs="1" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Straße und Hausnummer"/>
													<aie:id value="1779"/>
													<aie:status value="R"/>
													<aie:format value="an..35"/>
													<aie:pcre value="\A.{1,35}\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:minLength value="1"/>
													<xs:maxLength value="35"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="Country" minOccurs="1" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Land"/>
													<aie:id value="1774"/>
													<aie:status value="R"/>
													<aie:format value="an2"/>
													<aie:pcre value="\A[A-Z]{2}\Z"/>
													<aie:list value="I0300"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:length value="2"/>
													<xs:pattern value="[A-Z]{2}"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="Postcode" minOccurs="0" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Postleitzahl"/>
													<aie:id value="1778"/>
													<aie:status value="D"/>
													<aie:format value="an..9"/>
													<aie:pcre value="\A.{1,9}\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:minLength value="1"/>
													<xs:maxLength value="9"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="City" minOccurs="1" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Ort"/>
													<aie:id value="1775"/>
													<aie:status value="R"/>
													<aie:format value="an..35"/>
													<aie:pcre value="\A.{1,35}\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:minLength value="1"/>
													<xs:maxLength value="35"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="District" minOccurs="0" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Ortsteil"/>
													<aie:id value="1776"/>
													<aie:status value="O"/>
													<aie:format value="an..35"/>
													<aie:pcre value="\A.{1,35}\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:minLength value="1"/>
													<xs:maxLength value="35"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
									</xs:sequence>
								</xs:complexType>
							</xs:element>
						</xs:sequence>
					</xs:complexType>
				</xs:element>
				<xs:element name="ContactPerson" minOccurs="1" maxOccurs="1" id="PK0">
					<xs:annotation>
						<xs:documentation>
							<aie:name value="ANGABEN ZUM ANSPRECHPARTNER FIRMA"/>
							<aie:id value="517"/>
							<aie:status value="R"/>
						</xs:documentation>
					</xs:annotation>
					<xs:complexType>
						<xs:sequence>
							<xs:element name="Name" minOccurs="1" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="Name"/>
										<aie:id value="520"/>
										<aie:status value="R"/>
										<aie:format value="an..35"/>
										<aie:pcre value="\A.{1,35}\Z"/>
									</xs:documentation>
								</xs:annotation>
								<xs:simpleType>
									<xs:restriction base="xs:token">
										<xs:minLength value="1"/>
										<xs:maxLength value="35"/>
									</xs:restriction>
								</xs:simpleType>
							</xs:element>
							<xs:element name="Position" minOccurs="1" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="Stellung in der Firma"/>
										<aie:id value="521"/>
										<aie:status value="R"/>
										<aie:format value="an..35"/>
										<aie:pcre value="\A.{1,35}\Z"/>
									</xs:documentation>
								</xs:annotation>
								<xs:simpleType>
									<xs:restriction base="xs:token">
										<xs:minLength value="1"/>
										<xs:maxLength value="35"/>
									</xs:restriction>
								</xs:simpleType>
							</xs:element>
							<xs:element name="PhoneNumber" minOccurs="1" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="Telefonnummer"/>
										<aie:id value="522"/>
										<aie:status value="R"/>
										<aie:format value="an..35"/>
										<aie:pcre value="\A.{1,35}\Z"/>
									</xs:documentation>
								</xs:annotation>
								<xs:simpleType>
									<xs:restriction base="xs:token">
										<xs:minLength value="1"/>
										<xs:maxLength value="35"/>
									</xs:restriction>
								</xs:simpleType>
							</xs:element>
							<xs:element name="MailAddress" minOccurs="0" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="E-Mail-Adresse"/>
										<aie:id value="518"/>
										<aie:status value="O"/>
										<aie:format value="an..256"/>
										<aie:pcre value="\A(?=.{1,256}\Z)[A-Za-z0-9!#$%&amp;&apos;*+/=?^_`{|}~-]+(?:\.[A-Za-z0-9!#$%&amp;&apos;*+/=?^_`{|}~-]+)*@(?:[A-Za-z0-9](?:[A-Za-z0-9-]*[A-Za-z0-9])?\.)+[A-Za-z0-9](?:[A-Za-z0-9-]*[A-Za-z0-9])?\Z"/>
									</xs:documentation>
								</xs:annotation>
								<xs:simpleType>
									<xs:restriction base="xs:token">
										<xs:minLength value="1"/>
										<xs:maxLength value="256"/>
										<xs:pattern value="[A-Za-z0-9!#$%&amp;&apos;*+/=?\^_`{|}~\-]+(\.[A-Za-z0-9!#$%&amp;&apos;*+/=?\^_`{|}~\-]+)*@([A-Za-z0-9]([A-Za-z0-9\-]*[A-Za-z0-9])?\.)+[A-Za-z0-9]([A-Za-z0-9\-]*[A-Za-z0-9])?"/>
									</xs:restriction>
								</xs:simpleType>
							</xs:element>
						</xs:sequence>
					</xs:complexType>
				</xs:element>
				<xs:element name="BorderTransportMeans" minOccurs="1" maxOccurs="1" id="BMG">
					<xs:annotation>
						<xs:documentation>
							<aie:name value="BEFÖRDERUNGSMITTEL AN DER GRENZE"/>
							<aie:id value="735"/>
							<aie:status value="R"/>
						</xs:documentation>
					</xs:annotation>
					<xs:complexType>
						<xs:sequence>
							<xs:element name="Mode" minOccurs="1" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="Verkehrszweig an der Grenze"/>
										<aie:id value="740"/>
										<aie:status value="R"/>
										<aie:format value="an1"/>
										<aie:pcre value="\A.\Z"/>
										<aie:list value="A1980"/>
									</xs:documentation>
								</xs:annotation>
								<xs:simpleType>
									<xs:restriction base="xs:token">
										<xs:length value="1"/>
									</xs:restriction>
								</xs:simpleType>
							</xs:element>
							<xs:element name="Type" minOccurs="1" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="Art des Beförderungsmittels an der Grenze"/>
										<aie:id value="736"/>
										<aie:status value="R"/>
										<aie:format value="an2"/>
										<aie:pcre value="\A.{2}\Z"/>
										<aie:list value="A1140"/>
									</xs:documentation>
								</xs:annotation>
								<xs:simpleType>
									<xs:restriction base="xs:token">
										<xs:length value="2"/>
									</xs:restriction>
								</xs:simpleType>
							</xs:element>
							<xs:element name="Information" minOccurs="0" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="Beschreibung des Beförderungsmittels"/>
										<aie:id value="738"/>
										<aie:status value="D"/>
										<aie:format value="an..17"/>
										<aie:pcre value="\A.{1,17}\Z"/>
									</xs:documentation>
								</xs:annotation>
								<xs:simpleType>
									<xs:restriction base="xs:token">
										<xs:minLength value="1"/>
										<xs:maxLength value="17"/>
									</xs:restriction>
								</xs:simpleType>
							</xs:element>
							<xs:element name="Nationality" minOccurs="0" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="Staatszugehörigkeit des Beförderungsmittels an der Grenze"/>
										<aie:id value="739"/>
										<aie:status value="D"/>
										<aie:format value="an2"/>
										<aie:pcre value="\A.{2}\Z"/>
										<aie:list value="I0300"/>
									</xs:documentation>
								</xs:annotation>
								<xs:simpleType>
									<xs:restriction base="xs:token">
										<xs:length value="2"/>
									</xs:restriction>
								</xs:simpleType>
							</xs:element>
						</xs:sequence>
					</xs:complexType>
				</xs:element>
				<xs:element name="ArrivalTransportMeans" minOccurs="0" maxOccurs="1" id="BMN">
					<xs:annotation>
						<xs:documentation>
							<aie:name value="BEFÖRDERUNGSMITTEL BEI ANKUNFT"/>
							<aie:id value="729"/>
							<aie:status value="D"/>
						</xs:documentation>
					</xs:annotation>
					<xs:complexType>
						<xs:sequence>
							<xs:element name="Identity" minOccurs="1" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="Kennzeichen/Name des Beförderungsmittels bei Ankunft"/>
										<aie:id value="731"/>
										<aie:status value="R"/>
										<aie:format value="an..30"/>
										<aie:pcre value="\A.{1,30}\Z"/>
									</xs:documentation>
								</xs:annotation>
								<xs:simpleType>
									<xs:restriction base="xs:token">
										<xs:minLength value="1"/>
										<xs:maxLength value="30"/>
									</xs:restriction>
								</xs:simpleType>
							</xs:element>
						</xs:sequence>
					</xs:complexType>
				</xs:element>
				<xs:element name="PreviousAdministrativeReferences" minOccurs="1" maxOccurs="1" id="DP0">
					<xs:annotation>
						<xs:documentation>
							<aie:name value="VORPAPIERE"/>
							<aie:id value="1838"/>
							<aie:status value="R"/>
						</xs:documentation>
					</xs:annotation>
					<xs:complexType>
						<xs:sequence>
							<xs:element name="Type" minOccurs="1" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="Vorpapierart"/>
										<aie:id value="1839"/>
										<aie:status value="R"/>
										<aie:format value="an..6"/>
										<aie:pcre value="\A(?:AT-AV|AT-ZL|ATA|ATNEU|ESUMA|GB|OHNE|POST|PUEB|T1|T2|TIR|VER321|VO)\Z"/>
										<aie:list value="A2020"/>
									</xs:documentation>
								</xs:annotation>
								<xs:simpleType>
									<xs:restriction base="xs:token">
										<xs:minLength value="1"/>
										<xs:maxLength value="6"/>
										<xs:pattern value="AT-AV"/>
										<xs:pattern value="AT-ZL"/>
										<xs:pattern value="ATA"/>
										<xs:pattern value="ATNEU"/>
										<xs:pattern value="ESUMA"/>
										<xs:pattern value="GB"/>
										<xs:pattern value="OHNE"/>
										<xs:pattern value="POST"/>
										<xs:pattern value="PUEB"/>
										<xs:pattern value="T1"/>
										<xs:pattern value="T2"/>
										<xs:pattern value="TIR"/>
										<xs:pattern value="VER321"/>
										<xs:pattern value="VO"/>
									</xs:restriction>
								</xs:simpleType>
							</xs:element>
							<xs:element name="PreviousAdministrativeReference" minOccurs="0" maxOccurs="1" id="DP1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="VORPAPIER"/>
										<aie:id value="1840"/>
										<aie:status value="D"/>
									</xs:documentation>
								</xs:annotation>
								<xs:complexType>
									<xs:sequence>
										<xs:element name="ReferenceNumber" minOccurs="1" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Vorpapiernummer"/>
													<aie:id value="1841"/>
													<aie:status value="R"/>
													<aie:format value="an..28"/>
													<aie:pcre value="\A.{1,28}\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:minLength value="1"/>
													<xs:maxLength value="28"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
									</xs:sequence>
								</xs:complexType>
							</xs:element>
						</xs:sequence>
					</xs:complexType>
				</xs:element>
				<xs:element name="SummaryDeclaration" minOccurs="0" maxOccurs="1" id="BSK">
					<xs:annotation>
						<xs:documentation>
							<aie:name value="BEENDIGUNGSANTEIL SUMA"/>
							<aie:id value="639"/>
							<aie:status value="D"/>
						</xs:documentation>
					</xs:annotation>
					<xs:complexType>
						<xs:sequence>
							<xs:element name="IdentificationIndicator" minOccurs="1" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="Art der Identifikation"/>
										<aie:id value="641"/>
										<aie:status value="R"/>
										<aie:format value="an..3"/>
										<aie:pcre value="\A(?:AWB|REG)\Z"/>
										<aie:list value="A1125"/>
									</xs:documentation>
								</xs:annotation>
								<xs:simpleType>
									<xs:restriction base="xs:token">
										<xs:length value="3"/>
										<xs:enumeration value="AWB"/>
										<xs:enumeration value="REG"/>
									</xs:restriction>
								</xs:simpleType>
							</xs:element>
							<xs:element name="GoodsItem" minOccurs="1" maxOccurs="999" id="BSP">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="POSITION (BE-ANTEIL SUMA)"/>
										<aie:id value="644"/>
										<aie:status value="R"/>
									</xs:documentation>
								</xs:annotation>
								<xs:complexType>
									<xs:sequence>
										<xs:element name="Quantity" minOccurs="1" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Stückzahl"/>
													<aie:id value="646"/>
													<aie:status value="R"/>
													<aie:format value="n..5"/>
													<aie:pcre value="\A[1-9][0-9]{0,4}\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:integer">
													<xs:minInclusive value="1"/>
													<xs:maxInclusive value="99999"/>
													<xs:totalDigits value="5"/>
													<xs:pattern value="[1-9][0-9]{0,4}"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="IdentificationByKey" minOccurs="0" maxOccurs="1" id="BSO">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="ORDNUNGSBEGRIFF BEZOGENE ERLEDIGUNG"/>
													<aie:id value="3650"/>
													<aie:status value="D"/>
												</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:sequence>
													<xs:element name="Kind" minOccurs="1" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Art SpO"/>
																<aie:id value="3655"/>
																<aie:status value="R"/>
																<aie:format value="an3"/>
																<aie:pcre value="\A(?:AWB|ULD)\Z"/>
																<aie:list value="A1180"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:length value="3"/>
																<xs:enumeration value="AWB"/>
																<xs:enumeration value="ULD"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="Number" minOccurs="1" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Spezifischer Ordnungsbegriff"/>
																<aie:id value="3654"/>
																<aie:status value="R"/>
																<aie:format value="an..44"/>
																<aie:pcre value="\A.{1,44}\Z"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:minLength value="1"/>
																<xs:maxLength value="44"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="Custodian" minOccurs="1" maxOccurs="1" id="BSV">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="ANGABEN ZUM VERWAHRER"/>
																<aie:id value="3658"/>
																<aie:status value="R"/>
															</xs:documentation>
														</xs:annotation>
														<xs:complexType>
															<xs:sequence>
																<xs:element name="Identification" minOccurs="1" maxOccurs="1">
																	<xs:annotation>
																		<xs:documentation>
																			<aie:name value="TIN"/>
																			<aie:status value="R"/>
																		</xs:documentation>
																	</xs:annotation>
																	<xs:complexType>
																		<xs:sequence>
																			<xs:element name="ReferenceNumber" minOccurs="1" maxOccurs="1">
																				<xs:annotation>
																					<xs:documentation>
																						<aie:id value="3662"/>
																						<aie:format value="an..17"/>
																						<aie:pcre value="\A(?:[A-Z]{2}[\x21-\x7E]{1,15}|0{17})\Z"/>
																					</xs:documentation>
																				</xs:annotation>
																				<xs:simpleType>
																					<xs:restriction base="xs:token">
																						<xs:minLength value="1"/>
																						<xs:maxLength value="17"/>
																						<xs:pattern value="[A-Z]{2}[&#x21;-&#x7E;]{1,15}"/>
																						<xs:pattern value="0{17}"/>
																					</xs:restriction>
																				</xs:simpleType>
																			</xs:element>
																		</xs:sequence>
																	</xs:complexType>
																</xs:element>
															</xs:sequence>
														</xs:complexType>
													</xs:element>
												</xs:sequence>
											</xs:complexType>
										</xs:element>
										<xs:element name="IdentificationByRegistration" minOccurs="0" maxOccurs="1" id="BSR">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="REGISTRIERNUMMER BEZOGENE ERLEDIGUNG"/>
													<aie:id value="3682"/>
													<aie:status value="D"/>
												</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:sequence>
													<xs:element name="ReferencedRegistrationNumber" minOccurs="1" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Registriernummer SumA"/>
																<aie:id value="3684"/>
																<aie:status value="R"/>
																<aie:format value="an21"/>
																<aie:pcre value="\AAT[A-Z][0-9]{2}[0-9]{6}(?:0[1-9]|1[0-2])20[0-9]{2}[0-9]{4}\Z"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:length value="21"/>
																<xs:pattern value="AT[A-Z][0-9]{2}[0-9]{6}(0[1-9]|1[0-2])20[0-9]{2}[0-9]{4}"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="ReferencedSequenceNumber" minOccurs="1" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Positionsnummer SumA"/>
																<aie:id value="3683"/>
																<aie:status value="R"/>
																<aie:format value="n..4"/>
																<aie:pcre value="\A[1-9][0-9]{0,3}\Z"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:integer">
																<xs:minInclusive value="1"/>
																<xs:maxInclusive value="9999"/>
																<xs:totalDigits value="4"/>
																<xs:pattern value="[1-9][0-9]{0,3}"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
												</xs:sequence>
											</xs:complexType>
										</xs:element>
									</xs:sequence>
								</xs:complexType>
							</xs:element>
						</xs:sequence>
					</xs:complexType>
				</xs:element>
				<xs:element name="CustomsWarehouse" minOccurs="0" maxOccurs="1" id="BLK">
					<xs:annotation>
						<xs:documentation>
							<aie:name value="BEENDIGUNGSANTEIL ZL"/>
							<aie:id value="677"/>
							<aie:status value="D"/>
						</xs:documentation>
					</xs:annotation>
					<xs:complexType>
						<xs:sequence>
							<xs:element name="SequenceNumber" minOccurs="1" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="Nummer"/>
										<aie:id value="681"/>
										<aie:status value="R"/>
										<aie:format value="n..5"/>
										<aie:pcre value="\A1\Z"/>
									</xs:documentation>
								</xs:annotation>
								<xs:simpleType>
									<xs:restriction base="xs:token">
										<xs:length value="1"/>
										<xs:enumeration value="1"/>
									</xs:restriction>
								</xs:simpleType>
							</xs:element>
							<xs:element name="GoodsItemQuantity" minOccurs="1" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="Anzahl Positionen"/>
										<aie:id value="682"/>
										<aie:status value="R"/>
										<aie:format value="n..3"/>
										<aie:pcre value="\A[1-9][0-9]{0,2}\Z"/>
									</xs:documentation>
								</xs:annotation>
								<xs:simpleType>
									<xs:restriction base="xs:integer">
										<xs:minInclusive value="1"/>
										<xs:maxInclusive value="999"/>
										<xs:totalDigits value="3"/>
										<xs:pattern value="[1-9][0-9]{0,2}"/>
									</xs:restriction>
								</xs:simpleType>
							</xs:element>
							<xs:element name="CustomsAuthorisation" minOccurs="1" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="Bewilligungsnummer"/>
										<aie:status value="R"/>
									</xs:documentation>
								</xs:annotation>
								<xs:complexType>
									<xs:sequence>
										<xs:element name="WarehouseOwner" minOccurs="1" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:id value="679"/>
													<aie:format value="an..35"/>
													<aie:pcre value="\A(?:[A-Z]{2}[0-9]{4}[A-Z][A-Z0-9][0-9]{1,4}|[A-Z]{2}.{1,4}.{1,29})\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:minLength value="1"/>
													<xs:maxLength value="35"/>
													<xs:pattern value="[A-Z]{2}[0-9]{4}[A-Z][A-Z0-9][0-9]{1,4}"/>
													<xs:pattern value="[A-Z]{2}.{1,4}.{1,29}"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
									</xs:sequence>
								</xs:complexType>
							</xs:element>
							<xs:element name="LocalReferenceNumber" minOccurs="0" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="Bezugsnummer"/>
										<aie:id value="680"/>
										<aie:status value="O"/>
										<aie:format value="an..35"/>
										<aie:pcre value="\A.{1,35}\Z"/>
									</xs:documentation>
								</xs:annotation>
								<xs:simpleType>
									<xs:restriction base="xs:token">
										<xs:minLength value="1"/>
										<xs:maxLength value="35"/>
									</xs:restriction>
								</xs:simpleType>
							</xs:element>
							<xs:element name="GoodsItem" minOccurs="1" maxOccurs="999" id="BLP">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="POSITION (BE-ANTEIL ZL)"/>
										<aie:id value="684"/>
										<aie:status value="R"/>
									</xs:documentation>
								</xs:annotation>
								<xs:complexType>
									<xs:sequence>
										<xs:element name="SequenceNumber" minOccurs="1" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Positionsnummer"/>
													<aie:id value="685"/>
													<aie:status value="R"/>
													<aie:format value="n..3"/>
													<aie:pcre value="\A[1-9][0-9]{0,2}\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:integer">
													<xs:minInclusive value="1"/>
													<xs:maxInclusive value="999"/>
													<xs:totalDigits value="3"/>
													<xs:pattern value="[1-9][0-9]{0,2}"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="ReferencedRegistrationNumber" minOccurs="1" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Registriernummer des Zugangs"/>
													<aie:id value="690"/>
													<aie:status value="R"/>
													<aie:format value="an..35"/>
													<aie:pcre value="\A.{1,35}\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:minLength value="1"/>
													<xs:maxLength value="35"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="ReferencedSequenceNumber" minOccurs="1" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Position des Zugangs"/>
													<aie:id value="689"/>
													<aie:status value="R"/>
													<aie:format value="n..5"/>
													<aie:pcre value="\A[1-9][0-9]{0,4}\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:integer">
													<xs:minInclusive value="1"/>
													<xs:maxInclusive value="99999"/>
													<xs:totalDigits value="5"/>
													<xs:pattern value="[1-9][0-9]{0,4}"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="AccessViaAtlasFlag" minOccurs="1" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Kennzeichen Zugang in ATLAS"/>
													<aie:id value="688"/>
													<aie:status value="R"/>
													<aie:format value="an1"/>
													<aie:pcre value="\A.\Z"/>
													<aie:list value="A1810"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:length value="1"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="CommodityCode" minOccurs="1" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Warennummer"/>
													<aie:id value="687"/>
													<aie:status value="R"/>
													<aie:format value="n11"/>
													<aie:pcre value="\A[0-9]{11}\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:length value="11"/>
													<xs:pattern value="[0-9]{11}"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="UsualProcessingFlag" minOccurs="1" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Kennzeichen Übliche Behandlung"/>
													<aie:id value="686"/>
													<aie:status value="R"/>
													<aie:format value="an1"/>
													<aie:pcre value="\A.\Z"/>
													<aie:list value="A1740"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:length value="1"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="Complement" minOccurs="0" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Positionszusatz"/>
													<aie:id value="691"/>
													<aie:status value="O"/>
													<aie:format value="an..100"/>
													<aie:pcre value="\A.{1,100}\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:minLength value="1"/>
													<xs:maxLength value="100"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="CommercialAmount" minOccurs="0" maxOccurs="1" id="BLH">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="ANGABEN ZUR HANDELSMENGE (BE-ANTEIL ZL)"/>
													<aie:id value="696"/>
													<aie:status value="D"/>
												</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:sequence>
													<xs:element name="Quantity" minOccurs="1" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Handelsmenge"/>
																<aie:id value="698"/>
																<aie:status value="R"/>
																<aie:format value="n..12 (12,3)"/>
																<aie:pcre value="\A(?!0\.?0*\Z)(?:0|[1-9][0-9]{0,8})(?:\.[0-9]{1,3})?\Z"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:decimal">
																<xs:minInclusive value="0.001"/>
																<xs:maxInclusive value="999999999.999"/>
																<xs:totalDigits value="12"/>
																<xs:fractionDigits value="3"/>
																<xs:pattern value="(0|[1-9][0-9]{0,8})(\.[0-9]{1,3})?"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="MeasurementUnit" minOccurs="1" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Maßeinheit (Handelsmenge)"/>
																<aie:id value="697"/>
																<aie:status value="R"/>
																<aie:format value="an3"/>
																<aie:pcre value="\A.{3}\Z"/>
																<aie:list value="I0700"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:length value="3"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="Qualifier" minOccurs="0" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Qualifikator (Handelsmenge)"/>
																<aie:id value="699"/>
																<aie:status value="D"/>
																<aie:format value="an1"/>
																<aie:pcre value="\A.\Z"/>
																<aie:list value="I0700"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:length value="1"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
												</xs:sequence>
											</xs:complexType>
										</xs:element>
										<xs:element name="DebitAmount" minOccurs="1" maxOccurs="1" id="BLA">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="ANGABEN ZUR ABGANGSMENGE (BE-ANTEIL ZL)"/>
													<aie:id value="692"/>
													<aie:status value="R"/>
												</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:sequence>
													<xs:element name="Quantity" minOccurs="1" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Abgangsmenge"/>
																<aie:id value="694"/>
																<aie:status value="R"/>
																<aie:format value="n..12 (12,3)"/>
																<aie:pcre value="\A(?!0\.?0*\Z)(?:0|[1-9][0-9]{0,8})(?:\.[0-9]{1,3})?\Z"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:decimal">
																<xs:minInclusive value="0.001"/>
																<xs:maxInclusive value="999999999.999"/>
																<xs:totalDigits value="12"/>
																<xs:fractionDigits value="3"/>
																<xs:pattern value="(0|[1-9][0-9]{0,8})(\.[0-9]{1,3})?"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="MeasurementUnit" minOccurs="1" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Maßeinheit (Abgangsmenge)"/>
																<aie:id value="693"/>
																<aie:status value="R"/>
																<aie:format value="an3"/>
																<aie:pcre value="\A.{3}\Z"/>
																<aie:list value="I0700"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:length value="3"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="Qualifier" minOccurs="0" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Qualifikator (Abgangsmenge)"/>
																<aie:id value="695"/>
																<aie:status value="D"/>
																<aie:format value="an1"/>
																<aie:pcre value="\A.\Z"/>
																<aie:list value="I0700"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:length value="1"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
												</xs:sequence>
											</xs:complexType>
										</xs:element>
									</xs:sequence>
								</xs:complexType>
							</xs:element>
						</xs:sequence>
					</xs:complexType>
				</xs:element>
				<xs:element name="InwardProcessing" minOccurs="0" maxOccurs="1" id="BVK">
					<xs:annotation>
						<xs:documentation>
							<aie:name value="BEENDIGUNGSANTEIL AV"/>
							<aie:id value="627"/>
							<aie:status value="D"/>
						</xs:documentation>
					</xs:annotation>
					<xs:complexType>
						<xs:sequence>
							<xs:element name="SequenceNumber" minOccurs="1" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="Nummer"/>
										<aie:id value="630"/>
										<aie:status value="R"/>
										<aie:format value="n..5"/>
										<aie:pcre value="\A1\Z"/>
									</xs:documentation>
								</xs:annotation>
								<xs:simpleType>
									<xs:restriction base="xs:token">
										<xs:length value="1"/>
										<xs:enumeration value="1"/>
									</xs:restriction>
								</xs:simpleType>
							</xs:element>
							<xs:element name="GoodsItemQuantity" minOccurs="1" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="Anzahl Positionen"/>
										<aie:id value="631"/>
										<aie:status value="R"/>
										<aie:format value="n..3"/>
										<aie:pcre value="\A[1-9][0-9]{0,2}\Z"/>
									</xs:documentation>
								</xs:annotation>
								<xs:simpleType>
									<xs:restriction base="xs:integer">
										<xs:minInclusive value="1"/>
										<xs:maxInclusive value="999"/>
										<xs:totalDigits value="3"/>
										<xs:pattern value="[1-9][0-9]{0,2}"/>
									</xs:restriction>
								</xs:simpleType>
							</xs:element>
							<xs:element name="CustomsAuthorisation" minOccurs="0" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="Bewilligungsnummer"/>
										<aie:status value="D"/>
									</xs:documentation>
								</xs:annotation>
								<xs:complexType>
									<xs:sequence>
										<xs:element name="ProcessingOwner" minOccurs="1" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:id value="629"/>
													<aie:format value="an..35"/>
													<aie:pcre value="\A(?:[A-Z]{2}[0-9]{4}[A-Z][A-Z0-9][0-9]{1,4}|[A-Z]{2}.{1,4}.{1,29})\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:minLength value="1"/>
													<xs:maxLength value="35"/>
													<xs:pattern value="[A-Z]{2}[0-9]{4}[A-Z][A-Z0-9][0-9]{1,4}"/>
													<xs:pattern value="[A-Z]{2}.{1,4}.{1,29}"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
									</xs:sequence>
								</xs:complexType>
							</xs:element>
							<xs:element name="SimplifiedGrantAuthorisationFlag" minOccurs="1" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="Kennzeichen Vereinfachter Bewilligungsantrag AV (BE-Anteil AV)"/>
										<aie:id value="4306"/>
										<aie:status value="R"/>
										<aie:format value="a1"/>
										<aie:pcre value="\A\D\Z"/>
										<aie:list value="A1765"/>
									</xs:documentation>
								</xs:annotation>
								<xs:simpleType>
									<xs:restriction base="xs:token">
										<xs:length value="1"/>
										<xs:pattern value="[^0-9]"/>
									</xs:restriction>
								</xs:simpleType>
							</xs:element>
							<xs:element name="MonitoringCustomsOffice" minOccurs="0" maxOccurs="1" id="HAD">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="ANGABEN ZUR ÜBERWACHUNGSZOLLSTELLE AV (BE-ANTEIL AV)"/>
										<aie:id value="4307"/>
										<aie:status value="D"/>
									</xs:documentation>
								</xs:annotation>
								<xs:complexType>
									<xs:sequence>
										<xs:element name="Identification" minOccurs="1" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Dienststellennummer"/>
													<aie:status value="R"/>
												</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:sequence>
													<xs:element name="ReferenceNumber" minOccurs="1" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:id value="4308"/>
																<aie:format value="an8"/>
																<aie:pcre value="\ADE00[0-9]{4}\Z"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:length value="8"/>
																<xs:pattern value="DE00[0-9]{4}"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
												</xs:sequence>
											</xs:complexType>
										</xs:element>
									</xs:sequence>
								</xs:complexType>
							</xs:element>
							<xs:element name="GoodsItem" minOccurs="1" maxOccurs="999" id="BVP">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="POSITION (BE-ANTEIL AV)"/>
										<aie:id value="633"/>
										<aie:status value="R"/>
									</xs:documentation>
								</xs:annotation>
								<xs:complexType>
									<xs:sequence>
										<xs:element name="SequenceNumber" minOccurs="1" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Positionsnummer"/>
													<aie:id value="634"/>
													<aie:status value="R"/>
													<aie:format value="n..3"/>
													<aie:pcre value="\A[1-9][0-9]{0,2}\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:integer">
													<xs:minInclusive value="1"/>
													<xs:maxInclusive value="999"/>
													<xs:totalDigits value="3"/>
													<xs:pattern value="[1-9][0-9]{0,2}"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="ReferencedRegistrationNumber" minOccurs="1" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Registriernummer des Zugangs"/>
													<aie:id value="638"/>
													<aie:status value="R"/>
													<aie:format value="an..35"/>
													<aie:pcre value="\A.{1,35}\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:minLength value="1"/>
													<xs:maxLength value="35"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="ReferencedSequenceNumber" minOccurs="1" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Position des Zugangs"/>
													<aie:id value="637"/>
													<aie:status value="R"/>
													<aie:format value="n..5"/>
													<aie:pcre value="\A[1-9][0-9]{0,4}\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:integer">
													<xs:minInclusive value="1"/>
													<xs:maxInclusive value="99999"/>
													<xs:totalDigits value="5"/>
													<xs:pattern value="[1-9][0-9]{0,4}"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="AccessViaAtlasFlag" minOccurs="1" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Kennzeichen Zugang in ATLAS"/>
													<aie:id value="636"/>
													<aie:status value="R"/>
													<aie:format value="an1"/>
													<aie:pcre value="\A.\Z"/>
													<aie:list value="A1810"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:length value="1"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="GoodsRelatedInformation" minOccurs="1" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Warenbezogene Angaben"/>
													<aie:id value="635"/>
													<aie:status value="R"/>
													<aie:format value="an..350"/>
													<aie:pcre value="\A.{1,350}\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:minLength value="1"/>
													<xs:maxLength value="350"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
									</xs:sequence>
								</xs:complexType>
							</xs:element>
						</xs:sequence>
					</xs:complexType>
				</xs:element>
				<xs:element name="Body" minOccurs="1" maxOccurs="1" id="BDY">
					<xs:annotation>
						<xs:documentation>
							<aie:name value="RUMPF"/>
							<aie:id value="2040"/>
							<aie:status value="R"/>
						</xs:documentation>
					</xs:annotation>
					<xs:complexType>
						<xs:sequence>
							<xs:element name="Consignee" minOccurs="1" maxOccurs="1" id="CE1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="ANGABEN ZUM EMPFÄNGER"/>
										<aie:id value="2091"/>
										<aie:status value="R"/>
									</xs:documentation>
								</xs:annotation>
								<xs:complexType>
									<xs:sequence>
										<xs:element name="Identification" minOccurs="0" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
												</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:sequence>
													<xs:element name="ReferenceNumber" minOccurs="0" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="TIN"/>
																<aie:id value="2095"/>
																<aie:status value="D"/>
																<aie:format value="an..17"/>
																<aie:pcre value="\A[A-Z]{2}[\x21-\x7E]{1,15}\Z"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:minLength value="1"/>
																<xs:maxLength value="17"/>
																<xs:pattern value="[A-Z]{2}[&#x21;-&#x7E;]{1,15}"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="SubsidiaryNumber" minOccurs="0" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Niederlassungsnummer"/>
																<aie:id value="2094"/>
																<aie:status value="D"/>
																<aie:format value="n4"/>
																<aie:pcre value="\A[0-9]{4}\Z"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:length value="4"/>
																<xs:pattern value="[0-9]{4}"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
												</xs:sequence>
											</xs:complexType>
										</xs:element>
										<xs:element name="Name" minOccurs="0" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Name"/>
													<aie:id value="2093"/>
													<aie:status value="D"/>
													<aie:format value="an..120"/>
													<aie:pcre value="\A.{1,120}\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:minLength value="1"/>
													<xs:maxLength value="120"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="Address" minOccurs="0" maxOccurs="1" id="CEA">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="EMPFÄNGER (ADRESSDATEN)"/>
													<aie:id value="2096"/>
													<aie:status value="D"/>
												</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:sequence>
													<xs:element name="Line" minOccurs="1" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Straße und Hausnummer"/>
																<aie:id value="2102"/>
																<aie:status value="R"/>
																<aie:format value="an..35"/>
																<aie:pcre value="\A.{1,35}\Z"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:minLength value="1"/>
																<xs:maxLength value="35"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="Country" minOccurs="1" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Land"/>
																<aie:id value="2097"/>
																<aie:status value="R"/>
																<aie:format value="an2"/>
																<aie:pcre value="\A[A-Z]{2}\Z"/>
																<aie:list value="I0300"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:length value="2"/>
																<xs:pattern value="[A-Z]{2}"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="Postcode" minOccurs="0" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Postleitzahl"/>
																<aie:id value="2101"/>
																<aie:status value="D"/>
																<aie:format value="an..9"/>
																<aie:pcre value="\A.{1,9}\Z"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:minLength value="1"/>
																<xs:maxLength value="9"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="City" minOccurs="1" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Ort"/>
																<aie:id value="2098"/>
																<aie:status value="R"/>
																<aie:format value="an..35"/>
																<aie:pcre value="\A.{1,35}\Z"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:minLength value="1"/>
																<xs:maxLength value="35"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="District" minOccurs="0" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Ortsteil"/>
																<aie:id value="2099"/>
																<aie:status value="O"/>
																<aie:format value="an..35"/>
																<aie:pcre value="\A.{1,35}\Z"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:minLength value="1"/>
																<xs:maxLength value="35"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
												</xs:sequence>
											</xs:complexType>
										</xs:element>
									</xs:sequence>
								</xs:complexType>
							</xs:element>
							<xs:element name="Acquirer" minOccurs="0" maxOccurs="1" id="UC0">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="ANGABEN ZUM ERWERBER IM ANDEREN MITGLIEDSTAAT"/>
										<aie:id value="2114"/>
										<aie:status value="D"/>
									</xs:documentation>
								</xs:annotation>
								<xs:complexType>
									<xs:sequence>
										<xs:element name="Identification" minOccurs="0" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
												</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:sequence>
													<xs:element name="ReferenceNumber" minOccurs="0" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="TIN"/>
																<aie:id value="2118"/>
																<aie:status value="D"/>
																<aie:format value="an..17"/>
																<aie:pcre value="\A[A-Z]{2}[\x21-\x7E]{1,15}\Z"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:minLength value="1"/>
																<xs:maxLength value="17"/>
																<xs:pattern value="[A-Z]{2}[&#x21;-&#x7E;]{1,15}"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="SubsidiaryNumber" minOccurs="0" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Niederlassungsnummer"/>
																<aie:id value="2117"/>
																<aie:status value="D"/>
																<aie:format value="n4"/>
																<aie:pcre value="\A[0-9]{4}\Z"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:length value="4"/>
																<xs:pattern value="[0-9]{4}"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
												</xs:sequence>
											</xs:complexType>
										</xs:element>
										<xs:element name="Name" minOccurs="0" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Name"/>
													<aie:id value="2116"/>
													<aie:status value="D"/>
													<aie:format value="an..120"/>
													<aie:pcre value="\A.{1,120}\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:minLength value="1"/>
													<xs:maxLength value="120"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="TaxNumber" minOccurs="1" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="USt-IdNr."/>
													<aie:id value="2137"/>
													<aie:status value="R"/>
													<aie:format value="an..20"/>
													<aie:pcre value="\A[A-Z]{2}.{1,12}\Z"/>
													<aie:list value="A1835"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:minLength value="1"/>
													<xs:maxLength value="20"/>
													<xs:pattern value="[A-Z]{2}.{1,12}"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="Address" minOccurs="0" maxOccurs="1" id="UC1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="ERWERBER (ADRESSDATEN)"/>
													<aie:id value="2119"/>
													<aie:status value="D"/>
												</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:sequence>
													<xs:element name="Line" minOccurs="1" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Straße und Hausnummer"/>
																<aie:id value="2125"/>
																<aie:status value="R"/>
																<aie:format value="an..35"/>
																<aie:pcre value="\A.{1,35}\Z"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:minLength value="1"/>
																<xs:maxLength value="35"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="Country" minOccurs="1" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Land"/>
																<aie:id value="2120"/>
																<aie:status value="R"/>
																<aie:format value="an2"/>
																<aie:pcre value="\A[A-Z]{2}\Z"/>
																<aie:list value="I0300"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:length value="2"/>
																<xs:pattern value="[A-Z]{2}"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="Postcode" minOccurs="0" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Postleitzahl"/>
																<aie:id value="2124"/>
																<aie:status value="D"/>
																<aie:format value="an..9"/>
																<aie:pcre value="\A.{1,9}\Z"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:minLength value="1"/>
																<xs:maxLength value="9"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="City" minOccurs="1" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Ort"/>
																<aie:id value="2121"/>
																<aie:status value="R"/>
																<aie:format value="an..35"/>
																<aie:pcre value="\A.{1,35}\Z"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:minLength value="1"/>
																<xs:maxLength value="35"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="District" minOccurs="0" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Ortsteil"/>
																<aie:id value="2122"/>
																<aie:status value="O"/>
																<aie:format value="an..35"/>
																<aie:pcre value="\A.{1,35}\Z"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:minLength value="1"/>
																<xs:maxLength value="35"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
												</xs:sequence>
											</xs:complexType>
										</xs:element>
									</xs:sequence>
								</xs:complexType>
							</xs:element>
							<xs:element name="Containers" minOccurs="1" maxOccurs="1" id="KC0">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="ANGABEN ZU CONTAINERN"/>
										<aie:id value="2086"/>
										<aie:status value="R"/>
									</xs:documentation>
								</xs:annotation>
								<xs:complexType>
									<xs:sequence>
										<xs:element name="ContainerFlag" minOccurs="1" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Kennzeichen Container"/>
													<aie:id value="2088"/>
													<aie:status value="R"/>
													<aie:format value="an1"/>
													<aie:pcre value="\A.\Z"/>
													<aie:list value="A1450"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:length value="1"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="Container" minOccurs="0" maxOccurs="9" id="KC1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="ANGABEN ZU CONTAINERNUMMERN"/>
													<aie:id value="2089"/>
													<aie:status value="D"/>
												</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:sequence>
													<xs:element name="IdentificationNumber" minOccurs="1" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Container-Nummer"/>
																<aie:id value="2090"/>
																<aie:status value="R"/>
																<aie:format value="an..11"/>
																<aie:pcre value="\A.{1,11}\Z"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:minLength value="1"/>
																<xs:maxLength value="11"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
												</xs:sequence>
											</xs:complexType>
										</xs:element>
									</xs:sequence>
								</xs:complexType>
							</xs:element>
							<xs:element name="ForeignTradeStatistics" minOccurs="0" maxOccurs="1" id="RAS">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="DATEN FÜR DIE AUSSENHANDELSSTATISTIK (KOPF)"/>
										<aie:id value="2043"/>
										<aie:status value="D"/>
									</xs:documentation>
								</xs:annotation>
								<xs:complexType>
									<xs:sequence>
										<xs:element name="InlandTransportMode" minOccurs="0" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Verkehrszweig im Inland"/>
													<aie:id value="2050"/>
													<aie:status value="O"/>
													<aie:format value="an1"/>
													<aie:pcre value="\A.\Z"/>
													<aie:list value="A1990"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:length value="1"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="TotalGrossMassMeasure" minOccurs="0" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Rohmasse-Gesamt"/>
													<aie:id value="2047"/>
													<aie:status value="D"/>
													<aie:format value="n..10 (10,1)"/>
													<aie:pcre value="\A(?!0\.?0*\Z)(?:0|[1-9][0-9]{0,8})(?:\.[0-9])?\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:decimal">
													<xs:minInclusive value="0.1"/>
													<xs:maxInclusive value="999999999.9"/>
													<xs:totalDigits value="10"/>
													<xs:fractionDigits value="1"/>
													<xs:pattern value="(0|[1-9][0-9]{0,8})(\.[0-9])?"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
									</xs:sequence>
								</xs:complexType>
							</xs:element>
							<xs:element name="Document" minOccurs="0" maxOccurs="20" id="RUX">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="VORGELEGTE UNTERLAGEN ZU EINER ANMELDUNG"/>
										<aie:id value="2143"/>
										<aie:status value="O"/>
									</xs:documentation>
								</xs:annotation>
								<xs:complexType>
									<xs:sequence>
										<xs:element name="Division" minOccurs="1" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Bereich der Unterlage (Anmeldung)"/>
													<aie:id value="2146"/>
													<aie:status value="R"/>
													<aie:format value="an1"/>
													<aie:pcre value="\A4\Z"/>
													<aie:list value="A1255"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:length value="1"/>
													<xs:enumeration value="4"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="Type" minOccurs="1" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Art der Unterlage (Anmeldung)"/>
													<aie:id value="2152"/>
													<aie:status value="R"/>
													<aie:format value="an4"/>
													<aie:pcre value="\A.{4}\Z"/>
													<aie:list value="I0200"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:length value="4"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="ReferenceNumber" minOccurs="1" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Nummer vorgelegte Unterlage"/>
													<aie:id value="2151"/>
													<aie:status value="R"/>
													<aie:format value="an..35"/>
													<aie:pcre value="\A.{1,35}\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:minLength value="1"/>
													<xs:maxLength value="35"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="IssuingDate" minOccurs="1" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Datum vorgelegte Unterlage"/>
													<aie:id value="2147"/>
													<aie:status value="R"/>
													<aie:format value="Date (n8)"/>
													<aie:pcre value="\A(?:(?:(?:0[48]|[2468][048]|[13579][26])(?:[02468][048]|[13579][26])|(?:[02468][1-35-79]|[13579][013-57-9])(?:0[48]|[2468][048]|[13579][26]))-02-29|[0-9][0-9][0-9][0-9]-(?:(?:0[13578]|1[02])-(?:0[1-9]|[12][0-9]|3[01])|(?:0[469]|11)-(?:0[1-9]|[12][0-9]|30)|02-(?:0[1-9]|1[0-9]|2[0-8])))\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:date">
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
									</xs:sequence>
								</xs:complexType>
							</xs:element>
							<xs:element name="GoodsItem" minOccurs="1" maxOccurs="999" id="GDS">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="POSITION"/>
										<aie:id value="2306"/>
										<aie:status value="R"/>
									</xs:documentation>
								</xs:annotation>
								<xs:complexType>
									<xs:sequence>
										<xs:element name="SequenceNumber" minOccurs="1" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Positionsnummer"/>
													<aie:id value="2356"/>
													<aie:status value="R"/>
													<aie:format value="n..3"/>
													<aie:pcre value="\A[1-9][0-9]{0,2}\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:integer">
													<xs:minInclusive value="1"/>
													<xs:maxInclusive value="999"/>
													<xs:totalDigits value="3"/>
													<xs:pattern value="[1-9][0-9]{0,2}"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="Procedure" minOccurs="1" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Verfahrenscode"/>
													<aie:status value="R"/>
												</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:sequence>
													<xs:element name="RequestedPreviousProcedure" minOccurs="1" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:id value="2377"/>
																<aie:format value="an4"/>
																<aie:pcre value="\A.{4}\Z"/>
																<aie:list value="I0100"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:length value="4"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
												</xs:sequence>
											</xs:complexType>
										</xs:element>
										<xs:element name="CessionManagementFlag" minOccurs="0" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Kennzeichen Abgabensteuerung"/>
													<aie:id value="2307"/>
													<aie:status value="D"/>
													<aie:format value="an2"/>
													<aie:pcre value="\A.{2}\Z"/>
													<aie:list value="A1345"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:length value="2"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="GoodsDescription" minOccurs="1" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Warenbezeichnung"/>
													<aie:id value="2386"/>
													<aie:status value="R"/>
													<aie:format value="an..240"/>
													<aie:pcre value="\A.{1,240}\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:minLength value="1"/>
													<xs:maxLength value="240"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="NetMassMeasure" minOccurs="1" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Eigenmasse"/>
													<aie:id value="2335"/>
													<aie:status value="R"/>
													<aie:format value="n..10 (10,1)"/>
													<aie:pcre value="\A(?:0|[1-9][0-9]{0,8})(?:\.[0-9])?\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:decimal">
													<xs:minInclusive value="0.0"/>
													<xs:maxInclusive value="999999999.9"/>
													<xs:totalDigits value="10"/>
													<xs:fractionDigits value="1"/>
													<xs:pattern value="(0|[1-9][0-9]{0,8})(\.[0-9])?"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="OriginCountry" minOccurs="1" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Ursprungsland"/>
													<aie:id value="2376"/>
													<aie:status value="R"/>
													<aie:format value="an2"/>
													<aie:pcre value="\A.{2}\Z"/>
													<aie:list value="I0300"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:length value="2"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="SupplementaryInformation" minOccurs="0" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Positionszusatz"/>
													<aie:id value="2358"/>
													<aie:status value="O"/>
													<aie:format value="an..100"/>
													<aie:pcre value="\A.{1,100}\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:minLength value="1"/>
													<xs:maxLength value="100"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="TobaccoRevenueStampNumber" minOccurs="0" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Tabaksteuerzeichen-Nummer"/>
													<aie:id value="2370"/>
													<aie:status value="D"/>
													<aie:format value="an5"/>
													<aie:pcre value="\A.{5}\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:length value="5"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="CommodityCode" minOccurs="1" maxOccurs="1" id="COM">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="ANGABE WARENNUMMER"/>
													<aie:id value="3247"/>
													<aie:status value="R"/>
												</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:sequence>
													<xs:element name="CommodityCode" minOccurs="1" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Warennummer"/>
																<aie:id value="3248"/>
																<aie:status value="R"/>
																<aie:format value="an11"/>
																<aie:pcre value="\A.{11}\Z"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:length value="11"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
												</xs:sequence>
											</xs:complexType>
										</xs:element>
										<xs:element name="AdditionalProcedure" minOccurs="0" maxOccurs="99" id="ADL">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="ANGABEN ZU EU-CODES"/>
													<aie:id value="4945"/>
													<aie:status value="O"/>
												</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:sequence>
													<xs:element name="Code" minOccurs="1" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="EU-Code"/>
																<aie:id value="4946"/>
																<aie:status value="R"/>
																<aie:format value="an3"/>
																<aie:pcre value="\A.{3}\Z"/>
																<aie:list value="I0100"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:length value="3"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
												</xs:sequence>
											</xs:complexType>
										</xs:element>
										<xs:element name="SupplementaryCodes" minOccurs="0" maxOccurs="10" id="PZC">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="ANGABEN ZU ZUSATZCODES"/>
													<aie:id value="3316"/>
													<aie:status value="D"/>
												</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:sequence>
													<xs:element name="Code" minOccurs="1" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Zusatzcode"/>
																<aie:id value="3317"/>
																<aie:status value="R"/>
																<aie:format value="an4"/>
																<aie:pcre value="\A.{4}\Z"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:length value="4"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
												</xs:sequence>
											</xs:complexType>
										</xs:element>
										<xs:element name="Package" minOccurs="0" maxOccurs="1" id="GS2">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="PACKSTÜCKE"/>
													<aie:id value="2965"/>
													<aie:status value="D"/>
												</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:sequence>
													<xs:element name="Kind" minOccurs="1" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Art der Packstücke"/>
																<aie:id value="2967"/>
																<aie:status value="R"/>
																<aie:format value="an2"/>
																<aie:pcre value="\A.{2}\Z"/>
																<aie:list value="A1160"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:length value="2"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="Quantity" minOccurs="0" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Packstücke-Anzahl"/>
																<aie:id value="2966"/>
																<aie:status value="D"/>
																<aie:format value="n..5"/>
																<aie:pcre value="\A[1-9][0-9]{0,4}\Z"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:integer">
																<xs:minInclusive value="1"/>
																<xs:maxInclusive value="99999"/>
																<xs:totalDigits value="5"/>
																<xs:pattern value="[1-9][0-9]{0,4}"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="MarksNumbers" minOccurs="0" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Packstücke-Zeichen und Nummern"/>
																<aie:id value="2968"/>
																<aie:status value="D"/>
																<aie:format value="an..70"/>
																<aie:pcre value="\A.{1,70}\Z"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:minLength value="1"/>
																<xs:maxLength value="70"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
												</xs:sequence>
											</xs:complexType>
										</xs:element>
										<xs:element name="ForeignTradeStatistics" minOccurs="0" maxOccurs="1" id="PAS">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="DATEN FÜR DIE AUSSENHANDELSSTATISTIK (POSITION)"/>
													<aie:id value="2561"/>
													<aie:status value="D"/>
												</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:sequence>
													<xs:element name="GrossMassMeasure" minOccurs="1" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Rohmasse-Position"/>
																<aie:id value="2565"/>
																<aie:status value="R"/>
																<aie:format value="n..10 (10,1)"/>
																<aie:pcre value="\A(?!0\.?0*\Z)(?:0|[1-9][0-9]{0,8})(?:\.[0-9])?\Z"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:decimal">
																<xs:minInclusive value="0.1"/>
																<xs:maxInclusive value="999999999.9"/>
																<xs:totalDigits value="10"/>
																<xs:fractionDigits value="1"/>
																<xs:pattern value="(0|[1-9][0-9]{0,8})(\.[0-9])?"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
												</xs:sequence>
											</xs:complexType>
										</xs:element>
										<xs:element name="Assessment" minOccurs="0" maxOccurs="1" id="PBX">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="BEMESSUNGSDATEN (OHNE VERBRAUCHSTEUER)"/>
													<aie:id value="2695"/>
													<aie:status value="D"/>
												</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:sequence>
													<xs:element name="CustomsValue" minOccurs="0" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Zollwert"/>
																<aie:id value="2699"/>
																<aie:status value="D"/>
																<aie:format value="n..11 (11,2)"/>
																<aie:pcre value="\A(?!0\.?0*\Z)(?:0|[1-9][0-9]{0,8})(?:\.[0-9]{1,2})?\Z"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:decimal">
																<xs:minInclusive value="0.01"/>
																<xs:maxInclusive value="999999999.99"/>
																<xs:totalDigits value="11"/>
																<xs:fractionDigits value="2"/>
																<xs:pattern value="(0|[1-9][0-9]{0,8})(\.[0-9]{1,2})?"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="Amount" minOccurs="0" maxOccurs="5" id="PBZ">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="ANGABEN ZUR ZOLLMENGE"/>
																<aie:id value="2706"/>
																<aie:status value="D"/>
															</xs:documentation>
														</xs:annotation>
														<xs:complexType>
															<xs:sequence>
																<xs:element name="Quantity" minOccurs="1" maxOccurs="1">
																	<xs:annotation>
																		<xs:documentation>
																			<aie:name value="Zollmenge"/>
																			<aie:id value="2708"/>
																			<aie:status value="R"/>
																			<aie:format value="n..12 (12,3)"/>
																			<aie:pcre value="\A(?!0\.?0*\Z)(?:0|[1-9][0-9]{0,8})(?:\.[0-9]{1,3})?\Z"/>
																		</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:decimal">
																			<xs:minInclusive value="0.001"/>
																			<xs:maxInclusive value="999999999.999"/>
																			<xs:totalDigits value="12"/>
																			<xs:fractionDigits value="3"/>
																			<xs:pattern value="(0|[1-9][0-9]{0,8})(\.[0-9]{1,3})?"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
																<xs:element name="MeasurementUnit" minOccurs="1" maxOccurs="1">
																	<xs:annotation>
																		<xs:documentation>
																			<aie:name value="Maßeinheit (Zollmenge)"/>
																			<aie:id value="2707"/>
																			<aie:status value="R"/>
																			<aie:format value="an3"/>
																			<aie:pcre value="\A.{3}\Z"/>
																			<aie:list value="I0700"/>
																		</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:token">
																			<xs:length value="3"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
																<xs:element name="Qualifier" minOccurs="0" maxOccurs="1">
																	<xs:annotation>
																		<xs:documentation>
																			<aie:name value="Qualifikator (Zollmenge)"/>
																			<aie:id value="2709"/>
																			<aie:status value="D"/>
																			<aie:format value="an1"/>
																			<aie:pcre value="\A.\Z"/>
																			<aie:list value="I0700"/>
																		</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:token">
																			<xs:length value="1"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
															</xs:sequence>
														</xs:complexType>
													</xs:element>
													<xs:element name="SpecificRate" minOccurs="0" maxOccurs="5" id="PBW">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="BESONDERE WERTANGABEN"/>
																<aie:id value="2700"/>
																<aie:status value="D"/>
															</xs:documentation>
														</xs:annotation>
														<xs:complexType>
															<xs:sequence>
																<xs:element name="Type" minOccurs="1" maxOccurs="1">
																	<xs:annotation>
																		<xs:documentation>
																			<aie:name value="Preisart"/>
																			<aie:id value="2701"/>
																			<aie:status value="R"/>
																			<aie:format value="an1"/>
																			<aie:pcre value="\A.\Z"/>
																			<aie:list value="A1880"/>
																		</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:token">
																			<xs:length value="1"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
																<xs:element name="Value" minOccurs="1" maxOccurs="1">
																	<xs:annotation>
																		<xs:documentation>
																			<aie:name value="Besondere Wertangabe"/>
																			<aie:id value="2702"/>
																			<aie:status value="R"/>
																			<aie:format value="n..11 (11,2)"/>
																			<aie:pcre value="\A(?!0\.?0*\Z)(?:0|[1-9][0-9]{0,8})(?:\.[0-9]{1,2})?\Z"/>
																		</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:decimal">
																			<xs:minInclusive value="0.01"/>
																			<xs:maxInclusive value="999999999.99"/>
																			<xs:totalDigits value="11"/>
																			<xs:fractionDigits value="2"/>
																			<xs:pattern value="(0|[1-9][0-9]{0,8})(\.[0-9]{1,2})?"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
															</xs:sequence>
														</xs:complexType>
													</xs:element>
													<xs:element name="ContentInformation" minOccurs="0" maxOccurs="3" id="PBG">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="GEHALTSANGABEN"/>
																<aie:id value="2703"/>
																<aie:status value="O"/>
															</xs:documentation>
														</xs:annotation>
														<xs:complexType>
															<xs:sequence>
																<xs:element name="Type" minOccurs="1" maxOccurs="1">
																	<xs:annotation>
																		<xs:documentation>
																			<aie:name value="Gehaltsangaben/Art"/>
																			<aie:id value="2704"/>
																			<aie:status value="R"/>
																			<aie:format value="an2"/>
																			<aie:pcre value="\A.{2}\Z"/>
																			<aie:list value="A1330"/>
																		</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:token">
																			<xs:length value="2"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
																<xs:element name="Degree-Percentage" minOccurs="1" maxOccurs="1">
																	<xs:annotation>
																		<xs:documentation>
																			<aie:name value="Gehaltsangaben (Grad/Prozent)"/>
																			<aie:id value="2705"/>
																			<aie:status value="R"/>
																			<aie:format value="n..5 (5,2)"/>
																			<aie:pcre value="\A(?!0\.?0*\Z)(?:(?:0|[1-9][0-9]{0,1})(?:\.[0-9]{1,2})?|100(?:\.0{1,2})?)\Z"/>
																		</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:decimal">
																			<xs:pattern value="(0|[1-9][0-9]{0,1})(\.[0-9]{1,2})?"/>
																			<xs:pattern value="100(\.0{1,2})?"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
															</xs:sequence>
														</xs:complexType>
													</xs:element>
												</xs:sequence>
											</xs:complexType>
										</xs:element>
										<xs:element name="ExciseDuty" minOccurs="0" maxOccurs="3" id="PVS">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="VERBRAUCHSTEUERDATEN"/>
													<aie:id value="3095"/>
													<aie:status value="D"/>
												</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:sequence>
													<xs:element name="Code" minOccurs="1" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Verbrauchsteuer (Code)"/>
																<aie:id value="3096"/>
																<aie:status value="R"/>
																<aie:format value="an4"/>
																<aie:pcre value="\A.{4}\Z"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:length value="4"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="Degree-Percentage" minOccurs="0" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Grad/Prozent (Verbrauchsteuer)"/>
																<aie:id value="3097"/>
																<aie:status value="D"/>
																<aie:format value="n..5 (5,2)"/>
																<aie:pcre value="\A(?!0\.?0*\Z)(?:(?:0|[1-9][0-9]{0,1})(?:\.[0-9]{1,2})?|100(?:\.0{1,2})?)\Z"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:decimal">
																<xs:pattern value="(0|[1-9][0-9]{0,1})(\.[0-9]{1,2})?"/>
																<xs:pattern value="100(\.0{1,2})?"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="Value" minOccurs="0" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Verbrauchsteuerwert"/>
																<aie:id value="3098"/>
																<aie:status value="D"/>
																<aie:format value="n..11 (11,2)"/>
																<aie:pcre value="\A(?!0\.?0*\Z)(?:0|[1-9][0-9]{0,8})(?:\.[0-9]{1,2})?\Z"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:decimal">
																<xs:minInclusive value="0.01"/>
																<xs:maxInclusive value="999999999.99"/>
																<xs:totalDigits value="11"/>
																<xs:fractionDigits value="2"/>
																<xs:pattern value="(0|[1-9][0-9]{0,8})(\.[0-9]{1,2})?"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="Amount" minOccurs="1" maxOccurs="1" id="PVM">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="ANGABEN ZUR VERBRAUCHSTEUERMENGE"/>
																<aie:id value="3099"/>
																<aie:status value="R"/>
															</xs:documentation>
														</xs:annotation>
														<xs:complexType>
															<xs:sequence>
																<xs:element name="Quantity" minOccurs="1" maxOccurs="1">
																	<xs:annotation>
																		<xs:documentation>
																			<aie:name value="Verbrauchsteuer (Menge)"/>
																			<aie:id value="3101"/>
																			<aie:status value="R"/>
																			<aie:format value="n..12 (12,3)"/>
																			<aie:pcre value="\A(?!0\.?0*\Z)(?:0|[1-9][0-9]{0,8})(?:\.[0-9]{1,3})?\Z"/>
																		</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:decimal">
																			<xs:minInclusive value="0.001"/>
																			<xs:maxInclusive value="999999999.999"/>
																			<xs:totalDigits value="12"/>
																			<xs:fractionDigits value="3"/>
																			<xs:pattern value="(0|[1-9][0-9]{0,8})(\.[0-9]{1,3})?"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
																<xs:element name="MeasurementUnit" minOccurs="1" maxOccurs="1">
																	<xs:annotation>
																		<xs:documentation>
																			<aie:name value="Maßeinheit (Verbrauchsteuer)"/>
																			<aie:id value="3100"/>
																			<aie:status value="R"/>
																			<aie:format value="an3"/>
																			<aie:pcre value="\A.{3}\Z"/>
																			<aie:list value="I0700"/>
																		</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:token">
																			<xs:length value="3"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
																<xs:element name="Qualifier" minOccurs="0" maxOccurs="1">
																	<xs:annotation>
																		<xs:documentation>
																			<aie:name value="Qualifikator (Verbrauchsteuer)"/>
																			<aie:id value="3102"/>
																			<aie:status value="D"/>
																			<aie:format value="an1"/>
																			<aie:pcre value="\A.\Z"/>
																			<aie:list value="I0700"/>
																		</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:token">
																			<xs:length value="1"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
															</xs:sequence>
														</xs:complexType>
													</xs:element>
												</xs:sequence>
											</xs:complexType>
										</xs:element>
										<xs:element name="PreferentialTreatment" minOccurs="0" maxOccurs="1" id="PGX">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="BEGÜNSTIGUNGSDATEN"/>
													<aie:id value="3843"/>
													<aie:status value="D"/>
												</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:sequence>
													<xs:element name="RequestedPreferentialTreatment" minOccurs="1" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Beantragte Begünstigung"/>
																<aie:id value="2656"/>
																<aie:status value="R"/>
																<aie:format value="an3"/>
																<aie:pcre value="\A.{3}\Z"/>
																<aie:list value="A1200"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:length value="3"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="Declaration" minOccurs="0" maxOccurs="1" id="PGM">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="ANGABEN ZU KONTINGENTEN"/>
																<aie:id value="3844"/>
																<aie:status value="D"/>
															</xs:documentation>
														</xs:annotation>
														<xs:complexType>
															<xs:sequence>
																<xs:element name="Contingent" minOccurs="0" maxOccurs="2" id="GMK">
																	<xs:annotation>
																		<xs:documentation>
																			<aie:name value="KONTINGENTSANGABEN"/>
																			<aie:id value="3845"/>
																			<aie:status value="D"/>
																		</xs:documentation>
																	</xs:annotation>
																	<xs:complexType>
																		<xs:sequence>
																			<xs:element name="ContingentNumber" minOccurs="1" maxOccurs="1">
																				<xs:annotation>
																					<xs:documentation>
																						<aie:name value="Kontingentnummer"/>
																						<aie:id value="2662"/>
																						<aie:status value="R"/>
																						<aie:format value="an4"/>
																						<aie:pcre value="\A.{4}\Z"/>
																					</xs:documentation>
																				</xs:annotation>
																				<xs:simpleType>
																					<xs:restriction base="xs:token">
																						<xs:length value="4"/>
																					</xs:restriction>
																				</xs:simpleType>
																			</xs:element>
																		</xs:sequence>
																	</xs:complexType>
																</xs:element>
																<xs:element name="PreferentialTreatmentQuantity" minOccurs="0" maxOccurs="1" id="GMB">
																	<xs:annotation>
																		<xs:documentation>
																			<aie:name value="ANGABEN ZUR BEGÜNSTIGUNGSMENGE"/>
																			<aie:id value="2657"/>
																			<aie:status value="D"/>
																		</xs:documentation>
																	</xs:annotation>
																	<xs:complexType>
																		<xs:sequence>
																			<xs:element name="Quantity" minOccurs="1" maxOccurs="1">
																				<xs:annotation>
																					<xs:documentation>
																						<aie:name value="Begünstigungsmenge"/>
																						<aie:id value="2659"/>
																						<aie:status value="R"/>
																						<aie:format value="n..9"/>
																						<aie:pcre value="\A[1-9][0-9]{0,8}\Z"/>
																					</xs:documentation>
																				</xs:annotation>
																				<xs:simpleType>
																					<xs:restriction base="xs:integer">
																						<xs:minInclusive value="1"/>
																						<xs:maxInclusive value="999999999"/>
																						<xs:totalDigits value="9"/>
																						<xs:pattern value="[1-9][0-9]{0,8}"/>
																					</xs:restriction>
																				</xs:simpleType>
																			</xs:element>
																			<xs:element name="MeasurementUnit" minOccurs="1" maxOccurs="1">
																				<xs:annotation>
																					<xs:documentation>
																						<aie:name value="Maßeinheit (Begünstigungsmenge)"/>
																						<aie:id value="2658"/>
																						<aie:status value="R"/>
																						<aie:format value="an3"/>
																						<aie:pcre value="\A.{3}\Z"/>
																						<aie:list value="I0700"/>
																					</xs:documentation>
																				</xs:annotation>
																				<xs:simpleType>
																					<xs:restriction base="xs:token">
																						<xs:length value="3"/>
																					</xs:restriction>
																				</xs:simpleType>
																			</xs:element>
																			<xs:element name="Qualifier" minOccurs="0" maxOccurs="1">
																				<xs:annotation>
																					<xs:documentation>
																						<aie:name value="Qualifikator (Begünstigungsmenge)"/>
																						<aie:id value="2660"/>
																						<aie:status value="D"/>
																						<aie:format value="an1"/>
																						<aie:pcre value="\A.\Z"/>
																						<aie:list value="I0700"/>
																					</xs:documentation>
																				</xs:annotation>
																				<xs:simpleType>
																					<xs:restriction base="xs:token">
																						<xs:length value="1"/>
																					</xs:restriction>
																				</xs:simpleType>
																			</xs:element>
																		</xs:sequence>
																	</xs:complexType>
																</xs:element>
															</xs:sequence>
														</xs:complexType>
													</xs:element>
												</xs:sequence>
											</xs:complexType>
										</xs:element>
										<xs:element name="Document" minOccurs="0" maxOccurs="99" id="DC2">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="UNTERLAGEN ZUR POSITION"/>
													<aie:id value="3076"/>
													<aie:status value="O"/>
												</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:sequence>
													<xs:element name="Division" minOccurs="1" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Bereich der Unterlage (Position)"/>
																<aie:id value="3079"/>
																<aie:status value="R"/>
																<aie:format value="an1"/>
																<aie:pcre value="\A.\Z"/>
																<aie:list value="A1255"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:length value="1"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="Type" minOccurs="1" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Art der Unterlage (Position)"/>
																<aie:id value="3085"/>
																<aie:status value="R"/>
																<aie:format value="an4"/>
																<aie:pcre value="\A.{4}\Z"/>
																<aie:list value="I0200"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:length value="4"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="ReferenceNumber" minOccurs="0" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Nummer der Unterlage (Position)"/>
																<aie:id value="3084"/>
																<aie:status value="D"/>
																<aie:format value="an..35"/>
																<aie:pcre value="\A.{1,35}\Z"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:minLength value="1"/>
																<xs:maxLength value="35"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="IssuingDate" minOccurs="0" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Datum der Unterlage (Position)"/>
																<aie:id value="3080"/>
																<aie:status value="D"/>
																<aie:format value="Date (n8)"/>
																<aie:pcre value="\A(?:(?:(?:0[48]|[2468][048]|[13579][26])(?:[02468][048]|[13579][26])|(?:[02468][1-35-79]|[13579][013-57-9])(?:0[48]|[2468][048]|[13579][26]))-02-29|[0-9][0-9][0-9][0-9]-(?:(?:0[13578]|1[02])-(?:0[1-9]|[12][0-9]|3[01])|(?:0[469]|11)-(?:0[1-9]|[12][0-9]|30)|02-(?:0[1-9]|1[0-9]|2[0-8])))\Z"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:date">
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="AtHandFlag" minOccurs="0" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Kennzeichen Vorhanden"/>
																<aie:id value="3086"/>
																<aie:status value="D"/>
																<aie:format value="an1"/>
																<aie:pcre value="\A.\Z"/>
																<aie:list value="A1790"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:length value="1"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="WriteOff" minOccurs="0" maxOccurs="1" id="DC3">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="ANGABEN ZU ABSCHREIBUNGSMENGE/-WERT"/>
																<aie:id value="3090"/>
																<aie:status value="D"/>
															</xs:documentation>
														</xs:annotation>
														<xs:complexType>
															<xs:sequence>
																<xs:element name="Quantity" minOccurs="1" maxOccurs="1">
																	<xs:annotation>
																		<xs:documentation>
																			<aie:name value="Abschreibungsmenge/-wert"/>
																			<aie:id value="3092"/>
																			<aie:status value="R"/>
																			<aie:format value="n..12 (12,3)"/>
																			<aie:pcre value="\A(?!0\.?0*\Z)(?:0|[1-9][0-9]{0,8})(?:\.[0-9]{1,3})?\Z"/>
																		</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:decimal">
																			<xs:minInclusive value="0.001"/>
																			<xs:maxInclusive value="999999999.999"/>
																			<xs:totalDigits value="12"/>
																			<xs:fractionDigits value="3"/>
																			<xs:pattern value="(0|[1-9][0-9]{0,8})(\.[0-9]{1,3})?"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
																<xs:element name="MeasurementUnit" minOccurs="1" maxOccurs="1">
																	<xs:annotation>
																		<xs:documentation>
																			<aie:name value="Maßeinheit (Abschreibung)"/>
																			<aie:id value="3091"/>
																			<aie:status value="R"/>
																			<aie:format value="an3"/>
																			<aie:pcre value="\A.{3}\Z"/>
																			<aie:list value="I0700"/>
																		</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:token">
																			<xs:length value="3"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
																<xs:element name="Qualifier" minOccurs="0" maxOccurs="1">
																	<xs:annotation>
																		<xs:documentation>
																			<aie:name value="Qualifikator (Abschreibung)"/>
																			<aie:id value="3093"/>
																			<aie:status value="D"/>
																			<aie:format value="an1"/>
																			<aie:pcre value="\A.\Z"/>
																			<aie:list value="I0700"/>
																		</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:token">
																			<xs:length value="1"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
															</xs:sequence>
														</xs:complexType>
													</xs:element>
												</xs:sequence>
											</xs:complexType>
										</xs:element>
									</xs:sequence>
								</xs:complexType>
							</xs:element>
						</xs:sequence>
					</xs:complexType>
				</xs:element>
			</xs:sequence>
		</xs:complexType>
	</xs:element>
</xs:schema>
'

IF EXISTS (SELECT * FROM sys.xml_schema_collections 
                    WHERE name = N'DE_IMP_ECFCPD' 
                    AND schema_id = SCHEMA_ID(N'dbo'))
BEGIN
   DROP XML SCHEMA COLLECTION dbo.DE_IMP_ECFCPD;
END
 
CREATE XML SCHEMA COLLECTION dbo.DE_IMP_ECFCPD
AS N'<?xml version="1.0" encoding="UTF-16"?>
<xs:schema version="9.0.0.7" elementFormDefault="qualified" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:aie="urn:publicid:IDN+zoll.de:AIE">
	<xs:complexType name="decimal">
		<xs:simpleContent>
			<xs:extension base="xs:decimal">
				<xs:anyAttribute/>
			</xs:extension>
		</xs:simpleContent>
	</xs:complexType>
	<xs:complexType name="integer">
		<xs:simpleContent>
			<xs:extension base="xs:integer">
				<xs:anyAttribute/>
			</xs:extension>
		</xs:simpleContent>
	</xs:complexType>
	<xs:complexType name="token">
		<xs:simpleContent>
			<xs:extension base="xs:token">
				<xs:anyAttribute/>
			</xs:extension>
		</xs:simpleContent>
	</xs:complexType>
	<xs:element name="ECFCPD" id="MES">
		<xs:annotation>
			<xs:documentation>
				<aie:name value="NACHRICHT"/>
				<aie:id value="1"/>
				<aie:status value="R"/>
			</xs:documentation>
		</xs:annotation>
		<xs:complexType>
			<xs:sequence>
				<xs:element name="MetaData" minOccurs="1" maxOccurs="1" id="MTD">
					<xs:annotation>
						<xs:documentation>
							<aie:name value="METADATEN"/>
							<aie:id value="159"/>
							<aie:status value="R"/>
						</xs:documentation>
					</xs:annotation>
					<xs:complexType>
						<xs:sequence>
							<xs:element name="Preparation" minOccurs="1" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="Vorbereitung"/>
										<aie:status value="R"/>
									</xs:documentation>
								</xs:annotation>
								<xs:complexType>
									<xs:sequence>
										<xs:element name="Date" minOccurs="1" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Vorbereitung (Datum)"/>
													<aie:id value="168"/>
													<aie:status value="R"/>
													<aie:format value="Date (n6)"/>
													<aie:pcre value="\A(?!....-(?:02|04|06|09|11)-31|....-02-30|..(?:.[13579]|[02468][26]|[13579][048])-02-29)^(?:20[0-9][0-9])-(?:0[1-9]|1[0-2])-(?:0[1-9]|[12][0-9]|3[01])\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:date">
													<xs:minInclusive value="2000-01-01"/>
													<xs:maxInclusive value="2099-12-31"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="Time" minOccurs="1" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Vorbereitung (Zeit)"/>
													<aie:id value="169"/>
													<aie:status value="R"/>
													<aie:format value="Time (n4)"/>
													<aie:pcre value="\A(?:[01][0-9]|2[0-3]):(?:[0-5][0-9]):(?:00)\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:time">
													<xs:minInclusive value="00:00:00"/>
													<xs:maxInclusive value="23:59:00"/>
													<xs:pattern value="[0-9]{2}:[0-9]{2}:[0-0]{2}"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
									</xs:sequence>
								</xs:complexType>
							</xs:element>
							<xs:element name="InterchangeControlReference" minOccurs="1" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="Datei-Kennung"/>
										<aie:id value="160"/>
										<aie:status value="R"/>
										<aie:format value="an..14"/>
										<aie:pcre value="\A.{1,14}\Z"/>
									</xs:documentation>
								</xs:annotation>
								<xs:simpleType>
									<xs:restriction base="xs:token">
										<xs:minLength value="1"/>
										<xs:maxLength value="14"/>
									</xs:restriction>
								</xs:simpleType>
							</xs:element>
							<xs:element name="MessageReferenceNumber" minOccurs="1" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="Identifikation"/>
										<aie:id value="161"/>
										<aie:status value="R"/>
										<aie:format value="n..6"/>
										<aie:pcre value="\A(?:0|[1-9][0-9]{0,5})\Z"/>
									</xs:documentation>
								</xs:annotation>
								<xs:simpleType>
									<xs:restriction base="xs:integer">
										<xs:minInclusive value="0"/>
										<xs:maxInclusive value="999999"/>
										<xs:totalDigits value="6"/>
										<xs:pattern value="(0|[1-9][0-9]{0,5})"/>
									</xs:restriction>
								</xs:simpleType>
							</xs:element>
							<xs:element name="MessageIdentifier" minOccurs="1" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="Nachrichtennummer"/>
										<aie:id value="163"/>
										<aie:status value="R"/>
										<aie:format value="an..35"/>
										<aie:pcre value="\A.{1,35}\Z"/>
									</xs:documentation>
								</xs:annotation>
								<xs:simpleType>
									<xs:restriction base="xs:token">
										<xs:minLength value="1"/>
										<xs:maxLength value="35"/>
									</xs:restriction>
								</xs:simpleType>
							</xs:element>
							<xs:element name="MessageGroup" minOccurs="1" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="Nachrichtengruppe"/>
										<aie:id value="162"/>
										<aie:status value="R"/>
										<aie:format value="a3"/>
										<aie:pcre value="\A(?:ZSZ)\Z"/>
										<aie:list value="A0110"/>
									</xs:documentation>
								</xs:annotation>
								<xs:simpleType>
									<xs:restriction base="xs:token">
										<xs:length value="3"/>
										<xs:enumeration value="ZSZ"/>
									</xs:restriction>
								</xs:simpleType>
							</xs:element>
							<xs:element name="Scenario" minOccurs="0" maxOccurs="0">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="Szenario"/>
										<aie:status value="N"/>
									</xs:documentation>
								</xs:annotation>
								<xs:complexType>
									<xs:sequence>
										<xs:element name="ReferenceNumber" minOccurs="0" maxOccurs="0">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Szenario-Nummer"/>
													<aie:id value="165"/>
													<aie:status value="N"/>
													<aie:format value="n5"/>
													<aie:pcre value="\A[1-9][0-9]{4}\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:length value="5"/>
													<xs:pattern value="[1-9][0-9]{4}"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="Note" minOccurs="0" maxOccurs="0">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Szenario-Hinweis"/>
													<aie:id value="164"/>
													<aie:status value="N"/>
													<aie:format value="a2"/>
													<aie:pcre value="\A[A-Z]{2}\Z"/>
													<aie:list value="A0112"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:length value="2"/>
													<xs:pattern value="[A-Z]{2}"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
									</xs:sequence>
								</xs:complexType>
							</xs:element>
							<xs:element name="TestIndicator" minOccurs="0" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="Test-Indikator"/>
										<aie:id value="166"/>
										<aie:status value="O"/>
										<aie:format value="n1"/>
										<aie:pcre value="\A1\Z"/>
										<aie:list value="A0035"/>
									</xs:documentation>
								</xs:annotation>
								<xs:simpleType>
									<xs:restriction base="xs:token">
										<xs:length value="1"/>
										<xs:enumeration value="1"/>
									</xs:restriction>
								</xs:simpleType>
							</xs:element>
							<xs:element name="MessageType" minOccurs="1" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="Typ"/>
										<aie:id value="167"/>
										<aie:status value="R"/>
										<aie:format value="a6"/>
										<aie:pcre value="\AECFCPD\Z"/>
										<aie:list value="A0057"/>
									</xs:documentation>
								</xs:annotation>
								<xs:simpleType>
									<xs:restriction base="xs:token">
										<xs:length value="6"/>
										<xs:enumeration value="ECFCPD"/>
									</xs:restriction>
								</xs:simpleType>
							</xs:element>
							<xs:element name="InterchangeSender" minOccurs="1" maxOccurs="1" id="MST">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="NACHRICHTENSENDER"/>
										<aie:id value="241"/>
										<aie:status value="R"/>
									</xs:documentation>
								</xs:annotation>
								<xs:complexType>
									<xs:sequence>
										<xs:element name="Identification" minOccurs="1" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
												</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:sequence>
													<xs:element name="ReferenceNumber" minOccurs="1" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="TIN"/>
																<aie:id value="245"/>
																<aie:status value="R"/>
																<aie:format value="an..17"/>
																<aie:pcre value="\A[A-Z]{2}[\x21-\x7E]{1,15}\Z"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:minLength value="1"/>
																<xs:maxLength value="17"/>
																<xs:pattern value="[A-Z]{2}[&#x21;-&#x7E;]{1,15}"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="SubsidiaryNumber" minOccurs="1" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Niederlassungsnummer"/>
																<aie:id value="244"/>
																<aie:status value="R"/>
																<aie:format value="n4"/>
																<aie:pcre value="\A[0-9]{4}\Z"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:length value="4"/>
																<xs:pattern value="[0-9]{4}"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
												</xs:sequence>
											</xs:complexType>
										</xs:element>
									</xs:sequence>
								</xs:complexType>
							</xs:element>
							<xs:element name="InterchangeRecipient" minOccurs="1" maxOccurs="1" id="MED">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="NACHRICHTENEMPFÄNGER"/>
										<aie:id value="170"/>
										<aie:status value="R"/>
									</xs:documentation>
								</xs:annotation>
								<xs:complexType>
									<xs:sequence>
										<xs:element name="Identification" minOccurs="1" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Dienststellennummer"/>
													<aie:status value="R"/>
												</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:sequence>
													<xs:element name="ReferenceNumber" minOccurs="1" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:id value="173"/>
																<aie:format value="an8"/>
																<aie:pcre value="\ADE00[0-9]{4}\Z"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:length value="8"/>
																<xs:pattern value="DE00[0-9]{4}"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
												</xs:sequence>
											</xs:complexType>
										</xs:element>
									</xs:sequence>
								</xs:complexType>
							</xs:element>
						</xs:sequence>
					</xs:complexType>
				</xs:element>
				<xs:element name="Header" minOccurs="1" maxOccurs="1" id="HEA">
					<xs:annotation>
						<xs:documentation>
							<aie:name value="KOPF"/>
							<aie:id value="3647"/>
							<aie:status value="R"/>
						</xs:documentation>
					</xs:annotation>
					<xs:complexType>
						<xs:sequence>
							<xs:element name="MessageVersion" minOccurs="1" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="Nachrichtenversion"/>
										<aie:id value="89"/>
										<aie:status value="R"/>
										<aie:format value="an..7"/>
										<aie:pcre value="\AD\.[1-9][0-9]?\.[1-9]?[0-9]\Z"/>
									</xs:documentation>
								</xs:annotation>
								<xs:simpleType>
									<xs:restriction base="xs:token">
										<xs:minLength value="1"/>
										<xs:maxLength value="7"/>
										<xs:pattern value="D\.[1-9][0-9]?\.[1-9]?[0-9]"/>
									</xs:restriction>
								</xs:simpleType>
							</xs:element>
							<xs:element name="MessageRole" minOccurs="1" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="Nachrichtenfunktion"/>
										<aie:id value="87"/>
										<aie:status value="R"/>
										<aie:format value="an..2"/>
										<aie:pcre value="\A.{1,2}\Z"/>
										<aie:list value="A1290"/>
									</xs:documentation>
								</xs:annotation>
								<xs:simpleType>
									<xs:restriction base="xs:token">
										<xs:minLength value="1"/>
										<xs:maxLength value="2"/>
									</xs:restriction>
								</xs:simpleType>
							</xs:element>
							<xs:element name="MessageCreationDate" minOccurs="1" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="Datum der Nachricht"/>
										<aie:id value="86"/>
										<aie:status value="R"/>
										<aie:format value="Date (n8)"/>
										<aie:pcre value="\A(?:(?:(?:0[48]|[2468][048]|[13579][26])(?:[02468][048]|[13579][26])|(?:[02468][1-35-79]|[13579][013-57-9])(?:0[48]|[2468][048]|[13579][26]))-02-29|[0-9][0-9][0-9][0-9]-(?:(?:0[13578]|1[02])-(?:0[1-9]|[12][0-9]|3[01])|(?:0[469]|11)-(?:0[1-9]|[12][0-9]|30)|02-(?:0[1-9]|1[0-9]|2[0-8])))\Z"/>
									</xs:documentation>
								</xs:annotation>
								<xs:simpleType>
									<xs:restriction base="xs:date">
									</xs:restriction>
								</xs:simpleType>
							</xs:element>
							<xs:element name="Declaration" minOccurs="1" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="Anmeldeart"/>
										<aie:status value="R"/>
									</xs:documentation>
								</xs:annotation>
								<xs:complexType>
									<xs:sequence>
										<xs:element name="Kind" minOccurs="1" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:id value="11"/>
													<aie:format value="an1"/>
													<aie:pcre value="\A(?:Y|Z)\Z"/>
													<aie:list value="A1025"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:length value="1"/>
													<xs:enumeration value="Y"/>
													<xs:enumeration value="Z"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
									</xs:sequence>
								</xs:complexType>
							</xs:element>
							<xs:element name="ReferenceNumber" minOccurs="0" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="Registriernummer"/>
										<aie:id value="98"/>
										<aie:status value="D"/>
										<aie:format value="an21"/>
										<aie:pcre value="\AAT[A-Z][0-9]{2}[0-9]{6}(?:0[1-9]|1[0-2])20[0-9]{2}[0-9]{4}\Z"/>
									</xs:documentation>
								</xs:annotation>
								<xs:simpleType>
									<xs:restriction base="xs:token">
										<xs:length value="21"/>
										<xs:pattern value="AT[A-Z][0-9]{2}[0-9]{6}(0[1-9]|1[0-2])20[0-9]{2}[0-9]{4}"/>
									</xs:restriction>
								</xs:simpleType>
							</xs:element>
							<xs:element name="LocalReferenceNumber" minOccurs="0" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="Bezugsnummer"/>
										<aie:id value="46"/>
										<aie:status value="O"/>
										<aie:format value="an..35"/>
										<aie:pcre value="\A.{1,35}\Z"/>
									</xs:documentation>
								</xs:annotation>
								<xs:simpleType>
									<xs:restriction base="xs:token">
										<xs:minLength value="1"/>
										<xs:maxLength value="35"/>
									</xs:restriction>
								</xs:simpleType>
							</xs:element>
							<xs:element name="StartAccountingPeriodDate" minOccurs="0" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="Beginn Abrechnungszeitraum"/>
										<aie:id value="154"/>
										<aie:status value="D"/>
										<aie:format value="Date (n8)"/>
										<aie:pcre value="\A(?:(?:(?:0[48]|[2468][048]|[13579][26])(?:[02468][048]|[13579][26])|(?:[02468][1-35-79]|[13579][013-57-9])(?:0[48]|[2468][048]|[13579][26]))-02-29|[0-9][0-9][0-9][0-9]-(?:(?:0[13578]|1[02])-(?:0[1-9]|[12][0-9]|3[01])|(?:0[469]|11)-(?:0[1-9]|[12][0-9]|30)|02-(?:0[1-9]|1[0-9]|2[0-8])))\Z"/>
									</xs:documentation>
								</xs:annotation>
								<xs:simpleType>
									<xs:restriction base="xs:date">
									</xs:restriction>
								</xs:simpleType>
							</xs:element>
							<xs:element name="EndAccountingPeriodDate" minOccurs="0" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="Ende Abrechnungszeitraum"/>
										<aie:id value="155"/>
										<aie:status value="D"/>
										<aie:format value="Date (n8)"/>
										<aie:pcre value="\A(?:(?:(?:0[48]|[2468][048]|[13579][26])(?:[02468][048]|[13579][26])|(?:[02468][1-35-79]|[13579][013-57-9])(?:0[48]|[2468][048]|[13579][26]))-02-29|[0-9][0-9][0-9][0-9]-(?:(?:0[13578]|1[02])-(?:0[1-9]|[12][0-9]|3[01])|(?:0[469]|11)-(?:0[1-9]|[12][0-9]|30)|02-(?:0[1-9]|1[0-9]|2[0-8])))\Z"/>
									</xs:documentation>
								</xs:annotation>
								<xs:simpleType>
									<xs:restriction base="xs:date">
									</xs:restriction>
								</xs:simpleType>
							</xs:element>
							<xs:element name="DeclarantIsConsigneeFlag" minOccurs="0" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="Anmelder ist Empfänger"/>
										<aie:id value="13"/>
										<aie:status value="D"/>
										<aie:format value="an1"/>
										<aie:pcre value="\A.\Z"/>
										<aie:list value="A1030"/>
									</xs:documentation>
								</xs:annotation>
								<xs:simpleType>
									<xs:restriction base="xs:token">
										<xs:length value="1"/>
									</xs:restriction>
								</xs:simpleType>
							</xs:element>
							<xs:element name="CustomsAuthorisation" minOccurs="0" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="Bewilligungsnummer"/>
										<aie:status value="D"/>
									</xs:documentation>
								</xs:annotation>
								<xs:complexType>
									<xs:sequence>
										<xs:element name="LocalClearanceProcedure" minOccurs="0" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Bewilligungsnummer (vereinfachtes Verfahren)"/>
													<aie:id value="45"/>
													<aie:status value="D"/>
													<aie:format value="an..35"/>
													<aie:pcre value="\A(?:[A-Z]{2}[0-9]{4}[A-Z][A-Z0-9][0-9]{1,4}|[A-Z]{2}.{1,4}.{1,29})\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:minLength value="1"/>
													<xs:maxLength value="35"/>
													<xs:pattern value="[A-Z]{2}[0-9]{4}[A-Z][A-Z0-9][0-9]{1,4}"/>
													<xs:pattern value="[A-Z]{2}.{1,4}.{1,29}"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="EndUse" minOccurs="0" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Bewilligungsnummer (Endverwendung)"/>
													<aie:id value="4160"/>
													<aie:status value="D"/>
													<aie:format value="an..35"/>
													<aie:pcre value="\A(?:[A-Z]{2}[0-9]{4}[A-Z][A-Z0-9][0-9]{1,4}|[A-Z]{2}.{1,4}.{1,29})\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:minLength value="1"/>
													<xs:maxLength value="35"/>
													<xs:pattern value="[A-Z]{2}[0-9]{4}[A-Z][A-Z0-9][0-9]{1,4}"/>
													<xs:pattern value="[A-Z]{2}.{1,4}.{1,29}"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
									</xs:sequence>
								</xs:complexType>
							</xs:element>
							<xs:element name="InputTaxDeductionFlag" minOccurs="0" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="Vorsteuerabzug"/>
										<aie:id value="134"/>
										<aie:status value="D"/>
										<aie:format value="an1"/>
										<aie:pcre value="\A.\Z"/>
										<aie:list value="A2030"/>
									</xs:documentation>
								</xs:annotation>
								<xs:simpleType>
									<xs:restriction base="xs:token">
										<xs:length value="1"/>
									</xs:restriction>
								</xs:simpleType>
							</xs:element>
							<xs:element name="CurrencyCode" minOccurs="0" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="WKZ"/>
										<aie:id value="149"/>
										<aie:status value="D"/>
										<aie:format value="an3"/>
										<aie:pcre value="\AEUR\Z"/>
										<aie:list value="I0400"/>
									</xs:documentation>
								</xs:annotation>
								<xs:simpleType>
									<xs:restriction base="xs:token">
										<xs:length value="3"/>
										<xs:enumeration value="EUR"/>
									</xs:restriction>
								</xs:simpleType>
							</xs:element>
							<xs:element name="TaxNumber" minOccurs="0" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="USt-IdNr."/>
										<aie:id value="125"/>
										<aie:status value="D"/>
										<aie:format value="an..20"/>
										<aie:pcre value="\A(?:[A-Z]{2}.{1,12}|.{1,20})\Z"/>
										<aie:list value="A1835"/>
									</xs:documentation>
								</xs:annotation>
								<xs:simpleType>
									<xs:restriction base="xs:token">
										<xs:minLength value="1"/>
										<xs:maxLength value="20"/>
										<xs:pattern value="[A-Z]{2}.{1,12}"/>
										<xs:pattern value=".{1,20}"/>
									</xs:restriction>
								</xs:simpleType>
							</xs:element>
							<xs:element name="TaxOffice" minOccurs="0" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="Finanzamt"/>
										<aie:id value="66"/>
										<aie:status value="D"/>
										<aie:format value="an4"/>
										<aie:pcre value="\A.{4}\Z"/>
									</xs:documentation>
								</xs:annotation>
								<xs:simpleType>
									<xs:restriction base="xs:token">
										<xs:length value="4"/>
									</xs:restriction>
								</xs:simpleType>
							</xs:element>
							<xs:element name="RepresentativeRelationshipFlag" minOccurs="0" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="Kennzeichen Vertretungsverhältnis"/>
										<aie:id value="131"/>
										<aie:status value="D"/>
										<aie:format value="an1"/>
										<aie:pcre value="\A.\Z"/>
										<aie:list value="A1770"/>
									</xs:documentation>
								</xs:annotation>
								<xs:simpleType>
									<xs:restriction base="xs:token">
										<xs:length value="1"/>
									</xs:restriction>
								</xs:simpleType>
							</xs:element>
							<xs:element name="MandateReference" minOccurs="0" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="Mandatsreferenznummer"/>
										<aie:id value="85"/>
										<aie:status value="O"/>
										<aie:format value="n10"/>
										<aie:pcre value="\A[0-9]{10}\Z"/>
									</xs:documentation>
								</xs:annotation>
								<xs:simpleType>
									<xs:restriction base="xs:token">
										<xs:length value="10"/>
										<xs:pattern value="[0-9]{10}"/>
									</xs:restriction>
								</xs:simpleType>
							</xs:element>
							<xs:element name="DeclarationPlace" minOccurs="0" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="Ausstellungsort"/>
										<aie:id value="17"/>
										<aie:status value="D"/>
										<aie:format value="an..35"/>
										<aie:pcre value="\A.{1,35}\Z"/>
									</xs:documentation>
								</xs:annotation>
								<xs:simpleType>
									<xs:restriction base="xs:token">
										<xs:minLength value="1"/>
										<xs:maxLength value="35"/>
									</xs:restriction>
								</xs:simpleType>
							</xs:element>
							<xs:element name="AuthorisationNumber" minOccurs="1" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="BIN"/>
										<aie:id value="48"/>
										<aie:status value="R"/>
										<aie:format value="an25"/>
										<aie:pcre value="\A.{25}\Z"/>
									</xs:documentation>
								</xs:annotation>
								<xs:simpleType>
									<xs:restriction base="xs:token">
										<xs:length value="25"/>
									</xs:restriction>
								</xs:simpleType>
							</xs:element>
						</xs:sequence>
					</xs:complexType>
				</xs:element>
				<xs:element name="Declarant" minOccurs="0" maxOccurs="1" id="DT0">
					<xs:annotation>
						<xs:documentation>
							<aie:name value="ANGABEN ZUM ANMELDER"/>
							<aie:id value="489"/>
							<aie:status value="D"/>
						</xs:documentation>
					</xs:annotation>
					<xs:complexType>
						<xs:sequence>
							<xs:element name="Identification" minOccurs="0" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
									</xs:documentation>
								</xs:annotation>
								<xs:complexType>
									<xs:sequence>
										<xs:element name="ReferenceNumber" minOccurs="0" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="TIN"/>
													<aie:id value="493"/>
													<aie:status value="D"/>
													<aie:format value="an..17"/>
													<aie:pcre value="\A[A-Z]{2}[\x21-\x7E]{1,15}\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:minLength value="1"/>
													<xs:maxLength value="17"/>
													<xs:pattern value="[A-Z]{2}[&#x21;-&#x7E;]{1,15}"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="SubsidiaryNumber" minOccurs="0" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Niederlassungsnummer"/>
													<aie:id value="492"/>
													<aie:status value="D"/>
													<aie:format value="n4"/>
													<aie:pcre value="\A[0-9]{4}\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:length value="4"/>
													<xs:pattern value="[0-9]{4}"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
									</xs:sequence>
								</xs:complexType>
							</xs:element>
							<xs:element name="Name" minOccurs="0" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="Name"/>
										<aie:id value="491"/>
										<aie:status value="D"/>
										<aie:format value="an..120"/>
										<aie:pcre value="\A.{1,120}\Z"/>
									</xs:documentation>
								</xs:annotation>
								<xs:simpleType>
									<xs:restriction base="xs:token">
										<xs:minLength value="1"/>
										<xs:maxLength value="120"/>
									</xs:restriction>
								</xs:simpleType>
							</xs:element>
							<xs:element name="Address" minOccurs="0" maxOccurs="1" id="DT1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="ANMELDER (ADRESSDATEN)"/>
										<aie:id value="494"/>
										<aie:status value="D"/>
									</xs:documentation>
								</xs:annotation>
								<xs:complexType>
									<xs:sequence>
										<xs:element name="Line" minOccurs="1" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Straße und Hausnummer"/>
													<aie:id value="500"/>
													<aie:status value="R"/>
													<aie:format value="an..35"/>
													<aie:pcre value="\A.{1,35}\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:minLength value="1"/>
													<xs:maxLength value="35"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="Country" minOccurs="1" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Land"/>
													<aie:id value="495"/>
													<aie:status value="R"/>
													<aie:format value="an2"/>
													<aie:pcre value="\A[A-Z]{2}\Z"/>
													<aie:list value="I0300"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:length value="2"/>
													<xs:pattern value="[A-Z]{2}"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="Postcode" minOccurs="0" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Postleitzahl"/>
													<aie:id value="499"/>
													<aie:status value="D"/>
													<aie:format value="an..9"/>
													<aie:pcre value="\A.{1,9}\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:minLength value="1"/>
													<xs:maxLength value="9"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="City" minOccurs="1" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Ort"/>
													<aie:id value="496"/>
													<aie:status value="R"/>
													<aie:format value="an..35"/>
													<aie:pcre value="\A.{1,35}\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:minLength value="1"/>
													<xs:maxLength value="35"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="District" minOccurs="0" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Ortsteil"/>
													<aie:id value="497"/>
													<aie:status value="O"/>
													<aie:format value="an..35"/>
													<aie:pcre value="\A.{1,35}\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:minLength value="1"/>
													<xs:maxLength value="35"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
									</xs:sequence>
								</xs:complexType>
							</xs:element>
						</xs:sequence>
					</xs:complexType>
				</xs:element>
				<xs:element name="Representative" minOccurs="0" maxOccurs="1" id="CB0">
					<xs:annotation>
						<xs:documentation>
							<aie:name value="ANGABEN ZUM VERTRETER"/>
							<aie:id value="1791"/>
							<aie:status value="D"/>
						</xs:documentation>
					</xs:annotation>
					<xs:complexType>
						<xs:sequence>
							<xs:element name="Identification" minOccurs="1" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
									</xs:documentation>
								</xs:annotation>
								<xs:complexType>
									<xs:sequence>
										<xs:element name="ReferenceNumber" minOccurs="1" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="TIN"/>
													<aie:id value="1795"/>
													<aie:status value="R"/>
													<aie:format value="an..17"/>
													<aie:pcre value="\A[A-Z]{2}[\x21-\x7E]{1,15}\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:minLength value="1"/>
													<xs:maxLength value="17"/>
													<xs:pattern value="[A-Z]{2}[&#x21;-&#x7E;]{1,15}"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="SubsidiaryNumber" minOccurs="0" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Niederlassungsnummer"/>
													<aie:id value="1794"/>
													<aie:status value="O"/>
													<aie:format value="n4"/>
													<aie:pcre value="\A[0-9]{4}\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:length value="4"/>
													<xs:pattern value="[0-9]{4}"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
									</xs:sequence>
								</xs:complexType>
							</xs:element>
						</xs:sequence>
					</xs:complexType>
				</xs:element>
				<xs:element name="Principal" minOccurs="0" maxOccurs="1" id="UH0">
					<xs:annotation>
						<xs:documentation>
							<aie:name value="ANGABEN ZUM VERTRETENEN (FÜR RECHNUNG)"/>
							<aie:id value="1768"/>
							<aie:status value="D"/>
						</xs:documentation>
					</xs:annotation>
					<xs:complexType>
						<xs:sequence>
							<xs:element name="Identification" minOccurs="0" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
									</xs:documentation>
								</xs:annotation>
								<xs:complexType>
									<xs:sequence>
										<xs:element name="ReferenceNumber" minOccurs="0" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="TIN"/>
													<aie:id value="1772"/>
													<aie:status value="D"/>
													<aie:format value="an..17"/>
													<aie:pcre value="\A[A-Z]{2}[\x21-\x7E]{1,15}\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:minLength value="1"/>
													<xs:maxLength value="17"/>
													<xs:pattern value="[A-Z]{2}[&#x21;-&#x7E;]{1,15}"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="SubsidiaryNumber" minOccurs="0" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Niederlassungsnummer"/>
													<aie:id value="1771"/>
													<aie:status value="D"/>
													<aie:format value="n4"/>
													<aie:pcre value="\A[0-9]{4}\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:length value="4"/>
													<xs:pattern value="[0-9]{4}"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
									</xs:sequence>
								</xs:complexType>
							</xs:element>
							<xs:element name="Name" minOccurs="0" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="Name"/>
										<aie:id value="1770"/>
										<aie:status value="D"/>
										<aie:format value="an..120"/>
										<aie:pcre value="\A.{1,120}\Z"/>
									</xs:documentation>
								</xs:annotation>
								<xs:simpleType>
									<xs:restriction base="xs:token">
										<xs:minLength value="1"/>
										<xs:maxLength value="120"/>
									</xs:restriction>
								</xs:simpleType>
							</xs:element>
							<xs:element name="Address" minOccurs="0" maxOccurs="1" id="UH1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="ADRESSDATEN (FÜR RECHNUNG)"/>
										<aie:id value="1773"/>
										<aie:status value="D"/>
									</xs:documentation>
								</xs:annotation>
								<xs:complexType>
									<xs:sequence>
										<xs:element name="Line" minOccurs="1" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Straße und Hausnummer"/>
													<aie:id value="1779"/>
													<aie:status value="R"/>
													<aie:format value="an..35"/>
													<aie:pcre value="\A.{1,35}\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:minLength value="1"/>
													<xs:maxLength value="35"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="Country" minOccurs="1" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Land"/>
													<aie:id value="1774"/>
													<aie:status value="R"/>
													<aie:format value="an2"/>
													<aie:pcre value="\A[A-Z]{2}\Z"/>
													<aie:list value="I0300"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:length value="2"/>
													<xs:pattern value="[A-Z]{2}"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="Postcode" minOccurs="0" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Postleitzahl"/>
													<aie:id value="1778"/>
													<aie:status value="D"/>
													<aie:format value="an..9"/>
													<aie:pcre value="\A.{1,9}\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:minLength value="1"/>
													<xs:maxLength value="9"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="City" minOccurs="1" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Ort"/>
													<aie:id value="1775"/>
													<aie:status value="R"/>
													<aie:format value="an..35"/>
													<aie:pcre value="\A.{1,35}\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:minLength value="1"/>
													<xs:maxLength value="35"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="District" minOccurs="0" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Ortsteil"/>
													<aie:id value="1776"/>
													<aie:status value="O"/>
													<aie:format value="an..35"/>
													<aie:pcre value="\A.{1,35}\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:minLength value="1"/>
													<xs:maxLength value="35"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
									</xs:sequence>
								</xs:complexType>
							</xs:element>
						</xs:sequence>
					</xs:complexType>
				</xs:element>
				<xs:element name="ContactPerson" minOccurs="0" maxOccurs="1" id="PK0">
					<xs:annotation>
						<xs:documentation>
							<aie:name value="ANGABEN ZUM ANSPRECHPARTNER FIRMA"/>
							<aie:id value="517"/>
							<aie:status value="D"/>
						</xs:documentation>
					</xs:annotation>
					<xs:complexType>
						<xs:sequence>
							<xs:element name="Name" minOccurs="0" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="Name"/>
										<aie:id value="520"/>
										<aie:status value="D"/>
										<aie:format value="an..35"/>
										<aie:pcre value="\A.{1,35}\Z"/>
									</xs:documentation>
								</xs:annotation>
								<xs:simpleType>
									<xs:restriction base="xs:token">
										<xs:minLength value="1"/>
										<xs:maxLength value="35"/>
									</xs:restriction>
								</xs:simpleType>
							</xs:element>
							<xs:element name="Position" minOccurs="0" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="Stellung in der Firma"/>
										<aie:id value="521"/>
										<aie:status value="D"/>
										<aie:format value="an..35"/>
										<aie:pcre value="\A.{1,35}\Z"/>
									</xs:documentation>
								</xs:annotation>
								<xs:simpleType>
									<xs:restriction base="xs:token">
										<xs:minLength value="1"/>
										<xs:maxLength value="35"/>
									</xs:restriction>
								</xs:simpleType>
							</xs:element>
							<xs:element name="PhoneNumber" minOccurs="0" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="Telefonnummer"/>
										<aie:id value="522"/>
										<aie:status value="D"/>
										<aie:format value="an..35"/>
										<aie:pcre value="\A.{1,35}\Z"/>
									</xs:documentation>
								</xs:annotation>
								<xs:simpleType>
									<xs:restriction base="xs:token">
										<xs:minLength value="1"/>
										<xs:maxLength value="35"/>
									</xs:restriction>
								</xs:simpleType>
							</xs:element>
							<xs:element name="MailAddress" minOccurs="0" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="E-Mail-Adresse"/>
										<aie:id value="518"/>
										<aie:status value="O"/>
										<aie:format value="an..256"/>
										<aie:pcre value="\A(?=.{1,256}\Z)[A-Za-z0-9!#$%&amp;&apos;*+/=?^_`{|}~-]+(?:\.[A-Za-z0-9!#$%&amp;&apos;*+/=?^_`{|}~-]+)*@(?:[A-Za-z0-9](?:[A-Za-z0-9-]*[A-Za-z0-9])?\.)+[A-Za-z0-9](?:[A-Za-z0-9-]*[A-Za-z0-9])?\Z"/>
									</xs:documentation>
								</xs:annotation>
								<xs:simpleType>
									<xs:restriction base="xs:token">
										<xs:minLength value="1"/>
										<xs:maxLength value="256"/>
										<xs:pattern value="[A-Za-z0-9!#$%&amp;&apos;*+/=?\^_`{|}~\-]+(\.[A-Za-z0-9!#$%&amp;&apos;*+/=?\^_`{|}~\-]+)*@([A-Za-z0-9]([A-Za-z0-9\-]*[A-Za-z0-9])?\.)+[A-Za-z0-9]([A-Za-z0-9\-]*[A-Za-z0-9])?"/>
									</xs:restriction>
								</xs:simpleType>
							</xs:element>
						</xs:sequence>
					</xs:complexType>
				</xs:element>
				<xs:element name="Body" minOccurs="1" maxOccurs="999" id="BDY">
					<xs:annotation>
						<xs:documentation>
							<aie:name value="ANGABEN ZUR VZA/AZ"/>
							<aie:id value="2040"/>
							<aie:status value="R"/>
						</xs:documentation>
					</xs:annotation>
					<xs:complexType>
						<xs:sequence>
							<xs:element name="ReferenceNumber" minOccurs="1" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="Registriernummer vZA/AZ"/>
										<aie:id value="2042"/>
										<aie:status value="R"/>
										<aie:format value="an21"/>
										<aie:pcre value="\AAT[A-Z][0-9]{2}[0-9]{6}(?:0[1-9]|1[0-2])20[0-9]{2}[0-9]{4}\Z"/>
									</xs:documentation>
								</xs:annotation>
								<xs:simpleType>
									<xs:restriction base="xs:token">
										<xs:length value="21"/>
										<xs:pattern value="AT[A-Z][0-9]{2}[0-9]{6}(0[1-9]|1[0-2])20[0-9]{2}[0-9]{4}"/>
									</xs:restriction>
								</xs:simpleType>
							</xs:element>
							<xs:element name="CustomsValueFlag" minOccurs="1" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="Kennzeichen D.V.1"/>
										<aie:id value="2189"/>
										<aie:status value="R"/>
										<aie:format value="an1"/>
										<aie:pcre value="\A.\Z"/>
										<aie:list value="A1460"/>
									</xs:documentation>
								</xs:annotation>
								<xs:simpleType>
									<xs:restriction base="xs:token">
										<xs:length value="1"/>
									</xs:restriction>
								</xs:simpleType>
							</xs:element>
							<xs:element name="Consignor" minOccurs="1" maxOccurs="1" id="CO1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="ANGABEN ZUM VERSENDER/AUSFÜHRER"/>
										<aie:id value="2162"/>
										<aie:status value="R"/>
									</xs:documentation>
								</xs:annotation>
								<xs:complexType>
									<xs:sequence>
										<xs:element name="Identification" minOccurs="0" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="TIN"/>
													<aie:status value="D"/>
												</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:sequence>
													<xs:element name="ReferenceNumber" minOccurs="1" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:id value="2166"/>
																<aie:format value="an..17"/>
																<aie:pcre value="\A[A-Z]{2}[\x21-\x7E]{1,15}\Z"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:minLength value="1"/>
																<xs:maxLength value="17"/>
																<xs:pattern value="[A-Z]{2}[&#x21;-&#x7E;]{1,15}"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
												</xs:sequence>
											</xs:complexType>
										</xs:element>
										<xs:element name="Name" minOccurs="0" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Name"/>
													<aie:id value="2164"/>
													<aie:status value="D"/>
													<aie:format value="an..120"/>
													<aie:pcre value="\A.{1,120}\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:minLength value="1"/>
													<xs:maxLength value="120"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="Address" minOccurs="0" maxOccurs="1" id="COA">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="VERSENDER/AUSFÜHRER (ADRESSDATEN)"/>
													<aie:id value="2167"/>
													<aie:status value="D"/>
												</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:sequence>
													<xs:element name="Line" minOccurs="1" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Straße und Hausnummer"/>
																<aie:id value="2173"/>
																<aie:status value="R"/>
																<aie:format value="an..35"/>
																<aie:pcre value="\A.{1,35}\Z"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:minLength value="1"/>
																<xs:maxLength value="35"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="Country" minOccurs="1" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Land"/>
																<aie:id value="2168"/>
																<aie:status value="R"/>
																<aie:format value="an2"/>
																<aie:pcre value="\A[A-Z]{2}\Z"/>
																<aie:list value="I0300"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:length value="2"/>
																<xs:pattern value="[A-Z]{2}"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="Postcode" minOccurs="0" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Postleitzahl"/>
																<aie:id value="2172"/>
																<aie:status value="D"/>
																<aie:format value="an..9"/>
																<aie:pcre value="\A.{1,9}\Z"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:minLength value="1"/>
																<xs:maxLength value="9"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="City" minOccurs="1" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Ort"/>
																<aie:id value="2169"/>
																<aie:status value="R"/>
																<aie:format value="an..35"/>
																<aie:pcre value="\A.{1,35}\Z"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:minLength value="1"/>
																<xs:maxLength value="35"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="District" minOccurs="0" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Ortsteil"/>
																<aie:id value="2170"/>
																<aie:status value="O"/>
																<aie:format value="an..35"/>
																<aie:pcre value="\A.{1,35}\Z"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:minLength value="1"/>
																<xs:maxLength value="35"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
												</xs:sequence>
											</xs:complexType>
										</xs:element>
									</xs:sequence>
								</xs:complexType>
							</xs:element>
							<xs:element name="Consignee" minOccurs="0" maxOccurs="1" id="CE1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="ANGABEN ZUM EMPFÄNGER"/>
										<aie:id value="2091"/>
										<aie:status value="D"/>
									</xs:documentation>
								</xs:annotation>
								<xs:complexType>
									<xs:sequence>
										<xs:element name="Identification" minOccurs="0" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
												</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:sequence>
													<xs:element name="ReferenceNumber" minOccurs="0" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="TIN"/>
																<aie:id value="2095"/>
																<aie:status value="D"/>
																<aie:format value="an..17"/>
																<aie:pcre value="\A[A-Z]{2}[\x21-\x7E]{1,15}\Z"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:minLength value="1"/>
																<xs:maxLength value="17"/>
																<xs:pattern value="[A-Z]{2}[&#x21;-&#x7E;]{1,15}"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="SubsidiaryNumber" minOccurs="0" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Niederlassungsnummer"/>
																<aie:id value="2094"/>
																<aie:status value="D"/>
																<aie:format value="n4"/>
																<aie:pcre value="\A[0-9]{4}\Z"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:length value="4"/>
																<xs:pattern value="[0-9]{4}"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
												</xs:sequence>
											</xs:complexType>
										</xs:element>
										<xs:element name="Name" minOccurs="0" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Name"/>
													<aie:id value="2093"/>
													<aie:status value="D"/>
													<aie:format value="an..120"/>
													<aie:pcre value="\A.{1,120}\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:minLength value="1"/>
													<xs:maxLength value="120"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="Address" minOccurs="0" maxOccurs="1" id="CEA">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="EMPFÄNGER (ADRESSDATEN)"/>
													<aie:id value="2096"/>
													<aie:status value="D"/>
												</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:sequence>
													<xs:element name="Line" minOccurs="1" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Straße und Hausnummer"/>
																<aie:id value="2102"/>
																<aie:status value="R"/>
																<aie:format value="an..35"/>
																<aie:pcre value="\A.{1,35}\Z"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:minLength value="1"/>
																<xs:maxLength value="35"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="Country" minOccurs="1" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Land"/>
																<aie:id value="2097"/>
																<aie:status value="R"/>
																<aie:format value="an2"/>
																<aie:pcre value="\A[A-Z]{2}\Z"/>
																<aie:list value="I0300"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:length value="2"/>
																<xs:pattern value="[A-Z]{2}"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="Postcode" minOccurs="0" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Postleitzahl"/>
																<aie:id value="2101"/>
																<aie:status value="D"/>
																<aie:format value="an..9"/>
																<aie:pcre value="\A.{1,9}\Z"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:minLength value="1"/>
																<xs:maxLength value="9"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="City" minOccurs="1" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Ort"/>
																<aie:id value="2098"/>
																<aie:status value="R"/>
																<aie:format value="an..35"/>
																<aie:pcre value="\A.{1,35}\Z"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:minLength value="1"/>
																<xs:maxLength value="35"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="District" minOccurs="0" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Ortsteil"/>
																<aie:id value="2099"/>
																<aie:status value="O"/>
																<aie:format value="an..35"/>
																<aie:pcre value="\A.{1,35}\Z"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:minLength value="1"/>
																<xs:maxLength value="35"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
												</xs:sequence>
											</xs:complexType>
										</xs:element>
									</xs:sequence>
								</xs:complexType>
							</xs:element>
							<xs:element name="Acquirer" minOccurs="0" maxOccurs="1" id="UC0">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="ANGABEN ZUM ERWERBER IM ANDEREN MITGLIEDSTAAT"/>
										<aie:id value="2114"/>
										<aie:status value="D"/>
									</xs:documentation>
								</xs:annotation>
								<xs:complexType>
									<xs:sequence>
										<xs:element name="Identification" minOccurs="0" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
												</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:sequence>
													<xs:element name="ReferenceNumber" minOccurs="0" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="TIN"/>
																<aie:id value="2118"/>
																<aie:status value="D"/>
																<aie:format value="an..17"/>
																<aie:pcre value="\A[A-Z]{2}[\x21-\x7E]{1,15}\Z"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:minLength value="1"/>
																<xs:maxLength value="17"/>
																<xs:pattern value="[A-Z]{2}[&#x21;-&#x7E;]{1,15}"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="SubsidiaryNumber" minOccurs="0" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Niederlassungsnummer"/>
																<aie:id value="2117"/>
																<aie:status value="D"/>
																<aie:format value="n4"/>
																<aie:pcre value="\A[0-9]{4}\Z"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:length value="4"/>
																<xs:pattern value="[0-9]{4}"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
												</xs:sequence>
											</xs:complexType>
										</xs:element>
										<xs:element name="Name" minOccurs="0" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Name"/>
													<aie:id value="2116"/>
													<aie:status value="D"/>
													<aie:format value="an..120"/>
													<aie:pcre value="\A.{1,120}\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:minLength value="1"/>
													<xs:maxLength value="120"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="TaxNumber" minOccurs="0" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="USt-IdNr."/>
													<aie:id value="2137"/>
													<aie:status value="D"/>
													<aie:format value="an..20"/>
													<aie:pcre value="\A[A-Z]{2}.{1,12}\Z"/>
													<aie:list value="A1835"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:minLength value="1"/>
													<xs:maxLength value="20"/>
													<xs:pattern value="[A-Z]{2}.{1,12}"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="Address" minOccurs="0" maxOccurs="1" id="UC1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="ERWERBER (ADRESSDATEN)"/>
													<aie:id value="2119"/>
													<aie:status value="D"/>
												</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:sequence>
													<xs:element name="Line" minOccurs="1" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Straße und Hausnummer"/>
																<aie:id value="2125"/>
																<aie:status value="R"/>
																<aie:format value="an..35"/>
																<aie:pcre value="\A.{1,35}\Z"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:minLength value="1"/>
																<xs:maxLength value="35"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="Country" minOccurs="1" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Land"/>
																<aie:id value="2120"/>
																<aie:status value="R"/>
																<aie:format value="an2"/>
																<aie:pcre value="\A[A-Z]{2}\Z"/>
																<aie:list value="I0300"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:length value="2"/>
																<xs:pattern value="[A-Z]{2}"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="Postcode" minOccurs="0" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Postleitzahl"/>
																<aie:id value="2124"/>
																<aie:status value="D"/>
																<aie:format value="an..9"/>
																<aie:pcre value="\A.{1,9}\Z"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:minLength value="1"/>
																<xs:maxLength value="9"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="City" minOccurs="1" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Ort"/>
																<aie:id value="2121"/>
																<aie:status value="R"/>
																<aie:format value="an..35"/>
																<aie:pcre value="\A.{1,35}\Z"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:minLength value="1"/>
																<xs:maxLength value="35"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="District" minOccurs="0" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Ortsteil"/>
																<aie:id value="2122"/>
																<aie:status value="O"/>
																<aie:format value="an..35"/>
																<aie:pcre value="\A.{1,35}\Z"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:minLength value="1"/>
																<xs:maxLength value="35"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
												</xs:sequence>
											</xs:complexType>
										</xs:element>
									</xs:sequence>
								</xs:complexType>
							</xs:element>
							<xs:element name="DeliveryTerms" minOccurs="1" maxOccurs="1" id="RAL">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="ANGABEN ZUR LIEFERBEDINGUNG"/>
										<aie:id value="2138"/>
										<aie:status value="R"/>
									</xs:documentation>
								</xs:annotation>
								<xs:complexType>
									<xs:sequence>
										<xs:element name="Code" minOccurs="1" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Lieferbedingung"/>
													<aie:id value="2139"/>
													<aie:status value="R"/>
													<aie:format value="an3"/>
													<aie:pcre value="\A.{3}\Z"/>
													<aie:list value="A1840"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:length value="3"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="Description" minOccurs="0" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Lieferbedingung-Incoterm"/>
													<aie:id value="2140"/>
													<aie:status value="D"/>
													<aie:format value="an..100"/>
													<aie:pcre value="\A.{1,100}\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:minLength value="1"/>
													<xs:maxLength value="100"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="Place" minOccurs="1" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Lieferbedingung-Ort"/>
													<aie:id value="2141"/>
													<aie:status value="R"/>
													<aie:format value="an..35"/>
													<aie:pcre value="\A.{1,35}\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:minLength value="1"/>
													<xs:maxLength value="35"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="Key" minOccurs="1" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Lieferbedingung-Schlüssel"/>
													<aie:id value="2142"/>
													<aie:status value="R"/>
													<aie:format value="an1"/>
													<aie:pcre value="\A.\Z"/>
													<aie:list value="A1850"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:length value="1"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
									</xs:sequence>
								</xs:complexType>
							</xs:element>
							<xs:element name="PaymentTransaction" minOccurs="0" maxOccurs="1" id="MOP">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="ANGABEN ZUM ZAHLUNGSVERKEHR"/>
										<aie:id value="2185"/>
										<aie:status value="D"/>
									</xs:documentation>
								</xs:annotation>
								<xs:complexType>
									<xs:sequence>
										<xs:element name="Amount" minOccurs="0" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Rechnungspreis"/>
													<aie:id value="2186"/>
													<aie:status value="O"/>
													<aie:format value="n..13 (13,2)"/>
													<aie:pcre value="\A(?:0|[1-9][0-9]{0,10})(?:\.[0-9]{1,2})?\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:decimal">
													<xs:minInclusive value="0.00"/>
													<xs:maxInclusive value="99999999999.99"/>
													<xs:totalDigits value="13"/>
													<xs:fractionDigits value="2"/>
													<xs:pattern value="(0|[1-9][0-9]{0,10})(\.[0-9]{1,2})?"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="CurrencyCode" minOccurs="0" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Währungsschlüssel"/>
													<aie:id value="2187"/>
													<aie:status value="D"/>
													<aie:format value="an3"/>
													<aie:pcre value="\A.{3}\Z"/>
													<aie:list value="I0400"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:length value="3"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
									</xs:sequence>
								</xs:complexType>
							</xs:element>
							<xs:element name="ForeignTradeStatistics" minOccurs="0" maxOccurs="1" id="RAS">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="DATEN FÜR DIE AUSSENHANDELSSTATISTIK VZA/AZ (KOPF)"/>
										<aie:id value="2043"/>
										<aie:status value="O"/>
									</xs:documentation>
								</xs:annotation>
								<xs:complexType>
									<xs:sequence>
										<xs:element name="EntryCustomsOffice" minOccurs="1" maxOccurs="1" id="RSE">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="ANGABEN ZUR EINGANGSZOLLSTELLE"/>
													<aie:id value="2056"/>
													<aie:status value="R"/>
												</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:sequence>
													<xs:element name="ReferenceNumber" minOccurs="1" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Eingangszollstelle"/>
																<aie:id value="2059"/>
																<aie:status value="R"/>
																<aie:format value="an8"/>
																<aie:pcre value="\ADE00[0-9]{4}\Z"/>
																<aie:list value="I0500"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:length value="8"/>
																<xs:pattern value="DE00[0-9]{4}"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
												</xs:sequence>
											</xs:complexType>
										</xs:element>
									</xs:sequence>
								</xs:complexType>
							</xs:element>
							<xs:element name="CustomsValue" minOccurs="0" maxOccurs="1" id="RZW">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="ANMELDUNG DER ANGABEN ÜBER DEN ZOLLWERT (D.V.1) VZA/AZ (KOPF)"/>
										<aie:id value="2188"/>
										<aie:status value="D"/>
									</xs:documentation>
								</xs:annotation>
								<xs:complexType>
									<xs:sequence>
										<xs:element name="FormerDecisions" minOccurs="0" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Frühere Entscheidungen"/>
													<aie:id value="2193"/>
													<aie:status value="O"/>
													<aie:format value="an..100"/>
													<aie:pcre value="\A.{1,100}\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:minLength value="1"/>
													<xs:maxLength value="100"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="Vendor" minOccurs="1" maxOccurs="1" id="SE0">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="ANGABEN ZUM VERKÄUFER"/>
													<aie:id value="2234"/>
													<aie:status value="R"/>
												</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:sequence>
													<xs:element name="Identification" minOccurs="0" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="TIN"/>
																<aie:status value="D"/>
															</xs:documentation>
														</xs:annotation>
														<xs:complexType>
															<xs:sequence>
																<xs:element name="ReferenceNumber" minOccurs="1" maxOccurs="1">
																	<xs:annotation>
																		<xs:documentation>
																			<aie:id value="2238"/>
																			<aie:format value="an..17"/>
																			<aie:pcre value="\A[A-Z]{2}[\x21-\x7E]{1,15}\Z"/>
																		</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:token">
																			<xs:minLength value="1"/>
																			<xs:maxLength value="17"/>
																			<xs:pattern value="[A-Z]{2}[&#x21;-&#x7E;]{1,15}"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
															</xs:sequence>
														</xs:complexType>
													</xs:element>
													<xs:element name="Name" minOccurs="0" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Name"/>
																<aie:id value="2236"/>
																<aie:status value="D"/>
																<aie:format value="an..120"/>
																<aie:pcre value="\A.{1,120}\Z"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:minLength value="1"/>
																<xs:maxLength value="120"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="Address" minOccurs="0" maxOccurs="1" id="SE1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="VERKÄUFER (ADRESSDATEN)"/>
																<aie:id value="2239"/>
																<aie:status value="D"/>
															</xs:documentation>
														</xs:annotation>
														<xs:complexType>
															<xs:sequence>
																<xs:element name="Line" minOccurs="1" maxOccurs="1">
																	<xs:annotation>
																		<xs:documentation>
																			<aie:name value="Straße und Hausnummer"/>
																			<aie:id value="2245"/>
																			<aie:status value="R"/>
																			<aie:format value="an..35"/>
																			<aie:pcre value="\A.{1,35}\Z"/>
																		</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:token">
																			<xs:minLength value="1"/>
																			<xs:maxLength value="35"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
																<xs:element name="Country" minOccurs="1" maxOccurs="1">
																	<xs:annotation>
																		<xs:documentation>
																			<aie:name value="Land"/>
																			<aie:id value="2240"/>
																			<aie:status value="R"/>
																			<aie:format value="an2"/>
																			<aie:pcre value="\A[A-Z]{2}\Z"/>
																			<aie:list value="I0300"/>
																		</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:token">
																			<xs:length value="2"/>
																			<xs:pattern value="[A-Z]{2}"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
																<xs:element name="Postcode" minOccurs="0" maxOccurs="1">
																	<xs:annotation>
																		<xs:documentation>
																			<aie:name value="Postleitzahl"/>
																			<aie:id value="2244"/>
																			<aie:status value="D"/>
																			<aie:format value="an..9"/>
																			<aie:pcre value="\A.{1,9}\Z"/>
																		</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:token">
																			<xs:minLength value="1"/>
																			<xs:maxLength value="9"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
																<xs:element name="City" minOccurs="1" maxOccurs="1">
																	<xs:annotation>
																		<xs:documentation>
																			<aie:name value="Ort"/>
																			<aie:id value="2241"/>
																			<aie:status value="R"/>
																			<aie:format value="an..35"/>
																			<aie:pcre value="\A.{1,35}\Z"/>
																		</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:token">
																			<xs:minLength value="1"/>
																			<xs:maxLength value="35"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
																<xs:element name="District" minOccurs="0" maxOccurs="1">
																	<xs:annotation>
																		<xs:documentation>
																			<aie:name value="Ortsteil"/>
																			<aie:id value="2242"/>
																			<aie:status value="O"/>
																			<aie:format value="an..35"/>
																			<aie:pcre value="\A.{1,35}\Z"/>
																		</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:token">
																			<xs:minLength value="1"/>
																			<xs:maxLength value="35"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
															</xs:sequence>
														</xs:complexType>
													</xs:element>
												</xs:sequence>
											</xs:complexType>
										</xs:element>
										<xs:element name="Vendee" minOccurs="1" maxOccurs="1" id="BY0">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="ANGABEN ZUM KÄUFER"/>
													<aie:id value="2205"/>
													<aie:status value="R"/>
												</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:sequence>
													<xs:element name="Identification" minOccurs="0" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="TIN"/>
																<aie:status value="D"/>
															</xs:documentation>
														</xs:annotation>
														<xs:complexType>
															<xs:sequence>
																<xs:element name="ReferenceNumber" minOccurs="1" maxOccurs="1">
																	<xs:annotation>
																		<xs:documentation>
																			<aie:id value="2209"/>
																			<aie:format value="an..17"/>
																			<aie:pcre value="\A[A-Z]{2}[\x21-\x7E]{1,15}\Z"/>
																		</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:token">
																			<xs:minLength value="1"/>
																			<xs:maxLength value="17"/>
																			<xs:pattern value="[A-Z]{2}[&#x21;-&#x7E;]{1,15}"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
															</xs:sequence>
														</xs:complexType>
													</xs:element>
													<xs:element name="Name" minOccurs="0" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Name"/>
																<aie:id value="2207"/>
																<aie:status value="D"/>
																<aie:format value="an..120"/>
																<aie:pcre value="\A.{1,120}\Z"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:minLength value="1"/>
																<xs:maxLength value="120"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="Address" minOccurs="0" maxOccurs="1" id="BY1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="KÄUFER (ADRESSDATEN)"/>
																<aie:id value="2210"/>
																<aie:status value="D"/>
															</xs:documentation>
														</xs:annotation>
														<xs:complexType>
															<xs:sequence>
																<xs:element name="Line" minOccurs="1" maxOccurs="1">
																	<xs:annotation>
																		<xs:documentation>
																			<aie:name value="Straße und Hausnummer"/>
																			<aie:id value="2216"/>
																			<aie:status value="R"/>
																			<aie:format value="an..35"/>
																			<aie:pcre value="\A.{1,35}\Z"/>
																		</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:token">
																			<xs:minLength value="1"/>
																			<xs:maxLength value="35"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
																<xs:element name="Country" minOccurs="1" maxOccurs="1">
																	<xs:annotation>
																		<xs:documentation>
																			<aie:name value="Land"/>
																			<aie:id value="2211"/>
																			<aie:status value="R"/>
																			<aie:format value="an2"/>
																			<aie:pcre value="\A[A-Z]{2}\Z"/>
																			<aie:list value="I0300"/>
																		</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:token">
																			<xs:length value="2"/>
																			<xs:pattern value="[A-Z]{2}"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
																<xs:element name="Postcode" minOccurs="0" maxOccurs="1">
																	<xs:annotation>
																		<xs:documentation>
																			<aie:name value="Postleitzahl"/>
																			<aie:id value="2215"/>
																			<aie:status value="D"/>
																			<aie:format value="an..9"/>
																			<aie:pcre value="\A.{1,9}\Z"/>
																		</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:token">
																			<xs:minLength value="1"/>
																			<xs:maxLength value="9"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
																<xs:element name="City" minOccurs="1" maxOccurs="1">
																	<xs:annotation>
																		<xs:documentation>
																			<aie:name value="Ort"/>
																			<aie:id value="2212"/>
																			<aie:status value="R"/>
																			<aie:format value="an..35"/>
																			<aie:pcre value="\A.{1,35}\Z"/>
																		</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:token">
																			<xs:minLength value="1"/>
																			<xs:maxLength value="35"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
																<xs:element name="District" minOccurs="0" maxOccurs="1">
																	<xs:annotation>
																		<xs:documentation>
																			<aie:name value="Ortsteil"/>
																			<aie:id value="2213"/>
																			<aie:status value="O"/>
																			<aie:format value="an..35"/>
																			<aie:pcre value="\A.{1,35}\Z"/>
																		</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:token">
																			<xs:minLength value="1"/>
																			<xs:maxLength value="35"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
															</xs:sequence>
														</xs:complexType>
													</xs:element>
												</xs:sequence>
											</xs:complexType>
										</xs:element>
										<xs:element name="Affiliation" minOccurs="1" maxOccurs="1" id="KZV">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="ANGABEN ZUR VERBUNDENHEIT"/>
													<aie:id value="2231"/>
													<aie:status value="R"/>
												</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:sequence>
													<xs:element name="Type" minOccurs="1" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Kennzeichen Verbundenheit Verkäufer und Käufer"/>
																<aie:id value="2233"/>
																<aie:status value="R"/>
																<aie:format value="an1"/>
																<aie:pcre value="\A.\Z"/>
																<aie:list value="A1760"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:length value="1"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="Description" minOccurs="0" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Einzelheiten der Verbundenheit von Verkäufer und Käufer"/>
																<aie:id value="2232"/>
																<aie:status value="D"/>
																<aie:format value="an..100"/>
																<aie:pcre value="\A.{1,100}\Z"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:minLength value="1"/>
																<xs:maxLength value="100"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
												</xs:sequence>
											</xs:complexType>
										</xs:element>
										<xs:element name="RestrictionOrCondition" minOccurs="1" maxOccurs="1" id="KZE">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="ANGABEN ZU BEDINGUNGEN/LEISTUNGEN"/>
													<aie:id value="2201"/>
													<aie:status value="R"/>
												</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:sequence>
													<xs:element name="RestrictionFlag" minOccurs="1" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Einschränkungen"/>
																<aie:id value="2204"/>
																<aie:status value="R"/>
																<aie:format value="an1"/>
																<aie:pcre value="\A.\Z"/>
																<aie:list value="A1310"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:length value="1"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="ConditionFlag" minOccurs="1" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Bedingungen/Leistungen"/>
																<aie:id value="2203"/>
																<aie:status value="R"/>
																<aie:format value="an1"/>
																<aie:pcre value="\A.\Z"/>
																<aie:list value="A1220"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:length value="1"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="Description" minOccurs="0" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Einschränkungs-/Bedingungsart"/>
																<aie:id value="2202"/>
																<aie:status value="D"/>
																<aie:format value="an..100"/>
																<aie:pcre value="\A.{1,100}\Z"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:minLength value="1"/>
																<xs:maxLength value="100"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
												</xs:sequence>
											</xs:complexType>
										</xs:element>
										<xs:element name="LicenseFee" minOccurs="1" maxOccurs="1" id="KZL">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="ANGABEN ZU LIZENZGEBÜHREN"/>
													<aie:id value="2228"/>
													<aie:status value="R"/>
												</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:sequence>
													<xs:element name="LicenseFeeFlag" minOccurs="1" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Kennzeichen Lizenzgebühren"/>
																<aie:id value="2229"/>
																<aie:status value="R"/>
																<aie:format value="an1"/>
																<aie:pcre value="\A.\Z"/>
																<aie:list value="A1620"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:length value="1"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="Description" minOccurs="0" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Umstände Lizenzgebühren"/>
																<aie:id value="2230"/>
																<aie:status value="D"/>
																<aie:format value="an..100"/>
																<aie:pcre value="\A.{1,100}\Z"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:minLength value="1"/>
																<xs:maxLength value="100"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
												</xs:sequence>
											</xs:complexType>
										</xs:element>
										<xs:element name="Resale" minOccurs="1" maxOccurs="1" id="KZU">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="ANGABEN ZU WEITERVERKÄUFE/ÜBERLASSUNGEN/VERWENDUNGEN"/>
													<aie:id value="2280"/>
													<aie:status value="R"/>
												</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:sequence>
													<xs:element name="ResaleFlag" minOccurs="1" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Kennzeichen Weiterverkäufe/Überlassungen/Verwendungen"/>
																<aie:id value="2281"/>
																<aie:status value="R"/>
																<aie:format value="an1"/>
																<aie:pcre value="\A.\Z"/>
																<aie:list value="A1800"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:length value="1"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="Description" minOccurs="0" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Umstände zu Weiterverkäufe/Überlassungen/Verwendungen"/>
																<aie:id value="2282"/>
																<aie:status value="D"/>
																<aie:format value="an..100"/>
																<aie:pcre value="\A.{1,100}\Z"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:minLength value="1"/>
																<xs:maxLength value="100"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
												</xs:sequence>
											</xs:complexType>
										</xs:element>
									</xs:sequence>
								</xs:complexType>
							</xs:element>
							<xs:element name="Document" minOccurs="0" maxOccurs="20" id="RUX">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="ANGABEN ZU VORGELEGTEN UNTERLAGEN ZU EINER ZOLLANMELDUNG VZA/AZ (KOPF)"/>
										<aie:id value="2143"/>
										<aie:status value="O"/>
									</xs:documentation>
								</xs:annotation>
								<xs:complexType>
									<xs:sequence>
										<xs:element name="Division" minOccurs="1" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Bereich der Unterlage (Anmeldung)"/>
													<aie:id value="2146"/>
													<aie:status value="R"/>
													<aie:format value="an1"/>
													<aie:pcre value="\A4\Z"/>
													<aie:list value="A1255"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:length value="1"/>
													<xs:enumeration value="4"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="Type" minOccurs="1" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Art der Unterlage (Anmeldung)"/>
													<aie:id value="2152"/>
													<aie:status value="R"/>
													<aie:format value="an4"/>
													<aie:pcre value="\A.{4}\Z"/>
													<aie:list value="I0200"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:length value="4"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="ReferenceNumber" minOccurs="1" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Nummer vorgelegte Unterlage"/>
													<aie:id value="2151"/>
													<aie:status value="R"/>
													<aie:format value="an..35"/>
													<aie:pcre value="\A.{1,35}\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:minLength value="1"/>
													<xs:maxLength value="35"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="IssuingDate" minOccurs="1" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Datum vorgelegte Unterlage"/>
													<aie:id value="2147"/>
													<aie:status value="R"/>
													<aie:format value="Date (n8)"/>
													<aie:pcre value="\A(?:(?:(?:0[48]|[2468][048]|[13579][26])(?:[02468][048]|[13579][26])|(?:[02468][1-35-79]|[13579][013-57-9])(?:0[48]|[2468][048]|[13579][26]))-02-29|[0-9][0-9][0-9][0-9]-(?:(?:0[13578]|1[02])-(?:0[1-9]|[12][0-9]|3[01])|(?:0[469]|11)-(?:0[1-9]|[12][0-9]|30)|02-(?:0[1-9]|1[0-9]|2[0-8])))\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:date">
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
									</xs:sequence>
								</xs:complexType>
							</xs:element>
							<xs:element name="GoodsItem" minOccurs="1" maxOccurs="999" id="GDS">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="POSITION"/>
										<aie:id value="2306"/>
										<aie:status value="R"/>
									</xs:documentation>
								</xs:annotation>
								<xs:complexType>
									<xs:sequence>
										<xs:element name="SequenceNumber" minOccurs="1" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Positionsnummer in der EGZ"/>
													<aie:id value="2356"/>
													<aie:status value="R"/>
													<aie:format value="n..5"/>
													<aie:pcre value="\A[1-9][0-9]{0,4}\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:integer">
													<xs:minInclusive value="1"/>
													<xs:maxInclusive value="99999"/>
													<xs:totalDigits value="5"/>
													<xs:pattern value="[1-9][0-9]{0,4}"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="ReferredSequenceNumber" minOccurs="1" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Positionsnummer in der vZA/AZ"/>
													<aie:id value="2383"/>
													<aie:status value="R"/>
													<aie:format value="n..3"/>
													<aie:pcre value="\A[1-9][0-9]{0,2}\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:integer">
													<xs:minInclusive value="1"/>
													<xs:maxInclusive value="999"/>
													<xs:totalDigits value="3"/>
													<xs:pattern value="[1-9][0-9]{0,2}"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="CessionManagementFlag" minOccurs="0" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Kennzeichen Abgabensteuerung"/>
													<aie:id value="2307"/>
													<aie:status value="O"/>
													<aie:format value="an2"/>
													<aie:pcre value="\A.{2}\Z"/>
													<aie:list value="A1345"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:length value="2"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="MatterCode" minOccurs="1" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Sachbereich"/>
													<aie:id value="2363"/>
													<aie:status value="R"/>
													<aie:format value="an2"/>
													<aie:pcre value="\A.{2}\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:length value="2"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="ArticleNumber" minOccurs="0" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Artikelnummer"/>
													<aie:id value="2318"/>
													<aie:status value="O"/>
													<aie:format value="an..35"/>
													<aie:pcre value="\A.{1,35}\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:minLength value="1"/>
													<xs:maxLength value="35"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="InvoiceAmount" minOccurs="1" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Artikelpreis"/>
													<aie:id value="2319"/>
													<aie:status value="R"/>
													<aie:format value="n..11 (11,2)"/>
													<aie:pcre value="\A(?:0|[1-9][0-9]{0,8})(?:\.[0-9]{1,2})?\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:decimal">
													<xs:minInclusive value="0.00"/>
													<xs:maxInclusive value="999999999.99"/>
													<xs:totalDigits value="11"/>
													<xs:fractionDigits value="2"/>
													<xs:pattern value="(0|[1-9][0-9]{0,8})(\.[0-9]{1,2})?"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="NetMassMeasure" minOccurs="0" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Eigenmasse"/>
													<aie:id value="2335"/>
													<aie:status value="D"/>
													<aie:format value="n..10 (10,1)"/>
													<aie:pcre value="\A(?:0|[1-9][0-9]{0,8})(?:\.[0-9])?\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:decimal">
													<xs:minInclusive value="0.0"/>
													<xs:maxInclusive value="999999999.9"/>
													<xs:totalDigits value="10"/>
													<xs:fractionDigits value="1"/>
													<xs:pattern value="(0|[1-9][0-9]{0,8})(\.[0-9])?"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="OriginCountry" minOccurs="0" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Ursprungsland"/>
													<aie:id value="2376"/>
													<aie:status value="D"/>
													<aie:format value="an2"/>
													<aie:pcre value="\A.{2}\Z"/>
													<aie:list value="I0300"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:length value="2"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="DepartureCountry" minOccurs="0" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Versendungsland"/>
													<aie:id value="2378"/>
													<aie:status value="D"/>
													<aie:format value="an2"/>
													<aie:pcre value="\A.{2}\Z"/>
													<aie:list value="I0300"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:length value="2"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="SupplementaryInformation" minOccurs="0" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Positionszusatz"/>
													<aie:id value="2358"/>
													<aie:status value="O"/>
													<aie:format value="an..100"/>
													<aie:pcre value="\A.{1,100}\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:minLength value="1"/>
													<xs:maxLength value="100"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="CompleteDeclarationFlag" minOccurs="1" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Kennzeichen Vollständige Angaben"/>
													<aie:id value="2381"/>
													<aie:status value="R"/>
													<aie:format value="an1"/>
													<aie:pcre value="\A.\Z"/>
													<aie:list value="A1750"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:length value="1"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="TobaccoRevenueStampNumber" minOccurs="0" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Tabaksteuerzeichen-Nummer"/>
													<aie:id value="2370"/>
													<aie:status value="D"/>
													<aie:format value="an5"/>
													<aie:pcre value="\A.{5}\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:length value="5"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="CommodityCode" minOccurs="0" maxOccurs="1" id="COM">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="ANGABE WARENNUMMER"/>
													<aie:id value="3247"/>
													<aie:status value="D"/>
												</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:sequence>
													<xs:element name="CommodityCode" minOccurs="1" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Warennummer"/>
																<aie:id value="3248"/>
																<aie:status value="R"/>
																<aie:format value="an11"/>
																<aie:pcre value="\A.{11}\Z"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:length value="11"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
												</xs:sequence>
											</xs:complexType>
										</xs:element>
										<xs:element name="AdditionalProcedure" minOccurs="0" maxOccurs="99" id="ADL">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="ANGABEN ZU EU-CODES"/>
													<aie:id value="4945"/>
													<aie:status value="O"/>
												</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:sequence>
													<xs:element name="Code" minOccurs="1" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="EU-Code"/>
																<aie:id value="4946"/>
																<aie:status value="R"/>
																<aie:format value="an3"/>
																<aie:pcre value="\A.{3}\Z"/>
																<aie:list value="I0100"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:length value="3"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
												</xs:sequence>
											</xs:complexType>
										</xs:element>
										<xs:element name="SupplementaryCodes" minOccurs="0" maxOccurs="10" id="PZC">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="ANGABEN ZU ZUSATZCODES"/>
													<aie:id value="3316"/>
													<aie:status value="D"/>
												</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:sequence>
													<xs:element name="Code" minOccurs="1" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Zusatzcode"/>
																<aie:id value="3317"/>
																<aie:status value="R"/>
																<aie:format value="an4"/>
																<aie:pcre value="\A.{4}\Z"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:length value="4"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
												</xs:sequence>
											</xs:complexType>
										</xs:element>
										<xs:element name="ForeignTradeStatistics" minOccurs="1" maxOccurs="1" id="PAS">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="DATEN FÜR DIE AUSSENHANDELSSTATISTIK EGZ (POSITION)"/>
													<aie:id value="2561"/>
													<aie:status value="R"/>
												</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:sequence>
													<xs:element name="GoodsStatus" minOccurs="1" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Statistikstatus"/>
																<aie:id value="2567"/>
																<aie:status value="R"/>
																<aie:format value="an2"/>
																<aie:pcre value="\A.{2}\Z"/>
																<aie:list value="A1920"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:length value="2"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="TransactionType" minOccurs="1" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Art des Geschäfts"/>
																<aie:id value="2564"/>
																<aie:status value="R"/>
																<aie:format value="an2"/>
																<aie:pcre value="\A.{2}\Z"/>
																<aie:list value="A1150"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:length value="2"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="DestinationCountry" minOccurs="1" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Bestimmungslandcode"/>
																<aie:id value="2563"/>
																<aie:status value="R"/>
																<aie:format value="an2"/>
																<aie:pcre value="\A.{2}\Z"/>
																<aie:list value="A1314"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:length value="2"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="DestinationFederalState" minOccurs="1" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Bestimmungsbundesland"/>
																<aie:id value="2562"/>
																<aie:status value="R"/>
																<aie:format value="an2"/>
																<aie:pcre value="\A.{2}\Z"/>
																<aie:list value="A1270"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:length value="2"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="InlandTransportMode" minOccurs="0" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Verkehrszweig im Inland"/>
																<aie:id value="2568"/>
																<aie:status value="D"/>
																<aie:format value="an1"/>
																<aie:pcre value="\A.\Z"/>
																<aie:list value="A1990"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:length value="1"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="Quantity" minOccurs="1" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Wert"/>
																<aie:id value="2569"/>
																<aie:status value="R"/>
																<aie:format value="n..9"/>
																<aie:pcre value="\A[1-9][0-9]{0,8}\Z"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:integer">
																<xs:minInclusive value="1"/>
																<xs:maxInclusive value="999999999"/>
																<xs:totalDigits value="9"/>
																<xs:pattern value="[1-9][0-9]{0,8}"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="GrossMassMeasure" minOccurs="0" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Rohmasse-Position"/>
																<aie:id value="2565"/>
																<aie:status value="O"/>
																<aie:format value="n..10 (10,1)"/>
																<aie:pcre value="\A(?!0\.?0*\Z)(?:0|[1-9][0-9]{0,8})(?:\.[0-9])?\Z"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:decimal">
																<xs:minInclusive value="0.1"/>
																<xs:maxInclusive value="999999999.9"/>
																<xs:totalDigits value="10"/>
																<xs:fractionDigits value="1"/>
																<xs:pattern value="(0|[1-9][0-9]{0,8})(\.[0-9])?"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="Amount" minOccurs="0" maxOccurs="1" id="PAM">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="ANGABEN ZUR AH-STAT. MENGE"/>
																<aie:id value="2570"/>
																<aie:status value="D"/>
															</xs:documentation>
														</xs:annotation>
														<xs:complexType>
															<xs:sequence>
																<xs:element name="Quantity" minOccurs="1" maxOccurs="1">
																	<xs:annotation>
																		<xs:documentation>
																			<aie:name value="Menge"/>
																			<aie:id value="2572"/>
																			<aie:status value="R"/>
																			<aie:format value="n..12 (12,3)"/>
																			<aie:pcre value="\A(?!0\.?0*\Z)(?:0|[1-9][0-9]{0,8})(?:\.[0-9]{1,3})?\Z"/>
																		</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:decimal">
																			<xs:minInclusive value="0.001"/>
																			<xs:maxInclusive value="999999999.999"/>
																			<xs:totalDigits value="12"/>
																			<xs:fractionDigits value="3"/>
																			<xs:pattern value="(0|[1-9][0-9]{0,8})(\.[0-9]{1,3})?"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
																<xs:element name="MeasurementUnit" minOccurs="1" maxOccurs="1">
																	<xs:annotation>
																		<xs:documentation>
																			<aie:name value="Maßeinheit"/>
																			<aie:id value="2571"/>
																			<aie:status value="R"/>
																			<aie:format value="an3"/>
																			<aie:pcre value="\A.{3}\Z"/>
																			<aie:list value="I0700"/>
																		</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:token">
																			<xs:length value="3"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
																<xs:element name="Qualifier" minOccurs="0" maxOccurs="1">
																	<xs:annotation>
																		<xs:documentation>
																			<aie:name value="Qualifikator"/>
																			<aie:id value="2573"/>
																			<aie:status value="D"/>
																			<aie:format value="an1"/>
																			<aie:pcre value="\A.\Z"/>
																			<aie:list value="I0700"/>
																		</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:token">
																			<xs:length value="1"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
															</xs:sequence>
														</xs:complexType>
													</xs:element>
												</xs:sequence>
											</xs:complexType>
										</xs:element>
										<xs:element name="CustomsValue" minOccurs="0" maxOccurs="1" id="PZW">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="ANMELDUNG DER ANGABEN ÜBER DEN ZOLLWERT (D.V.1) EGZ (POSITION)"/>
													<aie:id value="3262"/>
													<aie:status value="D"/>
												</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:sequence>
													<xs:element name="DepartureAirport" minOccurs="0" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Abflughafen"/>
																<aie:id value="3263"/>
																<aie:status value="O"/>
																<aie:format value="an3"/>
																<aie:pcre value="\A.{3}\Z"/>
																<aie:list value="I0600"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:length value="3"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="DestinationPlace" minOccurs="0" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Ort des Verbringens"/>
																<aie:id value="3265"/>
																<aie:status value="D"/>
																<aie:format value="an..35"/>
																<aie:pcre value="\A.{1,35}\Z"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:minLength value="1"/>
																<xs:maxLength value="35"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="AdditionDeductionDescription" minOccurs="0" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Hinzurechnungen/Abzüge"/>
																<aie:id value="3264"/>
																<aie:status value="D"/>
																<aie:format value="an..30"/>
																<aie:pcre value="\A.{1,30}\Z"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:minLength value="1"/>
																<xs:maxLength value="30"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="NetPrice" minOccurs="0" maxOccurs="1" id="PZN">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="ANGABEN ZUM NETTOPREIS"/>
																<aie:id value="3291"/>
																<aie:status value="D"/>
															</xs:documentation>
														</xs:annotation>
														<xs:complexType>
															<xs:sequence>
																<xs:element name="Value" minOccurs="1" maxOccurs="1">
																	<xs:annotation>
																		<xs:documentation>
																			<aie:name value="Nettopreis"/>
																			<aie:id value="3292"/>
																			<aie:status value="R"/>
																			<aie:format value="n..11 (11,2)"/>
																			<aie:pcre value="\A(?!0\.?0*\Z)(?:0|[1-9][0-9]{0,8})(?:\.[0-9]{1,2})?\Z"/>
																		</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:decimal">
																			<xs:minInclusive value="0.01"/>
																			<xs:maxInclusive value="999999999.99"/>
																			<xs:totalDigits value="11"/>
																			<xs:fractionDigits value="2"/>
																			<xs:pattern value="(0|[1-9][0-9]{0,8})(\.[0-9]{1,2})?"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
																<xs:element name="CurrencyCode" minOccurs="1" maxOccurs="1">
																	<xs:annotation>
																		<xs:documentation>
																			<aie:name value="Währung Nettopreis"/>
																			<aie:id value="3296"/>
																			<aie:status value="R"/>
																			<aie:format value="an3"/>
																			<aie:pcre value="\A.{3}\Z"/>
																			<aie:list value="I0400"/>
																		</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:token">
																			<xs:length value="3"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
																<xs:element name="CurrencyRateAgreedFlag" minOccurs="0" maxOccurs="1">
																	<xs:annotation>
																		<xs:documentation>
																			<aie:name value="Kennzeichen Kurs netto vereinbart"/>
																			<aie:id value="3295"/>
																			<aie:status value="D"/>
																			<aie:format value="an1"/>
																			<aie:pcre value="\A.\Z"/>
																			<aie:list value="A1610"/>
																		</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:token">
																			<xs:length value="1"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
																<xs:element name="CurrencyRate" minOccurs="0" maxOccurs="1">
																	<xs:annotation>
																		<xs:documentation>
																			<aie:name value="Kurs Nettopreis"/>
																			<aie:id value="3293"/>
																			<aie:status value="D"/>
																			<aie:format value="n..12 (18,9)"/>
																			<aie:pcre value="\A(?!0\.?0*\Z)(?=.{1,13}\Z)(?:0|[1-9][0-9]{0,8})(?:\.[0-9]{1,9})?\Z"/>
																		</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:decimal">
																			<xs:minInclusive value="0.000000001"/>
																			<xs:maxInclusive value="999999999.999"/>
																			<xs:totalDigits value="12"/>
																			<xs:fractionDigits value="9"/>
																			<xs:pattern value="(0|[1-9][0-9]{0,8})(\.[0-9]{1,9})?"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
															</xs:sequence>
														</xs:complexType>
													</xs:element>
													<xs:element name="IndirectPayment" minOccurs="0" maxOccurs="1" id="PZM">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="ANGABEN ZU MITTELBAREN ZAHLUNGEN"/>
																<aie:id value="3285"/>
																<aie:status value="O"/>
															</xs:documentation>
														</xs:annotation>
														<xs:complexType>
															<xs:sequence>
																<xs:element name="Value" minOccurs="1" maxOccurs="1">
																	<xs:annotation>
																		<xs:documentation>
																			<aie:name value="Mittelbare Zahlungen"/>
																			<aie:id value="3286"/>
																			<aie:status value="R"/>
																			<aie:format value="n..11 (11,2)"/>
																			<aie:pcre value="\A(?!0\.?0*\Z)(?:0|[1-9][0-9]{0,8})(?:\.[0-9]{1,2})?\Z"/>
																		</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:decimal">
																			<xs:minInclusive value="0.01"/>
																			<xs:maxInclusive value="999999999.99"/>
																			<xs:totalDigits value="11"/>
																			<xs:fractionDigits value="2"/>
																			<xs:pattern value="(0|[1-9][0-9]{0,8})(\.[0-9]{1,2})?"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
																<xs:element name="CurrencyCode" minOccurs="1" maxOccurs="1">
																	<xs:annotation>
																		<xs:documentation>
																			<aie:name value="Währung Mittelbare Zahlungen"/>
																			<aie:id value="3290"/>
																			<aie:status value="R"/>
																			<aie:format value="an3"/>
																			<aie:pcre value="\A.{3}\Z"/>
																			<aie:list value="I0400"/>
																		</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:token">
																			<xs:length value="3"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
																<xs:element name="CurrencyRateAgreedFlag" minOccurs="0" maxOccurs="1">
																	<xs:annotation>
																		<xs:documentation>
																			<aie:name value="Kennzeichen Kurs Mittelbare Zahlungen vereinbart"/>
																			<aie:id value="3289"/>
																			<aie:status value="D"/>
																			<aie:format value="an1"/>
																			<aie:pcre value="\A.\Z"/>
																			<aie:list value="A1600"/>
																		</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:token">
																			<xs:length value="1"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
																<xs:element name="CurrencyRate" minOccurs="0" maxOccurs="1">
																	<xs:annotation>
																		<xs:documentation>
																			<aie:name value="Kurs Mittelbare Zahlungen"/>
																			<aie:id value="3287"/>
																			<aie:status value="D"/>
																			<aie:format value="n..12 (18,9)"/>
																			<aie:pcre value="\A(?!0\.?0*\Z)(?=.{1,13}\Z)(?:0|[1-9][0-9]{0,8})(?:\.[0-9]{1,9})?\Z"/>
																		</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:decimal">
																			<xs:minInclusive value="0.000000001"/>
																			<xs:maxInclusive value="999999999.999"/>
																			<xs:totalDigits value="12"/>
																			<xs:fractionDigits value="9"/>
																			<xs:pattern value="(0|[1-9][0-9]{0,8})(\.[0-9]{1,9})?"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
															</xs:sequence>
														</xs:complexType>
													</xs:element>
													<xs:element name="AirFreightCosts" minOccurs="0" maxOccurs="1" id="PZL">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="ANGABEN ZU DEN LUFTFRACHTKOSTEN"/>
																<aie:id value="3276"/>
																<aie:status value="D"/>
															</xs:documentation>
														</xs:annotation>
														<xs:complexType>
															<xs:sequence>
																<xs:element name="Value" minOccurs="1" maxOccurs="1">
																	<xs:annotation>
																		<xs:documentation>
																			<aie:name value="Betrag der gesamten Luftfrachtkosten"/>
																			<aie:id value="3277"/>
																			<aie:status value="R"/>
																			<aie:format value="n..11 (11,2)"/>
																			<aie:pcre value="\A(?!0\.?0*\Z)(?:0|[1-9][0-9]{0,8})(?:\.[0-9]{1,2})?\Z"/>
																		</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:decimal">
																			<xs:minInclusive value="0.01"/>
																			<xs:maxInclusive value="999999999.99"/>
																			<xs:totalDigits value="11"/>
																			<xs:fractionDigits value="2"/>
																			<xs:pattern value="(0|[1-9][0-9]{0,8})(\.[0-9]{1,2})?"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
																<xs:element name="CurrencyCode" minOccurs="1" maxOccurs="1">
																	<xs:annotation>
																		<xs:documentation>
																			<aie:name value="Währung Betrag der gesamten Luftfrachtkosten"/>
																			<aie:id value="3284"/>
																			<aie:status value="R"/>
																			<aie:format value="an3"/>
																			<aie:pcre value="\A.{3}\Z"/>
																			<aie:list value="I0400"/>
																		</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:token">
																			<xs:length value="3"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
																<xs:element name="CurrencyRateIATA" minOccurs="0" maxOccurs="1">
																	<xs:annotation>
																		<xs:documentation>
																			<aie:name value="Kennzeichen IATA-Kurs Betrag der gesamten Luftfrachtkosten"/>
																			<aie:id value="3278"/>
																			<aie:status value="D"/>
																			<aie:format value="an1"/>
																			<aie:pcre value="\A.\Z"/>
																			<aie:list value="A1560"/>
																		</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:token">
																			<xs:length value="1"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
																<xs:element name="CurrencyRateAgreedFlag" minOccurs="0" maxOccurs="1">
																	<xs:annotation>
																		<xs:documentation>
																			<aie:name value="Kennzeichen Kurs Betrag der gesamten Luftfrachtkosten vereinbart"/>
																			<aie:id value="3282"/>
																			<aie:status value="D"/>
																			<aie:format value="an1"/>
																			<aie:pcre value="\A.\Z"/>
																			<aie:list value="A1590"/>
																		</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:token">
																			<xs:length value="1"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
																<xs:element name="CurrencyRate" minOccurs="0" maxOccurs="1">
																	<xs:annotation>
																		<xs:documentation>
																			<aie:name value="Kurs Betrag der gesamten Luftfrachtkosten"/>
																			<aie:id value="3279"/>
																			<aie:status value="D"/>
																			<aie:format value="n..12 (18,9)"/>
																			<aie:pcre value="\A(?!0\.?0*\Z)(?=.{1,13}\Z)(?:0|[1-9][0-9]{0,8})(?:\.[0-9]{1,9})?\Z"/>
																		</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:decimal">
																			<xs:minInclusive value="0.000000001"/>
																			<xs:maxInclusive value="999999999.999"/>
																			<xs:totalDigits value="12"/>
																			<xs:fractionDigits value="9"/>
																			<xs:pattern value="(0|[1-9][0-9]{0,8})(\.[0-9]{1,9})?"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
																<xs:element name="CurrencyRateDate" minOccurs="0" maxOccurs="1">
																	<xs:annotation>
																		<xs:documentation>
																			<aie:name value="Datum des Kurses Betrag der gesamten Luftfrachtkosten"/>
																			<aie:id value="3281"/>
																			<aie:status value="D"/>
																			<aie:format value="Date (n8)"/>
																			<aie:pcre value="\A(?:(?:(?:0[48]|[2468][048]|[13579][26])(?:[02468][048]|[13579][26])|(?:[02468][1-35-79]|[13579][013-57-9])(?:0[48]|[2468][048]|[13579][26]))-02-29|[0-9][0-9][0-9][0-9]-(?:(?:0[13578]|1[02])-(?:0[1-9]|[12][0-9]|3[01])|(?:0[469]|11)-(?:0[1-9]|[12][0-9]|30)|02-(?:0[1-9]|1[0-9]|2[0-8])))\Z"/>
																		</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:date">
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
															</xs:sequence>
														</xs:complexType>
													</xs:element>
													<xs:element name="AdditionDeduction" minOccurs="0" maxOccurs="10" id="PZR">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="HINZURECHNUNGEN/ABZÜGE ZUM ZOLLWERT"/>
																<aie:id value="3266"/>
																<aie:status value="D"/>
															</xs:documentation>
														</xs:annotation>
														<xs:complexType>
															<xs:sequence>
																<xs:element name="Type" minOccurs="1" maxOccurs="1">
																	<xs:annotation>
																		<xs:documentation>
																			<aie:name value="Art Abzug/Hinzurechnungen"/>
																			<aie:id value="3267"/>
																			<aie:status value="R"/>
																			<aie:format value="an3"/>
																			<aie:pcre value="\A.{3}\Z"/>
																			<aie:list value="A1070"/>
																		</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:token">
																			<xs:length value="3"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
																<xs:element name="Value" minOccurs="1" maxOccurs="1">
																	<xs:annotation>
																		<xs:documentation>
																			<aie:name value="Betrag Abzug/Hinzurechnungen"/>
																			<aie:id value="3268"/>
																			<aie:status value="R"/>
																			<aie:format value="n..11 (11,2)"/>
																			<aie:pcre value="\A(?!0\.?0*\Z)(?:0|[1-9][0-9]{0,8})(?:\.[0-9]{1,2})?\Z"/>
																		</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:decimal">
																			<xs:minInclusive value="0.01"/>
																			<xs:maxInclusive value="999999999.99"/>
																			<xs:totalDigits value="11"/>
																			<xs:fractionDigits value="2"/>
																			<xs:pattern value="(0|[1-9][0-9]{0,8})(\.[0-9]{1,2})?"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
																<xs:element name="CurrencyCode" minOccurs="1" maxOccurs="1">
																	<xs:annotation>
																		<xs:documentation>
																			<aie:name value="Währung Abzug/Hinzurechnungen"/>
																			<aie:id value="3275"/>
																			<aie:status value="R"/>
																			<aie:format value="an3"/>
																			<aie:pcre value="\A.{3}\Z"/>
																			<aie:list value="I0400"/>
																		</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:token">
																			<xs:length value="3"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
																<xs:element name="CurrencyRateIATA" minOccurs="0" maxOccurs="1">
																	<xs:annotation>
																		<xs:documentation>
																			<aie:name value="Kennzeichen IATA-Kurs Abzug/Hinzurechnungen"/>
																			<aie:id value="3269"/>
																			<aie:status value="D"/>
																			<aie:format value="an1"/>
																			<aie:pcre value="\A.\Z"/>
																			<aie:list value="A1560"/>
																		</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:token">
																			<xs:length value="1"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
																<xs:element name="CurrencyRateAgreedFlag" minOccurs="0" maxOccurs="1">
																	<xs:annotation>
																		<xs:documentation>
																			<aie:name value="Kennzeichen Kurs Abzug/Hinzurechnungen vereinbart"/>
																			<aie:id value="3273"/>
																			<aie:status value="D"/>
																			<aie:format value="an1"/>
																			<aie:pcre value="\A.\Z"/>
																			<aie:list value="A1590"/>
																		</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:token">
																			<xs:length value="1"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
																<xs:element name="CurrencyRate" minOccurs="0" maxOccurs="1">
																	<xs:annotation>
																		<xs:documentation>
																			<aie:name value="Kurs Abzug/Hinzurechnungen"/>
																			<aie:id value="3270"/>
																			<aie:status value="D"/>
																			<aie:format value="n..12 (18,9)"/>
																			<aie:pcre value="\A(?!0\.?0*\Z)(?=.{1,13}\Z)(?:0|[1-9][0-9]{0,8})(?:\.[0-9]{1,9})?\Z"/>
																		</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:decimal">
																			<xs:minInclusive value="0.000000001"/>
																			<xs:maxInclusive value="999999999.999"/>
																			<xs:totalDigits value="12"/>
																			<xs:fractionDigits value="9"/>
																			<xs:pattern value="(0|[1-9][0-9]{0,8})(\.[0-9]{1,9})?"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
																<xs:element name="CurrencyRateDate" minOccurs="0" maxOccurs="1">
																	<xs:annotation>
																		<xs:documentation>
																			<aie:name value="Datum des Kurses Abzug/Hinzurechnungen"/>
																			<aie:id value="3272"/>
																			<aie:status value="D"/>
																			<aie:format value="Date (n8)"/>
																			<aie:pcre value="\A(?:(?:(?:0[48]|[2468][048]|[13579][26])(?:[02468][048]|[13579][26])|(?:[02468][1-35-79]|[13579][013-57-9])(?:0[48]|[2468][048]|[13579][26]))-02-29|[0-9][0-9][0-9][0-9]-(?:(?:0[13578]|1[02])-(?:0[1-9]|[12][0-9]|3[01])|(?:0[469]|11)-(?:0[1-9]|[12][0-9]|30)|02-(?:0[1-9]|1[0-9]|2[0-8])))\Z"/>
																		</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:date">
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
																<xs:element name="Percentage" minOccurs="0" maxOccurs="1">
																	<xs:annotation>
																		<xs:documentation>
																			<aie:name value="Prozent der Hinzurechnungen/Abzüge"/>
																			<aie:id value="3274"/>
																			<aie:status value="D"/>
																			<aie:format value="n..5 (5,2)"/>
																			<aie:pcre value="\A(?!0\.?0*\Z)(?:0|[1-9][0-9]{0,2})(?:\.[0-9]{1,2})?\Z"/>
																		</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:decimal">
																			<xs:minInclusive value="0.01"/>
																			<xs:maxInclusive value="999.99"/>
																			<xs:totalDigits value="5"/>
																			<xs:fractionDigits value="2"/>
																			<xs:pattern value="(0|[1-9][0-9]{0,2})(\.[0-9]{1,2})?"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
															</xs:sequence>
														</xs:complexType>
													</xs:element>
												</xs:sequence>
											</xs:complexType>
										</xs:element>
										<xs:element name="Assessment" minOccurs="0" maxOccurs="1" id="PBX">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="BEMESSUNGSDATEN (OHNE VERBRAUCHSTEUER) EGZ (POSITION)"/>
													<aie:id value="2695"/>
													<aie:status value="D"/>
												</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:sequence>
													<xs:element name="CustomsValue" minOccurs="0" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Zollwert"/>
																<aie:id value="2699"/>
																<aie:status value="D"/>
																<aie:format value="n..11 (11,2)"/>
																<aie:pcre value="\A(?!0\.?0*\Z)(?:0|[1-9][0-9]{0,8})(?:\.[0-9]{1,2})?\Z"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:decimal">
																<xs:minInclusive value="0.01"/>
																<xs:maxInclusive value="999999999.99"/>
																<xs:totalDigits value="11"/>
																<xs:fractionDigits value="2"/>
																<xs:pattern value="(0|[1-9][0-9]{0,8})(\.[0-9]{1,2})?"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="OutwardProcessingFee" minOccurs="0" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Veredelungsentgelt/Wertsteigerung"/>
																<aie:id value="2696"/>
																<aie:status value="D"/>
																<aie:format value="n..11 (11,2)"/>
																<aie:pcre value="\A(?!0\.?0*\Z)(?:0|[1-9][0-9]{0,8})(?:\.[0-9]{1,2})?\Z"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:decimal">
																<xs:minInclusive value="0.01"/>
																<xs:maxInclusive value="999999999.99"/>
																<xs:totalDigits value="11"/>
																<xs:fractionDigits value="2"/>
																<xs:pattern value="(0|[1-9][0-9]{0,8})(\.[0-9]{1,2})?"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="TaxCosts" minOccurs="0" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Kosten für EUSt"/>
																<aie:id value="2697"/>
																<aie:status value="D"/>
																<aie:format value="n..11 (11,2)"/>
																<aie:pcre value="\A(?!0\.?0*\Z)(?:0|[1-9][0-9]{0,8})(?:\.[0-9]{1,2})?\Z"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:decimal">
																<xs:minInclusive value="0.01"/>
																<xs:maxInclusive value="999999999.99"/>
																<xs:totalDigits value="11"/>
																<xs:fractionDigits value="2"/>
																<xs:pattern value="(0|[1-9][0-9]{0,8})(\.[0-9]{1,2})?"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="Amount" minOccurs="0" maxOccurs="5" id="PBZ">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="ANGABEN ZUR ZOLLMENGE"/>
																<aie:id value="2706"/>
																<aie:status value="D"/>
															</xs:documentation>
														</xs:annotation>
														<xs:complexType>
															<xs:sequence>
																<xs:element name="Quantity" minOccurs="1" maxOccurs="1">
																	<xs:annotation>
																		<xs:documentation>
																			<aie:name value="Zollmenge"/>
																			<aie:id value="2708"/>
																			<aie:status value="R"/>
																			<aie:format value="n..12 (12,3)"/>
																			<aie:pcre value="\A(?!0\.?0*\Z)(?:0|[1-9][0-9]{0,8})(?:\.[0-9]{1,3})?\Z"/>
																		</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:decimal">
																			<xs:minInclusive value="0.001"/>
																			<xs:maxInclusive value="999999999.999"/>
																			<xs:totalDigits value="12"/>
																			<xs:fractionDigits value="3"/>
																			<xs:pattern value="(0|[1-9][0-9]{0,8})(\.[0-9]{1,3})?"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
																<xs:element name="MeasurementUnit" minOccurs="1" maxOccurs="1">
																	<xs:annotation>
																		<xs:documentation>
																			<aie:name value="Maßeinheit (Zollmenge)"/>
																			<aie:id value="2707"/>
																			<aie:status value="R"/>
																			<aie:format value="an3"/>
																			<aie:pcre value="\A.{3}\Z"/>
																			<aie:list value="I0700"/>
																		</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:token">
																			<xs:length value="3"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
																<xs:element name="Qualifier" minOccurs="0" maxOccurs="1">
																	<xs:annotation>
																		<xs:documentation>
																			<aie:name value="Qualifikator (Zollmenge)"/>
																			<aie:id value="2709"/>
																			<aie:status value="D"/>
																			<aie:format value="an1"/>
																			<aie:pcre value="\A.\Z"/>
																			<aie:list value="I0700"/>
																		</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:token">
																			<xs:length value="1"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
															</xs:sequence>
														</xs:complexType>
													</xs:element>
													<xs:element name="SpecificRate" minOccurs="0" maxOccurs="5" id="PBW">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="ANGABEN ZUR BESONDEREN WERTANGABE"/>
																<aie:id value="2700"/>
																<aie:status value="D"/>
															</xs:documentation>
														</xs:annotation>
														<xs:complexType>
															<xs:sequence>
																<xs:element name="Type" minOccurs="1" maxOccurs="1">
																	<xs:annotation>
																		<xs:documentation>
																			<aie:name value="Preisart"/>
																			<aie:id value="2701"/>
																			<aie:status value="R"/>
																			<aie:format value="an1"/>
																			<aie:pcre value="\A.\Z"/>
																			<aie:list value="A1880"/>
																		</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:token">
																			<xs:length value="1"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
																<xs:element name="Value" minOccurs="1" maxOccurs="1">
																	<xs:annotation>
																		<xs:documentation>
																			<aie:name value="Besondere Wertangabe"/>
																			<aie:id value="2702"/>
																			<aie:status value="R"/>
																			<aie:format value="n..11 (11,2)"/>
																			<aie:pcre value="\A(?!0\.?0*\Z)(?:0|[1-9][0-9]{0,8})(?:\.[0-9]{1,2})?\Z"/>
																		</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:decimal">
																			<xs:minInclusive value="0.01"/>
																			<xs:maxInclusive value="999999999.99"/>
																			<xs:totalDigits value="11"/>
																			<xs:fractionDigits value="2"/>
																			<xs:pattern value="(0|[1-9][0-9]{0,8})(\.[0-9]{1,2})?"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
															</xs:sequence>
														</xs:complexType>
													</xs:element>
													<xs:element name="ContentInformation" minOccurs="0" maxOccurs="3" id="PBG">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="GEHALTSANGABEN"/>
																<aie:id value="2703"/>
																<aie:status value="O"/>
															</xs:documentation>
														</xs:annotation>
														<xs:complexType>
															<xs:sequence>
																<xs:element name="Type" minOccurs="1" maxOccurs="1">
																	<xs:annotation>
																		<xs:documentation>
																			<aie:name value="Gehaltsangaben/Art"/>
																			<aie:id value="2704"/>
																			<aie:status value="R"/>
																			<aie:format value="an2"/>
																			<aie:pcre value="\A.{2}\Z"/>
																			<aie:list value="A1330"/>
																		</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:token">
																			<xs:length value="2"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
																<xs:element name="Degree-Percentage" minOccurs="1" maxOccurs="1">
																	<xs:annotation>
																		<xs:documentation>
																			<aie:name value="Gehaltsangaben (Grad/Prozent)"/>
																			<aie:id value="2705"/>
																			<aie:status value="R"/>
																			<aie:format value="n..5 (5,2)"/>
																			<aie:pcre value="\A(?!0\.?0*\Z)(?:(?:0|[1-9][0-9]{0,1})(?:\.[0-9]{1,2})?|100(?:\.0{1,2})?)\Z"/>
																		</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:decimal">
																			<xs:pattern value="(0|[1-9][0-9]{0,1})(\.[0-9]{1,2})?"/>
																			<xs:pattern value="100(\.0{1,2})?"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
															</xs:sequence>
														</xs:complexType>
													</xs:element>
												</xs:sequence>
											</xs:complexType>
										</xs:element>
										<xs:element name="ExciseDuty" minOccurs="0" maxOccurs="3" id="PVS">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="VERBRAUCHSTEUERDATEN EGZ (POSITION)"/>
													<aie:id value="3095"/>
													<aie:status value="D"/>
												</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:sequence>
													<xs:element name="Code" minOccurs="1" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Verbrauchsteuer (Code)"/>
																<aie:id value="3096"/>
																<aie:status value="R"/>
																<aie:format value="an4"/>
																<aie:pcre value="\A.{4}\Z"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:length value="4"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="Degree-Percentage" minOccurs="0" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Grad/Prozent (Verbrauchsteuer)"/>
																<aie:id value="3097"/>
																<aie:status value="D"/>
																<aie:format value="n..5 (5,2)"/>
																<aie:pcre value="\A(?!0\.?0*\Z)(?:(?:0|[1-9][0-9]{0,1})(?:\.[0-9]{1,2})?|100(?:\.0{1,2})?)\Z"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:decimal">
																<xs:pattern value="(0|[1-9][0-9]{0,1})(\.[0-9]{1,2})?"/>
																<xs:pattern value="100(\.0{1,2})?"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="Value" minOccurs="0" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Verbrauchsteuerwert"/>
																<aie:id value="3098"/>
																<aie:status value="D"/>
																<aie:format value="n..11 (11,2)"/>
																<aie:pcre value="\A(?!0\.?0*\Z)(?:0|[1-9][0-9]{0,8})(?:\.[0-9]{1,2})?\Z"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:decimal">
																<xs:minInclusive value="0.01"/>
																<xs:maxInclusive value="999999999.99"/>
																<xs:totalDigits value="11"/>
																<xs:fractionDigits value="2"/>
																<xs:pattern value="(0|[1-9][0-9]{0,8})(\.[0-9]{1,2})?"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="Amount" minOccurs="0" maxOccurs="1" id="PVM">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="ANGABEN ZUR VERBRAUCHSTEUERMENGE"/>
																<aie:id value="3099"/>
																<aie:status value="D"/>
															</xs:documentation>
														</xs:annotation>
														<xs:complexType>
															<xs:sequence>
																<xs:element name="Quantity" minOccurs="1" maxOccurs="1">
																	<xs:annotation>
																		<xs:documentation>
																			<aie:name value="Verbrauchsteuer (Menge)"/>
																			<aie:id value="3101"/>
																			<aie:status value="R"/>
																			<aie:format value="n..12 (12,3)"/>
																			<aie:pcre value="\A(?!0\.?0*\Z)(?:0|[1-9][0-9]{0,8})(?:\.[0-9]{1,3})?\Z"/>
																		</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:decimal">
																			<xs:minInclusive value="0.001"/>
																			<xs:maxInclusive value="999999999.999"/>
																			<xs:totalDigits value="12"/>
																			<xs:fractionDigits value="3"/>
																			<xs:pattern value="(0|[1-9][0-9]{0,8})(\.[0-9]{1,3})?"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
																<xs:element name="MeasurementUnit" minOccurs="1" maxOccurs="1">
																	<xs:annotation>
																		<xs:documentation>
																			<aie:name value="Maßeinheit (Verbrauchsteuer)"/>
																			<aie:id value="3100"/>
																			<aie:status value="R"/>
																			<aie:format value="an3"/>
																			<aie:pcre value="\A.{3}\Z"/>
																			<aie:list value="I0700"/>
																		</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:token">
																			<xs:length value="3"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
																<xs:element name="Qualifier" minOccurs="0" maxOccurs="1">
																	<xs:annotation>
																		<xs:documentation>
																			<aie:name value="Qualifikator (Verbrauchsteuer)"/>
																			<aie:id value="3102"/>
																			<aie:status value="D"/>
																			<aie:format value="an1"/>
																			<aie:pcre value="\A.\Z"/>
																			<aie:list value="I0700"/>
																		</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:token">
																			<xs:length value="1"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
															</xs:sequence>
														</xs:complexType>
													</xs:element>
												</xs:sequence>
											</xs:complexType>
										</xs:element>
										<xs:element name="PreferentialTreatment" minOccurs="0" maxOccurs="1" id="PGX">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="BEGÜNSTIGUNGSDATEN EGZ (POSITION)"/>
													<aie:id value="3843"/>
													<aie:status value="D"/>
												</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:sequence>
													<xs:element name="RequestedPreferentialTreatment" minOccurs="0" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Beantragte Begünstigung"/>
																<aie:id value="2656"/>
																<aie:status value="D"/>
																<aie:format value="an3"/>
																<aie:pcre value="\A.{3}\Z"/>
																<aie:list value="A1200"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:length value="3"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="Declaration" minOccurs="0" maxOccurs="1" id="PGM">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="ANGABEN ZU KONTINGENTEN"/>
																<aie:id value="3844"/>
																<aie:status value="D"/>
															</xs:documentation>
														</xs:annotation>
														<xs:complexType>
															<xs:sequence>
																<xs:element name="Contingent" minOccurs="0" maxOccurs="2" id="GMK">
																	<xs:annotation>
																		<xs:documentation>
																			<aie:name value="KONTINGENTSANGABEN"/>
																			<aie:id value="3845"/>
																			<aie:status value="D"/>
																		</xs:documentation>
																	</xs:annotation>
																	<xs:complexType>
																		<xs:sequence>
																			<xs:element name="ContingentNumber" minOccurs="1" maxOccurs="1">
																				<xs:annotation>
																					<xs:documentation>
																						<aie:name value="Kontingentnummer"/>
																						<aie:id value="2662"/>
																						<aie:status value="R"/>
																						<aie:format value="an4"/>
																						<aie:pcre value="\A.{4}\Z"/>
																					</xs:documentation>
																				</xs:annotation>
																				<xs:simpleType>
																					<xs:restriction base="xs:token">
																						<xs:length value="4"/>
																					</xs:restriction>
																				</xs:simpleType>
																			</xs:element>
																		</xs:sequence>
																	</xs:complexType>
																</xs:element>
																<xs:element name="PreferentialTreatmentQuantity" minOccurs="0" maxOccurs="1" id="GMB">
																	<xs:annotation>
																		<xs:documentation>
																			<aie:name value="ANGABEN ZUR BEGÜNSTIGUNGSMENGE"/>
																			<aie:id value="2657"/>
																			<aie:status value="D"/>
																		</xs:documentation>
																	</xs:annotation>
																	<xs:complexType>
																		<xs:sequence>
																			<xs:element name="Quantity" minOccurs="1" maxOccurs="1">
																				<xs:annotation>
																					<xs:documentation>
																						<aie:name value="Begünstigungsmenge"/>
																						<aie:id value="2659"/>
																						<aie:status value="R"/>
																						<aie:format value="n..9"/>
																						<aie:pcre value="\A[1-9][0-9]{0,8}\Z"/>
																					</xs:documentation>
																				</xs:annotation>
																				<xs:simpleType>
																					<xs:restriction base="xs:integer">
																						<xs:minInclusive value="1"/>
																						<xs:maxInclusive value="999999999"/>
																						<xs:totalDigits value="9"/>
																						<xs:pattern value="[1-9][0-9]{0,8}"/>
																					</xs:restriction>
																				</xs:simpleType>
																			</xs:element>
																			<xs:element name="MeasurementUnit" minOccurs="1" maxOccurs="1">
																				<xs:annotation>
																					<xs:documentation>
																						<aie:name value="Maßeinheit (Begünstigungsmenge)"/>
																						<aie:id value="2658"/>
																						<aie:status value="R"/>
																						<aie:format value="an3"/>
																						<aie:pcre value="\A.{3}\Z"/>
																						<aie:list value="I0700"/>
																					</xs:documentation>
																				</xs:annotation>
																				<xs:simpleType>
																					<xs:restriction base="xs:token">
																						<xs:length value="3"/>
																					</xs:restriction>
																				</xs:simpleType>
																			</xs:element>
																			<xs:element name="Qualifier" minOccurs="0" maxOccurs="1">
																				<xs:annotation>
																					<xs:documentation>
																						<aie:name value="Qualifikator (Begünstigungsmenge)"/>
																						<aie:id value="2660"/>
																						<aie:status value="D"/>
																						<aie:format value="an1"/>
																						<aie:pcre value="\A.\Z"/>
																						<aie:list value="I0700"/>
																					</xs:documentation>
																				</xs:annotation>
																				<xs:simpleType>
																					<xs:restriction base="xs:token">
																						<xs:length value="1"/>
																					</xs:restriction>
																				</xs:simpleType>
																			</xs:element>
																		</xs:sequence>
																	</xs:complexType>
																</xs:element>
															</xs:sequence>
														</xs:complexType>
													</xs:element>
												</xs:sequence>
											</xs:complexType>
										</xs:element>
										<xs:element name="OutwardProcessingReduction" minOccurs="0" maxOccurs="3" id="PPV">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="ANGABEN ZU PV-MINDERUNG"/>
													<aie:id value="2969"/>
													<aie:status value="D"/>
												</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:sequence>
													<xs:element name="Group" minOccurs="1" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Mindernde Abgabengruppe"/>
																<aie:id value="2971"/>
																<aie:status value="R"/>
																<aie:format value="an2"/>
																<aie:pcre value="\A.{2}\Z"/>
																<aie:list value="A1860"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:length value="2"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="Amount" minOccurs="1" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Minderungsbetrag"/>
																<aie:id value="2972"/>
																<aie:status value="R"/>
																<aie:format value="n..11 (11,2)"/>
																<aie:pcre value="\A(?!0\.?0*\Z)(?:0|[1-9][0-9]{0,8})(?:\.[0-9]{1,2})?\Z"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:decimal">
																<xs:minInclusive value="0.01"/>
																<xs:maxInclusive value="999999999.99"/>
																<xs:totalDigits value="11"/>
																<xs:fractionDigits value="2"/>
																<xs:pattern value="(0|[1-9][0-9]{0,8})(\.[0-9]{1,2})?"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
												</xs:sequence>
											</xs:complexType>
										</xs:element>
										<xs:element name="SpecialCase" minOccurs="0" maxOccurs="9" id="PSF">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="SONDERFALLDATEN"/>
													<aie:id value="3069"/>
													<aie:status value="D"/>
												</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:sequence>
													<xs:element name="Group" minOccurs="1" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Sonderabgabengruppe (Sonderfalleingabe)"/>
																<aie:id value="3070"/>
																<aie:status value="R"/>
																<aie:format value="an2"/>
																<aie:pcre value="\A.{2}\Z"/>
																<aie:list value="A1010"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:length value="2"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="ApplicationType" minOccurs="1" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Anwendungsart"/>
																<aie:id value="3071"/>
																<aie:status value="R"/>
																<aie:format value="an2"/>
																<aie:pcre value="\A.{2}\Z"/>
																<aie:list value="A1060"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:length value="2"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="RateOrAmountOrFactor" minOccurs="0" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Satz, Betrag oder Faktor"/>
																<aie:id value="3072"/>
																<aie:status value="D"/>
																<aie:format value="n..12 (12,5)"/>
																<aie:pcre value="\A(?:0|[1-9][0-9]{0,6})(?:\.[0-9]{1,5})?\Z"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:decimal">
																<xs:minInclusive value="0.00000"/>
																<xs:maxInclusive value="9999999.99999"/>
																<xs:totalDigits value="12"/>
																<xs:fractionDigits value="5"/>
																<xs:pattern value="(0|[1-9][0-9]{0,6})(\.[0-9]{1,5})?"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
												</xs:sequence>
											</xs:complexType>
										</xs:element>
										<xs:element name="Document" minOccurs="0" maxOccurs="99" id="DC2">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="UNTERLAGEN ZUR POSITION"/>
													<aie:id value="3076"/>
													<aie:status value="O"/>
												</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:sequence>
													<xs:element name="Division" minOccurs="1" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Bereich der Unterlage (Position)"/>
																<aie:id value="3079"/>
																<aie:status value="R"/>
																<aie:format value="an1"/>
																<aie:pcre value="\A.\Z"/>
																<aie:list value="A1255"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:length value="1"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="Type" minOccurs="1" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Art der Unterlage (Position)"/>
																<aie:id value="3085"/>
																<aie:status value="R"/>
																<aie:format value="an4"/>
																<aie:pcre value="\A.{4}\Z"/>
																<aie:list value="I0200"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:length value="4"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="ReferenceNumber" minOccurs="0" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Nummer der Unterlage (Position)"/>
																<aie:id value="3084"/>
																<aie:status value="D"/>
																<aie:format value="an..35"/>
																<aie:pcre value="\A.{1,35}\Z"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:minLength value="1"/>
																<xs:maxLength value="35"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="IssuingDate" minOccurs="0" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Datum der Unterlage (Position)"/>
																<aie:id value="3080"/>
																<aie:status value="D"/>
																<aie:format value="Date (n8)"/>
																<aie:pcre value="\A(?:(?:(?:0[48]|[2468][048]|[13579][26])(?:[02468][048]|[13579][26])|(?:[02468][1-35-79]|[13579][013-57-9])(?:0[48]|[2468][048]|[13579][26]))-02-29|[0-9][0-9][0-9][0-9]-(?:(?:0[13578]|1[02])-(?:0[1-9]|[12][0-9]|3[01])|(?:0[469]|11)-(?:0[1-9]|[12][0-9]|30)|02-(?:0[1-9]|1[0-9]|2[0-8])))\Z"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:date">
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="AtHandFlag" minOccurs="0" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Kennzeichen Vorhanden"/>
																<aie:id value="3086"/>
																<aie:status value="D"/>
																<aie:format value="an1"/>
																<aie:pcre value="\A.\Z"/>
																<aie:list value="A1790"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:length value="1"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="WriteOff" minOccurs="0" maxOccurs="1" id="DC3">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="ANGABEN ZU ABSCHREIBUNGSMENGE/-WERT"/>
																<aie:id value="3090"/>
																<aie:status value="D"/>
															</xs:documentation>
														</xs:annotation>
														<xs:complexType>
															<xs:sequence>
																<xs:element name="Quantity" minOccurs="1" maxOccurs="1">
																	<xs:annotation>
																		<xs:documentation>
																			<aie:name value="Abschreibungsmenge/-wert"/>
																			<aie:id value="3092"/>
																			<aie:status value="R"/>
																			<aie:format value="n..12 (12,3)"/>
																			<aie:pcre value="\A(?!0\.?0*\Z)(?:0|[1-9][0-9]{0,8})(?:\.[0-9]{1,3})?\Z"/>
																		</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:decimal">
																			<xs:minInclusive value="0.001"/>
																			<xs:maxInclusive value="999999999.999"/>
																			<xs:totalDigits value="12"/>
																			<xs:fractionDigits value="3"/>
																			<xs:pattern value="(0|[1-9][0-9]{0,8})(\.[0-9]{1,3})?"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
																<xs:element name="MeasurementUnit" minOccurs="1" maxOccurs="1">
																	<xs:annotation>
																		<xs:documentation>
																			<aie:name value="Maßeinheit (Abschreibung)"/>
																			<aie:id value="3091"/>
																			<aie:status value="R"/>
																			<aie:format value="an3"/>
																			<aie:pcre value="\A.{3}\Z"/>
																			<aie:list value="I0700"/>
																		</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:token">
																			<xs:length value="3"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
																<xs:element name="Qualifier" minOccurs="0" maxOccurs="1">
																	<xs:annotation>
																		<xs:documentation>
																			<aie:name value="Qualifikator (Abschreibung)"/>
																			<aie:id value="3093"/>
																			<aie:status value="D"/>
																			<aie:format value="an1"/>
																			<aie:pcre value="\A.\Z"/>
																			<aie:list value="I0700"/>
																		</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:token">
																			<xs:length value="1"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
															</xs:sequence>
														</xs:complexType>
													</xs:element>
												</xs:sequence>
											</xs:complexType>
										</xs:element>
										<xs:element name="BorderTransportMeans" minOccurs="0" maxOccurs="1" id="MTI">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="BEFÖRDERUNGSMITTEL AN DER GRENZE"/>
													<aie:id value="2598"/>
													<aie:status value="D"/>
												</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:sequence>
													<xs:element name="Mode" minOccurs="0" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Verkehrszweig an der Grenze"/>
																<aie:id value="2603"/>
																<aie:status value="D"/>
																<aie:format value="an1"/>
																<aie:pcre value="\A.\Z"/>
																<aie:list value="A1980"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:length value="1"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="Type" minOccurs="0" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Art des Beförderungsmittels an der Grenze"/>
																<aie:id value="2599"/>
																<aie:status value="D"/>
																<aie:format value="an2"/>
																<aie:pcre value="\A.{2}\Z"/>
																<aie:list value="A1140"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:length value="2"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="Information" minOccurs="0" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Beschreibung des Beförderungsmittels"/>
																<aie:id value="2601"/>
																<aie:status value="D"/>
																<aie:format value="an..17"/>
																<aie:pcre value="\A.{1,17}\Z"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:minLength value="1"/>
																<xs:maxLength value="17"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="Nationality" minOccurs="0" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Staatszugehörigkeit des Beförderungsmittels an der Grenze"/>
																<aie:id value="2602"/>
																<aie:status value="D"/>
																<aie:format value="an2"/>
																<aie:pcre value="\A.{2}\Z"/>
																<aie:list value="I0300"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:length value="2"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
												</xs:sequence>
											</xs:complexType>
										</xs:element>
									</xs:sequence>
								</xs:complexType>
							</xs:element>
						</xs:sequence>
					</xs:complexType>
				</xs:element>
			</xs:sequence>
		</xs:complexType>
	</xs:element>
</xs:schema>
'

IF EXISTS (SELECT * FROM sys.xml_schema_collections 
                    WHERE name = N'DE_IMP_GCCONI' 
                    AND schema_id = SCHEMA_ID(N'dbo'))
BEGIN
   DROP XML SCHEMA COLLECTION dbo.DE_IMP_GCCONI;
END
 
CREATE XML SCHEMA COLLECTION dbo.DE_IMP_GCCONI
AS N'<?xml version="1.0" encoding="UTF-16"?>
<xs:schema version="9.0.1.2" elementFormDefault="qualified" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:aie="urn:publicid:IDN+zoll.de:AIE">
	<xs:complexType name="decimal">
		<xs:simpleContent>
			<xs:extension base="xs:decimal">
				<xs:anyAttribute/>
			</xs:extension>
		</xs:simpleContent>
	</xs:complexType>
	<xs:complexType name="integer">
		<xs:simpleContent>
			<xs:extension base="xs:integer">
				<xs:anyAttribute/>
			</xs:extension>
		</xs:simpleContent>
	</xs:complexType>
	<xs:complexType name="token">
		<xs:simpleContent>
			<xs:extension base="xs:token">
				<xs:anyAttribute/>
			</xs:extension>
		</xs:simpleContent>
	</xs:complexType>
	<xs:element name="GCCONI" id="MES">
		<xs:annotation>
			<xs:documentation>
				<aie:name value="NACHRICHT"/>
				<aie:id value="1"/>
				<aie:status value="R"/>
			</xs:documentation>
		</xs:annotation>
		<xs:complexType>
			<xs:sequence>
				<xs:element name="MetaData" minOccurs="1" maxOccurs="1" id="MTD">
					<xs:annotation>
						<xs:documentation>
							<aie:name value="METADATEN"/>
							<aie:id value="159"/>
							<aie:status value="R"/>
						</xs:documentation>
					</xs:annotation>
					<xs:complexType>
						<xs:sequence>
							<xs:element name="Preparation" minOccurs="1" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="Vorbereitung"/>
										<aie:status value="R"/>
									</xs:documentation>
								</xs:annotation>
								<xs:complexType>
									<xs:sequence>
										<xs:element name="Date" minOccurs="1" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Vorbereitung (Datum)"/>
													<aie:id value="168"/>
													<aie:status value="R"/>
													<aie:format value="Date (n6)"/>
													<aie:pcre value="\A(?!....-(?:02|04|06|09|11)-31|....-02-30|..(?:.[13579]|[02468][26]|[13579][048])-02-29)^(?:20[0-9][0-9])-(?:0[1-9]|1[0-2])-(?:0[1-9]|[12][0-9]|3[01])\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:date">
													<xs:minInclusive value="2000-01-01"/>
													<xs:maxInclusive value="2099-12-31"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="Time" minOccurs="1" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Vorbereitung (Zeit)"/>
													<aie:id value="169"/>
													<aie:status value="R"/>
													<aie:format value="Time (n4)"/>
													<aie:pcre value="\A(?:[01][0-9]|2[0-3]):(?:[0-5][0-9]):(?:00)\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:time">
													<xs:minInclusive value="00:00:00"/>
													<xs:maxInclusive value="23:59:00"/>
													<xs:pattern value="[0-9]{2}:[0-9]{2}:[0-0]{2}"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
									</xs:sequence>
								</xs:complexType>
							</xs:element>
							<xs:element name="InterchangeControlReference" minOccurs="1" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="Datei-Kennung"/>
										<aie:id value="160"/>
										<aie:status value="R"/>
										<aie:format value="an..14"/>
										<aie:pcre value="\A.{1,14}\Z"/>
									</xs:documentation>
								</xs:annotation>
								<xs:simpleType>
									<xs:restriction base="xs:token">
										<xs:minLength value="1"/>
										<xs:maxLength value="14"/>
									</xs:restriction>
								</xs:simpleType>
							</xs:element>
							<xs:element name="MessageReferenceNumber" minOccurs="1" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="Identifikation"/>
										<aie:id value="161"/>
										<aie:status value="R"/>
										<aie:format value="n..6"/>
										<aie:pcre value="\A(?:0|[1-9][0-9]{0,5})\Z"/>
									</xs:documentation>
								</xs:annotation>
								<xs:simpleType>
									<xs:restriction base="xs:integer">
										<xs:minInclusive value="0"/>
										<xs:maxInclusive value="999999"/>
										<xs:totalDigits value="6"/>
										<xs:pattern value="(0|[1-9][0-9]{0,5})"/>
									</xs:restriction>
								</xs:simpleType>
							</xs:element>
							<xs:element name="MessageIdentifier" minOccurs="1" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="Nachrichtennummer"/>
										<aie:id value="163"/>
										<aie:status value="R"/>
										<aie:format value="an..35"/>
										<aie:pcre value="\A.{1,35}\Z"/>
									</xs:documentation>
								</xs:annotation>
								<xs:simpleType>
									<xs:restriction base="xs:token">
										<xs:minLength value="1"/>
										<xs:maxLength value="35"/>
									</xs:restriction>
								</xs:simpleType>
							</xs:element>
							<xs:element name="MessageGroup" minOccurs="1" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="Nachrichtengruppe"/>
										<aie:id value="162"/>
										<aie:status value="R"/>
										<aie:format value="a3"/>
										<aie:pcre value="\A(?:AVE|AVV|LVE|LVV|ZBV|ZVV)\Z"/>
										<aie:list value="A0110"/>
									</xs:documentation>
								</xs:annotation>
								<xs:simpleType>
									<xs:restriction base="xs:token">
										<xs:length value="3"/>
										<xs:enumeration value="AVE"/>
										<xs:enumeration value="AVV"/>
										<xs:enumeration value="LVE"/>
										<xs:enumeration value="LVV"/>
										<xs:enumeration value="ZBV"/>
										<xs:enumeration value="ZVV"/>
									</xs:restriction>
								</xs:simpleType>
							</xs:element>
							<xs:element name="Scenario" minOccurs="0" maxOccurs="0">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="Szenario"/>
										<aie:status value="N"/>
									</xs:documentation>
								</xs:annotation>
								<xs:complexType>
									<xs:sequence>
										<xs:element name="ReferenceNumber" minOccurs="0" maxOccurs="0">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Szenario-Nummer"/>
													<aie:id value="165"/>
													<aie:status value="N"/>
													<aie:format value="n5"/>
													<aie:pcre value="\A[1-9][0-9]{4}\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:length value="5"/>
													<xs:pattern value="[1-9][0-9]{4}"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="Note" minOccurs="0" maxOccurs="0">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Szenario-Hinweis"/>
													<aie:id value="164"/>
													<aie:status value="N"/>
													<aie:format value="a2"/>
													<aie:pcre value="\A[A-Z]{2}\Z"/>
													<aie:list value="A0112"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:length value="2"/>
													<xs:pattern value="[A-Z]{2}"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
									</xs:sequence>
								</xs:complexType>
							</xs:element>
							<xs:element name="TestIndicator" minOccurs="0" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="Test-Indikator"/>
										<aie:id value="166"/>
										<aie:status value="O"/>
										<aie:format value="n1"/>
										<aie:pcre value="\A1\Z"/>
										<aie:list value="A0035"/>
									</xs:documentation>
								</xs:annotation>
								<xs:simpleType>
									<xs:restriction base="xs:token">
										<xs:length value="1"/>
										<xs:enumeration value="1"/>
									</xs:restriction>
								</xs:simpleType>
							</xs:element>
							<xs:element name="MessageType" minOccurs="1" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="Typ"/>
										<aie:id value="167"/>
										<aie:status value="R"/>
										<aie:format value="a6"/>
										<aie:pcre value="\AGCCONI\Z"/>
										<aie:list value="A0057"/>
									</xs:documentation>
								</xs:annotation>
								<xs:simpleType>
									<xs:restriction base="xs:token">
										<xs:length value="6"/>
										<xs:enumeration value="GCCONI"/>
									</xs:restriction>
								</xs:simpleType>
							</xs:element>
							<xs:element name="InterchangeSender" minOccurs="1" maxOccurs="1" id="MST">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="NACHRICHTENSENDER"/>
										<aie:id value="241"/>
										<aie:status value="R"/>
									</xs:documentation>
								</xs:annotation>
								<xs:complexType>
									<xs:sequence>
										<xs:element name="Identification" minOccurs="1" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
												</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:sequence>
													<xs:element name="ReferenceNumber" minOccurs="1" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="TIN"/>
																<aie:id value="245"/>
																<aie:status value="R"/>
																<aie:format value="an..17"/>
																<aie:pcre value="\A[A-Z]{2}[\x21-\x7E]{1,15}\Z"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:minLength value="1"/>
																<xs:maxLength value="17"/>
																<xs:pattern value="[A-Z]{2}[&#x21;-&#x7E;]{1,15}"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="SubsidiaryNumber" minOccurs="1" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Niederlassungsnummer"/>
																<aie:id value="244"/>
																<aie:status value="R"/>
																<aie:format value="n4"/>
																<aie:pcre value="\A[0-9]{4}\Z"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:length value="4"/>
																<xs:pattern value="[0-9]{4}"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
												</xs:sequence>
											</xs:complexType>
										</xs:element>
									</xs:sequence>
								</xs:complexType>
							</xs:element>
							<xs:element name="InterchangeRecipient" minOccurs="1" maxOccurs="1" id="MED">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="NACHRICHTENEMPFÄNGER"/>
										<aie:id value="170"/>
										<aie:status value="R"/>
									</xs:documentation>
								</xs:annotation>
								<xs:complexType>
									<xs:sequence>
										<xs:element name="Identification" minOccurs="1" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Dienststellennummer"/>
													<aie:status value="R"/>
												</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:sequence>
													<xs:element name="ReferenceNumber" minOccurs="1" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:id value="173"/>
																<aie:format value="an8"/>
																<aie:pcre value="\ADE00[0-9]{4}\Z"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:length value="8"/>
																<xs:pattern value="DE00[0-9]{4}"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
												</xs:sequence>
											</xs:complexType>
										</xs:element>
									</xs:sequence>
								</xs:complexType>
							</xs:element>
						</xs:sequence>
					</xs:complexType>
				</xs:element>
				<xs:element name="Header" minOccurs="1" maxOccurs="1" id="HEA">
					<xs:annotation>
						<xs:documentation>
							<aie:name value="KOPF"/>
							<aie:id value="3647"/>
							<aie:status value="R"/>
						</xs:documentation>
					</xs:annotation>
					<xs:complexType>
						<xs:sequence>
							<xs:element name="MessageVersion" minOccurs="1" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="Nachrichtenversion"/>
										<aie:id value="89"/>
										<aie:status value="R"/>
										<aie:format value="an..7"/>
										<aie:pcre value="\AI\.[1-9][0-9]?\.[1-9]?[0-9]\Z"/>
									</xs:documentation>
								</xs:annotation>
								<xs:simpleType>
									<xs:restriction base="xs:token">
										<xs:minLength value="1"/>
										<xs:maxLength value="7"/>
										<xs:pattern value="I\.[1-9][0-9]?\.[1-9]?[0-9]"/>
									</xs:restriction>
								</xs:simpleType>
							</xs:element>
							<xs:element name="TemporaryReferenceNumber" minOccurs="1" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="Arbeitsnummer der vorzeitigen Anmeldung"/>
										<aie:id value="22"/>
										<aie:status value="R"/>
										<aie:format value="an21"/>
										<aie:pcre value="\AAT[A-Z][0-9]{2}[0-9]{6}(?:0[1-9]|1[0-2])20[0-9]{2}[0-9]{4}\Z"/>
									</xs:documentation>
								</xs:annotation>
								<xs:simpleType>
									<xs:restriction base="xs:token">
										<xs:length value="21"/>
										<xs:pattern value="AT[A-Z][0-9]{2}[0-9]{6}(0[1-9]|1[0-2])20[0-9]{2}[0-9]{4}"/>
									</xs:restriction>
								</xs:simpleType>
							</xs:element>
							<xs:element name="LocalReferenceNumber" minOccurs="0" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="Bezugsnummer"/>
										<aie:id value="46"/>
										<aie:status value="O"/>
										<aie:format value="an..35"/>
										<aie:pcre value="\A.{1,35}\Z"/>
									</xs:documentation>
								</xs:annotation>
								<xs:simpleType>
									<xs:restriction base="xs:token">
										<xs:minLength value="1"/>
										<xs:maxLength value="35"/>
									</xs:restriction>
								</xs:simpleType>
							</xs:element>
							<xs:element name="GoodsLocation" minOccurs="0" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="Warenort"/>
										<aie:id value="139"/>
										<aie:status value="O"/>
										<aie:format value="an..35"/>
										<aie:pcre value="\A.{1,35}\Z"/>
									</xs:documentation>
								</xs:annotation>
								<xs:simpleType>
									<xs:restriction base="xs:token">
										<xs:minLength value="1"/>
										<xs:maxLength value="35"/>
									</xs:restriction>
								</xs:simpleType>
							</xs:element>
							<xs:element name="AuthorisationNumber" minOccurs="1" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="BIN"/>
										<aie:id value="48"/>
										<aie:status value="R"/>
										<aie:format value="an25"/>
										<aie:pcre value="\A.{25}\Z"/>
									</xs:documentation>
								</xs:annotation>
								<xs:simpleType>
									<xs:restriction base="xs:token">
										<xs:length value="25"/>
									</xs:restriction>
								</xs:simpleType>
							</xs:element>
						</xs:sequence>
					</xs:complexType>
				</xs:element>
				<xs:element name="PresentationConfirmer" minOccurs="1" maxOccurs="1" id="FS0">
					<xs:annotation>
						<xs:documentation>
							<aie:name value="ANGABEN ZUM GESTELLUNGSBESTÄTIGER"/>
							<aie:id value="1265"/>
							<aie:status value="R"/>
						</xs:documentation>
					</xs:annotation>
					<xs:complexType>
						<xs:sequence>
							<xs:element name="Identification" minOccurs="1" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
									</xs:documentation>
								</xs:annotation>
								<xs:complexType>
									<xs:sequence>
										<xs:element name="ReferenceNumber" minOccurs="1" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="TIN"/>
													<aie:id value="1269"/>
													<aie:status value="R"/>
													<aie:format value="an..17"/>
													<aie:pcre value="\A(?:[A-Z]{2}[\x21-\x7E]{1,15}|0{17})\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:minLength value="1"/>
													<xs:maxLength value="17"/>
													<xs:pattern value="[A-Z]{2}[&#x21;-&#x7E;]{1,15}"/>
													<xs:pattern value="0{17}"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="SubsidiaryNumber" minOccurs="0" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Niederlassungsnummer"/>
													<aie:id value="1268"/>
													<aie:status value="O"/>
													<aie:format value="n4"/>
													<aie:pcre value="\A[0-9]{4}\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:length value="4"/>
													<xs:pattern value="[0-9]{4}"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
									</xs:sequence>
								</xs:complexType>
							</xs:element>
						</xs:sequence>
					</xs:complexType>
				</xs:element>
				<xs:element name="ContactPerson" minOccurs="1" maxOccurs="1" id="PK0">
					<xs:annotation>
						<xs:documentation>
							<aie:name value="ANGABEN ZUM ANSPRECHPARTNER FIRMA"/>
							<aie:id value="517"/>
							<aie:status value="R"/>
						</xs:documentation>
					</xs:annotation>
					<xs:complexType>
						<xs:sequence>
							<xs:element name="Name" minOccurs="1" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="Name"/>
										<aie:id value="520"/>
										<aie:status value="R"/>
										<aie:format value="an..35"/>
										<aie:pcre value="\A.{1,35}\Z"/>
									</xs:documentation>
								</xs:annotation>
								<xs:simpleType>
									<xs:restriction base="xs:token">
										<xs:minLength value="1"/>
										<xs:maxLength value="35"/>
									</xs:restriction>
								</xs:simpleType>
							</xs:element>
							<xs:element name="Position" minOccurs="1" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="Stellung in der Firma"/>
										<aie:id value="521"/>
										<aie:status value="R"/>
										<aie:format value="an..35"/>
										<aie:pcre value="\A.{1,35}\Z"/>
									</xs:documentation>
								</xs:annotation>
								<xs:simpleType>
									<xs:restriction base="xs:token">
										<xs:minLength value="1"/>
										<xs:maxLength value="35"/>
									</xs:restriction>
								</xs:simpleType>
							</xs:element>
							<xs:element name="PhoneNumber" minOccurs="1" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="Telefonnummer"/>
										<aie:id value="522"/>
										<aie:status value="R"/>
										<aie:format value="an..35"/>
										<aie:pcre value="\A.{1,35}\Z"/>
									</xs:documentation>
								</xs:annotation>
								<xs:simpleType>
									<xs:restriction base="xs:token">
										<xs:minLength value="1"/>
										<xs:maxLength value="35"/>
									</xs:restriction>
								</xs:simpleType>
							</xs:element>
							<xs:element name="MailAddress" minOccurs="0" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="E-Mail-Adresse"/>
										<aie:id value="518"/>
										<aie:status value="O"/>
										<aie:format value="an..256"/>
										<aie:pcre value="\A(?=.{1,256}\Z)[A-Za-z0-9!#$%&amp;&apos;*+/=?^_`{|}~-]+(?:\.[A-Za-z0-9!#$%&amp;&apos;*+/=?^_`{|}~-]+)*@(?:[A-Za-z0-9](?:[A-Za-z0-9-]*[A-Za-z0-9])?\.)+[A-Za-z0-9](?:[A-Za-z0-9-]*[A-Za-z0-9])?\Z"/>
									</xs:documentation>
								</xs:annotation>
								<xs:simpleType>
									<xs:restriction base="xs:token">
										<xs:minLength value="1"/>
										<xs:maxLength value="256"/>
										<xs:pattern value="[A-Za-z0-9!#$%&amp;&apos;*+/=?\^_`{|}~\-]+(\.[A-Za-z0-9!#$%&amp;&apos;*+/=?\^_`{|}~\-]+)*@([A-Za-z0-9]([A-Za-z0-9\-]*[A-Za-z0-9])?\.)+[A-Za-z0-9]([A-Za-z0-9\-]*[A-Za-z0-9])?"/>
									</xs:restriction>
								</xs:simpleType>
							</xs:element>
						</xs:sequence>
					</xs:complexType>
				</xs:element>
				<xs:element name="ArrivalTransportMeans" minOccurs="0" maxOccurs="1" id="BMN">
					<xs:annotation>
						<xs:documentation>
							<aie:name value="BEFÖRDERUNGSMITTEL BEI ANKUNFT"/>
							<aie:id value="729"/>
							<aie:status value="D"/>
						</xs:documentation>
					</xs:annotation>
					<xs:complexType>
						<xs:sequence>
							<xs:element name="Identity" minOccurs="1" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="Kennzeichen des Beförderungsmittels bei Ankunft"/>
										<aie:id value="731"/>
										<aie:status value="R"/>
										<aie:format value="an..30"/>
										<aie:pcre value="\A.{1,30}\Z"/>
									</xs:documentation>
								</xs:annotation>
								<xs:simpleType>
									<xs:restriction base="xs:token">
										<xs:minLength value="1"/>
										<xs:maxLength value="30"/>
									</xs:restriction>
								</xs:simpleType>
							</xs:element>
						</xs:sequence>
					</xs:complexType>
				</xs:element>
				<xs:element name="PreviousAdministrativeReferences" minOccurs="0" maxOccurs="1" id="DP0">
					<xs:annotation>
						<xs:documentation>
							<aie:name value="VORPAPIERE"/>
							<aie:id value="1838"/>
							<aie:status value="O"/>
						</xs:documentation>
					</xs:annotation>
					<xs:complexType>
						<xs:sequence>
							<xs:element name="Type" minOccurs="1" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="Vorpapierart"/>
										<aie:id value="1839"/>
										<aie:status value="R"/>
										<aie:format value="an..6"/>
										<aie:pcre value="\A(?:AT-AV|AT-ZL|ATA|ATNEU|ESUMA|GB|OHNE|POST|PUEB|T1|T2|TIR|VER321|VO)\Z"/>
										<aie:list value="A2020"/>
									</xs:documentation>
								</xs:annotation>
								<xs:simpleType>
									<xs:restriction base="xs:token">
										<xs:minLength value="1"/>
										<xs:maxLength value="6"/>
										<xs:pattern value="AT-AV"/>
										<xs:pattern value="AT-ZL"/>
										<xs:pattern value="ATA"/>
										<xs:pattern value="ATNEU"/>
										<xs:pattern value="ESUMA"/>
										<xs:pattern value="GB"/>
										<xs:pattern value="OHNE"/>
										<xs:pattern value="POST"/>
										<xs:pattern value="PUEB"/>
										<xs:pattern value="T1"/>
										<xs:pattern value="T2"/>
										<xs:pattern value="TIR"/>
										<xs:pattern value="VER321"/>
										<xs:pattern value="VO"/>
									</xs:restriction>
								</xs:simpleType>
							</xs:element>
							<xs:element name="PreviousAdministrativeReference" minOccurs="0" maxOccurs="1" id="DP1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="VORPAPIER"/>
										<aie:id value="1840"/>
										<aie:status value="D"/>
									</xs:documentation>
								</xs:annotation>
								<xs:complexType>
									<xs:sequence>
										<xs:element name="ReferenceNumber" minOccurs="1" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Vorpapiernummer"/>
													<aie:id value="1841"/>
													<aie:status value="R"/>
													<aie:format value="an..28"/>
													<aie:pcre value="\A.{1,28}\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:minLength value="1"/>
													<xs:maxLength value="28"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
									</xs:sequence>
								</xs:complexType>
							</xs:element>
						</xs:sequence>
					</xs:complexType>
				</xs:element>
				<xs:element name="SummaryDeclaration" minOccurs="0" maxOccurs="1" id="BSK">
					<xs:annotation>
						<xs:documentation>
							<aie:name value="BEENDIGUNGSANTEIL SUMA"/>
							<aie:id value="639"/>
							<aie:status value="D"/>
						</xs:documentation>
					</xs:annotation>
					<xs:complexType>
						<xs:sequence>
							<xs:element name="IdentificationIndicator" minOccurs="1" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="Art der Identifikation"/>
										<aie:id value="641"/>
										<aie:status value="R"/>
										<aie:format value="an..3"/>
										<aie:pcre value="\A(?:AWB|REG)\Z"/>
										<aie:list value="A1125"/>
									</xs:documentation>
								</xs:annotation>
								<xs:simpleType>
									<xs:restriction base="xs:token">
										<xs:length value="3"/>
										<xs:enumeration value="AWB"/>
										<xs:enumeration value="REG"/>
									</xs:restriction>
								</xs:simpleType>
							</xs:element>
							<xs:element name="GoodsItem" minOccurs="1" maxOccurs="999" id="BSP">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="POSITION (BE-ANTEIL SUMA)"/>
										<aie:id value="644"/>
										<aie:status value="R"/>
									</xs:documentation>
								</xs:annotation>
								<xs:complexType>
									<xs:sequence>
										<xs:element name="Quantity" minOccurs="1" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Stückzahl"/>
													<aie:id value="646"/>
													<aie:status value="R"/>
													<aie:format value="n..5"/>
													<aie:pcre value="\A[1-9][0-9]{0,4}\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:integer">
													<xs:minInclusive value="1"/>
													<xs:maxInclusive value="99999"/>
													<xs:totalDigits value="5"/>
													<xs:pattern value="[1-9][0-9]{0,4}"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="IdentificationByKey" minOccurs="0" maxOccurs="1" id="BSO">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="ORDNUNGSBEGRIFF BEZOGENE ERLEDIGUNG"/>
													<aie:id value="3650"/>
													<aie:status value="D"/>
												</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:sequence>
													<xs:element name="Kind" minOccurs="1" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Art SpO"/>
																<aie:id value="3655"/>
																<aie:status value="R"/>
																<aie:format value="an3"/>
																<aie:pcre value="\A(?:AWB|ULD)\Z"/>
																<aie:list value="A1180"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:length value="3"/>
																<xs:enumeration value="AWB"/>
																<xs:enumeration value="ULD"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="Number" minOccurs="1" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Spezifischer Ordnungsbegriff"/>
																<aie:id value="3654"/>
																<aie:status value="R"/>
																<aie:format value="an..44"/>
																<aie:pcre value="\A.{1,44}\Z"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:minLength value="1"/>
																<xs:maxLength value="44"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="Custodian" minOccurs="1" maxOccurs="1" id="BSV">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="ANGABEN ZUM VERWAHRER"/>
																<aie:id value="3658"/>
																<aie:status value="R"/>
															</xs:documentation>
														</xs:annotation>
														<xs:complexType>
															<xs:sequence>
																<xs:element name="Identification" minOccurs="1" maxOccurs="1">
																	<xs:annotation>
																		<xs:documentation>
																			<aie:name value="TIN"/>
																			<aie:status value="R"/>
																		</xs:documentation>
																	</xs:annotation>
																	<xs:complexType>
																		<xs:sequence>
																			<xs:element name="ReferenceNumber" minOccurs="1" maxOccurs="1">
																				<xs:annotation>
																					<xs:documentation>
																						<aie:id value="3662"/>
																						<aie:format value="an..17"/>
																						<aie:pcre value="\A(?:[A-Z]{2}[\x21-\x7E]{1,15}|0{17})\Z"/>
																					</xs:documentation>
																				</xs:annotation>
																				<xs:simpleType>
																					<xs:restriction base="xs:token">
																						<xs:minLength value="1"/>
																						<xs:maxLength value="17"/>
																						<xs:pattern value="[A-Z]{2}[&#x21;-&#x7E;]{1,15}"/>
																						<xs:pattern value="0{17}"/>
																					</xs:restriction>
																				</xs:simpleType>
																			</xs:element>
																		</xs:sequence>
																	</xs:complexType>
																</xs:element>
															</xs:sequence>
														</xs:complexType>
													</xs:element>
												</xs:sequence>
											</xs:complexType>
										</xs:element>
										<xs:element name="IdentificationByRegistration" minOccurs="0" maxOccurs="1" id="BSR">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="REGISTRIERNUMMER BEZOGENE ERLEDIGUNG"/>
													<aie:id value="3682"/>
													<aie:status value="D"/>
												</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:sequence>
													<xs:element name="ReferencedRegistrationNumber" minOccurs="1" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Registriernummer SumA"/>
																<aie:id value="3684"/>
																<aie:status value="R"/>
																<aie:format value="an21"/>
																<aie:pcre value="\AAT[A-Z][0-9]{2}[0-9]{6}(?:0[1-9]|1[0-2])20[0-9]{2}[0-9]{4}\Z"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:length value="21"/>
																<xs:pattern value="AT[A-Z][0-9]{2}[0-9]{6}(0[1-9]|1[0-2])20[0-9]{2}[0-9]{4}"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="ReferencedSequenceNumber" minOccurs="1" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Positionsnummer SumA"/>
																<aie:id value="3683"/>
																<aie:status value="R"/>
																<aie:format value="n..4"/>
																<aie:pcre value="\A[1-9][0-9]{0,3}\Z"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:integer">
																<xs:minInclusive value="1"/>
																<xs:maxInclusive value="9999"/>
																<xs:totalDigits value="4"/>
																<xs:pattern value="[1-9][0-9]{0,3}"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
												</xs:sequence>
											</xs:complexType>
										</xs:element>
									</xs:sequence>
								</xs:complexType>
							</xs:element>
						</xs:sequence>
					</xs:complexType>
				</xs:element>
				<xs:element name="CustomsWarehouse" minOccurs="0" maxOccurs="1" id="BLK">
					<xs:annotation>
						<xs:documentation>
							<aie:name value="BEENDIGUNGSANTEIL ZL"/>
							<aie:id value="677"/>
							<aie:status value="D"/>
						</xs:documentation>
					</xs:annotation>
					<xs:complexType>
						<xs:sequence>
							<xs:element name="SequenceNumber" minOccurs="1" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="Nummer"/>
										<aie:id value="681"/>
										<aie:status value="R"/>
										<aie:format value="n..5"/>
										<aie:pcre value="\A1\Z"/>
									</xs:documentation>
								</xs:annotation>
								<xs:simpleType>
									<xs:restriction base="xs:token">
										<xs:length value="1"/>
										<xs:enumeration value="1"/>
									</xs:restriction>
								</xs:simpleType>
							</xs:element>
							<xs:element name="GoodsItemQuantity" minOccurs="1" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="Anzahl Positionen"/>
										<aie:id value="682"/>
										<aie:status value="R"/>
										<aie:format value="n..3"/>
										<aie:pcre value="\A[1-9][0-9]{0,2}\Z"/>
									</xs:documentation>
								</xs:annotation>
								<xs:simpleType>
									<xs:restriction base="xs:integer">
										<xs:minInclusive value="1"/>
										<xs:maxInclusive value="999"/>
										<xs:totalDigits value="3"/>
										<xs:pattern value="[1-9][0-9]{0,2}"/>
									</xs:restriction>
								</xs:simpleType>
							</xs:element>
							<xs:element name="CustomsAuthorisation" minOccurs="1" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="Bewilligungsnummer"/>
										<aie:status value="R"/>
									</xs:documentation>
								</xs:annotation>
								<xs:complexType>
									<xs:sequence>
										<xs:element name="WarehouseOwner" minOccurs="1" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:id value="679"/>
													<aie:format value="an..35"/>
													<aie:pcre value="\A(?:[A-Z]{2}[0-9]{4}[A-Z][A-Z0-9][0-9]{1,4}|[A-Z]{2}.{1,4}.{1,29})\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:minLength value="1"/>
													<xs:maxLength value="35"/>
													<xs:pattern value="[A-Z]{2}[0-9]{4}[A-Z][A-Z0-9][0-9]{1,4}"/>
													<xs:pattern value="[A-Z]{2}.{1,4}.{1,29}"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
									</xs:sequence>
								</xs:complexType>
							</xs:element>
							<xs:element name="LocalReferenceNumber" minOccurs="0" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="Bezugsnummer"/>
										<aie:id value="680"/>
										<aie:status value="O"/>
										<aie:format value="an..35"/>
										<aie:pcre value="\A.{1,35}\Z"/>
									</xs:documentation>
								</xs:annotation>
								<xs:simpleType>
									<xs:restriction base="xs:token">
										<xs:minLength value="1"/>
										<xs:maxLength value="35"/>
									</xs:restriction>
								</xs:simpleType>
							</xs:element>
							<xs:element name="GoodsItem" minOccurs="1" maxOccurs="999" id="BLP">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="POSITION (BE-ANTEIL ZL)"/>
										<aie:id value="684"/>
										<aie:status value="R"/>
									</xs:documentation>
								</xs:annotation>
								<xs:complexType>
									<xs:sequence>
										<xs:element name="SequenceNumber" minOccurs="1" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Positionsnummer"/>
													<aie:id value="685"/>
													<aie:status value="R"/>
													<aie:format value="n..3"/>
													<aie:pcre value="\A[1-9][0-9]{0,2}\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:integer">
													<xs:minInclusive value="1"/>
													<xs:maxInclusive value="999"/>
													<xs:totalDigits value="3"/>
													<xs:pattern value="[1-9][0-9]{0,2}"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="ReferencedRegistrationNumber" minOccurs="1" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Registriernummer des Zugangs"/>
													<aie:id value="690"/>
													<aie:status value="R"/>
													<aie:format value="an..35"/>
													<aie:pcre value="\A.{1,35}\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:minLength value="1"/>
													<xs:maxLength value="35"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="ReferencedSequenceNumber" minOccurs="1" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Position des Zugangs"/>
													<aie:id value="689"/>
													<aie:status value="R"/>
													<aie:format value="n..5"/>
													<aie:pcre value="\A[1-9][0-9]{0,4}\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:integer">
													<xs:minInclusive value="1"/>
													<xs:maxInclusive value="99999"/>
													<xs:totalDigits value="5"/>
													<xs:pattern value="[1-9][0-9]{0,4}"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="AccessViaAtlasFlag" minOccurs="1" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Kennzeichen Zugang in ATLAS"/>
													<aie:id value="688"/>
													<aie:status value="R"/>
													<aie:format value="an1"/>
													<aie:pcre value="\A.\Z"/>
													<aie:list value="A1810"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:length value="1"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="CommodityCode" minOccurs="1" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Warennummer"/>
													<aie:id value="687"/>
													<aie:status value="R"/>
													<aie:format value="n11"/>
													<aie:pcre value="\A[0-9]{11}\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:length value="11"/>
													<xs:pattern value="[0-9]{11}"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="UsualProcessingFlag" minOccurs="1" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Kennzeichen Übliche Behandlung"/>
													<aie:id value="686"/>
													<aie:status value="R"/>
													<aie:format value="an1"/>
													<aie:pcre value="\A.\Z"/>
													<aie:list value="A1740"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:length value="1"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="Complement" minOccurs="0" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Positionszusatz"/>
													<aie:id value="691"/>
													<aie:status value="O"/>
													<aie:format value="an..100"/>
													<aie:pcre value="\A.{1,100}\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:minLength value="1"/>
													<xs:maxLength value="100"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="CommercialAmount" minOccurs="0" maxOccurs="1" id="BLH">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="ANGABEN ZUR HANDELSMENGE (BE-ANTEIL ZL)"/>
													<aie:id value="696"/>
													<aie:status value="D"/>
												</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:sequence>
													<xs:element name="Quantity" minOccurs="1" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Handelsmenge"/>
																<aie:id value="698"/>
																<aie:status value="R"/>
																<aie:format value="n..12 (12,3)"/>
																<aie:pcre value="\A(?!0\.?0*\Z)(?:0|[1-9][0-9]{0,8})(?:\.[0-9]{1,3})?\Z"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:decimal">
																<xs:minInclusive value="0.001"/>
																<xs:maxInclusive value="999999999.999"/>
																<xs:totalDigits value="12"/>
																<xs:fractionDigits value="3"/>
																<xs:pattern value="(0|[1-9][0-9]{0,8})(\.[0-9]{1,3})?"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="MeasurementUnit" minOccurs="1" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Maßeinheit (Handelsmenge)"/>
																<aie:id value="697"/>
																<aie:status value="R"/>
																<aie:format value="an3"/>
																<aie:pcre value="\A.{3}\Z"/>
																<aie:list value="I0700"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:length value="3"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="Qualifier" minOccurs="0" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Qualifikator (Handelsmenge)"/>
																<aie:id value="699"/>
																<aie:status value="D"/>
																<aie:format value="an1"/>
																<aie:pcre value="\A.\Z"/>
																<aie:list value="I0700"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:length value="1"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
												</xs:sequence>
											</xs:complexType>
										</xs:element>
										<xs:element name="DebitAmount" minOccurs="1" maxOccurs="1" id="BLA">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="ANGABEN ZUR ABGANGSMENGE (BE-ANTEIL ZL)"/>
													<aie:id value="692"/>
													<aie:status value="R"/>
												</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:sequence>
													<xs:element name="Quantity" minOccurs="1" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Abgangsmenge"/>
																<aie:id value="694"/>
																<aie:status value="R"/>
																<aie:format value="n..12 (12,3)"/>
																<aie:pcre value="\A(?!0\.?0*\Z)(?:0|[1-9][0-9]{0,8})(?:\.[0-9]{1,3})?\Z"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:decimal">
																<xs:minInclusive value="0.001"/>
																<xs:maxInclusive value="999999999.999"/>
																<xs:totalDigits value="12"/>
																<xs:fractionDigits value="3"/>
																<xs:pattern value="(0|[1-9][0-9]{0,8})(\.[0-9]{1,3})?"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="MeasurementUnit" minOccurs="1" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Maßeinheit (Abgangsmenge)"/>
																<aie:id value="693"/>
																<aie:status value="R"/>
																<aie:format value="an3"/>
																<aie:pcre value="\A.{3}\Z"/>
																<aie:list value="I0700"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:length value="3"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="Qualifier" minOccurs="0" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Qualifikator (Abgangsmenge)"/>
																<aie:id value="695"/>
																<aie:status value="D"/>
																<aie:format value="an1"/>
																<aie:pcre value="\A.\Z"/>
																<aie:list value="I0700"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:length value="1"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
												</xs:sequence>
											</xs:complexType>
										</xs:element>
									</xs:sequence>
								</xs:complexType>
							</xs:element>
						</xs:sequence>
					</xs:complexType>
				</xs:element>
				<xs:element name="InwardProcessing" minOccurs="0" maxOccurs="1" id="BVK">
					<xs:annotation>
						<xs:documentation>
							<aie:name value="BEENDIGUNGSANTEIL AV"/>
							<aie:id value="627"/>
							<aie:status value="D"/>
						</xs:documentation>
					</xs:annotation>
					<xs:complexType>
						<xs:sequence>
							<xs:element name="SequenceNumber" minOccurs="1" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="Nummer"/>
										<aie:id value="630"/>
										<aie:status value="R"/>
										<aie:format value="n..5"/>
										<aie:pcre value="\A1\Z"/>
									</xs:documentation>
								</xs:annotation>
								<xs:simpleType>
									<xs:restriction base="xs:token">
										<xs:length value="1"/>
										<xs:enumeration value="1"/>
									</xs:restriction>
								</xs:simpleType>
							</xs:element>
							<xs:element name="GoodsItemQuantity" minOccurs="1" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="Anzahl Positionen"/>
										<aie:id value="631"/>
										<aie:status value="R"/>
										<aie:format value="n..3"/>
										<aie:pcre value="\A[1-9][0-9]{0,2}\Z"/>
									</xs:documentation>
								</xs:annotation>
								<xs:simpleType>
									<xs:restriction base="xs:integer">
										<xs:minInclusive value="1"/>
										<xs:maxInclusive value="999"/>
										<xs:totalDigits value="3"/>
										<xs:pattern value="[1-9][0-9]{0,2}"/>
									</xs:restriction>
								</xs:simpleType>
							</xs:element>
							<xs:element name="CustomsAuthorisation" minOccurs="0" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="Bewilligungsnummer"/>
										<aie:status value="D"/>
									</xs:documentation>
								</xs:annotation>
								<xs:complexType>
									<xs:sequence>
										<xs:element name="ProcessingOwner" minOccurs="1" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:id value="629"/>
													<aie:format value="an..35"/>
													<aie:pcre value="\A(?:[A-Z]{2}[0-9]{4}[A-Z][A-Z0-9][0-9]{1,4}|[A-Z]{2}.{1,4}.{1,29})\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:minLength value="1"/>
													<xs:maxLength value="35"/>
													<xs:pattern value="[A-Z]{2}[0-9]{4}[A-Z][A-Z0-9][0-9]{1,4}"/>
													<xs:pattern value="[A-Z]{2}.{1,4}.{1,29}"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
									</xs:sequence>
								</xs:complexType>
							</xs:element>
							<xs:element name="SimplifiedGrantAuthorisationFlag" minOccurs="1" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="Kennzeichen Vereinfachter Bewilligungsantrag AV (BE-Anteil AV)"/>
										<aie:id value="4306"/>
										<aie:status value="R"/>
										<aie:format value="a1"/>
										<aie:pcre value="\A\D\Z"/>
										<aie:list value="A1765"/>
									</xs:documentation>
								</xs:annotation>
								<xs:simpleType>
									<xs:restriction base="xs:token">
										<xs:length value="1"/>
										<xs:pattern value="[^0-9]"/>
									</xs:restriction>
								</xs:simpleType>
							</xs:element>
							<xs:element name="MonitoringCustomsOffice" minOccurs="0" maxOccurs="1" id="HAD">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="ANGABEN ZUR ÜBERWACHUNGSZOLLSTELLE AV (BE-ANTEIL AV)"/>
										<aie:id value="4307"/>
										<aie:status value="D"/>
									</xs:documentation>
								</xs:annotation>
								<xs:complexType>
									<xs:sequence>
										<xs:element name="Identification" minOccurs="1" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Dienststellennummer"/>
													<aie:status value="R"/>
												</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:sequence>
													<xs:element name="ReferenceNumber" minOccurs="1" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:id value="4308"/>
																<aie:format value="an8"/>
																<aie:pcre value="\ADE00[0-9]{4}\Z"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:length value="8"/>
																<xs:pattern value="DE00[0-9]{4}"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
												</xs:sequence>
											</xs:complexType>
										</xs:element>
									</xs:sequence>
								</xs:complexType>
							</xs:element>
							<xs:element name="GoodsItem" minOccurs="1" maxOccurs="999" id="BVP">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="POSITION (BE-ANTEIL AV)"/>
										<aie:id value="633"/>
										<aie:status value="R"/>
									</xs:documentation>
								</xs:annotation>
								<xs:complexType>
									<xs:sequence>
										<xs:element name="SequenceNumber" minOccurs="1" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Positionsnummer"/>
													<aie:id value="634"/>
													<aie:status value="R"/>
													<aie:format value="n..3"/>
													<aie:pcre value="\A[1-9][0-9]{0,2}\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:integer">
													<xs:minInclusive value="1"/>
													<xs:maxInclusive value="999"/>
													<xs:totalDigits value="3"/>
													<xs:pattern value="[1-9][0-9]{0,2}"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="ReferencedRegistrationNumber" minOccurs="1" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Registriernummer des Zugangs"/>
													<aie:id value="638"/>
													<aie:status value="R"/>
													<aie:format value="an..35"/>
													<aie:pcre value="\A.{1,35}\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:minLength value="1"/>
													<xs:maxLength value="35"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="ReferencedSequenceNumber" minOccurs="1" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Position des Zugangs"/>
													<aie:id value="637"/>
													<aie:status value="R"/>
													<aie:format value="n..5"/>
													<aie:pcre value="\A[1-9][0-9]{0,4}\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:integer">
													<xs:minInclusive value="1"/>
													<xs:maxInclusive value="99999"/>
													<xs:totalDigits value="5"/>
													<xs:pattern value="[1-9][0-9]{0,4}"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="AccessViaAtlasFlag" minOccurs="1" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Kennzeichen Zugang in ATLAS"/>
													<aie:id value="636"/>
													<aie:status value="R"/>
													<aie:format value="an1"/>
													<aie:pcre value="\A.\Z"/>
													<aie:list value="A1810"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:length value="1"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="GoodsRelatedInformation" minOccurs="1" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Warenbezogene Angaben"/>
													<aie:id value="635"/>
													<aie:status value="R"/>
													<aie:format value="an..350"/>
													<aie:pcre value="\A.{1,350}\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:minLength value="1"/>
													<xs:maxLength value="350"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
									</xs:sequence>
								</xs:complexType>
							</xs:element>
						</xs:sequence>
					</xs:complexType>
				</xs:element>
			</xs:sequence>
		</xs:complexType>
	</xs:element>
</xs:schema>
'

IF EXISTS (SELECT * FROM sys.xml_schema_collections 
                    WHERE name = N'DE_IMP_GSCOPK' 
                    AND schema_id = SCHEMA_ID(N'dbo'))
BEGIN
   DROP XML SCHEMA COLLECTION dbo.DE_IMP_GSCOPK;
END
 
CREATE XML SCHEMA COLLECTION dbo.DE_IMP_GSCOPK
AS N'<?xml version="1.0" encoding="UTF-16"?>
<xs:schema version="9.0.0.8" elementFormDefault="qualified" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:aie="urn:publicid:IDN+zoll.de:AIE">
	<xs:complexType name="decimal">
		<xs:simpleContent>
			<xs:extension base="xs:decimal">
				<xs:anyAttribute/>
			</xs:extension>
		</xs:simpleContent>
	</xs:complexType>
	<xs:complexType name="integer">
		<xs:simpleContent>
			<xs:extension base="xs:integer">
				<xs:anyAttribute/>
			</xs:extension>
		</xs:simpleContent>
	</xs:complexType>
	<xs:complexType name="token">
		<xs:simpleContent>
			<xs:extension base="xs:token">
				<xs:anyAttribute/>
			</xs:extension>
		</xs:simpleContent>
	</xs:complexType>
	<xs:element name="GSCOPK" id="MES">
		<xs:annotation>
			<xs:documentation>
				<aie:name value="NACHRICHT"/>
				<aie:id value="1"/>
				<aie:status value="R"/>
			</xs:documentation>
		</xs:annotation>
		<xs:complexType>
			<xs:sequence>
				<xs:element name="MetaData" minOccurs="1" maxOccurs="1" id="MTD">
					<xs:annotation>
						<xs:documentation>
							<aie:name value="METADATEN"/>
							<aie:id value="159"/>
							<aie:status value="R"/>
						</xs:documentation>
					</xs:annotation>
					<xs:complexType>
						<xs:sequence>
							<xs:element name="Preparation" minOccurs="1" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="Vorbereitung"/>
										<aie:status value="R"/>
									</xs:documentation>
								</xs:annotation>
								<xs:complexType>
									<xs:sequence>
										<xs:element name="Date" minOccurs="1" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Vorbereitung (Datum)"/>
													<aie:id value="168"/>
													<aie:status value="R"/>
													<aie:format value="Date (n6)"/>
													<aie:pcre value="\A(?!....-(?:02|04|06|09|11)-31|....-02-30|..(?:.[13579]|[02468][26]|[13579][048])-02-29)^(?:20[0-9][0-9])-(?:0[1-9]|1[0-2])-(?:0[1-9]|[12][0-9]|3[01])\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:date">
													<xs:minInclusive value="2000-01-01"/>
													<xs:maxInclusive value="2099-12-31"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="Time" minOccurs="1" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Vorbereitung (Zeit)"/>
													<aie:id value="169"/>
													<aie:status value="R"/>
													<aie:format value="Time (n4)"/>
													<aie:pcre value="\A(?:[01][0-9]|2[0-3]):(?:[0-5][0-9]):(?:00)\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:time">
													<xs:minInclusive value="00:00:00"/>
													<xs:maxInclusive value="23:59:00"/>
													<xs:pattern value="[0-9]{2}:[0-9]{2}:[0-0]{2}"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
									</xs:sequence>
								</xs:complexType>
							</xs:element>
							<xs:element name="InterchangeControlReference" minOccurs="1" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="Datei-Kennung"/>
										<aie:id value="160"/>
										<aie:status value="R"/>
										<aie:format value="an..14"/>
										<aie:pcre value="\A.{1,14}\Z"/>
									</xs:documentation>
								</xs:annotation>
								<xs:simpleType>
									<xs:restriction base="xs:token">
										<xs:minLength value="1"/>
										<xs:maxLength value="14"/>
									</xs:restriction>
								</xs:simpleType>
							</xs:element>
							<xs:element name="MessageReferenceNumber" minOccurs="1" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="Identifikation"/>
										<aie:id value="161"/>
										<aie:status value="R"/>
										<aie:format value="n..6"/>
										<aie:pcre value="\A(?:0|[1-9][0-9]{0,5})\Z"/>
									</xs:documentation>
								</xs:annotation>
								<xs:simpleType>
									<xs:restriction base="xs:integer">
										<xs:minInclusive value="0"/>
										<xs:maxInclusive value="999999"/>
										<xs:totalDigits value="6"/>
										<xs:pattern value="(0|[1-9][0-9]{0,5})"/>
									</xs:restriction>
								</xs:simpleType>
							</xs:element>
							<xs:element name="MessageIdentifier" minOccurs="1" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="Nachrichtennummer"/>
										<aie:id value="163"/>
										<aie:status value="R"/>
										<aie:format value="an..35"/>
										<aie:pcre value="\A.{1,35}\Z"/>
									</xs:documentation>
								</xs:annotation>
								<xs:simpleType>
									<xs:restriction base="xs:token">
										<xs:minLength value="1"/>
										<xs:maxLength value="35"/>
									</xs:restriction>
								</xs:simpleType>
							</xs:element>
							<xs:element name="MessageGroup" minOccurs="1" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="Nachrichtengruppe"/>
										<aie:id value="162"/>
										<aie:status value="R"/>
										<aie:format value="a3"/>
										<aie:pcre value="\A(?:AEZ|LBA|ZSZ)\Z"/>
										<aie:list value="A0110"/>
									</xs:documentation>
								</xs:annotation>
								<xs:simpleType>
									<xs:restriction base="xs:token">
										<xs:length value="3"/>
										<xs:enumeration value="AEZ"/>
										<xs:enumeration value="LBA"/>
										<xs:enumeration value="ZSZ"/>
									</xs:restriction>
								</xs:simpleType>
							</xs:element>
							<xs:element name="Scenario" minOccurs="0" maxOccurs="0">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="Szenario"/>
										<aie:status value="N"/>
									</xs:documentation>
								</xs:annotation>
								<xs:complexType>
									<xs:sequence>
										<xs:element name="ReferenceNumber" minOccurs="0" maxOccurs="0">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Szenario-Nummer"/>
													<aie:id value="165"/>
													<aie:status value="N"/>
													<aie:format value="n5"/>
													<aie:pcre value="\A[1-9][0-9]{4}\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:length value="5"/>
													<xs:pattern value="[1-9][0-9]{4}"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="Note" minOccurs="0" maxOccurs="0">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Szenario-Hinweis"/>
													<aie:id value="164"/>
													<aie:status value="N"/>
													<aie:format value="a2"/>
													<aie:pcre value="\A[A-Z]{2}\Z"/>
													<aie:list value="A0112"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:length value="2"/>
													<xs:pattern value="[A-Z]{2}"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
									</xs:sequence>
								</xs:complexType>
							</xs:element>
							<xs:element name="TestIndicator" minOccurs="0" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="Test-Indikator"/>
										<aie:id value="166"/>
										<aie:status value="O"/>
										<aie:format value="n1"/>
										<aie:pcre value="\A1\Z"/>
										<aie:list value="A0035"/>
									</xs:documentation>
								</xs:annotation>
								<xs:simpleType>
									<xs:restriction base="xs:token">
										<xs:length value="1"/>
										<xs:enumeration value="1"/>
									</xs:restriction>
								</xs:simpleType>
							</xs:element>
							<xs:element name="MessageType" minOccurs="1" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="Typ"/>
										<aie:id value="167"/>
										<aie:status value="R"/>
										<aie:format value="a6"/>
										<aie:pcre value="\AGSCOPK\Z"/>
										<aie:list value="A0057"/>
									</xs:documentation>
								</xs:annotation>
								<xs:simpleType>
									<xs:restriction base="xs:token">
										<xs:length value="6"/>
										<xs:enumeration value="GSCOPK"/>
									</xs:restriction>
								</xs:simpleType>
							</xs:element>
							<xs:element name="InterchangeSender" minOccurs="1" maxOccurs="1" id="MST">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="NACHRICHTENSENDER"/>
										<aie:id value="241"/>
										<aie:status value="R"/>
									</xs:documentation>
								</xs:annotation>
								<xs:complexType>
									<xs:sequence>
										<xs:element name="Identification" minOccurs="1" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
												</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:sequence>
													<xs:element name="ReferenceNumber" minOccurs="1" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="TIN"/>
																<aie:id value="245"/>
																<aie:status value="R"/>
																<aie:format value="an..17"/>
																<aie:pcre value="\A[A-Z]{2}[\x21-\x7E]{1,15}\Z"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:minLength value="1"/>
																<xs:maxLength value="17"/>
																<xs:pattern value="[A-Z]{2}[&#x21;-&#x7E;]{1,15}"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="SubsidiaryNumber" minOccurs="1" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Niederlassungsnummer"/>
																<aie:id value="244"/>
																<aie:status value="R"/>
																<aie:format value="n4"/>
																<aie:pcre value="\A[0-9]{4}\Z"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:length value="4"/>
																<xs:pattern value="[0-9]{4}"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
												</xs:sequence>
											</xs:complexType>
										</xs:element>
									</xs:sequence>
								</xs:complexType>
							</xs:element>
							<xs:element name="InterchangeRecipient" minOccurs="1" maxOccurs="1" id="MED">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="NACHRICHTENEMPFÄNGER"/>
										<aie:id value="170"/>
										<aie:status value="R"/>
									</xs:documentation>
								</xs:annotation>
								<xs:complexType>
									<xs:sequence>
										<xs:element name="Identification" minOccurs="1" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Dienststellennummer"/>
													<aie:status value="R"/>
												</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:sequence>
													<xs:element name="ReferenceNumber" minOccurs="1" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:id value="173"/>
																<aie:format value="an8"/>
																<aie:pcre value="\ADE00[0-9]{4}\Z"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:length value="8"/>
																<xs:pattern value="DE00[0-9]{4}"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
												</xs:sequence>
											</xs:complexType>
										</xs:element>
									</xs:sequence>
								</xs:complexType>
							</xs:element>
						</xs:sequence>
					</xs:complexType>
				</xs:element>
				<xs:element name="Header" minOccurs="1" maxOccurs="1" id="HEA">
					<xs:annotation>
						<xs:documentation>
							<aie:name value="KOPF"/>
							<aie:id value="3647"/>
							<aie:status value="R"/>
						</xs:documentation>
					</xs:annotation>
					<xs:complexType>
						<xs:sequence>
							<xs:element name="MessageVersion" minOccurs="1" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="Nachrichtenversion"/>
										<aie:id value="89"/>
										<aie:status value="R"/>
										<aie:format value="an..7"/>
										<aie:pcre value="\AK\.[1-9][0-9]?\.[1-9]?[0-9]\Z"/>
									</xs:documentation>
								</xs:annotation>
								<xs:simpleType>
									<xs:restriction base="xs:token">
										<xs:minLength value="1"/>
										<xs:maxLength value="7"/>
										<xs:pattern value="K\.[1-9][0-9]?\.[1-9]?[0-9]"/>
									</xs:restriction>
								</xs:simpleType>
							</xs:element>
							<xs:element name="MessageRole" minOccurs="1" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="Nachrichtenfunktion"/>
										<aie:id value="87"/>
										<aie:status value="R"/>
										<aie:format value="an..2"/>
										<aie:pcre value="\A.{1,2}\Z"/>
										<aie:list value="A1290"/>
									</xs:documentation>
								</xs:annotation>
								<xs:simpleType>
									<xs:restriction base="xs:token">
										<xs:minLength value="1"/>
										<xs:maxLength value="2"/>
									</xs:restriction>
								</xs:simpleType>
							</xs:element>
							<xs:element name="MessageCreationDate" minOccurs="1" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="Datum der Nachricht"/>
										<aie:id value="86"/>
										<aie:status value="R"/>
										<aie:format value="Date (n8)"/>
										<aie:pcre value="\A(?:(?:(?:0[48]|[2468][048]|[13579][26])(?:[02468][048]|[13579][26])|(?:[02468][1-35-79]|[13579][013-57-9])(?:0[48]|[2468][048]|[13579][26]))-02-29|[0-9][0-9][0-9][0-9]-(?:(?:0[13578]|1[02])-(?:0[1-9]|[12][0-9]|3[01])|(?:0[469]|11)-(?:0[1-9]|[12][0-9]|30)|02-(?:0[1-9]|1[0-9]|2[0-8])))\Z"/>
									</xs:documentation>
								</xs:annotation>
								<xs:simpleType>
									<xs:restriction base="xs:date">
									</xs:restriction>
								</xs:simpleType>
							</xs:element>
							<xs:element name="Declaration" minOccurs="1" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
									</xs:documentation>
								</xs:annotation>
								<xs:complexType>
									<xs:sequence>
										<xs:element name="Kind" minOccurs="1" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Anmeldeart"/>
													<aie:id value="11"/>
													<aie:status value="R"/>
													<aie:format value="an1"/>
													<aie:pcre value="\A(?:Y|Z)\Z"/>
													<aie:list value="A1025"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:length value="1"/>
													<xs:enumeration value="Y"/>
													<xs:enumeration value="Z"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="Type" minOccurs="1" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Art der Anmeldung"/>
													<aie:id value="14"/>
													<aie:status value="R"/>
													<aie:format value="an..3"/>
													<aie:pcre value="\A(?:AAV|AZ|AZL|VAV|VZA|VZL)\Z"/>
													<aie:list value="A1100"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:minLength value="2"/>
													<xs:maxLength value="3"/>
													<xs:enumeration value="AAV"/>
													<xs:enumeration value="AZ"/>
													<xs:enumeration value="AZL"/>
													<xs:enumeration value="VAV"/>
													<xs:enumeration value="VZA"/>
													<xs:enumeration value="VZL"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
									</xs:sequence>
								</xs:complexType>
							</xs:element>
							<xs:element name="ReferenceNumber" minOccurs="0" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="Registriernummer"/>
										<aie:id value="98"/>
										<aie:status value="D"/>
										<aie:format value="an21"/>
										<aie:pcre value="\AAT[A-Z][0-9]{2}[0-9]{6}(?:0[1-9]|1[0-2])20[0-9]{2}[0-9]{4}\Z"/>
									</xs:documentation>
								</xs:annotation>
								<xs:simpleType>
									<xs:restriction base="xs:token">
										<xs:length value="21"/>
										<xs:pattern value="AT[A-Z][0-9]{2}[0-9]{6}(0[1-9]|1[0-2])20[0-9]{2}[0-9]{4}"/>
									</xs:restriction>
								</xs:simpleType>
							</xs:element>
							<xs:element name="LocalReferenceNumber" minOccurs="0" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="Bezugsnummer"/>
										<aie:id value="46"/>
										<aie:status value="O"/>
										<aie:format value="an..35"/>
										<aie:pcre value="\A.{1,35}\Z"/>
									</xs:documentation>
								</xs:annotation>
								<xs:simpleType>
									<xs:restriction base="xs:token">
										<xs:minLength value="1"/>
										<xs:maxLength value="35"/>
									</xs:restriction>
								</xs:simpleType>
							</xs:element>
							<xs:element name="StartAccountingPeriodDate" minOccurs="0" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="Beginn Abrechnungszeitraum"/>
										<aie:id value="154"/>
										<aie:status value="D"/>
										<aie:format value="Date (n8)"/>
										<aie:pcre value="\A(?:(?:(?:0[48]|[2468][048]|[13579][26])(?:[02468][048]|[13579][26])|(?:[02468][1-35-79]|[13579][013-57-9])(?:0[48]|[2468][048]|[13579][26]))-02-29|[0-9][0-9][0-9][0-9]-(?:(?:0[13578]|1[02])-(?:0[1-9]|[12][0-9]|3[01])|(?:0[469]|11)-(?:0[1-9]|[12][0-9]|30)|02-(?:0[1-9]|1[0-9]|2[0-8])))\Z"/>
									</xs:documentation>
								</xs:annotation>
								<xs:simpleType>
									<xs:restriction base="xs:date">
									</xs:restriction>
								</xs:simpleType>
							</xs:element>
							<xs:element name="EndAccountingPeriodDate" minOccurs="0" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="Ende Abrechnungszeitraum"/>
										<aie:id value="155"/>
										<aie:status value="D"/>
										<aie:format value="Date (n8)"/>
										<aie:pcre value="\A(?:(?:(?:0[48]|[2468][048]|[13579][26])(?:[02468][048]|[13579][26])|(?:[02468][1-35-79]|[13579][013-57-9])(?:0[48]|[2468][048]|[13579][26]))-02-29|[0-9][0-9][0-9][0-9]-(?:(?:0[13578]|1[02])-(?:0[1-9]|[12][0-9]|3[01])|(?:0[469]|11)-(?:0[1-9]|[12][0-9]|30)|02-(?:0[1-9]|1[0-9]|2[0-8])))\Z"/>
									</xs:documentation>
								</xs:annotation>
								<xs:simpleType>
									<xs:restriction base="xs:date">
									</xs:restriction>
								</xs:simpleType>
							</xs:element>
							<xs:element name="DeclarantIsConsigneeFlag" minOccurs="0" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="Anmelder ist Empfänger"/>
										<aie:id value="13"/>
										<aie:status value="D"/>
										<aie:format value="an1"/>
										<aie:pcre value="\A.\Z"/>
										<aie:list value="A1030"/>
									</xs:documentation>
								</xs:annotation>
								<xs:simpleType>
									<xs:restriction base="xs:token">
										<xs:length value="1"/>
									</xs:restriction>
								</xs:simpleType>
							</xs:element>
							<xs:element name="CustomsAuthorisation" minOccurs="0" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="Bewilligungsnummer"/>
										<aie:status value="D"/>
									</xs:documentation>
								</xs:annotation>
								<xs:complexType>
									<xs:sequence>
										<xs:element name="LocalClearanceProcedure" minOccurs="0" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Bewilligungsnummer (vereinfachtes Verfahren)"/>
													<aie:id value="45"/>
													<aie:status value="D"/>
													<aie:format value="an..35"/>
													<aie:pcre value="\A(?:[A-Z]{2}[0-9]{4}[AS][1239][0-9]{1,4}|[A-Z]{2}(?:EIR|SDE).{1,29})\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:minLength value="1"/>
													<xs:maxLength value="35"/>
													<xs:pattern value="[A-Z]{2}[0-9]{4}[AS][1239][0-9]{1,4}"/>
													<xs:pattern value="[A-Z]{2}(EIR|SDE).{1,29}"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="CurrentProcedure" minOccurs="0" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Bewilligungsnummer (Fachverfahren)"/>
													<aie:id value="43"/>
													<aie:status value="D"/>
													<aie:format value="an..35"/>
													<aie:pcre value="\A(?:[A-Z]{2}[0-9]{4}(?:L[ACDE]|FV|AV)[0-9]{1,4}|[A-Z]{2}(?:CW[1P]|EUS|IPO).{1,29})\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:minLength value="1"/>
													<xs:maxLength value="35"/>
													<xs:pattern value="[A-Z]{2}[0-9]{4}(L[ACDE]|FV|AV)[0-9]{1,4}"/>
													<xs:pattern value="[A-Z]{2}(CW[1P]|EUS|IPO).{1,29}"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
									</xs:sequence>
								</xs:complexType>
							</xs:element>
							<xs:element name="InputTaxDeductionFlag" minOccurs="0" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="Vorsteuerabzug"/>
										<aie:id value="134"/>
										<aie:status value="D"/>
										<aie:format value="an1"/>
										<aie:pcre value="\A.\Z"/>
										<aie:list value="A2030"/>
									</xs:documentation>
								</xs:annotation>
								<xs:simpleType>
									<xs:restriction base="xs:token">
										<xs:length value="1"/>
									</xs:restriction>
								</xs:simpleType>
							</xs:element>
							<xs:element name="CurrencyCode" minOccurs="0" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="WKZ"/>
										<aie:id value="149"/>
										<aie:status value="D"/>
										<aie:format value="an3"/>
										<aie:pcre value="\AEUR\Z"/>
										<aie:list value="I0400"/>
									</xs:documentation>
								</xs:annotation>
								<xs:simpleType>
									<xs:restriction base="xs:token">
										<xs:length value="3"/>
										<xs:enumeration value="EUR"/>
									</xs:restriction>
								</xs:simpleType>
							</xs:element>
							<xs:element name="TaxNumber" minOccurs="0" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="USt-IdNr."/>
										<aie:id value="125"/>
										<aie:status value="D"/>
										<aie:format value="an..20"/>
										<aie:pcre value="\A(?:[A-Z]{2}.{1,12}|.{1,20})\Z"/>
										<aie:list value="A1835"/>
									</xs:documentation>
								</xs:annotation>
								<xs:simpleType>
									<xs:restriction base="xs:token">
										<xs:minLength value="1"/>
										<xs:maxLength value="20"/>
										<xs:pattern value="[A-Z]{2}.{1,12}"/>
										<xs:pattern value=".{1,20}"/>
									</xs:restriction>
								</xs:simpleType>
							</xs:element>
							<xs:element name="TaxOffice" minOccurs="0" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="Finanzamt"/>
										<aie:id value="66"/>
										<aie:status value="D"/>
										<aie:format value="an4"/>
										<aie:pcre value="\A.{4}\Z"/>
									</xs:documentation>
								</xs:annotation>
								<xs:simpleType>
									<xs:restriction base="xs:token">
										<xs:length value="4"/>
									</xs:restriction>
								</xs:simpleType>
							</xs:element>
							<xs:element name="RepresentativeRelationshipFlag" minOccurs="0" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="Kennzeichen Vertretungsverhältnis"/>
										<aie:id value="131"/>
										<aie:status value="D"/>
										<aie:format value="an1"/>
										<aie:pcre value="\A.\Z"/>
										<aie:list value="A1770"/>
									</xs:documentation>
								</xs:annotation>
								<xs:simpleType>
									<xs:restriction base="xs:token">
										<xs:length value="1"/>
									</xs:restriction>
								</xs:simpleType>
							</xs:element>
							<xs:element name="MandateReference" minOccurs="0" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="Mandatsreferenznummer"/>
										<aie:id value="85"/>
										<aie:status value="D"/>
										<aie:format value="n10"/>
										<aie:pcre value="\A[0-9]{10}\Z"/>
									</xs:documentation>
								</xs:annotation>
								<xs:simpleType>
									<xs:restriction base="xs:token">
										<xs:length value="10"/>
										<xs:pattern value="[0-9]{10}"/>
									</xs:restriction>
								</xs:simpleType>
							</xs:element>
							<xs:element name="DeclarationPlace" minOccurs="0" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="Ausstellungsort"/>
										<aie:id value="17"/>
										<aie:status value="D"/>
										<aie:format value="an..35"/>
										<aie:pcre value="\A.{1,35}\Z"/>
									</xs:documentation>
								</xs:annotation>
								<xs:simpleType>
									<xs:restriction base="xs:token">
										<xs:minLength value="1"/>
										<xs:maxLength value="35"/>
									</xs:restriction>
								</xs:simpleType>
							</xs:element>
							<xs:element name="AuthorisationNumber" minOccurs="1" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="BIN"/>
										<aie:id value="48"/>
										<aie:status value="R"/>
										<aie:format value="an25"/>
										<aie:pcre value="\A.{25}\Z"/>
									</xs:documentation>
								</xs:annotation>
								<xs:simpleType>
									<xs:restriction base="xs:token">
										<xs:length value="25"/>
									</xs:restriction>
								</xs:simpleType>
							</xs:element>
						</xs:sequence>
					</xs:complexType>
				</xs:element>
				<xs:element name="Declarant" minOccurs="0" maxOccurs="1" id="DT0">
					<xs:annotation>
						<xs:documentation>
							<aie:name value="ANGABEN ZUM ANMELDER"/>
							<aie:id value="489"/>
							<aie:status value="D"/>
						</xs:documentation>
					</xs:annotation>
					<xs:complexType>
						<xs:sequence>
							<xs:element name="Identification" minOccurs="0" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
									</xs:documentation>
								</xs:annotation>
								<xs:complexType>
									<xs:sequence>
										<xs:element name="ReferenceNumber" minOccurs="0" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="TIN"/>
													<aie:id value="493"/>
													<aie:status value="D"/>
													<aie:format value="an..17"/>
													<aie:pcre value="\A[A-Z]{2}[\x21-\x7E]{1,15}\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:minLength value="1"/>
													<xs:maxLength value="17"/>
													<xs:pattern value="[A-Z]{2}[&#x21;-&#x7E;]{1,15}"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="SubsidiaryNumber" minOccurs="0" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Niederlassungsnummer"/>
													<aie:id value="492"/>
													<aie:status value="D"/>
													<aie:format value="n4"/>
													<aie:pcre value="\A[0-9]{4}\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:length value="4"/>
													<xs:pattern value="[0-9]{4}"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
									</xs:sequence>
								</xs:complexType>
							</xs:element>
							<xs:element name="Name" minOccurs="0" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="Name"/>
										<aie:id value="491"/>
										<aie:status value="D"/>
										<aie:format value="an..120"/>
										<aie:pcre value="\A.{1,120}\Z"/>
									</xs:documentation>
								</xs:annotation>
								<xs:simpleType>
									<xs:restriction base="xs:token">
										<xs:minLength value="1"/>
										<xs:maxLength value="120"/>
									</xs:restriction>
								</xs:simpleType>
							</xs:element>
							<xs:element name="Address" minOccurs="0" maxOccurs="1" id="DT1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="ANMELDER (ADRESSDATEN)"/>
										<aie:id value="494"/>
										<aie:status value="D"/>
									</xs:documentation>
								</xs:annotation>
								<xs:complexType>
									<xs:sequence>
										<xs:element name="Line" minOccurs="1" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Straße und Hausnummer"/>
													<aie:id value="500"/>
													<aie:status value="R"/>
													<aie:format value="an..35"/>
													<aie:pcre value="\A.{1,35}\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:minLength value="1"/>
													<xs:maxLength value="35"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="Country" minOccurs="1" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Land"/>
													<aie:id value="495"/>
													<aie:status value="R"/>
													<aie:format value="an2"/>
													<aie:pcre value="\A[A-Z]{2}\Z"/>
													<aie:list value="I0300"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:length value="2"/>
													<xs:pattern value="[A-Z]{2}"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="Postcode" minOccurs="0" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Postleitzahl"/>
													<aie:id value="499"/>
													<aie:status value="D"/>
													<aie:format value="an..9"/>
													<aie:pcre value="\A.{1,9}\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:minLength value="1"/>
													<xs:maxLength value="9"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="City" minOccurs="1" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Ort"/>
													<aie:id value="496"/>
													<aie:status value="R"/>
													<aie:format value="an..35"/>
													<aie:pcre value="\A.{1,35}\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:minLength value="1"/>
													<xs:maxLength value="35"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="District" minOccurs="0" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Ortsteil"/>
													<aie:id value="497"/>
													<aie:status value="O"/>
													<aie:format value="an..35"/>
													<aie:pcre value="\A.{1,35}\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:minLength value="1"/>
													<xs:maxLength value="35"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
									</xs:sequence>
								</xs:complexType>
							</xs:element>
						</xs:sequence>
					</xs:complexType>
				</xs:element>
				<xs:element name="Representative" minOccurs="0" maxOccurs="1" id="CB0">
					<xs:annotation>
						<xs:documentation>
							<aie:name value="ANGABEN ZUM VERTRETER"/>
							<aie:id value="1791"/>
							<aie:status value="D"/>
						</xs:documentation>
					</xs:annotation>
					<xs:complexType>
						<xs:sequence>
							<xs:element name="Identification" minOccurs="1" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
									</xs:documentation>
								</xs:annotation>
								<xs:complexType>
									<xs:sequence>
										<xs:element name="ReferenceNumber" minOccurs="1" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="TIN"/>
													<aie:id value="1795"/>
													<aie:status value="R"/>
													<aie:format value="an..17"/>
													<aie:pcre value="\A[A-Z]{2}[\x21-\x7E]{1,15}\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:minLength value="1"/>
													<xs:maxLength value="17"/>
													<xs:pattern value="[A-Z]{2}[&#x21;-&#x7E;]{1,15}"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="SubsidiaryNumber" minOccurs="0" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Niederlassungsnummer"/>
													<aie:id value="1794"/>
													<aie:status value="O"/>
													<aie:format value="n4"/>
													<aie:pcre value="\A[0-9]{4}\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:length value="4"/>
													<xs:pattern value="[0-9]{4}"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
									</xs:sequence>
								</xs:complexType>
							</xs:element>
						</xs:sequence>
					</xs:complexType>
				</xs:element>
				<xs:element name="Principal" minOccurs="0" maxOccurs="1" id="UH0">
					<xs:annotation>
						<xs:documentation>
							<aie:name value="ANGABEN ZUM VERTRETENEN (FÜR RECHNUNG)"/>
							<aie:id value="1768"/>
							<aie:status value="D"/>
						</xs:documentation>
					</xs:annotation>
					<xs:complexType>
						<xs:sequence>
							<xs:element name="Identification" minOccurs="0" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
									</xs:documentation>
								</xs:annotation>
								<xs:complexType>
									<xs:sequence>
										<xs:element name="ReferenceNumber" minOccurs="0" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="TIN"/>
													<aie:id value="1772"/>
													<aie:status value="D"/>
													<aie:format value="an..17"/>
													<aie:pcre value="\A[A-Z]{2}[\x21-\x7E]{1,15}\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:minLength value="1"/>
													<xs:maxLength value="17"/>
													<xs:pattern value="[A-Z]{2}[&#x21;-&#x7E;]{1,15}"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="SubsidiaryNumber" minOccurs="0" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Niederlassungsnummer"/>
													<aie:id value="1771"/>
													<aie:status value="D"/>
													<aie:format value="n4"/>
													<aie:pcre value="\A[0-9]{4}\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:length value="4"/>
													<xs:pattern value="[0-9]{4}"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
									</xs:sequence>
								</xs:complexType>
							</xs:element>
							<xs:element name="Name" minOccurs="0" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="Name"/>
										<aie:id value="1770"/>
										<aie:status value="D"/>
										<aie:format value="an..120"/>
										<aie:pcre value="\A.{1,120}\Z"/>
									</xs:documentation>
								</xs:annotation>
								<xs:simpleType>
									<xs:restriction base="xs:token">
										<xs:minLength value="1"/>
										<xs:maxLength value="120"/>
									</xs:restriction>
								</xs:simpleType>
							</xs:element>
							<xs:element name="Address" minOccurs="0" maxOccurs="1" id="UH1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="FÜR RECHNUNG (ADRESSDATEN)"/>
										<aie:id value="1773"/>
										<aie:status value="D"/>
									</xs:documentation>
								</xs:annotation>
								<xs:complexType>
									<xs:sequence>
										<xs:element name="Line" minOccurs="1" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Straße und Hausnummer"/>
													<aie:id value="1779"/>
													<aie:status value="R"/>
													<aie:format value="an..35"/>
													<aie:pcre value="\A.{1,35}\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:minLength value="1"/>
													<xs:maxLength value="35"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="Country" minOccurs="1" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Land"/>
													<aie:id value="1774"/>
													<aie:status value="R"/>
													<aie:format value="an2"/>
													<aie:pcre value="\A[A-Z]{2}\Z"/>
													<aie:list value="I0300"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:length value="2"/>
													<xs:pattern value="[A-Z]{2}"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="Postcode" minOccurs="0" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Postleitzahl"/>
													<aie:id value="1778"/>
													<aie:status value="D"/>
													<aie:format value="an..9"/>
													<aie:pcre value="\A.{1,9}\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:minLength value="1"/>
													<xs:maxLength value="9"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="City" minOccurs="1" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Ort"/>
													<aie:id value="1775"/>
													<aie:status value="R"/>
													<aie:format value="an..35"/>
													<aie:pcre value="\A.{1,35}\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:minLength value="1"/>
													<xs:maxLength value="35"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="District" minOccurs="0" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Ortsteil"/>
													<aie:id value="1776"/>
													<aie:status value="O"/>
													<aie:format value="an..35"/>
													<aie:pcre value="\A.{1,35}\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:minLength value="1"/>
													<xs:maxLength value="35"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
									</xs:sequence>
								</xs:complexType>
							</xs:element>
						</xs:sequence>
					</xs:complexType>
				</xs:element>
				<xs:element name="ContactPerson" minOccurs="0" maxOccurs="1" id="PK0">
					<xs:annotation>
						<xs:documentation>
							<aie:name value="ANGABEN ZUM ANSPRECHPARTNER FIRMA"/>
							<aie:id value="517"/>
							<aie:status value="D"/>
						</xs:documentation>
					</xs:annotation>
					<xs:complexType>
						<xs:sequence>
							<xs:element name="Name" minOccurs="0" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="Name"/>
										<aie:id value="520"/>
										<aie:status value="D"/>
										<aie:format value="an..35"/>
										<aie:pcre value="\A.{1,35}\Z"/>
									</xs:documentation>
								</xs:annotation>
								<xs:simpleType>
									<xs:restriction base="xs:token">
										<xs:minLength value="1"/>
										<xs:maxLength value="35"/>
									</xs:restriction>
								</xs:simpleType>
							</xs:element>
							<xs:element name="Position" minOccurs="0" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="Stellung in der Firma"/>
										<aie:id value="521"/>
										<aie:status value="D"/>
										<aie:format value="an..35"/>
										<aie:pcre value="\A.{1,35}\Z"/>
									</xs:documentation>
								</xs:annotation>
								<xs:simpleType>
									<xs:restriction base="xs:token">
										<xs:minLength value="1"/>
										<xs:maxLength value="35"/>
									</xs:restriction>
								</xs:simpleType>
							</xs:element>
							<xs:element name="PhoneNumber" minOccurs="0" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="Telefonnummer"/>
										<aie:id value="522"/>
										<aie:status value="D"/>
										<aie:format value="an..35"/>
										<aie:pcre value="\A.{1,35}\Z"/>
									</xs:documentation>
								</xs:annotation>
								<xs:simpleType>
									<xs:restriction base="xs:token">
										<xs:minLength value="1"/>
										<xs:maxLength value="35"/>
									</xs:restriction>
								</xs:simpleType>
							</xs:element>
							<xs:element name="MailAddress" minOccurs="0" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="E-Mail-Adresse"/>
										<aie:id value="518"/>
										<aie:status value="O"/>
										<aie:format value="an..256"/>
										<aie:pcre value="\A(?=.{1,256}\Z)[A-Za-z0-9!#$%&amp;&apos;*+/=?^_`{|}~-]+(?:\.[A-Za-z0-9!#$%&amp;&apos;*+/=?^_`{|}~-]+)*@(?:[A-Za-z0-9](?:[A-Za-z0-9-]*[A-Za-z0-9])?\.)+[A-Za-z0-9](?:[A-Za-z0-9-]*[A-Za-z0-9])?\Z"/>
									</xs:documentation>
								</xs:annotation>
								<xs:simpleType>
									<xs:restriction base="xs:token">
										<xs:minLength value="1"/>
										<xs:maxLength value="256"/>
										<xs:pattern value="[A-Za-z0-9!#$%&amp;&apos;*+/=?\^_`{|}~\-]+(\.[A-Za-z0-9!#$%&amp;&apos;*+/=?\^_`{|}~\-]+)*@([A-Za-z0-9]([A-Za-z0-9\-]*[A-Za-z0-9])?\.)+[A-Za-z0-9]([A-Za-z0-9\-]*[A-Za-z0-9])?"/>
									</xs:restriction>
								</xs:simpleType>
							</xs:element>
						</xs:sequence>
					</xs:complexType>
				</xs:element>
				<xs:element name="Body" minOccurs="1" maxOccurs="999" id="BDY">
					<xs:annotation>
						<xs:documentation>
							<aie:name value="ANGABEN ZUR VZA/AZ"/>
							<aie:id value="2040"/>
							<aie:status value="R"/>
						</xs:documentation>
					</xs:annotation>
					<xs:complexType>
						<xs:sequence>
							<xs:element name="ReferenceNumber" minOccurs="1" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="Registriernummer im anderen Mitgliedstaat"/>
										<aie:id value="2042"/>
										<aie:status value="R"/>
										<aie:format value="an..35"/>
										<aie:pcre value="\A.{1,35}\Z"/>
									</xs:documentation>
								</xs:annotation>
								<xs:simpleType>
									<xs:restriction base="xs:token">
										<xs:minLength value="1"/>
										<xs:maxLength value="35"/>
									</xs:restriction>
								</xs:simpleType>
							</xs:element>
							<xs:element name="CustomsValueFlag" minOccurs="1" maxOccurs="1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="Kennzeichen D.V.1"/>
										<aie:id value="2189"/>
										<aie:status value="R"/>
										<aie:format value="an1"/>
										<aie:pcre value="\A.\Z"/>
										<aie:list value="A1460"/>
									</xs:documentation>
								</xs:annotation>
								<xs:simpleType>
									<xs:restriction base="xs:token">
										<xs:length value="1"/>
									</xs:restriction>
								</xs:simpleType>
							</xs:element>
							<xs:element name="Consignor" minOccurs="0" maxOccurs="1" id="CO1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="ANGABEN ZUM VERSENDER/AUSFÜHRER"/>
										<aie:id value="2162"/>
										<aie:status value="D"/>
									</xs:documentation>
								</xs:annotation>
								<xs:complexType>
									<xs:sequence>
										<xs:element name="Identification" minOccurs="0" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="TIN"/>
													<aie:status value="D"/>
												</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:sequence>
													<xs:element name="ReferenceNumber" minOccurs="1" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:id value="2166"/>
																<aie:format value="an..17"/>
																<aie:pcre value="\A[A-Z]{2}[\x21-\x7E]{1,15}\Z"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:minLength value="1"/>
																<xs:maxLength value="17"/>
																<xs:pattern value="[A-Z]{2}[&#x21;-&#x7E;]{1,15}"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
												</xs:sequence>
											</xs:complexType>
										</xs:element>
										<xs:element name="Name" minOccurs="0" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Name"/>
													<aie:id value="2164"/>
													<aie:status value="D"/>
													<aie:format value="an..120"/>
													<aie:pcre value="\A.{1,120}\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:minLength value="1"/>
													<xs:maxLength value="120"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="Address" minOccurs="0" maxOccurs="1" id="COA">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="VERSENDER/AUSFÜHRER (ADRESSDATEN)"/>
													<aie:id value="2167"/>
													<aie:status value="D"/>
												</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:sequence>
													<xs:element name="Line" minOccurs="1" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Straße und Hausnummer"/>
																<aie:id value="2173"/>
																<aie:status value="R"/>
																<aie:format value="an..35"/>
																<aie:pcre value="\A.{1,35}\Z"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:minLength value="1"/>
																<xs:maxLength value="35"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="Country" minOccurs="1" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Land"/>
																<aie:id value="2168"/>
																<aie:status value="R"/>
																<aie:format value="an2"/>
																<aie:pcre value="\A[A-Z]{2}\Z"/>
																<aie:list value="I0300"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:length value="2"/>
																<xs:pattern value="[A-Z]{2}"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="Postcode" minOccurs="0" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Postleitzahl"/>
																<aie:id value="2172"/>
																<aie:status value="D"/>
																<aie:format value="an..9"/>
																<aie:pcre value="\A.{1,9}\Z"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:minLength value="1"/>
																<xs:maxLength value="9"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="City" minOccurs="1" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Ort"/>
																<aie:id value="2169"/>
																<aie:status value="R"/>
																<aie:format value="an..35"/>
																<aie:pcre value="\A.{1,35}\Z"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:minLength value="1"/>
																<xs:maxLength value="35"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="District" minOccurs="0" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Ortsteil"/>
																<aie:id value="2170"/>
																<aie:status value="O"/>
																<aie:format value="an..35"/>
																<aie:pcre value="\A.{1,35}\Z"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:minLength value="1"/>
																<xs:maxLength value="35"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
												</xs:sequence>
											</xs:complexType>
										</xs:element>
									</xs:sequence>
								</xs:complexType>
							</xs:element>
							<xs:element name="Consignee" minOccurs="0" maxOccurs="1" id="CE1">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="ANGABEN ZUM EMPFÄNGER"/>
										<aie:id value="2091"/>
										<aie:status value="D"/>
									</xs:documentation>
								</xs:annotation>
								<xs:complexType>
									<xs:sequence>
										<xs:element name="Identification" minOccurs="0" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
												</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:sequence>
													<xs:element name="ReferenceNumber" minOccurs="0" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="TIN"/>
																<aie:id value="2095"/>
																<aie:status value="D"/>
																<aie:format value="an..17"/>
																<aie:pcre value="\A[A-Z]{2}[\x21-\x7E]{1,15}\Z"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:minLength value="1"/>
																<xs:maxLength value="17"/>
																<xs:pattern value="[A-Z]{2}[&#x21;-&#x7E;]{1,15}"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="SubsidiaryNumber" minOccurs="0" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Niederlassungsnummer"/>
																<aie:id value="2094"/>
																<aie:status value="D"/>
																<aie:format value="n4"/>
																<aie:pcre value="\A[0-9]{4}\Z"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:length value="4"/>
																<xs:pattern value="[0-9]{4}"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
												</xs:sequence>
											</xs:complexType>
										</xs:element>
										<xs:element name="Name" minOccurs="0" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Name"/>
													<aie:id value="2093"/>
													<aie:status value="D"/>
													<aie:format value="an..120"/>
													<aie:pcre value="\A.{1,120}\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:minLength value="1"/>
													<xs:maxLength value="120"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="Address" minOccurs="0" maxOccurs="1" id="CEA">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="EMPFÄNGER (ADRESSDATEN)"/>
													<aie:id value="2096"/>
													<aie:status value="D"/>
												</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:sequence>
													<xs:element name="Line" minOccurs="1" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Straße und Hausnummer"/>
																<aie:id value="2102"/>
																<aie:status value="R"/>
																<aie:format value="an..35"/>
																<aie:pcre value="\A.{1,35}\Z"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:minLength value="1"/>
																<xs:maxLength value="35"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="Country" minOccurs="1" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Land"/>
																<aie:id value="2097"/>
																<aie:status value="R"/>
																<aie:format value="an2"/>
																<aie:pcre value="\A[A-Z]{2}\Z"/>
																<aie:list value="I0300"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:length value="2"/>
																<xs:pattern value="[A-Z]{2}"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="Postcode" minOccurs="0" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Postleitzahl"/>
																<aie:id value="2101"/>
																<aie:status value="D"/>
																<aie:format value="an..9"/>
																<aie:pcre value="\A.{1,9}\Z"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:minLength value="1"/>
																<xs:maxLength value="9"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="City" minOccurs="1" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Ort"/>
																<aie:id value="2098"/>
																<aie:status value="R"/>
																<aie:format value="an..35"/>
																<aie:pcre value="\A.{1,35}\Z"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:minLength value="1"/>
																<xs:maxLength value="35"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="District" minOccurs="0" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Ortsteil"/>
																<aie:id value="2099"/>
																<aie:status value="O"/>
																<aie:format value="an..35"/>
																<aie:pcre value="\A.{1,35}\Z"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:minLength value="1"/>
																<xs:maxLength value="35"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
												</xs:sequence>
											</xs:complexType>
										</xs:element>
									</xs:sequence>
								</xs:complexType>
							</xs:element>
							<xs:element name="Acquirer" minOccurs="0" maxOccurs="1" id="UC0">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="ANGABEN ZUM ERWERBER IM ANDEREN MITGLIEDSTAAT"/>
										<aie:id value="2114"/>
										<aie:status value="D"/>
									</xs:documentation>
								</xs:annotation>
								<xs:complexType>
									<xs:sequence>
										<xs:element name="Identification" minOccurs="0" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
												</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:sequence>
													<xs:element name="ReferenceNumber" minOccurs="0" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="TIN"/>
																<aie:id value="2118"/>
																<aie:status value="D"/>
																<aie:format value="an..17"/>
																<aie:pcre value="\A[A-Z]{2}[\x21-\x7E]{1,15}\Z"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:minLength value="1"/>
																<xs:maxLength value="17"/>
																<xs:pattern value="[A-Z]{2}[&#x21;-&#x7E;]{1,15}"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="SubsidiaryNumber" minOccurs="0" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Niederlassungsnummer"/>
																<aie:id value="2117"/>
																<aie:status value="D"/>
																<aie:format value="n4"/>
																<aie:pcre value="\A[0-9]{4}\Z"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:length value="4"/>
																<xs:pattern value="[0-9]{4}"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
												</xs:sequence>
											</xs:complexType>
										</xs:element>
										<xs:element name="Name" minOccurs="0" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Name"/>
													<aie:id value="2116"/>
													<aie:status value="D"/>
													<aie:format value="an..120"/>
													<aie:pcre value="\A.{1,120}\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:minLength value="1"/>
													<xs:maxLength value="120"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="TaxNumber" minOccurs="0" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="USt-IdNr."/>
													<aie:id value="2137"/>
													<aie:status value="D"/>
													<aie:format value="an..20"/>
													<aie:pcre value="\A[A-Z]{2}.{1,12}\Z"/>
													<aie:list value="A1835"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:minLength value="1"/>
													<xs:maxLength value="20"/>
													<xs:pattern value="[A-Z]{2}.{1,12}"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="Address" minOccurs="0" maxOccurs="1" id="UC1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="ERWERBER (ADRESSDATEN)"/>
													<aie:id value="2119"/>
													<aie:status value="D"/>
												</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:sequence>
													<xs:element name="Line" minOccurs="1" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Straße und Hausnummer"/>
																<aie:id value="2125"/>
																<aie:status value="R"/>
																<aie:format value="an..35"/>
																<aie:pcre value="\A.{1,35}\Z"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:minLength value="1"/>
																<xs:maxLength value="35"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="Country" minOccurs="1" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Land"/>
																<aie:id value="2120"/>
																<aie:status value="R"/>
																<aie:format value="an2"/>
																<aie:pcre value="\A[A-Z]{2}\Z"/>
																<aie:list value="I0300"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:length value="2"/>
																<xs:pattern value="[A-Z]{2}"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="Postcode" minOccurs="0" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Postleitzahl"/>
																<aie:id value="2124"/>
																<aie:status value="D"/>
																<aie:format value="an..9"/>
																<aie:pcre value="\A.{1,9}\Z"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:minLength value="1"/>
																<xs:maxLength value="9"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="City" minOccurs="1" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Ort"/>
																<aie:id value="2121"/>
																<aie:status value="R"/>
																<aie:format value="an..35"/>
																<aie:pcre value="\A.{1,35}\Z"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:minLength value="1"/>
																<xs:maxLength value="35"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="District" minOccurs="0" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Ortsteil"/>
																<aie:id value="2122"/>
																<aie:status value="O"/>
																<aie:format value="an..35"/>
																<aie:pcre value="\A.{1,35}\Z"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:minLength value="1"/>
																<xs:maxLength value="35"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
												</xs:sequence>
											</xs:complexType>
										</xs:element>
									</xs:sequence>
								</xs:complexType>
							</xs:element>
							<xs:element name="Containers" minOccurs="1" maxOccurs="1" id="KC0">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="ANGABEN ZU CONTAINERN"/>
										<aie:id value="2086"/>
										<aie:status value="R"/>
									</xs:documentation>
								</xs:annotation>
								<xs:complexType>
									<xs:sequence>
										<xs:element name="ContainerFlag" minOccurs="1" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Kennzeichen Container"/>
													<aie:id value="2088"/>
													<aie:status value="R"/>
													<aie:format value="an1"/>
													<aie:pcre value="\A.\Z"/>
													<aie:list value="A1450"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:length value="1"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
									</xs:sequence>
								</xs:complexType>
							</xs:element>
							<xs:element name="DeliveryTerms" minOccurs="0" maxOccurs="1" id="RAL">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="ANGABEN ZUR LIEFERBEDINGUNG"/>
										<aie:id value="2138"/>
										<aie:status value="D"/>
									</xs:documentation>
								</xs:annotation>
								<xs:complexType>
									<xs:sequence>
										<xs:element name="Code" minOccurs="0" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Lieferbedingung"/>
													<aie:id value="2139"/>
													<aie:status value="D"/>
													<aie:format value="an3"/>
													<aie:pcre value="\A.{3}\Z"/>
													<aie:list value="A1840"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:length value="3"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="Description" minOccurs="0" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Lieferbedingung-Incoterm"/>
													<aie:id value="2140"/>
													<aie:status value="D"/>
													<aie:format value="an..100"/>
													<aie:pcre value="\A.{1,100}\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:minLength value="1"/>
													<xs:maxLength value="100"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="Place" minOccurs="0" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Lieferbedingung-Ort"/>
													<aie:id value="2141"/>
													<aie:status value="D"/>
													<aie:format value="an..35"/>
													<aie:pcre value="\A.{1,35}\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:minLength value="1"/>
													<xs:maxLength value="35"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="Key" minOccurs="0" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Lieferbedingung-Schlüssel"/>
													<aie:id value="2142"/>
													<aie:status value="D"/>
													<aie:format value="an1"/>
													<aie:pcre value="\A.\Z"/>
													<aie:list value="A1850"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:length value="1"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
									</xs:sequence>
								</xs:complexType>
							</xs:element>
							<xs:element name="PaymentTransaction" minOccurs="0" maxOccurs="1" id="MOP">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="ANGABEN ZUM ZAHLUNGSVERKEHR"/>
										<aie:id value="2185"/>
										<aie:status value="D"/>
									</xs:documentation>
								</xs:annotation>
								<xs:complexType>
									<xs:sequence>
										<xs:element name="Amount" minOccurs="0" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Rechnungspreis"/>
													<aie:id value="2186"/>
													<aie:status value="O"/>
													<aie:format value="n..13 (13,2)"/>
													<aie:pcre value="\A(?:0|[1-9][0-9]{0,10})(?:\.[0-9]{1,2})?\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:decimal">
													<xs:minInclusive value="0.00"/>
													<xs:maxInclusive value="99999999999.99"/>
													<xs:totalDigits value="13"/>
													<xs:fractionDigits value="2"/>
													<xs:pattern value="(0|[1-9][0-9]{0,10})(\.[0-9]{1,2})?"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="CurrencyCode" minOccurs="0" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Währungsschlüssel"/>
													<aie:id value="2187"/>
													<aie:status value="D"/>
													<aie:format value="an3"/>
													<aie:pcre value="\A.{3}\Z"/>
													<aie:list value="I0400"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:length value="3"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
									</xs:sequence>
								</xs:complexType>
							</xs:element>
							<xs:element name="ForeignTradeStatistics" minOccurs="0" maxOccurs="1" id="RAS">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="DATEN FÜR DIE AUSSENHANDELSSTATISTIK VZA/AZ (KOPF)"/>
										<aie:id value="2043"/>
										<aie:status value="D"/>
									</xs:documentation>
								</xs:annotation>
								<xs:complexType>
									<xs:sequence>
										<xs:element name="InlandTransportMode" minOccurs="0" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Verkehrszweig im Inland"/>
													<aie:id value="2050"/>
													<aie:status value="O"/>
													<aie:format value="an1"/>
													<aie:pcre value="\A.\Z"/>
													<aie:list value="A1990"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:length value="1"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="EntryCustomsOffice" minOccurs="0" maxOccurs="1" id="RSE">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="ANGABEN ZUR EINGANGSZOLLSTELLE"/>
													<aie:id value="2056"/>
													<aie:status value="O"/>
												</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:sequence>
													<xs:element name="ReferenceNumber" minOccurs="1" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Eingangszollstelle"/>
																<aie:id value="2059"/>
																<aie:status value="R"/>
																<aie:format value="an8"/>
																<aie:pcre value="\ADE00[0-9]{4}\Z"/>
																<aie:list value="I0500"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:length value="8"/>
																<xs:pattern value="DE00[0-9]{4}"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
												</xs:sequence>
											</xs:complexType>
										</xs:element>
									</xs:sequence>
								</xs:complexType>
							</xs:element>
							<xs:element name="BorderTransportMeans" minOccurs="0" maxOccurs="1" id="MBG">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="BEFÖRDERUNGSMITTEL AN DER GRENZE"/>
										<aie:id value="2080"/>
										<aie:status value="D"/>
									</xs:documentation>
								</xs:annotation>
								<xs:complexType>
									<xs:sequence>
										<xs:element name="Mode" minOccurs="0" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Verkehrszweig an der Grenze"/>
													<aie:id value="2085"/>
													<aie:status value="D"/>
													<aie:format value="an1"/>
													<aie:pcre value="\A.\Z"/>
													<aie:list value="A1980"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:length value="1"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="Type" minOccurs="0" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Art des Beförderungsmittels an der Grenze"/>
													<aie:id value="2081"/>
													<aie:status value="D"/>
													<aie:format value="an2"/>
													<aie:pcre value="\A.{2}\Z"/>
													<aie:list value="A1140"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:length value="2"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="Information" minOccurs="0" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Beschreibung des Beförderungsmittels"/>
													<aie:id value="2083"/>
													<aie:status value="D"/>
													<aie:format value="an..17"/>
													<aie:pcre value="\A.{1,17}\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:minLength value="1"/>
													<xs:maxLength value="17"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="Identity" minOccurs="0" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Kennzeichen/Name des Beförderungsmittels bei Ankunft"/>
													<aie:id value="2082"/>
													<aie:status value="D"/>
													<aie:format value="an..30"/>
													<aie:pcre value="\A.{1,30}\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:minLength value="1"/>
													<xs:maxLength value="30"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="Nationality" minOccurs="0" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Staatszugehörigkeit des Beförderungsmittels an der Grenze"/>
													<aie:id value="2084"/>
													<aie:status value="D"/>
													<aie:format value="an2"/>
													<aie:pcre value="\A.{2}\Z"/>
													<aie:list value="I0300"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:length value="2"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
									</xs:sequence>
								</xs:complexType>
							</xs:element>
							<xs:element name="CustomsValue" minOccurs="0" maxOccurs="1" id="RZW">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="ANMELDUNG DER ANGABEN ÜBER DEN ZOLLWERT (D.V.1) VZA/AZ (KOPF)"/>
										<aie:id value="2188"/>
										<aie:status value="D"/>
									</xs:documentation>
								</xs:annotation>
								<xs:complexType>
									<xs:sequence>
										<xs:element name="FormerDecisions" minOccurs="0" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Frühere Entscheidungen"/>
													<aie:id value="2193"/>
													<aie:status value="D"/>
													<aie:format value="an..100"/>
													<aie:pcre value="\A.{1,100}\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:minLength value="1"/>
													<xs:maxLength value="100"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="Vendor" minOccurs="1" maxOccurs="1" id="SE0">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="ANGABEN ZUM VERKÄUFER"/>
													<aie:id value="2234"/>
													<aie:status value="R"/>
												</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:sequence>
													<xs:element name="Identification" minOccurs="0" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="TIN"/>
																<aie:status value="D"/>
															</xs:documentation>
														</xs:annotation>
														<xs:complexType>
															<xs:sequence>
																<xs:element name="ReferenceNumber" minOccurs="1" maxOccurs="1">
																	<xs:annotation>
																		<xs:documentation>
																			<aie:id value="2238"/>
																			<aie:format value="an..17"/>
																			<aie:pcre value="\A[A-Z]{2}[\x21-\x7E]{1,15}\Z"/>
																		</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:token">
																			<xs:minLength value="1"/>
																			<xs:maxLength value="17"/>
																			<xs:pattern value="[A-Z]{2}[&#x21;-&#x7E;]{1,15}"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
															</xs:sequence>
														</xs:complexType>
													</xs:element>
													<xs:element name="Name" minOccurs="0" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Name"/>
																<aie:id value="2236"/>
																<aie:status value="D"/>
																<aie:format value="an..120"/>
																<aie:pcre value="\A.{1,120}\Z"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:minLength value="1"/>
																<xs:maxLength value="120"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="Address" minOccurs="0" maxOccurs="1" id="SE1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="VERKÄUFER (ADRESSDATEN)"/>
																<aie:id value="2239"/>
																<aie:status value="D"/>
															</xs:documentation>
														</xs:annotation>
														<xs:complexType>
															<xs:sequence>
																<xs:element name="Line" minOccurs="1" maxOccurs="1">
																	<xs:annotation>
																		<xs:documentation>
																			<aie:name value="Straße und Hausnummer"/>
																			<aie:id value="2245"/>
																			<aie:status value="R"/>
																			<aie:format value="an..35"/>
																			<aie:pcre value="\A.{1,35}\Z"/>
																		</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:token">
																			<xs:minLength value="1"/>
																			<xs:maxLength value="35"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
																<xs:element name="Country" minOccurs="1" maxOccurs="1">
																	<xs:annotation>
																		<xs:documentation>
																			<aie:name value="Land"/>
																			<aie:id value="2240"/>
																			<aie:status value="R"/>
																			<aie:format value="an2"/>
																			<aie:pcre value="\A[A-Z]{2}\Z"/>
																			<aie:list value="I0300"/>
																		</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:token">
																			<xs:length value="2"/>
																			<xs:pattern value="[A-Z]{2}"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
																<xs:element name="Postcode" minOccurs="0" maxOccurs="1">
																	<xs:annotation>
																		<xs:documentation>
																			<aie:name value="Postleitzahl"/>
																			<aie:id value="2244"/>
																			<aie:status value="D"/>
																			<aie:format value="an..9"/>
																			<aie:pcre value="\A.{1,9}\Z"/>
																		</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:token">
																			<xs:minLength value="1"/>
																			<xs:maxLength value="9"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
																<xs:element name="City" minOccurs="1" maxOccurs="1">
																	<xs:annotation>
																		<xs:documentation>
																			<aie:name value="Ort"/>
																			<aie:id value="2241"/>
																			<aie:status value="R"/>
																			<aie:format value="an..35"/>
																			<aie:pcre value="\A.{1,35}\Z"/>
																		</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:token">
																			<xs:minLength value="1"/>
																			<xs:maxLength value="35"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
																<xs:element name="District" minOccurs="0" maxOccurs="1">
																	<xs:annotation>
																		<xs:documentation>
																			<aie:name value="Ortsteil"/>
																			<aie:id value="2242"/>
																			<aie:status value="O"/>
																			<aie:format value="an..35"/>
																			<aie:pcre value="\A.{1,35}\Z"/>
																		</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:token">
																			<xs:minLength value="1"/>
																			<xs:maxLength value="35"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
															</xs:sequence>
														</xs:complexType>
													</xs:element>
												</xs:sequence>
											</xs:complexType>
										</xs:element>
										<xs:element name="Vendee" minOccurs="1" maxOccurs="1" id="BY0">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="ANGABEN ZUM KÄUFER"/>
													<aie:id value="2205"/>
													<aie:status value="R"/>
												</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:sequence>
													<xs:element name="Identification" minOccurs="0" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="TIN"/>
																<aie:status value="D"/>
															</xs:documentation>
														</xs:annotation>
														<xs:complexType>
															<xs:sequence>
																<xs:element name="ReferenceNumber" minOccurs="1" maxOccurs="1">
																	<xs:annotation>
																		<xs:documentation>
																			<aie:id value="2209"/>
																			<aie:format value="an..17"/>
																			<aie:pcre value="\A[A-Z]{2}[\x21-\x7E]{1,15}\Z"/>
																		</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:token">
																			<xs:minLength value="1"/>
																			<xs:maxLength value="17"/>
																			<xs:pattern value="[A-Z]{2}[&#x21;-&#x7E;]{1,15}"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
															</xs:sequence>
														</xs:complexType>
													</xs:element>
													<xs:element name="Name" minOccurs="0" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Name"/>
																<aie:id value="2207"/>
																<aie:status value="D"/>
																<aie:format value="an..120"/>
																<aie:pcre value="\A.{1,120}\Z"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:minLength value="1"/>
																<xs:maxLength value="120"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="Address" minOccurs="0" maxOccurs="1" id="BY1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="KÄUFER (ADRESSDATEN)"/>
																<aie:id value="2210"/>
																<aie:status value="D"/>
															</xs:documentation>
														</xs:annotation>
														<xs:complexType>
															<xs:sequence>
																<xs:element name="Line" minOccurs="1" maxOccurs="1">
																	<xs:annotation>
																		<xs:documentation>
																			<aie:name value="Straße und Hausnummer"/>
																			<aie:id value="2216"/>
																			<aie:status value="R"/>
																			<aie:format value="an..35"/>
																			<aie:pcre value="\A.{1,35}\Z"/>
																		</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:token">
																			<xs:minLength value="1"/>
																			<xs:maxLength value="35"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
																<xs:element name="Country" minOccurs="1" maxOccurs="1">
																	<xs:annotation>
																		<xs:documentation>
																			<aie:name value="Land"/>
																			<aie:id value="2211"/>
																			<aie:status value="R"/>
																			<aie:format value="an2"/>
																			<aie:pcre value="\A[A-Z]{2}\Z"/>
																			<aie:list value="I0300"/>
																		</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:token">
																			<xs:length value="2"/>
																			<xs:pattern value="[A-Z]{2}"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
																<xs:element name="Postcode" minOccurs="0" maxOccurs="1">
																	<xs:annotation>
																		<xs:documentation>
																			<aie:name value="Postleitzahl"/>
																			<aie:id value="2215"/>
																			<aie:status value="D"/>
																			<aie:format value="an..9"/>
																			<aie:pcre value="\A.{1,9}\Z"/>
																		</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:token">
																			<xs:minLength value="1"/>
																			<xs:maxLength value="9"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
																<xs:element name="City" minOccurs="1" maxOccurs="1">
																	<xs:annotation>
																		<xs:documentation>
																			<aie:name value="Ort"/>
																			<aie:id value="2212"/>
																			<aie:status value="R"/>
																			<aie:format value="an..35"/>
																			<aie:pcre value="\A.{1,35}\Z"/>
																		</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:token">
																			<xs:minLength value="1"/>
																			<xs:maxLength value="35"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
																<xs:element name="District" minOccurs="0" maxOccurs="1">
																	<xs:annotation>
																		<xs:documentation>
																			<aie:name value="Ortsteil"/>
																			<aie:id value="2213"/>
																			<aie:status value="O"/>
																			<aie:format value="an..35"/>
																			<aie:pcre value="\A.{1,35}\Z"/>
																		</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:token">
																			<xs:minLength value="1"/>
																			<xs:maxLength value="35"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
															</xs:sequence>
														</xs:complexType>
													</xs:element>
												</xs:sequence>
											</xs:complexType>
										</xs:element>
										<xs:element name="Affiliation" minOccurs="1" maxOccurs="1" id="KZV">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="VERBUNDENHEIT VON VERKÄUFER UND KÄUFER"/>
													<aie:id value="2231"/>
													<aie:status value="R"/>
												</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:sequence>
													<xs:element name="Type" minOccurs="1" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Kennzeichen Verbundenheit Verkäufer und Käufer"/>
																<aie:id value="2233"/>
																<aie:status value="R"/>
																<aie:format value="an1"/>
																<aie:pcre value="\A.\Z"/>
																<aie:list value="A1760"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:length value="1"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="Description" minOccurs="0" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Einzelheiten der Verbundenheit von Verkäufer und Käufer"/>
																<aie:id value="2232"/>
																<aie:status value="D"/>
																<aie:format value="an..100"/>
																<aie:pcre value="\A.{1,100}\Z"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:minLength value="1"/>
																<xs:maxLength value="100"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
												</xs:sequence>
											</xs:complexType>
										</xs:element>
										<xs:element name="RestrictionOrCondition" minOccurs="1" maxOccurs="1" id="KZE">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="EINSCHRÄNKUNGEN UND BEDINGUNGEN"/>
													<aie:id value="2201"/>
													<aie:status value="R"/>
												</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:sequence>
													<xs:element name="RestrictionFlag" minOccurs="1" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Einschränkungen"/>
																<aie:id value="2204"/>
																<aie:status value="R"/>
																<aie:format value="an1"/>
																<aie:pcre value="\A.\Z"/>
																<aie:list value="A1310"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:length value="1"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="ConditionFlag" minOccurs="1" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Bedingungen/Leistungen"/>
																<aie:id value="2203"/>
																<aie:status value="R"/>
																<aie:format value="an1"/>
																<aie:pcre value="\A.\Z"/>
																<aie:list value="A1220"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:length value="1"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="Description" minOccurs="0" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Einschränkungs-/Bedingungsart"/>
																<aie:id value="2202"/>
																<aie:status value="D"/>
																<aie:format value="an..100"/>
																<aie:pcre value="\A.{1,100}\Z"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:minLength value="1"/>
																<xs:maxLength value="100"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
												</xs:sequence>
											</xs:complexType>
										</xs:element>
										<xs:element name="LicenseFee" minOccurs="1" maxOccurs="1" id="KZL">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="LIZENZGEBÜHREN"/>
													<aie:id value="2228"/>
													<aie:status value="R"/>
												</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:sequence>
													<xs:element name="LicenseFeeFlag" minOccurs="1" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Kennzeichen Lizenzgebühren"/>
																<aie:id value="2229"/>
																<aie:status value="R"/>
																<aie:format value="an1"/>
																<aie:pcre value="\A.\Z"/>
																<aie:list value="A1620"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:length value="1"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="Description" minOccurs="0" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Umstände Lizenzgebühren"/>
																<aie:id value="2230"/>
																<aie:status value="D"/>
																<aie:format value="an..100"/>
																<aie:pcre value="\A.{1,100}\Z"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:minLength value="1"/>
																<xs:maxLength value="100"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
												</xs:sequence>
											</xs:complexType>
										</xs:element>
										<xs:element name="Resale" minOccurs="1" maxOccurs="1" id="KZU">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="WEITERVERKÄUFE/ÜBERLASSUNGEN/VERWENDUNGEN"/>
													<aie:id value="2280"/>
													<aie:status value="R"/>
												</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:sequence>
													<xs:element name="ResaleFlag" minOccurs="1" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Kennzeichen Weiterverkäufe/Überlassungen/Verwendungen"/>
																<aie:id value="2281"/>
																<aie:status value="R"/>
																<aie:format value="an1"/>
																<aie:pcre value="\A.\Z"/>
																<aie:list value="A1800"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:length value="1"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="Description" minOccurs="0" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Umstände zu Weiterverkäufe/Überlassungen/Verwendungen"/>
																<aie:id value="2282"/>
																<aie:status value="D"/>
																<aie:format value="an..100"/>
																<aie:pcre value="\A.{1,100}\Z"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:minLength value="1"/>
																<xs:maxLength value="100"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
												</xs:sequence>
											</xs:complexType>
										</xs:element>
									</xs:sequence>
								</xs:complexType>
							</xs:element>
							<xs:element name="Document" minOccurs="0" maxOccurs="20" id="RUX">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="VORGELEGTE UNTERLAGEN ZU EINER VZA/AZ (KOPF)"/>
										<aie:id value="2143"/>
										<aie:status value="O"/>
									</xs:documentation>
								</xs:annotation>
								<xs:complexType>
									<xs:sequence>
										<xs:element name="Division" minOccurs="1" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Bereich der Unterlage (Anmeldung)"/>
													<aie:id value="2146"/>
													<aie:status value="R"/>
													<aie:format value="an1"/>
													<aie:pcre value="\A4\Z"/>
													<aie:list value="A1255"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:length value="1"/>
													<xs:enumeration value="4"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="Type" minOccurs="1" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Art der Unterlage (Anmeldung)"/>
													<aie:id value="2152"/>
													<aie:status value="R"/>
													<aie:format value="an4"/>
													<aie:pcre value="\A.{4}\Z"/>
													<aie:list value="I0200"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:length value="4"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="ReferenceNumber" minOccurs="1" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Nummer vorgelegte Unterlage"/>
													<aie:id value="2151"/>
													<aie:status value="R"/>
													<aie:format value="an..35"/>
													<aie:pcre value="\A.{1,35}\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:minLength value="1"/>
													<xs:maxLength value="35"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="IssuingDate" minOccurs="1" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Datum vorgelegte Unterlage"/>
													<aie:id value="2147"/>
													<aie:status value="R"/>
													<aie:format value="Date (n8)"/>
													<aie:pcre value="\A(?:(?:(?:0[48]|[2468][048]|[13579][26])(?:[02468][048]|[13579][26])|(?:[02468][1-35-79]|[13579][013-57-9])(?:0[48]|[2468][048]|[13579][26]))-02-29|[0-9][0-9][0-9][0-9]-(?:(?:0[13578]|1[02])-(?:0[1-9]|[12][0-9]|3[01])|(?:0[469]|11)-(?:0[1-9]|[12][0-9]|30)|02-(?:0[1-9]|1[0-9]|2[0-8])))\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:date">
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
									</xs:sequence>
								</xs:complexType>
							</xs:element>
							<xs:element name="GoodsItem" minOccurs="1" maxOccurs="999" id="GDS">
								<xs:annotation>
									<xs:documentation>
										<aie:name value="POSITION"/>
										<aie:id value="2306"/>
										<aie:status value="R"/>
									</xs:documentation>
								</xs:annotation>
								<xs:complexType>
									<xs:sequence>
										<xs:element name="SequenceNumber" minOccurs="1" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Positionsnummer in der ZA mit informellen Anteilen"/>
													<aie:id value="2356"/>
													<aie:status value="R"/>
													<aie:format value="n..5"/>
													<aie:pcre value="\A[1-9][0-9]{0,4}\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:integer">
													<xs:minInclusive value="1"/>
													<xs:maxInclusive value="99999"/>
													<xs:totalDigits value="5"/>
													<xs:pattern value="[1-9][0-9]{0,4}"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="ReferredSequenceNumber" minOccurs="1" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Positionsnummer in der informellen vZA/AZ"/>
													<aie:id value="2383"/>
													<aie:status value="R"/>
													<aie:format value="n..3"/>
													<aie:pcre value="\A[1-9][0-9]{0,2}\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:integer">
													<xs:minInclusive value="1"/>
													<xs:maxInclusive value="999"/>
													<xs:totalDigits value="3"/>
													<xs:pattern value="[1-9][0-9]{0,2}"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="Procedure" minOccurs="1" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Verfahrenscode"/>
													<aie:status value="R"/>
												</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:sequence>
													<xs:element name="RequestedPreviousProcedure" minOccurs="1" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:id value="2377"/>
																<aie:format value="an4"/>
																<aie:pcre value="\A.{4}\Z"/>
																<aie:list value="I0100"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:length value="4"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
												</xs:sequence>
											</xs:complexType>
										</xs:element>
										<xs:element name="CessionManagementFlag" minOccurs="0" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Kennzeichen Abgabensteuerung"/>
													<aie:id value="2307"/>
													<aie:status value="D"/>
													<aie:format value="an2"/>
													<aie:pcre value="\A.{2}\Z"/>
													<aie:list value="A1345"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:length value="2"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="GoodsDescription" minOccurs="1" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Warenbezeichnung"/>
													<aie:id value="2386"/>
													<aie:status value="R"/>
													<aie:format value="an..240"/>
													<aie:pcre value="\A.{1,240}\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:minLength value="1"/>
													<xs:maxLength value="240"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="MatterCode" minOccurs="1" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Sachbereich"/>
													<aie:id value="2363"/>
													<aie:status value="R"/>
													<aie:format value="an2"/>
													<aie:pcre value="\A.{2}\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:length value="2"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="ArticleNumber" minOccurs="0" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Artikelnummer"/>
													<aie:id value="2318"/>
													<aie:status value="O"/>
													<aie:format value="an..35"/>
													<aie:pcre value="\A.{1,35}\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:minLength value="1"/>
													<xs:maxLength value="35"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="InvoiceAmount" minOccurs="0" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Artikelpreis"/>
													<aie:id value="2319"/>
													<aie:status value="D"/>
													<aie:format value="n..11 (11,2)"/>
													<aie:pcre value="\A(?:0|[1-9][0-9]{0,8})(?:\.[0-9]{1,2})?\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:decimal">
													<xs:minInclusive value="0.00"/>
													<xs:maxInclusive value="999999999.99"/>
													<xs:totalDigits value="11"/>
													<xs:fractionDigits value="2"/>
													<xs:pattern value="(0|[1-9][0-9]{0,8})(\.[0-9]{1,2})?"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="NetMassMeasure" minOccurs="1" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Eigenmasse"/>
													<aie:id value="2335"/>
													<aie:status value="R"/>
													<aie:format value="n..10 (10,1)"/>
													<aie:pcre value="\A(?:0|[1-9][0-9]{0,8})(?:\.[0-9])?\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:decimal">
													<xs:minInclusive value="0.0"/>
													<xs:maxInclusive value="999999999.9"/>
													<xs:totalDigits value="10"/>
													<xs:fractionDigits value="1"/>
													<xs:pattern value="(0|[1-9][0-9]{0,8})(\.[0-9])?"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="OriginCountry" minOccurs="1" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Ursprungsland"/>
													<aie:id value="2376"/>
													<aie:status value="R"/>
													<aie:format value="an2"/>
													<aie:pcre value="\A.{2}\Z"/>
													<aie:list value="I0300"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:length value="2"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="DepartureCountry" minOccurs="1" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Versendungsland"/>
													<aie:id value="2378"/>
													<aie:status value="R"/>
													<aie:format value="an2"/>
													<aie:pcre value="\A.{2}\Z"/>
													<aie:list value="I0300"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:length value="2"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="SupplementaryInformation" minOccurs="0" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Positionszusatz"/>
													<aie:id value="2358"/>
													<aie:status value="O"/>
													<aie:format value="an..100"/>
													<aie:pcre value="\A.{1,100}\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:minLength value="1"/>
													<xs:maxLength value="100"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="AcceptanceDate" minOccurs="1" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Datum der Annahme"/>
													<aie:id value="2315"/>
													<aie:status value="R"/>
													<aie:format value="Date (n8)"/>
													<aie:pcre value="\A(?:(?:(?:0[48]|[2468][048]|[13579][26])(?:[02468][048]|[13579][26])|(?:[02468][1-35-79]|[13579][013-57-9])(?:0[48]|[2468][048]|[13579][26]))-02-29|[0-9][0-9][0-9][0-9]-(?:(?:0[13578]|1[02])-(?:0[1-9]|[12][0-9]|3[01])|(?:0[469]|11)-(?:0[1-9]|[12][0-9]|30)|02-(?:0[1-9]|1[0-9]|2[0-8])))\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:date">
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="FinishingLimitDate" minOccurs="0" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Beendigungsfrist"/>
													<aie:id value="2326"/>
													<aie:status value="D"/>
													<aie:format value="Date (n8)"/>
													<aie:pcre value="\A(?:(?:(?:0[48]|[2468][048]|[13579][26])(?:[02468][048]|[13579][26])|(?:[02468][1-35-79]|[13579][013-57-9])(?:0[48]|[2468][048]|[13579][26]))-02-29|[0-9][0-9][0-9][0-9]-(?:(?:0[13578]|1[02])-(?:0[1-9]|[12][0-9]|3[01])|(?:0[469]|11)-(?:0[1-9]|[12][0-9]|30)|02-(?:0[1-9]|1[0-9]|2[0-8])))\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:date">
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="IssuingDate" minOccurs="1" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Datum der Überlassung"/>
													<aie:id value="2372"/>
													<aie:status value="R"/>
													<aie:format value="Date (n8)"/>
													<aie:pcre value="\A(?:(?:(?:0[48]|[2468][048]|[13579][26])(?:[02468][048]|[13579][26])|(?:[02468][1-35-79]|[13579][013-57-9])(?:0[48]|[2468][048]|[13579][26]))-02-29|[0-9][0-9][0-9][0-9]-(?:(?:0[13578]|1[02])-(?:0[1-9]|[12][0-9]|3[01])|(?:0[469]|11)-(?:0[1-9]|[12][0-9]|30)|02-(?:0[1-9]|1[0-9]|2[0-8])))\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:date">
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="ForeignTradeImportEarlyClearanceFlag" minOccurs="0" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Kennzeichen Vorgezogene außenwirtschaftsrechtliche Einfuhrabfertigung"/>
													<aie:id value="2382"/>
													<aie:status value="D"/>
													<aie:format value="an1"/>
													<aie:pcre value="\A.\Z"/>
													<aie:list value="A1775"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:length value="1"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="CompleteDeclarationFlag" minOccurs="1" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Kennzeichen Vollständige Angaben"/>
													<aie:id value="2381"/>
													<aie:status value="R"/>
													<aie:format value="an1"/>
													<aie:pcre value="\A.\Z"/>
													<aie:list value="A1750"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:length value="1"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="TobaccoRevenueStampNumber" minOccurs="0" maxOccurs="1">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="Tabaksteuerzeichen-Nummer"/>
													<aie:id value="2370"/>
													<aie:status value="D"/>
													<aie:format value="an5"/>
													<aie:pcre value="\A.{5}\Z"/>
												</xs:documentation>
											</xs:annotation>
											<xs:simpleType>
												<xs:restriction base="xs:token">
													<xs:length value="5"/>
												</xs:restriction>
											</xs:simpleType>
										</xs:element>
										<xs:element name="CommodityCode" minOccurs="1" maxOccurs="1" id="COM">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="ANGABE WARENNUMMER"/>
													<aie:id value="3247"/>
													<aie:status value="R"/>
												</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:sequence>
													<xs:element name="CommodityCode" minOccurs="1" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Warennummer"/>
																<aie:id value="3248"/>
																<aie:status value="R"/>
																<aie:format value="an11"/>
																<aie:pcre value="\A.{11}\Z"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:length value="11"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
												</xs:sequence>
											</xs:complexType>
										</xs:element>
										<xs:element name="AdditionalProcedure" minOccurs="0" maxOccurs="99" id="ADL">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="ANGABEN ZU EU-CODES"/>
													<aie:id value="4945"/>
													<aie:status value="O"/>
												</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:sequence>
													<xs:element name="Code" minOccurs="1" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="EU-Code"/>
																<aie:id value="4946"/>
																<aie:status value="R"/>
																<aie:format value="an3"/>
																<aie:pcre value="\A.{3}\Z"/>
																<aie:list value="I0100"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:length value="3"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
												</xs:sequence>
											</xs:complexType>
										</xs:element>
										<xs:element name="SupplementaryCodes" minOccurs="0" maxOccurs="10" id="PZC">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="ANGABEN ZU ZUSATZCODES"/>
													<aie:id value="3316"/>
													<aie:status value="D"/>
												</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:sequence>
													<xs:element name="Code" minOccurs="1" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Zusatzcode"/>
																<aie:id value="3317"/>
																<aie:status value="R"/>
																<aie:format value="an4"/>
																<aie:pcre value="\A.{4}\Z"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:length value="4"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
												</xs:sequence>
											</xs:complexType>
										</xs:element>
										<xs:element name="Package" minOccurs="0" maxOccurs="1" id="GS2">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="PACKSTÜCKE"/>
													<aie:id value="2965"/>
													<aie:status value="D"/>
												</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:sequence>
													<xs:element name="Kind" minOccurs="1" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Art der Packstücke"/>
																<aie:id value="2967"/>
																<aie:status value="R"/>
																<aie:format value="an2"/>
																<aie:pcre value="\A.{2}\Z"/>
																<aie:list value="A1160"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:length value="2"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="Quantity" minOccurs="0" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Packstücke-Anzahl"/>
																<aie:id value="2966"/>
																<aie:status value="D"/>
																<aie:format value="n..5"/>
																<aie:pcre value="\A[1-9][0-9]{0,4}\Z"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:integer">
																<xs:minInclusive value="1"/>
																<xs:maxInclusive value="99999"/>
																<xs:totalDigits value="5"/>
																<xs:pattern value="[1-9][0-9]{0,4}"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="MarksNumbers" minOccurs="0" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Packstücke-Zeichen und Nummern"/>
																<aie:id value="2968"/>
																<aie:status value="D"/>
																<aie:format value="an..70"/>
																<aie:pcre value="\A.{1,70}\Z"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:minLength value="1"/>
																<xs:maxLength value="70"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
												</xs:sequence>
											</xs:complexType>
										</xs:element>
										<xs:element name="ForeignTradeStatistics" minOccurs="1" maxOccurs="1" id="PAS">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="DATEN FÜR DIE AUSSENHANDELSSTATISTIK ZIA (POSITION)"/>
													<aie:id value="2561"/>
													<aie:status value="R"/>
												</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:sequence>
													<xs:element name="GoodsStatus" minOccurs="1" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Statistikstatus"/>
																<aie:id value="2567"/>
																<aie:status value="R"/>
																<aie:format value="an2"/>
																<aie:pcre value="\A(?:01|04)\Z"/>
																<aie:list value="A1920"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:length value="2"/>
																<xs:enumeration value="01"/>
																<xs:enumeration value="04"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="TransactionType" minOccurs="0" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Art des Geschäfts"/>
																<aie:id value="2564"/>
																<aie:status value="D"/>
																<aie:format value="an2"/>
																<aie:pcre value="\A.{2}\Z"/>
																<aie:list value="A1150"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:length value="2"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="DestinationCountry" minOccurs="0" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Bestimmungslandcode"/>
																<aie:id value="2563"/>
																<aie:status value="D"/>
																<aie:format value="an2"/>
																<aie:pcre value="\A.{2}\Z"/>
																<aie:list value="A1314"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:length value="2"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="DestinationFederalState" minOccurs="0" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Bestimmungsbundesland"/>
																<aie:id value="2562"/>
																<aie:status value="D"/>
																<aie:format value="an2"/>
																<aie:pcre value="\A.{2}\Z"/>
																<aie:list value="A1270"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:length value="2"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="Quantity" minOccurs="0" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Wert"/>
																<aie:id value="2569"/>
																<aie:status value="D"/>
																<aie:format value="n..9"/>
																<aie:pcre value="\A[1-9][0-9]{0,8}\Z"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:integer">
																<xs:minInclusive value="1"/>
																<xs:maxInclusive value="999999999"/>
																<xs:totalDigits value="9"/>
																<xs:pattern value="[1-9][0-9]{0,8}"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="GrossMassMeasure" minOccurs="0" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Rohmasse-Position"/>
																<aie:id value="2565"/>
																<aie:status value="O"/>
																<aie:format value="n..10 (10,1)"/>
																<aie:pcre value="\A(?!0\.?0*\Z)(?:0|[1-9][0-9]{0,8})(?:\.[0-9])?\Z"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:decimal">
																<xs:minInclusive value="0.1"/>
																<xs:maxInclusive value="999999999.9"/>
																<xs:totalDigits value="10"/>
																<xs:fractionDigits value="1"/>
																<xs:pattern value="(0|[1-9][0-9]{0,8})(\.[0-9])?"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="Amount" minOccurs="0" maxOccurs="1" id="PAM">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="ANGABEN ZUR AH-STAT. MENGE"/>
																<aie:id value="2570"/>
																<aie:status value="D"/>
															</xs:documentation>
														</xs:annotation>
														<xs:complexType>
															<xs:sequence>
																<xs:element name="Quantity" minOccurs="1" maxOccurs="1">
																	<xs:annotation>
																		<xs:documentation>
																			<aie:name value="Menge"/>
																			<aie:id value="2572"/>
																			<aie:status value="R"/>
																			<aie:format value="n..12 (12,3)"/>
																			<aie:pcre value="\A(?!0\.?0*\Z)(?:0|[1-9][0-9]{0,8})(?:\.[0-9]{1,3})?\Z"/>
																		</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:decimal">
																			<xs:minInclusive value="0.001"/>
																			<xs:maxInclusive value="999999999.999"/>
																			<xs:totalDigits value="12"/>
																			<xs:fractionDigits value="3"/>
																			<xs:pattern value="(0|[1-9][0-9]{0,8})(\.[0-9]{1,3})?"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
																<xs:element name="MeasurementUnit" minOccurs="1" maxOccurs="1">
																	<xs:annotation>
																		<xs:documentation>
																			<aie:name value="Maßeinheit"/>
																			<aie:id value="2571"/>
																			<aie:status value="R"/>
																			<aie:format value="an3"/>
																			<aie:pcre value="\A.{3}\Z"/>
																			<aie:list value="I0700"/>
																		</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:token">
																			<xs:length value="3"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
																<xs:element name="Qualifier" minOccurs="0" maxOccurs="1">
																	<xs:annotation>
																		<xs:documentation>
																			<aie:name value="Qualifikator"/>
																			<aie:id value="2573"/>
																			<aie:status value="D"/>
																			<aie:format value="an1"/>
																			<aie:pcre value="\A.\Z"/>
																			<aie:list value="I0700"/>
																		</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:token">
																			<xs:length value="1"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
															</xs:sequence>
														</xs:complexType>
													</xs:element>
												</xs:sequence>
											</xs:complexType>
										</xs:element>
										<xs:element name="InwardMovement" minOccurs="0" maxOccurs="1" id="PZG">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="ZUGANG"/>
													<aie:id value="3297"/>
													<aie:status value="D"/>
												</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:sequence>
													<xs:element name="Amount" minOccurs="1" maxOccurs="1" id="ZGM">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="ANGABEN ZUR ZUGANGSMENGE"/>
																<aie:id value="3302"/>
																<aie:status value="R"/>
															</xs:documentation>
														</xs:annotation>
														<xs:complexType>
															<xs:sequence>
																<xs:element name="Quantity" minOccurs="1" maxOccurs="1">
																	<xs:annotation>
																		<xs:documentation>
																			<aie:name value="Zugangsmenge"/>
																			<aie:id value="3304"/>
																			<aie:status value="R"/>
																			<aie:format value="n..12 (12,3)"/>
																			<aie:pcre value="\A(?!0\.?0*\Z)(?:0|[1-9][0-9]{0,8})(?:\.[0-9]{1,3})?\Z"/>
																		</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:decimal">
																			<xs:minInclusive value="0.001"/>
																			<xs:maxInclusive value="999999999.999"/>
																			<xs:totalDigits value="12"/>
																			<xs:fractionDigits value="3"/>
																			<xs:pattern value="(0|[1-9][0-9]{0,8})(\.[0-9]{1,3})?"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
																<xs:element name="MeasurementUnit" minOccurs="1" maxOccurs="1">
																	<xs:annotation>
																		<xs:documentation>
																			<aie:name value="Maßeinheit (Zugangsmenge)"/>
																			<aie:id value="3303"/>
																			<aie:status value="R"/>
																			<aie:format value="an3"/>
																			<aie:pcre value="\A.{3}\Z"/>
																			<aie:list value="I0700"/>
																		</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:token">
																			<xs:length value="3"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
																<xs:element name="Qualifier" minOccurs="0" maxOccurs="1">
																	<xs:annotation>
																		<xs:documentation>
																			<aie:name value="Qualifikator (Zugangsmenge)"/>
																			<aie:id value="3305"/>
																			<aie:status value="D"/>
																			<aie:format value="an1"/>
																			<aie:pcre value="\A.\Z"/>
																			<aie:list value="I0700"/>
																		</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:token">
																			<xs:length value="1"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
															</xs:sequence>
														</xs:complexType>
													</xs:element>
												</xs:sequence>
											</xs:complexType>
										</xs:element>
										<xs:element name="CustomsValue" minOccurs="0" maxOccurs="1" id="PZW">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="ANGABEN ÜBER DEN ZOLLWERT (D.V.1) ZIA (POSITION)"/>
													<aie:id value="3262"/>
													<aie:status value="D"/>
												</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:sequence>
													<xs:element name="DepartureAirport" minOccurs="0" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Abflughafen"/>
																<aie:id value="3263"/>
																<aie:status value="D"/>
																<aie:format value="an3"/>
																<aie:pcre value="\A.{3}\Z"/>
																<aie:list value="I0600"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:length value="3"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="DestinationPlace" minOccurs="0" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Ort des Verbringens"/>
																<aie:id value="3265"/>
																<aie:status value="D"/>
																<aie:format value="an..35"/>
																<aie:pcre value="\A.{1,35}\Z"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:minLength value="1"/>
																<xs:maxLength value="35"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="AdditionDeductionDescription" minOccurs="0" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Hinzurechnungen/Abzüge"/>
																<aie:id value="3264"/>
																<aie:status value="D"/>
																<aie:format value="an..30"/>
																<aie:pcre value="\A.{1,30}\Z"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:minLength value="1"/>
																<xs:maxLength value="30"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="NetPrice" minOccurs="0" maxOccurs="1" id="PZN">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="ANGABEN ZUM NETTOPREIS"/>
																<aie:id value="3291"/>
																<aie:status value="D"/>
															</xs:documentation>
														</xs:annotation>
														<xs:complexType>
															<xs:sequence>
																<xs:element name="Value" minOccurs="1" maxOccurs="1">
																	<xs:annotation>
																		<xs:documentation>
																			<aie:name value="Nettopreis"/>
																			<aie:id value="3292"/>
																			<aie:status value="R"/>
																			<aie:format value="n..11 (11,2)"/>
																			<aie:pcre value="\A(?!0\.?0*\Z)(?:0|[1-9][0-9]{0,8})(?:\.[0-9]{1,2})?\Z"/>
																		</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:decimal">
																			<xs:minInclusive value="0.01"/>
																			<xs:maxInclusive value="999999999.99"/>
																			<xs:totalDigits value="11"/>
																			<xs:fractionDigits value="2"/>
																			<xs:pattern value="(0|[1-9][0-9]{0,8})(\.[0-9]{1,2})?"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
																<xs:element name="CurrencyCode" minOccurs="1" maxOccurs="1">
																	<xs:annotation>
																		<xs:documentation>
																			<aie:name value="Währung Nettopreis"/>
																			<aie:id value="3296"/>
																			<aie:status value="R"/>
																			<aie:format value="an3"/>
																			<aie:pcre value="\A.{3}\Z"/>
																			<aie:list value="I0400"/>
																		</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:token">
																			<xs:length value="3"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
																<xs:element name="CurrencyRateAgreedFlag" minOccurs="0" maxOccurs="1">
																	<xs:annotation>
																		<xs:documentation>
																			<aie:name value="Kennzeichen Kurs netto vereinbart"/>
																			<aie:id value="3295"/>
																			<aie:status value="D"/>
																			<aie:format value="an1"/>
																			<aie:pcre value="\A.\Z"/>
																			<aie:list value="A1610"/>
																		</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:token">
																			<xs:length value="1"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
																<xs:element name="CurrencyRate" minOccurs="0" maxOccurs="1">
																	<xs:annotation>
																		<xs:documentation>
																			<aie:name value="Kurs Nettopreis"/>
																			<aie:id value="3293"/>
																			<aie:status value="D"/>
																			<aie:format value="n..12 (18,9)"/>
																			<aie:pcre value="\A(?!0\.?0*\Z)(?=.{1,13}\Z)(?:0|[1-9][0-9]{0,8})(?:\.[0-9]{1,9})?\Z"/>
																		</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:decimal">
																			<xs:minInclusive value="0.000000001"/>
																			<xs:maxInclusive value="999999999.999"/>
																			<xs:totalDigits value="12"/>
																			<xs:fractionDigits value="9"/>
																			<xs:pattern value="(0|[1-9][0-9]{0,8})(\.[0-9]{1,9})?"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
															</xs:sequence>
														</xs:complexType>
													</xs:element>
													<xs:element name="IndirectPayment" minOccurs="0" maxOccurs="1" id="PZM">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="ANGABEN ZU MITTELBAREN ZAHLUNGEN"/>
																<aie:id value="3285"/>
																<aie:status value="D"/>
															</xs:documentation>
														</xs:annotation>
														<xs:complexType>
															<xs:sequence>
																<xs:element name="Value" minOccurs="1" maxOccurs="1">
																	<xs:annotation>
																		<xs:documentation>
																			<aie:name value="Mittelbare Zahlungen"/>
																			<aie:id value="3286"/>
																			<aie:status value="R"/>
																			<aie:format value="n..11 (11,2)"/>
																			<aie:pcre value="\A(?!0\.?0*\Z)(?:0|[1-9][0-9]{0,8})(?:\.[0-9]{1,2})?\Z"/>
																		</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:decimal">
																			<xs:minInclusive value="0.01"/>
																			<xs:maxInclusive value="999999999.99"/>
																			<xs:totalDigits value="11"/>
																			<xs:fractionDigits value="2"/>
																			<xs:pattern value="(0|[1-9][0-9]{0,8})(\.[0-9]{1,2})?"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
																<xs:element name="CurrencyCode" minOccurs="1" maxOccurs="1">
																	<xs:annotation>
																		<xs:documentation>
																			<aie:name value="Währung Mittelbare Zahlungen"/>
																			<aie:id value="3290"/>
																			<aie:status value="R"/>
																			<aie:format value="an3"/>
																			<aie:pcre value="\A.{3}\Z"/>
																			<aie:list value="I0400"/>
																		</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:token">
																			<xs:length value="3"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
																<xs:element name="CurrencyRateAgreedFlag" minOccurs="0" maxOccurs="1">
																	<xs:annotation>
																		<xs:documentation>
																			<aie:name value="Kennzeichen Kurs Mittelbare Zahlungen vereinbart"/>
																			<aie:id value="3289"/>
																			<aie:status value="D"/>
																			<aie:format value="an1"/>
																			<aie:pcre value="\A.\Z"/>
																			<aie:list value="A1600"/>
																		</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:token">
																			<xs:length value="1"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
																<xs:element name="CurrencyRate" minOccurs="0" maxOccurs="1">
																	<xs:annotation>
																		<xs:documentation>
																			<aie:name value="Kurs Mittelbare Zahlungen"/>
																			<aie:id value="3287"/>
																			<aie:status value="D"/>
																			<aie:format value="n..12 (18,9)"/>
																			<aie:pcre value="\A(?!0\.?0*\Z)(?=.{1,13}\Z)(?:0|[1-9][0-9]{0,8})(?:\.[0-9]{1,9})?\Z"/>
																		</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:decimal">
																			<xs:minInclusive value="0.000000001"/>
																			<xs:maxInclusive value="999999999.999"/>
																			<xs:totalDigits value="12"/>
																			<xs:fractionDigits value="9"/>
																			<xs:pattern value="(0|[1-9][0-9]{0,8})(\.[0-9]{1,9})?"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
															</xs:sequence>
														</xs:complexType>
													</xs:element>
													<xs:element name="AirFreightCosts" minOccurs="0" maxOccurs="1" id="PZL">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="ANGABEN ZU DEN LUFTFRACHTKOSTEN"/>
																<aie:id value="3276"/>
																<aie:status value="D"/>
															</xs:documentation>
														</xs:annotation>
														<xs:complexType>
															<xs:sequence>
																<xs:element name="Value" minOccurs="1" maxOccurs="1">
																	<xs:annotation>
																		<xs:documentation>
																			<aie:name value="Betrag der gesamten Luftfrachtkosten"/>
																			<aie:id value="3277"/>
																			<aie:status value="R"/>
																			<aie:format value="n..11 (11,2)"/>
																			<aie:pcre value="\A(?!0\.?0*\Z)(?:0|[1-9][0-9]{0,8})(?:\.[0-9]{1,2})?\Z"/>
																		</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:decimal">
																			<xs:minInclusive value="0.01"/>
																			<xs:maxInclusive value="999999999.99"/>
																			<xs:totalDigits value="11"/>
																			<xs:fractionDigits value="2"/>
																			<xs:pattern value="(0|[1-9][0-9]{0,8})(\.[0-9]{1,2})?"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
																<xs:element name="CurrencyCode" minOccurs="1" maxOccurs="1">
																	<xs:annotation>
																		<xs:documentation>
																			<aie:name value="Währung Betrag der gesamten Luftfrachtkosten"/>
																			<aie:id value="3284"/>
																			<aie:status value="R"/>
																			<aie:format value="an3"/>
																			<aie:pcre value="\A.{3}\Z"/>
																			<aie:list value="I0400"/>
																		</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:token">
																			<xs:length value="3"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
																<xs:element name="CurrencyRateIATA" minOccurs="0" maxOccurs="1">
																	<xs:annotation>
																		<xs:documentation>
																			<aie:name value="Kennzeichen IATA-Kurs Betrag der gesamten Luftfrachtkosten"/>
																			<aie:id value="3278"/>
																			<aie:status value="D"/>
																			<aie:format value="an1"/>
																			<aie:pcre value="\A.\Z"/>
																			<aie:list value="A1560"/>
																		</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:token">
																			<xs:length value="1"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
																<xs:element name="CurrencyRateAgreedFlag" minOccurs="0" maxOccurs="1">
																	<xs:annotation>
																		<xs:documentation>
																			<aie:name value="Kennzeichen Kurs Betrag der gesamten Luftfrachtkosten vereinbart"/>
																			<aie:id value="3282"/>
																			<aie:status value="D"/>
																			<aie:format value="an1"/>
																			<aie:pcre value="\A.\Z"/>
																			<aie:list value="A1590"/>
																		</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:token">
																			<xs:length value="1"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
																<xs:element name="CurrencyRate" minOccurs="0" maxOccurs="1">
																	<xs:annotation>
																		<xs:documentation>
																			<aie:name value="Kurs Betrag der gesamten Luftfrachtkosten"/>
																			<aie:id value="3279"/>
																			<aie:status value="D"/>
																			<aie:format value="n..12 (18,9)"/>
																			<aie:pcre value="\A(?!0\.?0*\Z)(?=.{1,13}\Z)(?:0|[1-9][0-9]{0,8})(?:\.[0-9]{1,9})?\Z"/>
																		</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:decimal">
																			<xs:minInclusive value="0.000000001"/>
																			<xs:maxInclusive value="999999999.999"/>
																			<xs:totalDigits value="12"/>
																			<xs:fractionDigits value="9"/>
																			<xs:pattern value="(0|[1-9][0-9]{0,8})(\.[0-9]{1,9})?"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
																<xs:element name="CurrencyRateDate" minOccurs="0" maxOccurs="1">
																	<xs:annotation>
																		<xs:documentation>
																			<aie:name value="Datum des Kurses Betrag der gesamten Luftfrachtkosten"/>
																			<aie:id value="3281"/>
																			<aie:status value="D"/>
																			<aie:format value="Date (n8)"/>
																			<aie:pcre value="\A(?:(?:(?:0[48]|[2468][048]|[13579][26])(?:[02468][048]|[13579][26])|(?:[02468][1-35-79]|[13579][013-57-9])(?:0[48]|[2468][048]|[13579][26]))-02-29|[0-9][0-9][0-9][0-9]-(?:(?:0[13578]|1[02])-(?:0[1-9]|[12][0-9]|3[01])|(?:0[469]|11)-(?:0[1-9]|[12][0-9]|30)|02-(?:0[1-9]|1[0-9]|2[0-8])))\Z"/>
																		</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:date">
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
															</xs:sequence>
														</xs:complexType>
													</xs:element>
													<xs:element name="AdditionDeduction" minOccurs="0" maxOccurs="10" id="PZR">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="HINZURECHNUNGEN/ABZÜGE ZUM ZOLLWERT"/>
																<aie:id value="3266"/>
																<aie:status value="D"/>
															</xs:documentation>
														</xs:annotation>
														<xs:complexType>
															<xs:sequence>
																<xs:element name="Type" minOccurs="1" maxOccurs="1">
																	<xs:annotation>
																		<xs:documentation>
																			<aie:name value="Art Abzug/Hinzurechnungen"/>
																			<aie:id value="3267"/>
																			<aie:status value="R"/>
																			<aie:format value="an3"/>
																			<aie:pcre value="\A.{3}\Z"/>
																			<aie:list value="A1070"/>
																		</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:token">
																			<xs:length value="3"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
																<xs:element name="Value" minOccurs="1" maxOccurs="1">
																	<xs:annotation>
																		<xs:documentation>
																			<aie:name value="Betrag Abzug/Hinzurechnungen"/>
																			<aie:id value="3268"/>
																			<aie:status value="R"/>
																			<aie:format value="n..11 (11,2)"/>
																			<aie:pcre value="\A(?!0\.?0*\Z)(?:0|[1-9][0-9]{0,8})(?:\.[0-9]{1,2})?\Z"/>
																		</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:decimal">
																			<xs:minInclusive value="0.01"/>
																			<xs:maxInclusive value="999999999.99"/>
																			<xs:totalDigits value="11"/>
																			<xs:fractionDigits value="2"/>
																			<xs:pattern value="(0|[1-9][0-9]{0,8})(\.[0-9]{1,2})?"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
																<xs:element name="CurrencyCode" minOccurs="1" maxOccurs="1">
																	<xs:annotation>
																		<xs:documentation>
																			<aie:name value="Währung Abzug/Hinzurechnungen"/>
																			<aie:id value="3275"/>
																			<aie:status value="R"/>
																			<aie:format value="an3"/>
																			<aie:pcre value="\A.{3}\Z"/>
																			<aie:list value="I0400"/>
																		</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:token">
																			<xs:length value="3"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
																<xs:element name="CurrencyRateIATA" minOccurs="0" maxOccurs="1">
																	<xs:annotation>
																		<xs:documentation>
																			<aie:name value="Kennzeichen IATA-Kurs Abzug/Hinzurechnungen"/>
																			<aie:id value="3269"/>
																			<aie:status value="D"/>
																			<aie:format value="an1"/>
																			<aie:pcre value="\A.\Z"/>
																			<aie:list value="A1560"/>
																		</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:token">
																			<xs:length value="1"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
																<xs:element name="CurrencyRateAgreedFlag" minOccurs="0" maxOccurs="1">
																	<xs:annotation>
																		<xs:documentation>
																			<aie:name value="Kennzeichen Kurs Abzug/Hinzurechnungen vereinbart"/>
																			<aie:id value="3273"/>
																			<aie:status value="D"/>
																			<aie:format value="an1"/>
																			<aie:pcre value="\A.\Z"/>
																			<aie:list value="A1590"/>
																		</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:token">
																			<xs:length value="1"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
																<xs:element name="CurrencyRate" minOccurs="0" maxOccurs="1">
																	<xs:annotation>
																		<xs:documentation>
																			<aie:name value="Kurs Abzug/Hinzurechnungen"/>
																			<aie:id value="3270"/>
																			<aie:status value="D"/>
																			<aie:format value="n..12 (18,9)"/>
																			<aie:pcre value="\A(?!0\.?0*\Z)(?=.{1,13}\Z)(?:0|[1-9][0-9]{0,8})(?:\.[0-9]{1,9})?\Z"/>
																		</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:decimal">
																			<xs:minInclusive value="0.000000001"/>
																			<xs:maxInclusive value="999999999.999"/>
																			<xs:totalDigits value="12"/>
																			<xs:fractionDigits value="9"/>
																			<xs:pattern value="(0|[1-9][0-9]{0,8})(\.[0-9]{1,9})?"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
																<xs:element name="CurrencyRateDate" minOccurs="0" maxOccurs="1">
																	<xs:annotation>
																		<xs:documentation>
																			<aie:name value="Datum des Kurses Abzug/Hinzurechnungen"/>
																			<aie:id value="3272"/>
																			<aie:status value="D"/>
																			<aie:format value="Date (n8)"/>
																			<aie:pcre value="\A(?:(?:(?:0[48]|[2468][048]|[13579][26])(?:[02468][048]|[13579][26])|(?:[02468][1-35-79]|[13579][013-57-9])(?:0[48]|[2468][048]|[13579][26]))-02-29|[0-9][0-9][0-9][0-9]-(?:(?:0[13578]|1[02])-(?:0[1-9]|[12][0-9]|3[01])|(?:0[469]|11)-(?:0[1-9]|[12][0-9]|30)|02-(?:0[1-9]|1[0-9]|2[0-8])))\Z"/>
																		</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:date">
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
																<xs:element name="Percentage" minOccurs="0" maxOccurs="1">
																	<xs:annotation>
																		<xs:documentation>
																			<aie:name value="Prozent der Hinzurechnungen/Abzüge"/>
																			<aie:id value="3274"/>
																			<aie:status value="D"/>
																			<aie:format value="n..5 (5,2)"/>
																			<aie:pcre value="\A(?!0\.?0*\Z)(?:0|[1-9][0-9]{0,2})(?:\.[0-9]{1,2})?\Z"/>
																		</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:decimal">
																			<xs:minInclusive value="0.01"/>
																			<xs:maxInclusive value="999.99"/>
																			<xs:totalDigits value="5"/>
																			<xs:fractionDigits value="2"/>
																			<xs:pattern value="(0|[1-9][0-9]{0,2})(\.[0-9]{1,2})?"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
															</xs:sequence>
														</xs:complexType>
													</xs:element>
												</xs:sequence>
											</xs:complexType>
										</xs:element>
										<xs:element name="Assessment" minOccurs="0" maxOccurs="1" id="PBX">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="BEMESSUNGSDATEN (OHNE VERBRAUCHSTEUER) ZIA (POSITION)"/>
													<aie:id value="2695"/>
													<aie:status value="D"/>
												</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:sequence>
													<xs:element name="CustomsValue" minOccurs="0" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Zollwert"/>
																<aie:id value="2699"/>
																<aie:status value="D"/>
																<aie:format value="n..11 (11,2)"/>
																<aie:pcre value="\A(?!0\.?0*\Z)(?:0|[1-9][0-9]{0,8})(?:\.[0-9]{1,2})?\Z"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:decimal">
																<xs:minInclusive value="0.01"/>
																<xs:maxInclusive value="999999999.99"/>
																<xs:totalDigits value="11"/>
																<xs:fractionDigits value="2"/>
																<xs:pattern value="(0|[1-9][0-9]{0,8})(\.[0-9]{1,2})?"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="OutwardProcessingFee" minOccurs="0" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Veredelungsentgelt/Wertsteigerung"/>
																<aie:id value="2696"/>
																<aie:status value="D"/>
																<aie:format value="n..11 (11,2)"/>
																<aie:pcre value="\A(?!0\.?0*\Z)(?:0|[1-9][0-9]{0,8})(?:\.[0-9]{1,2})?\Z"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:decimal">
																<xs:minInclusive value="0.01"/>
																<xs:maxInclusive value="999999999.99"/>
																<xs:totalDigits value="11"/>
																<xs:fractionDigits value="2"/>
																<xs:pattern value="(0|[1-9][0-9]{0,8})(\.[0-9]{1,2})?"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="TaxCosts" minOccurs="0" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Kosten für EUSt"/>
																<aie:id value="2697"/>
																<aie:status value="D"/>
																<aie:format value="n..11 (11,2)"/>
																<aie:pcre value="\A(?!0\.?0*\Z)(?:0|[1-9][0-9]{0,8})(?:\.[0-9]{1,2})?\Z"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:decimal">
																<xs:minInclusive value="0.01"/>
																<xs:maxInclusive value="999999999.99"/>
																<xs:totalDigits value="11"/>
																<xs:fractionDigits value="2"/>
																<xs:pattern value="(0|[1-9][0-9]{0,8})(\.[0-9]{1,2})?"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="Amount" minOccurs="0" maxOccurs="5" id="PBZ">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="ANGABEN ZUR ZOLLMENGE"/>
																<aie:id value="2706"/>
																<aie:status value="D"/>
															</xs:documentation>
														</xs:annotation>
														<xs:complexType>
															<xs:sequence>
																<xs:element name="Quantity" minOccurs="1" maxOccurs="1">
																	<xs:annotation>
																		<xs:documentation>
																			<aie:name value="Zollmenge"/>
																			<aie:id value="2708"/>
																			<aie:status value="R"/>
																			<aie:format value="n..12 (12,3)"/>
																			<aie:pcre value="\A(?!0\.?0*\Z)(?:0|[1-9][0-9]{0,8})(?:\.[0-9]{1,3})?\Z"/>
																		</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:decimal">
																			<xs:minInclusive value="0.001"/>
																			<xs:maxInclusive value="999999999.999"/>
																			<xs:totalDigits value="12"/>
																			<xs:fractionDigits value="3"/>
																			<xs:pattern value="(0|[1-9][0-9]{0,8})(\.[0-9]{1,3})?"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
																<xs:element name="MeasurementUnit" minOccurs="1" maxOccurs="1">
																	<xs:annotation>
																		<xs:documentation>
																			<aie:name value="Maßeinheit (Zollmenge)"/>
																			<aie:id value="2707"/>
																			<aie:status value="R"/>
																			<aie:format value="an3"/>
																			<aie:pcre value="\A.{3}\Z"/>
																			<aie:list value="I0700"/>
																		</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:token">
																			<xs:length value="3"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
																<xs:element name="Qualifier" minOccurs="0" maxOccurs="1">
																	<xs:annotation>
																		<xs:documentation>
																			<aie:name value="Qualifikator (Zollmenge)"/>
																			<aie:id value="2709"/>
																			<aie:status value="D"/>
																			<aie:format value="an1"/>
																			<aie:pcre value="\A.\Z"/>
																			<aie:list value="I0700"/>
																		</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:token">
																			<xs:length value="1"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
															</xs:sequence>
														</xs:complexType>
													</xs:element>
													<xs:element name="SpecificRate" minOccurs="0" maxOccurs="5" id="PBW">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="ANGABEN ZUR BESONDEREN WERTANGABE"/>
																<aie:id value="2700"/>
																<aie:status value="D"/>
															</xs:documentation>
														</xs:annotation>
														<xs:complexType>
															<xs:sequence>
																<xs:element name="Type" minOccurs="1" maxOccurs="1">
																	<xs:annotation>
																		<xs:documentation>
																			<aie:name value="Preisart"/>
																			<aie:id value="2701"/>
																			<aie:status value="R"/>
																			<aie:format value="an1"/>
																			<aie:pcre value="\A.\Z"/>
																			<aie:list value="A1880"/>
																		</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:token">
																			<xs:length value="1"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
																<xs:element name="Value" minOccurs="1" maxOccurs="1">
																	<xs:annotation>
																		<xs:documentation>
																			<aie:name value="Besondere Wertangabe"/>
																			<aie:id value="2702"/>
																			<aie:status value="R"/>
																			<aie:format value="n..11 (11,2)"/>
																			<aie:pcre value="\A(?!0\.?0*\Z)(?:0|[1-9][0-9]{0,8})(?:\.[0-9]{1,2})?\Z"/>
																		</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:decimal">
																			<xs:minInclusive value="0.01"/>
																			<xs:maxInclusive value="999999999.99"/>
																			<xs:totalDigits value="11"/>
																			<xs:fractionDigits value="2"/>
																			<xs:pattern value="(0|[1-9][0-9]{0,8})(\.[0-9]{1,2})?"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
															</xs:sequence>
														</xs:complexType>
													</xs:element>
													<xs:element name="ContentInformation" minOccurs="0" maxOccurs="3" id="PBG">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="GEHALTSANGABEN"/>
																<aie:id value="2703"/>
																<aie:status value="O"/>
															</xs:documentation>
														</xs:annotation>
														<xs:complexType>
															<xs:sequence>
																<xs:element name="Type" minOccurs="1" maxOccurs="1">
																	<xs:annotation>
																		<xs:documentation>
																			<aie:name value="Gehaltsangaben/Art"/>
																			<aie:id value="2704"/>
																			<aie:status value="R"/>
																			<aie:format value="an2"/>
																			<aie:pcre value="\A.{2}\Z"/>
																			<aie:list value="A1330"/>
																		</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:token">
																			<xs:length value="2"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
																<xs:element name="Degree-Percentage" minOccurs="1" maxOccurs="1">
																	<xs:annotation>
																		<xs:documentation>
																			<aie:name value="Gehaltsangaben (Grad/Prozent)"/>
																			<aie:id value="2705"/>
																			<aie:status value="R"/>
																			<aie:format value="n..5 (5,2)"/>
																			<aie:pcre value="\A(?!0\.?0*\Z)(?:(?:0|[1-9][0-9]{0,1})(?:\.[0-9]{1,2})?|100(?:\.0{1,2})?)\Z"/>
																		</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:decimal">
																			<xs:pattern value="(0|[1-9][0-9]{0,1})(\.[0-9]{1,2})?"/>
																			<xs:pattern value="100(\.0{1,2})?"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
															</xs:sequence>
														</xs:complexType>
													</xs:element>
												</xs:sequence>
											</xs:complexType>
										</xs:element>
										<xs:element name="ExciseDuty" minOccurs="0" maxOccurs="3" id="PVS">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="VERBRAUCHSTEUERDATEN ZIA (POSITION)"/>
													<aie:id value="3095"/>
													<aie:status value="D"/>
												</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:sequence>
													<xs:element name="Code" minOccurs="1" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Verbrauchsteuer (Code)"/>
																<aie:id value="3096"/>
																<aie:status value="R"/>
																<aie:format value="an4"/>
																<aie:pcre value="\A.{4}\Z"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:length value="4"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="Degree-Percentage" minOccurs="0" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Grad/Prozent (Verbrauchsteuer)"/>
																<aie:id value="3097"/>
																<aie:status value="D"/>
																<aie:format value="n..5 (5,2)"/>
																<aie:pcre value="\A(?!0\.?0*\Z)(?:(?:0|[1-9][0-9]{0,1})(?:\.[0-9]{1,2})?|100(?:\.0{1,2})?)\Z"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:decimal">
																<xs:pattern value="(0|[1-9][0-9]{0,1})(\.[0-9]{1,2})?"/>
																<xs:pattern value="100(\.0{1,2})?"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="Value" minOccurs="0" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Verbrauchsteuerwert"/>
																<aie:id value="3098"/>
																<aie:status value="D"/>
																<aie:format value="n..11 (11,2)"/>
																<aie:pcre value="\A(?!0\.?0*\Z)(?:0|[1-9][0-9]{0,8})(?:\.[0-9]{1,2})?\Z"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:decimal">
																<xs:minInclusive value="0.01"/>
																<xs:maxInclusive value="999999999.99"/>
																<xs:totalDigits value="11"/>
																<xs:fractionDigits value="2"/>
																<xs:pattern value="(0|[1-9][0-9]{0,8})(\.[0-9]{1,2})?"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="Amount" minOccurs="1" maxOccurs="1" id="PVM">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="ANGABEN ZUR VERBRAUCHSTEUERMENGE"/>
																<aie:id value="3099"/>
																<aie:status value="R"/>
															</xs:documentation>
														</xs:annotation>
														<xs:complexType>
															<xs:sequence>
																<xs:element name="Quantity" minOccurs="1" maxOccurs="1">
																	<xs:annotation>
																		<xs:documentation>
																			<aie:name value="Verbrauchsteuer (Menge)"/>
																			<aie:id value="3101"/>
																			<aie:status value="R"/>
																			<aie:format value="n..12 (12,3)"/>
																			<aie:pcre value="\A(?!0\.?0*\Z)(?:0|[1-9][0-9]{0,8})(?:\.[0-9]{1,3})?\Z"/>
																		</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:decimal">
																			<xs:minInclusive value="0.001"/>
																			<xs:maxInclusive value="999999999.999"/>
																			<xs:totalDigits value="12"/>
																			<xs:fractionDigits value="3"/>
																			<xs:pattern value="(0|[1-9][0-9]{0,8})(\.[0-9]{1,3})?"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
																<xs:element name="MeasurementUnit" minOccurs="1" maxOccurs="1">
																	<xs:annotation>
																		<xs:documentation>
																			<aie:name value="Maßeinheit (Verbrauchsteuer)"/>
																			<aie:id value="3100"/>
																			<aie:status value="R"/>
																			<aie:format value="an3"/>
																			<aie:pcre value="\A.{3}\Z"/>
																			<aie:list value="I0700"/>
																		</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:token">
																			<xs:length value="3"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
																<xs:element name="Qualifier" minOccurs="0" maxOccurs="1">
																	<xs:annotation>
																		<xs:documentation>
																			<aie:name value="Qualifikator (Verbrauchsteuer)"/>
																			<aie:id value="3102"/>
																			<aie:status value="D"/>
																			<aie:format value="an1"/>
																			<aie:pcre value="\A.\Z"/>
																			<aie:list value="I0700"/>
																		</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:token">
																			<xs:length value="1"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
															</xs:sequence>
														</xs:complexType>
													</xs:element>
												</xs:sequence>
											</xs:complexType>
										</xs:element>
										<xs:element name="PreferentialTreatment" minOccurs="0" maxOccurs="1" id="PGX">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="BEGÜNSTIGUNGSDATEN ZIA (POSITION)"/>
													<aie:id value="3843"/>
													<aie:status value="D"/>
												</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:sequence>
													<xs:element name="RequestedPreferentialTreatment" minOccurs="0" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Beantragte Begünstigung"/>
																<aie:id value="2656"/>
																<aie:status value="D"/>
																<aie:format value="an3"/>
																<aie:pcre value="\A.{3}\Z"/>
																<aie:list value="A1200"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:length value="3"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="Declaration" minOccurs="0" maxOccurs="1" id="PGM">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="ANGABEN ZU KONTINGENTEN"/>
																<aie:id value="3844"/>
																<aie:status value="D"/>
															</xs:documentation>
														</xs:annotation>
														<xs:complexType>
															<xs:sequence>
																<xs:element name="Contingent" minOccurs="0" maxOccurs="2" id="GMK">
																	<xs:annotation>
																		<xs:documentation>
																			<aie:name value="KONTINGENTSANGABEN"/>
																			<aie:id value="3845"/>
																			<aie:status value="D"/>
																		</xs:documentation>
																	</xs:annotation>
																	<xs:complexType>
																		<xs:sequence>
																			<xs:element name="ContingentNumber" minOccurs="1" maxOccurs="1">
																				<xs:annotation>
																					<xs:documentation>
																						<aie:name value="Kontingentnummer"/>
																						<aie:id value="2662"/>
																						<aie:status value="R"/>
																						<aie:format value="an4"/>
																						<aie:pcre value="\A.{4}\Z"/>
																					</xs:documentation>
																				</xs:annotation>
																				<xs:simpleType>
																					<xs:restriction base="xs:token">
																						<xs:length value="4"/>
																					</xs:restriction>
																				</xs:simpleType>
																			</xs:element>
																		</xs:sequence>
																	</xs:complexType>
																</xs:element>
																<xs:element name="PreferentialTreatmentQuantity" minOccurs="0" maxOccurs="1" id="GMB">
																	<xs:annotation>
																		<xs:documentation>
																			<aie:name value="ANGABEN ZUR BEGÜNSTIGUNGSMENGE"/>
																			<aie:id value="2657"/>
																			<aie:status value="D"/>
																		</xs:documentation>
																	</xs:annotation>
																	<xs:complexType>
																		<xs:sequence>
																			<xs:element name="Quantity" minOccurs="1" maxOccurs="1">
																				<xs:annotation>
																					<xs:documentation>
																						<aie:name value="Begünstigungsmenge"/>
																						<aie:id value="2659"/>
																						<aie:status value="R"/>
																						<aie:format value="n..9"/>
																						<aie:pcre value="\A[1-9][0-9]{0,8}\Z"/>
																					</xs:documentation>
																				</xs:annotation>
																				<xs:simpleType>
																					<xs:restriction base="xs:integer">
																						<xs:minInclusive value="1"/>
																						<xs:maxInclusive value="999999999"/>
																						<xs:totalDigits value="9"/>
																						<xs:pattern value="[1-9][0-9]{0,8}"/>
																					</xs:restriction>
																				</xs:simpleType>
																			</xs:element>
																			<xs:element name="MeasurementUnit" minOccurs="1" maxOccurs="1">
																				<xs:annotation>
																					<xs:documentation>
																						<aie:name value="Maßeinheit (Begünstigungsmenge)"/>
																						<aie:id value="2658"/>
																						<aie:status value="R"/>
																						<aie:format value="an3"/>
																						<aie:pcre value="\A.{3}\Z"/>
																						<aie:list value="I0700"/>
																					</xs:documentation>
																				</xs:annotation>
																				<xs:simpleType>
																					<xs:restriction base="xs:token">
																						<xs:length value="3"/>
																					</xs:restriction>
																				</xs:simpleType>
																			</xs:element>
																			<xs:element name="Qualifier" minOccurs="0" maxOccurs="1">
																				<xs:annotation>
																					<xs:documentation>
																						<aie:name value="Qualifikator (Begünstigungsmenge)"/>
																						<aie:id value="2660"/>
																						<aie:status value="D"/>
																						<aie:format value="an1"/>
																						<aie:pcre value="\A.\Z"/>
																						<aie:list value="I0700"/>
																					</xs:documentation>
																				</xs:annotation>
																				<xs:simpleType>
																					<xs:restriction base="xs:token">
																						<xs:length value="1"/>
																					</xs:restriction>
																				</xs:simpleType>
																			</xs:element>
																		</xs:sequence>
																	</xs:complexType>
																</xs:element>
															</xs:sequence>
														</xs:complexType>
													</xs:element>
												</xs:sequence>
											</xs:complexType>
										</xs:element>
										<xs:element name="OutwardProcessingReduction" minOccurs="0" maxOccurs="3" id="PPV">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="ANGABEN ZU PV-MINDERUNG"/>
													<aie:id value="2969"/>
													<aie:status value="D"/>
												</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:sequence>
													<xs:element name="Group" minOccurs="1" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Mindernde Abgabengruppe"/>
																<aie:id value="2971"/>
																<aie:status value="R"/>
																<aie:format value="an2"/>
																<aie:pcre value="\A.{2}\Z"/>
																<aie:list value="A1860"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:length value="2"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="Amount" minOccurs="1" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Minderungsbetrag"/>
																<aie:id value="2972"/>
																<aie:status value="R"/>
																<aie:format value="n..11 (11,2)"/>
																<aie:pcre value="\A(?!0\.?0*\Z)(?:0|[1-9][0-9]{0,8})(?:\.[0-9]{1,2})?\Z"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:decimal">
																<xs:minInclusive value="0.01"/>
																<xs:maxInclusive value="999999999.99"/>
																<xs:totalDigits value="11"/>
																<xs:fractionDigits value="2"/>
																<xs:pattern value="(0|[1-9][0-9]{0,8})(\.[0-9]{1,2})?"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
												</xs:sequence>
											</xs:complexType>
										</xs:element>
										<xs:element name="SpecialCase" minOccurs="0" maxOccurs="9" id="PSF">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="SONDERFALLDATEN"/>
													<aie:id value="3069"/>
													<aie:status value="D"/>
												</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:sequence>
													<xs:element name="Group" minOccurs="1" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Sonderabgabengruppe (Sonderfalleingabe)"/>
																<aie:id value="3070"/>
																<aie:status value="R"/>
																<aie:format value="an2"/>
																<aie:pcre value="\A.{2}\Z"/>
																<aie:list value="A1010"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:length value="2"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="ApplicationType" minOccurs="1" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Anwendungsart"/>
																<aie:id value="3071"/>
																<aie:status value="R"/>
																<aie:format value="an2"/>
																<aie:pcre value="\A.{2}\Z"/>
																<aie:list value="A1060"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:length value="2"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="RateOrAmountOrFactor" minOccurs="0" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Satz, Betrag oder Faktor"/>
																<aie:id value="3072"/>
																<aie:status value="D"/>
																<aie:format value="n..12 (12,5)"/>
																<aie:pcre value="\A(?:0|[1-9][0-9]{0,6})(?:\.[0-9]{1,5})?\Z"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:decimal">
																<xs:minInclusive value="0.00000"/>
																<xs:maxInclusive value="9999999.99999"/>
																<xs:totalDigits value="12"/>
																<xs:fractionDigits value="5"/>
																<xs:pattern value="(0|[1-9][0-9]{0,6})(\.[0-9]{1,5})?"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
												</xs:sequence>
											</xs:complexType>
										</xs:element>
										<xs:element name="NotificationCode" minOccurs="0" maxOccurs="1" id="PMK">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="MELDUNGEN"/>
													<aie:id value="2960"/>
													<aie:status value="D"/>
												</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:sequence>
													<xs:element name="Code22Flag" minOccurs="0" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Kennzeichen Meldung Kennzahl 22 erstellt"/>
																<aie:id value="2961"/>
																<aie:status value="D"/>
																<aie:format value="an1"/>
																<aie:pcre value="\A.\Z"/>
																<aie:list value="A1622"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:length value="1"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="Code60Flag" minOccurs="0" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Kennzeichen Meldung Kennzahl 60 erstellt"/>
																<aie:id value="2962"/>
																<aie:status value="D"/>
																<aie:format value="an1"/>
																<aie:pcre value="\A.\Z"/>
																<aie:list value="A1623"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:length value="1"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="Code66Flag" minOccurs="0" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Kennzeichen Meldung Kennzahl 66 erstellt"/>
																<aie:id value="2963"/>
																<aie:status value="D"/>
																<aie:format value="an1"/>
																<aie:pcre value="\A.\Z"/>
																<aie:list value="A1624"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:length value="1"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="Code90Flag" minOccurs="0" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Kennzeichen Meldung Kennzahl 90 erstellt"/>
																<aie:id value="2964"/>
																<aie:status value="D"/>
																<aie:format value="an1"/>
																<aie:pcre value="\A.\Z"/>
																<aie:list value="A1625"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:length value="1"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
												</xs:sequence>
											</xs:complexType>
										</xs:element>
										<xs:element name="Document" minOccurs="0" maxOccurs="99" id="DC2">
											<xs:annotation>
												<xs:documentation>
													<aie:name value="UNTERLAGEN ZUR POSITION"/>
													<aie:id value="3076"/>
													<aie:status value="O"/>
												</xs:documentation>
											</xs:annotation>
											<xs:complexType>
												<xs:sequence>
													<xs:element name="Division" minOccurs="1" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Bereich der Unterlage (Position)"/>
																<aie:id value="3079"/>
																<aie:status value="R"/>
																<aie:format value="an1"/>
																<aie:pcre value="\A.\Z"/>
																<aie:list value="A1255"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:length value="1"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="Type" minOccurs="1" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Art der Unterlage (Position)"/>
																<aie:id value="3085"/>
																<aie:status value="R"/>
																<aie:format value="an4"/>
																<aie:pcre value="\A.{4}\Z"/>
																<aie:list value="I0200"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:length value="4"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="ReferenceNumber" minOccurs="0" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Nummer der Unterlage (Position)"/>
																<aie:id value="3084"/>
																<aie:status value="D"/>
																<aie:format value="an..35"/>
																<aie:pcre value="\A.{1,35}\Z"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:minLength value="1"/>
																<xs:maxLength value="35"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="IssuingDate" minOccurs="0" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Datum der Unterlage (Position)"/>
																<aie:id value="3080"/>
																<aie:status value="D"/>
																<aie:format value="Date (n8)"/>
																<aie:pcre value="\A(?:(?:(?:0[48]|[2468][048]|[13579][26])(?:[02468][048]|[13579][26])|(?:[02468][1-35-79]|[13579][013-57-9])(?:0[48]|[2468][048]|[13579][26]))-02-29|[0-9][0-9][0-9][0-9]-(?:(?:0[13578]|1[02])-(?:0[1-9]|[12][0-9]|3[01])|(?:0[469]|11)-(?:0[1-9]|[12][0-9]|30)|02-(?:0[1-9]|1[0-9]|2[0-8])))\Z"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:date">
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="AtHandFlag" minOccurs="0" maxOccurs="1">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="Kennzeichen Vorhanden"/>
																<aie:id value="3086"/>
																<aie:status value="D"/>
																<aie:format value="an1"/>
																<aie:pcre value="\A.\Z"/>
																<aie:list value="A1790"/>
															</xs:documentation>
														</xs:annotation>
														<xs:simpleType>
															<xs:restriction base="xs:token">
																<xs:length value="1"/>
															</xs:restriction>
														</xs:simpleType>
													</xs:element>
													<xs:element name="WriteOff" minOccurs="0" maxOccurs="1" id="DC3">
														<xs:annotation>
															<xs:documentation>
																<aie:name value="ANGABEN ZU ABSCHREIBUNGSMENGE/-WERT"/>
																<aie:id value="3090"/>
																<aie:status value="D"/>
															</xs:documentation>
														</xs:annotation>
														<xs:complexType>
															<xs:sequence>
																<xs:element name="Quantity" minOccurs="1" maxOccurs="1">
																	<xs:annotation>
																		<xs:documentation>
																			<aie:name value="Abschreibungsmenge/-wert"/>
																			<aie:id value="3092"/>
																			<aie:status value="R"/>
																			<aie:format value="n..12 (12,3)"/>
																			<aie:pcre value="\A(?!0\.?0*\Z)(?:0|[1-9][0-9]{0,8})(?:\.[0-9]{1,3})?\Z"/>
																		</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:decimal">
																			<xs:minInclusive value="0.001"/>
																			<xs:maxInclusive value="999999999.999"/>
																			<xs:totalDigits value="12"/>
																			<xs:fractionDigits value="3"/>
																			<xs:pattern value="(0|[1-9][0-9]{0,8})(\.[0-9]{1,3})?"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
																<xs:element name="MeasurementUnit" minOccurs="1" maxOccurs="1">
																	<xs:annotation>
																		<xs:documentation>
																			<aie:name value="Maßeinheit (Abschreibung)"/>
																			<aie:id value="3091"/>
																			<aie:status value="R"/>
																			<aie:format value="an3"/>
																			<aie:pcre value="\A.{3}\Z"/>
																			<aie:list value="I0700"/>
																		</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:token">
																			<xs:length value="3"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
																<xs:element name="Qualifier" minOccurs="0" maxOccurs="1">
																	<xs:annotation>
																		<xs:documentation>
																			<aie:name value="Qualifikator (Abschreibung)"/>
																			<aie:id value="3093"/>
																			<aie:status value="D"/>
																			<aie:format value="an1"/>
																			<aie:pcre value="\A.\Z"/>
																			<aie:list value="I0700"/>
																		</xs:documentation>
																	</xs:annotation>
																	<xs:simpleType>
																		<xs:restriction base="xs:token">
																			<xs:length value="1"/>
																		</xs:restriction>
																	</xs:simpleType>
																</xs:element>
															</xs:sequence>
														</xs:complexType>
													</xs:element>
												</xs:sequence>
											</xs:complexType>
										</xs:element>
									</xs:sequence>
								</xs:complexType>
							</xs:element>
						</xs:sequence>
					</xs:complexType>
				</xs:element>
			</xs:sequence>
		</xs:complexType>
	</xs:element>
</xs:schema>
'