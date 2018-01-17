/******************************************************************************************
@Author         Hamed Izadpanah
@Date           22/01/2016
@Project        Cloud Sherpas - GGIS
@Description    Test class responsible for unit testing of AllProposedGrantTriggersHandler
*******************************************************************************************/ 
@isTest
private class AllProposedGrantTriggersHandlerTest {

    static User adminUser;
    static User dept1SuperUser1;
    static User dept1SuperUser2;
    static User dept2SuperUser1;

    static Proposed_Grant__c proposedGrantCreatedByAdmin;
    static Proposed_Grant__c proposedGrantCreatedByDept1SuperUser1;
    static Proposed_Grant__c proposedGrantCreatedByDept2SuperUser1;
            
            
    static void setupUser(){
        TestDataFactory testFactory = new TestDataFactory();

        Account department1 = testFactory.createAccount('Department1','NEW_CPID_Department1');
        insert department1;
        dept1SuperUser1 = testFactory.setupBasicUser(department1 ,'SuperUserContact1','Data Solution Portal - Super User');
        insert dept1SuperUser1;
        dept1SuperUser2 = testFactory.setupBasicUser(department1 ,'SuperUserContact2','Data Solution Portal - Super User');
        insert dept1SuperUser2;

        Account department2 = testFactory.createAccount('Department2','NEW_CPID_Department2');
        insert department2;  
        dept2SuperUser1 = testFactory.setupBasicUser(department2 ,'SuperUserContact3','Data Solution Portal - Super User');
        insert dept2SuperUser1;
    }

    static void createData(){
        setupUser();
        TestDataFactory testFactory = new TestDataFactory();
        System.runAs(dept1SuperUser1){
	        proposedGrantCreatedByDept1SuperUser1 = testFactory.createProposedGrant('NonAdminRecord01');
	        insert proposedGrantCreatedByDept1SuperUser1;
        }
    }
    @isTest 
    static void testDeletionForSuperUserSuccess(){
        createData();
        System.assertEquals(1, [SELECT COUNT() FROM Proposed_Grant__c WHERE Id = :proposedGrantCreatedByDept1SuperUser1.Id]);
    	System.runAs(dept1SuperUser1){
    		delete [SELECT Id FROM Proposed_Grant__c WHERE Id = :proposedGrantCreatedByDept1SuperUser1.Id];
    	}
        System.assertEquals(0, [SELECT COUNT() FROM Proposed_Grant__c WHERE Id = :proposedGrantCreatedByDept1SuperUser1.Id]);
    }
    @isTest 
    static void testDeletionForSuperUserFailed(){
        createData();
        System.assertEquals(1, [SELECT COUNT() FROM Proposed_Grant__c WHERE Id = :proposedGrantCreatedByDept1SuperUser1.Id]);
    	System.runAs(dept2SuperUser1){
    		try{
        		delete [SELECT Id FROM Proposed_Grant__c WHERE Id = :proposedGrantCreatedByDept1SuperUser1.Id];
    			System.assert(false);
			} catch (DmlException exceptionToHandle){
				System.assertEquals(true, exceptionToHandle.getMessage().containsIgnoreCase('insufficient access'));
			}
    		
    	}
        System.assertEquals(1, [SELECT COUNT() FROM Proposed_Grant__c WHERE Id = :proposedGrantCreatedByDept1SuperUser1.Id]);
    }
}