<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Notify_Admins_of_Inactive_Users</fullName>
        <description>Notify Admins of Inactive Users</description>
        <protected>false</protected>
        <recipients>
            <field>Email</field>
            <type>email</type>
        </recipients>
        <senderAddress>grantshubsupport@cabinetoffice.gov.uk</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/Inactive_Users_With_Grants_Reminder</template>
    </alerts>
    <alerts>
        <fullName>Send_Incomplete_Grant_Awards_reminder</fullName>
        <description>Send Incomplete Grant Awards reminder</description>
        <protected>false</protected>
        <recipients>
            <field>Email</field>
            <type>email</type>
        </recipients>
        <senderAddress>grantshubsupport@cabinetoffice.gov.uk</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/Incomplete_Grants_Reminder</template>
    </alerts>
    <alerts>
        <fullName>X12_Month_Grant_Scheme_Review_Outcome_Reminder</fullName>
        <description>12 Month Grant Scheme Review Outcome Reminder</description>
        <protected>false</protected>
        <recipients>
            <field>Email</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/X12_Month_Grant_Scheme_Review_Outcome_Reminder</template>
    </alerts>
    <alerts>
        <fullName>X18_Month_Grant_Scheme_Review_Reminder</fullName>
        <description>18 Month Grant Scheme Review Reminder</description>
        <protected>false</protected>
        <recipients>
            <field>Email</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/X18_Month_Grant_Scheme_Review_Reminder</template>
    </alerts>
    <alerts>
        <fullName>X9_Month_Grant_Scheme_Review_Reminder</fullName>
        <description>9 Month Grant Scheme Review Reminder</description>
        <protected>false</protected>
        <recipients>
            <field>Email</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/X9_Month_Grant_Scheme_Review_Reminder</template>
    </alerts>
    <fieldUpdates>
        <fullName>Uncheck_Grant_Reminder_Flag</fullName>
        <field>SendGrantReminder__c</field>
        <literalValue>0</literalValue>
        <name>Uncheck Grant Reminder Flag</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Uncheck_Send_Inactive_User</fullName>
        <field>SendInactiveUserEmail__c</field>
        <literalValue>0</literalValue>
        <name>Uncheck Send Inactive User</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Last_Review_Reminder_Email_Date</fullName>
        <field>Last_Review_Reminder_Email__c</field>
        <formula>TODAY()</formula>
        <name>Update Last Review Reminder Email Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>Send Grant Scheme review reminder emails</fullName>
        <active>true</active>
        <booleanFilter>(1 OR 2) AND 3</booleanFilter>
        <criteriaItems>
            <field>User.Last_Review_Reminder_Email__c</field>
            <operation>equals</operation>
            <value>TODAY</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.Last_Review_Reminder_Email__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <criteriaItems>
            <field>User.Next_Review_Reminder_Email__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>X12_Month_Grant_Scheme_Review_Outcome_Reminder</name>
                <type>Alert</type>
            </actions>
            <actions>
                <name>X18_Month_Grant_Scheme_Review_Reminder</name>
                <type>Alert</type>
            </actions>
            <actions>
                <name>X9_Month_Grant_Scheme_Review_Reminder</name>
                <type>Alert</type>
            </actions>
            <actions>
                <name>Update_Last_Review_Reminder_Email_Date</name>
                <type>FieldUpdate</type>
            </actions>
            <offsetFromField>User.Next_Review_Reminder_Email__c</offsetFromField>
            <timeLength>1</timeLength>
            <workflowTimeTriggerUnit>Hours</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Send Inactive Users Reminder</fullName>
        <actions>
            <name>Notify_Admins_of_Inactive_Users</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Uncheck_Send_Inactive_User</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>User.IsActive</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.ProfileId</field>
            <operation>equals</operation>
            <value>System Administrator</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.SendInactiveUserEmail__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>Workflow to notify Admins on incomplete Grant Awards with inactive users</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Send Incomplete Grant Awards Reminder</fullName>
        <actions>
            <name>Send_Incomplete_Grant_Awards_reminder</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Uncheck_Grant_Reminder_Flag</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>User.IsActive</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.SendGrantReminder__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>Workflow to send reminder email to users whose Grant Awards have incomplete information.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>