/******************************************************************************************
@Author         Bhushan Sukumar
@Date           18 Apr 2016
@Project        Cloud Sherpas Cabinet Office Data Source
@Description    This is the test class for NotifyGrantDeletion class
*******************************************************************************************/

@isTest(SeeAllData = false)
private class NotifyGrantDeletion_Test {

    //test setup method for creating the test data
    @testSetup static void setupTestData() {
        TestDataFactory testFactory = new TestDataFactory();

        //Creating Programme record
        Programme__c programme = testFactory.createProgramme('Test Programme',
                                 String.valueOf(Date.today()));
        insert programme;

        //Creating Organisation
        Account org = testFactory.createAccount('Test Account1', 'Test Account1');
        insert org;

        //Creating COFOG
        COFOG_L2__c cofog = testFactory.createCOFOG_L2('Test COFOG');
        insert cofog;

        //Creating Grant Scheme record
        Grant_Scheme__c scheme = testFactory.createGrantScheme(org, 'Test Scheme', cofog);
        insert scheme;

        //Creating Grant Award record
        Grant_Award__c award = testFactory.createGrantAward('Test Grant Award Name', org, scheme);
        insert award;

        //Creating portal super user
        User superUser = testFactory.setupBasicUser(org,
                         'Test Contact' + String.valueOf(Date.today()),
                         Constant.PROFILE_SYSADMIN);

    }

    /**
     * test method to test the email notification when a Grant Scheme record is deleted
     * @author  Bhushan Sukumar
     * @date    18 Apr 2016
     */
    @isTest static void testSchemeNotification() {
        NotifyGrantDeletions notify = new NotifyGrantDeletions();
        Set<String> grantSchemeFields = Schema.getGlobalDescribe().get(
                                            Constant.SOBJECT_TYPE_GRANT_SCHEME).getDescribe().fields.getMap().keySet();

        String schemeSoql = 'SELECT ';
        for (String fieldName : grantSchemeFields) {
            schemeSoql += fieldName + ',';
        }
        schemeSoql = schemeSoql.left(schemeSoql.lastIndexOf(','));
        schemeSoql += ' FROM Grant_Scheme__c';

        List<SObject> schemesToDel = Database.Query(schemeSoql);
        Map<Id, SObject> schemeMap = new Map<Id, SObject>();
        Test.startTest();
        schemeMap.put(schemesToDel[0].id, (SObject)schemesToDel[0]);
        User superUser = [SELECT Id,
                          Name FROM User
                          WHERE Profile.Name = : Constant.PROFILE_SYSADMIN
                                               AND IsActive = TRUE LIMIT 1];
        System.runAs(superUser) {
            System.assert(notify.notifyGrantHubSupport(schemeMap));
        }
        Test.stopTest();
    }

    /**
     * test method to test the email notification when a Grant Award record is deleted
     * @author  Bhushan Sukumar
     * @date    18 Apr 2016
     */
    @isTest static void testAwardNotification() {
        NotifyGrantDeletions notify = new NotifyGrantDeletions();
        Set<String> grantAwardFields = Schema.getGlobalDescribe().get(
                                           Constant.SOBJECT_TYPE_GRANT_AWARD).getDescribe().fields.getMap().keySet();
        String awardSoql = 'SELECT ';
        for (String fieldName : grantAwardFields) {
            awardSoql += fieldName + ',';
        }
        awardSoql = awardSoql.left(awardSoql.lastIndexOf(','));
        awardSoql += ' FROM Grant_Award__c';

        List<SObject> awardsToDel = Database.Query(awardSoql);
        Map<Id, SObject> awardMap = new Map<Id, SObject>();
        Test.startTest();
        awardMap.put(awardsToDel[0].id, (SObject)awardsToDel[0]);
        User superUser = [SELECT Id,
                          Name
                          FROM User
                          WHERE Profile.Name = : Constant.PROFILE_SYSADMIN
                                               AND IsActive = TRUE LIMIT 1];
        System.runAs(superUser) {
            System.assert(notify.notifyGrantHubSupport(awardMap));
        }
        Test.stopTest();
    }

    /**
     * test method to test the email notification when a programme record is deleted
     * @author  Bhushan Sukumar
     * @date    18 Apr 2016
     */
    @isTest static void testProgrammeNotification() {
        NotifyGrantDeletions notify = new NotifyGrantDeletions();
        Set<String> programmeFields = Schema.getGlobalDescribe().get(
                                          Constant.SOBJECT_TYPE_PROGRAMME).getDescribe().fields.getMap().keySet();
        String progSoql = 'SELECT ';
        for (String fieldName : programmeFields) {
            progSoql += fieldName + ',';
        }
        progSoql = progSoql.left(progSoql.lastIndexOf(','));
        progSoql += ' FROM Programme__c';

        List<SObject> progsToDel = Database.Query(progSoql);
        Map<Id, SObject> programmesMap = new Map<Id, SObject>();
        Test.startTest();
        programmesMap.put(progsToDel[0].id, (SObject)progsToDel[0]);
        User superUser = [SELECT Id,
                          Name
                          FROM User
                          WHERE Profile.Name = : Constant.PROFILE_SYSADMIN
                                               AND IsActive = TRUE LIMIT 1];
        System.runAs(superUser) {
            System.assert(notify.notifyGrantHubSupport(programmesMap));
        }
        Test.stopTest();
    }
}