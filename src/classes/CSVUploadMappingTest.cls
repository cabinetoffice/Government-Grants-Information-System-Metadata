<<<<<<< HEAD
/******************************************************************************************
@Author         Hamed Izadpanah
@Date           03/10/2015
@Project        Cloud Sherpas Cabinet Office Data Source
@Description    This is the unit test for CSV Upload mapping class
*******************************************************************************************/
@isTest
private class CSVUploadMappingTest{
	@testSetup()
	private static void setupTestData(){
		List<CSV_Upload_Mapping_Column__c> requiredColumns = new List<CSV_Upload_Mapping_Column__c>{
			new CSV_Upload_Mapping_Column__c(
				Name = 'AWD-Name',
				Mapped_From_Field__c = 'Award Name',
				Mapped_To_Field__c = 'Name',
				CSV_Upload_Type__c = Constant.CSV_UPLOAD_CREATE_AWARD_TYPE,
				SObject_Creator__c = Constant.CSV_SOBJECT_CREATOR_GRANT_AWARD,
				Required__c = true,
				SObject_Type__c = Constant.SOBJECT_TYPE_GRANT_AWARD
			),
			new CSV_Upload_Mapping_Column__c(
				Name = 'AWD-Address',
				Mapped_From_Field__c = 'Award Address',
				Mapped_To_Field__c = 'Address_Line1__c',
				CSV_Upload_Type__c = Constant.CSV_UPLOAD_CREATE_AWARD_TYPE,
				SObject_Creator__c = Constant.CSV_SOBJECT_CREATOR_GRANT_AWARD,
				Required__c = true,
				SObject_Type__c = Constant.SOBJECT_TYPE_GRANT_AWARD
			),
			new CSV_Upload_Mapping_Column__c(
				Name = 'Recpient External Id Type',
				Mapped_From_Field__c = 'Recepient External Id',
				Mapped_To_Field__c = 'ExternalId',
				CSV_Upload_Type__c = Constant.CSV_UPLOAD_CREATE_AWARD_TYPE,
				SObject_Creator__c = Constant.CSV_SOBJECT_CREATOR_GRANT_AWARD,
				Required__c = true,
				External_Id_Type_Column__c = true,
				SObject_Type__c = Constant.SOBJECT_TYPE_GRANT_AWARD
			)
		};
		insert requiredColumns;
	}

	static CSV_Upload__c csvUpload;
	private static void initData(){
		csvUpload = new CSV_Upload__c(
			RecordTypeId = CSV_Upload__c.SObjectType.getDescribe().getRecordTypeInfosByName().get(Constant.CSV_UPLOAD_GRANT_AWARD_RT_NAME).getRecordTypeId(),
			Type__c = Constant.CSV_UPLOAD_CREATE_AWARD_TYPE
		);
	}
	@isTest()
	static void testGetRequiredMappingColumns(){
		initData();
		CSVUploadMapping mapping = new CSVUploadMapping(csvUpload);
		System.assertEquals(3, mapping.getRequiredMappingColumns().size());
	}
	@isTest()
	static void testGetColumnsMappingForSObjectType(){
		initData();
		CSVUploadMapping mapping = new CSVUploadMapping(csvUpload);
		System.assertEquals(3, mapping.getColumnsSObjectCreator(Constant.CSV_SOBJECT_CREATOR_GRANT_AWARD).size());
	}
	@isTest()
	static void testGetExternalIdTypeField(){
		initData();
		CSVUploadMapping mapping = new CSVUploadMapping(csvUpload);
		System.assertEquals(1, mapping.getExternalIdTypeField().size());
	}
	@isTest()
	static void testGetMappedFields(){
		initData();
		CSVUploadMapping mapping = new CSVUploadMapping(csvUpload);
		System.assertEquals(2, mapping.getMappedFields().size());
	}

=======
<<<<<<< HEAD
/******************************************************************************************
@Author         Hamed Izadpanah
@Date           03/10/2015
@Project        Cloud Sherpas Cabinet Office Data Source
@Description    This is the unit test for CSV Upload mapping class
*******************************************************************************************/
@isTest
private class CSVUploadMappingTest{
	@testSetup()
	private static void setupTestData(){
		List<CSV_Upload_Mapping_Column__c> requiredColumns = new List<CSV_Upload_Mapping_Column__c>{
			new CSV_Upload_Mapping_Column__c(
				Name = 'AWD-Name',
				Mapped_From_Field__c = 'Award Name',
				Mapped_To_Field__c = 'Name',
				CSV_Upload_Type__c = Constant.CSV_UPLOAD_CREATE_AWARD_TYPE,
				SObject_Creator__c = Constant.CSV_SOBJECT_CREATOR_GRANT_AWARD,
				Required__c = true,
				SObject_Type__c = Constant.SOBJECT_TYPE_GRANT_AWARD
			),
			new CSV_Upload_Mapping_Column__c(
				Name = 'AWD-Address',
				Mapped_From_Field__c = 'Award Address',
				Mapped_To_Field__c = 'Address_Line1__c',
				CSV_Upload_Type__c = Constant.CSV_UPLOAD_CREATE_AWARD_TYPE,
				SObject_Creator__c = Constant.CSV_SOBJECT_CREATOR_GRANT_AWARD,
				Required__c = true,
				SObject_Type__c = Constant.SOBJECT_TYPE_GRANT_AWARD
			),
			new CSV_Upload_Mapping_Column__c(
				Name = 'Recpient External Id Type',
				Mapped_From_Field__c = 'Recepient External Id',
				Mapped_To_Field__c = 'ExternalId',
				CSV_Upload_Type__c = Constant.CSV_UPLOAD_CREATE_AWARD_TYPE,
				SObject_Creator__c = Constant.CSV_SOBJECT_CREATOR_GRANT_AWARD,
				Required__c = true,
				External_Id_Type_Column__c = true,
				SObject_Type__c = Constant.SOBJECT_TYPE_GRANT_AWARD
			)
		};
		insert requiredColumns;
	}

	static CSV_Upload__c csvUpload;
	private static void initData(){
		csvUpload = new CSV_Upload__c(
			RecordTypeId = CSV_Upload__c.SObjectType.getDescribe().getRecordTypeInfosByName().get(Constant.CSV_UPLOAD_GRANT_AWARD_RT_NAME).getRecordTypeId(),
			Type__c = Constant.CSV_UPLOAD_CREATE_AWARD_TYPE
		);
	}
	@isTest()
	static void testGetRequiredMappingColumns(){
		initData();
		CSVUploadMapping mapping = new CSVUploadMapping(csvUpload);
		System.assertEquals(3, mapping.getRequiredMappingColumns().size());
	}
	@isTest()
	static void testGetColumnsMappingForSObjectType(){
		initData();
		CSVUploadMapping mapping = new CSVUploadMapping(csvUpload);
		System.assertEquals(3, mapping.getColumnsSObjectCreator(Constant.CSV_SOBJECT_CREATOR_GRANT_AWARD).size());
	}
	@isTest()
	static void testGetExternalIdTypeField(){
		initData();
		CSVUploadMapping mapping = new CSVUploadMapping(csvUpload);
		System.assertEquals(1, mapping.getExternalIdTypeField().size());
	}
	@isTest()
	static void testGetMappedFields(){
		initData();
		CSVUploadMapping mapping = new CSVUploadMapping(csvUpload);
		System.assertEquals(2, mapping.getMappedFields().size());
	}

=======
<<<<<<< HEAD
/******************************************************************************************
@Author         Hamed Izadpanah
@Date           03/10/2015
@Project        Cloud Sherpas Cabinet Office Data Source
@Description    This is the unit test for CSV Upload mapping class
*******************************************************************************************/
@isTest
private class CSVUploadMappingTest{
	@testSetup()
	private static void setupTestData(){
		List<CSV_Upload_Mapping_Column__c> requiredColumns = new List<CSV_Upload_Mapping_Column__c>{
			new CSV_Upload_Mapping_Column__c(
				Name = 'AWD-Name',
				Mapped_From_Field__c = 'Award Name',
				Mapped_To_Field__c = 'Name',
				CSV_Upload_Type__c = Constant.CSV_UPLOAD_CREATE_AWARD_TYPE,
				SObject_Creator__c = Constant.CSV_SOBJECT_CREATOR_GRANT_AWARD,
				Required__c = true,
				SObject_Type__c = Constant.SOBJECT_TYPE_GRANT_AWARD
			),
			new CSV_Upload_Mapping_Column__c(
				Name = 'AWD-Address',
				Mapped_From_Field__c = 'Award Address',
				Mapped_To_Field__c = 'Address_Line1__c',
				CSV_Upload_Type__c = Constant.CSV_UPLOAD_CREATE_AWARD_TYPE,
				SObject_Creator__c = Constant.CSV_SOBJECT_CREATOR_GRANT_AWARD,
				Required__c = true,
				SObject_Type__c = Constant.SOBJECT_TYPE_GRANT_AWARD
			),
			new CSV_Upload_Mapping_Column__c(
				Name = 'Recpient External Id Type',
				Mapped_From_Field__c = 'Recepient External Id',
				Mapped_To_Field__c = 'ExternalId',
				CSV_Upload_Type__c = Constant.CSV_UPLOAD_CREATE_AWARD_TYPE,
				SObject_Creator__c = Constant.CSV_SOBJECT_CREATOR_GRANT_AWARD,
				Required__c = true,
				External_Id_Type_Column__c = true,
				SObject_Type__c = Constant.SOBJECT_TYPE_GRANT_AWARD
			)
		};
		insert requiredColumns;
	}

	static CSV_Upload__c csvUpload;
	private static void initData(){
		csvUpload = new CSV_Upload__c(
			RecordTypeId = CSV_Upload__c.SObjectType.getDescribe().getRecordTypeInfosByName().get(Constant.CSV_UPLOAD_GRANT_AWARD_RT_NAME).getRecordTypeId(),
			Type__c = Constant.CSV_UPLOAD_CREATE_AWARD_TYPE
		);
	}
	@isTest()
	static void testGetRequiredMappingColumns(){
		initData();
		CSVUploadMapping mapping = new CSVUploadMapping(csvUpload);
		System.assertEquals(3, mapping.getRequiredMappingColumns().size());
	}
	@isTest()
	static void testGetColumnsMappingForSObjectType(){
		initData();
		CSVUploadMapping mapping = new CSVUploadMapping(csvUpload);
		System.assertEquals(3, mapping.getColumnsSObjectCreator(Constant.CSV_SOBJECT_CREATOR_GRANT_AWARD).size());
	}
	@isTest()
	static void testGetExternalIdTypeField(){
		initData();
		CSVUploadMapping mapping = new CSVUploadMapping(csvUpload);
		System.assertEquals(1, mapping.getExternalIdTypeField().size());
	}
	@isTest()
	static void testGetMappedFields(){
		initData();
		CSVUploadMapping mapping = new CSVUploadMapping(csvUpload);
		System.assertEquals(2, mapping.getMappedFields().size());
	}

=======
/******************************************************************************************
@Author         Hamed Izadpanah
@Date           03/10/2015
@Project        Cloud Sherpas Cabinet Office Data Source
@Description    This is the unit test for CSV Upload mapping class
*******************************************************************************************/
@isTest
private class CSVUploadMappingTest{
	@testSetup()
	private static void setupTestData(){
		List<CSV_Upload_Mapping_Column__c> requiredColumns = new List<CSV_Upload_Mapping_Column__c>{
			new CSV_Upload_Mapping_Column__c(
				Name = 'AWD-Name',
				Mapped_From_Field__c = 'Award Name',
				Mapped_To_Field__c = 'Name',
				CSV_Upload_Type__c = Constant.CSV_UPLOAD_CREATE_AWARD_TYPE,
				SObject_Creator__c = Constant.CSV_SOBJECT_CREATOR_GRANT_AWARD,
				Required__c = true,
				SObject_Type__c = Constant.SOBJECT_TYPE_GRANT_AWARD
			),
			new CSV_Upload_Mapping_Column__c(
				Name = 'AWD-Address',
				Mapped_From_Field__c = 'Award Address',
				Mapped_To_Field__c = 'Address_Line1__c',
				CSV_Upload_Type__c = Constant.CSV_UPLOAD_CREATE_AWARD_TYPE,
				SObject_Creator__c = Constant.CSV_SOBJECT_CREATOR_GRANT_AWARD,
				Required__c = true,
				SObject_Type__c = Constant.SOBJECT_TYPE_GRANT_AWARD
			),
			new CSV_Upload_Mapping_Column__c(
				Name = 'Recpient External Id Type',
				Mapped_From_Field__c = 'Recepient External Id',
				Mapped_To_Field__c = 'ExternalId',
				CSV_Upload_Type__c = Constant.CSV_UPLOAD_CREATE_AWARD_TYPE,
				SObject_Creator__c = Constant.CSV_SOBJECT_CREATOR_GRANT_AWARD,
				Required__c = true,
				External_Id_Type_Column__c = true,
				SObject_Type__c = Constant.SOBJECT_TYPE_GRANT_AWARD
			)
		};
		insert requiredColumns;
	}

	static CSV_Upload__c csvUpload;
	private static void initData(){
		csvUpload = new CSV_Upload__c(
			RecordTypeId = CSV_Upload__c.SObjectType.getDescribe().getRecordTypeInfosByName().get(Constant.CSV_UPLOAD_GRANT_AWARD_RT_NAME).getRecordTypeId(),
			Type__c = Constant.CSV_UPLOAD_CREATE_AWARD_TYPE
		);
	}
	@isTest()
	static void testGetRequiredMappingColumns(){
		initData();
		CSVUploadMapping mapping = new CSVUploadMapping(csvUpload);
		System.assertEquals(3, mapping.getRequiredMappingColumns().size());
	}
	@isTest()
	static void testGetColumnsMappingForSObjectType(){
		initData();
		CSVUploadMapping mapping = new CSVUploadMapping(csvUpload);
		System.assertEquals(3, mapping.getColumnsSObjectCreator(Constant.CSV_SOBJECT_CREATOR_GRANT_AWARD).size());
	}
	@isTest()
	static void testGetExternalIdTypeField(){
		initData();
		CSVUploadMapping mapping = new CSVUploadMapping(csvUpload);
		System.assertEquals(1, mapping.getExternalIdTypeField().size());
	}
	@isTest()
	static void testGetMappedFields(){
		initData();
		CSVUploadMapping mapping = new CSVUploadMapping(csvUpload);
		System.assertEquals(2, mapping.getMappedFields().size());
	}

>>>>>>> refs/remotes/origin/master
>>>>>>> branch 'master' of https://github.com/cabinetoffice/Government-Grants-Information-System-Metadata
>>>>>>> branch 'master' of https://github.com/cabinetoffice/Government-Grants-Information-System-Metadata
}