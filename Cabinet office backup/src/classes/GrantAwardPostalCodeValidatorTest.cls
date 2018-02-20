/******************************************************************************************
@Author         Hamed Izadpanah
@Date           18/02/2015
@Project        Cloud Sherpas Cabinet Office Data Source
@Description    This is the test unit for GrantAwardPostalCodeValidator class
*******************************************************************************************/
@isTest
private class GrantAwardPostalCodeValidatorTest{

	@testSetup()
    static void setupTestData(){
        TestDataFactory testFactory = new TestDataFactory();
        testFactory.insertReferenceData();
        Account department1 = testFactory.createAccount('Department1','NEW_CPID_Department1');
        department1.Primary_Address_1__c = 'Unit 1, Horse Guards Rd';
        department1.Primary_Address_2__c = 'HM Treasury';
        department1.Primary_City__c = 'London';
        department1.Primary_County__c = 'Greater London';
        department1.Primary_Country__c = 'United Kingdom';
        department1.Primary_Postal_Code__c = 'SW1A 2HQ';
        insert department1;
        User dept1SuperUser1 = testFactory.setupBasicUser(department1 ,'SuperUserContact1','Data Solution Portal - Super User');
        insert dept1SuperUser1;
        System.runAs(dept1SuperUser1){
            Grant_Scheme__c grantSchemeCreatedByDept1SuperUser1 = testFactory.createGrantScheme(
            	department1, 'Test Grant Award NonAdminRecord01', testFactory.testCOFOGLevel
            );
            insert grantSchemeCreatedByDept1SuperUser1;
            Grant_Award__c grantAwardCreatedByDept1SuperUser1 = testFactory.createGrantAward(
            	'Test Grant Award AdminRecord', department1, grantSchemeCreatedByDept1SuperUser1
            );
            grantAwardCreatedByDept1SuperUser1.Recipient_Secondary_Postal_Code__c = 'SW1A         2HQ';
            insert grantAwardCreatedByDept1SuperUser1;
        }
    }


	@isTest
	static void testValidateValidPostCodeWithExecute(){
		PostCodesIO.PostCodeResult mockResult = PostCodesIO.generateMockResult();
		PostCodesIO.ResponseWrapper responseWrapper = new PostCodesIO.ResponseWrapper();
		responseWrapper.status = 200;
		responseWrapper.result = mockResult;
		BasicHttpCalloutMock calloutMock = new BasicHttpCalloutMock(
			200,
			'OK',
			JSON.serializePretty(responseWrapper),
			new Map<String, String>()
		);
		Test.setMock(HttpCalloutMock.class, calloutMock);


		List<Grant_Award__c> createdGrantAwards = [
			SELECT Recipient_Secondary_Postal_Code__c,
			Postal_Code_Validation_Error_Message__c, 
			Is_Postal_Code_Valid__c, Has_Postal_Code_Been_Checked__c
			FROM Grant_Award__c
		];
		System.assertEquals(1, createdGrantAwards.size());
		System.assertEquals(null, createdGrantAwards[0].Postal_Code_Validation_Error_Message__c);
		System.assertEquals('SW1A         2HQ', createdGrantAwards[0].Recipient_Secondary_Postal_Code__c);
		System.assertEquals(false, createdGrantAwards[0].Is_Postal_Code_Valid__c);
		System.assertEquals(false, createdGrantAwards[0].Has_Postal_Code_Been_Checked__c);
		GrantAwardPostalCodeValidator postalCodeValidator = new GrantAwardPostalCodeValidator();
		postalCodeValidator.execute(null, createdGrantAwards);
		System.assertEquals(1, createdGrantAwards.size());
		System.assertEquals(null, createdGrantAwards[0].Postal_Code_Validation_Error_Message__c);
		System.assertEquals('SW1A 2HQ', createdGrantAwards[0].Recipient_Secondary_Postal_Code__c);
		
		System.assertEquals(true, createdGrantAwards[0].Is_Postal_Code_Valid__c);
		System.assertEquals(true, createdGrantAwards[0].Has_Postal_Code_Been_Checked__c);
	}

	@isTest
	static void testValidateValidPostCodeWithBatchProcess(){
		PostCodesIO.PostCodeResult mockResult = PostCodesIO.generateMockResult();
		PostCodesIO.ResponseWrapper responseWrapper = new PostCodesIO.ResponseWrapper();
		responseWrapper.status = 200;
		responseWrapper.result = mockResult;
		BasicHttpCalloutMock calloutMock = new BasicHttpCalloutMock(
			200,
			'OK',
			JSON.serializePretty(responseWrapper),
			new Map<String, String>()
		);
		Test.setMock(HttpCalloutMock.class, calloutMock);


		List<Grant_Award__c> createdGrantAwards = [
			SELECT Recipient_Secondary_Postal_Code__c,
			Postal_Code_Validation_Error_Message__c, 
			Is_Postal_Code_Valid__c, Has_Postal_Code_Been_Checked__c
			FROM Grant_Award__c
		];
		System.assertEquals(1, createdGrantAwards.size());
		System.assertEquals(null, createdGrantAwards[0].Postal_Code_Validation_Error_Message__c);
		System.assertEquals('SW1A         2HQ', createdGrantAwards[0].Recipient_Secondary_Postal_Code__c);
		System.assertEquals(false, createdGrantAwards[0].Is_Postal_Code_Valid__c);
		System.assertEquals(false, createdGrantAwards[0].Has_Postal_Code_Been_Checked__c);
		Test.startTest();
			GrantAwardPostalCodeValidator postalCodeValidator = new GrantAwardPostalCodeValidator();
			Database.executeBatch(postalCodeValidator, 10);
		Test.stopTest();
		createdGrantAwards = [
			SELECT Recipient_Secondary_Postal_Code__c,
			Postal_Code_Validation_Error_Message__c, 
			Is_Postal_Code_Valid__c, Has_Postal_Code_Been_Checked__c
			FROM Grant_Award__c
		];
		System.assertEquals(1, createdGrantAwards.size());
		System.assertEquals(null, createdGrantAwards[0].Postal_Code_Validation_Error_Message__c);
		System.assertEquals('SW1A 2HQ', createdGrantAwards[0].Recipient_Secondary_Postal_Code__c);
	}
	@isTest
	static void testValidateValidPostCodeWithSchedule(){
		PostCodesIO.PostCodeResult mockResult = PostCodesIO.generateMockResult();
		PostCodesIO.ResponseWrapper responseWrapper = new PostCodesIO.ResponseWrapper();
		responseWrapper.status = 200;
		responseWrapper.result = mockResult;
		BasicHttpCalloutMock calloutMock = new BasicHttpCalloutMock(
			200,
			'OK',
			JSON.serializePretty(responseWrapper),
			new Map<String, String>()
		);
		Test.setMock(HttpCalloutMock.class, calloutMock);


		List<Grant_Award__c> createdGrantAwards = [
			SELECT Recipient_Secondary_Postal_Code__c,
			Postal_Code_Validation_Error_Message__c, 
			Is_Postal_Code_Valid__c, Has_Postal_Code_Been_Checked__c
			FROM Grant_Award__c
		];
		System.assertEquals(1, createdGrantAwards.size());
		System.assertEquals(null, createdGrantAwards[0].Postal_Code_Validation_Error_Message__c);
		System.assertEquals('SW1A         2HQ', createdGrantAwards[0].Recipient_Secondary_Postal_Code__c);
		System.assertEquals(false, createdGrantAwards[0].Is_Postal_Code_Valid__c);
		System.assertEquals(false, createdGrantAwards[0].Has_Postal_Code_Been_Checked__c);
		Test.startTest();
			String CRON_EXP = '0 0 0 3 9 ? 2099';
			String jobId = System.schedule('TEST SCHEDULE BATCH', CRON_EXP, new GrantAwardPostalCodeValidator());
			CronTrigger ct = [
				SELECT Id, CronExpression, TimesTriggered, NextFireTime
				FROM CronTrigger WHERE id = :jobId
			];
			System.assertEquals(0, ct.TimesTriggered);
		Test.stopTest();
	}
}