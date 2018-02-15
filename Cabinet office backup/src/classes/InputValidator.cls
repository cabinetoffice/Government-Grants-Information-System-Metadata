/******************************************************************************************
@Author         Hamed Izadpanah
@Date           03/10/2015
@Project        Cloud Sherpas Cabinet Office Data Source
@Description    This is an abstract validator class which validates input values
*******************************************************************************************/
public abstract class InputValidator implements ApexInterface.Validator{

	public String customErrorMessage;
	protected List<String> errorMessages = new List<String>();
	protected List<InputValidator> childValidators = new List<InputValidator>();

	public Boolean validateAllChildValidators = false;

	public List<String> getErrorMessages(){
		return errorMessages;
	}

	public List<String> getAllErrorMessages(){
		List<String> returnValue = errorMessages;
		for(InputValidator validatorToAdd : childValidators){
			returnValue.addAll(validatorToAdd.getErrorMessages());
		}
		return returnValue;
	}

	public void addAllErrorsToThePage(){
		for(String errorMessageToShow : getAllErrorMessages()){
			Utility.addMessageToPage(ApexPages.Severity.ERROR, errorMessageToShow);
		}
	}

	public Boolean validateChildValidators(){
		Boolean returnValue = true;
		for(InputValidator childValidator : childValidators){
			Boolean isChildValid = childValidator.isValid();
			returnValue = returnValue ? isChildValid : returnValue;
			if(!returnValue && !validateAllChildValidators){
				return false;
			}
		}
		return returnValue;
	}

	public abstract Boolean isValid();


	public class NullValidator extends InputValidator{
		private String inputName;
		private Object objectToValidate;

		public NullValidator(String inputName, Object objectToValidate){
			this.inputName = inputName;
			this.objectToValidate = objectToValidate;
		}
		public override Boolean isValid(){
			String errorMessage = String.isNotBlank(customErrorMessage) ? customErrorMessage : inputName + ' value cannot be null!';
			if(objectToValidate == null){
				errorMessages.add(errorMessage);
				return false;
			}
			return true;
		}
	}


	public class CSVExtensionValidator extends InputValidator{
		private final List<String> VALID_FILE_EXTENSIONS = new List<String>{
			'.csv'
		};
		private String valueToValidate;
		public CSVExtensionValidator(String valueToValidate){
			this.valueToValidate = valueToValidate;
		}
		public override Boolean isValid(){
			for(String validExtension : VALID_FILE_EXTENSIONS){
				String extensionToValidate = String.isNotBlank(valueToValidate) ? valueToValidate.right(validExtension.length()) : '';
				if(!extensionToValidate.equalsIgnoreCase(validExtension)){
					errorMessages.add(Label.CSV_Upload_Invalid_File_Extension_Error_Message);
					return false;
				}
			}
			return true;
		}
	}

	public class AttachmentValidator extends InputValidator{
		private Attachment attachmentToValidate;

		public AttachmentValidator(Attachment attachmentToValidate){
			this.attachmentToValidate = attachmentToValidate;
		}
		public override Boolean isValid(){
			InputValidator bodyNullValidator = new NullValidator('Attachment Content', attachmentToValidate.Body);
			bodyNullValidator.customErrorMessage = 'Uploaded file cannot be null. Please select a file and try again.';
			childValidators.add(bodyNullValidator);

			InputValidator attachmentNameNullValidator = new NullValidator('Attachment Name', attachmentToValidate.Name);
			attachmentNameNullValidator.customErrorMessage = 'Please choose a file with a name.';
			childValidators.add(attachmentNameNullValidator);
			if(!validateChildValidators()){
				return false;
			}
			return true;
		}
	}

	public class CSVColumnsValidator extends InputValidator{
		CSVDocument documentToValidate;
		CSVUploadMapping mapping;
		public CSVColumnsValidator(CSVDocument documentToValidate, CSVUploadMapping mapping){
			this.documentToValidate = documentToValidate;
			this.mapping = mapping;
		}

		public override Boolean isValid(){
			if(documentToValidate.columnNames.isEmpty()){
				errorMessages.add('No headers are found to be mapped.');
				return false;
			}
			Set<String> headerValues = new Set<String>(documentToValidate.columnNames);
			for(CSV_Upload_Mapping_Column__c requiredColumnToCheck : mapping.getRequiredMappingColumns()){
				if(!headerValues.contains(requiredColumnToCheck.Mapped_From_Field__c)){
					String errorMessage = Label.Required_Fields_Missing_Error_Message.replaceAll(Constant.ERR_MSG_TEMP_REQ_FIELDS_MISSING, requiredColumnToCheck.Mapped_From_Field__c);
					errorMessages.add(errorMessage);
					return false;
				}
			}
			return true;
		}
	}
}