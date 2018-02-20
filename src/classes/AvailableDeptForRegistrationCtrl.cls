public without sharing class AvailableDeptForRegistrationCtrl {
<<<<<<< HEAD
    public String getJSON(){
        List<AccountWrapper> allFoundAccounts = new List<AccountWrapper>();
        set<string> uniqueName= new    set<string>();
        for(Account departmentToAdd : [
            SELECT Id, Name
            FROM Account 
            WHERE CPID_from_OSCAR__c != null 
            
        ]){
         
           
               if(!uniqueName.contains(departmentToAdd.Name))
               {
                    allFoundAccounts.add(new AccountWrapper(departmentToAdd));
                     uniqueName.add(departmentToAdd.Name);
               }
           
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
=======
<<<<<<< HEAD
    public String getJSON(){
        List<AccountWrapper> allFoundAccounts = new List<AccountWrapper>();
        set<string> uniqueName= new    set<string>();
        for(Account departmentToAdd : [
            SELECT Id, Name
            FROM Account 
            WHERE CPID_from_OSCAR__c != null 
            
        ]){
         
           
               if(!uniqueName.contains(departmentToAdd.Name))
               {
                    allFoundAccounts.add(new AccountWrapper(departmentToAdd));
                     uniqueName.add(departmentToAdd.Name);
               }
           
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
=======
<<<<<<< HEAD
    public String getJSON(){
        List<AccountWrapper> allFoundAccounts = new List<AccountWrapper>();
        set<string> uniqueName= new    set<string>();
        for(Account departmentToAdd : [
            SELECT Id, Name
            FROM Account 
            WHERE CPID_from_OSCAR__c != null 
            
        ]){
         
           
               if(!uniqueName.contains(departmentToAdd.Name))
               {
                    allFoundAccounts.add(new AccountWrapper(departmentToAdd));
                     uniqueName.add(departmentToAdd.Name);
               }
           
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
=======
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
>>>>>>> refs/remotes/origin/master
>>>>>>> branch 'master' of https://github.com/cabinetoffice/Government-Grants-Information-System-Metadata
>>>>>>> branch 'master' of https://github.com/cabinetoffice/Government-Grants-Information-System-Metadata
}