public without sharing class AvailableDeptForRegistrationCtrl {
	public String getJSON(){
		List<AccountWrapper> allFoundAccounts = new List<AccountWrapper>();
		for(Account departmentToAdd : [
			SELECT Id, Name
			FROM Account 
			WHERE CPID_from_OSCAR__c != null
			AND ParentId != null
		]){
			allFoundAccounts.add(new AccountWrapper(departmentToAdd));
		}
		return JSON.serialize(allFoundAccounts);
	}

	public class AccountWrapper{
		public String id;
		public String name;
		public AccountWrapper(Account accountToUse){
			id = accountToUse.Id;
			name = accountToUse.Name;
		}
	}
}