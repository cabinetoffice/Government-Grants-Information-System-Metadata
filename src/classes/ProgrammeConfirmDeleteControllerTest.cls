<<<<<<< HEAD
/******************************************************************************************
@Author         Hamed Izadpanah
@Date           11/03/2016
@Project        Cloud Sherpas - GGIS
@Description    Test class responsible for unit testing of ProgrammeConfirmDeleteController
*******************************************************************************************/ 
@isTest
private class ProgrammeConfirmDeleteControllerTest{

    static Account department1;

    static User adminUser;
    static User dept1SuperUser1;
    static User dept1SuperUser2;
    static User dept2SuperUser1;

    static COFOG_L2__c testCOFOG1; 

    static Programme__c programmeCreatedByDept1SuperUser1;

    static void setupUser(){
        TestDataFactory testFactory = new TestDataFactory();

        department1 = testFactory.createAccount('Department1','NEW_CPID_Department1');
        department1.Primary_Address_1__c = 'Unit 1, Horse Guards Rd';
        department1.Primary_Address_2__c = 'HM Treasury';
        department1.Primary_City__c = 'London';
        department1.Primary_County__c = 'Greater London';
        department1.Primary_Country__c = 'United Kingdom';
        department1.Primary_Postal_Code__c = 'SW1A 2HQ';
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
        testFactory.insertReferenceData();
        System.runAs(dept1SuperUser1){
            programmeCreatedByDept1SuperUser1 = testFactory.createProgramme('New Programme', 'PROG_ID_REF');
            insert programmeCreatedByDept1SuperUser1;
        }
    }

	@isTest
	static void testDeleteSuccess(){
        createData();
        System.runAs(dept1SuperUser1){
        	ProgrammeConfirmDeleteController controllerToUse = new ProgrammeConfirmDeleteController(
        		new ApexPages.StandardController(programmeCreatedByDept1SuperUser1)
        	);
        	System.assertNotEquals(null, controllerToUse.deleteRecord());
        }
	}
	@isTest
	static void testDeleteFail(){
        createData();
        Test.setCreatedDate(programmeCreatedByDept1SuperUser1.Id, Datetime.newInstance(2011, 3, 3));
        System.runAs(dept1SuperUser1){
        	Test.startTest();
	        	ProgrammeConfirmDeleteController controllerToUse = new ProgrammeConfirmDeleteController(
	        		new ApexPages.StandardController(programmeCreatedByDept1SuperUser1)
	        	);
	        	System.assertEquals(null, controllerToUse.deleteRecord());
        	Test.stopTest();
        }

	}
=======
<<<<<<< HEAD
/******************************************************************************************
@Author         Hamed Izadpanah
@Date           11/03/2016
@Project        Cloud Sherpas - GGIS
@Description    Test class responsible for unit testing of ProgrammeConfirmDeleteController
*******************************************************************************************/ 
@isTest
private class ProgrammeConfirmDeleteControllerTest{

    static Account department1;

    static User adminUser;
    static User dept1SuperUser1;
    static User dept1SuperUser2;
    static User dept2SuperUser1;

    static COFOG_L2__c testCOFOG1; 

    static Programme__c programmeCreatedByDept1SuperUser1;

    static void setupUser(){
        TestDataFactory testFactory = new TestDataFactory();

        department1 = testFactory.createAccount('Department1','NEW_CPID_Department1');
        department1.Primary_Address_1__c = 'Unit 1, Horse Guards Rd';
        department1.Primary_Address_2__c = 'HM Treasury';
        department1.Primary_City__c = 'London';
        department1.Primary_County__c = 'Greater London';
        department1.Primary_Country__c = 'United Kingdom';
        department1.Primary_Postal_Code__c = 'SW1A 2HQ';
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
        testFactory.insertReferenceData();
        System.runAs(dept1SuperUser1){
            programmeCreatedByDept1SuperUser1 = testFactory.createProgramme('New Programme', 'PROG_ID_REF');
            insert programmeCreatedByDept1SuperUser1;
        }
    }

	@isTest
	static void testDeleteSuccess(){
        createData();
        System.runAs(dept1SuperUser1){
        	ProgrammeConfirmDeleteController controllerToUse = new ProgrammeConfirmDeleteController(
        		new ApexPages.StandardController(programmeCreatedByDept1SuperUser1)
        	);
        	System.assertNotEquals(null, controllerToUse.deleteRecord());
        }
	}
	@isTest
	static void testDeleteFail(){
        createData();
        Test.setCreatedDate(programmeCreatedByDept1SuperUser1.Id, Datetime.newInstance(2011, 3, 3));
        System.runAs(dept1SuperUser1){
        	Test.startTest();
	        	ProgrammeConfirmDeleteController controllerToUse = new ProgrammeConfirmDeleteController(
	        		new ApexPages.StandardController(programmeCreatedByDept1SuperUser1)
	        	);
	        	System.assertEquals(null, controllerToUse.deleteRecord());
        	Test.stopTest();
        }

	}
=======
<<<<<<< HEAD
/******************************************************************************************
@Author         Hamed Izadpanah
@Date           11/03/2016
@Project        Cloud Sherpas - GGIS
@Description    Test class responsible for unit testing of ProgrammeConfirmDeleteController
*******************************************************************************************/ 
@isTest
private class ProgrammeConfirmDeleteControllerTest{

    static Account department1;

    static User adminUser;
    static User dept1SuperUser1;
    static User dept1SuperUser2;
    static User dept2SuperUser1;

    static COFOG_L2__c testCOFOG1; 

    static Programme__c programmeCreatedByDept1SuperUser1;

    static void setupUser(){
        TestDataFactory testFactory = new TestDataFactory();

        department1 = testFactory.createAccount('Department1','NEW_CPID_Department1');
        department1.Primary_Address_1__c = 'Unit 1, Horse Guards Rd';
        department1.Primary_Address_2__c = 'HM Treasury';
        department1.Primary_City__c = 'London';
        department1.Primary_County__c = 'Greater London';
        department1.Primary_Country__c = 'United Kingdom';
        department1.Primary_Postal_Code__c = 'SW1A 2HQ';
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
        testFactory.insertReferenceData();
        System.runAs(dept1SuperUser1){
            programmeCreatedByDept1SuperUser1 = testFactory.createProgramme('New Programme', 'PROG_ID_REF');
            insert programmeCreatedByDept1SuperUser1;
        }
    }

	@isTest
	static void testDeleteSuccess(){
        createData();
        System.runAs(dept1SuperUser1){
        	ProgrammeConfirmDeleteController controllerToUse = new ProgrammeConfirmDeleteController(
        		new ApexPages.StandardController(programmeCreatedByDept1SuperUser1)
        	);
        	System.assertNotEquals(null, controllerToUse.deleteRecord());
        }
	}
	@isTest
	static void testDeleteFail(){
        createData();
        Test.setCreatedDate(programmeCreatedByDept1SuperUser1.Id, Datetime.newInstance(2011, 3, 3));
        System.runAs(dept1SuperUser1){
        	Test.startTest();
	        	ProgrammeConfirmDeleteController controllerToUse = new ProgrammeConfirmDeleteController(
	        		new ApexPages.StandardController(programmeCreatedByDept1SuperUser1)
	        	);
	        	System.assertEquals(null, controllerToUse.deleteRecord());
        	Test.stopTest();
        }

	}
=======
<<<<<<< HEAD
/******************************************************************************************
@Author         Hamed Izadpanah
@Date           11/03/2016
@Project        Cloud Sherpas - GGIS
@Description    Test class responsible for unit testing of ProgrammeConfirmDeleteController
*******************************************************************************************/ 
@isTest
private class ProgrammeConfirmDeleteControllerTest{

    static Account department1;

    static User adminUser;
    static User dept1SuperUser1;
    static User dept1SuperUser2;
    static User dept2SuperUser1;

    static COFOG_L2__c testCOFOG1; 

    static Programme__c programmeCreatedByDept1SuperUser1;

    static void setupUser(){
        TestDataFactory testFactory = new TestDataFactory();

        department1 = testFactory.createAccount('Department1','NEW_CPID_Department1');
        department1.Primary_Address_1__c = 'Unit 1, Horse Guards Rd';
        department1.Primary_Address_2__c = 'HM Treasury';
        department1.Primary_City__c = 'London';
        department1.Primary_County__c = 'Greater London';
        department1.Primary_Country__c = 'United Kingdom';
        department1.Primary_Postal_Code__c = 'SW1A 2HQ';
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
        testFactory.insertReferenceData();
        System.runAs(dept1SuperUser1){
            programmeCreatedByDept1SuperUser1 = testFactory.createProgramme('New Programme', 'PROG_ID_REF');
            insert programmeCreatedByDept1SuperUser1;
        }
    }

	@isTest
	static void testDeleteSuccess(){
        createData();
        System.runAs(dept1SuperUser1){
        	ProgrammeConfirmDeleteController controllerToUse = new ProgrammeConfirmDeleteController(
        		new ApexPages.StandardController(programmeCreatedByDept1SuperUser1)
        	);
        	System.assertNotEquals(null, controllerToUse.deleteRecord());
        }
	}
	@isTest
	static void testDeleteFail(){
        createData();
        Test.setCreatedDate(programmeCreatedByDept1SuperUser1.Id, Datetime.newInstance(2011, 3, 3));
        System.runAs(dept1SuperUser1){
        	Test.startTest();
	        	ProgrammeConfirmDeleteController controllerToUse = new ProgrammeConfirmDeleteController(
	        		new ApexPages.StandardController(programmeCreatedByDept1SuperUser1)
	        	);
	        	System.assertEquals(null, controllerToUse.deleteRecord());
        	Test.stopTest();
        }

	}
=======
/******************************************************************************************
@Author         Hamed Izadpanah
@Date           11/03/2016
@Project        Cloud Sherpas - GGIS
@Description    Test class responsible for unit testing of ProgrammeConfirmDeleteController
*******************************************************************************************/ 
@isTest
private class ProgrammeConfirmDeleteControllerTest{

    static Account department1;

    static User adminUser;
    static User dept1SuperUser1;
    static User dept1SuperUser2;
    static User dept2SuperUser1;

    static COFOG_L2__c testCOFOG1; 

    static Programme__c programmeCreatedByDept1SuperUser1;

    static void setupUser(){
        TestDataFactory testFactory = new TestDataFactory();

        department1 = testFactory.createAccount('Department1','NEW_CPID_Department1');
        department1.Primary_Address_1__c = 'Unit 1, Horse Guards Rd';
        department1.Primary_Address_2__c = 'HM Treasury';
        department1.Primary_City__c = 'London';
        department1.Primary_County__c = 'Greater London';
        department1.Primary_Country__c = 'United Kingdom';
        department1.Primary_Postal_Code__c = 'SW1A 2HQ';
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
        testFactory.insertReferenceData();
        System.runAs(dept1SuperUser1){
            programmeCreatedByDept1SuperUser1 = testFactory.createProgramme('New Programme', 'PROG_ID_REF');
            insert programmeCreatedByDept1SuperUser1;
        }
    }

	@isTest
	static void testDeleteSuccess(){
        createData();
        System.runAs(dept1SuperUser1){
        	ProgrammeConfirmDeleteController controllerToUse = new ProgrammeConfirmDeleteController(
        		new ApexPages.StandardController(programmeCreatedByDept1SuperUser1)
        	);
        	System.assertNotEquals(null, controllerToUse.deleteRecord());
        }
	}
	@isTest
	static void testDeleteFail(){
        createData();
        Test.setCreatedDate(programmeCreatedByDept1SuperUser1.Id, Datetime.newInstance(2011, 3, 3));
        System.runAs(dept1SuperUser1){
        	Test.startTest();
	        	ProgrammeConfirmDeleteController controllerToUse = new ProgrammeConfirmDeleteController(
	        		new ApexPages.StandardController(programmeCreatedByDept1SuperUser1)
	        	);
	        	System.assertEquals(null, controllerToUse.deleteRecord());
        	Test.stopTest();
        }

	}
>>>>>>> refs/remotes/origin/master
>>>>>>> branch 'master' of https://github.com/cabinetoffice/Government-Grants-Information-System-Metadata
>>>>>>> branch 'master' of https://github.com/cabinetoffice/Government-Grants-Information-System-Metadata
>>>>>>> branch 'master' of https://github.com/cabinetoffice/Government-Grants-Information-System-Metadata
}