/******************************************************************************************
@Author         Divino Brinas
@Date           09/24/2015
@Project        Cloud Sherpas Cabinet Office Data Source
@Description    Main entry for all the trigger events on Intermediary__c object
*******************************************************************************************/
public without sharing class AllIntermediaryTriggersHandler {
	public static void handleBeforeDelete(Map<Id, Intermediary__c> oldMap){
        Map<Id, Intermediary__c> queriedIntermediaries = new Map<Id, Intermediary__c>([
            SELECT Id, Owner.UserRoleId, Grant_Award__r.Portal_User_Cannot_Delete_This_Record__c, Grant_Scheme__r.Portal_User_Cannot_Delete_This_Record__c
            FROM Intermediary__c
            WHERE Id IN :oldMap.keySet()
        ]);
        for(Intermediary__c intermediaryToCheck : oldMap.values()){
            Intermediary__c queriedIntermediary = new Intermediary__c();
            queriedIntermediary = queriedIntermediaries.get(intermediaryToCheck.id);
            checkUserDepartment(queriedIntermediary, intermediaryToCheck);
            if (queriedIntermediary.Grant_Award__r.Portal_User_Cannot_Delete_This_Record__c
                    || queriedIntermediary.Grant_Scheme__r.Portal_User_Cannot_Delete_This_Record__c) {
                intermediaryToCheck.addError(System.Label.Grant_Intermediary_Delete_Validation_Error_Message);
            }
        }
    }
    private static void checkUserDepartment(Intermediary__c queriedIntermediary, Intermediary__c intermediaryToCheck){
        Boolean isRunningUserRoleDifferentFromOwnerUserRole = UserInfo.getUserType() == Constant.USER_TYPE_COMMUNITY_PLUS && UserInfo.getUserRoleId() != queriedIntermediary.Owner.UserRoleId;
        if(isRunningUserRoleDifferentFromOwnerUserRole){
            intermediaryToCheck.addError(System.Label.User_Delete_Access_Error_Msg);
        }
    }    
}