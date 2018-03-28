<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Uncheck_Has_Postal_Code_Been_Checked</fullName>
        <description>This field update makes sure that Is Postal code Validate checkbox has been unchecked.</description>
        <field>Has_Postal_Code_Been_Checked__c</field>
        <literalValue>0</literalValue>
        <name>Uncheck Has Postal Code Been Checked</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Uncheck_Is_Postal_Code_Valid</fullName>
        <description>This checkbox makes sure that postal code is valid has been unchecked.</description>
        <field>Is_Postal_Code_Valid__c</field>
        <literalValue>0</literalValue>
        <name>Uncheck Is Postal Code Valid</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Evaluation_Modified_Date</fullName>
        <field>Evaluation_Modified_Date_by_Portal_User__c</field>
        <formula>IF ((TODAY() - Award_End_Date__c) &gt; 365
  , NOW()
  , DATETIMEVALUE(Award_End_Date__c + 365)
)</formula>
        <name>Update Evaluation Modified Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Flag_Last_Modified_By</fullName>
        <field>Potential_issue_with_delivery_update_by__c</field>
        <formula>LastModifiedBy.FirstName &amp; &apos; &apos; &amp;  LastModifiedBy.LastName &amp; &apos;, &apos; &amp; TEXT ( LastModifiedDate )</formula>
        <name>Update Flag Last Modified By</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Recipient_Name</fullName>
        <field>Recipient_Name_at_Award_Creation__c</field>
        <formula>Recipient__r.Name</formula>
        <name>Update Recipient Name</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Total_Amount_in_funding_agreement</fullName>
        <field>Total_Amount_in_funding_agreement__c</field>
        <formula>Total_Value_Budgeted_in_GBP__c</formula>
        <name>Update Total Amount in funding agreement</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>Amount transfer from Individual to Organisational field</fullName>
        <actions>
            <name>Update_Total_Amount_in_funding_agreement</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Grant_Award__c.Total_Value_Budgeted_in_GBP__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Grant_Award__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Individual Award</value>
        </criteriaItems>
        <description>All reports are based on Total Amount in Funding agreement in GB field, but for Individual record type Total Value Budgeted in GBP field is used, workflow to transfer data from Individual field to Organisational field on record Create/Edit</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Grant Award Evaluation fields have been Modified</fullName>
        <actions>
            <name>Update_Evaluation_Modified_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(ISPICKVAL($Profile.UserType, &apos;PowerCustomerSuccess&apos;)   , OR(     AND(ISCHANGED(Award_End_Date__c)      , ISBLANK(Evaluation_Modified_Date_by_Portal_User__c)      , ISCHANGED(Award_Objectives_Achieved__c)       , ISCHANGED(Reason_for_Given_Answer__c))     , AND(ISCHANGED(Award_End_Date__c)      , NOT(ISBLANK(Evaluation_Modified_Date_by_Portal_User__c)))     , AND(NOT(ISCHANGED(Award_End_Date__c))      , ISBLANK(Evaluation_Modified_Date_by_Portal_User__c)      , ISCHANGED(Award_Objectives_Achieved__c)       , ISCHANGED(Reason_for_Given_Answer__c))   ) )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Grant Award Postal Code Has Changed</fullName>
        <actions>
            <name>Uncheck_Has_Postal_Code_Been_Checked</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Uncheck_Is_Postal_Code_Valid</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(  NOT($Setup.Bypass__c.Workflow_Rules__c),  NOT(ISNEW()),  ISCHANGED( Recipient_Secondary_Postal_Code__c )  )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>New Grant Awards for Organisation with empty recipient name</fullName>
        <actions>
            <name>Update_Recipient_Name</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>This is the workflow rule for new grant awards for organisations</description>
        <formula>AND(  NOT($Setup.Bypass__c.Workflow_Rules__c)  ,  RecordType.Name == &apos;Organisation Award&apos;  , ISBLANK( Recipient_Name_at_Award_Creation__c ) )</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Potential Issue Has Changed</fullName>
        <actions>
            <name>Update_Flag_Last_Modified_By</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(  NOT($Setup.Bypass__c.Workflow_Rules__c),  Potential_Issue_With_Grant_Delivery__c = TRUE )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
