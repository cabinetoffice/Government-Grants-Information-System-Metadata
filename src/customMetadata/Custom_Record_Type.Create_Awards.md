<?xml version="1.0" encoding="UTF-8"?>
<CustomMetadata xmlns="http://soap.sforce.com/2006/04/metadata" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
    <label>Create Awards</label>
    <protected>false</protected>
    <values>
        <field>CSV_Template_Name__c</field>
        <value xsi:nil="true"/>
    </values>
    <values>
        <field>Default_CSV_Template_Path__c</field>
        <value xsi:type="xsd:string">templates/create-awards-organisation.xlsx</value>
    </values>
    <values>
        <field>Description__c</field>
        <value xsi:type="xsd:string">Choose this Type if you want to create new Grant Awards in the system. You will need to have setup a Grant Scheme first to upload Grant Awards against it.</value>
    </values>
    <values>
        <field>Individual_CSV_Template_Name__c</field>
        <value xsi:type="xsd:string">Click here to download the Data upload template to Create Awards to Individuals</value>
    </values>
    <values>
        <field>Individual_CSV_Template_Path__c</field>
        <value xsi:type="xsd:string">templates/create-awards-individual.xlsx</value>
    </values>
    <values>
        <field>Order__c</field>
        <value xsi:type="xsd:double">1.0</value>
    </values>
    <values>
        <field>Organisation_CSV_Template_Name__c</field>
        <value xsi:type="xsd:string">Click here to download the Data upload template to Create Awards to Organisations</value>
    </values>
    <values>
        <field>Organisation_CSV_Template_Path__c</field>
        <value xsi:type="xsd:string">templates/create-awards-organisation.xlsx</value>
    </values>
    <values>
        <field>Processor__c</field>
        <value xsi:type="xsd:string">CSVUploadSObjectFactory.CreateAwardsFactory</value>
    </values>
    <values>
        <field>Requires_Recipient_Type__c</field>
        <value xsi:type="xsd:boolean">true</value>
    </values>
    <values>
        <field>SObject_API_Name__c</field>
        <value xsi:type="xsd:string">CSV_Upload__c</value>
    </values>
</CustomMetadata>
