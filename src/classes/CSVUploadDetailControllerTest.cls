<<<<<<< HEAD
/******************************************************************************************
@Author         Hamed Izadpanah
@Date           03/10/2015
@Project        Cloud Sherpas Cabinet Office Data Source
@Description    This is the unit test for CSV Upload detailed/view page controller
*******************************************************************************************/
@isTest
private class CSVUploadDetailControllerTest{
	
	static CSV_Upload__c csvUploadToUse;
	static ApexPages.StandardController stndController;
	static CSVUploadDetailController controller;
	static void initData(){
		if(csvUploadToUse == null){
			csvUploadToUse = new CSV_Upload__c(
				Type__c = Constant.CSV_UPLOAD_CREATE_AWARD_TYPE,
				RecordTypeId = CSV_Upload__c.SObjectType.getDescribe().getRecordTypeInfosByName().get(Constant.CSV_UPLOAD_GRANT_AWARD_RT_NAME).getRecordTypeId()
			);
		}
		stndController = new ApexPages.StandardController(csvUploadToUse);
		controller = new CSVUploadDetailController(stndController);
	}

	@isTest
	static void testNewCSVUploadRedirect(){
		initData();
		PageReference returnedPageReference = controller.checkCSVUploadRecord();
		System.assertEquals(Page.CSVUploadNew.getUrl(), returnedPageReference.getUrl());
	}
	@isTest
	static void testExistingCSVUploadRedirect(){
		csvUploadToUse = new CSV_Upload__c(
			Type__c = Constant.CSV_UPLOAD_CREATE_AWARD_TYPE,
			RecordTypeId = CSV_Upload__c.SObjectType.getDescribe().getRecordTypeInfosByName().get(Constant.CSV_UPLOAD_GRANT_AWARD_RT_NAME).getRecordTypeId(),
			Apex_Batch_Id__c = 'a0126000000aFH4'
		);
		insert csvUploadToUse;
		initData();
		System.assertEquals(null, controller.checkCSVUploadRecord());
	}
	@isTest
	static void testGetRelatedAttachments(){
		csvUploadToUse = new CSV_Upload__c(
			Type__c = Constant.CSV_UPLOAD_CREATE_AWARD_TYPE,
			RecordTypeId = CSV_Upload__c.SObjectType.getDescribe().getRecordTypeInfosByName().get(Constant.CSV_UPLOAD_GRANT_AWARD_RT_NAME).getRecordTypeId(),
			Apex_Batch_Id__c = 'a0126000000aFH4'
		);
		insert csvUploadToUse;
		insert new Attachment(
			Name = 'file.csv',
			Body = Blob.valueOf('test1,test2,test3'),
			ParentId = csvUploadToUse.Id
		);
		initData();
		System.assertEquals(1, controller.getRelatedAttachments().size());
	}
	@isTest
	static void testGetJobItemsProcessed(){
		initData();
		System.assertEquals(100, controller.getJobItemsProcessed());
	}
	@isTest
	static void testGetTotalJobItems(){
		initData();
		System.assertEquals(100, controller.getTotalJobItems());
	}
	@isTest
	static void testReset(){
		initData();
		try{
			controller.reset();
			System.assert(false); // This line should never fire
		}catch(System.SObjectException exceptionToHandle){
			System.assertEquals('You cannot call reset when the data is being passed into the controller by the caller.', exceptionToHandle.getMessage());
		}
	}
=======
<<<<<<< HEAD
/******************************************************************************************
@Author         Hamed Izadpanah
@Date           03/10/2015
@Project        Cloud Sherpas Cabinet Office Data Source
@Description    This is the unit test for CSV Upload detailed/view page controller
*******************************************************************************************/
@isTest
private class CSVUploadDetailControllerTest{
	
	static CSV_Upload__c csvUploadToUse;
	static ApexPages.StandardController stndController;
	static CSVUploadDetailController controller;
	static void initData(){
		if(csvUploadToUse == null){
			csvUploadToUse = new CSV_Upload__c(
				Type__c = Constant.CSV_UPLOAD_CREATE_AWARD_TYPE,
				RecordTypeId = CSV_Upload__c.SObjectType.getDescribe().getRecordTypeInfosByName().get(Constant.CSV_UPLOAD_GRANT_AWARD_RT_NAME).getRecordTypeId()
			);
		}
		stndController = new ApexPages.StandardController(csvUploadToUse);
		controller = new CSVUploadDetailController(stndController);
	}

	@isTest
	static void testNewCSVUploadRedirect(){
		initData();
		PageReference returnedPageReference = controller.checkCSVUploadRecord();
		System.assertEquals(Page.CSVUploadNew.getUrl(), returnedPageReference.getUrl());
	}
	@isTest
	static void testExistingCSVUploadRedirect(){
		csvUploadToUse = new CSV_Upload__c(
			Type__c = Constant.CSV_UPLOAD_CREATE_AWARD_TYPE,
			RecordTypeId = CSV_Upload__c.SObjectType.getDescribe().getRecordTypeInfosByName().get(Constant.CSV_UPLOAD_GRANT_AWARD_RT_NAME).getRecordTypeId(),
			Apex_Batch_Id__c = 'a0126000000aFH4'
		);
		insert csvUploadToUse;
		initData();
		System.assertEquals(null, controller.checkCSVUploadRecord());
	}
	@isTest
	static void testGetRelatedAttachments(){
		csvUploadToUse = new CSV_Upload__c(
			Type__c = Constant.CSV_UPLOAD_CREATE_AWARD_TYPE,
			RecordTypeId = CSV_Upload__c.SObjectType.getDescribe().getRecordTypeInfosByName().get(Constant.CSV_UPLOAD_GRANT_AWARD_RT_NAME).getRecordTypeId(),
			Apex_Batch_Id__c = 'a0126000000aFH4'
		);
		insert csvUploadToUse;
		insert new Attachment(
			Name = 'file.csv',
			Body = Blob.valueOf('test1,test2,test3'),
			ParentId = csvUploadToUse.Id
		);
		initData();
		System.assertEquals(1, controller.getRelatedAttachments().size());
	}
	@isTest
	static void testGetJobItemsProcessed(){
		initData();
		System.assertEquals(100, controller.getJobItemsProcessed());
	}
	@isTest
	static void testGetTotalJobItems(){
		initData();
		System.assertEquals(100, controller.getTotalJobItems());
	}
	@isTest
	static void testReset(){
		initData();
		try{
			controller.reset();
			System.assert(false); // This line should never fire
		}catch(System.SObjectException exceptionToHandle){
			System.assertEquals('You cannot call reset when the data is being passed into the controller by the caller.', exceptionToHandle.getMessage());
		}
	}
=======
<<<<<<< HEAD
/******************************************************************************************
@Author         Hamed Izadpanah
@Date           03/10/2015
@Project        Cloud Sherpas Cabinet Office Data Source
@Description    This is the unit test for CSV Upload detailed/view page controller
*******************************************************************************************/
@isTest
private class CSVUploadDetailControllerTest{
	
	static CSV_Upload__c csvUploadToUse;
	static ApexPages.StandardController stndController;
	static CSVUploadDetailController controller;
	static void initData(){
		if(csvUploadToUse == null){
			csvUploadToUse = new CSV_Upload__c(
				Type__c = Constant.CSV_UPLOAD_CREATE_AWARD_TYPE,
				RecordTypeId = CSV_Upload__c.SObjectType.getDescribe().getRecordTypeInfosByName().get(Constant.CSV_UPLOAD_GRANT_AWARD_RT_NAME).getRecordTypeId()
			);
		}
		stndController = new ApexPages.StandardController(csvUploadToUse);
		controller = new CSVUploadDetailController(stndController);
	}

	@isTest
	static void testNewCSVUploadRedirect(){
		initData();
		PageReference returnedPageReference = controller.checkCSVUploadRecord();
		System.assertEquals(Page.CSVUploadNew.getUrl(), returnedPageReference.getUrl());
	}
	@isTest
	static void testExistingCSVUploadRedirect(){
		csvUploadToUse = new CSV_Upload__c(
			Type__c = Constant.CSV_UPLOAD_CREATE_AWARD_TYPE,
			RecordTypeId = CSV_Upload__c.SObjectType.getDescribe().getRecordTypeInfosByName().get(Constant.CSV_UPLOAD_GRANT_AWARD_RT_NAME).getRecordTypeId(),
			Apex_Batch_Id__c = 'a0126000000aFH4'
		);
		insert csvUploadToUse;
		initData();
		System.assertEquals(null, controller.checkCSVUploadRecord());
	}
	@isTest
	static void testGetRelatedAttachments(){
		csvUploadToUse = new CSV_Upload__c(
			Type__c = Constant.CSV_UPLOAD_CREATE_AWARD_TYPE,
			RecordTypeId = CSV_Upload__c.SObjectType.getDescribe().getRecordTypeInfosByName().get(Constant.CSV_UPLOAD_GRANT_AWARD_RT_NAME).getRecordTypeId(),
			Apex_Batch_Id__c = 'a0126000000aFH4'
		);
		insert csvUploadToUse;
		insert new Attachment(
			Name = 'file.csv',
			Body = Blob.valueOf('test1,test2,test3'),
			ParentId = csvUploadToUse.Id
		);
		initData();
		System.assertEquals(1, controller.getRelatedAttachments().size());
	}
	@isTest
	static void testGetJobItemsProcessed(){
		initData();
		System.assertEquals(100, controller.getJobItemsProcessed());
	}
	@isTest
	static void testGetTotalJobItems(){
		initData();
		System.assertEquals(100, controller.getTotalJobItems());
	}
	@isTest
	static void testReset(){
		initData();
		try{
			controller.reset();
			System.assert(false); // This line should never fire
		}catch(System.SObjectException exceptionToHandle){
			System.assertEquals('You cannot call reset when the data is being passed into the controller by the caller.', exceptionToHandle.getMessage());
		}
	}
=======
<<<<<<< HEAD
/******************************************************************************************
@Author         Hamed Izadpanah
@Date           03/10/2015
@Project        Cloud Sherpas Cabinet Office Data Source
@Description    This is the unit test for CSV Upload detailed/view page controller
*******************************************************************************************/
@isTest
private class CSVUploadDetailControllerTest{
	
	static CSV_Upload__c csvUploadToUse;
	static ApexPages.StandardController stndController;
	static CSVUploadDetailController controller;
	static void initData(){
		if(csvUploadToUse == null){
			csvUploadToUse = new CSV_Upload__c(
				Type__c = Constant.CSV_UPLOAD_CREATE_AWARD_TYPE,
				RecordTypeId = CSV_Upload__c.SObjectType.getDescribe().getRecordTypeInfosByName().get(Constant.CSV_UPLOAD_GRANT_AWARD_RT_NAME).getRecordTypeId()
			);
		}
		stndController = new ApexPages.StandardController(csvUploadToUse);
		controller = new CSVUploadDetailController(stndController);
	}

	@isTest
	static void testNewCSVUploadRedirect(){
		initData();
		PageReference returnedPageReference = controller.checkCSVUploadRecord();
		System.assertEquals(Page.CSVUploadNew.getUrl(), returnedPageReference.getUrl());
	}
	@isTest
	static void testExistingCSVUploadRedirect(){
		csvUploadToUse = new CSV_Upload__c(
			Type__c = Constant.CSV_UPLOAD_CREATE_AWARD_TYPE,
			RecordTypeId = CSV_Upload__c.SObjectType.getDescribe().getRecordTypeInfosByName().get(Constant.CSV_UPLOAD_GRANT_AWARD_RT_NAME).getRecordTypeId(),
			Apex_Batch_Id__c = 'a0126000000aFH4'
		);
		insert csvUploadToUse;
		initData();
		System.assertEquals(null, controller.checkCSVUploadRecord());
	}
	@isTest
	static void testGetRelatedAttachments(){
		csvUploadToUse = new CSV_Upload__c(
			Type__c = Constant.CSV_UPLOAD_CREATE_AWARD_TYPE,
			RecordTypeId = CSV_Upload__c.SObjectType.getDescribe().getRecordTypeInfosByName().get(Constant.CSV_UPLOAD_GRANT_AWARD_RT_NAME).getRecordTypeId(),
			Apex_Batch_Id__c = 'a0126000000aFH4'
		);
		insert csvUploadToUse;
		insert new Attachment(
			Name = 'file.csv',
			Body = Blob.valueOf('test1,test2,test3'),
			ParentId = csvUploadToUse.Id
		);
		initData();
		System.assertEquals(1, controller.getRelatedAttachments().size());
	}
	@isTest
	static void testGetJobItemsProcessed(){
		initData();
		System.assertEquals(100, controller.getJobItemsProcessed());
	}
	@isTest
	static void testGetTotalJobItems(){
		initData();
		System.assertEquals(100, controller.getTotalJobItems());
	}
	@isTest
	static void testReset(){
		initData();
		try{
			controller.reset();
			System.assert(false); // This line should never fire
		}catch(System.SObjectException exceptionToHandle){
			System.assertEquals('You cannot call reset when the data is being passed into the controller by the caller.', exceptionToHandle.getMessage());
		}
	}
=======
/******************************************************************************************
@Author         Hamed Izadpanah
@Date           03/10/2015
@Project        Cloud Sherpas Cabinet Office Data Source
@Description    This is the unit test for CSV Upload detailed/view page controller
*******************************************************************************************/
@isTest
private class CSVUploadDetailControllerTest{
	
	static CSV_Upload__c csvUploadToUse;
	static ApexPages.StandardController stndController;
	static CSVUploadDetailController controller;
	static void initData(){
		if(csvUploadToUse == null){
			csvUploadToUse = new CSV_Upload__c(
				Type__c = Constant.CSV_UPLOAD_CREATE_AWARD_TYPE,
				RecordTypeId = CSV_Upload__c.SObjectType.getDescribe().getRecordTypeInfosByName().get(Constant.CSV_UPLOAD_GRANT_AWARD_RT_NAME).getRecordTypeId()
			);
		}
		stndController = new ApexPages.StandardController(csvUploadToUse);
		controller = new CSVUploadDetailController(stndController);
	}

	@isTest
	static void testNewCSVUploadRedirect(){
		initData();
		PageReference returnedPageReference = controller.checkCSVUploadRecord();
		System.assertEquals(Page.CSVUploadNew.getUrl(), returnedPageReference.getUrl());
	}
	@isTest
	static void testExistingCSVUploadRedirect(){
		csvUploadToUse = new CSV_Upload__c(
			Type__c = Constant.CSV_UPLOAD_CREATE_AWARD_TYPE,
			RecordTypeId = CSV_Upload__c.SObjectType.getDescribe().getRecordTypeInfosByName().get(Constant.CSV_UPLOAD_GRANT_AWARD_RT_NAME).getRecordTypeId(),
			Apex_Batch_Id__c = 'a0126000000aFH4'
		);
		insert csvUploadToUse;
		initData();
		System.assertEquals(null, controller.checkCSVUploadRecord());
	}
	@isTest
	static void testGetRelatedAttachments(){
		csvUploadToUse = new CSV_Upload__c(
			Type__c = Constant.CSV_UPLOAD_CREATE_AWARD_TYPE,
			RecordTypeId = CSV_Upload__c.SObjectType.getDescribe().getRecordTypeInfosByName().get(Constant.CSV_UPLOAD_GRANT_AWARD_RT_NAME).getRecordTypeId(),
			Apex_Batch_Id__c = 'a0126000000aFH4'
		);
		insert csvUploadToUse;
		insert new Attachment(
			Name = 'file.csv',
			Body = Blob.valueOf('test1,test2,test3'),
			ParentId = csvUploadToUse.Id
		);
		initData();
		System.assertEquals(1, controller.getRelatedAttachments().size());
	}
	@isTest
	static void testGetJobItemsProcessed(){
		initData();
		System.assertEquals(100, controller.getJobItemsProcessed());
	}
	@isTest
	static void testGetTotalJobItems(){
		initData();
		System.assertEquals(100, controller.getTotalJobItems());
	}
	@isTest
	static void testReset(){
		initData();
		try{
			controller.reset();
			System.assert(false); // This line should never fire
		}catch(System.SObjectException exceptionToHandle){
			System.assertEquals('You cannot call reset when the data is being passed into the controller by the caller.', exceptionToHandle.getMessage());
		}
	}
>>>>>>> refs/remotes/origin/master
>>>>>>> branch 'master' of https://github.com/cabinetoffice/Government-Grants-Information-System-Metadata
>>>>>>> branch 'master' of https://github.com/cabinetoffice/Government-Grants-Information-System-Metadata
>>>>>>> branch 'master' of https://github.com/cabinetoffice/Government-Grants-Information-System-Metadata
}