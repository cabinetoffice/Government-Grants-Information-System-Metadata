/******************************************************************************************
@Author         Hamed Izadpanah
@Date           03/10/2015
@Project        Cloud Sherpas Cabinet Office Data Source
@Description    This is a batch processor which is used to process a large number of CSV rows
*******************************************************************************************/
public with sharing class CSVUploadProcessor implements Database.Batchable<CSVDocument.CSVRow>, Database.Stateful{

	private CSVDocument documentToUpload;
	
	private List<CSVDocument.CSVRow> rowsWithError = new List<CSVDocument.CSVRow>();

	CSVUploadSObjectFactory sobjectFactory; 
	public CSVUploadProcessor(CSVDocument documentToUpload, CSVUploadSObjectFactory sobjectFactory) {
		this.documentToUpload = documentToUpload;
		this.sobjectFactory = sobjectFactory;
	}

	public Iterable<CSVDocument.CSVRow> start(Database.BatchableContext bc) {
		CSV_Upload__c csvUploadToUpsert = new CSV_Upload__c(
			Processing_Status__c = Constant.CSV_UPLOAD_PT_STARTED,
			Type__c = sobjectFactory.getType(),
			Apex_Batch_Id__c = Id.valueOf(bc.getJobId())
		);
		upsert csvUploadToUpsert Apex_Batch_Id__c;
		return documentToUpload.allRows;
	} 

	public void execute(Database.BatchableContext bc, List<CSVDocument.CSVRow> csvRows){
		List<Grant_Award__c> grantAwardsToInsert = new List<Grant_Award__c>();
		Integer failedRecordsCount = 0;
		//CSVUploadSObjectFactory sobjectFactory = mapping.getSObjectFactory();
		for(CSVDocument.CSVRow rowToHandle : csvRows){
			List<String> errorMessages = new List<String>();
			SavePoint sp = Database.setSavePoint();
			try{
				sobjectFactory.build(rowToHandle);
			} catch (DmlException exceptionToHanlde){
				for(Integer i = 0; i < exceptionToHanlde.getNumDml(); i++){
					errorMessages.add(exceptionToHanlde.getDmlMessage(i));
				}
			} catch(Exception exceptionToHandle){
				errorMessages.add(exceptionToHandle.getMessage());
			}
			if(!errorMessages.isEmpty()){
				failedRecordsCount++;
				while(rowToHandle.columnValues.size() < rowToHandle.columnNames.size()){
					rowToHandle.columnValues.add(null);
				}
				String errorMessageToAdd = String.join(errorMessages, '; ');
				rowToHandle.columnValues.add(errorMessageToAdd);
				rowsWithError.add(rowToHandle);
				Database.rollBack(sp);
			}
		}
		List<CSV_Upload__c> foundRelatedCSVUploads = [
			SELECT Id, Records_Created_Count__c, Records_Updated_Count__c, Total_Records_Failed__c 
			FROM CSV_Upload__c WHERE Apex_Batch_Id__c = :Id.valueOf(bc.getJobId())
			LIMIT 1
		];
		if(!foundRelatedCSVUploads.isEmpty()){
			CSV_Upload__c csvUploadToChange = foundRelatedCSVUploads[0];
			sobjectFactory.addOperationsCountDetails(csvUploadToChange);
			csvUploadToChange.Total_Records_Failed__c = csvUploadToChange.Total_Records_Failed__c + failedRecordsCount;
			csvUploadToChange.Processing_Status__c = Constant.CSV_UPLOAD_PT_IN_PROGRESS;
			update csvUploadToChange;
		}
	}

	public void finish(Database.BatchableContext bc){
		CSV_Upload__c csvUploadToUpsert = new CSV_Upload__c(
			Processing_Status__c = Constant.CSV_UPLOAD_PT_FINISHED,
			Apex_Batch_Id__c = Id.valueOf(bc.getJobId())
		);
		upsert csvUploadToUpsert Apex_Batch_Id__c;
		if(!rowsWithError.isEmpty()){
			List<String> csvColumnNames = rowsWithError[0].columnNames;
			csvColumnNames.add('Error Details');
			CSVDocument errorCSVDocument = new CSVDocument(csvColumnNames, rowsWithError);
			insert new Attachment(
				Name = 'error-file.csv',
				Body = Blob.valueOf(errorCSVDocument.convertToString()),
				ParentId = csvUploadToUpsert.Id
			);
		}
	}
}