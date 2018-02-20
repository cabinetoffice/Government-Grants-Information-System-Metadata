/******************************************************************************************
@Author         Hamed Izadpanah
@Date           10/03/2016
@Project        Cloud Sherpas - GGIS
@Description    This is the extension class to replace standard delete functionality
*******************************************************************************************/
public with sharing class GrantAwardConfirmDeleteController {
    private final ApexPages.StandardController stndController;

    public GrantAwardConfirmDeleteController(ApexPages.StandardController stndController) {
        this.stndController = stndController;
    }

    public PageReference deleteRecord() {
        try {
            Map<Id, SObject> awardsToDel = new Map<Id, SObject>();
            awardsToDel.put(stndController.getId(), stndController.getRecord());
            NotifyGrantDeletions notify = new NotifyGrantDeletions();
            notify.notifyGrantHubSupport(awardsToDel);
            delete stndController.getRecord();
        } catch (DmlException exceptionToHandle) {
            ApexPages.addMessages(exceptionToHandle);
            return null;
        }
        return stndController.cancel();
    }
}