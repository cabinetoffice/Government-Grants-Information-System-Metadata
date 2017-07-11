/******************************************************************************************
@Author         Hamed Izadpanah
@Date           29/02/2016
@Project        Cloud Sherpas Cabinet Office Data Source
@Description    This is the unit test for the Bootstrap component's controller
*******************************************************************************************/
@isTest
private class PageMessagesBootstrapControllerTest{
	
	@isTest
	static void testGetApexPagesHasMessage(){
		PageMessagesBootstrapController controller = new PageMessagesBootstrapController();
		System.assertEquals(false, controller.getApexPagesHasMessage());
		ApexPages.addMessage(
			new ApexPages.Message(
				ApexPages.Severity.ERROR,
				'New Error Message'
			)
		);
		System.assertEquals(true, controller.getApexPagesHasMessage());
	}
}