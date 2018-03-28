@isTest
private class CSV_UploadNewControllerTest{

	private static testMethod void testUploadOrgnisation() {
    	CSV_Upload__c CSVtest = new CSV_Upload__c();
        CSVUploadNewController CSVUpload = new CSVUploadNewController(new ApexPages.StandardController(CSVtest));
        StaticResource StaticCSV = [SELECT Name, Body FROM StaticResource WHERE Name = 'Test_CSV_Create_Organisation'];
        Blob CSVblob = StaticCSV.body;
        CSVUpload.csvContent = CSVblob;
        CSVUpload.upload();
	}
    private static testMethod void testAmendOrgnisation() {
    	CSV_Upload__c CSVtest = new CSV_Upload__c();
        CSVUploadNewController CSVUpload = new CSVUploadNewController(new ApexPages.StandardController(CSVtest));
        StaticResource StaticCSV = [SELECT Name, Body FROM StaticResource WHERE Name = 'Test_CSV_Amend_Organisation'];
        Blob CSVblob = StaticCSV.body;
        CSVUpload.csvContent = CSVblob;
        CSVUpload.upload();
	}
	private static testMethod void testCreateIndividual() {
    	CSV_Upload__c CSVtest = new CSV_Upload__c();
        CSVUploadNewController CSVUpload = new CSVUploadNewController(new ApexPages.StandardController(CSVtest));
        StaticResource StaticCSV = [SELECT Name, Body FROM StaticResource WHERE Name = 'Test_CSV_Create_Individual'];
        Blob CSVblob = StaticCSV.body;
        CSVUpload.csvContent = CSVblob;
        CSVUpload.upload();
	}
		private static testMethod void testAmendIndividual() {
    	CSV_Upload__c CSVtest = new CSV_Upload__c();
        CSVUploadNewController CSVUpload = new CSVUploadNewController(new ApexPages.StandardController(CSVtest));
        StaticResource StaticCSV = [SELECT Name, Body FROM StaticResource WHERE Name = 'Test_CSV_Amend_Individual'];
        Blob CSVblob = StaticCSV.body;
        CSVUpload.csvContent = CSVblob;
        CSVUpload.upload();
	}
}