/******************************************************************************************
@Author         Hamed Izadpanah
@Date           28/09/2015
@Project        Cloud Sherpas Cabinet Office Data Source
@Description    Main abstract class to hold child interfaces in the Salesforce org
*******************************************************************************************/
public abstract class ApexInterface {

	public interface Validator{
		Boolean isValid();
	}

	public interface StringValueParser{
		Object parse(String valueToParse);
	}
	
}