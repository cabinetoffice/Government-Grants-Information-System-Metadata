<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Email_all_users_with_System_Admin_profile</fullName>
        <ccEmails>grantshubsupport@cabinetoffice.gov.uk</ccEmails>
        <description>Email all users with System Admin profile</description>
        <protected>false</protected>
        <senderAddress>grantshubsupport@cabinetoffice.gov.uk</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/CommunityUserAccessRequestEmailTemplate</template>
    </alerts>
    <alerts>
        <fullName>Email_requesting_Contact_for_Community_Access</fullName>
        <description>Email requesting Contact for Community Access</description>
        <protected>false</protected>
        <recipients>
            <field>Email</field>
            <type>email</type>
        </recipients>
        <senderAddress>grantshubsupport@cabinetoffice.gov.uk</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/CommunityNewUserRequestNotifcationEmailTemplate</template>
    </alerts>
    <rules>
        <fullName>New User Contact Rule</fullName>
        <actions>
            <name>Email_all_users_with_System_Admin_profile</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Email_requesting_Contact_for_Community_Access</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <formula>AND(  NOT( $Setup.Bypass__c.Workflow_Rules__c )  , NOT(ISPICKVAL( $User.User_Type__c, &apos;System User&apos;)) )</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
