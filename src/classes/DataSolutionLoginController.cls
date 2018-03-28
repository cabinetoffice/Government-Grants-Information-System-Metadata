/******************************************************************************************
@Author         Hamed Izadpanah
@Date           21/09/2015
@Project        Cloud Sherpas Cabinet Office Data Source
@Description    This is the standard login controller for the Data Solution portal login
*******************************************************************************************/
global with sharing class DataSolutionLoginController {
    global String username {get; set;}
    global String password {get; set;}

    global PageReference login() {
        return Site.login(username, password, Label.DT_App_Launcher_URL);
    }
	
}