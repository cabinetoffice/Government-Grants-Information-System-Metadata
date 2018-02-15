/******************************************************************************************
@Author         Bhushan Sukumar
@Date           22 Mar 2016
@Project        Cloud Sherpas Cabinet Office Data Source
@Description    Test class for unit testing GrantSchemePrivilegeBannerExt
*******************************************************************************************/
@isTest
private class GrantSchemePrivilegeBannerExtTest {

    @testSetup
    static void setupTestData() {
        TestDataFactory testFactory = new TestDataFactory();
        testFactory.insertReferenceData();
        Account funderAccount = testFactory.createAccount('New Funder', 'FUN123');
        Account testDepartment = testFactory.createAccount('My New Department', 'DEP123');

        insert funderAccount;
        insert testDepartment;

        Grant_Scheme__c gScheme = testFactory.createGrantScheme(funderAccount, 'Test Grant Scheme', testFactory.testCOFOGLevel);
        gScheme.Intermediated__c = true;
        insert gScheme;
    }

    @isTest
    static void testInitialise() {
        List<Grant_Scheme__c> gSchemes = [SELECT Id FROM Grant_Scheme__c];
        Test.startTest();
            ApexPages.StandardController stdCont = new ApexPages.StandardController(gSchemes[0]);
            GrantSchemePrivilegeBannerExt bannerExt = new GrantSchemePrivilegeBannerExt(stdCont);
        Test.stopTest();
        System.assertEquals(0, bannerExt.getCountOfRelatedIntermediaries());
    }
}