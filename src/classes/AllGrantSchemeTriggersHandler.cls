/******************************************************************************************
@Author         Divino Brinas
@Date           09/24/2015
@Project        Cloud Sherpas Cabinet Office Data Source
@Description    Main entry for all the trigger events on Grant_Scheme__c object
*******************************************************************************************/
public without sharing class AllGrantSchemeTriggersHandler {
    public static void handleBeforeDelete(Map<Id, Grant_Scheme__c> oldMap) {
<<<<<<< HEAD
        User u = [SELECT Profile.NAME FROM User WHERE ID = :UserInfo.getUserID()]; 
        If(u.profile.NAME != 'System Administrator'){
            Map<Id, Grant_Scheme__c> queriedGrantSchemes = new Map<Id, Grant_Scheme__c>([
                        SELECT Id, Owner.UserRoleId, Portal_User_Cannot_Delete_This_Record__c
                        FROM Grant_Scheme__c
                        WHERE Id IN :oldMap.keySet()
                    ]);
            for (Grant_Scheme__c grantSchemeToCheck : oldMap.values()) {
                Grant_Scheme__c queriedGrantScheme = new Grant_Scheme__c();
                queriedGrantScheme = queriedGrantSchemes.get(grantSchemeToCheck.id);
                checkUserDepartment(queriedGrantScheme, grantSchemeToCheck);
                if (queriedGrantScheme.Portal_User_Cannot_Delete_This_Record__c) {
                    grantSchemeToCheck.addError(System.Label.Grant_Scheme_Delete_Validation_Error_Message);
                }
            }
        }
    }
    public static void handleBeforeInsert(List<Grant_Scheme__c> lstTrigNew){
        FYcal.FinancialYear(lstTrigNew);
    }
    public static void handleBeforeUpdate(List<Grant_Scheme__c> lstTrigNew){
        FYcal.FinancialYear(lstTrigNew);
    }
    private static void checkUserDepartment(Grant_Scheme__c queriedGrantScheme, Grant_Scheme__c grantSchemeToCheck) {
        Boolean isRunningUserRoleDifferentFromOwnerUserRole = /** UserInfo.getUserType() == Constant.USER_TYPE_COMMUNITY_PLUS **/UserInfo.getUserRoleId() != queriedGrantScheme.Owner.UserRoleId;
=======
<<<<<<< HEAD
        User u = [SELECT Profile.NAME FROM User WHERE ID = :UserInfo.getUserID()]; 
        If(u.profile.NAME != 'System Administrator'){
            Map<Id, Grant_Scheme__c> queriedGrantSchemes = new Map<Id, Grant_Scheme__c>([
                        SELECT Id, Owner.UserRoleId, Portal_User_Cannot_Delete_This_Record__c
                        FROM Grant_Scheme__c
                        WHERE Id IN :oldMap.keySet()
                    ]);
            for (Grant_Scheme__c grantSchemeToCheck : oldMap.values()) {
                Grant_Scheme__c queriedGrantScheme = new Grant_Scheme__c();
                queriedGrantScheme = queriedGrantSchemes.get(grantSchemeToCheck.id);
                checkUserDepartment(queriedGrantScheme, grantSchemeToCheck);
                if (queriedGrantScheme.Portal_User_Cannot_Delete_This_Record__c) {
                    grantSchemeToCheck.addError(System.Label.Grant_Scheme_Delete_Validation_Error_Message);
                }
            }
        }
    }
    public static void handleBeforeInsert(List<Grant_Scheme__c> lstTrigNew){
        FYcal.FinancialYear(lstTrigNew);
    }
    public static void handleBeforeUpdate(List<Grant_Scheme__c> lstTrigNew){
        FYcal.FinancialYear(lstTrigNew);
    }
    private static void checkUserDepartment(Grant_Scheme__c queriedGrantScheme, Grant_Scheme__c grantSchemeToCheck) {
        Boolean isRunningUserRoleDifferentFromOwnerUserRole = /** UserInfo.getUserType() == Constant.USER_TYPE_COMMUNITY_PLUS **/UserInfo.getUserRoleId() != queriedGrantScheme.Owner.UserRoleId;
=======
        Map<Id, Grant_Scheme__c> queriedGrantSchemes = new Map<Id, Grant_Scheme__c>([
                    SELECT Id, Owner.UserRoleId, Portal_User_Cannot_Delete_This_Record__c
                    FROM Grant_Scheme__c
                    WHERE Id IN :oldMap.keySet()
                ]);
        for (Grant_Scheme__c grantSchemeToCheck : oldMap.values()) {
            Grant_Scheme__c queriedGrantScheme = new Grant_Scheme__c();
            queriedGrantScheme = queriedGrantSchemes.get(grantSchemeToCheck.id);
            checkUserDepartment(queriedGrantScheme, grantSchemeToCheck);
            if (queriedGrantScheme.Portal_User_Cannot_Delete_This_Record__c) {
                grantSchemeToCheck.addError(System.Label.Grant_Scheme_Delete_Validation_Error_Message);
            }
        }
    }
    public static void handleBeforeInsert(List<Grant_Scheme__c> lstTrigNew){
        FYcal.FinancialYear(lstTrigNew);
    }
    public static void handleBeforeUpdate(List<Grant_Scheme__c> lstTrigNew){
        FYcal.FinancialYear(lstTrigNew);
    }
    private static void checkUserDepartment(Grant_Scheme__c queriedGrantScheme, Grant_Scheme__c grantSchemeToCheck) {
        Boolean isRunningUserRoleDifferentFromOwnerUserRole = UserInfo.getUserType() == Constant.USER_TYPE_COMMUNITY_PLUS && UserInfo.getUserRoleId() != queriedGrantScheme.Owner.UserRoleId;
>>>>>>> refs/remotes/origin/master
>>>>>>> branch 'master' of https://github.com/cabinetoffice/Government-Grants-Information-System-Metadata
        if (isRunningUserRoleDifferentFromOwnerUserRole) {
            grantSchemeToCheck.addError(System.Label.User_Delete_Access_Error_Msg);
        }
    }
}