/******************************************************************************************
@Author         Hamed Izadpanah
@Date           22/01/2016
@Project        Cloud Sherpas - GGIS Beta
@Description    Main entry for all the trigger events on Proposed Grant object
*******************************************************************************************/
public without sharing class AllProposedGrantTriggersHandler {
    public static void handleBeforeDelete(Map<Id, Proposed_Grant__c> oldMap){
        Map<Id, Proposed_Grant__c> queriedProposedGrants = new Map<Id, Proposed_Grant__c>([
            SELECT Id, Owner.UserRoleId
            FROM Proposed_Grant__c
            WHERE Id IN :oldMap.keySet()
        ]);
        for(Proposed_Grant__c proposedGranmtToCheck : oldMap.values()){
            Proposed_Grant__c queriedProposedGranmt = new Proposed_Grant__c();
            queriedProposedGranmt = queriedProposedGrants.get(proposedGranmtToCheck.id);
            checkUserDepartment(queriedProposedGranmt, proposedGranmtToCheck);
        }
    }
    private static void checkUserDepartment(Proposed_Grant__c queriedProposedGrant, Proposed_Grant__c proposedGranmtdToCheck){
        Boolean isRunningUserRoleDifferentFromOwnerUserRole = UserInfo.getUserType() == Constant.USER_TYPE_COMMUNITY_PLUS && UserInfo.getUserRoleId() != queriedProposedGrant.Owner.UserRoleId;
        if(isRunningUserRoleDifferentFromOwnerUserRole){
            proposedGranmtdToCheck.addError(System.Label.User_Delete_Access_Error_Msg);
        }
    }
}