<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Change_Account_Owner_to_System_Admin</fullName>
        <field>OwnerId</field>
        <lookupValue>wasim.akhtar@cabinetoffice.gov.uk.admin</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>Change Account Owner to System Admin</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Sharing_RW_For_Org_Shr_Type</fullName>
        <description>Update sharing rule read and write for all the new accounts created</description>
        <field>Type</field>
        <literalValue>Shared Read/Write</literalValue>
        <name>Update Sharing RW For Org Shr Type</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Change Account Owner created via Portal</fullName>
        <actions>
            <name>Change_Account_Owner_to_System_Admin</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>User.UserType</field>
            <operation>equals</operation>
            <value>Partner,Customer Portal Manager,Customer Portal User,Guest,Self Service</value>
        </criteriaItems>
        <description>GEPDS-671 - Only Salesforce admins should own Account records.</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>New Organisation Created</fullName>
        <actions>
            <name>Update_Sharing_RW_For_Org_Shr_Type</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>NOT($Setup.Bypass__c.Workflow_Rules__c)</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
