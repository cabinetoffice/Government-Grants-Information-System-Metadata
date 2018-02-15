/******************************************************************************************
@Author         Hamed Izadpanah
@Date           03/10/2015
@Project        Cloud Sherpas Cabinet Office Data Source
@Description    This is the unit test for CSV Upload create/edit page controller
*******************************************************************************************/
<<<<<<< HEAD
//This class has been replaced with CSV_UploadNewControllerTest
@isTest
private class CSVUploadNewControllerTest{
	@testSetup()
	private static void setupTestData(){
		/**
		insert new CoA_L5__c(
			Name = TestDataFactory.TEST_CCOA_CODE
		);
		TestDataFactory testFactory = new TestDataFactory();
		insert testFactory.createDefaultCSVColumnMappingItems();
		COFOG_L2__c newCOFOG = new COFOG_L2__c(
			Name = '123',
			COFOG_L2_Long_Name__c = 'RT'
		);
		insert newCOFOG;
		Account funderAccount = testFactory.createAccount('New Funder', 'FUN123');
		Account testDepartment = testFactory.createAccount('My New Department', 'DEP123');
		insert new List<Account>{funderAccount, testDepartment};
		
		Grant_Scheme__c newGrantScheme = testFactory.createGrantScheme(funderAccount, 'New Scheme', newCOFOG);
		newGrantScheme.Scheme_Reference_No__c = 'MySchemeRefNumber';
		insert newGrantScheme;
	}

	static Account testDepartment;
	static CSVUploadMapping grantAwardMapping;
	private static CSV_Upload__c newUploadProcess;
	private static ApexPages.StandardController stndController;
	private static CSVUploadNewController controller;

	static void initData(){
		TestDataFactory testFactory = new TestDataFactory();
		CSV_Upload__c grantAwardCsvUpload = testFactory.createOrganisationGrantAwardCSVUpload(Constant.CSV_UPLOAD_CREATE_AWARD_TYPE);
		grantAwardMapping = new CSVUploadMapping(grantAwardCsvUpload);
		testDepartment = [SELECT Id FROM Account WHERE CPID_from_OSCAR__c = 'DEP123' LIMIT 1][0];

		newUploadProcess = testFactory.createOrganisationGrantAwardCSVUpload(Constant.CSV_UPLOAD_CREATE_AWARD_TYPE);
		stndController = new ApexPages.StandardController(newUploadProcess);
		controller = new CSVUploadNewController(stndController);
		**/
	}


	@isTest
	static void testNullAttachmentBodyError(){
	    /**
		initData();
		System.assertEquals(0, ApexPages.getMessages().size());
		controller.validate();
		System.assertEquals(1, ApexPages.getMessages().size());
		System.assertEquals('Uploaded file cannot be null. Please select a file and try again.', ApexPages.getMessages()[0].getDetail());
		**/
	}
	@isTest
	static void testNullAttachmentNameError(){
	    /**
		initData();
		System.assertEquals(0, ApexPages.getMessages().size());
		controller.csvContent = Blob.valueOf('Header1,Header2,Header3\n');
		controller.validate();
		System.assertEquals(2, ApexPages.getMessages().size());
		System.assertEquals('Required fields are missing: [Name]', ApexPages.getMessages()[0].getDetail());
		System.assertEquals('Please choose a file with a name.', ApexPages.getMessages()[1].getDetail());
		**/
	}

	@isTest
	static void testChangeFileAction(){
	    /**
		initData();
		controller.fileName = 'File To Upload.csv';
		controller.changeFile();
		System.assertEquals(null, controller.fileName);
		**/
	}

	@isTest
	static void testAttachmentWithBadColumnsError(){
	    /**
		initData();
		System.assertEquals(0, ApexPages.getMessages().size());
		controller.fileName = 'File To Upload.csv';
		controller.csvContent = Blob.valueOf('Header1,Header2,Header3\n');
		controller.validate();
		System.assertEquals(1, ApexPages.getMessages().size());
		String EXPECTED_ERROR_MESSAGE = Label.Required_Fields_Missing_Error_Message.replaceAll(Constant.ERR_MSG_TEMP_REQ_FIELDS_MISSING, 'Allocation Method');
		System.assertEquals(EXPECTED_ERROR_MESSAGE, ApexPages.getMessages()[0].getDetail());
		**/
	}
	@isTest
	static void testAttachmentWithValidColumns(){
	    /**
		initData();
		TestDataFactory testFactory = new TestDataFactory();
		List<List<String>> allGrantAwardData = testFactory.createDefaultGrantAwardDataParsedCSV();
		CSVDocument documentToUpload = new CSVDocument(allGrantAwardData);
		System.assertEquals(0, ApexPages.getMessages().size());
		controller.fileName = 'File To Upload.csv';
		controller.csvContent = Blob.valueOf(documentToUpload.convertToString());
		controller.validate();
		System.assertEquals(1, ApexPages.getMessages().size());
		System.assertEquals('Upload will contain 1 record(s).', ApexPages.getMessages()[0].getDetail());
		**/
	}

	@isTest
	static void testNewCSVUploadRedirect(){
	    /**
		initData();
		System.assertEquals(null, controller.checkCSVUploadRecord());
		**/
	}

	@isTest
	static void testExistingCSVUploadRedirect(){
	    /**
		initData();
		newUploadProcess.Apex_Batch_Id__c = 'a0126000000aFH4';
		insert newUploadProcess;
		stndController = new ApexPages.StandardController(newUploadProcess);
		controller = new CSVUploadNewController(stndController);
		System.assertEquals(stndController.view().getUrl(), controller.checkCSVUploadRecord().getUrl());
		**/
	}



	@isTest
	static void testUploadWithoutValidate(){
	    /**
		initData();
		System.assertEquals(0, ApexPages.getMessages().size());
		controller.upload();
		System.assertEquals(1, ApexPages.getMessages().size());
		System.assertEquals('Uploaded file cannot be null. Please select a file and try again.', ApexPages.getMessages()[0].getDetail());
		**/
	}
	@isTest
	static void testGetAvailableTypeOptions(){
	   /**
		initData();
		System.assertEquals(false, controller.getAvailableTypeOptions().isEmpty());
		**/
	}

	@isTest
	static void testUploadProcess(){
	    /**
		initData();
		TestDataFactory testFactory = new TestDataFactory();
		List<List<String>> allGrantAwardData = testFactory.createDefaultGrantAwardDataParsedCSV();
		CSVDocument documentToUpload = new CSVDocument(allGrantAwardData);
		controller.fileName = 'File To Upload.csv';
		controller.csvContent = Blob.valueOf(documentToUpload.convertToString());
		controller.validate();
		System.assertEquals(1, ApexPages.getMessages().size());
		Test.startTest();
			PageReference uploadReturnPageReference = controller.upload();
		Test.stopTest();
		System.assertNotEquals(null, controller.csvUploadToUse.Id);
		System.assertEquals(1, ApexPages.getMessages().size());
		System.assertEquals('Upload will contain 1 record(s).', ApexPages.getMessages()[0].getDetail());
		System.assertNotEquals(null, uploadReturnPageReference);
		System.assertEquals(controller.csvUploadToUse.Id, uploadReturnPageReference.getParameters().get('id'));
		PageReference CSV_UPLOAD_DETAIL_PAGE = Page.CSVUploadDetail;
		CSV_UPLOAD_DETAIL_PAGE.getParameters().put('id', controller.csvUploadToUse.Id);
		System.assertEquals(CSV_UPLOAD_DETAIL_PAGE.getUrl(), uploadReturnPageReference.getUrl());
		**/
	}

	@isTest
	static void testGetIsReadyForFileUpload(){
	    /**
		initData();
		newUploadProcess.Type__c = null;
		newUploadProcess.Recipient_Type__c = null;
		System.assertEquals(false, controller.getIsReadyForFileUpload());

		newUploadProcess.Type__c = 'Create Awards';
		System.assertEquals(false, controller.getIsReadyForFileUpload());
		newUploadProcess.Type__c = 'Amend Awards';
		System.assertEquals(false, controller.getIsReadyForFileUpload());
		newUploadProcess.Type__c = 'Upload Awards Evaluations';
		System.assertEquals(true, controller.getIsReadyForFileUpload());
		newUploadProcess.Type__c = 'Upload Awards Payments';
		System.assertEquals(true, controller.getIsReadyForFileUpload());
		
		newUploadProcess.Type__c = 'Create Awards';
		System.assertEquals(false, controller.getIsReadyForFileUpload());
		newUploadProcess.Recipient_Type__c = 'Individual';
		System.assertEquals(true, controller.getIsReadyForFileUpload());
		newUploadProcess.Type__c = 'Amend Awards';
		System.assertEquals(true, controller.getIsReadyForFileUpload());
		**/
	}
	@isTest
	static void testGetCSVTemplatePath(){
	    /**
		String EMPTH_PATH = '';
		initData();
		newUploadProcess.Type__c = null;
		newUploadProcess.Recipient_Type__c = null;
		System.assertEquals(EMPTH_PATH, controller.getCSVTemplatePath());

		newUploadProcess.Type__c = 'Create Awards';
		System.assertNotEquals(EMPTH_PATH, controller.getCSVTemplatePath());
		newUploadProcess.Type__c = 'Amend Awards';
		System.assertNotEquals(EMPTH_PATH, controller.getCSVTemplatePath());
		newUploadProcess.Type__c = 'Upload Awards Evaluations';
		System.assertNotEquals(EMPTH_PATH, controller.getCSVTemplatePath());
		newUploadProcess.Type__c = 'Upload Awards Payments';
		System.assertNotEquals(EMPTH_PATH, controller.getCSVTemplatePath());
		
		newUploadProcess.Type__c = 'Create Awards';
		System.assertNotEquals(EMPTH_PATH, controller.getCSVTemplatePath());
		newUploadProcess.Recipient_Type__c = 'Individual';
		System.assertNotEquals(EMPTH_PATH, controller.getCSVTemplatePath());
		newUploadProcess.Type__c = 'Amend Awards';
		System.assertNotEquals(EMPTH_PATH, controller.getCSVTemplatePath());
		**/
	}
	@isTest
	static void testGetRecordtypeNeedsRecipientType(){
	    /**
		initData();
		newUploadProcess.Type__c = null;
		System.assertEquals(false, controller.getRecordtypeNeedsRecipientType());

		newUploadProcess.Type__c = 'Create Awards';
		System.assertEquals(true, controller.getRecordtypeNeedsRecipientType());

		newUploadProcess.Type__c = 'Amend Awards';
		System.assertEquals(true, controller.getRecordtypeNeedsRecipientType());

		newUploadProcess.Type__c = 'Upload Awards Evaluations';
		System.assertEquals(false, controller.getRecordtypeNeedsRecipientType());
		newUploadProcess.Type__c = 'Upload Awards Payments';
		System.assertEquals(false, controller.getRecordtypeNeedsRecipientType());
		**/
	}
	
=======
@isTest
private class CSVUploadNewControllerTest{
	
	@testSetup()
	private static void setupTestData(){
		
		insert new CoA_L5__c(
			Name = TestDataFactory.TEST_CCOA_CODE
		);
		TestDataFactory testFactory = new TestDataFactory();
		insert testFactory.createDefaultCSVColumnMappingItems();
		COFOG_L2__c newCOFOG = new COFOG_L2__c(
			Name = '123',
			COFOG_L2_Long_Name__c = 'RT'
		);
		insert newCOFOG;
		Account funderAccount = testFactory.createAccount('New Funder', 'FUN123');
		Account testDepartment = testFactory.createAccount('My New Department', 'DEP123');
		insert new List<Account>{funderAccount, testDepartment};
		
		Grant_Scheme__c newGrantScheme = testFactory.createGrantScheme(funderAccount, 'New Scheme', newCOFOG);
		newGrantScheme.Scheme_Reference_No__c = 'MySchemeRefNumber';
		insert newGrantScheme;
	}

	static Account testDepartment;
	static CSVUploadMapping grantAwardMapping;
	private static CSV_Upload__c newUploadProcess;
	private static ApexPages.StandardController stndController;
	private static CSVUploadNewController controller;

	static void initData(){
		TestDataFactory testFactory = new TestDataFactory();
		CSV_Upload__c grantAwardCsvUpload = testFactory.createOrganisationGrantAwardCSVUpload(Constant.CSV_UPLOAD_CREATE_AWARD_TYPE);
		grantAwardMapping = new CSVUploadMapping(grantAwardCsvUpload);
		testDepartment = [SELECT Id FROM Account WHERE CPID_from_OSCAR__c = 'DEP123' LIMIT 1][0];

		newUploadProcess = testFactory.createOrganisationGrantAwardCSVUpload(Constant.CSV_UPLOAD_CREATE_AWARD_TYPE);
		stndController = new ApexPages.StandardController(newUploadProcess);
		controller = new CSVUploadNewController(stndController);
	}


	@isTest
	static void testNullAttachmentBodyError(){
		initData();
		System.assertEquals(0, ApexPages.getMessages().size());
		controller.validate();
		System.assertEquals(1, ApexPages.getMessages().size());
		System.assertEquals('Uploaded file cannot be null. Please select a file and try again.', ApexPages.getMessages()[0].getDetail());
	}
	@isTest
	static void testNullAttachmentNameError(){
		initData();
		System.assertEquals(0, ApexPages.getMessages().size());
		controller.csvContent = Blob.valueOf('Header1,Header2,Header3\n');
		controller.validate();
		System.assertEquals(2, ApexPages.getMessages().size());
		System.assertEquals('Required fields are missing: [Name]', ApexPages.getMessages()[0].getDetail());
		System.assertEquals('Please choose a file with a name.', ApexPages.getMessages()[1].getDetail());
	}

	@isTest
	static void testChangeFileAction(){
		initData();
		controller.fileName = 'File To Upload.csv';
		controller.changeFile();
		System.assertEquals(null, controller.fileName);
	}

	@isTest
	static void testAttachmentWithBadColumnsError(){
		initData();
		System.assertEquals(0, ApexPages.getMessages().size());
		controller.fileName = 'File To Upload.csv';
		controller.csvContent = Blob.valueOf('Header1,Header2,Header3\n');
		controller.validate();
		System.assertEquals(1, ApexPages.getMessages().size());
		String EXPECTED_ERROR_MESSAGE = Label.Required_Fields_Missing_Error_Message.replaceAll(Constant.ERR_MSG_TEMP_REQ_FIELDS_MISSING, 'Allocation Method');
		System.assertEquals(EXPECTED_ERROR_MESSAGE, ApexPages.getMessages()[0].getDetail());
	}
	@isTest
	static void testAttachmentWithValidColumns(){
		initData();
		TestDataFactory testFactory = new TestDataFactory();
		List<List<String>> allGrantAwardData = testFactory.createDefaultGrantAwardDataParsedCSV();
		CSVDocument documentToUpload = new CSVDocument(allGrantAwardData);
		System.assertEquals(0, ApexPages.getMessages().size());
		controller.fileName = 'File To Upload.csv';
		controller.csvContent = Blob.valueOf(documentToUpload.convertToString());
		controller.validate();
		System.assertEquals(1, ApexPages.getMessages().size());
		System.assertEquals('Upload will contain 1 record(s).', ApexPages.getMessages()[0].getDetail());
	}

	@isTest
	static void testNewCSVUploadRedirect(){
		initData();
		System.assertEquals(null, controller.checkCSVUploadRecord());
	}

	@isTest
	static void testExistingCSVUploadRedirect(){
		initData();
		newUploadProcess.Apex_Batch_Id__c = 'a0126000000aFH4';
		insert newUploadProcess;
		stndController = new ApexPages.StandardController(newUploadProcess);
		controller = new CSVUploadNewController(stndController);
		System.assertEquals(stndController.view().getUrl(), controller.checkCSVUploadRecord().getUrl());
	}



	@isTest
	static void testUploadWithoutValidate(){
		initData();
		System.assertEquals(0, ApexPages.getMessages().size());
		controller.upload();
		System.assertEquals(1, ApexPages.getMessages().size());
		System.assertEquals('Uploaded file cannot be null. Please select a file and try again.', ApexPages.getMessages()[0].getDetail());
	}
	@isTest
	static void testGetAvailableTypeOptions(){
		initData();
		System.assertEquals(false, controller.getAvailableTypeOptions().isEmpty());
	}

	@isTest
	static void testUploadProcess(){
		initData();
		TestDataFactory testFactory = new TestDataFactory();
		List<List<String>> allGrantAwardData = testFactory.createDefaultGrantAwardDataParsedCSV();
		CSVDocument documentToUpload = new CSVDocument(allGrantAwardData);
		controller.fileName = 'File To Upload.csv';
		controller.csvContent = Blob.valueOf(documentToUpload.convertToString());
		controller.validate();
		System.assertEquals(1, ApexPages.getMessages().size());
		Test.startTest();
			PageReference uploadReturnPageReference = controller.upload();
		Test.stopTest();
		System.assertNotEquals(null, controller.csvUploadToUse.Id);
		System.assertEquals(1, ApexPages.getMessages().size());
		System.assertEquals('Upload will contain 1 record(s).', ApexPages.getMessages()[0].getDetail());
		System.assertNotEquals(null, uploadReturnPageReference);
		System.assertEquals(controller.csvUploadToUse.Id, uploadReturnPageReference.getParameters().get('id'));
		PageReference CSV_UPLOAD_DETAIL_PAGE = Page.CSVUploadDetail;
		CSV_UPLOAD_DETAIL_PAGE.getParameters().put('id', controller.csvUploadToUse.Id);
		System.assertEquals(CSV_UPLOAD_DETAIL_PAGE.getUrl(), uploadReturnPageReference.getUrl());
	}

	@isTest
	static void testGetIsReadyForFileUpload(){
		initData();
		newUploadProcess.Type__c = null;
		newUploadProcess.Recipient_Type__c = null;
		System.assertEquals(false, controller.getIsReadyForFileUpload());

		newUploadProcess.Type__c = 'Create Awards';
		System.assertEquals(false, controller.getIsReadyForFileUpload());
		newUploadProcess.Type__c = 'Amend Awards';
		System.assertEquals(false, controller.getIsReadyForFileUpload());
		newUploadProcess.Type__c = 'Upload Awards Evaluations';
		System.assertEquals(true, controller.getIsReadyForFileUpload());
		newUploadProcess.Type__c = 'Upload Awards Payments';
		System.assertEquals(true, controller.getIsReadyForFileUpload());
		
		newUploadProcess.Type__c = 'Create Awards';
		System.assertEquals(false, controller.getIsReadyForFileUpload());
		newUploadProcess.Recipient_Type__c = 'Individual';
		System.assertEquals(true, controller.getIsReadyForFileUpload());
		newUploadProcess.Type__c = 'Amend Awards';
		System.assertEquals(true, controller.getIsReadyForFileUpload());
	}
	@isTest
	static void testGetCSVTemplatePath(){
		String EMPTH_PATH = '';
		initData();
		newUploadProcess.Type__c = null;
		newUploadProcess.Recipient_Type__c = null;
		System.assertEquals(EMPTH_PATH, controller.getCSVTemplatePath());

		newUploadProcess.Type__c = 'Create Awards';
		System.assertNotEquals(EMPTH_PATH, controller.getCSVTemplatePath());
		newUploadProcess.Type__c = 'Amend Awards';
		System.assertNotEquals(EMPTH_PATH, controller.getCSVTemplatePath());
		newUploadProcess.Type__c = 'Upload Awards Evaluations';
		System.assertNotEquals(EMPTH_PATH, controller.getCSVTemplatePath());
		newUploadProcess.Type__c = 'Upload Awards Payments';
		System.assertNotEquals(EMPTH_PATH, controller.getCSVTemplatePath());
		
		newUploadProcess.Type__c = 'Create Awards';
		System.assertNotEquals(EMPTH_PATH, controller.getCSVTemplatePath());
		newUploadProcess.Recipient_Type__c = 'Individual';
		System.assertNotEquals(EMPTH_PATH, controller.getCSVTemplatePath());
		newUploadProcess.Type__c = 'Amend Awards';
		System.assertNotEquals(EMPTH_PATH, controller.getCSVTemplatePath());
	}
	@isTest
	static void testGetRecordtypeNeedsRecipientType(){
		initData();
		newUploadProcess.Type__c = null;
		System.assertEquals(false, controller.getRecordtypeNeedsRecipientType());

		newUploadProcess.Type__c = 'Create Awards';
		System.assertEquals(true, controller.getRecordtypeNeedsRecipientType());

		newUploadProcess.Type__c = 'Amend Awards';
		System.assertEquals(true, controller.getRecordtypeNeedsRecipientType());

		newUploadProcess.Type__c = 'Upload Awards Evaluations';
		System.assertEquals(false, controller.getRecordtypeNeedsRecipientType());
		newUploadProcess.Type__c = 'Upload Awards Payments';
		System.assertEquals(false, controller.getRecordtypeNeedsRecipientType());
	}
>>>>>>> refs/remotes/origin/master
}