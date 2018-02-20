public with sharing class CSVUploadMappingMockDataFactory {
	public List<CSV_Upload_Mapping_Column__c> create(){
		return new List<CSV_Upload_Mapping_Column__c>{
            // Recepient Mapping
            new CSV_Upload_Mapping_Column__c(
                Name = 'AWD-CRT-Organisation Name', Mapped_From_Field__c = 'Recipient Name', SObject_Type__c = Constant.SOBJECT_TYPE_ACCOUNT, Mapped_To_Field__c = 'Name', Required__c = true,
                CSV_Upload_Type__c = Constant.CSV_UPLOAD_CREATE_AWARD_TYPE, SObject_Creator__c = Constant.CSV_SOBJECT_CREATOR_GRANT_AWARD_RECEPIENT,
                CSV_Upload_Recipient_Type__c = Constant.GRT_ORGANISATION
            ),
            new CSV_Upload_Mapping_Column__c(
                Name = 'AWD-CRT-Recepeint Address 1', Mapped_From_Field__c = 'Award Address 1', SObject_Type__c = Constant.SOBJECT_TYPE_ACCOUNT, Mapped_To_Field__c = 'Primary_Address_1__c',
                Required__c = true, CSV_Upload_Type__c = Constant.CSV_UPLOAD_CREATE_AWARD_TYPE, SObject_Creator__c = Constant.CSV_SOBJECT_CREATOR_GRANT_AWARD_RECEPIENT,
                CSV_Upload_Recipient_Type__c = Constant.GRT_ORGANISATION
            ),
            new CSV_Upload_Mapping_Column__c(
                Name = 'AWD-CRT-Recepeint Address 2', Mapped_From_Field__c = 'Award Address 2', SObject_Type__c = Constant.SOBJECT_TYPE_ACCOUNT, Mapped_To_Field__c = 'Primary_Address_2__c',
                CSV_Upload_Type__c = Constant.CSV_UPLOAD_CREATE_AWARD_TYPE, SObject_Creator__c = Constant.CSV_SOBJECT_CREATOR_GRANT_AWARD_RECEPIENT,
                CSV_Upload_Recipient_Type__c = Constant.GRT_ORGANISATION
            ),
            new CSV_Upload_Mapping_Column__c(
                Name = 'AWD-CRT-Recepeint City', Mapped_From_Field__c = 'Award City', SObject_Type__c = Constant.SOBJECT_TYPE_ACCOUNT, Mapped_To_Field__c = 'Primary_City__c',
                Required__c = true, CSV_Upload_Type__c = Constant.CSV_UPLOAD_CREATE_AWARD_TYPE, SObject_Creator__c = Constant.CSV_SOBJECT_CREATOR_GRANT_AWARD_RECEPIENT,
                CSV_Upload_Recipient_Type__c = Constant.GRT_ORGANISATION
            ),
            new CSV_Upload_Mapping_Column__c(
                Name = 'AWD-CRT-Recepeint County', Mapped_From_Field__c = 'Award County', SObject_Type__c = Constant.SOBJECT_TYPE_ACCOUNT, Mapped_To_Field__c = 'Primary_County__c',
                Required__c = false, CSV_Upload_Type__c = Constant.CSV_UPLOAD_CREATE_AWARD_TYPE, SObject_Creator__c = Constant.CSV_SOBJECT_CREATOR_GRANT_AWARD_RECEPIENT,
                CSV_Upload_Recipient_Type__c = Constant.GRT_ORGANISATION
            ),
            new CSV_Upload_Mapping_Column__c(
                Name = 'AWD-CRT-Recepeint Postal Code', Mapped_From_Field__c = 'Award Postal Code', SObject_Type__c = Constant.SOBJECT_TYPE_ACCOUNT, Mapped_To_Field__c = 'Primary_Postal_Code__c',
                Required__c = true, CSV_Upload_Type__c = Constant.CSV_UPLOAD_CREATE_AWARD_TYPE, SObject_Creator__c = Constant.CSV_SOBJECT_CREATOR_GRANT_AWARD_RECEPIENT,
                CSV_Upload_Recipient_Type__c = Constant.GRT_ORGANISATION
            ),
            new CSV_Upload_Mapping_Column__c(
                Name = 'AWD-CRT-Recepeint Country', Mapped_From_Field__c = 'Award Country', SObject_Type__c = Constant.SOBJECT_TYPE_ACCOUNT, Mapped_To_Field__c = 'Primary_Country__c',
                Required__c = true, CSV_Upload_Type__c = Constant.CSV_UPLOAD_CREATE_AWARD_TYPE, SObject_Creator__c = Constant.CSV_SOBJECT_CREATOR_GRANT_AWARD_RECEPIENT,
                Value_Parser__c = Constant.STRING_VALUE_PARSER_PICKLIST, Not_Found_Error_Message__c = 'Award Country contains an invalid value.',
                CSV_Upload_Recipient_Type__c = Constant.GRT_ORGANISATION
            ),
            new CSV_Upload_Mapping_Column__c(
                Name = 'AWD-CRT-Recipient ID and Type', Mapped_From_Field__c = 'Recipient ID', SObject_Type__c = Constant.SOBJECT_TYPE_ACCOUNT, Mapped_To_Field__c = 'Recipient ID Type',
                Required__c = true, CSV_Upload_Type__c = Constant.CSV_UPLOAD_CREATE_AWARD_TYPE, SObject_Creator__c = Constant.CSV_SOBJECT_CREATOR_GRANT_AWARD_RECEPIENT,
                External_Id_Type_Column__c = true,
                CSV_Upload_Recipient_Type__c = Constant.GRT_ORGANISATION
            ),
            // Award Mapping
            new CSV_Upload_Mapping_Column__c(
                Name = 'AWD-CRT-Award Recipient', Mapped_From_Field__c = 'Recipient ID', 
                SObject_Type__c = Constant.SOBJECT_TYPE_GRANT_AWARD, Mapped_To_Field__c = 'Recipient ID Type', Required__c = true,
                CSV_Upload_Type__c = Constant.CSV_UPLOAD_CREATE_AWARD_TYPE, SObject_Creator__c = Constant.CSV_SOBJECT_CREATOR_GRANT_AWARD,
                External_Id_Type_Column__c = true, Query_Result_Id_Mapped_to_Field__c = 'Recipient__c',
                Record_Locator_Query__c = 'SELECT Id FROM Account WHERE ' + Constant.QUERY_INPUT_FIELD_TEMPLATE + ' = \'' + Constant.QUERY_INPUT_VALUE_TEMPLATE + '\' LIMIT 1',
                Run_SObject_Creator_On_Record_Not_Found__c = Constant.CSV_SOBJECT_CREATOR_GRANT_AWARD_RECEPIENT,
                CSV_Upload_Recipient_Type__c = Constant.GRT_ORGANISATION
            ),
            new CSV_Upload_Mapping_Column__c(
                Name = 'AWD-CRT-Grant Award Reference Number', Mapped_From_Field__c = 'Grant Award Reference Number', 
                SObject_Type__c = Constant.SOBJECT_TYPE_GRANT_AWARD, Mapped_To_Field__c = 'Grant_Award_Reference_Number__c', 
                CSV_Upload_Type__c = Constant.CSV_UPLOAD_CREATE_AWARD_TYPE, SObject_Creator__c = Constant.CSV_SOBJECT_CREATOR_GRANT_AWARD,
                CSV_Upload_Recipient_Type__c = Constant.GRT_ORGANISATION
            ),
            new CSV_Upload_Mapping_Column__c(
                Name = 'AWD-CRT-Grant Award Name', Mapped_From_Field__c = 'Grant Award Name', 
                SObject_Type__c = Constant.SOBJECT_TYPE_GRANT_AWARD, Mapped_To_Field__c = 'Grant_Award_Name__c', Required__c = true,
                CSV_Upload_Type__c = Constant.CSV_UPLOAD_CREATE_AWARD_TYPE, SObject_Creator__c = Constant.CSV_SOBJECT_CREATOR_GRANT_AWARD,
                CSV_Upload_Recipient_Type__c = Constant.GRT_ORGANISATION
            ),
            new CSV_Upload_Mapping_Column__c(
                Name = 'AWD-CRT-Award Secondary Address 1', Mapped_From_Field__c = 'Award Address 1', 
                SObject_Type__c = Constant.SOBJECT_TYPE_GRANT_AWARD, Mapped_To_Field__c = 'Recipient_Secondary_Address_1__c', Required__c = false,
                CSV_Upload_Type__c = Constant.CSV_UPLOAD_CREATE_AWARD_TYPE, SObject_Creator__c = Constant.CSV_SOBJECT_CREATOR_GRANT_AWARD,
                CSV_Upload_Recipient_Type__c = Constant.GRT_ORGANISATION
            ),
            new CSV_Upload_Mapping_Column__c(
                Name = 'AWD-CRT-Award Secondary Address 2', Mapped_From_Field__c = 'Award Address 2', 
                SObject_Type__c = Constant.SOBJECT_TYPE_GRANT_AWARD, Mapped_To_Field__c = 'Recipient_Secondary_Address_2__c', Required__c = false,
                CSV_Upload_Type__c = Constant.CSV_UPLOAD_CREATE_AWARD_TYPE, SObject_Creator__c = Constant.CSV_SOBJECT_CREATOR_GRANT_AWARD,
                CSV_Upload_Recipient_Type__c = Constant.GRT_ORGANISATION
            ),
            new CSV_Upload_Mapping_Column__c(
                Name = 'AWD-CRT-Award Secondary City', Mapped_From_Field__c = 'Award City', 
                SObject_Type__c = Constant.SOBJECT_TYPE_GRANT_AWARD, Mapped_To_Field__c = 'Recipient_Secondary_City__c', Required__c = false,
                CSV_Upload_Type__c = Constant.CSV_UPLOAD_CREATE_AWARD_TYPE, SObject_Creator__c = Constant.CSV_SOBJECT_CREATOR_GRANT_AWARD,
                CSV_Upload_Recipient_Type__c = Constant.GRT_ORGANISATION
            ),
            new CSV_Upload_Mapping_Column__c(
                Name = 'AWD-CRT-Award Secondary County', Mapped_From_Field__c = 'Award County', 
                SObject_Type__c = Constant.SOBJECT_TYPE_GRANT_AWARD, Mapped_To_Field__c = 'Recipient_Secondary_County__c', Required__c = false,
                CSV_Upload_Type__c = Constant.CSV_UPLOAD_CREATE_AWARD_TYPE, SObject_Creator__c = Constant.CSV_SOBJECT_CREATOR_GRANT_AWARD,
                CSV_Upload_Recipient_Type__c = Constant.GRT_ORGANISATION
            ),
            new CSV_Upload_Mapping_Column__c(
                Name = 'AWD-CRT-Award Secondary Postal Code', Mapped_From_Field__c = 'Award Postal Code', 
                SObject_Type__c = Constant.SOBJECT_TYPE_GRANT_AWARD, Mapped_To_Field__c = 'Recipient_Secondary_Postal_Code__c', Required__c = false,
                CSV_Upload_Type__c = Constant.CSV_UPLOAD_CREATE_AWARD_TYPE, SObject_Creator__c = Constant.CSV_SOBJECT_CREATOR_GRANT_AWARD,
                CSV_Upload_Recipient_Type__c = Constant.GRT_ORGANISATION
            ),
            new CSV_Upload_Mapping_Column__c(
                Name = 'AWD-CRT-Award Secondary Country', Mapped_From_Field__c = 'Award Country', 
                SObject_Type__c = Constant.SOBJECT_TYPE_GRANT_AWARD, Mapped_To_Field__c = 'Recipient_Secondary_Country__c', Required__c = false,
                CSV_Upload_Type__c = Constant.CSV_UPLOAD_CREATE_AWARD_TYPE, SObject_Creator__c = Constant.CSV_SOBJECT_CREATOR_GRANT_AWARD,
                Value_Parser__c = Constant.STRING_VALUE_PARSER_PICKLIST, Not_Found_Error_Message__c = 'Award Country contains an invalid value.',
                CSV_Upload_Recipient_Type__c = Constant.GRT_ORGANISATION
            ),
            new CSV_Upload_Mapping_Column__c(
                Name = 'AWD-CRT-Get exst organisation address', Mapped_From_Field__c = 'Get exisiting organisation address', 
                SObject_Type__c = Constant.SOBJECT_TYPE_GRANT_AWARD, Mapped_To_Field__c = 'Get_existing_organisation_address__c', Required__c = false,
                CSV_Upload_Type__c = Constant.CSV_UPLOAD_CREATE_AWARD_TYPE, SObject_Creator__c = Constant.CSV_SOBJECT_CREATOR_GRANT_AWARD,
                Value_Parser__c = Constant.STRING_VALUE_PARSER_BOOLEAN, CSV_Upload_Recipient_Type__c = Constant.GRT_ORGANISATION
            ),
            new CSV_Upload_Mapping_Column__c(
                Name = 'AWD-CRT-Is GRNT Monitored', Mapped_From_Field__c = 'Is Grant Monitored', 
                SObject_Type__c = Constant.SOBJECT_TYPE_GRANT_AWARD, Mapped_To_Field__c = 'Is_The_Grant_Monitored__c', Required__c = false,
                CSV_Upload_Type__c = Constant.CSV_UPLOAD_CREATE_AWARD_TYPE, SObject_Creator__c = Constant.CSV_SOBJECT_CREATOR_GRANT_AWARD,
                Value_Parser__c = Constant.STRING_VALUE_PARSER_PICKLIST, Not_Found_Error_Message__c = 'Is Grant Monitored contains an invalid value.',
                CSV_Upload_Recipient_Type__c = Constant.GRT_ORGANISATION
            ),
            new CSV_Upload_Mapping_Column__c(
                Name = 'AWD-CRT-Reason for no monitoring', Mapped_From_Field__c = 'Reason for no monitoring', 
                SObject_Type__c = Constant.SOBJECT_TYPE_GRANT_AWARD, Mapped_To_Field__c = 'Reason_For_No_Monitoring__c', Required__c = false,
                CSV_Upload_Type__c = Constant.CSV_UPLOAD_CREATE_AWARD_TYPE, SObject_Creator__c = Constant.CSV_SOBJECT_CREATOR_GRANT_AWARD,
                CSV_Upload_Recipient_Type__c = Constant.GRT_ORGANISATION
            ),
            new CSV_Upload_Mapping_Column__c(
                Name = 'AWD-CRT-Contact Forename', Mapped_From_Field__c = 'Contact Forename', 
                SObject_Type__c = Constant.SOBJECT_TYPE_GRANT_AWARD, Mapped_To_Field__c = 'Contact_Forename__c', Required__c = true,
                CSV_Upload_Type__c = Constant.CSV_UPLOAD_CREATE_AWARD_TYPE, SObject_Creator__c = Constant.CSV_SOBJECT_CREATOR_GRANT_AWARD,
                CSV_Upload_Recipient_Type__c = Constant.GRT_ORGANISATION
            ),
            new CSV_Upload_Mapping_Column__c(
                Name = 'AWD-CRT-Contact Surname', Mapped_From_Field__c = 'Contact Surname', 
                SObject_Type__c = Constant.SOBJECT_TYPE_GRANT_AWARD, Mapped_To_Field__c = 'Contact_Surname__c', Required__c = true,
                CSV_Upload_Type__c = Constant.CSV_UPLOAD_CREATE_AWARD_TYPE, SObject_Creator__c = Constant.CSV_SOBJECT_CREATOR_GRANT_AWARD,
                CSV_Upload_Recipient_Type__c = Constant.GRT_ORGANISATION
            ),
            new CSV_Upload_Mapping_Column__c(
                Name = 'AWD-CRT-Contact Email', Mapped_From_Field__c = 'Contact Email', 
                SObject_Type__c = Constant.SOBJECT_TYPE_GRANT_AWARD, Mapped_To_Field__c = 'Contact_Email__c', Required__c = true,
                CSV_Upload_Type__c = Constant.CSV_UPLOAD_CREATE_AWARD_TYPE, SObject_Creator__c = Constant.CSV_SOBJECT_CREATOR_GRANT_AWARD,
                CSV_Upload_Recipient_Type__c = Constant.GRT_ORGANISATION
            ),
            new CSV_Upload_Mapping_Column__c(
                Name = 'AWD-CRT-Allocation Method', Mapped_From_Field__c = 'Allocation Method', 
                SObject_Type__c = Constant.SOBJECT_TYPE_GRANT_AWARD, Mapped_To_Field__c = 'Allocation_Method__c', Required__c = true,
                CSV_Upload_Type__c = Constant.CSV_UPLOAD_CREATE_AWARD_TYPE, SObject_Creator__c = Constant.CSV_SOBJECT_CREATOR_GRANT_AWARD,
                Value_Parser__c = Constant.STRING_VALUE_PARSER_PICKLIST, Accept_Multi_Values__c = false, 
                Not_Found_Error_Message__c = 'Allocation Method contains an invalid value.',
                CSV_Upload_Recipient_Type__c = Constant.GRT_ORGANISATION
            ),
            new CSV_Upload_Mapping_Column__c(
                Name = 'AWD-CRT-Grant Award Objective', Mapped_From_Field__c = 'Grant Award Objective', 
                SObject_Type__c = Constant.SOBJECT_TYPE_GRANT_AWARD, Mapped_To_Field__c = 'Grant_Award_Objective__c', Required__c = false,
                CSV_Upload_Type__c = Constant.CSV_UPLOAD_CREATE_AWARD_TYPE, SObject_Creator__c = Constant.CSV_SOBJECT_CREATOR_GRANT_AWARD,
                CSV_Upload_Recipient_Type__c = Constant.GRT_ORGANISATION
            ),
            new CSV_Upload_Mapping_Column__c(
                Name = 'AWD-CRT-Award Start Date', Mapped_From_Field__c = 'Award Start Date', 
                SObject_Type__c = Constant.SOBJECT_TYPE_GRANT_AWARD, Mapped_To_Field__c = 'Award_Start_Date__c', Required__c = false,
                CSV_Upload_Type__c = Constant.CSV_UPLOAD_CREATE_AWARD_TYPE, SObject_Creator__c = Constant.CSV_SOBJECT_CREATOR_GRANT_AWARD,
                Value_Parser__c = Constant.STRING_VALUE_PARSER_DATE,
                CSV_Upload_Recipient_Type__c = Constant.GRT_ORGANISATION
            ),
            new CSV_Upload_Mapping_Column__c(
                Name = 'AWD-CRT-Award End Date', Mapped_From_Field__c = 'Award End Date', 
                SObject_Type__c = Constant.SOBJECT_TYPE_GRANT_AWARD, Mapped_To_Field__c = 'Award_End_Date__c', Required__c = false,
                CSV_Upload_Type__c = Constant.CSV_UPLOAD_CREATE_AWARD_TYPE, SObject_Creator__c = Constant.CSV_SOBJECT_CREATOR_GRANT_AWARD,
                Value_Parser__c = Constant.STRING_VALUE_PARSER_DATE,
                CSV_Upload_Recipient_Type__c = Constant.GRT_ORGANISATION
            ),
            new CSV_Upload_Mapping_Column__c(
                Name = 'AWD-CRT-Total Amount funding agrmnt', Mapped_From_Field__c = 'Total Amount in funding agreement in GBP', 
                SObject_Type__c = Constant.SOBJECT_TYPE_GRANT_AWARD, Mapped_To_Field__c = 'Total_Amount_in_funding_agreement__c', Required__c = true,
                CSV_Upload_Type__c = Constant.CSV_UPLOAD_CREATE_AWARD_TYPE, SObject_Creator__c = Constant.CSV_SOBJECT_CREATOR_GRANT_AWARD,
                Value_Parser__c = Constant.STRING_VALUE_PARSER_DECIMAL,
                CSV_Upload_Recipient_Type__c = Constant.GRT_ORGANISATION
            ),
            new CSV_Upload_Mapping_Column__c(
                Name = 'AWD-CRT-' + TestDataFactory.TEST_CCOA_COLUMN, Mapped_From_Field__c = TestDataFactory.TEST_CCOA_COLUMN, 
                SObject_Type__c = Constant.SOBJECT_TYPE_GRANT_AWARD, Mapped_To_Field__c = 'CCoA_L5__c', Required__c = true,
                CSV_Upload_Type__c = Constant.CSV_UPLOAD_CREATE_AWARD_TYPE, SObject_Creator__c = Constant.CSV_SOBJECT_CREATOR_GRANT_AWARD,
                Record_Locator_Query__c = 'SELECT Id FROM COA_L5__c WHERE Name = \'' + Constant.QUERY_INPUT_VALUE_TEMPLATE + '\' LIMIT 1',
                Not_Found_Error_Message__c = 'No ' + TestDataFactory.TEST_CCOA_COLUMN + ' was found with the provided Id.',
                CSV_Upload_Recipient_Type__c = Constant.GRT_ORGANISATION
            ),
            new CSV_Upload_Mapping_Column__c(
                Name = 'AWD-CRT-Scheme Ref or SF Scheme Ref', Mapped_From_Field__c = Constant.GRANT_SCHEME_AND_SYSTEM_REFERENCE_LABEL, 
                SObject_Type__c = Constant.SOBJECT_TYPE_GRANT_AWARD, Mapped_To_Field__c = 'Grant_Scheme__c', Required__c = true,
                CSV_Upload_Type__c = Constant.CSV_UPLOAD_CREATE_AWARD_TYPE, SObject_Creator__c = Constant.CSV_SOBJECT_CREATOR_GRANT_AWARD,
                Record_Locator_Query__c = 'SELECT Id FROM Grant_Scheme__c WHERE Name = \'' + Constant.QUERY_INPUT_VALUE_TEMPLATE + '\' OR Scheme_Reference_No__c = \'' + Constant.QUERY_INPUT_VALUE_TEMPLATE + '\' LIMIT 1',
                Not_Found_Error_Message__c = 'No Grant Scheme was found with the provided Id.',
                CSV_Upload_Recipient_Type__c = Constant.GRT_ORGANISATION
            ),

            //Intermediary Organisation 1
            new CSV_Upload_Mapping_Column__c(
                Name = 'AWD-CRT-Intermediary name 1', Mapped_From_Field__c = 'Intermediary name 1', SObject_Type__c = Constant.SOBJECT_TYPE_ACCOUNT, Mapped_To_Field__c = 'Name',
                CSV_Upload_Type__c = Constant.CSV_UPLOAD_CREATE_AWARD_TYPE, SObject_Creator__c = Constant.CSV_SOBJECT_CREATOR_GRANT_AWARD_INTERMEDIARY_ORGANISATION,
                Group__c = 1,
                CSV_Upload_Recipient_Type__c = Constant.GRT_ORGANISATION
            ),
            new CSV_Upload_Mapping_Column__c(
                Name = 'AWD-CRT-Intermediary 1 ID and Type', Mapped_From_Field__c = 'Intermediary Id 1', SObject_Type__c = Constant.SOBJECT_TYPE_ACCOUNT, Mapped_To_Field__c = 'Intermediary Id Type 1',
                CSV_Upload_Type__c = Constant.CSV_UPLOAD_CREATE_AWARD_TYPE, SObject_Creator__c = Constant.CSV_SOBJECT_CREATOR_GRANT_AWARD_INTERMEDIARY_ORGANISATION,
                External_Id_Type_Column__c = true, Group__c = 1,
                CSV_Upload_Recipient_Type__c = Constant.GRT_ORGANISATION
            ),

            //Intermediary 1
            new CSV_Upload_Mapping_Column__c(
                Name = 'AWD-CRT-Intermediary Id 1', Mapped_From_Field__c = 'Intermediary Id 1', SObject_Type__c = Constant.SOBJECT_TYPE_INTERMEDIARY, Mapped_To_Field__c = 'Intermediary Id Type 1', 
                CSV_Upload_Type__c = Constant.CSV_UPLOAD_CREATE_AWARD_TYPE, SObject_Creator__c = Constant.CSV_SOBJECT_CREATOR_GRANT_AWARD_INTERMEDIARY,
                External_Id_Type_Column__c = true, Query_Result_Id_Mapped_to_Field__c = 'Intermediary_Organisation__c',
                Record_Locator_Query__c = 'SELECT Id FROM Account WHERE ' + Constant.QUERY_INPUT_FIELD_TEMPLATE + ' = \'' + Constant.QUERY_INPUT_VALUE_TEMPLATE + '\' LIMIT 1',
                Run_SObject_Creator_On_Record_Not_Found__c = Constant.CSV_SOBJECT_CREATOR_GRANT_AWARD_INTERMEDIARY_ORGANISATION,
                Group__c = 1,
                CSV_Upload_Recipient_Type__c = Constant.GRT_ORGANISATION
            ),
            new CSV_Upload_Mapping_Column__c(
                Name = 'AWD-CRT-Intermediary Role 1', Mapped_From_Field__c = 'Intermediary Role 1', SObject_Type__c = Constant.SOBJECT_TYPE_INTERMEDIARY, Mapped_To_Field__c = 'Role__c',
                CSV_Upload_Type__c = Constant.CSV_UPLOAD_CREATE_AWARD_TYPE, SObject_Creator__c = Constant.CSV_SOBJECT_CREATOR_GRANT_AWARD_INTERMEDIARY,
                Group__c = 1, Value_Parser__c = Constant.STRING_VALUE_PARSER_PICKLIST, Accept_Multi_Values__c = true, 
                Not_Found_Error_Message__c = 'Intermediary Role 1 contains an invalid value.',
                CSV_Upload_Recipient_Type__c = Constant.GRT_ORGANISATION
            ),

            //Intermediary Organisation 2
            new CSV_Upload_Mapping_Column__c(
                Name = 'AWD-CRT-Intermediary name 2', Mapped_From_Field__c = 'Intermediary name 2', SObject_Type__c = Constant.SOBJECT_TYPE_ACCOUNT, Mapped_To_Field__c = 'Name',
                CSV_Upload_Type__c = Constant.CSV_UPLOAD_CREATE_AWARD_TYPE, SObject_Creator__c = Constant.CSV_SOBJECT_CREATOR_GRANT_AWARD_INTERMEDIARY_ORGANISATION,
                Group__c = 2,
                CSV_Upload_Recipient_Type__c = Constant.GRT_ORGANISATION
            ),
            new CSV_Upload_Mapping_Column__c(
                Name = 'AWD-CRT-Intermediary 2 ID and Type', Mapped_From_Field__c = 'Intermediary Id 2', SObject_Type__c = Constant.SOBJECT_TYPE_ACCOUNT, Mapped_To_Field__c = 'Intermediary Id Type 2',
                CSV_Upload_Type__c = Constant.CSV_UPLOAD_CREATE_AWARD_TYPE, SObject_Creator__c = Constant.CSV_SOBJECT_CREATOR_GRANT_AWARD_INTERMEDIARY_ORGANISATION,
                External_Id_Type_Column__c = true, Group__c = 2,
                CSV_Upload_Recipient_Type__c = Constant.GRT_ORGANISATION
            ),
            //Intermediary 2
            new CSV_Upload_Mapping_Column__c(
                Name = 'AWD-CRT-Intermediary Id 2', Mapped_From_Field__c = 'Intermediary Id 2', SObject_Type__c = Constant.SOBJECT_TYPE_INTERMEDIARY, Mapped_To_Field__c = 'Intermediary Id Type 2', 
                CSV_Upload_Type__c = Constant.CSV_UPLOAD_CREATE_AWARD_TYPE, SObject_Creator__c = Constant.CSV_SOBJECT_CREATOR_GRANT_AWARD_INTERMEDIARY,
                External_Id_Type_Column__c = true, Query_Result_Id_Mapped_to_Field__c = 'Intermediary_Organisation__c',
                Record_Locator_Query__c = 'SELECT Id FROM Account WHERE ' + Constant.QUERY_INPUT_FIELD_TEMPLATE + ' = \'' + Constant.QUERY_INPUT_VALUE_TEMPLATE + '\' LIMIT 1',
                Run_SObject_Creator_On_Record_Not_Found__c = Constant.CSV_SOBJECT_CREATOR_GRANT_AWARD_INTERMEDIARY_ORGANISATION,
                Group__c = 2,
                CSV_Upload_Recipient_Type__c = Constant.GRT_ORGANISATION
            ),
            new CSV_Upload_Mapping_Column__c(
                Name = 'AWD-CRT-Intermediary Role 2', Mapped_From_Field__c = 'Intermediary Role 2', SObject_Type__c = Constant.SOBJECT_TYPE_INTERMEDIARY, Mapped_To_Field__c = 'Role__c',
                CSV_Upload_Type__c = Constant.CSV_UPLOAD_CREATE_AWARD_TYPE, SObject_Creator__c = Constant.CSV_SOBJECT_CREATOR_GRANT_AWARD_INTERMEDIARY,
                Group__c = 2, Value_Parser__c = Constant.STRING_VALUE_PARSER_PICKLIST, Accept_Multi_Values__c = true,
                Not_Found_Error_Message__c = 'Intermediary Role 2 contains an invalid value.',
                CSV_Upload_Recipient_Type__c = Constant.GRT_ORGANISATION
            ),
            // Award AMEND
            // Award Mapping
            new CSV_Upload_Mapping_Column__c(
                Name = 'AWD-AMN-System Award Reference No', Mapped_From_Field__c = 'System Award Reference No', 
                SObject_Type__c = Constant.SOBJECT_TYPE_GRANT_AWARD, Mapped_To_Field__c = 'Name', Read_Only__c = true,
                CSV_Upload_Type__c = Constant.CSV_UPLOAD_AMEND_AWARD_TYPE, SObject_Creator__c = Constant.CSV_SOBJECT_AMEND_GRANT_AWARD,
                CSV_Upload_Recipient_Type__c = Constant.GRT_ORGANISATION
            ),
            new CSV_Upload_Mapping_Column__c(
                Name = 'AWD-AMN-Grant Award Reference Number', Mapped_From_Field__c = 'Grant Award Reference Number', 
                SObject_Type__c = Constant.SOBJECT_TYPE_GRANT_AWARD, Mapped_To_Field__c = 'Grant_Award_Reference_Number__c', 
                CSV_Upload_Type__c = Constant.CSV_UPLOAD_AMEND_AWARD_TYPE, SObject_Creator__c = Constant.CSV_SOBJECT_AMEND_GRANT_AWARD,
                CSV_Upload_Recipient_Type__c = Constant.GRT_ORGANISATION
            ),
            new CSV_Upload_Mapping_Column__c(
                Name = 'AWD-AMN-Grant Award Name', Mapped_From_Field__c = 'Grant Award Name', 
                SObject_Type__c = Constant.SOBJECT_TYPE_GRANT_AWARD, Mapped_To_Field__c = 'Grant_Award_Name__c', Required__c = true,
                CSV_Upload_Type__c = Constant.CSV_UPLOAD_AMEND_AWARD_TYPE, SObject_Creator__c = Constant.CSV_SOBJECT_AMEND_GRANT_AWARD,
                CSV_Upload_Recipient_Type__c = Constant.GRT_ORGANISATION
            ),
            new CSV_Upload_Mapping_Column__c(
                Name = 'AWD-AMN-Award Secondary Address 1', Mapped_From_Field__c = 'Award Address 1', 
                SObject_Type__c = Constant.SOBJECT_TYPE_GRANT_AWARD, Mapped_To_Field__c = 'Recipient_Secondary_Address_1__c', Required__c = false,
                CSV_Upload_Type__c = Constant.CSV_UPLOAD_AMEND_AWARD_TYPE, SObject_Creator__c = Constant.CSV_SOBJECT_AMEND_GRANT_AWARD,
                CSV_Upload_Recipient_Type__c = Constant.GRT_ORGANISATION
            ),
            new CSV_Upload_Mapping_Column__c(
                Name = 'AWD-AMN-Award Secondary Address 2', Mapped_From_Field__c = 'Award Address 2', 
                SObject_Type__c = Constant.SOBJECT_TYPE_GRANT_AWARD, Mapped_To_Field__c = 'Recipient_Secondary_Address_2__c', Required__c = false,
                CSV_Upload_Type__c = Constant.CSV_UPLOAD_AMEND_AWARD_TYPE, SObject_Creator__c = Constant.CSV_SOBJECT_AMEND_GRANT_AWARD,
                CSV_Upload_Recipient_Type__c = Constant.GRT_ORGANISATION
            ),
            new CSV_Upload_Mapping_Column__c(
                Name = 'AWD-AMN-Award Secondary City', Mapped_From_Field__c = 'Award City', 
                SObject_Type__c = Constant.SOBJECT_TYPE_GRANT_AWARD, Mapped_To_Field__c = 'Recipient_Secondary_City__c', Required__c = false,
                CSV_Upload_Type__c = Constant.CSV_UPLOAD_AMEND_AWARD_TYPE, SObject_Creator__c = Constant.CSV_SOBJECT_AMEND_GRANT_AWARD,
                CSV_Upload_Recipient_Type__c = Constant.GRT_ORGANISATION
            ),
            new CSV_Upload_Mapping_Column__c(
                Name = 'AWD-AMN-Award Secondary County', Mapped_From_Field__c = 'Award County', 
                SObject_Type__c = Constant.SOBJECT_TYPE_GRANT_AWARD, Mapped_To_Field__c = 'Recipient_Secondary_County__c', Required__c = false,
                CSV_Upload_Type__c = Constant.CSV_UPLOAD_AMEND_AWARD_TYPE, SObject_Creator__c = Constant.CSV_SOBJECT_AMEND_GRANT_AWARD,
                CSV_Upload_Recipient_Type__c = Constant.GRT_ORGANISATION
            ),
            new CSV_Upload_Mapping_Column__c(
                Name = 'AWD-AMN-Award Secondary Postal Code', Mapped_From_Field__c = 'Award Postal Code', 
                SObject_Type__c = Constant.SOBJECT_TYPE_GRANT_AWARD, Mapped_To_Field__c = 'Recipient_Secondary_Postal_Code__c', Required__c = false,
                CSV_Upload_Type__c = Constant.CSV_UPLOAD_AMEND_AWARD_TYPE, SObject_Creator__c = Constant.CSV_SOBJECT_AMEND_GRANT_AWARD,
                CSV_Upload_Recipient_Type__c = Constant.GRT_ORGANISATION
            ),
            new CSV_Upload_Mapping_Column__c(
                Name = 'AWD-AMN-Award Secondary Country', Mapped_From_Field__c = 'Award Country', 
                SObject_Type__c = Constant.SOBJECT_TYPE_GRANT_AWARD, Mapped_To_Field__c = 'Recipient_Secondary_Country__c', Required__c = false,
                CSV_Upload_Type__c = Constant.CSV_UPLOAD_AMEND_AWARD_TYPE, SObject_Creator__c = Constant.CSV_SOBJECT_AMEND_GRANT_AWARD,
                Value_Parser__c = Constant.STRING_VALUE_PARSER_PICKLIST, Not_Found_Error_Message__c = 'Award Country contains an invalid value.',
                CSV_Upload_Recipient_Type__c = Constant.GRT_ORGANISATION
            ),
            new CSV_Upload_Mapping_Column__c(
                Name = 'AWD-AMN-Is GRNT Monitored', Mapped_From_Field__c = 'Is Grant Monitored', 
                SObject_Type__c = Constant.SOBJECT_TYPE_GRANT_AWARD, Mapped_To_Field__c = 'Is_The_Grant_Monitored__c', Required__c = false,
                CSV_Upload_Type__c = Constant.CSV_UPLOAD_AMEND_AWARD_TYPE, SObject_Creator__c = Constant.CSV_SOBJECT_AMEND_GRANT_AWARD,
                Value_Parser__c = Constant.STRING_VALUE_PARSER_PICKLIST, Not_Found_Error_Message__c = 'Is Grant Monitored contains an invalid value.',
                CSV_Upload_Recipient_Type__c = Constant.GRT_ORGANISATION
            ),
            new CSV_Upload_Mapping_Column__c(
                Name = 'AWD-AMN-Reason for no monitoring', Mapped_From_Field__c = 'Reason for no monitoring', 
                SObject_Type__c = Constant.SOBJECT_TYPE_GRANT_AWARD, Mapped_To_Field__c = 'Reason_For_No_Monitoring__c', Required__c = false,
                CSV_Upload_Type__c = Constant.CSV_UPLOAD_AMEND_AWARD_TYPE, SObject_Creator__c = Constant.CSV_SOBJECT_AMEND_GRANT_AWARD,
                CSV_Upload_Recipient_Type__c = Constant.GRT_ORGANISATION
            ),
            new CSV_Upload_Mapping_Column__c(
                Name = 'AWD-AMN-Contact Forename', Mapped_From_Field__c = 'Contact Forename', 
                SObject_Type__c = Constant.SOBJECT_TYPE_GRANT_AWARD, Mapped_To_Field__c = 'Contact_Forename__c', Required__c = true,
                CSV_Upload_Type__c = Constant.CSV_UPLOAD_AMEND_AWARD_TYPE, SObject_Creator__c = Constant.CSV_SOBJECT_AMEND_GRANT_AWARD,
                CSV_Upload_Recipient_Type__c = Constant.GRT_ORGANISATION
            ),
            new CSV_Upload_Mapping_Column__c(
                Name = 'AWD-AMN-Contact Surname', Mapped_From_Field__c = 'Contact Surname', 
                SObject_Type__c = Constant.SOBJECT_TYPE_GRANT_AWARD, Mapped_To_Field__c = 'Contact_Surname__c', Required__c = true,
                CSV_Upload_Type__c = Constant.CSV_UPLOAD_AMEND_AWARD_TYPE, SObject_Creator__c = Constant.CSV_SOBJECT_AMEND_GRANT_AWARD,
                CSV_Upload_Recipient_Type__c = Constant.GRT_ORGANISATION
            ),
            new CSV_Upload_Mapping_Column__c(
                Name = 'AWD-AMN-Contact Email', Mapped_From_Field__c = 'Contact Email', 
                SObject_Type__c = Constant.SOBJECT_TYPE_GRANT_AWARD, Mapped_To_Field__c = 'Contact_Email__c', Required__c = true,
                CSV_Upload_Type__c = Constant.CSV_UPLOAD_AMEND_AWARD_TYPE, SObject_Creator__c = Constant.CSV_SOBJECT_AMEND_GRANT_AWARD,
                CSV_Upload_Recipient_Type__c = Constant.GRT_ORGANISATION
            ),
            new CSV_Upload_Mapping_Column__c(
                Name = 'AWD-AMN-Allocation Method', Mapped_From_Field__c = 'Allocation Method', 
                SObject_Type__c = Constant.SOBJECT_TYPE_GRANT_AWARD, Mapped_To_Field__c = 'Allocation_Method__c', Required__c = true,
                CSV_Upload_Type__c = Constant.CSV_UPLOAD_AMEND_AWARD_TYPE, SObject_Creator__c = Constant.CSV_SOBJECT_AMEND_GRANT_AWARD,
                Value_Parser__c = Constant.STRING_VALUE_PARSER_PICKLIST, Accept_Multi_Values__c = false, 
                Not_Found_Error_Message__c = 'Allocation Method contains an invalid value.',
                CSV_Upload_Recipient_Type__c = Constant.GRT_ORGANISATION
            ),
            new CSV_Upload_Mapping_Column__c(
                Name = 'AWD-AMN-Grant Award Objective', Mapped_From_Field__c = 'Grant Award Objective', 
                SObject_Type__c = Constant.SOBJECT_TYPE_GRANT_AWARD, Mapped_To_Field__c = 'Grant_Award_Objective__c', Required__c = false,
                CSV_Upload_Type__c = Constant.CSV_UPLOAD_AMEND_AWARD_TYPE, SObject_Creator__c = Constant.CSV_SOBJECT_AMEND_GRANT_AWARD,
                CSV_Upload_Recipient_Type__c = Constant.GRT_ORGANISATION
            ),
            new CSV_Upload_Mapping_Column__c(
                Name = 'AWD-AMN-Award Start Date', Mapped_From_Field__c = 'Award Start Date', 
                SObject_Type__c = Constant.SOBJECT_TYPE_GRANT_AWARD, Mapped_To_Field__c = 'Award_Start_Date__c', Required__c = false,
                CSV_Upload_Type__c = Constant.CSV_UPLOAD_AMEND_AWARD_TYPE, SObject_Creator__c = Constant.CSV_SOBJECT_AMEND_GRANT_AWARD,
                Value_Parser__c = Constant.STRING_VALUE_PARSER_DATE,
                CSV_Upload_Recipient_Type__c = Constant.GRT_ORGANISATION
            ),
            new CSV_Upload_Mapping_Column__c(
                Name = 'AWD-AMN-Award End Date', Mapped_From_Field__c = 'Award End Date', 
                SObject_Type__c = Constant.SOBJECT_TYPE_GRANT_AWARD, Mapped_To_Field__c = 'Award_End_Date__c', Required__c = false,
                CSV_Upload_Type__c = Constant.CSV_UPLOAD_AMEND_AWARD_TYPE, SObject_Creator__c = Constant.CSV_SOBJECT_AMEND_GRANT_AWARD,
                Value_Parser__c = Constant.STRING_VALUE_PARSER_DATE,
                CSV_Upload_Recipient_Type__c = Constant.GRT_ORGANISATION
            ),
            new CSV_Upload_Mapping_Column__c(
                Name = 'AWD-AMN-Total Amount funding agrmnt', Mapped_From_Field__c = 'Total Amount in funding agreement in GBP', 
                SObject_Type__c = Constant.SOBJECT_TYPE_GRANT_AWARD, Mapped_To_Field__c = 'Total_Amount_in_funding_agreement__c', Required__c = true,
                CSV_Upload_Type__c = Constant.CSV_UPLOAD_AMEND_AWARD_TYPE, SObject_Creator__c = Constant.CSV_SOBJECT_AMEND_GRANT_AWARD,
                Value_Parser__c = Constant.STRING_VALUE_PARSER_DECIMAL,
                CSV_Upload_Recipient_Type__c = Constant.GRT_ORGANISATION
            ),
            new CSV_Upload_Mapping_Column__c(
                Name = 'AWD-AMN-' + TestDataFactory.TEST_CCOA_COLUMN, Mapped_From_Field__c = TestDataFactory.TEST_CCOA_COLUMN, 
                SObject_Type__c = Constant.SOBJECT_TYPE_GRANT_AWARD, Mapped_To_Field__c = 'CCoA_L5__c', Required__c = true,
                CSV_Upload_Type__c = Constant.CSV_UPLOAD_AMEND_AWARD_TYPE, SObject_Creator__c = Constant.CSV_SOBJECT_AMEND_GRANT_AWARD,
                Record_Locator_Query__c = 'SELECT Id FROM COA_L5__c WHERE Name = \'' + Constant.QUERY_INPUT_VALUE_TEMPLATE + '\' LIMIT 1',
                Not_Found_Error_Message__c = 'No ' + TestDataFactory.TEST_CCOA_COLUMN + ' was found with the provided Id.',
                CSV_Upload_Recipient_Type__c = Constant.GRT_ORGANISATION
            )
        };
	}
}