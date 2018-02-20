/******************************************************************************************
@Author         Hamed Izadpanah
@Date           03/10/2015
@Project        Cloud Sherpas Cabinet Office Data Source
@Description    This is the unit test class for SObject factory class
*******************************************************************************************/
@isTest
private class CSVUploadSObjectFactoryTest {

    @testSetup()
    private static void setupTestData() {
        
        insert new CoA_L5__c(
            Name = '11111000'
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
        insert new List<Account> {funderAccount, testDepartment};
        User testSuperUser = testFactory.setupBasicUser(testDepartment, 'Super User 0', Constant.PROFILE_COMMUNITY_SUPER_USER);
        System.runAs(testSuperUser) {
            Grant_Scheme__c newGrantScheme = testFactory.createGrantScheme(funderAccount, 'New Scheme', newCOFOG);
            newGrantScheme.Scheme_Reference_No__c = 'MySchemeRefNumber';
            insert newGrantScheme;
        }
    }

    static Account testDepartment;
    static Account funderAccount;
    static COFOG_L2__c newCOFOG;
    static CSVUploadMapping grantAwardMapping;
    static void initData() {
        TestDataFactory testFactory = new TestDataFactory();
        CSV_Upload__c grantAwardCsvUpload = testFactory.createOrganisationGrantAwardCSVUpload(Constant.CSV_UPLOAD_CREATE_AWARD_TYPE);
        grantAwardMapping = new CSVUploadMapping(grantAwardCsvUpload);
        testDepartment = [SELECT Id FROM Account WHERE CPID_from_OSCAR__c = 'DEP123' LIMIT 1][0];
        funderAccount = [SELECT Id FROM Account WHERE CPID_from_OSCAR__c = 'FUN123' LIMIT 1][0];
        newCOFOG = [SELECT Id FROM COFOG_L2__c WHERE Name = '123' LIMIT 1][0];
    }

    @isTest
    static void testCreateNewGrantAwardFull() {
        /**
        initData();
        TestDataFactory testFactory = new TestDataFactory();
        User testSuperUser = testFactory.setupBasicUser(testDepartment, 'Super User 1', Constant.PROFILE_COMMUNITY_SUPER_USER);
        System.runAs(testSuperUser) {
            List<List<String>> allGrantAwardData = testFactory.createDefaultGrantAwardDataParsedCSV();
            CSVUploadSObjectFactory sobjectFactory = new CSVUploadSObjectFactory.CreateAwardsFactory();
            sobjectFactory.setCSVMapping(grantAwardMapping);
            CSVDocument csvDocumentToUse = new CSVDocument(allGrantAwardData);
            System.assertEquals(0, [SELECT COUNT() FROM Grant_Award__c]);
            System.assertEquals(0, [SELECT COUNT() FROM Account WHERE Name = 'This is a new recepient!']);
            System.assertEquals(0, [SELECT COUNT() FROM Intermediary__c]);
            sobjectFactory.build(csvDocumentToUse.allRows[0]);
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
        } **/
    }

    @isTest
    static void testCreateNewGrantAwardWithoutIntermediary() {
    /**
        initData();
        TestDataFactory testFactory = new TestDataFactory();
        User testSuperUser = testFactory.setupBasicUser(testDepartment, 'Super User 1', Constant.PROFILE_COMMUNITY_SUPER_USER);
        System.runAs(testSuperUser) {
            TestDataFactory.DEFAULT_GRANT_AWARD_DATA_PARSED.put(TestDataFactory.TEST_INTERMEDIARY1_ID_COLUMN, '');
            TestDataFactory.DEFAULT_GRANT_AWARD_DATA_PARSED.put(TestDataFactory.TEST_INTERMEDIARY2_ID_COLUMN, '');
            List<List<String>> allGrantAwardData = testFactory.createDefaultGrantAwardDataParsedCSV();
            CSVUploadSObjectFactory sobjectFactory = new CSVUploadSObjectFactory.CreateAwardsFactory();
            sobjectFactory.setCSVMapping(grantAwardMapping);
            CSVDocument csvDocumentToUse = new CSVDocument(allGrantAwardData);
            System.assertEquals(0, [SELECT COUNT() FROM Grant_Award__c]);
            System.assertEquals(0, [SELECT COUNT() FROM Account WHERE Name = 'This is a new recepient!']);
            System.assertEquals(0, [SELECT COUNT() FROM Intermediary__c]);
            sobjectFactory.build(csvDocumentToUse.allRows[0]);
            System.assertEquals(1, [SELECT COUNT() FROM Account WHERE Name = 'This is a new recepient!']);
            System.assertEquals(1, [SELECT COUNT() FROM Grant_Award__c]);
            System.assertEquals(0, [SELECT COUNT() FROM Intermediary__c]);
        }**/
    }

    @isTest
    static void testInvalidInsertGrantAwardNoNameAndRecepientId() {
        initData();
        TestDataFactory testFactory = new TestDataFactory();
        User testSuperUser = testFactory.setupBasicUser(testDepartment, 'Super User 1', Constant.PROFILE_COMMUNITY_SUPER_USER);
        System.runAs(testSuperUser) {

            TestDataFactory.DEFAULT_GRANT_AWARD_DATA_PARSED.put(TestDataFactory.TEST_GRANT_AWARD_NAME_COLUMN, '');
            TestDataFactory.DEFAULT_GRANT_AWARD_DATA_PARSED.put(TestDataFactory.TEST_RECEPIENT_ID_COLUMN, '');
            List<List<String>> allGrantAwardData = testFactory.createDefaultGrantAwardDataParsedCSV();
            CSVUploadSObjectFactory sobjectFactory = new CSVUploadSObjectFactory.CreateAwardsFactory();
            sobjectFactory.setCSVMapping(grantAwardMapping);
            CSVDocument csvDocumentToUse = new CSVDocument(allGrantAwardData);
            System.assertEquals(0, [SELECT COUNT() FROM Account WHERE Name = 'This is a new recepient!']);
            System.assertEquals(0, [SELECT COUNT() FROM Grant_Award__c]);
            System.assertEquals(0, [SELECT COUNT() FROM Intermediary__c]);
            try {
                sobjectFactory.build(csvDocumentToUse.allRows[0]);
                System.assert(false);
            } catch (Exception exceptionToHanlde) {
                System.assertEquals(true, exceptionToHanlde.getMessage().containsIgnoreCase('[Grant Award Name, Recipient ID]'));
            }
            System.assertEquals(0, [SELECT COUNT() FROM Account WHERE Name = 'This is a new recepient!']);
            System.assertEquals(0, [SELECT COUNT() FROM Grant_Award__c]);
            System.assertEquals(0, [SELECT COUNT() FROM Intermediary__c]);
        }
    }

    @isTest
    static void testInvalidInsertGrantAwardInvalidCCOAId() {
        initData();
        TestDataFactory testFactory = new TestDataFactory();
        User testSuperUser = testFactory.setupBasicUser(testDepartment, 'Super User 1', Constant.PROFILE_COMMUNITY_SUPER_USER);
        System.runAs(testSuperUser) {
            TestDataFactory.DEFAULT_GRANT_AWARD_DATA_PARSED.put(TestDataFactory.TEST_CCOA_COLUMN, 'Invalid CCOA Code');
            List<List<String>> allGrantAwardData = testFactory.createDefaultGrantAwardDataParsedCSV();
            CSVUploadSObjectFactory sobjectFactory = new CSVUploadSObjectFactory.CreateAwardsFactory();
            sobjectFactory.setCSVMapping(grantAwardMapping);
            CSVDocument csvDocumentToUse = new CSVDocument(allGrantAwardData);
            System.assertEquals(0, [SELECT COUNT() FROM Account WHERE Name = 'This is a new recepient!']);
            System.assertEquals(0, [SELECT COUNT() FROM Grant_Award__c]);
            System.assertEquals(0, [SELECT COUNT() FROM Intermediary__c]);
            try {
                sobjectFactory.build(csvDocumentToUse.allRows[0]);
                System.assert(false);
            } catch (CSVUploadSObjectFactory.NoRecordFoundException exceptionToHanlde) {
                System.assertEquals('No ' + TestDataFactory.TEST_CCOA_COLUMN + ' was found with the provided Id.', exceptionToHanlde.getMessage());
            }
            System.assertEquals(0, [SELECT COUNT() FROM Account WHERE Name = 'This is a new recepient!']);
            System.assertEquals(0, [SELECT COUNT() FROM Grant_Award__c]);
            System.assertEquals(0, [SELECT COUNT() FROM Intermediary__c]);
        }
    }

    @isTest
    static void testInvalidInsertGrantAwardBadCountryName() {
        initData();
        TestDataFactory testFactory = new TestDataFactory();
        User testSuperUser = testFactory.setupBasicUser(testDepartment, 'Super User 1', Constant.PROFILE_COMMUNITY_SUPER_USER);
        System.runAs(testSuperUser) {

            TestDataFactory.DEFAULT_GRANT_AWARD_DATA_PARSED.put(TestDataFactory.TEST_GRANT_AWARD_COUNTRY_COLUMN, 'Invalid Country Name');
            List<List<String>> allGrantAwardData = testFactory.createDefaultGrantAwardDataParsedCSV();

            CSVUploadSObjectFactory sobjectFactory = new CSVUploadSObjectFactory.CreateAwardsFactory();
            sobjectFactory.setCSVMapping(grantAwardMapping);
            CSVDocument csvDocumentToUse = new CSVDocument(allGrantAwardData);
            System.assertEquals(0, [SELECT COUNT() FROM Account WHERE Name = 'This is a new recepient!']);
            System.assertEquals(0, [SELECT COUNT() FROM Grant_Award__c]);
            System.assertEquals(0, [SELECT COUNT() FROM Intermediary__c]);
            try {
                sobjectFactory.build(csvDocumentToUse.allRows[0]);
                System.assert(false); // Ensures that this line never executes
            } catch (StringValueParser.InvalidInputException exceptionToHanlde) {
                System.assertEquals('Award Country contains an invalid value.', exceptionToHanlde.getMessage());
            }
            List<Grant_Award__c> insertedGrantAwards = [SELECT Recipient_Secondary_Country__c FROM Grant_Award__c];
            System.assertEquals(0, [SELECT COUNT() FROM Account WHERE Name = 'This is a new recepient!']);
            System.assertEquals(0, [SELECT COUNT() FROM Grant_Award__c]);
            System.assertEquals(0, [SELECT COUNT() FROM Intermediary__c]);
        }
    }

    @isTest
    static void testUpdateGrantAwardSuccess() {
        /**
        testCreateNewGrantAwardFull();

        TestDataFactory testFactory = new TestDataFactory();
        List<Grant_Award__c> insertedGrantAwards = [SELECT Grant_Award_Name__c FROM Grant_Award__c];
        System.assertEquals(1, insertedGrantAwards.size());
        System.assertEquals(TestDataFactory.TEST_GRANT_AWARD_NAME, insertedGrantAwards[0].Grant_Award_Name__c);
        System.assertEquals(1, [SELECT COUNT() FROM Account WHERE Name = 'This is a new recepient!']);
        System.assertEquals(2, [SELECT COUNT() FROM Intermediary__c]);

        User testSuperUser = testFactory.setupBasicUser(testDepartment, 'Super User 2', Constant.PROFILE_COMMUNITY_SUPER_USER);
        TestDataFactory.DEFAULT_GRANT_AWARD_DATA_PARSED.put(TestDataFactory.TEST_GRANT_AWARD_NAME_COLUMN, 'Updated Name for Grant Award!');
        List<List<String>> allGrantAwardData = testFactory.createDefaultGrantAwardDataParsedCSV();

        CSVUploadSObjectFactory sobjectFactory = new CSVUploadSObjectFactory.AmendAwardsFactory();

        CSV_Upload__c updateGrantAwardCsvUpload = testFactory.createOrganisationGrantAwardCSVUpload(Constant.CSV_UPLOAD_AMEND_AWARD_TYPE);
        grantAwardMapping = new CSVUploadMapping(updateGrantAwardCsvUpload);
        sobjectFactory.setCSVMapping(grantAwardMapping);

        CSVDocument csvDocumentToUse = new CSVDocument(allGrantAwardData);
        sobjectFactory.build(csvDocumentToUse.allRows[0]);
        List<Grant_Award__c> updatedGrantAwards = [SELECT Grant_Award_Name__c FROM Grant_Award__c];
        System.assertEquals(1, [SELECT COUNT() FROM Grant_Award__c]);
        System.assertEquals('Updated Name for Grant Award!', [SELECT Grant_Award_Name__c FROM Grant_Award__c LIMIT 1].Grant_Award_Name__c);
        System.assertEquals(1, [SELECT COUNT() FROM Account WHERE Name = 'This is a new recepient!']);
        System.assertEquals(2, [SELECT COUNT() FROM Intermediary__c]);
        **/
    }
    @isTest
    static void testUpdateGrantAwardFail() {
        /**
        testCreateNewGrantAwardFull();

        TestDataFactory testFactory = new TestDataFactory();
        List<Grant_Award__c> insertedGrantAwards = [SELECT Grant_Award_Name__c FROM Grant_Award__c];
        System.assertEquals(1, insertedGrantAwards.size());
        System.assertEquals(TestDataFactory.TEST_GRANT_AWARD_NAME, insertedGrantAwards[0].Grant_Award_Name__c);
        System.assertEquals(1, [SELECT COUNT() FROM Account WHERE Name = 'This is a new recepient!']);
        System.assertEquals(2, [SELECT COUNT() FROM Intermediary__c]);


        User testSuperUser = testFactory.setupBasicUser(testDepartment, 'Super User 2', Constant.PROFILE_COMMUNITY_SUPER_USER);

        TestDataFactory.DEFAULT_GRANT_AWARD_DATA_PARSED.put(TestDataFactory.TEST_GRANT_AWARD_REF_COLUMN, 'INVALID AWARD ID');
        List<List<String>> allGrantAwardData = testFactory.createDefaultGrantAwardDataParsedCSV();
        CSVUploadSObjectFactory sobjectFactory = new CSVUploadSObjectFactory.AmendAwardsFactory();

        CSV_Upload__c updateGrantAwardCsvUpload = testFactory.createOrganisationGrantAwardCSVUpload(Constant.CSV_UPLOAD_AMEND_AWARD_TYPE);
        grantAwardMapping = new CSVUploadMapping(updateGrantAwardCsvUpload);
        sobjectFactory.setCSVMapping(grantAwardMapping);

        CSVDocument csvDocumentToUse = new CSVDocument(allGrantAwardData);
        try {
            sobjectFactory.build(csvDocumentToUse.allRows[0]);
            System.assert(false, 'This line should never execute');
        } catch (CSVUploadSObjectFactory.NoRecordFoundException notFoundRecordExceptionToHandle) {
            //GEPDS-801 - 06 Apr 2016 - Showing different error message based on the checks
            System.assertEquals(notFoundRecordExceptionToHandle.getMessage(),
                                Label.Invalid_Grant_Ref_Num_Error);
        }
        List<Grant_Award__c> updatedGrantAwards = [SELECT Grant_Award_Name__c FROM Grant_Award__c];
        System.assertEquals(1, [SELECT COUNT() FROM Grant_Award__c]);
        System.assertEquals(TestDataFactory.TEST_GRANT_AWARD_NAME, [SELECT Grant_Award_Name__c FROM Grant_Award__c LIMIT 1].Grant_Award_Name__c);
        System.assertEquals(1, [SELECT COUNT() FROM Account WHERE Name = 'This is a new recepient!']);
        System.assertEquals(2, [SELECT COUNT() FROM Intermediary__c]);
        **/
    }

}