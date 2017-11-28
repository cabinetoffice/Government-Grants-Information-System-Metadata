/******************************************************************************************
@Author         Divino Brinas
@Date           09/24/2015
@Project        Cloud Sherpas Cabinet Office Data Source
@Description    Main entry for all the trigger events on Grant_Award__c object
*******************************************************************************************/
public without sharing class AllGrantAwardTriggersHandler {

    private static final Set<String> AWARD_ADDRESS_FIELDS = new Set<String> {
        'Recipient_Secondary_Address_1__c',
        'Recipient_Secondary_Address_2__c',
        'Recipient_Secondary_City__c',
        'Recipient_Secondary_Country__c',
        'Recipient_Secondary_County__c',
        'Recipient_Secondary_Postal_Code__c'
    };

    public static void handleBeforeInsert(List<Grant_Award__c> newList) {
        List<Grant_Award__c> grantAwardToAddRecipientAddressTo = new List<Grant_Award__c>();
        for (Grant_Award__c grantAwardToCheck : newList) {
            Boolean hasRecipient = String.isNotBlank(grantAwardToCheck.Recipient__c);
            if (hasRecipient && grantAwardToCheck.Get_existing_organisation_address__c) {
                grantAwardToAddRecipientAddressTo.add(grantAwardToCheck);
            }
        }
        if (!grantAwardToAddRecipientAddressTo.isEmpty()) {
            addRecipientAddToGrantAward(grantAwardToAddRecipientAddressTo);
        }

        clearReasonForNoMonitoring(newlist);
        GrantFYcal.GrantFinancialYear(newList);
    }

    public static void handleBeforeUpdate(List<Grant_Award__c> newList, Map<Id, Grant_Award__c> oldGrantAwards) {
        List<Grant_Award__c> grantAwardToAddRecipientAddressTo = new List<Grant_Award__c>();
        for (Grant_Award__c updateGrantAwardToCheck : newList) {
            Grant_Award__c oldGrantAward = oldGrantAwards.get(updateGrantAwardToCheck.Id);
            Boolean getFromExistingOrganisationHasChange = oldGrantAward.Get_existing_organisation_address__c != updateGrantAwardToCheck.Get_existing_organisation_address__c;
            Boolean hasAnyAddressValueChanged = getHasAnyAddressValueChanged(oldGrantAward, updateGrantAwardToCheck);
            Boolean hasRecipient = String.isNotBlank(updateGrantAwardToCheck.Recipient__c);
            if (getFromExistingOrganisationHasChange && hasRecipient && updateGrantAwardToCheck.Get_existing_organisation_address__c) {
                grantAwardToAddRecipientAddressTo.add(updateGrantAwardToCheck);
            } else if (hasAnyAddressValueChanged) {
                updateGrantAwardToCheck.Get_existing_organisation_address__c = false;
            }
        }
        if (!grantAwardToAddRecipientAddressTo.isEmpty()) {
            addRecipientAddToGrantAward(grantAwardToAddRecipientAddressTo);
        }

        clearReasonForNoMonitoring(newlist);
        GrantFYcal.GrantFinancialYear(newList);
    }

    private static Boolean getHasAnyAddressValueChanged(Grant_Award__c oldGrantAward, Grant_Award__c updateGrantAwardToCheck) {
        for (String addressFieldtoCheck : AWARD_ADDRESS_FIELDS) {
            String oldValue = (String) oldGrantAward.get(addressFieldtoCheck);
            String newValue = (String) updateGrantAwardToCheck.get(addressFieldtoCheck);
            if (oldValue != newValue) {
                return true;
            }
        }
        return false;
    }

    private static void addRecipientAddToGrantAward(List<Grant_Award__c> awardsToChange) {
        Set<Id> recipientIds = new Set<Id>();
        for (Grant_Award__c awardToChange : awardsToChange) {
            recipientIds.add(awardToChange.Recipient__c);
        }
        Map<Id, Account> queriedRecipients = new Map<Id, Account>([
                    SELECT Id, Primary_Address_1__c, Primary_Address_2__c, Primary_City__c,
                    Primary_County__c, Primary_Postal_Code__c, Primary_Country__c
                    FROM Account
                    WHERE Id IN :recipientIds
                ]);
        for (Grant_Award__c awardToChange : awardsToChange) {
            Account recipientToUse = queriedRecipients.get(awardToChange.Recipient__c);
            awardToChange.Recipient_Secondary_Address_1__c = recipientToUse.Primary_Address_1__c;
            awardToChange.Recipient_Secondary_Address_2__c = recipientToUse.Primary_Address_2__c;
            awardToChange.Recipient_Secondary_City__c = recipientToUse.Primary_City__c;
            awardToChange.Recipient_Secondary_Country__c = recipientToUse.Primary_Country__c;
            awardToChange.Recipient_Secondary_County__c = recipientToUse.Primary_County__c;
            awardToChange.Recipient_Secondary_Postal_Code__c = recipientToUse.Primary_Postal_Code__c;
        }
    }

    public static void handleBeforeDelete(Map<Id, Grant_Award__c> oldMap) {
        User u = [SELECT Profile.NAME FROM User WHERE ID = :UserInfo.getUserID()]; 
        If(u.profile.NAME != 'System Administrator'){
            Map<Id, Grant_Award__c> queriedGrantAwards = new Map<Id, Grant_Award__c>([
                        SELECT Id, Is_My_Department_Data__c, Portal_User_Cannot_Delete_This_Record__c
                        FROM Grant_Award__c
                        WHERE Id IN :oldMap.keySet()
                    ]);
            for (Grant_Award__c grantAwardToCheck : oldMap.values()) {
                Grant_Award__c queriedGrantAward = queriedGrantAwards.get(grantAwardToCheck.id);
                checkUserDepartment(queriedGrantAward, grantAwardToCheck);
                if (queriedGrantAward.Portal_User_Cannot_Delete_This_Record__c) {
                    grantAwardToCheck.addError(System.Label.Grant_Award_Delete_Validation_Error_Message);
                }
            }
        }
    }
    private static void checkUserDepartment(Grant_Award__c queriedGrantAward, Grant_Award__c grantAwardToCheck) {
        Boolean isRunningUserRoleDifferentFromOwnerUserRole = /** UserInfo.getUserType() == Constant.USER_TYPE_COMMUNITY_PLUS**/!queriedGrantAward.Is_My_Department_Data__c;
        if (isRunningUserRoleDifferentFromOwnerUserRole) {
            grantAwardToCheck.addError(System.Label.User_Delete_Access_Error_Msg);
        }
    }

    /**
     * method to clear the 'Reason for no mentoring' field when is the Grant is monitored
     * @author  Bhushan Sukumar
     * @date    29 Mar 2016
     * @param   newList  trigger list
     */
    private static void clearReasonForNoMonitoring(List<Grant_Award__c> newList) {
        for (Grant_Award__c award : newlist) {
            try {
                if (award.Is_The_Grant_Monitored__c == Constant.GRANT_MONITORED_YES &&
                        !String.isBlank(award.Reason_For_No_Monitoring__c)) {
                    award.Reason_For_No_Monitoring__c = '';
                }
            } catch (Exception e) {
                award.addError(Label.Grant_Award_Update_Exception_Msg + award.Grant_Scheme__c);
                award.addError(e.getMessage());
            }
        }
    }
}