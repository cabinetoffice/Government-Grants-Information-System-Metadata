/******************************************************************************************
@Author         Bhushan Sukumar
@Date           30 Mar 2016
@Description    This is the unit test for SendIncompleteGrantReminder batch class
*******************************************************************************************/

@isTest
private class SendIncompleteGrantReminder_Test {

    static User dept1SuperUser1;
    static user dept1SuperUser1Inactive;

    @isTest static void testSendIncompleteGrantReminderExecute() {
        Test.startTest();
        SendIncompleteGrantReminder batchJob = new SendIncompleteGrantReminder();
        Id batchId = Database.executeBatch(batchJob);
        system.assertNotEquals(null, batchId);
        List<Grant_Award__c> awards = [SELECT Id,
                                       CreatedById, Actual_Payment__c
                                       , Payment_Frequency__c
                                       , Award_Start_Date__c
                                       , Award_End_Date__c
                                       , CreatedBy.IsActive
                                       FROM Grant_Award__c
                                       WHERE Actual_Payment__c = null
                                               AND ((Payment_Frequency__c = : Constant.UPFRONT_PAYMENT
                                                       AND Award_Start_Date__c = LAST_MONTH)
                                                       OR ((Payment_Frequency__c = : Constant.INSTALMENT_PAYMENTS
                                                               OR Payment_Frequency__c = : Constant.END_PAYMENT)
                                                               AND Award_End_Date__c = LAST_MONTH))];
        batchJob.execute((Database.BatchableContext)null, awards);
        Test.stopTest();
    }

    @isTest
    static void testSendIncompleteGrantReminderWithGrantReminderUpdated() {
        Test.startTest();
        SendIncompleteGrantReminder batchJob = new SendIncompleteGrantReminder();
        Id batchId = Database.executeBatch(batchJob);
        system.assertNotEquals(null, batchId);
        List<Grant_Award__c> awards = [SELECT Id,
                                       CreatedById, Actual_Payment__c
                                       , Payment_Frequency__c
                                       , Award_Start_Date__c
                                       , Award_End_Date__c
                                       , CreatedBy.IsActive
                                       FROM Grant_Award__c
                                       WHERE Actual_Payment__c = null
                                               AND ((Payment_Frequency__c = : Constant.UPFRONT_PAYMENT
                                                       AND Award_Start_Date__c = LAST_MONTH)
                                                       OR ((Payment_Frequency__c = : Constant.INSTALMENT_PAYMENTS
                                                               OR Payment_Frequency__c = : Constant.END_PAYMENT)
                                                               AND Award_End_Date__c = LAST_MONTH))];
        batchJob.execute((Database.BatchableContext)null, awards);
        Test.stopTest();
    }

    @isTest
    static void testSendIncompleteGrantReminderWithInactiveUser() {
        Test.startTest();
        SendIncompleteGrantReminder batchJob = new SendIncompleteGrantReminder();
        Id batchId = Database.executeBatch(batchJob);
        system.assertNotEquals(null, batchId);
        List<Grant_Award__c> awards = [SELECT Id,
                                       CreatedById, Actual_Payment__c
                                       , Payment_Frequency__c
                                       , Award_Start_Date__c
                                       , Award_End_Date__c
                                       , CreatedBy.IsActive
                                       FROM Grant_Award__c
                                       WHERE Actual_Payment__c = null
                                               AND ((Payment_Frequency__c = : Constant.UPFRONT_PAYMENT
                                                       AND Award_Start_Date__c = LAST_MONTH)
                                                       OR ((Payment_Frequency__c = : Constant.INSTALMENT_PAYMENTS
                                                               OR Payment_Frequency__c = : Constant.END_PAYMENT)
                                                               AND Award_End_Date__c = LAST_MONTH))];
        batchJob.execute((Database.BatchableContext)null, awards);
        Test.stopTest();
    }

    @testSetup()
    static void setupTesData() {
        TestDataFactory testFactory = new TestDataFactory();
        testFactory.insertReferenceData();
        Account department1 = testFactory.createAccount('Department1', 'NEW_CPID_Department1');
        department1.Primary_Address_1__c = 'Unit 1, Horse Guards Rd';
        department1.Primary_Address_2__c = 'HM Treasury';
        department1.Primary_City__c = 'London';
        department1.Primary_County__c = 'Greater London';
        department1.Primary_Country__c = 'United Kingdom';
        department1.Primary_Postal_Code__c = 'SW1A 2HQ';
        insert department1;
        dept1SuperUser1 = testFactory.setupBasicUser(department1 , 'SuperUserContact1', 'Data Solution Portal - Super User');
        insert dept1SuperUser1;
        System.runAs(dept1SuperUser1) {
            Grant_Scheme__c grantSchemeCreatedByDept1SuperUser1 = testFactory.createGrantScheme(
                        department1, 'Test Grant Award NonAdminRecord01', testFactory.testCOFOGLevel
                    );
            insert grantSchemeCreatedByDept1SuperUser1;
            Grant_Award__c grantAwardCreatedByDept1SuperUser1 = testFactory.createGrantAward(
                        'Test Grant Award AdminRecord', department1, grantSchemeCreatedByDept1SuperUser1
                    );
            grantAwardCreatedByDept1SuperUser1.Recipient_Secondary_Postal_Code__c = 'SW1A         2HQ';
            insert grantAwardCreatedByDept1SuperUser1;

            grantAwardCreatedByDept1SuperUser1.Payment_Frequency__c = Constant.UPFRONT_PAYMENT;
            grantAwardCreatedByDept1SuperUser1.Award_Start_Date__c = Date.today() - 45;

            update grantAwardCreatedByDept1SuperUser1;

            Grant_Award__c grantAward2CreatedByDept1SuperUser1 = testFactory.createGrantAward(
                        'Test Grant Award AdminRecord2', department1, grantSchemeCreatedByDept1SuperUser1
                    );
            grantAward2CreatedByDept1SuperUser1.Recipient_Secondary_Postal_Code__c = 'SW1A         2HQ';
            grantAward2CreatedByDept1SuperUser1.Payment_Frequency__c = Constant.UPFRONT_PAYMENT;
            grantAward2CreatedByDept1SuperUser1.Award_Start_Date__c = Date.today() - 45;
            insert grantAward2CreatedByDept1SuperUser1;

            if ((Date.today().month() - grantAward2CreatedByDept1SuperUser1.Award_Start_Date__c.month()) != 1) {
                grantAward2CreatedByDept1SuperUser1.Award_Start_Date__c += 15;
            }

            update grantAward2CreatedByDept1SuperUser1;
        }

        dept1SuperUser1Inactive = testFactory.setupBasicUser(department1 , 'SuperUserContactInvalid', 'Data Solution Portal - Super User');
        insert dept1SuperUser1Inactive;

        System.runAs(dept1SuperUser1Inactive) {
            Grant_Scheme__c grantSchemeCreatedByDept1SuperUser1 = testFactory.createGrantScheme(
                        department1, 'Test Grant Award NonAdminRecord01', testFactory.testCOFOGLevel
                  );
            insert grantSchemeCreatedByDept1SuperUser1;

            Grant_Award__c grantAward2CreatedByDept1SuperUser1 = testFactory.createGrantAward(
                        'Test Grant Award AdminRecord2', department1, grantSchemeCreatedByDept1SuperUser1
                    );
            grantAward2CreatedByDept1SuperUser1.Recipient_Secondary_Postal_Code__c = 'SW1A         2HQ';
            grantAward2CreatedByDept1SuperUser1.Payment_Frequency__c = Constant.UPFRONT_PAYMENT;
            grantAward2CreatedByDept1SuperUser1.Award_Start_Date__c = Date.today() - 45;
            insert grantAward2CreatedByDept1SuperUser1;

            if ((Date.today().month() - grantAward2CreatedByDept1SuperUser1.Award_Start_Date__c.month()) != 1) {
                grantAward2CreatedByDept1SuperUser1.Award_Start_Date__c += 15;
            }

            update grantAward2CreatedByDept1SuperUser1;
        }

        System.runAs(dept1SuperUser1) {
            dept1SuperUser1Inactive.isActive = false;
            update dept1SuperUser1Inactive;
        }
    }
}