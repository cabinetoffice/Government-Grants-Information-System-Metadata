/******************************************************************************************
@Author         Hamed Izadpanah
@Date           21/09/2015
@Project        Cloud Sherpas Cabinet Office Data Source
@Description    This is the unit test for the data solution login controller
*******************************************************************************************/
@isTest
private class DataSolutionLoginControllerTest
{
	
	@isTest
	static void testInvalidLogin(){
        DataSolutionLoginController controller = new DataSolutionLoginController();
        controller.username = 'test@salesforce.com';
        controller.password = '123456'; 
                
        System.assertEquals(controller.login(), null);   

	}
}