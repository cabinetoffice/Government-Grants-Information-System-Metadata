/******************************************************************************************
@Author         Ric Dayrit
@Date           07/03/2016
@Project        Cloud Sherpas Cabinet Office Data Source
@Description    This is the unit test for GrantSchemeConfirmDeleteController class
*******************************************************************************************/
@isTest
private class GrantSchemeConfirmDeleteControllerTest{

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

        Account acctStandardUser = testFactory.createAccount('StandardUser','StandardUser');
        insert acctStandardUser;  

        User dept1SuperUser1 = testFactory.setupBasicUser(department1, 'SuperUserContact1', 'Data Solution Portal - Super User');
        insert dept1SuperUser1;
        User standardUser = testFactory.setupBasicUser(acctStandardUser ,'BasicUserContact','Data Solution Portal - User');
        insert standardUser;

        System.runAs(dept1SuperUser1){
            Grant_Scheme__c grantSchemeCreatedByDept1SuperUser1 = testFactory.createGrantScheme(
            	department1, 'Test Grant Award NonAdminRecord01', testFactory.testCOFOGLevel
            );
            insert grantSchemeCreatedByDept1SuperUser1;
            Grant_Award__c grantAwardCreatedByDept1SuperUser1 = testFactory.createGrantAward(
            	'Test Grant Award AdminRecord', department1, grantSchemeCreatedByDept1SuperUser1
            );
            grantAwardCreatedByDept1SuperUser1.Postal_Code_Geo_Location__Latitude__s = 51.503648907772100;
            grantAwardCreatedByDept1SuperUser1.Postal_Code_Geo_Location__Longitude__s = -0.126638914084856;
            grantAwardCreatedByDept1SuperUser1.Postal_Code_Region__c = 'London';
            grantAwardCreatedByDept1SuperUser1.Postal_Code_Parliamentary_Constituency__c = 'Islington North';
            grantAwardCreatedByDept1SuperUser1.Is_Postal_Code_Valid__c = true;
            grantAwardCreatedByDept1SuperUser1.Has_Postal_Code_Been_Checked__c = true;
            grantAwardCreatedByDept1SuperUser1.Total_Amount_in_funding_agreement__c = 100;
            Date startOfThisYearFY = Date.newInstance(Date.today().year(), 4, 1);
            grantAwardCreatedByDept1SuperUser1.Award_Start_Date__c = startOfThisYearFY.addMonths(-8);
            grantAwardCreatedByDept1SuperUser1.Award_End_Date__c = startOfThisYearFY.addMonths(-2);
            insert grantAwardCreatedByDept1SuperUser1;
        }
    }

    @isTest
    static void testGetAvailableRegions(){
        GrantSchemeConfirmDeleteController controller = new GrantSchemeConfirmDeleteController(
            new ApexPages.StandardController([SELECT Id FROM Grant_Scheme__c LIMIT 1])
        );
        System.assertEquals(1, controller.getCountOfRelatedGrantAwards());
    }
    @isTest
    static void testDeleteSuccess(){
        GrantSchemeConfirmDeleteController controller = new GrantSchemeConfirmDeleteController(
            new ApexPages.StandardController([SELECT Id FROM Grant_Scheme__c LIMIT 1])
        );
        System.assertNotEquals(null, controller.deleteAll());
    }
	/**@isTest
	//static void testDeleteFail(){
      //  User dept1SuperUser1 = [SELECT Id FROM User WHERE Email = 'SuperUserContact1@cabinetoffice.gov.uk' LIMIT 1][0];
        Grant_Scheme__c grantScheme = [SELECT Id FROM Grant_Scheme__c LIMIT 1][0];
        Test.setCreatedDate(grantScheme.Id, Datetime.newInstance(2011, 3, 3));
        System.runAs(dept1SuperUser1){
            Test.startTest();
                GrantSchemeConfirmDeleteController controller = new GrantSchemeConfirmDeleteController(
                    new ApexPages.StandardController(grantScheme)
                );
                System.assertEquals(null, controller.deleteAll());
            Test.stopTest();
        }
	}**/

    @isTest
    static void testShowDeleteButtonShowAdminUser() {
        GrantSchemeConfirmDeleteController controller = new GrantSchemeConfirmDeleteController(
            new ApexPages.StandardController([SELECT Id FROM Grant_Scheme__c LIMIT 1])
        );
        System.assertEquals(true, controller.getShowDeleteButton());
    }

    @isTest
    static void testShowDeleteButtonHidden() {
        User standardUser = [SELECT Id FROM User WHERE Email = 'BasicUserContact@cabinetoffice.gov.uk' LIMIT 1][0];
        System.runAs(standardUser) {
            Test.startTest();
                GrantSchemeConfirmDeleteController controller = new GrantSchemeConfirmDeleteController(
                    new ApexPages.StandardController([SELECT Id FROM Grant_Scheme__c LIMIT 1])
                );
                System.assertEquals(false, controller.getShowDeleteButton());
            Test.stopTest();
        }
    }

}