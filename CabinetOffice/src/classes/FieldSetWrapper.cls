/******************************************************************************************
@Author         Hamed Izadpanah
@Date           03/10/2015
@Project        Cloud Sherpas Cabinet Office Data Source
@Description    This is a decorator class for Schema.FieldSet class/object
*******************************************************************************************/
public with sharing class FieldSetWrapper {
	public final Schema.FieldSet fieldSetToUse {get; private set;}
	public FieldSetWrapper(Schema.FieldSet fieldSetToUse) {
		this.fieldSetToUse = fieldSetToUse;
	}
	public Boolean hasFieldByLabel(String fieldLabelToFind){
		return getFieldApiNameFromLabel(fieldLabelToFind) != null;
	}
	public String getFieldApiNameFromLabel(String fieldLabelToFind){
		for(Schema.FieldSetMember fieldToCheck : fieldSetToUse.getFields()){
			if(fieldToCheck.getLabel().equalsIgnoreCase(fieldLabelToFind)){
				return fieldToCheck.getFieldPath();
			}
		}
		return null;
	}
}