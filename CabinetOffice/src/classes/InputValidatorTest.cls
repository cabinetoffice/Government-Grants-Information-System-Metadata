@isTest
private class InputValidatorTest {
	@isTest
	static void testValidCSVExtensionValidator(){
		InputValidator.CSVExtensionValidator extensionValidator = new InputValidator.CSVExtensionValidator('somefile.csv');
		System.assertEquals(true, extensionValidator.isValid());
	}
	@isTest
	static void testInvalidCSVExtensionValidator(){
		InputValidator.CSVExtensionValidator extensionValidator = new InputValidator.CSVExtensionValidator('somefile.xsl');
		System.assertEquals(false, extensionValidator.isValid());
		System.assertEquals(1, extensionValidator.getErrorMessages().size());
		System.assertEquals(Label.CSV_Upload_Invalid_File_Extension_Error_Message, extensionValidator.getErrorMessages()[0]);
	}
}