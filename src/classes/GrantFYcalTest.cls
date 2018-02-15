@isTest
private class GrantFYcalTest {
	private static testMethod void TestGrantFinancialYear(){
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
              department1, 'Test Grant scheme NonAdminRecord01', testFactory.testCOFOGLevel);
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
	    Database.Insert(grantSchemeCreatedByDept1SuperUser1);
	    
	    
	    Grant_Award__c grantAwardCreatedByDept1SuperUser1 = testFactory.createGrantAward('Test Grant Award NonAdminRecord01', department1,grantSchemeCreatedByDept1SuperUser1);
	    
	    Test.startTest();
	    Database.Insert(grantAwardCreatedByDept1SuperUser1);
	    Test.stopTest();
        }
	}

}