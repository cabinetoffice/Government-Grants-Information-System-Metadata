/******************************************************************************************
@Author         Ric Dayrit
@Date           02/18/2015
@Project        Cloud Sherpas Cabinet Office Data Source
@Description    This is the controller for the User Registration page
*******************************************************************************************/
public without sharing class DataSolutionRegistrationController {

	public String firstName {get; set;}
	public String lastName {get; set;}
	public String emailAddress {get; set;}
	public String ggisRole {get; set;}
	public String selectedDepartmentId {get; set;}
	public String businessArea {get; set;}

	public List<SelectOption> getRoles() {
		Schema.DescribeFieldResult F = Contact.User_Role__c.getDescribe();
		List<Schema.PicklistEntry> picklistEntries = F.getPicklistValues();

		List<SelectOption> options = new List<SelectOption>();
		
		options.add(new SelectOption('', 'User types', false));
		for (Schema.PicklistEntry entry : picklistEntries) {
			options.add(new SelectOption(entry.getValue(), entry.getLabel()));
		}

		return options;
	}

	public List<SelectOption> getBusinessAreas() {
		Schema.DescribeFieldResult F = Contact.Business_Area__c.getDescribe();
		List<Schema.PicklistEntry> picklistEntries = F.getPicklistValues();

		List<SelectOption> options = new List<SelectOption>();
		
		options.add(new SelectOption('', 'Business Area', false));
		for (Schema.PicklistEntry entry : picklistEntries) {
			options.add(new SelectOption(entry.getValue(), entry.getLabel()));
		}

		return options;
	}


	private void resetFields(){
		firstName = null;
		lastName = null;
		emailAddress = null;
		ggisRole = null;
		selectedDepartmentId = null;
	}

	private String hasErrorMessage() {
		if(String.isBlank(selectedDepartmentId)) {
			return System.Label.DT_User_Registration_No_Organisation_Error_Message;
		}
		if(String.isBlank(ggisRole)) {
			return System.Label.DT_User_Registration_No_User_Type_Error_Message;
		}
		if(String.isBlank(businessArea)) {
			return System.Label.DT_User_Registration_No_Business_Area_Error_Message;
		}

		return null;
	}

	public PageReference saveUser() {
		String errorMsg = hasErrorMessage();
		if (!String.isBlank(errorMsg)) {
			ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, errorMsg));
			return null;
		} 
		try {
			Contact contact = new Contact(
				FirstName = firstName,
				LastName = lastName,
				Email = emailAddress,
				AccountId = selectedDepartmentId,
				User_Role__c = ggisRole,
				Business_Area__c = businessArea
			);
			insert contact;
			resetFields();

			PageReference page = System.Page.UserRegistrationSuccess;
            page.setRedirect(true);
            return page;
		} catch (Exception e) {
			ApexPages.addMessage(
				new ApexPages.message(ApexPages.severity.ERROR, 
					System.Label.DT_User_Registration_Internal_Error_Message)
			);
            return null;   
		}

		return null;
	}
}