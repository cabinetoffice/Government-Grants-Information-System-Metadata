/******************************************************************************************
@Author         Hamed Izadpanah
@Date           11/03/2016
@Project        Cloud Sherpas - GGIS
@Description    This is the extension class to replace standard delete functionality
*******************************************************************************************/
public without sharing class ProgrammeConfirmDeleteController {
    private final ApexPages.StandardController stndController;

    public ProgrammeConfirmDeleteController(ApexPages.StandardController stndController) {
        this.stndController = stndController;
    }

    public PageReference deleteRecord() {
        try {
            Map<Id, SObject> programmesToDel = new Map<Id, SObject>();
            programmesToDel.put(stndController.getId(), stndController.getRecord());
            NotifyGrantDeletions notify = new NotifyGrantDeletions();
            notify.notifyGrantHubSupport(programmesToDel);
            delete stndController.getRecord();
        } catch (DmlException exceptionToHandle) {
            ApexPages.addMessages(exceptionToHandle);
            return null;
        }
        return stndController.cancel();
    }
}