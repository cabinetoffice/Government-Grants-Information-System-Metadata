@isTest
private class FYcalTest {
	private static testMethod void TestFinancialYear(){
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
              department1, 'Test Grant Award NonAdminRecord01', testFactory.testCOFOGLevel);
	   /** TestDataFactory TG = new TestDataFactory();
	    TG.insertReferenceData();
	    
	    Account Acc1 = TG.createAccount('test');
	    Acc1.Type__C = 'Intermediary';
	    Database.Insert(Acc1);
	    COFOG_L2__c  COFOG = TG.createCOFOG_L2('test');
	    Database.Insert(COFOG);
	    Grant_Scheme__c GS = TG.createGrantScheme(Acc1, 'Test Grant Scheme', COFOG);
	    
	    gs.Funder__c = Acc1.id; **/
<<<<<<< HEAD
	    
	   /** grantSchemeCreatedByDept1SuperUser1.Start_Date__C = date.valueOf('2016-04-01');
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
	    grantSchemeCreatedByDept1SuperUser1.Related_policy_objective__c ='test'; **/
	    grantSchemeCreatedByDept1SuperUser1.Duration__C = '5';
=======
<<<<<<< HEAD
	    
	   /** grantSchemeCreatedByDept1SuperUser1.Start_Date__C = date.valueOf('2016-04-01');
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
	    grantSchemeCreatedByDept1SuperUser1.Related_policy_objective__c ='test'; **/
	    grantSchemeCreatedByDept1SuperUser1.Duration__C = '5';
=======
<<<<<<< HEAD
	    
	   /** grantSchemeCreatedByDept1SuperUser1.Start_Date__C = date.valueOf('2016-04-01');
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
	    grantSchemeCreatedByDept1SuperUser1.Related_policy_objective__c ='test'; **/
	    grantSchemeCreatedByDept1SuperUser1.Duration__C = '5';
=======
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
	    
>>>>>>> refs/remotes/origin/master
>>>>>>> branch 'master' of https://github.com/cabinetoffice/Government-Grants-Information-System-Metadata
>>>>>>> branch 'master' of https://github.com/cabinetoffice/Government-Grants-Information-System-Metadata
	    Test.startTest();
	    Database.Insert(grantSchemeCreatedByDept1SuperUser1);
	    Test.stopTest();
        }
	}

}