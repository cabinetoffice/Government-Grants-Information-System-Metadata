/******************************************************************************************
@Author         Hamed Izadpanah
@Date           21/09/2015
@Project        Cloud Sherpas Cabinet Office Data Source
@Description    This is the unit test for the data solution registration controller
*******************************************************************************************/
@isTest
private class DataSolutionRegistrationControllerTest {
<<<<<<< HEAD
    private static Account account;

    private static void createData() {
        account = new Account();
        account.Name = 'Test Organisation';
        account.Organisation_Type_Code__c = 'CG';
        account.Organisation_Sub_Type_Code__c = 'DEPT';
        account.CPID_from_OSCAR__c = 'TST010';
        account.Type__c = 'Funder';

        insert account;
    }

    @isTest
    static void testSaveNewRegistration() {
        createData();
        DataSolutionRegistrationController controller = new DataSolutionRegistrationController();
        controller.firstName = 'test';
        controller.lastName = 'lastName';
        controller.selectedDepartmentId = account.Id;
        controller.emailAddress = 'tst@gmail1.com';
        controller.ggisRole = 'Super User';
        controller.businessArea = 'Policy';

        controller.saveUser();

        Test.startTest();
            List<Contact> tstContact = [SELECT FirstName, LastName, Email, AccountId, User_Organisation_Type__c, Business_Area__c 
                                FROM Contact
                                WHERE AccountId =: account.Id];

            System.assertEquals('tst@gmail1.com', tstContact[0].Email);

        Test.stopTest();
    }
    
    @isTest
    static void testSaveNewRegistationNoAccontMatch() {
        createData();
        DataSolutionRegistrationController controller = new DataSolutionRegistrationController();
        controller.firstName = 'test';
        controller.lastName = 'lastName';
        controller.emailAddress = 'tst@gmail1.com';
        controller.ggisRole = 'Standard User';
        controller.businessArea = 'Policy';

        try {
            Test.startTest();
                controller.saveUser();
            Test.stopTest();
        } catch (Exception e) {
            System.assertEquals(System.Label.DT_User_Registration_No_Organisation_Error_Message,
                    ApexPages.getMessages()[0].getDetail());
        } 
    }

    @isTest
    static void testSaveNewRegistationNoUserType() {
        createData();
        DataSolutionRegistrationController controller = new DataSolutionRegistrationController();
        controller.firstName = 'test';
        controller.lastName = 'lastName';
        controller.emailAddress = 'tst@gmail1.com';
        controller.selectedDepartmentId = account.Id;
        controller.businessArea = 'Policy';

        try {
            Test.startTest();
                controller.saveUser();
            Test.stopTest();
        } catch (Exception e) {
            System.assertEquals(System.Label.DT_User_Registration_No_User_Type_Error_Message,
                    ApexPages.getMessages()[0].getDetail());
        } 
    }

    @isTest
    static void testSaveNewRegistationNoBusinessArea() {
        createData();
        DataSolutionRegistrationController controller = new DataSolutionRegistrationController();
        controller.firstName = 'test';
        controller.lastName = 'lastName';
        controller.emailAddress = 'tst@gmail1.com';
        controller.selectedDepartmentId = account.Id;
        controller.ggisRole = 'Central User';

        try {
            Test.startTest();
                controller.saveUser();
            Test.stopTest();
        } catch (Exception e) {
            System.assertEquals(System.Label.DT_User_Registration_No_Business_Area_Error_Message,
                    ApexPages.getMessages()[0].getDetail());
        } 
    }

    @isTest
    static void testSaveNewRegistationNoRolesSelected() {
        createData();
        DataSolutionRegistrationController controller = new DataSolutionRegistrationController();
        controller.firstName = 'test';
        controller.lastName = 'lastName';
        controller.emailAddress = 'tst@gmail1@.com';
        controller.selectedDepartmentId = account.Id;
        controller.businessArea = 'Policy';

        try {
            Test.startTest();
                controller.saveUser();
            Test.stopTest();
        } catch (Exception e) {
            System.assertEquals(System.Label.DT_User_Registration_Internal_Error_Message, ApexPages.getMessages()[0].getDetail());
        } 
    }

    @isTest 
    static void testGetRoles() {
        DataSolutionRegistrationController controller = new DataSolutionRegistrationController();
        System.assertEquals(3, controller.getRoles().size());
    }
=======
<<<<<<< HEAD
    private static Account account;

    private static void createData() {
        account = new Account();
        account.Name = 'Test Organisation';
        account.Organisation_Type_Code__c = 'CG';
        account.Organisation_Sub_Type_Code__c = 'DEPT';
        account.CPID_from_OSCAR__c = 'TST010';
        account.Type__c = 'Funder';

        insert account;
    }

    @isTest
    static void testSaveNewRegistration() {
        createData();
        DataSolutionRegistrationController controller = new DataSolutionRegistrationController();
        controller.firstName = 'test';
        controller.lastName = 'lastName';
        controller.selectedDepartmentId = account.Id;
        controller.emailAddress = 'tst@gmail1.com';
        controller.ggisRole = 'Super User';
        controller.businessArea = 'Policy';

        controller.saveUser();

        Test.startTest();
            List<Contact> tstContact = [SELECT FirstName, LastName, Email, AccountId, User_Organisation_Type__c, Business_Area__c 
                                FROM Contact
                                WHERE AccountId =: account.Id];

            System.assertEquals('tst@gmail1.com', tstContact[0].Email);

        Test.stopTest();
    }
    
    @isTest
    static void testSaveNewRegistationNoAccontMatch() {
        createData();
        DataSolutionRegistrationController controller = new DataSolutionRegistrationController();
        controller.firstName = 'test';
        controller.lastName = 'lastName';
        controller.emailAddress = 'tst@gmail1.com';
        controller.ggisRole = 'Standard User';
        controller.businessArea = 'Policy';

        try {
            Test.startTest();
                controller.saveUser();
            Test.stopTest();
        } catch (Exception e) {
            System.assertEquals(System.Label.DT_User_Registration_No_Organisation_Error_Message,
                    ApexPages.getMessages()[0].getDetail());
        } 
    }

    @isTest
    static void testSaveNewRegistationNoUserType() {
        createData();
        DataSolutionRegistrationController controller = new DataSolutionRegistrationController();
        controller.firstName = 'test';
        controller.lastName = 'lastName';
        controller.emailAddress = 'tst@gmail1.com';
        controller.selectedDepartmentId = account.Id;
        controller.businessArea = 'Policy';

        try {
            Test.startTest();
                controller.saveUser();
            Test.stopTest();
        } catch (Exception e) {
            System.assertEquals(System.Label.DT_User_Registration_No_User_Type_Error_Message,
                    ApexPages.getMessages()[0].getDetail());
        } 
    }

    @isTest
    static void testSaveNewRegistationNoBusinessArea() {
        createData();
        DataSolutionRegistrationController controller = new DataSolutionRegistrationController();
        controller.firstName = 'test';
        controller.lastName = 'lastName';
        controller.emailAddress = 'tst@gmail1.com';
        controller.selectedDepartmentId = account.Id;
        controller.ggisRole = 'Central User';

        try {
            Test.startTest();
                controller.saveUser();
            Test.stopTest();
        } catch (Exception e) {
            System.assertEquals(System.Label.DT_User_Registration_No_Business_Area_Error_Message,
                    ApexPages.getMessages()[0].getDetail());
        } 
    }

    @isTest
    static void testSaveNewRegistationNoRolesSelected() {
        createData();
        DataSolutionRegistrationController controller = new DataSolutionRegistrationController();
        controller.firstName = 'test';
        controller.lastName = 'lastName';
        controller.emailAddress = 'tst@gmail1@.com';
        controller.selectedDepartmentId = account.Id;
        controller.businessArea = 'Policy';

        try {
            Test.startTest();
                controller.saveUser();
            Test.stopTest();
        } catch (Exception e) {
            System.assertEquals(System.Label.DT_User_Registration_Internal_Error_Message, ApexPages.getMessages()[0].getDetail());
        } 
    }

    @isTest 
    static void testGetRoles() {
        DataSolutionRegistrationController controller = new DataSolutionRegistrationController();
        System.assertEquals(3, controller.getRoles().size());
    }
=======
<<<<<<< HEAD
    private static Account account;

    private static void createData() {
        account = new Account();
        account.Name = 'Test Organisation';
        account.Organisation_Type_Code__c = 'CG';
        account.Organisation_Sub_Type_Code__c = 'DEPT';
        account.CPID_from_OSCAR__c = 'TST010';
        account.Type__c = 'Funder';

        insert account;
    }

    @isTest
    static void testSaveNewRegistration() {
        createData();
        DataSolutionRegistrationController controller = new DataSolutionRegistrationController();
        controller.firstName = 'test';
        controller.lastName = 'lastName';
        controller.selectedDepartmentId = account.Id;
        controller.emailAddress = 'tst@gmail1.com';
        controller.ggisRole = 'Super User';
        controller.businessArea = 'Policy';

        controller.saveUser();

        Test.startTest();
            List<Contact> tstContact = [SELECT FirstName, LastName, Email, AccountId, User_Organisation_Type__c, Business_Area__c 
                                FROM Contact
                                WHERE AccountId =: account.Id];

            System.assertEquals('tst@gmail1.com', tstContact[0].Email);

        Test.stopTest();
    }
    
    @isTest
    static void testSaveNewRegistationNoAccontMatch() {
        createData();
        DataSolutionRegistrationController controller = new DataSolutionRegistrationController();
        controller.firstName = 'test';
        controller.lastName = 'lastName';
        controller.emailAddress = 'tst@gmail1.com';
        controller.ggisRole = 'Standard User';
        controller.businessArea = 'Policy';

        try {
            Test.startTest();
                controller.saveUser();
            Test.stopTest();
        } catch (Exception e) {
            System.assertEquals(System.Label.DT_User_Registration_No_Organisation_Error_Message,
                    ApexPages.getMessages()[0].getDetail());
        } 
    }

    @isTest
    static void testSaveNewRegistationNoUserType() {
        createData();
        DataSolutionRegistrationController controller = new DataSolutionRegistrationController();
        controller.firstName = 'test';
        controller.lastName = 'lastName';
        controller.emailAddress = 'tst@gmail1.com';
        controller.selectedDepartmentId = account.Id;
        controller.businessArea = 'Policy';

        try {
            Test.startTest();
                controller.saveUser();
            Test.stopTest();
        } catch (Exception e) {
            System.assertEquals(System.Label.DT_User_Registration_No_User_Type_Error_Message,
                    ApexPages.getMessages()[0].getDetail());
        } 
    }

    @isTest
    static void testSaveNewRegistationNoBusinessArea() {
        createData();
        DataSolutionRegistrationController controller = new DataSolutionRegistrationController();
        controller.firstName = 'test';
        controller.lastName = 'lastName';
        controller.emailAddress = 'tst@gmail1.com';
        controller.selectedDepartmentId = account.Id;
        controller.ggisRole = 'Central User';

        try {
            Test.startTest();
                controller.saveUser();
            Test.stopTest();
        } catch (Exception e) {
            System.assertEquals(System.Label.DT_User_Registration_No_Business_Area_Error_Message,
                    ApexPages.getMessages()[0].getDetail());
        } 
    }

    @isTest
    static void testSaveNewRegistationNoRolesSelected() {
        createData();
        DataSolutionRegistrationController controller = new DataSolutionRegistrationController();
        controller.firstName = 'test';
        controller.lastName = 'lastName';
        controller.emailAddress = 'tst@gmail1@.com';
        controller.selectedDepartmentId = account.Id;
        controller.businessArea = 'Policy';

        try {
            Test.startTest();
                controller.saveUser();
            Test.stopTest();
        } catch (Exception e) {
            System.assertEquals(System.Label.DT_User_Registration_Internal_Error_Message, ApexPages.getMessages()[0].getDetail());
        } 
    }

    @isTest 
    static void testGetRoles() {
        DataSolutionRegistrationController controller = new DataSolutionRegistrationController();
        System.assertEquals(3, controller.getRoles().size());
    }
=======
<<<<<<< HEAD
    private static Account account;

    private static void createData() {
        account = new Account();
        account.Name = 'Test Organisation';
        account.Organisation_Type_Code__c = 'CG';
        account.Organisation_Sub_Type_Code__c = 'DEPT';
        account.CPID_from_OSCAR__c = 'TST010';
        account.Type__c = 'Funder';

        insert account;
    }

    @isTest
    static void testSaveNewRegistration() {
        createData();
        DataSolutionRegistrationController controller = new DataSolutionRegistrationController();
        controller.firstName = 'test';
        controller.lastName = 'lastName';
        controller.selectedDepartmentId = account.Id;
        controller.emailAddress = 'tst@gmail1.com';
        controller.ggisRole = 'Super User';
        controller.businessArea = 'Policy';

        controller.saveUser();

        Test.startTest();
            List<Contact> tstContact = [SELECT FirstName, LastName, Email, AccountId, User_Organisation_Type__c, Business_Area__c 
                                FROM Contact
                                WHERE AccountId =: account.Id];

            System.assertEquals('tst@gmail1.com', tstContact[0].Email);

        Test.stopTest();
    }
    
    @isTest
    static void testSaveNewRegistationNoAccontMatch() {
        createData();
        DataSolutionRegistrationController controller = new DataSolutionRegistrationController();
        controller.firstName = 'test';
        controller.lastName = 'lastName';
        controller.emailAddress = 'tst@gmail1.com';
        controller.ggisRole = 'Standard User';
        controller.businessArea = 'Policy';

        try {
            Test.startTest();
                controller.saveUser();
            Test.stopTest();
        } catch (Exception e) {
            System.assertEquals(System.Label.DT_User_Registration_No_Organisation_Error_Message,
                    ApexPages.getMessages()[0].getDetail());
        } 
    }

    @isTest
    static void testSaveNewRegistationNoUserType() {
        createData();
        DataSolutionRegistrationController controller = new DataSolutionRegistrationController();
        controller.firstName = 'test';
        controller.lastName = 'lastName';
        controller.emailAddress = 'tst@gmail1.com';
        controller.selectedDepartmentId = account.Id;
        controller.businessArea = 'Policy';

        try {
            Test.startTest();
                controller.saveUser();
            Test.stopTest();
        } catch (Exception e) {
            System.assertEquals(System.Label.DT_User_Registration_No_User_Type_Error_Message,
                    ApexPages.getMessages()[0].getDetail());
        } 
    }

    @isTest
    static void testSaveNewRegistationNoBusinessArea() {
        createData();
        DataSolutionRegistrationController controller = new DataSolutionRegistrationController();
        controller.firstName = 'test';
        controller.lastName = 'lastName';
        controller.emailAddress = 'tst@gmail1.com';
        controller.selectedDepartmentId = account.Id;
        controller.ggisRole = 'Central User';

        try {
            Test.startTest();
                controller.saveUser();
            Test.stopTest();
        } catch (Exception e) {
            System.assertEquals(System.Label.DT_User_Registration_No_Business_Area_Error_Message,
                    ApexPages.getMessages()[0].getDetail());
        } 
    }

    @isTest
    static void testSaveNewRegistationNoRolesSelected() {
        createData();
        DataSolutionRegistrationController controller = new DataSolutionRegistrationController();
        controller.firstName = 'test';
        controller.lastName = 'lastName';
        controller.emailAddress = 'tst@gmail1@.com';
        controller.selectedDepartmentId = account.Id;
        controller.businessArea = 'Policy';

        try {
            Test.startTest();
                controller.saveUser();
            Test.stopTest();
        } catch (Exception e) {
            System.assertEquals(System.Label.DT_User_Registration_Internal_Error_Message, ApexPages.getMessages()[0].getDetail());
        } 
    }

    @isTest 
    static void testGetRoles() {
        DataSolutionRegistrationController controller = new DataSolutionRegistrationController();
        System.assertEquals(3, controller.getRoles().size());
    }
=======
	private static Account account;

	private static void createData() {
		account = new Account();
		account.Name = 'Test Organisation';
		account.Organisation_Type_Code__c = 'CG';
		account.Organisation_Sub_Type_Code__c = 'DEPT';
		account.CPID_from_OSCAR__c = 'TST010';
		account.Type__c = 'Funder';

		insert account;
	}

	@isTest
	static void testSaveNewRegistration() {
		createData();
		DataSolutionRegistrationController controller = new DataSolutionRegistrationController();
		controller.firstName = 'test';
		controller.lastName = 'lastName';
		controller.selectedDepartmentId = account.Id;
		controller.emailAddress = 'tst@gmail1.com';
		controller.ggisRole = 'Super User';
		controller.businessArea = 'Policy';

		controller.saveUser();

		Test.startTest();
			List<Contact> tstContact = [SELECT FirstName, LastName, Email, AccountId, User_Organisation_Type__c, Business_Area__c 
								FROM Contact
								WHERE AccountId =: account.Id];

			System.assertEquals('tst@gmail1.com', tstContact[0].Email);

		Test.stopTest();
	}
	
	@isTest
	static void testSaveNewRegistationNoAccontMatch() {
		createData();
		DataSolutionRegistrationController controller = new DataSolutionRegistrationController();
		controller.firstName = 'test';
		controller.lastName = 'lastName';
		controller.emailAddress = 'tst@gmail1.com';
		controller.ggisRole = 'Standard User';
		controller.businessArea = 'Policy';

		try {
			Test.startTest();
				controller.saveUser();
			Test.stopTest();
		} catch (Exception e) {
			System.assertEquals(System.Label.DT_User_Registration_No_Organisation_Error_Message,
					ApexPages.getMessages()[0].getDetail());
		} 
	}

	@isTest
	static void testSaveNewRegistationNoUserType() {
		createData();
		DataSolutionRegistrationController controller = new DataSolutionRegistrationController();
		controller.firstName = 'test';
		controller.lastName = 'lastName';
		controller.emailAddress = 'tst@gmail1.com';
		controller.selectedDepartmentId = account.Id;
		controller.businessArea = 'Policy';

		try {
			Test.startTest();
				controller.saveUser();
			Test.stopTest();
		} catch (Exception e) {
			System.assertEquals(System.Label.DT_User_Registration_No_User_Type_Error_Message,
					ApexPages.getMessages()[0].getDetail());
		} 
	}

	@isTest
	static void testSaveNewRegistationNoBusinessArea() {
		createData();
		DataSolutionRegistrationController controller = new DataSolutionRegistrationController();
		controller.firstName = 'test';
		controller.lastName = 'lastName';
		controller.emailAddress = 'tst@gmail1.com';
		controller.selectedDepartmentId = account.Id;
		controller.ggisRole = 'Central User';

		try {
			Test.startTest();
				controller.saveUser();
			Test.stopTest();
		} catch (Exception e) {
			System.assertEquals(System.Label.DT_User_Registration_No_Business_Area_Error_Message,
					ApexPages.getMessages()[0].getDetail());
		} 
	}

	@isTest
	static void testSaveNewRegistationNoRolesSelected() {
		createData();
		DataSolutionRegistrationController controller = new DataSolutionRegistrationController();
		controller.firstName = 'test';
		controller.lastName = 'lastName';
		controller.emailAddress = 'tst@gmail1@.com';
		controller.selectedDepartmentId = account.Id;
		controller.businessArea = 'Policy';

		try {
			Test.startTest();
				controller.saveUser();
			Test.stopTest();
		} catch (Exception e) {
			System.assertEquals(System.Label.DT_User_Registration_Internal_Error_Message, ApexPages.getMessages()[0].getDetail());
		} 
	}

	@isTest 
	static void testGetRoles() {
		DataSolutionRegistrationController controller = new DataSolutionRegistrationController();
		System.assertEquals(4, controller.getRoles().size());
	}
>>>>>>> refs/remotes/origin/master
>>>>>>> branch 'master' of https://github.com/cabinetoffice/Government-Grants-Information-System-Metadata
>>>>>>> branch 'master' of https://github.com/cabinetoffice/Government-Grants-Information-System-Metadata
>>>>>>> branch 'master' of https://github.com/cabinetoffice/Government-Grants-Information-System-Metadata
}