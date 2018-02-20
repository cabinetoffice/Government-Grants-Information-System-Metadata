/******************************************************************************************
@Author         Divino Brinas
@Date           09/24/2015
@Project        Cloud Sherpas Cabinet Office Data Source
@Description    Test class responsible for unit testing of AllGrantSchemeTriggersHandler
                                     
*******************************************************************************************/ 
@isTest//(seealldata=true) do note use this syntax
public class AllGrantSchemeTriggersHandlerTest {
	// Create 2 System Users: 1 for AdminUser and 1 for non-adminUser
    static User adminUser;
    static User superUser;
    static User standardUser;
    static String userName_ForAdmin = 'AdminAccount';
    static String userName_ForSuperUser = 'SuperUserAccount';
    static String userName_ForStandardUser = 'BasicUserAccount';
    static String grantSchemeIDBySuperUser;
    static String grantSchemeIDByStandardUser;

    static Account accAdmin;
    static Account accSuperUser;
    static Account accStandardUser;

    static Grant_Scheme__c grantSchemeAdmin;
    static COFOG_L2__c cofogAdmin;
    static Grant_Scheme__c grantSchemeSuperUser;
    static COFOG_L2__c cofogSuperUser;    
    static Grant_Scheme__c grantSchemeStandard;
    static COFOG_L2__c cofogStandard; 
            
    // Setting up the Users (Admin, Super User and standard User)
    static void setupUser(){
        TestDataFactory testFactory = new TestDataFactory();
        if(adminUser == null){
            Account acctAdmin = testFactory.createAccount('SystemAdminUser','SystemAdminUser');
            insert acctAdmin;
            adminUser = testFactory.setupBasicUser(acctAdmin,'AdminContact','System Administrator');
            insert adminUser;            
        }
        if(superUser == null){
            Account acctSuperUser = testFactory.createAccount('SuperUser','SuperUser');
            insert acctSuperUser;            
            superUser = testFactory.setupBasicUser(acctSuperUser ,'SuperUserContact','Data Solution Portal - Super User');
            insert superUser ;
        }
        if(standardUser == null){
            Account acctStandardUser = testFactory.createAccount('StandardUser','StandardUser');
            insert acctStandardUser;  
            standardUser = testFactory.setupBasicUser(acctStandardUser ,'BasicUserContact','Data Solution Portal - User');
            insert standardUser;
        }
    }
    // Create Data
    static void createData(){
        if(adminUser == null || superUser == null || standardUser == null){
            setupUser();
        }
        if(accAdmin == null){
            // Create Account with AdminUser access, we call it AdminRecord
            System.runAs(adminUser){
                TestDataFactory testDataFactory = new TestDataFactory();
                accAdmin = testDataFactory.createAccount('AdminRecord', 'AdminRecord');
                insert accAdmin;
                cofogAdmin = testDataFactory.createCOFOG_L2('COFOG030600');
                insert cofogAdmin;
                grantSchemeAdmin = testDataFactory.createGrantScheme(accAdmin, 'Test Grant Award NonAdminRecord01',cofogAdmin);
                insert grantSchemeAdmin;
            }
        }
        if(accSuperUser == null){
            // Create Account with non-adminUser access, we call it NonAdminRecord01
            System.runAs(superUser){
                TestDataFactory testDataFactory = new TestDataFactory();
                accSuperUser = testDataFactory.createAccount('NonAdminRecord01', 'NonAdminRecord01');
                insert accSuperUser;
                cofogSuperUser = testDataFactory.createCOFOG_L2('COFOG030600');
                insert cofogSuperUser;
                grantSchemeSuperUser = testDataFactory.createGrantScheme(accSuperUser, 'Test Grant Award NonAdminRecord01',cofogSuperUser);
                insert grantSchemeSuperUser;
                grantSchemeIDBySuperUser = grantSchemeSuperUser.id;
            }
        }
        if(accStandardUser == null){
            // Create Account with non-adminUser access, we call it NonAdminRecord02
            System.runAs(standardUser){
                TestDataFactory testDataFactory = new TestDataFactory();
                accStandardUser = testDataFactory.createAccount('NonAdminRecord02', 'NonAdminRecord02');
                insert accStandardUser;
                cofogStandard = testDataFactory.createCOFOG_L2('COFOG030600');
                insert cofogStandard;
                grantSchemeStandard = testDataFactory.createGrantScheme(accStandardUser, 'Test Grant Award NonAdminRecord02',cofogStandard);
                insert grantSchemeStandard;
                grantSchemeIDByStandardUser = grantSchemeStandard.id;
            }            
        }
    }    

    /****** POSITIVE TEST ********/
    @isTest static void testDeletionForSuperUserSuccess(){
        if(grantSchemeAdmin == null || grantSchemeSuperUser == null || grantSchemeStandard == null){
            createData();
        }
        // Start Deleting record
        String grantSchemeIDDeletedPositive;
        String errorMessagePos;
        List<Grant_Scheme__c> listGrantScheme = [SELECT Id, Name FROM Grant_Scheme__c];
        Test.startTest();
            // Test Negatively
            System.runAs(superUser){
                try{
                    for(Grant_Scheme__c schemeList : listGrantScheme ){
                        if(schemeList.id == grantSchemeIDBySuperUser ){
                            grantSchemeIDDeletedPositive = schemeList.id;
                            delete schemeList;
                        }
                    }
                }
                catch(Exception exp){
                    errorMessagePos = String.valueof(exp);
                    grantSchemeIDDeletedPositive = '';
                    system.debug('**** ERROR IN DELETION ='+ exp);
                }
                
            }
        Test.stopTest();
        if(grantSchemeIDDeletedPositive <> ''){
            List<Grant_Scheme__c> listGrantSchemeAfterDelete = [SELECT Id, Name FROM Grant_Scheme__c];
            Boolean isGrantSchemeExist = false;
            for(Grant_Scheme__c schemeList : listGrantSchemeAfterDelete ){
                if(schemeList.id == grantSchemeIDDeletedPositive ){
                    isGrantSchemeExist = true;
                    break;
                }
            }
            // False, because Id has been deleted
            System.assertEquals(isGrantSchemeExist, false);
        }
    }
    /*****/
    @isTest static void testDeletionForStandardUserSuccess(){
        if(grantSchemeAdmin == null || grantSchemeSuperUser == null || grantSchemeStandard == null){
            createData();
        }
        // Start Deleting record
        String grantSchemeIDDeletedPositive;
        String errorMessagePos;
        List<Grant_Scheme__c> listGrantScheme = [SELECT Id, Name FROM Grant_Scheme__c];
        Test.startTest();
            // Test Negatively
            System.runAs(standardUser){
                try{
                    for(Grant_Scheme__c schemeList : listGrantScheme ){
                        if(schemeList.id == grantSchemeIDByStandardUser){
                            grantSchemeIDDeletedPositive = schemeList.id;
                            delete schemeList;
                        }
                    }
                }
                catch(Exception exp){
                    errorMessagePos = String.valueof(exp);
                    grantSchemeIDDeletedPositive = '';
                    system.debug('**** ERROR IN DELETION ='+ exp);
                }
                
            }
        Test.stopTest();
        if(grantSchemeIDDeletedPositive <> ''){
            List<Grant_Scheme__c> listGrantSchemeAfterDelete = [SELECT Id, Name FROM Grant_Scheme__c];
            Boolean isGrantSchemeExist = false;
            for(Grant_Scheme__c schemeList : listGrantSchemeAfterDelete ){
                if(schemeList.id == grantSchemeIDDeletedPositive ){
                    isGrantSchemeExist = true;
                    break;
                }
            }
            // False, because Id has been deleted
            System.assertEquals(isGrantSchemeExist, false);
        }
    }
    /*****/
    /****** NEGATIVE TEST ********/
    @isTest static void testDeletionForSuperUserFailed(){
        if(grantSchemeAdmin == null || grantSchemeSuperUser == null || grantSchemeStandard == null){
            createData();
        }
        // Start Deleting record
        String grantSchemeIDDeletedNegative;
        String errorMessageNeg;
        List<Grant_Scheme__c> listGrantScheme = [SELECT Id, Name FROM Grant_Scheme__c];
        Test.startTest();
            // Test Negatively
            System.runAs(superUser){
                try{
                    for(Grant_Scheme__c schemeList : listGrantScheme ){
                        if(schemeList.id == grantSchemeIDByStandardUser ){
                            grantSchemeIDDeletedNegative = schemeList.id;
                            delete schemeList;
                        }
                    }
                }
                catch(Exception exp){
                    errorMessageNeg = String.valueof(exp);
                    grantSchemeIDDeletedNegative = '';
                    system.debug('**** ERROR IN DELETION ='+ exp);
                }
                
            }
        Test.stopTest();
        
        // Assertion
        // Negative Test
        if(grantSchemeIDDeletedNegative == ''){
            System.assert(errorMessageNeg.Contains('Delete failed'));
        }
    }
    @isTest static void testDeletionForStandardUserFailed(){
        if(grantSchemeAdmin == null || grantSchemeSuperUser == null || grantSchemeStandard == null){
            createData();
        }
        // Start Deleting record
        String grantSchemeIDDeletedNegative;
        String errorMessageNeg;
        List<Grant_Scheme__c> listGrantScheme = [SELECT Id, Name FROM Grant_Scheme__c];
        Test.startTest();
            // Test Negatively
            System.runAs(standardUser){
                try{
                    for(Grant_Scheme__c schemeList : listGrantScheme ){
                        if(schemeList.id == grantSchemeIDBySuperUser ){
                            grantSchemeIDDeletedNegative = schemeList.id;
                            delete schemeList;
                        }
                    }
                }
                catch(Exception exp){
                    errorMessageNeg = String.valueof(exp);
                    grantSchemeIDDeletedNegative = '';
                    system.debug('**** ERROR IN DELETION ='+ exp);
                }
                
            }
        Test.stopTest();
        
        // Assertion
        // Negative Test
        if(grantSchemeIDDeletedNegative == ''){
            System.assert(errorMessageNeg.Contains('Delete failed'));
        }
    }

    /**@isTest
    //static void testDeleteGrantSchemeNotWithin48HoursOfCreation() {
        String errorMsg = '';

        if(grantSchemeAdmin == null || grantSchemeSuperUser == null || grantSchemeStandard == null){
            createData();
        }
        Test.setCreatedDate(grantSchemeSuperUser.Id, Datetime.newInstance(2016, 3, 3));

        System.runAs(superUser){
            Test.startTest();
                try {
                    delete grantSchemeSuperUser;
                } catch (Exception e) {
                    errorMsg = e.getMessage();
                    System.assert(e.getMessage().contains(System.Label.Grant_Scheme_Delete_Validation_Error_Message));
                }
            Test.stopTest();
        }

         System.assert(errorMsg.contains(System.Label.Grant_Scheme_Delete_Validation_Error_Message)); 
    }**/
}