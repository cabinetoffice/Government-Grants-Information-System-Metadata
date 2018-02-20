/******************************************************************************************
@Author         Ric Dayrit
@Date           07/03/2016
@Project        Cloud Sherpas Cabinet Office Data Source
@Description    This page allows users to see an overview of the Grant Scheme before deleting it
*******************************************************************************************/
public without sharing class GrantSchemeConfirmDeleteController {

    private final ApexPages.StandardController stndController;

    public GrantSchemeConfirmDeleteController(ApexPages.StandardController stndController) {
        this.stndController = stndController;
    }

    public PageReference deleteAll() {
        PageReference returnPage = null;
        try {
            Map<Id, SObject> schemeToDel = new Map<Id, SObject>();
            schemeToDel.put(stndController.getId(), stndController.getRecord());
            NotifyGrantDeletions notify = new NotifyGrantDeletions();
            notify.notifyGrantHubSupport(schemeToDel);
            delete stndController.getRecord();
            returnPage = stndController.cancel();
        } catch (DmlException exceptionToHandle) {
            ApexPages.addMessages(exceptionToHandle);
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
            return null;
        } catch (EmailException emailExceptionHandle) {
            ApexPages.addMessages(emailExceptionHandle);
            return null;
>>>>>>> refs/remotes/origin/master
>>>>>>> branch 'master' of https://github.com/cabinetoffice/Government-Grants-Information-System-Metadata
        }
        return returnPage;
    }

    //GEPDS-867 - 12 Apr 2016
    /**
     * method to determine if the current superuser is linked to any of given funders
     * @author  Bhushan Sukumar
     * @date    12 Apr 2016
     * @param   funderIds  set of account ids
     * @return             boolean result
     */
    public boolean isSuperUserlinkedToFunder(Set<Id> funderIds) {
        //defaulting result to false
        boolean retVal = false;
        try {
            //Querying current user's contactId and checking if the contact is linked to any of
            //the given funders
            User currentUser = [SELECT Id,
                                ContactId
                                FROM User
                                WHERE Id = : UserInfo.getUserId()];
            List<Contact> userContacts = [SELECT Id
                                          FROM Contact
                                          WHERE Id = : currentUser.contactId
                                                  AND AccountId IN: funderIds];
            if (!userContacts.isEmpty()) {
                retVal = true;
            }
            return retVal;
        } catch (Exception e) {
            ApexPages.addMessages(e); //showing error to user
            return retVal;
        }
    }

    //GEPDS-867 - 12 Apr 2016
    /**
     * page property to render the 'Delete' button on the page
     * @author  Bhushan Sukumar
     * @date    12 Apr 2016
     * @return  boolean result
     */
    public boolean getShowDeleteButton() {
        //defaulting result to false
        boolean retVal = false;
        try {
            //retrieving the related funder and its parent's id (if any)
            Grant_Scheme__c scheme = [SELECT Id,
                                      Portal_User_Cannot_Delete_This_Record__c,
                                      Funder__c,
                                      Funder__r.ParentId
                                      FROM Grant_Scheme__c
                                      WHERE Id = : stndController.getId()];
            //adding the funder ids to a set
            Set<Id> funderIds = new Set<Id>();
            funderIds.add(scheme.Funder__c);
            if (!String.isBlank(scheme.Funder__r.ParentId))
                funderIds.add(scheme.Funder__r.ParentId);
            // If the current user is superuser, then check if they are related to the funder,
            // if not deletion should not be allowed
            if 	(!scheme.Portal_User_Cannot_Delete_This_Record__c &&
                    UserInfo.getUserType() == Constant.USER_TYPE_COMMUNITY_PLUS
                    && isSuperUserlinkedToFunder(funderIds)) {
                retVal = true;
            } else { // if the current user is admin, then deletion should be allowed
                Profile admProfile = [SELECT Id FROM Profile WHERE Name = : Constant.PROFILE_SYSADMIN];
                if (UserInfo.getProfileId() == admProfile.Id) {
                    retval = true;
                }
            }
        } catch (Exception e) {
            ApexPages.addMessages(e); //showing error to user
        }
        return retVal;
    }

    public Integer getCountOfRelatedGrantAwards() {
        return [
                   SELECT COUNT()
                   FROM Grant_Award__c
                   WHERE Grant_Scheme__c = :stndController.getId()
               ];
    }
}