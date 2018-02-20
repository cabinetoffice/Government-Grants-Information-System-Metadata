<<<<<<< HEAD
/******************************************************************************************
@Author         Hamed Izadpanah
@Date           03/10/2015
@Project        Cloud Sherpas Cabinet Office Data Source
@Description    This is the unit test for StringValueParser class
*******************************************************************************************/
@isTest
private class StringValueParserTest{
	
	@isTest
	static void testParseDate(){
		StringValueParser dateParser = new StringValueParser.StringToDate();
		Date parsedDate = (Date) dateParser.parse('23/04/2016');
		System.assertEquals(Date.newInstance(2016, 04, 23).format(), parsedDate.format());
	}
	@isTest
	static void testParseDecimal(){
		StringValueParser decimalParser = new StringValueParser.StringToDecimal();
		Decimal parsedDecimal = (Decimal) decimalParser.parse('23.25');
		System.assertEquals(23.25, parsedDecimal);
	}
	@isTest
	static void testParseBoolean(){
		StringValueParser booleanParser = new StringValueParser.StringToBoolean();
		System.assertEquals(true, (Boolean) booleanParser.parse('Y'));
		System.assertEquals(true, (Boolean) booleanParser.parse('Yes'));
		System.assertEquals(true, (Boolean) booleanParser.parse('true'));
		System.assertEquals(true, (Boolean) booleanParser.parse('1'));
		System.assertEquals(false, (Boolean) booleanParser.parse('0'));
	}
	@isTest
	static void testValidPicklistValue(){
		CSV_Upload_Mapping_Column__c mappingColumn = new CSV_Upload_Mapping_Column__c(
			SObject_Type__c = 'Account',
			Mapped_To_Field__c = 'Primary_Country__c'
		);
		StringValueParser picklistValueParser = new StringValueParser.StringToPicklistValues();
		picklistValueParser.setTargetMappingSetting(mappingColumn);
		String validCountryPicklistValue = (String) picklistValueParser.parse('united kingdom');
		System.assertEquals('United Kingdom', validCountryPicklistValue);
	}
	@isTest
	static void testInvalidPicklistValue(){
		CSV_Upload_Mapping_Column__c mappingColumn = new CSV_Upload_Mapping_Column__c(
			SObject_Type__c = 'Account',
			Mapped_To_Field__c = 'Primary_Country__c',
			Not_Found_Error_Message__c = 'Invalid Primary Country value!'
		);
		StringValueParser picklistValueParser = new StringValueParser.StringToPicklistValues();
		picklistValueParser.setTargetMappingSetting(mappingColumn);
		try{
			picklistValueParser.parse('Invalid Country Name');
			System.assert(false); // Ensures that this line never executes
		} catch(StringValueParser.InvalidInputException exceptionToHanlde){
			System.assertEquals('Invalid Primary Country value!', exceptionToHanlde.getMessage());
		}
	}
=======
<<<<<<< HEAD
/******************************************************************************************
@Author         Hamed Izadpanah
@Date           03/10/2015
@Project        Cloud Sherpas Cabinet Office Data Source
@Description    This is the unit test for StringValueParser class
*******************************************************************************************/
@isTest
private class StringValueParserTest{
	
	@isTest
	static void testParseDate(){
		StringValueParser dateParser = new StringValueParser.StringToDate();
		Date parsedDate = (Date) dateParser.parse('23/04/2016');
		System.assertEquals(Date.newInstance(2016, 04, 23).format(), parsedDate.format());
	}
	@isTest
	static void testParseDecimal(){
		StringValueParser decimalParser = new StringValueParser.StringToDecimal();
		Decimal parsedDecimal = (Decimal) decimalParser.parse('23.25');
		System.assertEquals(23.25, parsedDecimal);
	}
	@isTest
	static void testParseBoolean(){
		StringValueParser booleanParser = new StringValueParser.StringToBoolean();
		System.assertEquals(true, (Boolean) booleanParser.parse('Y'));
		System.assertEquals(true, (Boolean) booleanParser.parse('Yes'));
		System.assertEquals(true, (Boolean) booleanParser.parse('true'));
		System.assertEquals(true, (Boolean) booleanParser.parse('1'));
		System.assertEquals(false, (Boolean) booleanParser.parse('0'));
	}
	@isTest
	static void testValidPicklistValue(){
		CSV_Upload_Mapping_Column__c mappingColumn = new CSV_Upload_Mapping_Column__c(
			SObject_Type__c = 'Account',
			Mapped_To_Field__c = 'Primary_Country__c'
		);
		StringValueParser picklistValueParser = new StringValueParser.StringToPicklistValues();
		picklistValueParser.setTargetMappingSetting(mappingColumn);
		String validCountryPicklistValue = (String) picklistValueParser.parse('united kingdom');
		System.assertEquals('United Kingdom', validCountryPicklistValue);
	}
	@isTest
	static void testInvalidPicklistValue(){
		CSV_Upload_Mapping_Column__c mappingColumn = new CSV_Upload_Mapping_Column__c(
			SObject_Type__c = 'Account',
			Mapped_To_Field__c = 'Primary_Country__c',
			Not_Found_Error_Message__c = 'Invalid Primary Country value!'
		);
		StringValueParser picklistValueParser = new StringValueParser.StringToPicklistValues();
		picklistValueParser.setTargetMappingSetting(mappingColumn);
		try{
			picklistValueParser.parse('Invalid Country Name');
			System.assert(false); // Ensures that this line never executes
		} catch(StringValueParser.InvalidInputException exceptionToHanlde){
			System.assertEquals('Invalid Primary Country value!', exceptionToHanlde.getMessage());
		}
	}
=======
<<<<<<< HEAD
/******************************************************************************************
@Author         Hamed Izadpanah
@Date           03/10/2015
@Project        Cloud Sherpas Cabinet Office Data Source
@Description    This is the unit test for StringValueParser class
*******************************************************************************************/
@isTest
private class StringValueParserTest{
	
	@isTest
	static void testParseDate(){
		StringValueParser dateParser = new StringValueParser.StringToDate();
		Date parsedDate = (Date) dateParser.parse('23/04/2016');
		System.assertEquals(Date.newInstance(2016, 04, 23).format(), parsedDate.format());
	}
	@isTest
	static void testParseDecimal(){
		StringValueParser decimalParser = new StringValueParser.StringToDecimal();
		Decimal parsedDecimal = (Decimal) decimalParser.parse('23.25');
		System.assertEquals(23.25, parsedDecimal);
	}
	@isTest
	static void testParseBoolean(){
		StringValueParser booleanParser = new StringValueParser.StringToBoolean();
		System.assertEquals(true, (Boolean) booleanParser.parse('Y'));
		System.assertEquals(true, (Boolean) booleanParser.parse('Yes'));
		System.assertEquals(true, (Boolean) booleanParser.parse('true'));
		System.assertEquals(true, (Boolean) booleanParser.parse('1'));
		System.assertEquals(false, (Boolean) booleanParser.parse('0'));
	}
	@isTest
	static void testValidPicklistValue(){
		CSV_Upload_Mapping_Column__c mappingColumn = new CSV_Upload_Mapping_Column__c(
			SObject_Type__c = 'Account',
			Mapped_To_Field__c = 'Primary_Country__c'
		);
		StringValueParser picklistValueParser = new StringValueParser.StringToPicklistValues();
		picklistValueParser.setTargetMappingSetting(mappingColumn);
		String validCountryPicklistValue = (String) picklistValueParser.parse('united kingdom');
		System.assertEquals('United Kingdom', validCountryPicklistValue);
	}
	@isTest
	static void testInvalidPicklistValue(){
		CSV_Upload_Mapping_Column__c mappingColumn = new CSV_Upload_Mapping_Column__c(
			SObject_Type__c = 'Account',
			Mapped_To_Field__c = 'Primary_Country__c',
			Not_Found_Error_Message__c = 'Invalid Primary Country value!'
		);
		StringValueParser picklistValueParser = new StringValueParser.StringToPicklistValues();
		picklistValueParser.setTargetMappingSetting(mappingColumn);
		try{
			picklistValueParser.parse('Invalid Country Name');
			System.assert(false); // Ensures that this line never executes
		} catch(StringValueParser.InvalidInputException exceptionToHanlde){
			System.assertEquals('Invalid Primary Country value!', exceptionToHanlde.getMessage());
		}
	}
=======
/******************************************************************************************
@Author         Hamed Izadpanah
@Date           03/10/2015
@Project        Cloud Sherpas Cabinet Office Data Source
@Description    This is the unit test for StringValueParser class
*******************************************************************************************/
@isTest
private class StringValueParserTest{
	
	@isTest
	static void testParseDate(){
		StringValueParser dateParser = new StringValueParser.StringToDate();
		Date parsedDate = (Date) dateParser.parse('23/04/2016');
		System.assertEquals(Date.newInstance(2016, 04, 23).format(), parsedDate.format());
	}
	@isTest
	static void testParseDecimal(){
		StringValueParser decimalParser = new StringValueParser.StringToDecimal();
		Decimal parsedDecimal = (Decimal) decimalParser.parse('23.25');
		System.assertEquals(23.25, parsedDecimal);
	}
	@isTest
	static void testParseBoolean(){
		StringValueParser booleanParser = new StringValueParser.StringToBoolean();
		System.assertEquals(true, (Boolean) booleanParser.parse('Y'));
		System.assertEquals(true, (Boolean) booleanParser.parse('Yes'));
		System.assertEquals(true, (Boolean) booleanParser.parse('true'));
		System.assertEquals(true, (Boolean) booleanParser.parse('1'));
		System.assertEquals(false, (Boolean) booleanParser.parse('0'));
	}
	@isTest
	static void testValidPicklistValue(){
		CSV_Upload_Mapping_Column__c mappingColumn = new CSV_Upload_Mapping_Column__c(
			SObject_Type__c = 'Account',
			Mapped_To_Field__c = 'Primary_Country__c'
		);
		StringValueParser picklistValueParser = new StringValueParser.StringToPicklistValues();
		picklistValueParser.setTargetMappingSetting(mappingColumn);
		String validCountryPicklistValue = (String) picklistValueParser.parse('united kingdom');
		System.assertEquals('United Kingdom', validCountryPicklistValue);
	}
	@isTest
	static void testInvalidPicklistValue(){
		CSV_Upload_Mapping_Column__c mappingColumn = new CSV_Upload_Mapping_Column__c(
			SObject_Type__c = 'Account',
			Mapped_To_Field__c = 'Primary_Country__c',
			Not_Found_Error_Message__c = 'Invalid Primary Country value!'
		);
		StringValueParser picklistValueParser = new StringValueParser.StringToPicklistValues();
		picklistValueParser.setTargetMappingSetting(mappingColumn);
		try{
			picklistValueParser.parse('Invalid Country Name');
			System.assert(false); // Ensures that this line never executes
		} catch(StringValueParser.InvalidInputException exceptionToHanlde){
			System.assertEquals('Invalid Primary Country value!', exceptionToHanlde.getMessage());
		}
	}
>>>>>>> refs/remotes/origin/master
>>>>>>> branch 'master' of https://github.com/cabinetoffice/Government-Grants-Information-System-Metadata
>>>>>>> branch 'master' of https://github.com/cabinetoffice/Government-Grants-Information-System-Metadata
}