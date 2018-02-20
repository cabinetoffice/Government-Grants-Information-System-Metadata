/******************************************************************************************
@Author         Hamed Izadpanah
@Date           28/09/2015
@Project        Cloud Sherpas Cabinet Office Data Source
@Description    This is the generic constant class which holds all the constant values
*******************************************************************************************/
public abstract class Constant {

    // SObject types
    public static final String SOBJECT_TYPE_ACCOUNT = 'Account';
    public static final String SOBJECT_TYPE_GRANT_AWARD = 'Grant_Award__c';
    public static final String SOBJECT_TYPE_GRANT_SCHEME = 'Grant_Scheme__c';
    public static final String SOBJECT_TYPE_INTERMEDIARY = 'Intermediary__c';
    public static final String SOBJECT_TYPE_PROGRAMME = 'Programme__c';

    // String value parsers
    public static final String STRING_VALUE_PARSER_DATE = 'StringValueParser.StringToDate';
    public static final String STRING_VALUE_PARSER_DECIMAL = 'StringValueParser.StringToDecimal';
    public static final String STRING_VALUE_PARSER_PICKLIST = 'StringValueParser.StringToPicklistValues';
    public static final String STRING_VALUE_PARSER_BOOLEAN = 'StringValueParser.StringToBoolean';

    // Account External Id field api names
    public static final String ACC_EXT_ID_VAT_REG_NO_MAP = 'VAT Reg no';

    // Community Portal roles
    public static final String PORTAL_ROLE_MANAGER = 'Manager';

    // Account sharing access types
    public static final String ACCOUNT_SHARE_ACCESS_READ_WRITE = 'Edit';
    public static final String ACCOUNT_SHARE_ROWCAUSE_MANUAL = 'Manual';

    // Grant Awards Record Type Names
    public static final String GRANT_AWARD_INDIVIDUAL_RT_NAME = 'Individual Award';
    public static final String GRANT_AWARD_ORGANISATION_RT_NAME = 'Organisation Award';

    // CSV Upload records types
    public static final String CSV_UPLOAD_GRANT_AWARD_RT_NAME = 'Grant Award';
    // CSV Upload Types
    public static final String CSV_UPLOAD_CREATE_AWARD_TYPE = 'Create Awards';
    public static final String CSV_UPLOAD_AMEND_AWARD_TYPE = 'Amend Awards';
    public static final String CSV_UPLOAD_AWARD_EVALUATION_TYPE = 'Upload Award Evaluation';
    public static final String CSV_UPLOAD_AWARD_PAYMENT_TYPE = 'Upload Payments';

    // SObject creator types
    public static final String CSV_SOBJECT_CREATOR_GRANT_AWARD = 'CSVUploadSObjectFactory.GrantAwardCreator';
    public static final String CSV_SOBJECT_AMEND_GRANT_AWARD = 'CSVUploadSObjectFactory.GrantAwardUpdater';
    public static final String CSV_SOBJECT_CREATOR_GRANT_AWARD_RECEPIENT = 'CSVUploadSObjectFactory.RecepientCreator';
    public static final String CSV_SOBJECT_CREATOR_GRANT_AWARD_INTERMEDIARY = 'CSVUploadSObjectFactory.IntermediaryCreator';
    public static final String CSV_SOBJECT_CREATOR_GRANT_AWARD_INTERMEDIARY_ORGANISATION = 'CSVUploadSObjectFactory.IntermediaryOrganisationCreator';

    // CSV Upload Process Status
    public static final String CSV_UPLOAD_PT_VALIDATED = 'Validated';
    public static final String CSV_UPLOAD_PT_QUEUED = 'Queued';
    public static final String CSV_UPLOAD_PT_STARTED = 'Started';
    public static final String CSV_UPLOAD_PT_IN_PROGRESS = 'In Progress';
    public static final String CSV_UPLOAD_PT_FINISHED = 'Finished';

    //CSV Email Attachments - File Names
    public static final String CSV_ATTACH_NAME_GRANTAWARDS = 'Deleted Grant Awards_' + Date.today() + '_' + System.now() + '.csv';
    public static final String CSV_ATTACH_NAME_GRANTSCHEMES = 'Deleted Grant Schemes_' + Date.today() + '_' + System.now() + '.csv';
    public static final String CSV_ATTACH_NAME_PROGRAMMES = 'Deleted Programmes_' + Date.today() + '_' + System.now() + '.csv';

    // Organisation types
    public static final String ORGANISATION_TYPE_RECEPIENT = 'Recipient';
    public static final String ORGANISATION_TYPE_INTERMEDIARY = 'Intermediary';

    // Query input templates
    public static final String QUERY_INPUT_FIELD_TEMPLATE = '__INPUT_FIELD__';
    public static final String QUERY_INPUT_VALUE_TEMPLATE = '__INPUT_VALUE__';

    // Profile names
    public static final String PROFILE_COMMUNITY_SUPER_USER = 'Data Solution Portal - Super User';

    // Salesforce User Types
    public static final String USER_TYPE_COMMUNITY_PLUS = 'PowerCustomerSuccess';

    // Error message templates
    public static final String ERR_MSG_TEMP_REQ_FIELDS_MISSING = '__REQUIRED_FIELDS_LABELS__';

    // Grant Award Allocation Methods
    public static final String GA_ALLOC_MTHD_COMPETED = 'Competed';

    // CSV Mapping
    public final static String GRANT_SCHEME_AND_SYSTEM_REFERENCE_LABEL = Label.CSV_Upload_Grant_Scheme_Id_Column;

    // Grant Recipient Type
    public static final String GRT_ORGANISATION = 'Organisation';
    public static final String GRT_INIDIVIDUAL = 'Individual';

    // Grant Award 'Payment Frequency' picklist values
    public static final String INSTALMENT_PAYMENTS = 'Instalment payments';
    public static final String UPFRONT_PAYMENT = 'Upfront payments';
    public static final String END_PAYMENT = 'End payments';
    public static final String ADHOC_PAYMENT = 'Ad-hoc payments';

    // Grant Award 'If instalment Payments' field
    public static final String MONTHLY = 'monthly';
    public static final String YEARLY = 'yearly';
    public static final String QUARTERLY = 'quarterly';

    //Grant Award 'Is Grant Monitored' picklist values
    public static final String GRANT_MONITORED_YES = 'Yes';

    // Error message for empty username in forgot password page
    public static final String FORGOT_PASSWORD_ERROR = 'You must enter a username';

    //Profile Names
    public static final String PROFILE_SYSADMIN = 'System Administrator';
}