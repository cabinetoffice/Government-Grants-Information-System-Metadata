/******************************************************************************************
@Author         Divino Brinas
@Date           09/24/2015
@Project        Cloud Sherpas Cabinet Office Data Source
@Description    Test class responsible for unit testing of AllProgrammeTriggersHandler
                                     
*******************************************************************************************/ 
@isTest
private class AllProgrammeTriggersHandlerTest {
    // Create 2 System Users: 1 for AdminUser and 1 for non-adminUser
    static User adminUser;
    static User superUser;
    static User standardUser;
    static String userName_ForAdmin = 'AdminAccount';
    static String userName_ForSuperUser = 'SuperUserAccount';
    static String userName_ForStandardUser = 'BasicUserAccount';
    static String programmeIDBySuperUser;
    static String programmeIDByStandardUser;

    static Programme__c programmeAdmin;
    static Programme__c programmeSuperUser;
    static Programme__c programmeStandardUser;
    static Programme__c programmeSuperUser2;
            
            
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
        if(programmeAdmin == null){
            TestDataFactory testAccount = new TestDataFactory();
            programmeAdmin = testAccount.createProgramme('AdminRecord', 'AdminRecord');
            insert programmeAdmin;            
        }
        if(programmeSuperUser == null){
            TestDataFactory testAccount = new TestDataFactory();
            programmeSuperUser = testAccount.createProgramme('NonAdminRecord01', 'NonAdminRecord01');
            insert programmeSuperUser;
            programmeIDBySuperUser = programmeSuperUser.id;
        }
        if(programmeStandardUser == null){
            TestDataFactory testAccount = new TestDataFactory();
            programmeStandardUser = testAccount.createProgramme('NonAdminRecord02', 'NonAdminRecord02');
            insert programmeStandardUser;
            programmeIDByStandardUser = programmeStandardUser.id;
        }
    }
    /****** POSITIVE TEST ********/
    @isTest static void testDeletionForSuperUserSuccess(){
        if(programmeAdmin == null || programmeSuperUser == null || programmeStandardUser == null){
            createData();
        }
        // Start Deleting record
        String programmeIDDeletedPositive;
        String errorMessagePositive;
        List<Programme__c> listprogramme = [SELECT Id, Name FROM Programme__c];
        Test.startTest();
            // Test Positively
            System.runAs(adminUser){
                try{
                    for(Programme__c programmeList : listprogramme ){
                        if(programmeList.id == programmeIDBySuperUser ){
                            programmeIDDeletedPositive = programmeList.id;
                            delete programmeList;
                        }
                    }
                }
                catch(Exception exp){
                    errorMessagePositive = String.valueof(exp);
                    programmeIDDeletedPositive = '';
                    system.debug('**** ERROR IN DELETION ='+ exp);
                }
            }
        Test.stopTest();   
        if(programmeIDDeletedPositive <> '' ){
            List<Programme__c> listProgrammeAfterDelete = [SELECT Id, Name FROM Programme__c];
            Boolean isProgrammeExistPos = false;
            for(Programme__c prog : listProgrammeAfterDelete ){
                if(prog.id == programmeIDDeletedPositive){
                    isProgrammeExistPos = true;
                    break;
                }
            }
            // False, because Id has been deleted
            System.assertEquals(isProgrammeExistPos, false);
        }
    }
    /****** NEGATIVE TEST ********/
   
    @isTest static void testDeletionForSuperUserFailed(){
        if(programmeAdmin == null || programmeSuperUser == null || programmeStandardUser == null){
            createData();
        }
        // Start Deleting record
        String programmeIDDeletedNegative;
        String errorMessageNegative;
        List<Programme__c> listprogramme = [SELECT Id, Name FROM Programme__c];
        Test.startTest();
            // Test Positively
            System.runAs(superUser){
                try{
                    for(Programme__c programmeList : listprogramme ){
                        if(programmeList.id == programmeIDByStandardUser ){
                            programmeIDDeletedNegative = programmeList.id;
                            delete programmeList;
                        }
                    }
                }
                catch(Exception exp){
                    errorMessageNegative = String.valueof(exp);
                    programmeIDDeletedNegative = '';
                    system.debug('**** ERROR IN DELETION ='+ exp);
                }
            }
        Test.stopTest(); 
        
        // Assertion
        // Negative Test
        if(programmeIDDeletedNegative == ''){
            System.assert(errorMessageNegative.Contains('Delete failed'));
        }
    }    

    @isTest
    static void testDeleteProgrammeNotWithin48HoursOfCreation() {
        String errorMsg = '';

        if(programmeAdmin == null || programmeSuperUser == null || programmeStandardUser == null){
            createData();
        }

        System.runAs(superUser) {
            TestDataFactory testFactory = new TestDataFactory();

            programmeSuperUser2 = testFactory.createProgramme('NonAdminRecord01', 'NonAdminRecord01');
            insert programmeSuperUser2;
        }

        Test.setCreatedDate(programmeSuperUser2.Id, Datetime.newInstance(2016, 3, 3));

        System.runAs(superUser) {
            Test.startTest();
                try {
                    delete programmeSuperUser2;
                } catch (Exception e) {
                    errorMsg = e.getMessage();
                    System.assert(e.getMessage().contains(System.Label.Grant_Programme_Delete_Validation_Error_Message));
                }
            Test.stopTest();
        }
        
        System.assert(errorMsg.contains(System.Label.Grant_Programme_Delete_Validation_Error_Message));     
    }

}