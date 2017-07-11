/******************************************************************************************
@Author         Hamed Izadpanah
@Date           03/10/2015
@Project        Cloud Sherpas Cabinet Office Data Source
@Description    This is the unit test for ProgressBarController class
*******************************************************************************************/
@isTest
private class ProgressBarControllerTest{

	@isTest
	static void testValidGetPercentage(){
		ProgressBarController controller = new ProgressBarController();
		controller.inputCompleteNumber = 100;
		controller.inputCurrentNumber = 50;
		System.assertEquals(50, controller.getProgressPercentage());
	}
	@isTest
	static void testInvalidGetPercentage(){
		ProgressBarController controller = new ProgressBarController();
		System.assertEquals(0, controller.getProgressPercentage());
	}
}