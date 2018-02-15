/******************************************************************************************
@Author         Hamed Izadpanah
@Date           15/10/2015
@Project        Cloud Sherpas Cabinet Office Data Source
@Description    This is the unit test for StringWrapper class
*******************************************************************************************/
@isTest
private class StringWrapperTest{
	
	@isTest
	static void testValidSplit(){
		String SEPERATOR_VALUE = '\r\n';
		Integer VALUES_COUNT_TO_CREATE = 5000;
		List<String> valuesToJoin = new List<String>();
		for(Integer i = 0; i < VALUES_COUNT_TO_CREATE; i++){
			valuesToJoin.add('Value ' + String.valueOf(i));
		}
		String stringToSplit = String.join(valuesToJoin, SEPERATOR_VALUE);
		StringWrapper stringWrapperToUse = new StringWrapper(stringToSplit);
		LisT<String> splitedValues = stringWrapperToUse.split(SEPERATOR_VALUE);
		System.assertEquals(VALUES_COUNT_TO_CREATE, splitedValues.size());
		for(Integer i = 0; i < splitedValues.size(); i++){
			System.assertEquals('Value ' + String.valueOf(i), splitedValues[i]);
		}
	}
}