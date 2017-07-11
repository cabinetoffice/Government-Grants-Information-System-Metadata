/******************************************************************************************
@Author         Hamed Izadpanah
@Date           03/10/2015
@Project        Cloud Sherpas Cabinet Office Data Source
@Description    This is the unit test for CSV Upload Processor batch class
*******************************************************************************************/
@isTest
private class CSVUploadProcessorTest {

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
		User testSuperUser = testFactory.setupBasicUser(testDepartment, 'Super User 0', Constant.PROFILE_COMMUNITY_SUPER_USER);
		System.runAs(testSuperUser){
			Grant_Scheme__c newGrantScheme = testFactory.createGrantScheme(funderAccount, 'New Scheme', newCOFOG);
			newGrantScheme.Scheme_Reference_No__c = 'MySchemeRefNumber';
			insert newGrantScheme;
		}
	}

	static Account testDepartment;
	static void initData(){
		testDepartment = [SELECT Id FROM Account WHERE CPID_from_OSCAR__c = 'DEP123' LIMIT 1][0];
	}


	@isTest
	static void testCreateNewGrantAwardFull(){
		initData();
		TestDataFactory testFactory = new TestDataFactory();
		User testSuperUser = testFactory.setupBasicUser(testDepartment, 'Super User 1', Constant.PROFILE_COMMUNITY_SUPER_USER);
		System.runAs(testSuperUser){
			List<List<String>> allGrantAwardData = testFactory.createDefaultGrantAwardDataParsedCSV();
			System.assertEquals(0, [SELECT COUNT() FROM Grant_Award__c]);
			System.assertEquals(0, [SELECT COUNT() FROM Account WHERE Name = 'This is a new recepient!']);
			System.assertEquals(0, [SELECT COUNT() FROM Intermediary__c]);
			System.assertEquals(0, [SELECT COUNT() FROM CSV_Upload__c]);
			CSVDocument documentToUpload = new CSVDocument(allGrantAwardData);
			CSV_Upload__c csvUpload = testFactory.createOrganisationGrantAwardCSVUpload(Constant.CSV_UPLOAD_CREATE_AWARD_TYPE);
			CSVUploadProcessor processor = new CSVUploadProcessor(documentToUpload, CSVUploadSObjectFactory.newInstance(csvUpload));
			Test.startTest();
				Database.executeBatch(processor, 1);
			Test.stopTest();
			List<CSV_Upload__c> createdCSVUpload = [SELECT Records_Created_Count__c, Records_Updated_Count__c, Processing_Status__c, Total_Records_Failed__c FROM CSV_Upload__c];
			System.assertEquals(1, createdCSVUpload.size());
			System.assertEquals(Constant.CSV_UPLOAD_PT_FINISHED, createdCSVUpload[0].Processing_Status__c);
			System.assertEquals(1, createdCSVUpload[0].Records_Created_Count__c);
			System.assertEquals(0, createdCSVUpload[0].Records_Updated_Count__c);
			System.assertEquals(0, createdCSVUpload[0].Total_Records_Failed__c);

			System.assertEquals(1, [SELECT COUNT() FROM Account WHERE Name = 'This is a new recepient!']);
			System.assertEquals(1, [SELECT COUNT() FROM Grant_Award__c]);
			System.assertEquals(1, [
				SELECT COUNT() 
				FROM Intermediary__c 
				WHERE Intermediary_Organisation__r.Name = :TestDataFactory.NEW_INTERMEDIARY_1_NAME 
				AND Role__c = :TestDataFactory.NEW_INTERMEDIARY_1_ROLE 
				AND Intermediary_Organisation__r.VAT_Reg_no__c = :TestDataFactory.NEW_INTERMEDIARY_1_ORGANISATION_ID
			]);
			System.assertEquals(1, [
				SELECT COUNT() 
				FROM Intermediary__c 
				WHERE Intermediary_Organisation__r.Name = :TestDataFactory.NEW_INTERMEDIARY_2_NAME
				AND Role__c = :TestDataFactory.NEW_INTERMEDIARY_2_ROLE 
				AND Intermediary_Organisation__r.VAT_Reg_no__c = :TestDataFactory.NEW_INTERMEDIARY_2_ORGANISATION_ID
			]);
		}
	}

	@isTest
	static void testInvalidInsertGrantAwardNoNameAndRecepientId(){
		initData();
		TestDataFactory testFactory = new TestDataFactory();
		User testSuperUser = testFactory.setupBasicUser(testDepartment, 'Super User 1', Constant.PROFILE_COMMUNITY_SUPER_USER);
		System.runAs(testSuperUser){
		
			TestDataFactory.DEFAULT_GRANT_AWARD_DATA_PARSED.put(TestDataFactory.TEST_GRANT_AWARD_NAME_COLUMN, '');
			TestDataFactory.DEFAULT_GRANT_AWARD_DATA_PARSED.put(TestDataFactory.TEST_RECEPIENT_ID_COLUMN, '');
			List<List<String>> allGrantAwardData = testFactory.createDefaultGrantAwardDataParsedCSV();

			System.assertEquals(0, [SELECT COUNT() FROM Account WHERE Name = 'This is a new recepient!']);
			System.assertEquals(0, [SELECT COUNT() FROM Grant_Award__c]);
			System.assertEquals(0, [SELECT COUNT() FROM Intermediary__c]);

			CSVDocument documentToUpload = new CSVDocument(allGrantAwardData);
			CSV_Upload__c csvUpload = testFactory.createOrganisationGrantAwardCSVUpload(Constant.CSV_UPLOAD_CREATE_AWARD_TYPE);
			CSVUploadProcessor processor = new CSVUploadProcessor(documentToUpload, CSVUploadSObjectFactory.newInstance(csvUpload));
			System.assertEquals(0, [SELECT COUNT() FROM CSV_Upload__c]);
			Test.startTest();
				CSV_Upload__c newUpload = testFactory.createOrganisationGrantAwardCSVUpload(Constant.CSV_UPLOAD_CREATE_AWARD_TYPE);
				newUpload.Total_Records_Failed__c = 0;
				newUpload.Total_Records_To_Be_Processed__c = 1;
				newUpload.Apex_Batch_Id__c = Id.valueOf(Database.executeBatch(processor, 1));
				newUpload.Processing_Status__c = Constant.CSV_UPLOAD_PT_QUEUED;
				insert newUpload;
				System.assertEquals(0, [SELECT COUNT() FROM Attachment WHERE ParentId = :newUpload.Id]);
			Test.stopTest();

			List<CSV_Upload__c> createdCSVUpload = [SELECT Records_Created_Count__c, Records_Updated_Count__c, Processing_Status__c, Total_Records_Failed__c FROM CSV_Upload__c];
			System.assertEquals(1, createdCSVUpload.size());
			System.assertEquals(Constant.CSV_UPLOAD_PT_FINISHED, createdCSVUpload[0].Processing_Status__c);
			System.assertEquals(0, createdCSVUpload[0].Records_Created_Count__c);
			System.assertEquals(0, createdCSVUpload[0].Records_Updated_Count__c);
			System.assertEquals(1, createdCSVUpload[0].Total_Records_Failed__c);

			List<Attachment> errorFiles = [SELECT Body FROM Attachment WHERE ParentId = :newUpload.Id];
			System.assertEquals(1, errorFiles.size());
			System.assertEquals(true, errorFiles[0].Body.toString().containsIgnoreCase('[Grant Award Name, Recipient ID]'));
			System.assertEquals(0, [SELECT COUNT() FROM Account WHERE Name = 'This is a new recepient!']);
			System.assertEquals(0, [SELECT COUNT() FROM Grant_Award__c]);
			System.assertEquals(0, [SELECT COUNT() FROM Intermediary__c]);
		}
	}

	@isTest
	static void testInvalidInsertGrantAwardWithoutCountry(){
		initData();
		TestDataFactory testFactory = new TestDataFactory();
		User testSuperUser = testFactory.setupBasicUser(testDepartment, 'Super User 1', Constant.PROFILE_COMMUNITY_SUPER_USER);
		System.runAs(testSuperUser){
			String longName = '';
			while(longName.length() < 255){
				longName += 'LONG NAME!!!';
			}
			TestDataFactory.DEFAULT_GRANT_AWARD_DATA_PARSED.put(TestDataFactory.TEST_GRANT_AWARD_NAME_COLUMN, longName);
			List<List<String>> allGrantAwardData = testFactory.createDefaultGrantAwardDataParsedCSV();
			System.assertEquals(0, [SELECT COUNT() FROM Account WHERE Name = 'This is a new recepient!']);
			System.assertEquals(0, [SELECT COUNT() FROM Grant_Award__c]);
			System.assertEquals(0, [SELECT COUNT() FROM Intermediary__c]);
			CSVDocument documentToUpload = new CSVDocument(allGrantAwardData);
			CSV_Upload__c csvUpload = testFactory.createOrganisationGrantAwardCSVUpload(Constant.CSV_UPLOAD_CREATE_AWARD_TYPE);
			CSVUploadProcessor processor = new CSVUploadProcessor(documentToUpload, CSVUploadSObjectFactory.newInstance(csvUpload));
			Test.startTest();
				CSV_Upload__c newUpload = testFactory.createOrganisationGrantAwardCSVUpload(Constant.CSV_UPLOAD_CREATE_AWARD_TYPE);
				newUpload.Total_Records_Failed__c = 0;
				newUpload.Total_Records_To_Be_Processed__c = 1;
				newUpload.Apex_Batch_Id__c = Id.valueOf(Database.executeBatch(processor, 1));
				newUpload.Processing_Status__c = Constant.CSV_UPLOAD_PT_QUEUED;
				insert newUpload;
				System.assertEquals(0, [SELECT COUNT() FROM Attachment WHERE ParentId = :newUpload.Id]);
			Test.stopTest();
			List<Attachment> errorFiles = [SELECT Body FROM Attachment WHERE ParentId = :newUpload.Id];
			System.assertEquals(1, errorFiles.size());
			System.assertEquals(true, errorFiles[0].Body.toString().containsIgnoreCase('(max length=255)'));
			System.assertEquals(0, [SELECT COUNT() FROM Account WHERE Name = 'This is a new recepient!']);
			System.assertEquals(0, [SELECT COUNT() FROM Grant_Award__c]);
			System.assertEquals(0, [SELECT COUNT() FROM Intermediary__c]);
		}
	}

}