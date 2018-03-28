/******************************************************************************************
@Author         Hamed Izadpanah
@Date           25/01/2016
@Project        Cloud Sherpas - GGIS
@Description    Test class responsible for unit testing of AllGrantAwardTriggersHandler
*******************************************************************************************/
@isTest//(seealldata=true) do note use this syntax
public class AllGrantAwardTriggersHandlerTest {

    static Account department1;

    static User adminUser;
    static User dept1SuperUser1;
    static User dept1SuperUser2;
    static User dept2SuperUser1;

    static COFOG_L2__c testCOFOG1;

    static Grant_Scheme__c grantSchemeCreatedByDept1SuperUser1;
    static Grant_Award__c grantAwardCreatedByDept1SuperUser1;

    static void setupUser() {
        TestDataFactory testFactory = new TestDataFactory();

        department1 = testFactory.createAccount('Department1', 'NEW_CPID_Department1');
        department1.Primary_Address_1__c = 'Unit 1, Horse Guards Rd';
        department1.Primary_Address_2__c = 'HM Treasury';
        department1.Primary_City__c = 'London';
        department1.Primary_County__c = 'Greater London';
        department1.Primary_Country__c = 'United Kingdom';
        department1.Primary_Postal_Code__c = 'SW1A 2HQ';
        insert department1;
        dept1SuperUser1 = testFactory.setupBasicUser(department1 , 'SuperUserContact1', 'Data Solution Portal - Super User');
        insert dept1SuperUser1;
        dept1SuperUser2 = testFactory.setupBasicUser(department1 , 'SuperUserContact2', 'Data Solution Portal - Super User');
        insert dept1SuperUser2;

        Account department2 = testFactory.createAccount('Department2', 'NEW_CPID_Department2');
        insert department2;
        dept2SuperUser1 = testFactory.setupBasicUser(department2 , 'SuperUserContact3', 'Data Solution Portal - Super User');
        insert dept2SuperUser1;
    }
    static void createData() {
        setupUser();
        TestDataFactory testFactory = new TestDataFactory();
        testFactory.insertReferenceData();
        System.runAs(dept1SuperUser1) {
            grantSchemeCreatedByDept1SuperUser1 = testFactory.createGrantScheme(department1, 'Test Grant Award NonAdminRecord01', testFactory.testCOFOGLevel);
            insert grantSchemeCreatedByDept1SuperUser1;
            grantAwardCreatedByDept1SuperUser1 = testFactory.createGrantAward('Test Grant Award AdminRecord', department1, grantSchemeCreatedByDept1SuperUser1);
            insert grantAwardCreatedByDept1SuperUser1;
        }
    }
    @isTest
    static void testDeletionForSuperUserSuccess() {
        createData();
        System.assertEquals(1, [SELECT COUNT() FROM Grant_Award__c WHERE Id = :grantAwardCreatedByDept1SuperUser1.Id]);
        System.runAs(dept1SuperUser1) {
            delete [SELECT Id FROM Grant_Award__c WHERE Id = :grantAwardCreatedByDept1SuperUser1.Id];
        }
        System.assertEquals(0, [SELECT COUNT() FROM Grant_Award__c WHERE Id = :grantAwardCreatedByDept1SuperUser1.Id]);
    }
    @isTest
    static void testDeletionForSuperUserFailed() {
        createData();
        System.runAs(dept2SuperUser1) {
            Grant_Award__c insertedGrantAward = [
                                                    SELECT Id, Is_My_Department_Data__c, Grant_Scheme__r.Owner.UserRole.Name
                                                    FROM Grant_Award__c
                                                    WHERE Id = :grantAwardCreatedByDept1SuperUser1.Id
                                                ];

            System.assertEquals(
                UserInfo.getUserType(),
                Constant.USER_TYPE_COMMUNITY_PLUS
            );
            System.assertNotEquals(
                insertedGrantAward.Grant_Scheme__r.Owner.UserRole.Name,
                [SELECT Name FROM UserRole WHERE Id = :UserInfo.getUserRoleId()].Name
            );
            try {
                delete insertedGrantAward;
                System.assertEquals(false, insertedGrantAward.Is_My_Department_Data__c);
                System.assert(false);
            } catch (DmlException exceptionToHandle) {
                System.assertEquals(true, exceptionToHandle.getMessage().containsIgnoreCase(System.Label.User_Delete_Access_Error_Msg));
            }
        }
        System.assertEquals(1, [SELECT COUNT() FROM Grant_Award__c WHERE Id = :grantAwardCreatedByDept1SuperUser1.Id]);
    }

    @isTest
    static void testAddressCopyInvalid() {
        createData();
        TestDataFactory testFactory = new TestDataFactory();
        Grant_Award__c newGrantAward = testFactory.createGrantAward('Test Grant Award AdminRecord', department1, grantSchemeCreatedByDept1SuperUser1);
        newGrantAward.Recipient_Secondary_Address_1__c = null;
        newGrantAward.Recipient_Secondary_City__c = null;
        newGrantAward.Recipient_Secondary_Country__c = null;
        newGrantAward.Recipient_Secondary_Postal_Code__c = null;
        newGrantAward.Get_existing_organisation_address__c = false;
        System.runAs(dept1SuperUser1) {
            try {
                insert newGrantAward;
                System.assert(false);
            } catch (DmlException exceptionToHandle) {
                System.assertEquals(true, exceptionToHandle.getMessage().containsIgnoreCase('are mandatory'));
            }

        }
    }
    @isTest
    static void testAddressCopyValidInsert() {
        createData();
        TestDataFactory testFactory = new TestDataFactory();
        Grant_Award__c newGrantAward = testFactory.createGrantAward('Test Grant Award AdminRecord', department1, grantSchemeCreatedByDept1SuperUser1);
        newGrantAward.Recipient_Secondary_Address_1__c = null;
        newGrantAward.Recipient_Secondary_Address_2__c = null;
        newGrantAward.Recipient_Secondary_City__c = null;
        newGrantAward.Recipient_Secondary_County__c = null;
        newGrantAward.Recipient_Secondary_Country__c = null;
        newGrantAward.Recipient_Secondary_Postal_Code__c = null;
        newGrantAward.Get_existing_organisation_address__c = true;
        System.runAs(dept1SuperUser1) {
            insert newGrantAward;
            newGrantAward = [
                                SELECT Recipient_Secondary_Address_1__c, Recipient_Secondary_Address_2__c, Recipient_Secondary_City__c,
                                Recipient_Secondary_Country__c, Recipient_Secondary_Postal_Code__c, Recipient_Secondary_County__c
                                FROM Grant_Award__c
                                WHERE Id = :newGrantAward.Id
                            ];
            System.assertEquals('Unit 1, Horse Guards Rd', newGrantAward.Recipient_Secondary_Address_1__c);
            System.assertEquals('HM Treasury', newGrantAward.Recipient_Secondary_Address_2__c);
            System.assertEquals('London', newGrantAward.Recipient_Secondary_City__c);
            System.assertEquals('Greater London', newGrantAward.Recipient_Secondary_County__c);
            System.assertEquals('United Kingdom', newGrantAward.Recipient_Secondary_Country__c);
            System.assertEquals('SW1A 2HQ', newGrantAward.Recipient_Secondary_Postal_Code__c);
        }
    }
    @isTest
    static void testAddressCopyValidUpdate() {
        createData();
        TestDataFactory testFactory = new TestDataFactory();
        Grant_Award__c newGrantAward = testFactory.createGrantAward('Test Grant Award AdminRecord', department1, grantSchemeCreatedByDept1SuperUser1);
        System.assertNotEquals('Unit 1, Horse Guards Rd', newGrantAward.Recipient_Secondary_Address_1__c);
        System.assertNotEquals('HM Treasury', newGrantAward.Recipient_Secondary_Address_2__c);
        System.assertNotEquals('London', newGrantAward.Recipient_Secondary_City__c);
        System.assertNotEquals('Greater London', newGrantAward.Recipient_Secondary_County__c);
        System.assertNotEquals('United Kingdom', newGrantAward.Recipient_Secondary_Country__c);
        System.assertNotEquals('SW1A 2HQ', newGrantAward.Recipient_Secondary_Postal_Code__c);
        insert newGrantAward;

        newGrantAward.Recipient_Secondary_Address_1__c = null;
        newGrantAward.Recipient_Secondary_Address_2__c = null;
        newGrantAward.Recipient_Secondary_City__c = null;
        newGrantAward.Recipient_Secondary_County__c = null;
        newGrantAward.Recipient_Secondary_Country__c = null;
        newGrantAward.Recipient_Secondary_Postal_Code__c = null;
        newGrantAward.Get_existing_organisation_address__c = true;
        System.runAs(dept1SuperUser1) {
            update newGrantAward;
            newGrantAward = [
                                SELECT Recipient_Secondary_Address_1__c, Recipient_Secondary_Address_2__c, Recipient_Secondary_City__c,
                                Recipient_Secondary_Country__c, Recipient_Secondary_Postal_Code__c, Recipient_Secondary_County__c
                                FROM Grant_Award__c
                                WHERE Id = :newGrantAward.Id
                            ];
            System.assertEquals('Unit 1, Horse Guards Rd', newGrantAward.Recipient_Secondary_Address_1__c);
            System.assertEquals('HM Treasury', newGrantAward.Recipient_Secondary_Address_2__c);
            System.assertEquals('London', newGrantAward.Recipient_Secondary_City__c);
            System.assertEquals('Greater London', newGrantAward.Recipient_Secondary_County__c);
            System.assertEquals('United Kingdom', newGrantAward.Recipient_Secondary_Country__c);
            System.assertEquals('SW1A 2HQ', newGrantAward.Recipient_Secondary_Postal_Code__c);
        }
    }
    @isTest
    static void testAddressChangedEffect() {
        createData();
        TestDataFactory testFactory = new TestDataFactory();
        Grant_Award__c newGrantAward = testFactory.createGrantAward('Test Grant Award AdminRecord', department1, grantSchemeCreatedByDept1SuperUser1);
        newGrantAward.Recipient_Secondary_Address_1__c = null;
        newGrantAward.Recipient_Secondary_Address_2__c = null;
        newGrantAward.Recipient_Secondary_City__c = null;
        newGrantAward.Recipient_Secondary_County__c = null;
        newGrantAward.Recipient_Secondary_Country__c = null;
        newGrantAward.Recipient_Secondary_Postal_Code__c = null;
        newGrantAward.Get_existing_organisation_address__c = true;
        System.runAs(dept1SuperUser1) {
            insert newGrantAward;
            newGrantAward = [
                                SELECT Recipient_Secondary_Address_1__c, Recipient_Secondary_Address_2__c, Recipient_Secondary_City__c,
                                Recipient_Secondary_Country__c, Recipient_Secondary_Postal_Code__c, Recipient_Secondary_County__c,
                                Get_existing_organisation_address__c
                                FROM Grant_Award__c
                                WHERE Id = :newGrantAward.Id
                            ];
            System.assertEquals('Unit 1, Horse Guards Rd', newGrantAward.Recipient_Secondary_Address_1__c);
            System.assertEquals('HM Treasury', newGrantAward.Recipient_Secondary_Address_2__c);
            System.assertEquals('London', newGrantAward.Recipient_Secondary_City__c);
            System.assertEquals('Greater London', newGrantAward.Recipient_Secondary_County__c);
            System.assertEquals('United Kingdom', newGrantAward.Recipient_Secondary_Country__c);
            System.assertEquals('SW1A 2HQ', newGrantAward.Recipient_Secondary_Postal_Code__c);
            System.assertEquals(true, newGrantAward.Get_existing_organisation_address__c);

            newGrantAward.Recipient_Secondary_Address_1__c = 'Unit 2, Horse Guards Rd';
            update newGrantAward;
            newGrantAward = [
                                SELECT Recipient_Secondary_Address_1__c, Recipient_Secondary_Address_2__c, Recipient_Secondary_City__c,
                                Recipient_Secondary_Country__c, Recipient_Secondary_Postal_Code__c, Recipient_Secondary_County__c,
                                Get_existing_organisation_address__c
                                FROM Grant_Award__c
                                WHERE Id = :newGrantAward.Id
                            ];
            System.assertEquals('Unit 2, Horse Guards Rd', newGrantAward.Recipient_Secondary_Address_1__c);
            System.assertEquals('HM Treasury', newGrantAward.Recipient_Secondary_Address_2__c);
            System.assertEquals('London', newGrantAward.Recipient_Secondary_City__c);
            System.assertEquals('Greater London', newGrantAward.Recipient_Secondary_County__c);
            System.assertEquals('United Kingdom', newGrantAward.Recipient_Secondary_Country__c);
            System.assertEquals('SW1A 2HQ', newGrantAward.Recipient_Secondary_Postal_Code__c);
            System.assertEquals(false, newGrantAward.Get_existing_organisation_address__c);
        }
    }

   
  /** @isTest
    static void testDeleteGrantAwardNotWithin48HoursOfCreation() {
        String errorMsg = '';

        createData();
        Test.setCreatedDate(grantAwardCreatedByDept1SuperUser1.Id, Datetime.newInstance(2016, 3, 3));

        System.runAs(dept1SuperUser1) {
            Test.startTest();
            try {
                delete grantAwardCreatedByDept1SuperUser1;
            } catch (Exception e) {
                errorMsg = e.getMessage();
                System.assert(e.getMessage().contains(System.Label.Grant_Award_Delete_Validation_Error_Message));
            }
            Test.stopTest();
        }

        System.assert(errorMsg.contains(System.Label.Grant_Award_Delete_Validation_Error_Message));
    }**/ 

    @isTest
    static void testclearReasonForNoMonitoring() {
        createData();
        System.runAs(dept1SuperUser1) {
            Test.startTest();
            grantAwardCreatedByDept1SuperUser1.Is_The_Grant_Monitored__c = Constant.GRANT_MONITORED_YES;
            grantAwardCreatedByDept1SuperUser1.Against_Criteria_From_Grant_Agreement__c = 'Yes';
            grantAwardCreatedByDept1SuperUser1.Reason_For_No_Monitoring__c = 'test value';
            grantAwardCreatedByDept1SuperUser1.Mode_of_Monitoring__c = 'Milestone based';
            update grantAwardCreatedByDept1SuperUser1;
            Test.stopTest();
        }
        Grant_Award__c award = [SELECT Id, Is_The_Grant_Monitored__c, Reason_For_No_Monitoring__c FROM Grant_Award__c WHERE Id = : grantAwardCreatedByDept1SuperUser1.id];
        System.assertEquals(award.Reason_For_No_Monitoring__c, null);
    }
}