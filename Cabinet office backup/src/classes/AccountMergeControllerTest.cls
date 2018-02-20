/******************************************************************************************
@Author         Daniel Lagar
@Date           23/05/2017
@Project        Cloud Sherpas Cabinet Office Data Source
@Description    test class for the AccountMergeController extension.
*******************************************************************************************/
@isTest
public class AccountMergeControllerTest {
    //data set up accounts, schemes, award and intermediaries using the TestDataFactory Class.
    @testSetup public static void setup() {
        TestDataFactory testFactory = new TestDataFactory();
        testFactory.insertReferenceData();
        
        //the account used as the current parent.
        Account department1 = testFactory.createAccount('Department1','NEW_CPID_Department1');
            department1.Primary_Address_1__c = 'Unit 1, Horse Guards Rd';
            department1.Primary_Address_2__c = 'HM Treasury';
            department1.Primary_City__c = 'London';
            department1.Primary_County__c = 'Greater London';
            department1.Primary_Country__c = 'United Kingdom';
            department1.Primary_Postal_Code__c = 'SW1A 2HQ';
            department1.CPID_from_OSCAR__c = '20075';
            department1.Companies_House_Number__c = '6855521';
            department1.Charities_Commission_Number__c = '1117229';
            department1.VAT_Reg_no__c = '331333334';
            department1.DUNS_Number__c = '2341';
            department1.ISNI__c = '35235';
            department1.International_ID__c = '534532';
            department1.Other_ID__c = 'SP-G15-A07-09';
        database.insert(department1);
        
        //the account to be used as the new parent
        Account department2 = testFactory.createAccount('Department2','NEW_CPID_Department12');
            department1.Primary_Address_1__c = 'Unit 12, Horse Guards Rd';
            department1.Primary_Address_2__c = 'HM Treasury1';
            department1.Primary_City__c = 'London2';
            department1.Primary_County__c = 'Greater London';
            department1.Primary_Country__c = 'United Kingdom';
            department1.Primary_Postal_Code__c = 'SW1A 3HQ';
            department1.CPID_from_OSCAR__c = '20075';
            department1.Companies_House_Number__c = '6855521';
            department1.Charities_Commission_Number__c = '1117229';
            department1.VAT_Reg_no__c = '331333334';
            department1.DUNS_Number__c = '2341';
            department1.ISNI__c = '35235';
            department1.International_ID__c = '534532';
            department1.Other_ID__c = 'SP-G15-A07-09';
        database.insert(department2);
        
        //create department1's grant scheme
        Grant_Scheme__c grantSchemeCreatedByDept1SuperUser1 = testFactory.createGrantScheme(
            department1, 'Test Grant Award NonAdminRecord01', testFactory.testCOFOGLevel);
            grantSchemeCreatedByDept1SuperUser1.Start_Date__C = date.valueOf('2016-04-01');
            grantSchemeCreatedByDept1SuperUser1.Duration__C = '5';
            grantSchemeCreatedByDept1SuperUser1.Risk_Profile__c ='Medium';
            grantSchemeCreatedByDept1SuperUser1.Senior_Responsible_Officer_Full_Name__c = 'test';
            grantSchemeCreatedByDept1SuperUser1.Scheme_Value__c = 2234;
            grantSchemeCreatedByDept1SuperUser1.Contact_email_address__c ='test@test.com';
            grantSchemeCreatedByDept1SuperUser1.Public_funding_source__c ='NATO';
            grantSchemeCreatedByDept1SuperUser1.Primary_Purpose__c ='Research & Innovation';
            grantSchemeCreatedByDept1SuperUser1.Allocation_Method__c = 'Formula';
            grantSchemeCreatedByDept1SuperUser1.Target_Location__c = 'England';
            grantSchemeCreatedByDept1SuperUser1.Recipient_Sector__c = 'Central Government';
            grantSchemeCreatedByDept1SuperUser1.Considered_by_the_Grants_Advice_Panel__c ='No';
            grantSchemeCreatedByDept1SuperUser1.Capital_Resource__c ='Capital';
            grantSchemeCreatedByDept1SuperUser1.Related_policy_objective__c ='test';
            grantSchemeCreatedByDept1SuperUser1.Funder__c =department1.id;
        database.insert(grantSchemeCreatedByDept1SuperUser1);
        
        //create department1's Intermediary
        Intermediary__c testIntermediary = testFactory.createIntermediary(department1, grantSchemeCreatedByDept1SuperUser1);
            testIntermediary.Intermediary_Organisation__c = department1.id;
        database.insert(testIntermediary);
        
        //create department1's Award
        Grant_Award__c testGrantAward = testFactory.createGrantAward('GrantAward1', department1,grantSchemeCreatedByDept1SuperUser1);
            testGrantAward.Recipient__c = department1.id;
            testGrantAward.Grant_Award_Objective__c = 'test';
        database.insert(testGrantAward);
    }
        //test method to test the search funtion.
        public static testMethod void TestsearchAccount(){
            //get the accounts from the test set up.
            account department1 = [select id, name from account where name = 'Department1' limit 1];
            account department2 = [select id, name from account where name = 'Department2' limit 1];
            //instanciate the page
            PageReference pageRef = Page.AccountMergePage;
            Test.setCurrentPage(pageRef);
            ApexPages.currentPage().getParameters().put('id', department1.id);
            ApexPages.StandardController stdController = new ApexPages.StandardController(department1);
            AccountMergeController ext = new AccountMergeController(stdController);
            ApexPages.currentPage().getParameters().put('selected', department2.id);
            
            test.startTest();
                ext.setComp();
                ext.searchAccount();
            test.stopTest();

    }
        //test method to test the re-parent funtionality.
        public static testMethod void TestreParent(){
            //get the accounts from the test set up.
            account department1 = [select id, name from account where name = 'Department1' limit 1];
            account department2 = [select id, name from account where name = 'Department2' limit 1];
            //instanciate the page
            PageReference pageRef = Page.AccountMergePage;
            Test.setCurrentPage(pageRef);
            ApexPages.currentPage().getParameters().put('id', department1.id);
            ApexPages.StandardController stdController = new ApexPages.StandardController(department1);
            AccountMergeController ext = new AccountMergeController(stdController);
            ApexPages.currentPage().getParameters().put('selected', department2.id);
            test.startTest();
                ext.setComp();
                ext.reParent();
            test.stopTest();
    }
        //test method to test the re-parent funtionality when no parent account is selected.
        public static testMethod void TestNoAccountSelected(){
            account department1 = [select id, name from account where name = 'Department1' limit 1];
            account department2 = [select id, name from account where name = 'Department2' limit 1];
            PageReference pageRef = Page.AccountMergePage;
            Test.setCurrentPage(pageRef);
            ApexPages.currentPage().getParameters().put('id', department1.id);
            ApexPages.StandardController stdController = new ApexPages.StandardController(department1);
            AccountMergeController ext = new AccountMergeController(stdController);
            test.startTest();
                ext.reParent();
            test.stopTest();
    }   


}