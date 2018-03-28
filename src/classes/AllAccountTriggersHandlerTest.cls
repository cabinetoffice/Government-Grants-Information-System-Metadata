/******************************************************************************************
@Author         Divino Brinas
@Date           09/24/2015
@Project        Cloud Sherpas Cabinet Office Data Source
@Description    Test class responsible for unit testing of AllAccountTriggerHandler
                                     
*******************************************************************************************/ 
@isTest
private class AllAccountTriggersHandlerTest{

    // Create 2 System Users: 1 for AdminUser and 1 for non-adminUser
    static User adminUser;
    static User superUser;
    static User standardUser;
    static String userName_ForAdmin = 'AdminAccount';
    static String userName_ForSuperUser = 'SuperUserAccount';
    static String userName_ForStandardUser = 'BasicUserAccount';

    static Account accAdmin;
    static Account accSuperUser;
    static Account accStandardUser;

    static Grant_Scheme__c grantScheme;
    static Grant_Award__c grantAward;
    static Intermediary__c grantIntermediary;
    
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
                TestDataFactory testAccount = new TestDataFactory();
                accAdmin = testAccount.createAccount('AdminRecord', 'AdminRecord');
                insert accAdmin;
            }
        }
        if(accSuperUser == null){
            // Create Account with non-adminUser access, we call it NonAdminRecord01
            System.runAs(superUser){
                TestDataFactory testAccount = new TestDataFactory();
                accSuperUser = testAccount.createAccount('NonAdminRecord01', 'NonAdminRecord01');
                insert accSuperUser;
            }
        }
        if(accStandardUser == null){
            // Create Account with non-adminUser access, we call it NonAdminRecord02
            System.runAs(standardUser){
                TestDataFactory testAccount = new TestDataFactory();
                accStandardUser = testAccount.createAccount('NonAdminRecord02', 'NonAdminRecord02');
                insert accStandardUser;
            }            
        }
    }
    /****** POSITIVE TEST ********/
    @isTest static void testDeletionForSuperUserSuccess(){
        if(accAdmin == null || accSuperUser == null || accStandardUser == null){
            createData();
        }
        // Start Deleting record
        String accountIDDeletedPositive;
        String errorMessagePositive;
        List<Account> listAcct = [SELECT Id, Name FROM Account];
        Test.startTest();
            // Test Positively
            System.runAs(superUser){
                try{
                    for(Account acct : listAcct ){
                        if(acct.Name == 'NonAdminRecord01' ){
                            accountIDDeletedPositive = acct.id;
                            delete acct;
                        }
                    }
                }
                catch(Exception exp){
                    errorMessagePositive = String.valueof(exp);
                    accountIDDeletedPositive = '';
                    system.debug('**** ERROR IN DELETION ='+ exp);
                }
            }
        Test.stopTest();   
        if(accountIDDeletedPositive <> '' ){
            List<Account> listAccountAfterDelete = [SELECT Id, Name FROM Account];
            Boolean isAccountExistPos = false;
            for(Account acct : listAccountAfterDelete ){
                if(acct.id == accountIDDeletedPositive){
                    isAccountExistPos = true;
                    break;
                }
            }
            // False, because Id has been deleted
            System.assertEquals(isAccountExistPos, false);
        }
    }
    @isTest static void testDeletionForStandardUserSuccess(){
        if(accAdmin == null || accSuperUser == null || accStandardUser == null){
            createData();
        }
        // Start Deleting record
        String accountIDDeletedPositive;
        String errorMessagePositive;
        List<Account> listAcct = [SELECT Id, Name FROM Account];
        Test.startTest();
            // Test Positively
            System.runAs(standardUser){
                try{
                    for(Account acct : listAcct ){
                        if(acct.Name == 'NonAdminRecord02' ){
                            accountIDDeletedPositive = acct.id;
                            delete acct;
                        }
                    }
                }
                catch(Exception exp){
                    errorMessagePositive = String.valueof(exp);
                    accountIDDeletedPositive = '';
                    system.debug('**** ERROR IN DELETION ='+ exp);
                }
            }
        Test.stopTest(); 
        if(accountIDDeletedPositive <> '' ){
            List<Account> listAccountAfterDelete = [SELECT Id, Name FROM Account];
            Boolean isAccountExistPos = false;
            for(Account acct : listAccountAfterDelete ){
                if(acct.id == accountIDDeletedPositive){
                    isAccountExistPos = true;
                    break;
                }
            }
            // False, because Id has been deleted
            System.assertEquals(isAccountExistPos, false);
        }
        System.debug(' @@@@@ testDeletionForStandardUserSuccess END ');
    }

    /****** NEGATIVE TEST ********/
    @isTest static void testDeletionForSuperUserFailed(){
        if(accAdmin == null || accSuperUser == null || accStandardUser == null){
            createData();
        }
        // Start Deleting record
        String accountIDDeletedNegative;
        String errorMessage;
        List<Account> listAcct = [SELECT Id, Name FROM Account];
        Test.startTest();
            // Test Negatively 
            System.runAs(superUser){
                try{
                    for(Account acct : listAcct ){
                        if(acct.Name == 'NonAdminRecord02' ){
                            accountIDDeletedNegative = acct.id;
                            delete acct;
                        }
                    }
                }
                catch(Exception exp){
                    errorMessage = String.valueof(exp);
                    accountIDDeletedNegative = '';
                    system.debug('**** ERROR IN DELETION ='+ exp);
                }
                
            }
        Test.stopTest();
        
        // Assertion
        // Negative Test
        if(accountIDDeletedNegative == ''){
            System.assert(errorMessage.Contains('Delete failed'));
        }
    }
    @isTest static void testDeletionForStandardUserFailed(){
        if(accAdmin == null || accSuperUser == null || accStandardUser == null){
            createData();
        }
        // Start Deleting record
        String accountIDDeletedNegative;
        String errorMessage;
        List<Account> listAcct = [SELECT Id, Name FROM Account];
        Test.startTest();
            // Test Negatively 
            System.runAs(standardUser){
                try{
                    for(Account acct : listAcct ){
                        if(acct.Name == 'NonAdminRecord01' ){
                            accountIDDeletedNegative = acct.id;
                            delete acct;
                        }
                    }
                }
                catch(Exception exp){
                    errorMessage = String.valueof(exp);
                    accountIDDeletedNegative = '';
                    system.debug('**** ERROR IN DELETION ='+ exp);
                }
                
            }
        Test.stopTest();
        
        // Assertion
        // Negative Test
        if(accountIDDeletedNegative == ''){
            System.assert(errorMessage.Contains('Delete failed'));
        }
    }

    @isTest
    static void testDeleteCheckRelatedRecordsOrgWithGrantAward() {
        String errorMsg = '';
        if(accAdmin == null || accSuperUser == null || accStandardUser == null){
            createData();
            createAcountRelatedData();
        }

        Test.startTest();
            System.runAs(adminUser) {
                try {
                    delete accAdmin;
                } catch (Exception e) {
                    errorMsg = e.getMessage();
                    System.assert(e.getMessage().contains(System.Label.Organisation_Related_Grants_Delete_Error_Message));
                }
            }
        Test.stopTest();
        System.assert(errorMsg.contains(System.Label.Organisation_Related_Grants_Delete_Error_Message));
    }

    @isTest
    static void testDeleteCheckRelatedRecordsOrgWithGrantScheme() {
        String errorMsg = '';
        if(accAdmin == null || accSuperUser == null || accStandardUser == null){
            createData();
            createAcountRelatedData();
        }

        Test.startTest();
            System.runAs(adminUser) {
                try {
                    delete accAdmin;
                } catch (Exception e) {
                    errorMsg = e.getMessage();
                    System.assert(e.getMessage().contains(System.Label.Organisation_Related_Grants_Delete_Error_Message));
                }
            }
        Test.stopTest();
        System.assert(errorMsg.contains(System.Label.Organisation_Related_Grants_Delete_Error_Message));
    }

    @isTest
    static void testDeleteCheckRelatedRecordsOrgWithGrantIntermediary() {
        String errorMsg = '';
        if(accAdmin == null || accSuperUser == null || accStandardUser == null){
            createData();
            createAcountRelatedData();
        }

        Test.startTest();
            System.runAs(adminUser) {
                try {
                    delete accAdmin;
                } catch (Exception e) {
                    errorMsg = e.getMessage();
                    System.assert(e.getMessage().contains(System.Label.Organisation_Related_Grants_Delete_Error_Message));
                }
            }
        Test.stopTest();
        System.assert(errorMsg.contains(System.Label.Organisation_Related_Grants_Delete_Error_Message));
    }

    @isTest
    static void testDeleteCheckAccountWithChild() {
        String errorMsg = '';
        if(accAdmin == null || accSuperUser == null || accStandardUser == null){
            createData();
        }
        System.runAs(adminUser) {
            TestDataFactory testFactory = new TestDataFactory();
            Account childAcc = testFactory.createAccount('ChildAcctRecord', 'ChildAcctRecord');
            childAcc.ParentId = accAdmin.Id;
            insert childAcc;
            
            Test.startTest();      
                    try {
                        delete accAdmin;
                    } catch (Exception e) {
                        errorMsg = e.getMessage();
                        System.assert(e.getMessage().contains(System.Label.Organisation_Has_Child_Delete_Error_Message));
                    }
                
            Test.stopTest();
        }

        System.assert(errorMsg.contains(System.Label.Organisation_Has_Child_Delete_Error_Message));
    }

    static void createAcountRelatedData() {
        TestDataFactory testFactory = new TestDataFactory();
        testFactory.insertReferenceData();
        System.runAs(adminUser){
            grantScheme = testFactory.createGrantScheme(accAdmin, 'Test Grant Scheme', testFactory.testCOFOGLevel);
            insert grantScheme;
            grantAward = testFactory.createGrantAward('Test Grant Award', accAdmin, grantScheme);
            insert grantAward;
            grantIntermediary = testFactory.createIntermediary(accAdmin, grantScheme);
            insert grantIntermediary;
        }
    }
}