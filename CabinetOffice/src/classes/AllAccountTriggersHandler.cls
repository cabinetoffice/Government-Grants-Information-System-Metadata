/******************************************************************************************
@Author         Hamed Izadpanah
@Date           28/09/2015
@Project        Cloud Sherpas Cabinet Office Data Source
@Description    Main entry for all the trigger events on Account object
*******************************************************************************************/
public without sharing class AllAccountTriggersHandler {

	public static void handleBeforeDelete(Map<Id, Account> oldMap){
		Map<Id, Account> queriedAccounts = new Map<Id, Account>([
			SELECT Id, Owner.UserRoleId
			FROM Account
			WHERE Id IN :oldMap.keySet()
		]);
		for(Account accountToCheck : oldMap.values()){
			Account queriedAccount = queriedAccounts.get(accountToCheck.Id);
			checkUserDepartment(queriedAccount, accountToCheck);
		}
		checkChildAccountRecords(oldMap);
		checkRelatedRecords(oldMap);
	}

	private static void checkChildAccountRecords(Map<Id, Account> oldMap) {
		Map<Id, AggregateResult> childAccountCountMap = new Map<Id, AggregateResult>([
			SELECT ParentId Id, COUNT(Id) childCount
			FROM Account 
			WHERE ParentId IN : oldMap.keySet()
			GROUP BY ParentId]);
		
		for (Account organisationToCheck : oldMap.values()) {
			Integer orgChildCount = childAccountCountMap.containsKey(organisationToCheck.Id) ? (Integer) childAccountCountMap.get(organisationToCheck.Id).get('childCount') : 0;

			if (orgChildCount > 0) {
				organisationToCheck.addError(System.Label.Organisation_Has_Child_Delete_Error_Message);
			}
		}

	}

	private static void checkRelatedRecords(Map<Id, Account> oldMap){
		Map<Id, AggregateResult> relatedSchemesCountMap = new Map<Id, AggregateResult>([
			SELECT Funder__c Id, COUNT(Id) schemesCount 
			FROM Grant_Scheme__C 
			WHERE Funder__c IN :oldMap.keySet() 
			GROUP BY Funder__c
		]);
		Map<Id, AggregateResult> relatedAwardsCountMap = new Map<Id, AggregateResult>([
			SELECT Recipient__c Id, COUNT(Id) awardsCount 
			FROM Grant_Award__C 
			WHERE Recipient__c IN :oldMap.keySet() 
			GROUP BY Recipient__c
		]);
		Map<Id, AggregateResult> relatedIntermediariesCountMap = new Map<Id, AggregateResult>([
			SELECT Intermediary_Organisation__c Id, COUNT(Id) intermediariesCount 
			FROM Intermediary__c 
			WHERE Intermediary_Organisation__c IN :oldMap.keySet() 
			GROUP BY Intermediary_Organisation__c
		]);
		for(Account organisationToCheck : oldMap.values()){
			Integer relatedSchemesCount = relatedSchemesCountMap.containsKey(organisationToCheck.Id) ? (Integer) relatedSchemesCountMap.get(organisationToCheck.Id).get('schemesCount') : 0;
			Integer relatedAwardsCount = relatedAwardsCountMap.containsKey(organisationToCheck.Id) ? (Integer) relatedAwardsCountMap.get(organisationToCheck.Id).get('awardsCount') : 0;
			Integer relatedIntermediariesCount = relatedIntermediariesCountMap.containsKey(organisationToCheck.Id) ? (Integer) relatedIntermediariesCountMap.get(organisationToCheck.Id).get('intermediariesCount') : 0;
			if(relatedSchemesCount > 0 || relatedAwardsCount > 0 || relatedIntermediariesCount > 0){
				organisationToCheck.addError(System.Label.Organisation_Related_Grants_Delete_Error_Message);
			}
		}
	}

	private static void checkUserDepartment(Account queriedAccount, Account accountToCheck){
		Boolean isRunningUserRoleDifferentFromOwnerUserRole = UserInfo.getUserType() == Constant.USER_TYPE_COMMUNITY_PLUS && UserInfo.getUserRoleId() != queriedAccount.Owner.UserRoleId;
		if(isRunningUserRoleDifferentFromOwnerUserRole){
			accountToCheck.addError(System.Label.User_Delete_Access_Error_Msg);
		}
	}
}