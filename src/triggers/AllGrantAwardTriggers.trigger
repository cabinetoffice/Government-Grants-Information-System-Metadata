/******************************************************************************************
@Author         Hamed Izadpanah
@Date           28/09/2015
@Project        Cloud Sherpas Cabinet Office Data Source
@Description    Main entry for all the trigger events on Grant_Award__c object
*******************************************************************************************/
trigger AllGrantAwardTriggers on Grant_Award__c (before insert, 
    before update, 
    before delete, 
    after insert, 
    after update, 
    after delete, 
    after undelete) {
        
    if(Configuration.areTriggersOff()){
        return;
    }

    if (Trigger.isBefore && Trigger.isInsert) {
        AllGrantAwardTriggersHandler.handleBeforeInsert(Trigger.new);
    }
    if (Trigger.isBefore && Trigger.isUpdate) {
        AllGrantAwardTriggersHandler.handleBeforeUpdate(Trigger.new, Trigger.oldMap);
    }

    if (Trigger.isBefore && Trigger.isDelete) {
        AllGrantAwardTriggersHandler.handleBeforeDelete(Trigger.oldMap);
    }
}