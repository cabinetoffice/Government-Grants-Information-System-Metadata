/******************************************************************************************
@Author         Hamed Izadpanah
@Date           22/01/2016
@Project        Cloud Sherpas - GGIS Beta
@Description    Main entry for all the trigger events on Proposed Grant object
*******************************************************************************************/
trigger AllProposedGrantTriggers on Proposed_Grant__c (
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

    if (Trigger.isBefore && Trigger.isDelete) {
        AllProposedGrantTriggersHandler.handleBeforeDelete(Trigger.oldMap);
    }
}