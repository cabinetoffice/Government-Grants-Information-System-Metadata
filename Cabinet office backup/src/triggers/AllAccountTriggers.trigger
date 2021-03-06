/******************************************************************************************
@Author         Hamed Izadpanah
@Date           28/09/2015
@Project        Cloud Sherpas Cabinet Office Data Source
@Description    Main entry for all the trigger events on Account object
*******************************************************************************************/
trigger AllAccountTriggers on Account (
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

	if (Trigger.isBefore &Trigger.isDelete) {
    	AllAccountTriggersHandler.handleBeforeDelete(Trigger.oldMap);
	}
}