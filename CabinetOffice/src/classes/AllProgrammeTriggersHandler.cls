/******************************************************************************************
@Author         Divino Brinas
@Date           09/24/2015
@Project        Cloud Sherpas Cabinet Office Data Source
@Description    Main entry for all the trigger events on Programme__c object
*******************************************************************************************/
public without sharing class AllProgrammeTriggersHandler {
    public static void handleBeforeDelete(Map<Id, Programme__c> oldMap){
        Map<Id, Programme__c> queriedProgrammes = new Map<Id, Programme__c>([
            SELECT Id, Owner.UserRoleId, Portal_User_Cannot_Delete_This_Record__c
            FROM Programme__c
            WHERE Id IN :oldMap.keySet()
        ]);
        for(Programme__c programmeToCheck : oldMap.values()){
            Programme__c queriedProgramme = new Programme__c();
            queriedProgramme = queriedProgrammes.get(programmeToCheck.id);
            checkUserDepartment(queriedProgramme, programmeToCheck);
            if (queriedProgramme.Portal_User_Cannot_Delete_This_Record__c){
                programmeToCheck.addError(System.Label.Grant_Programme_Delete_Validation_Error_Message);
            }
        }
    }
    private static void checkUserDepartment(Programme__c queriedProgamme, Programme__c programmedToCheck){
        Boolean isRunningUserRoleDifferentFromOwnerUserRole = UserInfo.getUserType() == Constant.USER_TYPE_COMMUNITY_PLUS && UserInfo.getUserRoleId() != queriedProgamme.Owner.UserRoleId;
        if(isRunningUserRoleDifferentFromOwnerUserRole){
            programmedToCheck.addError(System.Label.User_Delete_Access_Error_Msg);
        }
    }
}