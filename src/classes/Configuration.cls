<<<<<<< HEAD
/******************************************************************************************
@Author         Hamed Izadpanah
@Date           28/09/2015
@Project        Cloud Sherpas Cabinet Office Data Source
@Description    This is a utility/helper class to manager all the system configuration logic
*******************************************************************************************/
public with sharing class Configuration {
    /**
     * Determines whether triggers should not be executed within current
     * session.
     *
     * Note: For security reasons business users are not allowed to have
     * triggers off, unless it's explicitly set from code.
     */
    public static Boolean areTriggersOff() {
        Bypass__c bypassInstance = Bypass__c.getInstance(UserInfo.getUserId());
        return bypassInstance != null && bypassInstance.Triggers__c;
    }
    
   /**
     * Switches validations on (true) or off (false).
     */
    public static void turnBypassTriggersPermanently(Boolean value) {
        Bypass__c bypassInstance = Bypass__c.getValues(UserInfo.getUserId());
        if(bypassInstance == null || String.isBlank(bypassInstance.Id)) {
            insert new Bypass__c(
                SetupOwnerId = UserInfo.getUserId(),
                Triggers__c = value
            );
            return;
        }
        bypassInstance.Triggers__c = value;
        update bypassInstance;
    }
    
    /**
     * Determines if system should allow to save invalid data.
     */
    public static Boolean areValidationsOff() {
        Bypass__c bypassInstance = Bypass__c.getInstance(UserInfo.getUserId());
        return bypassInstance != null && bypassInstance.Validation_Rules__c;
    }

    /**
     * Switches validations on (true) or off (false).
     */
    public static void turnBypassValidationsPermanently(Boolean value) {
        Bypass__c bypassInstance = Bypass__c.getValues(UserInfo.getUserId());
        if(bypassInstance == null || String.isBlank(bypassInstance.Id)) {
            insert new Bypass__c(
                SetupOwnerId = UserInfo.getUserId(),
                Validation_Rules__c = value
            );
            return;
        }
        bypassInstance.Validation_Rules__c = value;
        update bypassInstance;
    }

=======
<<<<<<< HEAD
/******************************************************************************************
@Author         Hamed Izadpanah
@Date           28/09/2015
@Project        Cloud Sherpas Cabinet Office Data Source
@Description    This is a utility/helper class to manager all the system configuration logic
*******************************************************************************************/
public with sharing class Configuration {
    /**
     * Determines whether triggers should not be executed within current
     * session.
     *
     * Note: For security reasons business users are not allowed to have
     * triggers off, unless it's explicitly set from code.
     */
    public static Boolean areTriggersOff() {
        Bypass__c bypassInstance = Bypass__c.getInstance(UserInfo.getUserId());
        return bypassInstance != null && bypassInstance.Triggers__c;
    }
    
   /**
     * Switches validations on (true) or off (false).
     */
    public static void turnBypassTriggersPermanently(Boolean value) {
        Bypass__c bypassInstance = Bypass__c.getValues(UserInfo.getUserId());
        if(bypassInstance == null || String.isBlank(bypassInstance.Id)) {
            insert new Bypass__c(
                SetupOwnerId = UserInfo.getUserId(),
                Triggers__c = value
            );
            return;
        }
        bypassInstance.Triggers__c = value;
        update bypassInstance;
    }
    
    /**
     * Determines if system should allow to save invalid data.
     */
    public static Boolean areValidationsOff() {
        Bypass__c bypassInstance = Bypass__c.getInstance(UserInfo.getUserId());
        return bypassInstance != null && bypassInstance.Validation_Rules__c;
    }

    /**
     * Switches validations on (true) or off (false).
     */
    public static void turnBypassValidationsPermanently(Boolean value) {
        Bypass__c bypassInstance = Bypass__c.getValues(UserInfo.getUserId());
        if(bypassInstance == null || String.isBlank(bypassInstance.Id)) {
            insert new Bypass__c(
                SetupOwnerId = UserInfo.getUserId(),
                Validation_Rules__c = value
            );
            return;
        }
        bypassInstance.Validation_Rules__c = value;
        update bypassInstance;
    }

=======
<<<<<<< HEAD
/******************************************************************************************
@Author         Hamed Izadpanah
@Date           28/09/2015
@Project        Cloud Sherpas Cabinet Office Data Source
@Description    This is a utility/helper class to manager all the system configuration logic
*******************************************************************************************/
public with sharing class Configuration {
    /**
     * Determines whether triggers should not be executed within current
     * session.
     *
     * Note: For security reasons business users are not allowed to have
     * triggers off, unless it's explicitly set from code.
     */
    public static Boolean areTriggersOff() {
        Bypass__c bypassInstance = Bypass__c.getInstance(UserInfo.getUserId());
        return bypassInstance != null && bypassInstance.Triggers__c;
    }
    
   /**
     * Switches validations on (true) or off (false).
     */
    public static void turnBypassTriggersPermanently(Boolean value) {
        Bypass__c bypassInstance = Bypass__c.getValues(UserInfo.getUserId());
        if(bypassInstance == null || String.isBlank(bypassInstance.Id)) {
            insert new Bypass__c(
                SetupOwnerId = UserInfo.getUserId(),
                Triggers__c = value
            );
            return;
        }
        bypassInstance.Triggers__c = value;
        update bypassInstance;
    }
    
    /**
     * Determines if system should allow to save invalid data.
     */
    public static Boolean areValidationsOff() {
        Bypass__c bypassInstance = Bypass__c.getInstance(UserInfo.getUserId());
        return bypassInstance != null && bypassInstance.Validation_Rules__c;
    }

    /**
     * Switches validations on (true) or off (false).
     */
    public static void turnBypassValidationsPermanently(Boolean value) {
        Bypass__c bypassInstance = Bypass__c.getValues(UserInfo.getUserId());
        if(bypassInstance == null || String.isBlank(bypassInstance.Id)) {
            insert new Bypass__c(
                SetupOwnerId = UserInfo.getUserId(),
                Validation_Rules__c = value
            );
            return;
        }
        bypassInstance.Validation_Rules__c = value;
        update bypassInstance;
    }

=======
<<<<<<< HEAD
/******************************************************************************************
@Author         Hamed Izadpanah
@Date           28/09/2015
@Project        Cloud Sherpas Cabinet Office Data Source
@Description    This is a utility/helper class to manager all the system configuration logic
*******************************************************************************************/
public with sharing class Configuration {
    /**
     * Determines whether triggers should not be executed within current
     * session.
     *
     * Note: For security reasons business users are not allowed to have
     * triggers off, unless it's explicitly set from code.
     */
    public static Boolean areTriggersOff() {
        Bypass__c bypassInstance = Bypass__c.getInstance(UserInfo.getUserId());
        return bypassInstance != null && bypassInstance.Triggers__c;
    }
    
   /**
     * Switches validations on (true) or off (false).
     */
    public static void turnBypassTriggersPermanently(Boolean value) {
        Bypass__c bypassInstance = Bypass__c.getValues(UserInfo.getUserId());
        if(bypassInstance == null || String.isBlank(bypassInstance.Id)) {
            insert new Bypass__c(
                SetupOwnerId = UserInfo.getUserId(),
                Triggers__c = value
            );
            return;
        }
        bypassInstance.Triggers__c = value;
        update bypassInstance;
    }
    
    /**
     * Determines if system should allow to save invalid data.
     */
    public static Boolean areValidationsOff() {
        Bypass__c bypassInstance = Bypass__c.getInstance(UserInfo.getUserId());
        return bypassInstance != null && bypassInstance.Validation_Rules__c;
    }

    /**
     * Switches validations on (true) or off (false).
     */
    public static void turnBypassValidationsPermanently(Boolean value) {
        Bypass__c bypassInstance = Bypass__c.getValues(UserInfo.getUserId());
        if(bypassInstance == null || String.isBlank(bypassInstance.Id)) {
            insert new Bypass__c(
                SetupOwnerId = UserInfo.getUserId(),
                Validation_Rules__c = value
            );
            return;
        }
        bypassInstance.Validation_Rules__c = value;
        update bypassInstance;
    }

=======
/******************************************************************************************
@Author         Hamed Izadpanah
@Date           28/09/2015
@Project        Cloud Sherpas Cabinet Office Data Source
@Description    This is a utility/helper class to manager all the system configuration logic
*******************************************************************************************/
public with sharing class Configuration {
    /**
     * Determines whether triggers should not be executed within current
     * session.
     *
     * Note: For security reasons business users are not allowed to have
     * triggers off, unless it's explicitly set from code.
     */
    public static Boolean areTriggersOff() {
        Bypass__c bypassInstance = Bypass__c.getInstance(UserInfo.getUserId());
        return bypassInstance != null && bypassInstance.Triggers__c;
    }
    
   /**
     * Switches validations on (true) or off (false).
     */
    public static void turnBypassTriggersPermanently(Boolean value) {
        Bypass__c bypassInstance = Bypass__c.getValues(UserInfo.getUserId());
        if(bypassInstance == null || String.isBlank(bypassInstance.Id)) {
            insert new Bypass__c(
                SetupOwnerId = UserInfo.getUserId(),
                Triggers__c = value
            );
            return;
        }
        bypassInstance.Triggers__c = value;
        update bypassInstance;
    }
    
    /**
     * Determines if system should allow to save invalid data.
     */
    public static Boolean areValidationsOff() {
        Bypass__c bypassInstance = Bypass__c.getInstance(UserInfo.getUserId());
        return bypassInstance != null && bypassInstance.Validation_Rules__c;
    }

    /**
     * Switches validations on (true) or off (false).
     */
    public static void turnBypassValidationsPermanently(Boolean value) {
        Bypass__c bypassInstance = Bypass__c.getValues(UserInfo.getUserId());
        if(bypassInstance == null || String.isBlank(bypassInstance.Id)) {
            insert new Bypass__c(
                SetupOwnerId = UserInfo.getUserId(),
                Validation_Rules__c = value
            );
            return;
        }
        bypassInstance.Validation_Rules__c = value;
        update bypassInstance;
    }

>>>>>>> refs/remotes/origin/master
>>>>>>> branch 'master' of https://github.com/cabinetoffice/Government-Grants-Information-System-Metadata
>>>>>>> branch 'master' of https://github.com/cabinetoffice/Government-Grants-Information-System-Metadata
>>>>>>> branch 'master' of https://github.com/cabinetoffice/Government-Grants-Information-System-Metadata
}