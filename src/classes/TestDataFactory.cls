/******************************************************************************************
@Author         Hamed Izadpanah
@Date           03/10/2015
@Project        Cloud Sherpas Cabinet Office Data Source
@Description    This is a data factory which will be used mostly for generating test data
*******************************************************************************************/
public class TestDataFactory {

    public final static String TEST_CCOA_COLUMN = 'CCoA L5';
    public final static String TEST_RECEPIENT_ID_COLUMN = 'Recipient ID';
    public final static String TEST_GRANT_AWARD_COUNTRY_COLUMN = 'Award Country';
    public final static String TEST_GRANT_AWARD_NAME_COLUMN = 'Grant Award Name';
    public final static String TEST_GRANT_AWARD_REF_COLUMN = 'Grant Award Reference Number';
    public final static String TEST_INTERMEDIARY1_ID_COLUMN = 'Intermediary Id 1';
    public final static String TEST_INTERMEDIARY2_ID_COLUMN = 'Intermediary Id 2';

    public final static String TEST_CCOA_CODE = '11111000';
    public final static String TEST_COFOG_CODE = 'COFOG030600';
    public final static String TEST_AUTHORITY_ACT_NAME = 'Test Authority Act';
    public final static String TEST_GRANT_AWARD_NAME = 'New Some Award NAme TEST';
    public final static String TEST_GRANT_AWARD_REF_NO = 'AWD-ID';
    public final static String NEW_INTERMEDIARY_1_ORGANISATION_ID = 'INT-ID1';
    public final static String NEW_INTERMEDIARY_1_NAME = 'NewIntermediaryName1';
    public final static String NEW_INTERMEDIARY_1_ROLE = 'Market Engagement Advertising';
    public final static String NEW_INTERMEDIARY_2_ORGANISATION_ID = 'INT-ID2';
    public final static String NEW_INTERMEDIARY_2_NAME = 'NewIntermediaryName2';
    public final static String NEW_INTERMEDIARY_2_ROLE = 'Performance Monitoring';

    public static Map<String, String> DEFAULT_GRANT_AWARD_DATA_PARSED = new Map<String, String>{
        TEST_GRANT_AWARD_REF_COLUMN => TEST_GRANT_AWARD_REF_NO,
        'System Award Reference No' => '',
        Constant.GRANT_SCHEME_AND_SYSTEM_REFERENCE_LABEL => 'MySchemeRefNumber',
        'Grant Award Name' => TEST_GRANT_AWARD_NAME,
        'Recipient Name' => 'This is a new recepient!',
        'Recipient ID' => 'SomeId',
        'Recipient ID Type' => 'VAT Reg no',
        'Award Address 1' => 'Unit 1, Horse Guards Rd',
        'Award Address 2' => '',
        'Award City' => 'London',
        'Award County' => 'Great London',
        'Award Country' => 'United Kingdom',
        'Award Postal Code' => 'SW1A 2HQ',
        'Contact Forename' => 'Test Contact',
        'Contact Surname' => 'Test Contact Surname',
        'Contact Email' => 'test@contact.com',
        'Allocation Method' => 'Competed',
        'Grant Award Objective' => 'My New Object!!!',
        'Award Start Date' => '14/01/2015',
        'Award End Date' => '18/01/2016',
        'Is Grant Monitored' => 'No',
        'Reason for no monitoring' => 'Test Record!',
        'Total Amount in funding agreement in GBP' => '520000',
        TEST_CCOA_COLUMN => TEST_CCOA_CODE,
        'Intermediary name 1' => NEW_INTERMEDIARY_1_NAME,
        'Intermediary Id 1' => NEW_INTERMEDIARY_1_ORGANISATION_ID,
        'Intermediary Id Type 1' => Constant.ACC_EXT_ID_VAT_REG_NO_MAP,
        'Intermediary Role 1' => NEW_INTERMEDIARY_1_ROLE,
        'Intermediary name 2' => NEW_INTERMEDIARY_2_NAME,
        'Intermediary Id 2' => NEW_INTERMEDIARY_2_ORGANISATION_ID,
        'Intermediary Id Type 2' => Constant.ACC_EXT_ID_VAT_REG_NO_MAP,
        'Intermediary Role 2' => NEW_INTERMEDIARY_2_ROLE
    };

    public String testPortalSuffix = 'dev';
    public String EMAIL_FOR_TEST_USER = 'salesforce.test.unittest@cabinetoffice.gov.uk';
    public String PORTAL_SUPER_USER_PROFILE_NAME = 'Grant Maker User';
    public COFOG_L2__c testCOFOGLevel;
    public COA_L5__c testCOALevel;
    public Authority_Act__c testAuthorityAct;

    public Account createAccount(String name){
        return new Account(
            Name = name
        );
    }

    public Contact createContact(Id accountId, String lastname){
        return new Contact(
            AccountId = accountId,
            Lastname = lastname
        );
    }

    public User createPortalUser(String email, Id portalProfileId, Contact portalContact){
        return new User(
            Email = 'genelia.dsouza@gmail.com',
            Profileid = portalProfileId, 
            UserName= email + testPortalSuffix, 
            Alias = 'GDS',
            TimeZoneSidKey='America/New_York',
            EmailEncodingKey='ISO-8859-1',
            LocaleSidKey='en_US', 
            LanguageLocaleKey='en_US',
            ContactId = portalContact.Id,
            PortalRole = 'Manager',
            FirstName = portalContact.Firstname,
            LastName = portalContact.Lastname
        );
    }

    public User insertBasicPortalUser(){
        Profile portalSuperUserProfile = [SELECT Id FROM Profile WHERE Name = :PORTAL_SUPER_USER_PROFILE_NAME];
        Account testAccount = createAccount('Test Account');
        insert testAccount;
        Contact testContact = createContact(testAccount.Id, 'Smoke - Test');
        insert testContact;
        User returnValue = createPortalUser(EMAIL_FOR_TEST_USER, portalSuperUserProfile.Id, testContact);
        insert returnValue;
        return returnValue;
    }
    // Create Account passing the validation rule    
    public Account createAccount(String name, String cpidVar){
        return new Account(
            Name = name,
            Type__c = 'Funder',
            CPID_from_OSCAR__c = cpidVar
        );
    }     
    // Create new Org User
    public User setupBasicUser(Account testDepartment, String contactName, String profileName){
        Profile profileUser = [SELECT Id FROM Profile WHERE Name = :profileName];
        User returnValue = new User(
            Alias = 'testRun', 
            Email = contactName.replaceAll(' ', '') + '@cabinetoffice.gov.uk',
            EmailEncodingKey = 'UTF-8', 
            LastName = profileName + 'User',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_GB', 
            ProfileId = profileUser.Id,
            TimeZoneSidKey='Europe/London', 
            UserName = contactName.replaceAll(' ', '') + '@cabinetoffice.gov.uk' + testPortalSuffix
        );
        if(profileName == 'System Administrator'){
            returnValue.User_Type__c = 'System User';
        } else {
            Contact testContact = createContact(testDepartment.Id, contactName);
            insert testContact;
            returnValue.ContactId = testContact.Id;
            returnValue.User_Type__c = 'Super User';
            returnValue.PortalRole = 'Manager';
        }
        return returnValue;
    }
    // Create new Programme record
    public Programme__c createProgramme(String programmeName, String programmeReferenceNo){
        return new Programme__c(
            Name = programmeName,
            Programme_Reference_Number__c = programmeReferenceNo
        );
    }

    // Create new Programme record
    public Proposed_Grant__c createProposedGrant(String grantName){
        return new Proposed_Grant__c(
            Name = grantName
        );
    }
    // Create new Grant Scheme record
    public Grant_Scheme__c createGrantScheme(Account accountRecord, String schemeName, COFOG_L2__c cofogL2Record){
        if(testAuthorityAct == null){
           insertReferenceData(); 
        }
        return new Grant_Scheme__c(
            Start_Date__c = Date.today(),
            Duration__c = '1',
            Intermediated__c = false,
            Target_Location__c = 'Northern Ireland',
            Allocation_Method__c = 'Un-competed',
            Public_Funding_Source__c = 'UK Exchequer',
            Purpose_Explanation__c = 'some explanation',
            Recipient_Sector__c = 'Local Government',
            Funder__c = accountRecord.id,
            Capital_Resource__c = 'Capital',
            Scheme_Name__c = schemeName,
            Contact_email_address__c = 'test@cabinetoffice.gov.uk',
            Primary_Purpose__c = 'Supporting delivery of a public service',
            COFOG_L2__c = cofogL2Record.id,
            Scheme_Value__c = 0,
            Authority_Act__c = testAuthorityAct.Id,
    	    Risk_Profile__c ='Medium',
    	    Senior_Responsible_Officer_Full_Name__c = 'test',
    	    Considered_by_the_Grants_Advice_Panel__c ='No',
	        Related_policy_objective__c ='test'
        );
    }
    // Create new Grant Scheme record
    public Intermediary__c createIntermediary(Account accountRecord, Grant_Scheme__c grantScheme){
        return new Intermediary__c(
            Intermediary_Organisation__c = accountRecord.id,
            Grant_Scheme__c = grantScheme.id
        );
    }
    // Create new Intermediary Record using Grant Award
    public Intermediary__c createIntermediaryWithAward(Account accountRecord, Grant_Award__c grantAward) {
        return new Intermediary__c(
            Intermediary_Organisation__c = accountRecord.Id,
            Grant_Award__c = grantAward.Id
        );
    }

    // Create new Grant Scheme record
    public Grant_Award__c createGrantAward(String grantAwardName, Account accountRecord, Grant_Scheme__c grantScheme){
        if(testCOALevel == null){
           insertReferenceData(); 
        }
        return new Grant_Award__c(
            Allocation_Method__c = Constant.GA_ALLOC_MTHD_COMPETED,
            Recipient__c = accountRecord.id,
            Grant_Scheme__c = grantScheme.id,
            Total_Amount_in_funding_agreement__c = 100001,
            Grant_Award_Name__c = grantAwardName,
            Contact_Surname__c = 'Test Contact Surname',
            Recipient_Secondary_Address_1__c = 'Test Address 1',
            Recipient_Secondary_City__c = 'Test City 1',
            Recipient_Secondary_Country__c = 'Great London',
            Recipient_Secondary_Postal_Code__c = 'Test Postal Code',
            Contact_Forename__c = 'Test Contact Forename',
            Contact_Email__c = 'testContactEmail@cabinetoffice.gov.uk.dev',
            Award_Start_Date__c = Date.today(),
            Award_End_Date__c = Date.today().addYears(1),
            Is_The_Grant_Monitored__c = 'No',
            Reason_For_No_Monitoring__c = 'Test Record!',
            CCoA_L5__c = testCOALevel.Id,  // PPE - LAND (OWNED) - COST - O/BAL
            Risk_Profile__c = 'Medium'
        );
    }
    // Create New COFOG L2
    public COFOG_L2__c createCOFOG_L2(String nameCOFOG){
        return new COFOG_L2__c(
            Name = nameCOFOG,
            COFOG_L0_LONG_NAME__C='3. Public order and safety',
            COFOG_L1_LONG_NAME__C='3.6 Public order and safety n.e.c.',
            COFOG_L2_LONG_NAME__C='3.6.0 Public order and safety n.e.c.'
            );
    }
    // Create New COA L5
    public COA_L5__c createCOAL5(String nameCOAL5){
        return new COA_L5__c(
            Name = nameCOAL5,
            ACCOUNT_L1_LONG_NAME__C='ASSETS', 
            ACCOUNT_L2_LONG_NAME__C='PROPERTY, PLANT AND EQUIPMENT (PPE)',
            ACCOUNT_L3_LONG_NAME__C='PROPERTY, PLANT AND EQUIPMENT - LAND',
            ACCOUNT_L4_LONG_NAME__C='PPE - LAND (OWNED) - COST OR VALUATION',
            ACCOUNT_L5_LONG_NAME__C='PPE - LAND (OWNED) - COST - O/BAL',
            ACCOUNT_L5_DESCRIPTION__C='Gross book value of any owned land holdings and land underlying buildings. Land underlying or associated with dwellings to be separately disclosed.'
        );
    }

    public List<List<String>> createDefaultGrantAwardDataParsedCSV(){
        List<String> columnNames = new List<String>();
        List<String> columnValues = new List<String>();
        for(String columnNameToAdd : DEFAULT_GRANT_AWARD_DATA_PARSED.keySet()){
            columnNames.add(columnNameToAdd);
            columnValues.add(DEFAULT_GRANT_AWARD_DATA_PARSED.get(columnNameToAdd));
        }
        return new List<List<String>>{columnNames, columnValues};
    }

    public CSV_Upload__c createOrganisationGrantAwardCSVUpload(String type){
        return new CSV_Upload__c(
            Type__c = type,
            RecordTypeId = CSV_Upload__c.SObjectType.getDescribe().getRecordTypeInfosByName().get(Constant.CSV_UPLOAD_GRANT_AWARD_RT_NAME).getRecordTypeId(),
            Recipient_Type__c = Constant.GRT_ORGANISATION
        );
    }

    public Authority_Act__c createAuthorityAct(String name){
        return new Authority_Act__c(
            Name = name,
            Is_Active__c = true
        );
    }

    public void insertReferenceData(){
        testCOALevel = createCOAL5(TEST_CCOA_CODE);
        testCOFOGLevel = createCOFOG_L2(TEST_COFOG_CODE);
        testAuthorityAct = createAuthorityAct(TEST_AUTHORITY_ACT_NAME);
        insert new List<SObject>{
            testCOALevel, testCOFOGLevel, testAuthorityAct
        };
    }


    public List<CSV_Upload_Mapping_Column__c> createDefaultCSVColumnMappingItems(){
        CSVUploadMappingMockDataFactory csvUploadMappingFactory = new CSVUploadMappingMockDataFactory();
        return csvUploadMappingFactory.create();
    }
}