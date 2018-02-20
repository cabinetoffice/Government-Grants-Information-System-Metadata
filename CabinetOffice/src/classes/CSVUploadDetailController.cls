/******************************************************************************************
@Author         Hamed Izadpanah
@Date           03/10/2015
@Project        Cloud Sherpas Cabinet Office Data Source
@Description    This is the page which override the default view page for CSV Upload object
*******************************************************************************************/
public with sharing class CSVUploadDetailController {

	private final ApexPages.StandardController stndController;

	public CSVUploadDetailController(ApexPages.StandardController stndController) {
		this.stndController = stndController;
	}
	
	public PageReference checkCSVUploadRecord(){
		Boolean newCSVUpload = String.isBlank(stndController.getId());
		CSV_Upload__c csvUploadToCheck = (CSV_Upload__c) stndController.getRecord();
		Boolean existingValidatedOnly = csvUploadToCheck.Processing_Status__c == Constant.CSV_UPLOAD_PT_VALIDATED;
		PageReference newCSVUploadPage = Page.CSVUploadNew;
		if(!newCSVUpload){
			newCSVUploadPage.getParameters().put('id', stndController.getId());
		}

		return newCSVUpload || existingValidatedOnly ? newCSVUploadPage : null;
	}

	private static List<AsyncApexJob> queriedBatchJobDetails;
	private static List<AsyncApexJob> queryBatchJobDetails(String apexJobIdToQuery){
		if(queriedBatchJobDetails == null){
			queriedBatchJobDetails = [
				SELECT TotalJobItems, JobItemsProcessed
				From AsyncApexJob
				WHERE Id = :apexJobIdToQuery
				LIMIT 1
			];
		}
		return queriedBatchJobDetails;
	}
	public Integer getTotalJobItems(){
		CSV_Upload__c csvUpload = (CSV_Upload__c) stndController.getRecord();
		return queryBatchJobDetails(csvUpload.Apex_Batch_Id__c).isEmpty() ? 100 : queryBatchJobDetails(csvUpload.Apex_Batch_Id__c)[0].TotalJobItems;
	}
	public Integer getJobItemsProcessed(){
		CSV_Upload__c csvUpload = (CSV_Upload__c) stndController.getRecord();
		return queryBatchJobDetails(csvUpload.Apex_Batch_Id__c).isEmpty() ? 100 : queryBatchJobDetails(csvUpload.Apex_Batch_Id__c)[0].JobItemsProcessed;
	}

	public void reset(){
		stndController.reset();
	}

	public List<Attachment> getRelatedAttachments(){
		return [
			SELECT Id, Name, CreatedDate, CreatedById
			FROM Attachment
			WHERE ParentId = :stndController.getId()
		];
	}

}