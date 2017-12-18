/******************************************************************************************
@Author         Bhushan Sukumar
@Date           29 Mar 2016
@Description    This is the batch processor which updates the 'Send Grant Reminder' flag on users
*******************************************************************************************/
global class SendIncompleteGrantReminder
    implements Database.Batchable<sObject>, Database.AllowsCallouts, Schedulable {

    global String query {get; set;}

    global Database.QueryLocator start(Database.BatchableContext BC) {

        return Database.getQueryLocator([SELECT Id,
                                         CreatedById, Actual_Payment__c
                                         , Payment_Frequency__c
                                         , Award_Start_Date__c
                                         , Award_End_Date__c
                                         , CreatedBy.IsActive
                                         FROM Grant_Award__c
                                         WHERE Actual_Payment__c = null
                                                 AND ((Payment_Frequency__c = : Constant.UPFRONT_PAYMENT
                                                         AND Award_Start_Date__c = LAST_MONTH)
                                                         OR ((Payment_Frequency__c = : Constant.INSTALMENT_PAYMENTS
                                                                 OR Payment_Frequency__c = : Constant.END_PAYMENT
                                                                         OR Payment_Frequency__c = : Constant.ADHOC_PAYMENT)
                                                                 AND Award_End_Date__c = LAST_MONTH))]);
    }

    global void execute(SchedulableContext sc) {
        Database.executeBatch(new SendIncompleteGrantReminder());
    }

    global void execute(Database.BatchableContext BC, List<Grant_Award__c> grantAwards) {
        //Checking the 'Bypass' switch before executing the logic.
        Bypass__c bypassSetting = Bypass__c.getInstance();
        //flag the determine if any of the 'CreatedBy' user is inactive.
        boolean notifyAdmin = false;
        if (!bypassSetting.Grant_Reminders__c) {
            Set<Id> userIds = new Set<Id>();
            for (Grant_Award__c gAward : grantAwards) {
                if (!userIds.contains(gAward.createdById) && gAward.CreatedBy.IsActive) {
                    userIds.add(gAward.CreatedById);
                }
                if (!gAward.CreatedBy.IsActive) {
                    notifyAdmin = true;
                }
            }
            List<User> usersToUpdate = [SELECT Id,
                                        SendGrantReminder__c FROM User
                                        WHERE Id IN : userIds LIMIT 10000];
            for (User userToRemind : usersToUpdate) {
                userToRemind.SendGrantReminder__c = true;
            }
            update usersToUpdate;
            if (notifyAdmin) {
                List<User> adminUsers = [SELECT Id,
                                         SendInactiveUserEmail__c
                                         FROM User
                                         WHERE Profile.Name = : Constant.PROFILE_SYSADMIN
                                                 AND IsActive = TRUE LIMIT 10000];
                for (User admin : adminUsers) {
                    //checking this flag will trigger the workflow to send email
                    admin.SendInactiveUserEmail__c = true;
                }
                update adminUsers;
            }
        }
    }

    global void finish(Database.BatchableContext BC) {

    }
}