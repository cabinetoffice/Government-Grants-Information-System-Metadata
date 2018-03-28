/******************************************************************************************
@Author         Daniel Lagar
@Date           23/05/2017
@Project        Cloud Sherpas Cabinet Office Data Source
@Description    Extension class for VF page AccountMergePage.page
*******************************************************************************************/
public class AccountMergeController {
    public string accName {get;set;}
    public string strSelected {get;set;}
    public string strCurrentACCid {get;set;}
    public Boolean MergeRendered {get;set;}
    public list<account> accountList {get;set;}
    public list<Intermediary__c> childIntermediaryList {get;set;}
    public list<Grant_Award__c> childAwardList {get;set;}
    public list<Grant_Scheme__c> childSchemeList {get;set;}
    
    public AccountMergeController(ApexPages.StandardController sc){
        accName = null;
        accountList = new list<Account>();
        strSelected = null;
        childIntermediaryList = new list<Intermediary__c>();
        childAwardList = new list<Grant_Award__c>();
        childSchemeList = new list<Grant_Scheme__c>();
        strCurrentACCid = ApexPages.currentPage().getParameters().get('id');
        MergeRendered = true;
    }
    
    //method to find a list of Organisations that will be the new parent Organisation for the children record which to meet the users search.
    public void searchAccount(){
        string searchString = '%' + accName + '%';
<<<<<<< HEAD
        accountList = [SELECT id, name, Type__c, Primary_Address_1__c, Primary_Postal_Code__c, Primary_City__c, Primary_County__c, CPID_from_OSCAR__c,Companies_House_Number__c,Charities_Commission_Number__c,VAT_Reg_no__c,DUNS_Number__c,ISNI__c,International_ID__c,Other_ID__c FROM account WHERE name LIKE : searchString AND id != :strCurrentACCid LIMIT 1000];
        // activate the merge button
        MergeRendered = false;
    }
    //method to get the selected parent Organisation from the radio button on the page.
    public void setComp() {
        strSelected = System.currentPagereference().getParameters().get('selected');
    
    }
    //method to re-parente each award, scheme and Intermediary to the new parent when the Reparent button is pressed.
    public PageReference reParent() {
        //pass the old current parents id to the page.
        PageReference reParentPage = new pagereference('/' + strCurrentACCid);
        //Check to make sure an Organisation is selected when Reparent is pressed.
        If(strSelected == NULL){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.ERROR, 'Please select an Organisation'));
        }
        Else{
            //find all the child schemes, awards and Intermediaries for the current Organisation.
            childIntermediaryList = [SELECT id, name,Intermediary_Organisation__c FROM Intermediary__c WHERE Intermediary_Organisation__c = :strCurrentACCid];
            childAwardList = [SELECT id, name FROM Grant_Award__c WHERE Recipient__c = :strCurrentACCid];
            childSchemeList = [SELECT id, name FROM Grant_Scheme__c WHERE Funder__c = :strCurrentACCid];
            
            // re-parente all schemes, award and Intermediaries to the Organisation selected.
            for(Intermediary__c interToReparent : childIntermediaryList){
                interToReparent.Intermediary_Organisation__c = strSelected;
            }
            
            for(Grant_Award__c AwardToReparent : childAwardList){
                AwardToReparent.Recipient__c = strSelected;
            }
            
            for(Grant_Scheme__c SchemeToReparent : childSchemeList){
                SchemeToReparent.Funder__c = strSelected;
            }
            
            database.update(childIntermediaryList);
            database.update(childAwardList);
            database.update(childSchemeList);
        }
        //return the user to the Organisation they were originally on.
        return reParentPage;
    }
=======
<<<<<<< HEAD
        accountList = [SELECT id, name, Type__c, Primary_Address_1__c, Primary_Postal_Code__c, Primary_City__c, Primary_County__c, CPID_from_OSCAR__c,Companies_House_Number__c,Charities_Commission_Number__c,VAT_Reg_no__c,DUNS_Number__c,ISNI__c,International_ID__c,Other_ID__c FROM account WHERE name LIKE : searchString AND id != :strCurrentACCid LIMIT 1000];
        // activate the merge button
        MergeRendered = false;
    }
    //method to get the selected parent Organisation from the radio button on the page.
    public void setComp() {
        strSelected = System.currentPagereference().getParameters().get('selected');
    
    }
    //method to re-parente each award, scheme and Intermediary to the new parent when the Reparent button is pressed.
    public PageReference reParent() {
        //pass the old current parents id to the page.
        PageReference reParentPage = new pagereference('/' + strCurrentACCid);
        //Check to make sure an Organisation is selected when Reparent is pressed.
        If(strSelected == NULL){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.ERROR, 'Please select an Organisation'));
        }
        Else{
            //find all the child schemes, awards and Intermediaries for the current Organisation.
            childIntermediaryList = [SELECT id, name,Intermediary_Organisation__c FROM Intermediary__c WHERE Intermediary_Organisation__c = :strCurrentACCid];
            childAwardList = [SELECT id, name FROM Grant_Award__c WHERE Recipient__c = :strCurrentACCid];
            childSchemeList = [SELECT id, name FROM Grant_Scheme__c WHERE Funder__c = :strCurrentACCid];
            
            // re-parente all schemes, award and Intermediaries to the Organisation selected.
            for(Intermediary__c interToReparent : childIntermediaryList){
                interToReparent.Intermediary_Organisation__c = strSelected;
            }
            
            for(Grant_Award__c AwardToReparent : childAwardList){
                AwardToReparent.Recipient__c = strSelected;
            }
            
            for(Grant_Scheme__c SchemeToReparent : childSchemeList){
                SchemeToReparent.Funder__c = strSelected;
            }
            
            database.update(childIntermediaryList);
            database.update(childAwardList);
            database.update(childSchemeList);
        }
        //return the user to the Organisation they were originally on.
        return reParentPage;
    }
=======
<<<<<<< HEAD
        accountList = [SELECT id, name, Type__c, Primary_Address_1__c, Primary_Postal_Code__c, Primary_City__c, Primary_County__c, CPID_from_OSCAR__c,Companies_House_Number__c,Charities_Commission_Number__c,VAT_Reg_no__c,DUNS_Number__c,ISNI__c,International_ID__c,Other_ID__c FROM account WHERE name LIKE : searchString AND id != :strCurrentACCid LIMIT 1000];
        // activate the merge button
        MergeRendered = false;
    }
    //method to get the selected parent Organisation from the radio button on the page.
    public void setComp() {
        strSelected = System.currentPagereference().getParameters().get('selected');
    
    }
    //method to re-parente each award, scheme and Intermediary to the new parent when the Reparent button is pressed.
    public PageReference reParent() {
        //pass the old current parents id to the page.
        PageReference reParentPage = new pagereference('/' + strCurrentACCid);
        //Check to make sure an Organisation is selected when Reparent is pressed.
        If(strSelected == NULL){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.ERROR, 'Please select an Organisation'));
        }
        Else{
            //find all the child schemes, awards and Intermediaries for the current Organisation.
            childIntermediaryList = [SELECT id, name,Intermediary_Organisation__c FROM Intermediary__c WHERE Intermediary_Organisation__c = :strCurrentACCid];
            childAwardList = [SELECT id, name FROM Grant_Award__c WHERE Recipient__c = :strCurrentACCid];
            childSchemeList = [SELECT id, name FROM Grant_Scheme__c WHERE Funder__c = :strCurrentACCid];
            
            // re-parente all schemes, award and Intermediaries to the Organisation selected.
            for(Intermediary__c interToReparent : childIntermediaryList){
                interToReparent.Intermediary_Organisation__c = strSelected;
            }
            
            for(Grant_Award__c AwardToReparent : childAwardList){
                AwardToReparent.Recipient__c = strSelected;
            }
            
            for(Grant_Scheme__c SchemeToReparent : childSchemeList){
                SchemeToReparent.Funder__c = strSelected;
            }
            
            database.update(childIntermediaryList);
            database.update(childAwardList);
            database.update(childSchemeList);
        }
        //return the user to the Organisation they were originally on.
        return reParentPage;
    }
=======
<<<<<<< HEAD
        accountList = [SELECT id, name, Type__c, Primary_Address_1__c, Primary_Postal_Code__c, Primary_City__c, Primary_County__c, CPID_from_OSCAR__c,Companies_House_Number__c,Charities_Commission_Number__c,VAT_Reg_no__c,DUNS_Number__c,ISNI__c,International_ID__c,Other_ID__c FROM account WHERE name LIKE : searchString AND id != :strCurrentACCid LIMIT 1000];
        // activate the merge button
        MergeRendered = false;
    }
    //method to get the selected parent Organisation from the radio button on the page.
    public void setComp() {
        strSelected = System.currentPagereference().getParameters().get('selected');
    
    }
    //method to re-parente each award, scheme and Intermediary to the new parent when the Reparent button is pressed.
    public PageReference reParent() {
        //pass the old current parents id to the page.
        PageReference reParentPage = new pagereference('/' + strCurrentACCid);
        //Check to make sure an Organisation is selected when Reparent is pressed.
        If(strSelected == NULL){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.ERROR, 'Please select an Organisation'));
        }
        Else{
            //find all the child schemes, awards and Intermediaries for the current Organisation.
            childIntermediaryList = [SELECT id, name,Intermediary_Organisation__c FROM Intermediary__c WHERE Intermediary_Organisation__c = :strCurrentACCid];
            childAwardList = [SELECT id, name FROM Grant_Award__c WHERE Recipient__c = :strCurrentACCid];
            childSchemeList = [SELECT id, name FROM Grant_Scheme__c WHERE Funder__c = :strCurrentACCid];
            
            // re-parente all schemes, award and Intermediaries to the Organisation selected.
            for(Intermediary__c interToReparent : childIntermediaryList){
                interToReparent.Intermediary_Organisation__c = strSelected;
            }
            
            for(Grant_Award__c AwardToReparent : childAwardList){
                AwardToReparent.Recipient__c = strSelected;
            }
            
            for(Grant_Scheme__c SchemeToReparent : childSchemeList){
                SchemeToReparent.Funder__c = strSelected;
            }
            
            database.update(childIntermediaryList);
            database.update(childAwardList);
            database.update(childSchemeList);
        }
        //return the user to the Organisation they were originally on.
        return reParentPage;
    }
=======
        accountList = [SELECT id, name, Type__c, Primary_Address_1__c, Primary_Postal_Code__c, Primary_City__c, Primary_County__c FROM account WHERE name LIKE : searchString AND id != :strCurrentACCid LIMIT 1000];
        // activate the merge button
        MergeRendered = false;
    }
    //method to get the selected parent Organisation from the radio button on the page.
    public void setComp() {
		strSelected = System.currentPagereference().getParameters().get('selected');
	
	}
	//method to re-parente each award, scheme and Intermediary to the new parent when the Reparent button is pressed.
    public PageReference reParent() {
        //pass the old current parents id to the page.
        PageReference reParentPage = new pagereference('/' + strCurrentACCid);
        //Check to make sure an Organisation is selected when Reparent is pressed.
        If(strSelected == NULL){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.ERROR, 'Please select an Organisation'));
        }
        Else{
            //find all the child schemes, awards and Intermediaries for the current Organisation.
            childIntermediaryList = [SELECT id, name,Intermediary_Organisation__c FROM Intermediary__c WHERE Intermediary_Organisation__c = :strCurrentACCid];
            childAwardList = [SELECT id, name FROM Grant_Award__c WHERE Recipient__c = :strCurrentACCid];
            childSchemeList = [SELECT id, name FROM Grant_Scheme__c WHERE Funder__c = :strCurrentACCid];
            
            // re-parente all schemes, award and Intermediaries to the Organisation selected.
            for(Intermediary__c interToReparent : childIntermediaryList){
                interToReparent.Intermediary_Organisation__c = strSelected;
            }
            
            for(Grant_Award__c AwardToReparent : childAwardList){
                AwardToReparent.Recipient__c = strSelected;
            }
            
            for(Grant_Scheme__c SchemeToReparent : childSchemeList){
                SchemeToReparent.Funder__c = strSelected;
            }
            
            database.update(childIntermediaryList);
            database.update(childAwardList);
            database.update(childSchemeList);
        }
        //return the user to the Organisation they were originally on.
        return reParentPage;
	}
>>>>>>> refs/remotes/origin/master
>>>>>>> branch 'master' of https://github.com/cabinetoffice/Government-Grants-Information-System-Metadata
>>>>>>> branch 'master' of https://github.com/cabinetoffice/Government-Grants-Information-System-Metadata
>>>>>>> branch 'master' of https://github.com/cabinetoffice/Government-Grants-Information-System-Metadata
}