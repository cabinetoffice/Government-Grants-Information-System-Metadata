<?xml version="1.0" encoding="UTF-8"?>
<CustomMetadata xmlns="http://soap.sforce.com/2006/04/metadata" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
    <label>Upload Awards Evaluations</label>
    <protected>false</protected>
    <values>
        <field>CSV_Template_Name__c</field>
        <value xsi:type="xsd:string">Click here to download the Data upload template to Upload Awards Evaluations</value>
    </values>
    <values>
        <field>Default_CSV_Template_Path__c</field>
        <value xsi:type="xsd:string">templates/upload-awards-evaluations.xlsx</value>
    </values>
    <values>
        <field>Description__c</field>
        <value xsi:type="xsd:string">Choose this Type if you want to upload Evaluation information against existing Grant Awards in the system. You will need to have created a Grant Award previously in order to be able to add Evaluation information against it.</value>
    </values>
    <values>
        <field>Individual_CSV_Template_Name__c</field>
        <value xsi:nil="true"/>
    </values>
    <values>
        <field>Individual_CSV_Template_Path__c</field>
        <value xsi:nil="true"/>
    </values>
    <values>
        <field>Order__c</field>
        <value xsi:type="xsd:double">4.0</value>
    </values>
    <values>
        <field>Organisation_CSV_Template_Name__c</field>
        <value xsi:nil="true"/>
    </values>
    <values>
        <field>Organisation_CSV_Template_Path__c</field>
        <value xsi:nil="true"/>
    </values>
    <values>
        <field>Processor__c</field>
        <value xsi:type="xsd:string">CSVUploadSObjectFactory.AmendAwardsFactory</value>
    </values>
    <values>
        <field>Requires_Recipient_Type__c</field>
        <value xsi:type="xsd:boolean">false</value>
    </values>
    <values>
        <field>SObject_API_Name__c</field>
        <value xsi:type="xsd:string">CSV_Upload__c</value>
    </values>
</CustomMetadata>
