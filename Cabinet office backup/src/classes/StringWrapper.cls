/******************************************************************************************
@Author         Hamed Izadpanah
@Date           15/10/2015
@Project        Cloud Sherpas Cabinet Office Data Source
@Description    This is a decorator for String values,
				This classes was initially created to help with custom algorithms for String class
*******************************************************************************************/
public with sharing class StringWrapper {
	private String stringToUse;
	public StringWrapper(String stringToUse){
		this.stringToUse = stringToUse;
	}
	public List<String> split(String separator){
		List<String> returnValue = new List<String>();
		Integer startSubstringNumber = 0;
		Integer endSubstringNumber = stringToUse.indexOf(separator);
		while(endSubstringNumber != -1){
			String foundString = stringToUse.substring(startSubstringNumber, endSubstringNumber);
			returnValue.add(foundString);
			startSubstringNumber = endSubstringNumber + separator.length();
			endSubstringNumber = stringToUse.indexOf(separator, startSubstringNumber);
		}
		if(stringToUse.length() > startSubstringNumber){
			returnValue.add(stringToUse.substring(startSubstringNumber, stringToUse.length()));
		}
		return returnValue;
	}
}