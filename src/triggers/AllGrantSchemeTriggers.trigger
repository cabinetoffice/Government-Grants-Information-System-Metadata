/******************************************************************************************
@Author         Hamed Izadpanah
@Date           28/09/2015
@Project        Cloud Sherpas Cabinet Office Data Source
@Description    Main entry for all the trigger events on Grant_Scheme__c object
*******************************************************************************************/
trigger AllGrantSchemeTriggers on Grant_Scheme__c (before insert, 
    before update, 
    before delete, 
    after insert, 
    after update, 
    after delete, 
    after undelete) {
        
    if(Configuration.areTriggersOff()){
        return;
    }

    if (Trigger.isBefore && Trigger.isDelete) {
        AllGrantSchemeTriggersHandler.handleBeforeDelete(Trigger.oldMap);
    }
    if (Trigger.isBefore && Trigger.isInsert) {
        AllGrantSchemeTriggersHandler.handleBeforeInsert(Trigger.new);
    }
    if (Trigger.isBefore && Trigger.isUpdate) {
        AllGrantSchemeTriggersHandler.handleBeforeUpdate(Trigger.new);
    }
}