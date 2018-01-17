/******************************************************************************************
@Author         Hamed Izadpanah
@Date           03/10/2015
@Project        Cloud Sherpas Cabinet Office Data Source
@Description    This is a test class for the FieldSetWrapper class
*******************************************************************************************/
@isTest
private class FieldSetWrapperTest{
	@isTest
	static void testHasFieldTrue(){
		FieldSetWrapper wrapper = new FieldSetWrapper(SObjectType.Account.FieldSets.External_Ids_for_CSV_upload);
		System.assertEquals(true, wrapper.hasFieldByLabel('VAT Reg no'));
	}
	@isTest
	static void testHasFieldFalse(){
		FieldSetWrapper wrapper = new FieldSetWrapper(SObjectType.Account.FieldSets.External_Ids_for_CSV_upload);
		System.assertEquals(false, wrapper.hasFieldByLabel('SomeInvalidField'));
	}
}