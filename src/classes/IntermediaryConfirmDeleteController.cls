/******************************************************************************************
@Author         Hamed Izadpanah
@Date           10/03/2016
@Project        Cloud Sherpas - GGIS
@Description    This is the extension class to replace standard delete functionality
*******************************************************************************************/ 
public with sharing class IntermediaryConfirmDeleteController {
	private final ApexPages.StandardController stndController;

	public IntermediaryConfirmDeleteController(ApexPages.StandardController stndController) {
		this.stndController = stndController;
	}

	public PageReference deleteRecord(){
		try{
			delete stndController.getRecord();
		} catch(DmlException exceptionToHandle){
			ApexPages.addMessages(exceptionToHandle);
			return null;
		}
		return stndController.cancel();
	}
}