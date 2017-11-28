@isTest
private class AvailableDeptForRegistrationCtrlTest{

	@testSetup()
	private static void setupTestData(){
		TestDataFactory testFactory = new TestDataFactory();
		Account funderAccount = testFactory.createAccount('New Funder', 'FUN123');
		Account testDepartment = testFactory.createAccount('My New Department', 'DEP123');
		testDepartment.CPID_from_OSCAR__c = '101.GROUP';
		insert new List<Account>{funderAccount, testDepartment};

		testDepartment.ParentId = funderAccount.Id;
		update testDepartment;
	}

	@isTest
	static void testGetJSON(){
		AvailableDeptForRegistrationCtrl controller = new AvailableDeptForRegistrationCtrl();
		System.assertNotEquals(null, controller.getJSON());
	}
}