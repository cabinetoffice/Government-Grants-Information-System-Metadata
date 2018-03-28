<<<<<<< HEAD
/******************************************************************************************
@Author         Hamed Izadpanah
@Date           03/10/2015
@Project        Cloud Sherpas Cabinet Office Data Source
@Description    This is the main mapping class which is a wrapper around a list of 
				CSV Upload mapping custom settings
*******************************************************************************************/
public with sharing class CSVUploadMapping {

	List<CSV_Upload_Mapping_Column__c> allMappingColumns;
	public CSVUploadMapping(List<CSV_Upload_Mapping_Column__c> allMappingColumns) {
		this.allMappingColumns = allMappingColumns;
	}
	public CSVUploadMapping(CSV_Upload__c csvUploadProcess) {
		this.allMappingColumns = [
			SELECT Id, Mapped_From_Field__c, SObject_Type__c, Mapped_To_Field__c, Required__c, SObject_Creator__c,
			Value_Parser__c, External_Id_Type_Column__c, Query_Result_Id_Mapped_to_Field__c, Record_Locator_Query__c, 
			Not_Found_Error_Message__c, Run_SObject_Creator_On_Record_Not_Found__c, Group__c, Read_Only__c, Accept_Multi_Values__c
			FROM CSV_Upload_Mapping_Column__c
			WHERE CSV_Upload_Type__c = :csvUploadProcess.Type__c
			AND CSV_Upload_Recipient_Type__c = :csvUploadProcess.Recipient_Type__c
			ORDER BY SObject_Creator__c, Mapped_To_Field__c
		];
	}

	public List<CSV_Upload_Mapping_Column__c> getRequiredMappingColumns(){
		List<CSV_Upload_Mapping_Column__c> returnValue = new List<CSV_Upload_Mapping_Column__c>();
		for(CSV_Upload_Mapping_Column__c columnToCheck : allMappingColumns){
			if(columnToCheck.Required__c){
				returnValue.add(columnToCheck);
			}
		}
		return returnValue;
	}
	public List<CSV_Upload_Mapping_Column__c> getColumnsSObjectCreator(String creatorName){
		List<CSV_Upload_Mapping_Column__c> returnValue = new List<CSV_Upload_Mapping_Column__c>();
		for(CSV_Upload_Mapping_Column__c columnToCheck : allMappingColumns){
			if(columnToCheck.SObject_Creator__c.equalsIgnoreCase(creatorName)){
				returnValue.add(columnToCheck);
			}
		}
		return returnValue;
	}
	public List<CSV_Upload_Mapping_Column__c> getColumnsSObjectCreator(Decimal groupNoDecimal, String creatorName){
		List<CSV_Upload_Mapping_Column__c> returnValue = new List<CSV_Upload_Mapping_Column__c>();
		for(CSV_Upload_Mapping_Column__c columnToCheck : allMappingColumns){
			if(columnToCheck.Group__c == groupNoDecimal && columnToCheck.SObject_Creator__c.equalsIgnoreCase(creatorName)){
				returnValue.add(columnToCheck);
			}
		}
		return returnValue;
	}
	public List<CSV_Upload_Mapping_Column__c> getExternalIdTypeField(){
		List<CSV_Upload_Mapping_Column__c> returnValue = new List<CSV_Upload_Mapping_Column__c>();
		for(CSV_Upload_Mapping_Column__c columnToCheck : allMappingColumns){
			if(columnToCheck.External_Id_Type_Column__c){
				returnValue.add(columnToCheck);
			}
		}
		return returnValue;
	}
	public List<CSV_Upload_Mapping_Column__c> getExternalIdFields(){
		List<CSV_Upload_Mapping_Column__c> returnValue = new List<CSV_Upload_Mapping_Column__c>();
		for(CSV_Upload_Mapping_Column__c columnToCheck : allMappingColumns){
			if(columnToCheck.External_Id_Type_Column__c){
				returnValue.add(columnToCheck);
			}
		}
		return returnValue;
	}
	public List<CSV_Upload_Mapping_Column__c> getMappedFields(){
		List<CSV_Upload_Mapping_Column__c> returnValue = new List<CSV_Upload_Mapping_Column__c>();
		for(CSV_Upload_Mapping_Column__c columnToCheck : allMappingColumns){
			if(!columnToCheck.External_Id_Type_Column__c){
				returnValue.add(columnToCheck);
			}
		}
		return returnValue;
	}
=======
<<<<<<< HEAD
/******************************************************************************************
@Author         Hamed Izadpanah
@Date           03/10/2015
@Project        Cloud Sherpas Cabinet Office Data Source
@Description    This is the main mapping class which is a wrapper around a list of 
				CSV Upload mapping custom settings
*******************************************************************************************/
public with sharing class CSVUploadMapping {

	List<CSV_Upload_Mapping_Column__c> allMappingColumns;
	public CSVUploadMapping(List<CSV_Upload_Mapping_Column__c> allMappingColumns) {
		this.allMappingColumns = allMappingColumns;
	}
	public CSVUploadMapping(CSV_Upload__c csvUploadProcess) {
		this.allMappingColumns = [
			SELECT Id, Mapped_From_Field__c, SObject_Type__c, Mapped_To_Field__c, Required__c, SObject_Creator__c,
			Value_Parser__c, External_Id_Type_Column__c, Query_Result_Id_Mapped_to_Field__c, Record_Locator_Query__c, 
			Not_Found_Error_Message__c, Run_SObject_Creator_On_Record_Not_Found__c, Group__c, Read_Only__c, Accept_Multi_Values__c
			FROM CSV_Upload_Mapping_Column__c
			WHERE CSV_Upload_Type__c = :csvUploadProcess.Type__c
			AND CSV_Upload_Recipient_Type__c = :csvUploadProcess.Recipient_Type__c
			ORDER BY SObject_Creator__c, Mapped_To_Field__c
		];
	}

	public List<CSV_Upload_Mapping_Column__c> getRequiredMappingColumns(){
		List<CSV_Upload_Mapping_Column__c> returnValue = new List<CSV_Upload_Mapping_Column__c>();
		for(CSV_Upload_Mapping_Column__c columnToCheck : allMappingColumns){
			if(columnToCheck.Required__c){
				returnValue.add(columnToCheck);
			}
		}
		return returnValue;
	}
	public List<CSV_Upload_Mapping_Column__c> getColumnsSObjectCreator(String creatorName){
		List<CSV_Upload_Mapping_Column__c> returnValue = new List<CSV_Upload_Mapping_Column__c>();
		for(CSV_Upload_Mapping_Column__c columnToCheck : allMappingColumns){
			if(columnToCheck.SObject_Creator__c.equalsIgnoreCase(creatorName)){
				returnValue.add(columnToCheck);
			}
		}
		return returnValue;
	}
	public List<CSV_Upload_Mapping_Column__c> getColumnsSObjectCreator(Decimal groupNoDecimal, String creatorName){
		List<CSV_Upload_Mapping_Column__c> returnValue = new List<CSV_Upload_Mapping_Column__c>();
		for(CSV_Upload_Mapping_Column__c columnToCheck : allMappingColumns){
			if(columnToCheck.Group__c == groupNoDecimal && columnToCheck.SObject_Creator__c.equalsIgnoreCase(creatorName)){
				returnValue.add(columnToCheck);
			}
		}
		return returnValue;
	}
	public List<CSV_Upload_Mapping_Column__c> getExternalIdTypeField(){
		List<CSV_Upload_Mapping_Column__c> returnValue = new List<CSV_Upload_Mapping_Column__c>();
		for(CSV_Upload_Mapping_Column__c columnToCheck : allMappingColumns){
			if(columnToCheck.External_Id_Type_Column__c){
				returnValue.add(columnToCheck);
			}
		}
		return returnValue;
	}
	public List<CSV_Upload_Mapping_Column__c> getExternalIdFields(){
		List<CSV_Upload_Mapping_Column__c> returnValue = new List<CSV_Upload_Mapping_Column__c>();
		for(CSV_Upload_Mapping_Column__c columnToCheck : allMappingColumns){
			if(columnToCheck.External_Id_Type_Column__c){
				returnValue.add(columnToCheck);
			}
		}
		return returnValue;
	}
	public List<CSV_Upload_Mapping_Column__c> getMappedFields(){
		List<CSV_Upload_Mapping_Column__c> returnValue = new List<CSV_Upload_Mapping_Column__c>();
		for(CSV_Upload_Mapping_Column__c columnToCheck : allMappingColumns){
			if(!columnToCheck.External_Id_Type_Column__c){
				returnValue.add(columnToCheck);
			}
		}
		return returnValue;
	}
=======
<<<<<<< HEAD
/******************************************************************************************
@Author         Hamed Izadpanah
@Date           03/10/2015
@Project        Cloud Sherpas Cabinet Office Data Source
@Description    This is the main mapping class which is a wrapper around a list of 
				CSV Upload mapping custom settings
*******************************************************************************************/
public with sharing class CSVUploadMapping {

	List<CSV_Upload_Mapping_Column__c> allMappingColumns;
	public CSVUploadMapping(List<CSV_Upload_Mapping_Column__c> allMappingColumns) {
		this.allMappingColumns = allMappingColumns;
	}
	public CSVUploadMapping(CSV_Upload__c csvUploadProcess) {
		this.allMappingColumns = [
			SELECT Id, Mapped_From_Field__c, SObject_Type__c, Mapped_To_Field__c, Required__c, SObject_Creator__c,
			Value_Parser__c, External_Id_Type_Column__c, Query_Result_Id_Mapped_to_Field__c, Record_Locator_Query__c, 
			Not_Found_Error_Message__c, Run_SObject_Creator_On_Record_Not_Found__c, Group__c, Read_Only__c, Accept_Multi_Values__c
			FROM CSV_Upload_Mapping_Column__c
			WHERE CSV_Upload_Type__c = :csvUploadProcess.Type__c
			AND CSV_Upload_Recipient_Type__c = :csvUploadProcess.Recipient_Type__c
			ORDER BY SObject_Creator__c, Mapped_To_Field__c
		];
	}

	public List<CSV_Upload_Mapping_Column__c> getRequiredMappingColumns(){
		List<CSV_Upload_Mapping_Column__c> returnValue = new List<CSV_Upload_Mapping_Column__c>();
		for(CSV_Upload_Mapping_Column__c columnToCheck : allMappingColumns){
			if(columnToCheck.Required__c){
				returnValue.add(columnToCheck);
			}
		}
		return returnValue;
	}
	public List<CSV_Upload_Mapping_Column__c> getColumnsSObjectCreator(String creatorName){
		List<CSV_Upload_Mapping_Column__c> returnValue = new List<CSV_Upload_Mapping_Column__c>();
		for(CSV_Upload_Mapping_Column__c columnToCheck : allMappingColumns){
			if(columnToCheck.SObject_Creator__c.equalsIgnoreCase(creatorName)){
				returnValue.add(columnToCheck);
			}
		}
		return returnValue;
	}
	public List<CSV_Upload_Mapping_Column__c> getColumnsSObjectCreator(Decimal groupNoDecimal, String creatorName){
		List<CSV_Upload_Mapping_Column__c> returnValue = new List<CSV_Upload_Mapping_Column__c>();
		for(CSV_Upload_Mapping_Column__c columnToCheck : allMappingColumns){
			if(columnToCheck.Group__c == groupNoDecimal && columnToCheck.SObject_Creator__c.equalsIgnoreCase(creatorName)){
				returnValue.add(columnToCheck);
			}
		}
		return returnValue;
	}
	public List<CSV_Upload_Mapping_Column__c> getExternalIdTypeField(){
		List<CSV_Upload_Mapping_Column__c> returnValue = new List<CSV_Upload_Mapping_Column__c>();
		for(CSV_Upload_Mapping_Column__c columnToCheck : allMappingColumns){
			if(columnToCheck.External_Id_Type_Column__c){
				returnValue.add(columnToCheck);
			}
		}
		return returnValue;
	}
	public List<CSV_Upload_Mapping_Column__c> getExternalIdFields(){
		List<CSV_Upload_Mapping_Column__c> returnValue = new List<CSV_Upload_Mapping_Column__c>();
		for(CSV_Upload_Mapping_Column__c columnToCheck : allMappingColumns){
			if(columnToCheck.External_Id_Type_Column__c){
				returnValue.add(columnToCheck);
			}
		}
		return returnValue;
	}
	public List<CSV_Upload_Mapping_Column__c> getMappedFields(){
		List<CSV_Upload_Mapping_Column__c> returnValue = new List<CSV_Upload_Mapping_Column__c>();
		for(CSV_Upload_Mapping_Column__c columnToCheck : allMappingColumns){
			if(!columnToCheck.External_Id_Type_Column__c){
				returnValue.add(columnToCheck);
			}
		}
		return returnValue;
	}
=======
<<<<<<< HEAD
/******************************************************************************************
@Author         Hamed Izadpanah
@Date           03/10/2015
@Project        Cloud Sherpas Cabinet Office Data Source
@Description    This is the main mapping class which is a wrapper around a list of 
				CSV Upload mapping custom settings
*******************************************************************************************/
public with sharing class CSVUploadMapping {

	List<CSV_Upload_Mapping_Column__c> allMappingColumns;
	public CSVUploadMapping(List<CSV_Upload_Mapping_Column__c> allMappingColumns) {
		this.allMappingColumns = allMappingColumns;
	}
	public CSVUploadMapping(CSV_Upload__c csvUploadProcess) {
		this.allMappingColumns = [
			SELECT Id, Mapped_From_Field__c, SObject_Type__c, Mapped_To_Field__c, Required__c, SObject_Creator__c,
			Value_Parser__c, External_Id_Type_Column__c, Query_Result_Id_Mapped_to_Field__c, Record_Locator_Query__c, 
			Not_Found_Error_Message__c, Run_SObject_Creator_On_Record_Not_Found__c, Group__c, Read_Only__c, Accept_Multi_Values__c
			FROM CSV_Upload_Mapping_Column__c
			WHERE CSV_Upload_Type__c = :csvUploadProcess.Type__c
			AND CSV_Upload_Recipient_Type__c = :csvUploadProcess.Recipient_Type__c
			ORDER BY SObject_Creator__c, Mapped_To_Field__c
		];
	}

	public List<CSV_Upload_Mapping_Column__c> getRequiredMappingColumns(){
		List<CSV_Upload_Mapping_Column__c> returnValue = new List<CSV_Upload_Mapping_Column__c>();
		for(CSV_Upload_Mapping_Column__c columnToCheck : allMappingColumns){
			if(columnToCheck.Required__c){
				returnValue.add(columnToCheck);
			}
		}
		return returnValue;
	}
	public List<CSV_Upload_Mapping_Column__c> getColumnsSObjectCreator(String creatorName){
		List<CSV_Upload_Mapping_Column__c> returnValue = new List<CSV_Upload_Mapping_Column__c>();
		for(CSV_Upload_Mapping_Column__c columnToCheck : allMappingColumns){
			if(columnToCheck.SObject_Creator__c.equalsIgnoreCase(creatorName)){
				returnValue.add(columnToCheck);
			}
		}
		return returnValue;
	}
	public List<CSV_Upload_Mapping_Column__c> getColumnsSObjectCreator(Decimal groupNoDecimal, String creatorName){
		List<CSV_Upload_Mapping_Column__c> returnValue = new List<CSV_Upload_Mapping_Column__c>();
		for(CSV_Upload_Mapping_Column__c columnToCheck : allMappingColumns){
			if(columnToCheck.Group__c == groupNoDecimal && columnToCheck.SObject_Creator__c.equalsIgnoreCase(creatorName)){
				returnValue.add(columnToCheck);
			}
		}
		return returnValue;
	}
	public List<CSV_Upload_Mapping_Column__c> getExternalIdTypeField(){
		List<CSV_Upload_Mapping_Column__c> returnValue = new List<CSV_Upload_Mapping_Column__c>();
		for(CSV_Upload_Mapping_Column__c columnToCheck : allMappingColumns){
			if(columnToCheck.External_Id_Type_Column__c){
				returnValue.add(columnToCheck);
			}
		}
		return returnValue;
	}
	public List<CSV_Upload_Mapping_Column__c> getExternalIdFields(){
		List<CSV_Upload_Mapping_Column__c> returnValue = new List<CSV_Upload_Mapping_Column__c>();
		for(CSV_Upload_Mapping_Column__c columnToCheck : allMappingColumns){
			if(columnToCheck.External_Id_Type_Column__c){
				returnValue.add(columnToCheck);
			}
		}
		return returnValue;
	}
	public List<CSV_Upload_Mapping_Column__c> getMappedFields(){
		List<CSV_Upload_Mapping_Column__c> returnValue = new List<CSV_Upload_Mapping_Column__c>();
		for(CSV_Upload_Mapping_Column__c columnToCheck : allMappingColumns){
			if(!columnToCheck.External_Id_Type_Column__c){
				returnValue.add(columnToCheck);
			}
		}
		return returnValue;
	}
=======
/******************************************************************************************
@Author         Hamed Izadpanah
@Date           03/10/2015
@Project        Cloud Sherpas Cabinet Office Data Source
@Description    This is the main mapping class which is a wrapper around a list of 
				CSV Upload mapping custom settings
*******************************************************************************************/
public with sharing class CSVUploadMapping {

	List<CSV_Upload_Mapping_Column__c> allMappingColumns;
	public CSVUploadMapping(List<CSV_Upload_Mapping_Column__c> allMappingColumns) {
		this.allMappingColumns = allMappingColumns;
	}
	public CSVUploadMapping(CSV_Upload__c csvUploadProcess) {
		this.allMappingColumns = [
			SELECT Id, Mapped_From_Field__c, SObject_Type__c, Mapped_To_Field__c, Required__c, SObject_Creator__c,
			Value_Parser__c, External_Id_Type_Column__c, Query_Result_Id_Mapped_to_Field__c, Record_Locator_Query__c, 
			Not_Found_Error_Message__c, Run_SObject_Creator_On_Record_Not_Found__c, Group__c, Read_Only__c, Accept_Multi_Values__c
			FROM CSV_Upload_Mapping_Column__c
			WHERE CSV_Upload_Type__c = :csvUploadProcess.Type__c
			AND CSV_Upload_Recipient_Type__c = :csvUploadProcess.Recipient_Type__c
			ORDER BY SObject_Creator__c, Mapped_To_Field__c
		];
	}

	public List<CSV_Upload_Mapping_Column__c> getRequiredMappingColumns(){
		List<CSV_Upload_Mapping_Column__c> returnValue = new List<CSV_Upload_Mapping_Column__c>();
		for(CSV_Upload_Mapping_Column__c columnToCheck : allMappingColumns){
			if(columnToCheck.Required__c){
				returnValue.add(columnToCheck);
			}
		}
		return returnValue;
	}
	public List<CSV_Upload_Mapping_Column__c> getColumnsSObjectCreator(String creatorName){
		List<CSV_Upload_Mapping_Column__c> returnValue = new List<CSV_Upload_Mapping_Column__c>();
		for(CSV_Upload_Mapping_Column__c columnToCheck : allMappingColumns){
			if(columnToCheck.SObject_Creator__c.equalsIgnoreCase(creatorName)){
				returnValue.add(columnToCheck);
			}
		}
		return returnValue;
	}
	public List<CSV_Upload_Mapping_Column__c> getColumnsSObjectCreator(Decimal groupNoDecimal, String creatorName){
		List<CSV_Upload_Mapping_Column__c> returnValue = new List<CSV_Upload_Mapping_Column__c>();
		for(CSV_Upload_Mapping_Column__c columnToCheck : allMappingColumns){
			if(columnToCheck.Group__c == groupNoDecimal && columnToCheck.SObject_Creator__c.equalsIgnoreCase(creatorName)){
				returnValue.add(columnToCheck);
			}
		}
		return returnValue;
	}
	public List<CSV_Upload_Mapping_Column__c> getExternalIdTypeField(){
		List<CSV_Upload_Mapping_Column__c> returnValue = new List<CSV_Upload_Mapping_Column__c>();
		for(CSV_Upload_Mapping_Column__c columnToCheck : allMappingColumns){
			if(columnToCheck.External_Id_Type_Column__c){
				returnValue.add(columnToCheck);
			}
		}
		return returnValue;
	}
	public List<CSV_Upload_Mapping_Column__c> getExternalIdFields(){
		List<CSV_Upload_Mapping_Column__c> returnValue = new List<CSV_Upload_Mapping_Column__c>();
		for(CSV_Upload_Mapping_Column__c columnToCheck : allMappingColumns){
			if(columnToCheck.External_Id_Type_Column__c){
				returnValue.add(columnToCheck);
			}
		}
		return returnValue;
	}
	public List<CSV_Upload_Mapping_Column__c> getMappedFields(){
		List<CSV_Upload_Mapping_Column__c> returnValue = new List<CSV_Upload_Mapping_Column__c>();
		for(CSV_Upload_Mapping_Column__c columnToCheck : allMappingColumns){
			if(!columnToCheck.External_Id_Type_Column__c){
				returnValue.add(columnToCheck);
			}
		}
		return returnValue;
	}
>>>>>>> refs/remotes/origin/master
>>>>>>> branch 'master' of https://github.com/cabinetoffice/Government-Grants-Information-System-Metadata
>>>>>>> branch 'master' of https://github.com/cabinetoffice/Government-Grants-Information-System-Metadata
>>>>>>> branch 'master' of https://github.com/cabinetoffice/Government-Grants-Information-System-Metadata
}