/******************************************************************************************
@Author         Hamed Izadpanah
@Date           19/02/2016
@Project        Cloud Sherpas Cabinet Office Data Source
@Description    This is the test unit for AwardPostalCodeHeatMapController
*******************************************************************************************/
@isTest
private class AwardPostalCodeHeatMapControllerTest{

	@testSetup()
    static void setupTestData(){
        TestDataFactory testFactory = new TestDataFactory();
        testFactory.insertReferenceData();
        Account department1 = testFactory.createAccount('Department1','NEW_CPID_Department1');
        department1.Primary_Address_1__c = 'Unit 1, Horse Guards Rd';
        department1.Primary_Address_2__c = 'HM Treasury';
        department1.Primary_City__c = 'London';
        department1.Primary_County__c = 'Greater London';
        department1.Primary_Country__c = 'United Kingdom';
        department1.Primary_Postal_Code__c = 'SW1A 2HQ';
        insert department1;
        User dept1SuperUser1 = testFactory.setupBasicUser(department1 ,'SuperUserContact1','Data Solution Portal - Super User');
        insert dept1SuperUser1;
        System.runAs(dept1SuperUser1){
            Grant_Scheme__c grantSchemeCreatedByDept1SuperUser1 = testFactory.createGrantScheme(
            	department1, 'Test Grant Award NonAdminRecord01', testFactory.testCOFOGLevel
            );
            insert grantSchemeCreatedByDept1SuperUser1;
            Grant_Award__c grantAwardCreatedByDept1SuperUser1 = testFactory.createGrantAward(
            	'Test Grant Award AdminRecord', department1, grantSchemeCreatedByDept1SuperUser1
            );
            grantAwardCreatedByDept1SuperUser1.Postal_Code_Geo_Location__Latitude__s = 51.503648907772100;
            grantAwardCreatedByDept1SuperUser1.Postal_Code_Geo_Location__Longitude__s = -0.126638914084856;
            grantAwardCreatedByDept1SuperUser1.Postal_Code_Region__c = 'London';
            grantAwardCreatedByDept1SuperUser1.Postal_Code_Parliamentary_Constituency__c = 'Islington North';
            grantAwardCreatedByDept1SuperUser1.Is_Postal_Code_Valid__c = true;
            grantAwardCreatedByDept1SuperUser1.Has_Postal_Code_Been_Checked__c = true;
            grantAwardCreatedByDept1SuperUser1.Total_Amount_in_funding_agreement__c = 100;
            Date startOfThisYearFY = Date.newInstance(Date.today().year(), 4, 1);
            grantAwardCreatedByDept1SuperUser1.Award_Start_Date__c = startOfThisYearFY.addMonths(-8);
            grantAwardCreatedByDept1SuperUser1.Award_End_Date__c = startOfThisYearFY.addMonths(-2);
            insert grantAwardCreatedByDept1SuperUser1;
        }
    }

	@isTest
	static void testGetAvailableRegions(){
		AwardPostalCodeHeatMapController controller = new AwardPostalCodeHeatMapController();
		controller.setNewMapCenter();
		List<SelectOption> availableRegions = controller.getAvailableRegions();
		System.assertEquals(2, availableRegions.size());
		System.assertEquals(Label.AwardPostalCodeHeatMapAllRegionsLabel, availableRegions[0].getLabel());
		System.assertEquals('', availableRegions[0].getValue());
		System.assertEquals('London', availableRegions[1].getLabel());
		System.assertEquals('London', availableRegions[1].getValue());
	}

	@isTest
	static void testGetAvailableConstituencies(){
		AwardPostalCodeHeatMapController controller = new AwardPostalCodeHeatMapController();
		List<SelectOption> availableConstituencies = controller.getAvailableConstituencies();
		System.assertEquals(2, availableConstituencies.size());
		System.assertEquals(Label.AwardPostalCodeHeatMapAllConstituenciesLabel, availableConstituencies[0].getLabel());
		System.assertEquals('', availableConstituencies[0].getValue());
		System.assertEquals('Islington North', availableConstituencies[1].getLabel());
		System.assertEquals('Islington North', availableConstituencies[1].getValue());
	}
	@isTest
	static void tetsGenerateQueryConditionsWithoutParams(){
		AwardPostalCodeHeatMapController controller = new AwardPostalCodeHeatMapController();
		controller.showActiveGrants = false;
		controller.filterGrantAward.Award_Start_Date__c = null;
		controller.filterGrantAward.Award_End_Date__c = null;
		controller.filterGrantAward.Postal_Code_Region__c = null;
		controller.filterGrantAward.Allocation_Method__c = null;
		String generatedQuery = controller.generateQueryConditions();
		System.assertEquals(false, generatedQuery.containsIgnoreCase('Award_Start_Date__c'));
		System.assertEquals(false, generatedQuery.containsIgnoreCase('Award_End_Date__c'));
		System.assertEquals(false, generatedQuery.containsIgnoreCase('Postal_Code_Region__c'));
		System.assertEquals(false, generatedQuery.containsIgnoreCase('Allocation_Method__c'));
		System.assertEquals(false, generatedQuery.containsIgnoreCase('Postal_Code_Parliamentary_Constituency__c'));
	}
	@isTest
	static void tetsGenerateQueryConditionsShowActiveGrants(){
		AwardPostalCodeHeatMapController controller = new AwardPostalCodeHeatMapController();
		controller.showActiveGrants = true;
		controller.filterGrantAward.Award_Start_Date__c = null;
		controller.filterGrantAward.Award_End_Date__c = null;
		controller.filterGrantAward.Postal_Code_Region__c = null;
		controller.filterGrantAward.Allocation_Method__c = null;
		String generatedQuery = controller.generateQueryConditions();
		System.assertEquals(true, generatedQuery.containsIgnoreCase('Award_Start_Date__c'));
		System.assertEquals(true, generatedQuery.containsIgnoreCase('Award_End_Date__c'));
	}
	@isTest
	static void tetsGenerateQueryConditionsWithStartDate(){
		AwardPostalCodeHeatMapController controller = new AwardPostalCodeHeatMapController();
		controller.showActiveGrants = false;
		controller.filterGrantAward.Award_Start_Date__c = Date.today();
		controller.filterGrantAward.Award_End_Date__c = null;
		controller.filterGrantAward.Postal_Code_Region__c = null;
		controller.filterGrantAward.Allocation_Method__c = null;
		String generatedQuery = controller.generateQueryConditions();
		System.assertEquals(true, generatedQuery.containsIgnoreCase('Award_Start_Date__c'));
		System.assertEquals(false, generatedQuery.containsIgnoreCase('Award_End_Date__c'));
	}
	@isTest
	static void tetsGenerateQueryConditionsWithEndDate(){
		AwardPostalCodeHeatMapController controller = new AwardPostalCodeHeatMapController();
		controller.showActiveGrants = false;
		controller.filterGrantAward.Award_Start_Date__c = null;
		controller.filterGrantAward.Award_End_Date__c = Date.today();
		controller.filterGrantAward.Postal_Code_Region__c = null;
		controller.filterGrantAward.Allocation_Method__c = null;
		String generatedQuery = controller.generateQueryConditions();
		System.assertEquals(false, generatedQuery.containsIgnoreCase('Award_Start_Date__c'));
		System.assertEquals(true, generatedQuery.containsIgnoreCase('Award_End_Date__c'));
	}
	@isTest
	static void tetsGenerateQueryConditionsWithRegion(){
		AwardPostalCodeHeatMapController controller = new AwardPostalCodeHeatMapController();
		controller.showActiveGrants = false;
		controller.filterGrantAward.Award_Start_Date__c = null;
		controller.filterGrantAward.Award_End_Date__c = null;
		controller.filterGrantAward.Postal_Code_Region__c = 'London';
		controller.filterGrantAward.Allocation_Method__c = null;
		String generatedQuery = controller.generateQueryConditions();
		System.assertEquals(true, generatedQuery.containsIgnoreCase('Postal_Code_Region__c'));
	}
	@isTest
	static void tetsGenerateQueryConditionsWithAwardAllocationMethod(){
		AwardPostalCodeHeatMapController controller = new AwardPostalCodeHeatMapController();
		controller.showActiveGrants = false;
		controller.filterGrantAward.Award_Start_Date__c = null;
		controller.filterGrantAward.Award_End_Date__c = null;
		controller.filterGrantAward.Postal_Code_Region__c = null;
		controller.filterGrantAward.Allocation_Method__c = 'Formula';
		String generatedQuery = controller.generateQueryConditions();
		System.assertEquals(true, generatedQuery.containsIgnoreCase('Allocation_Method__c'));
	}
	@isTest
	static void tetsGenerateQueryConditionsWithAwardConstituency(){
		AwardPostalCodeHeatMapController controller = new AwardPostalCodeHeatMapController();
		controller.showActiveGrants = false;
		controller.filterGrantAward.Award_Start_Date__c = null;
		controller.filterGrantAward.Award_End_Date__c = null;
		controller.filterGrantAward.Postal_Code_Region__c = null;
		controller.filterGrantAward.Allocation_Method__c = null;
		controller.filterGrantAward.Postal_Code_Parliamentary_Constituency__c = 'Bath';
		String generatedQuery = controller.generateQueryConditions();
		System.assertEquals(true, generatedQuery.containsIgnoreCase('Postal_Code_Parliamentary_Constituency__c'));
	}
	@isTest
	static void testGetHeatMapPoints(){
		AwardPostalCodeHeatMapController controller = new AwardPostalCodeHeatMapController();
		controller.showActiveGrants = false;
		controller.filterGrantAward.Award_Start_Date__c = null;
		controller.filterGrantAward.Award_End_Date__c = null;
		controller.filterGrantAward.Postal_Code_Region__c = 'London';
		controller.filterGrantAward.Allocation_Method__c = null;
		String heatMapPointsJSON = controller.getHeatMapPoints();
		String HEAT_MAP_JSON_RESPONSE = '[';
		HEAT_MAP_JSON_RESPONSE += 'new google.maps.LatLng(51.503648907772100,-0.126638914084856),';
		HEAT_MAP_JSON_RESPONSE += ']';
		System.assertEquals(HEAT_MAP_JSON_RESPONSE, heatMapPointsJSON);
	}
	@isTest
	static void testGetHeatMapPointsWithInvalidQuery(){
		AwardPostalCodeHeatMapController controller = new AwardPostalCodeHeatMapController();
		controller.showActiveGrants = false;
		controller.filterGrantAward.Award_Start_Date__c = null;
		controller.filterGrantAward.Award_End_Date__c = null;
		controller.filterGrantAward.Postal_Code_Region__c = 'London';
		controller.filterGrantAward.Allocation_Method__c = null;
		AwardPostalCodeHeatMapController.HEAT_MAP_BASE_QUERY_STRING += ' AND INVALID_FIELD = false'; 
		System.assertEquals(0, ApexPages.getMessages().size());
		String heatMapPointsJSON = controller.getHeatMapPoints();
		System.assertEquals(1, ApexPages.getMessages().size());
		System.assertEquals(ApexPages.Severity.ERROR, ApexPages.getMessages()[0].getSeverity());
		System.assertEquals(true, ApexPages.getMessages()[0].getDetail().containsIgnoreCase('No such column \'INVALID_FIELD\' on entity \'Grant_Award__c\''));
	}

	@isTest
	static void testGetLocationBasedSummary(){
		AwardPostalCodeHeatMapController controller = new AwardPostalCodeHeatMapController();
		controller.showActiveGrants = false;
		controller.filterGrantAward.Award_Start_Date__c = null;
		controller.filterGrantAward.Award_End_Date__c = null;
		controller.filterGrantAward.Postal_Code_Region__c = 'London';
		controller.filterGrantAward.Allocation_Method__c = null;
		controller.mapCurrentZoomRadius = 100;
		controller.mapCurrentCenterLat = 51.503648907772100;
		controller.mapCurrentCenterLong = -0.126638914084856;
		AggregateResult locationSummaryAgg = controller.getLocationBasedSummary();
		System.assertEquals(100, (Decimal) locationSummaryAgg.get('awardsAmount'));
		System.assertEquals(1, (Integer) locationSummaryAgg.get('awardsCount'));
	}
	@isTest
	static void testGetAllRegionTotalAmounts(){
		AwardPostalCodeHeatMapController controller = new AwardPostalCodeHeatMapController();
		controller.showActiveGrants = false;
		controller.filterGrantAward.Award_Start_Date__c = null;
		controller.filterGrantAward.Award_End_Date__c = null;
		controller.filterGrantAward.Postal_Code_Region__c = null;
		controller.filterGrantAward.Allocation_Method__c = null;
		controller.mapCurrentZoomRadius = 100;
		controller.mapCurrentCenterLat = 51.503648907772100;
		controller.mapCurrentCenterLong = -0.126638914084856;
		List<AggregateResult> locationSummaryAggs = controller.getAllRegionTotalAmounts();
		System.assertEquals(1, locationSummaryAggs.size());
		System.assertEquals('London', (String) locationSummaryAggs[0].get('Postal_Code_Region__c'));
		System.assertEquals(100, (Decimal) locationSummaryAggs[0].get('awardsAmount'));
	}

	@isTest
	static void testGetAllRegionTotalSchemeFunder(){
		Id accountId = [
			SELECT Id  
			FROM Account
		].Id;
		AwardPostalCodeHeatMapController controller = new AwardPostalCodeHeatMapController();
		controller.showActiveGrants = false;
		controller.filterGrantScheme.Funder__c = accountId;
		controller.mapCurrentZoomRadius = 100;
		controller.mapCurrentCenterLat = 51.503648907772100;
		controller.mapCurrentCenterLong = -0.126638914084856;
		List<AggregateResult> locationSummaryAggs = controller.getAllRegionTotalAmounts();
		System.assertEquals(1, locationSummaryAggs.size());
		System.assertEquals('London', (String) locationSummaryAggs[0].get('Postal_Code_Region__c'));
		System.assertEquals(100, (Decimal) locationSummaryAggs[0].get('awardsAmount'));
	}

	@isTest
	static void testGetAllRegionTotalSchemePrimaryPurpose(){
		AwardPostalCodeHeatMapController controller = new AwardPostalCodeHeatMapController();
		controller.showActiveGrants = false;
		controller.filterGrantScheme.Primary_Purpose__c = 'Supporting delivery of a public service';
		controller.mapCurrentZoomRadius = 100;
		controller.mapCurrentCenterLat = 51.503648907772100;
		controller.mapCurrentCenterLong = -0.126638914084856;
		List<AggregateResult> locationSummaryAggs = controller.getAllRegionTotalAmounts();
		System.assertEquals(1, locationSummaryAggs.size());
		System.assertEquals('London', (String) locationSummaryAggs[0].get('Postal_Code_Region__c'));
		System.assertEquals(100, (Decimal) locationSummaryAggs[0].get('awardsAmount'));
	}

	@isTest
	static void testGetAllRegionTotalSchemeRecipientSector(){
		AwardPostalCodeHeatMapController controller = new AwardPostalCodeHeatMapController();
		controller.showActiveGrants = false;
		controller.filterGrantScheme.Recipient_Sector__c = 'Local Government';
		controller.mapCurrentZoomRadius = 100;
		controller.mapCurrentCenterLat = 51.503648907772100;
		controller.mapCurrentCenterLong = -0.126638914084856;
		List<AggregateResult> locationSummaryAggs = controller.getAllRegionTotalAmounts();
		System.assertEquals(1, locationSummaryAggs.size());
		System.assertEquals('London', (String) locationSummaryAggs[0].get('Postal_Code_Region__c'));
		System.assertEquals(100, (Decimal) locationSummaryAggs[0].get('awardsAmount'));
	}
}