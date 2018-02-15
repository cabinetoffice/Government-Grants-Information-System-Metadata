<<<<<<< HEAD
/******************************************************************************************
@Author         Hamed Izadpanah
@Date           28/09/2015
@Project        Cloud Sherpas Cabinet Office Data Source
@Description    This is the test unit for Configuration Class
*******************************************************************************************/
@isTest
private class ConfigurationTest{
	
	@isTest
	static void testAreTriggersOff(){
		System.assertEquals(false, Configuration.areTriggersOff());
		Configuration.turnBypassTriggersPermanently(true); 
		System.assertEquals(true, Configuration.areTriggersOff());
		Configuration.turnBypassTriggersPermanently(false); 
		System.assertEquals(false, Configuration.areTriggersOff());
	}
	@isTest
	static void testAreValidationsOff(){
		System.assertEquals(false, Configuration.areValidationsOff());
		Configuration.turnBypassValidationsPermanently(true); 
		System.assertEquals(true, Configuration.areValidationsOff());
		Configuration.turnBypassValidationsPermanently(false); 
		System.assertEquals(false, Configuration.areValidationsOff());
	}
=======
/******************************************************************************************
@Author         Hamed Izadpanah
@Date           28/09/2015
@Project        Cloud Sherpas Cabinet Office Data Source
@Description    This is the test unit for Configuration Class
*******************************************************************************************/
@isTest
private class ConfigurationTest{
	
	@isTest
	static void testAreTriggersOff(){
		System.assertEquals(false, Configuration.areTriggersOff());
		Configuration.turnBypassTriggersPermanently(true); 
		System.assertEquals(true, Configuration.areTriggersOff());
		Configuration.turnBypassTriggersPermanently(false); 
		System.assertEquals(false, Configuration.areTriggersOff());
	}
	@isTest
	static void testAreValidationsOff(){
		System.assertEquals(false, Configuration.areValidationsOff());
		Configuration.turnBypassValidationsPermanently(true); 
		System.assertEquals(true, Configuration.areValidationsOff());
		Configuration.turnBypassValidationsPermanently(false); 
		System.assertEquals(false, Configuration.areValidationsOff());
	}
>>>>>>> refs/remotes/origin/master
}