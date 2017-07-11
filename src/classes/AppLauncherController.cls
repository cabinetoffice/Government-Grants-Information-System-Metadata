public with sharing class AppLauncherController {
	
 	public Boolean getShowGCOE() {
 		Id profileId = UserInfo.getProfileId();
		String profileName = [SELECT Id, Name FROM Profile WHERE Id =: profileId].Name;

		if (Constant.PROFILE_COMMUNITY_SUPER_USER.equalsIgnoreCase(profileName)) {
			return false;
		} else {
			return true;	
		}
 		
 	}
}