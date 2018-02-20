<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Update_Considered_Grants_Advice_to_Yes</fullName>
        <field>Considered_by_the_Grants_Advice_Panel__c</field>
        <literalValue>Yes</literalValue>
        <name>Update Considered Grants Advice to Yes</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Evaluation_Modified_Date</fullName>
        <field>Evaluation_Modified_Date_by_Portal_User__c</field>
        <formula>IF ((TODAY() - Max_Grant_Award_End_Date__c) &gt; 365 
 , NOW() 
 , DATETIMEVALUE(Max_Grant_Award_End_Date__c + 365) 
)</formula>
        <name>Update Evaluation Modified Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Grant_Scheme_to_Proposed</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Proposed_Grant_Scheme</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Update Grant Scheme to Proposed</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Grant_Scheme_to_Withdrawn</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Withdrawn_Grant_Scheme</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Update Grant Scheme to Withdrawn</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Grant Scheme Evaluation fields have been Modified</fullName>
        <actions>
            <name>Update_Evaluation_Modified_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <formula>AND(ISPICKVAL($Profile.UserType, &apos;PowerCustomerSuccess&apos;)
  , OR(
     AND(ISBLANK(Evaluation_Modified_Date_by_Portal_User__c)
      , ISCHANGED(Scheme_Objective__c) 
      , ISCHANGED(If_No_Reasons__c))
     , AND(NOT(ISBLANK(Evaluation_Modified_Date_by_Portal_User__c))
      ,  Max_Grant_Award_End_Date__c &lt; DATEVALUE(Evaluation_Modified_Date_by_Portal_User__c))
  )
)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Grant Scheme Un-Withdrawn</fullName>
        <actions>
            <name>Update_Grant_Scheme_to_Proposed</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Grant_Scheme__c.Grant_Scheme_Withdrawn__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <criteriaItems>
            <field>Grant_Scheme__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Withdrawn Grant Scheme</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Grant Scheme Withdrawn</fullName>
        <actions>
            <name>Update_Grant_Scheme_to_Withdrawn</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Grant_Scheme__c.Grant_Scheme_Withdrawn__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Grant_Scheme__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Proposed Grant Scheme</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update Considered by the Grants Advice Panel to Yes</fullName>
        <actions>
            <name>Update_Considered_Grants_Advice_to_Yes</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Grant_Scheme__c.Department_referring_to_NGAP__c</field>
            <operation>equals</operation>
            <value>Yes</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
