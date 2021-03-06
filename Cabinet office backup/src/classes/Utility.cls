/******************************************************************************************
@Author         Hamed Izadpanah
@Date           03/10/2015
@Project        Cloud Sherpas Cabinet Office Data Source
@Description    This is the generic system utility class for mostly used logic in Salesforce
*******************************************************************************************/
public with sharing class Utility {
	public static void addMessageToPage(ApexPages.Severity sevirity, String messageToShow){
		ApexPages.addMessage(
			new ApexPages.Message(
				sevirity,
				messageToShow
			)
		);
	}
}