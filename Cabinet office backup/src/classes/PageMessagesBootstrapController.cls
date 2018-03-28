/******************************************************************************************
@Author         Hamed Izadpanah
@Date           29/02/2016
@Project        Cloud Sherpas Cabinet Office Data Source
@Description    This is the custom controller for the Bootstrap page messages component
*******************************************************************************************/
public with sharing class PageMessagesBootstrapController {
    public Boolean getApexPagesHasMessage(){
        return ApexPages.hasMessages();
    }
}