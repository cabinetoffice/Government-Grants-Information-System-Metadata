/******************************************************************************************
@Author         Hamed Izadpanah
@Date           18/02/2016
@Project        Cloud Sherpas Cabinet Office Data Source
@Description    This is the batch processor which validates the post codes value on the Grnat Award
*******************************************************************************************/
public class GrantAwardPostalCodeValidator implements Database.Batchable<sObject>, Database.AllowsCallouts, Schedulable {
	
	public Database.QueryLocator start(Database.BatchableContext BC) {
		return Database.getQueryLocator([
			SELECT Id, Recipient_Secondary_Postal_Code__c
			FROM Grant_Award__c
			WHERE Recipient_Secondary_Postal_Code__c != null
			AND Has_Postal_Code_Been_Checked__c = false
		]);
	}

	public void execute(SchedulableContext sc){
		Database.executeBatch(this, 10);
	}

   	public void execute(Database.BatchableContext BC, List<Grant_Award__c> grantAwards) {
		PostCodesIO postCodesIOInstance = new PostCodesIO();
		for(Grant_Award__c grantAwardToValidate : grantAwards){
			grantAwardToValidate.Is_Postal_Code_Valid__c = false;
			try{
				PostCodesIO.PostCodeResult postCodeDetails;
				if(Test.isRunningTest()){
					postCodeDetails = PostCodesIO.generateMockResult();
				} else {
					postCodeDetails = postCodesIOInstance.retrievePostCodeDetails(grantAwardToValidate.Recipient_Secondary_Postal_Code__c);
				}
				grantAwardToValidate.Recipient_Secondary_Postal_Code__c = postCodeDetails.postcode;
				grantAwardToValidate.Postal_Code_Region__c = postCodeDetails.region;
				grantAwardToValidate.Postal_Code_Geo_Location__Latitude__s = postCodeDetails.latitude;
				grantAwardToValidate.Postal_Code_Geo_Location__Longitude__s = postCodeDetails.longitude;
				grantAwardToValidate.Postal_Code_Parliamentary_Constituency__c = postCodeDetails.parliamentary_constituency;
				grantAwardToValidate.Postal_Code_Country__c = postCodeDetails.country;
				grantAwardToValidate.Postal_Code_European_Electoral_Region__c = postCodeDetails.european_electoral_region;
				grantAwardToValidate.Postal_Code_NHS_Health_Authority__c = postCodeDetails.nhs_ha;
				grantAwardToValidate.Postal_Code_Primary_Care_Trust__c = postCodeDetails.primary_care_trust;
				grantAwardToValidate.Postal_Code_CCG__c = postCodeDetails.ccg;
				grantAwardToValidate.Postal_Code_NUTS__c = postCodeDetails.nuts;
				grantAwardToValidate.Postal_Code_Admin_County__c = postCodeDetails.admin_county;
				grantAwardToValidate.Postal_Code_Admin_Ward__c = postCodeDetails.admin_ward;
				grantAwardToValidate.Postal_Code_Parish__c = postCodeDetails.parish;
				grantAwardToValidate.Postal_Code_Incode__c = postCodeDetails.incode;
				grantAwardToValidate.Postal_Code_Outcode__c = postCodeDetails.outcode;
				grantAwardToValidate.Is_Postal_Code_Valid__c = true;
			} catch(PostCodesIO.PostCodeNotFoundException postalCodeNotFoundException){
				grantAwardToValidate.Postal_Code_Validation_Error_Message__c = postalCodeNotFoundException.getMessage();
				grantAwardToValidate.Is_Postal_Code_Valid__c = false;
			} catch(Exception genericException){
				grantAwardToValidate.Postal_Code_Validation_Error_Message__c = 'System Error: ' + genericException.getMessage() + ' \n Stack Trace: ' + genericException.getStackTraceString();
				grantAwardToValidate.Is_Postal_Code_Valid__c = false;
			}
			grantAwardToValidate.Has_Postal_Code_Been_Checked__c = true;
		}
		update grantAwards;
	}
	
	public void finish(Database.BatchableContext BC) {
		
	}
	
}