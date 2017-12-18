//****************************************************************************
// Author:         Alexander Cross
// Name:           CH_CompanySearchPageExtClass
// Creation Date:  06/03/2017
// Description:    Extension for visualforce page that searches Companies House API
//****************************************************************************

public without sharing class CH_CompanySearchPageExtClass{
	public jsonResults objResults {get;set;}
	public transient httpResponse res {get;set;}
	public List<jsonItem> ListItems {get;set;}
    public String strInterface {get;set;}
	public String strSearchTerm {get;set;}
	public String strAPIError {get;set;}
	public String strSelected {get;set;}
	public Boolean blnRenderResults {get;set;}
	public Boolean blnDisableCreate {get;set;}
	public Boolean blnHasResults {get;set;}
	public Boolean blnCallSuccess {get;set;}
	
	//****************************************************************************
	// Function:    CH_CompanySearchPageExtClass
	// Arguments:   
	// Return:      
	// Description: Class constructor
	//****************************************************************************
	public CH_CompanySearchPageExtClass() {
        strInterface = 'SearchCompany';
		strAPIError = NULL;
		strSearchTerm = NULL;
		strSelected = NULL;
		blnRenderResults = FALSE;
		blnDisableCreate = TRUE;
		blnHasResults = FALSE;
		blnCallSuccess = TRUE;
	}
	
	//****************************************************************************
	// Function:    searchCS
	// Arguments:   
	// Return:      
	// Description: Perform Companies House API call
	//****************************************************************************
	public void searchCS() {
		blnRenderResults = FALSE;
		blnDisableCreate = TRUE;
		blnHasResults = FALSE;
		blnCallSuccess = FALSE;
		
		//Reset items
		ListItems = new List<jsonItem>();
		
		//Make call
		callCompHouse();
		
		//process call if no API error
		if(strAPIError == NULL || strAPIError == '') {
			if(res.getStatusCode() == 200) {
				blnCallSuccess = TRUE;
				blnRenderResults = TRUE;
				
				//Deserialize JSON
				objResults = (jsonResults)JSON.deserialize(res.getBody(), jsonResults.class);
				
				//Check if returned results
				if(objResults.total_results > 0) {
					blnHasResults = TRUE;
					blnDisableCreate = FALSE;

					//Get items from JSON
					ListItems = objResults.items;
				}
				else {
                    //No results returned
					blnHasResults = FALSE;
				}
			} else {
                //Failed API call
				blnCallSuccess = FALSE;
				strAPIError = res.getStatus();
			}
		}
		
		if(strAPIError != NULL && strAPIError != '') {
			ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.ERROR, strAPIError));
		}
	}
	
	//****************************************************************************
	// Function:    createCS
	// Arguments:   
	// Return:      PageReference
	// Description: Create new organisation with prepoulated fields
	//****************************************************************************
	public PageReference createCS() {
        CH_Companies_House_Interface__mdt fieldData = new CH_Companies_House_Interface__mdt();
		PageReference ref = NULL;
		String strURI = NULL;
		
        //Get meta data
		for(CH_Companies_House_Interface__mdt md : [SELECT Id, MasterLabel, CH_Company_Number_Field__c, CH_Primary_Address_1_Field__c, CH_Primary_City_Field__c, CH_Primary_Country_Field__c, CH_Primary_Postal_Code_Field__c
													FROM CH_Companies_House_Interface__mdt]) {
			if(md.MasterLabel == strInterface) {
				fieldData = md;
			}
		}
        
        //If company selected
		if(strSelected != NULL && strSelected != '') {
            jsonItem itemToUse = new jsonItem();
            
            //Find item details in list
            for(jsonItem ji : ListItems) {
                if(ji.company_number == strSelected) {
                    itemToUse = ji;
                    break;
                }
            }
            //Create URI
            if(itemToUse != NULL) {
                //Get status to inclue in test coverage
                String strStatus = itemToUse.company_status;
                //Set account creation page
                strURI = '/001/e?';
                //Add account name
                strURI = strURI + 'acc2=' + itemToUse.title;
                //Add company number
                strURI = strURI + '&' + fieldData.CH_Company_Number_Field__c + '=' + itemToUse.company_number;
                //Add primary address 1
                strURI = strURI + '&' + fieldData.CH_Primary_Address_1_Field__c + '=' + itemToUse.address.premises + ' ' + itemToUse.address.address_line_1;
				//Add primary city
				strURI = strURI + '&' + fieldData.CH_Primary_City_Field__c + '=' + itemToUse.address.locality;
				//Add primary postal code
				strURI = strURI + '&' + fieldData.CH_Primary_Postal_Code_Field__c + '=' + itemToUse.address.postal_code;
				//add primary postal country
				strURI = strURI + '&' + fieldData.CH_Primary_Country_Field__c + '=United Kingdom';
            }
            
            //Set URI if not null
			if(strURI != NULL) {
                //Set page reference and stop it going to the custom help/direction page
				ref = new PageReference(strURI);
                ref.getParameters().put('nooverride','1');
			}
		}
		else {
            //no company selected
			ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.ERROR, 'No Company Details Selected'));
		}
		
		return ref;
	}
	
	//****************************************************************************
	// Function:    cancelCS
	// Arguments:   
	// Return:      PageReference
	// Description: Cancel current search
	//****************************************************************************
	public PageReference cancelCS() {
		PageReference ref = NULL;
		
		ref = new PageReference('/001/o');
		
		return ref;
	}

	//****************************************************************************
	// Function:    setComp
	// Arguments:   
	// Return:      
	// Description: Set the selected company number and create parameters
	//****************************************************************************
	public void setComp() {
		strSelected = System.currentPagereference().getParameters().get('selected');
	}
	
	//****************************************************************************
	// Function:    callCompHouse
	// Arguments:   
	// Return:      
	// Description: Makes a call to the Companies House API
	//****************************************************************************
	public void callCompHouse() {
		http h = new http();
		httpRequest req = new httpRequest();
		String strMethod = '';
		String strURL = '';
		String strRes = '';
		String strToken = '';
		String strParam = '';
		String strHeaderType = '';
		String strHeaderValue = '';
		String strAuth = '';
		String strSearchEncode = '';
		Blob blAuth = Blob.valueOf('');
		
		//Get meta data
		for(CH_Companies_House_Interface__mdt md : [SELECT Id, MasterLabel, CH_Method__c, CH_Resource__c, CH_Token__c, CH_URL__c, CH_User_Email__c
													FROM CH_Companies_House_Interface__mdt]) {
			if(md.MasterLabel == strInterface) {
				strMethod = md.CH_Method__c;
				strURL = md.CH_URL__c;
				strRes = md.CH_Resource__c;
				strToken = md.CH_Token__c;
			}
		}
		//Reset response variables
		res = new httpResponse();
		strAPIError = NULL;
		
        //Set token - NOTE token must be sent with a : on the end before encoding
		blAuth = Blob.valueOf(strToken + ':');
		strAuth = EncodingUtil.base64Encode(blAuth);
		
		//Set search term
		strSearchEncode = EncodingUtil.urlEncode(strSearchTerm, 'UTF-8');
		
		//Build request variables
		strParam = '?q=' + strSearchEncode + '&items_per_page=200';
		strHeaderType = 'Authorization';
		strHeaderValue = 'Basic ' + strAuth;
		
		//Create request
		req.setMethod(strMethod);
		req.setEndpoint(strURL + strRes + strParam);
		req.setHeader(strHeaderType, strHeaderValue);
		
		//Make call
		try {
			res = h.send(req);
		} catch(exception e) {
			blnCallSuccess = FALSE;
			strAPIError = e.getMessage();
		}
	}
	
	//****************************************************************************
	// Class:       jsonResults
	// Description: JSON for results from Companies House
	//****************************************************************************
	public class jsonResults {
		public List<jsonItem> items {get;set;}
		public Integer total_results {get;set;}
	}
	
	//****************************************************************************
	// Class:       jsonItem
	// Description: JSON for results from Companies House at item level
	//****************************************************************************
	public class jsonItem {
		public jsonAddress address {get;set;}
		public String company_status {get;set;}
		public String company_number {get;set;}
		public String title {get;set;}
	}
	
	//****************************************************************************
	// Class:       jsonAddress
	// Description: JSON for results from Companies House at address level
	//****************************************************************************
	public class jsonAddress {
		public String address_line_1 {get;set;}
		public String postal_code {get;set;}
		public String premises {get;set;}
		public String locality {get;set;}
	}
}