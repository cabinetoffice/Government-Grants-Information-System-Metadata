/******************************************************************************************
@Author         Hamed Izadpanah
@Date           03/10/2015
@Project        Cloud Sherpas Cabinet Office Data Source
@Description    This class parses string values into different types. This is used for CSV Upload process
*******************************************************************************************/
public abstract with sharing class StringValueParser {

	protected CSV_Upload_Mapping_Column__c targetMappingSetting;

	public void setTargetMappingSetting(CSV_Upload_Mapping_Column__c targetMappingSetting){
		this.targetMappingSetting = targetMappingSetting;
	}
	public abstract Object parse(String valueToParse);

	public class StringToDate extends StringValueParser{
		public override Object parse(String valueToParse){
			Date returnValue = String.isNotBlank(valueToParse) ? Date.parse(valueToParse) : null;
			return returnValue;
		}
	}
	public class StringToDecimal extends StringValueParser{
		public override Object parse(String valueToParse){
			Decimal returnValue = String.isNotBlank(valueToParse) ? Decimal.valueOf(valueToParse.replaceAll(',', '')) : null;
			return returnValue;
		}
	}
	public class StringToBoolean extends StringValueParser{
		public override Object parse(String valueToParse){
			Boolean returnValue = false;
			Set<String> TRUE_VALUES = new Set<String>{
				'YES',
				'Y',
				'TRUE',
				'1'
			};
			if(String.isNotBlank(valueToParse) && TRUE_VALUES.contains(valueToParse.trim().toUpperCase())){
				returnValue = true;
			}
			return returnValue;
		}
	}
	public class StringToPicklistValues extends StringValueParser{
		public override Object parse(String valueToParse){
			String returnValue = null;
			List<String> validatedValues = new List<String>();
			DescribeSObjectResult sObjectDescribeToCheck = Schema.getGlobalDescribe().get(targetMappingSetting.SObject_Type__c).getDescribe();
			List<Schema.PicklistEntry> availablePicklistOptions = sObjectDescribeToCheck.fields.getMap().get(targetMappingSetting.Mapped_To_Field__c).getDescribe().getPicklistValues();
			for(Schema.PicklistEntry availablePicklistOption : availablePicklistOptions){
				String picklistValue = availablePicklistOption.getValue();
				if(valueToParse.containsIgnoreCase(picklistValue)){
					validatedValues.add(picklistValue);
					if(!targetMappingSetting.Accept_Multi_Values__c){
						break;
					}
				}
			}
			if(String.isNotBlank(valueToParse) && validatedValues.isEmpty()){
				throw new InvalidInputException(targetMappingSetting.Not_Found_Error_Message__c);
			}
			returnValue = String.join(validatedValues,';');
			return returnValue;
		}
	}

	public class InvalidInputException extends Exception{}
}