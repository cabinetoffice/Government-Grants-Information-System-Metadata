/******************************************************************************************
@Author         Hamed Izadpanah
@Date           28/09/2015
@Project        Cloud Sherpas Cabinet Office Data Source
@Description    Main entry for all the trigger events on Programme__c object
*******************************************************************************************/
trigger AllProgrammeTriggers on Programme__c (
    before insert, 
    before update, 
    before delete, 
    after insert, 
    after update, 
    after delete, 
    after undelete) {
        
    if(Configuration.areTriggersOff()){
        return;
    }

<<<<<<< HEAD
    if (Trigger.isBefore &Trigger.isDelete) {
=======
    if (Trigger.isBefore && Trigger.isDelete) {
>>>>>>> refs/remotes/origin/master
        AllProgrammeTriggersHandler.handleBeforeDelete(Trigger.oldMap);
    }
}