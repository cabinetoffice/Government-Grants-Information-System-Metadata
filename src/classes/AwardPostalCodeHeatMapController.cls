/******************************************************************************************
@Author         Hamed Izadpanah
@Date           19/02/2016
@Project        Cloud Sherpas Cabinet Office Data Source
@Description    This is the controller for Grant Awards HeatMap functionality
*******************************************************************************************/
public with sharing class AwardPostalCodeHeatMapController {

	@testVisible
	private static String HEAT_MAP_BASE_QUERY_STRING;
	static {
		HEAT_MAP_BASE_QUERY_STRING = 'SELECT Postal_Code_Geo_Location__Latitude__s,';
		HEAT_MAP_BASE_QUERY_STRING += ' Postal_Code_Geo_Location__Longitude__s';
		HEAT_MAP_BASE_QUERY_STRING += ' FROM Grant_Award__c';
		HEAT_MAP_BASE_QUERY_STRING += ' WHERE Is_Postal_Code_Valid__c = true';
		HEAT_MAP_BASE_QUERY_STRING += ' AND Has_Postal_Code_Been_Checked__c = true';
	}

	public Grant_Award__c filterGrantAward {get; private set;}
	public Grant_Scheme__c filterGrantScheme {get; private set;}

	public Decimal mapCurrentZoomRadius {get; set;}
	public Decimal mapCurrentCenterLat {get; set;}
	public Decimal mapCurrentCenterLong {get; set;}

	public Boolean showActiveGrants {get; set;}
	public AwardPostalCodeHeatMapController() {
		mapCurrentZoomRadius = 100;
		mapCurrentCenterLat = 51.50722;
		mapCurrentCenterLong = -0.12750;
		Date startOfThisYearFY = Date.newInstance(Date.today().year(), 4, 1);
		filterGrantAward = new Grant_Award__c(
			Award_Start_Date__c = startOfThisYearFY.addYears(-1),
			Award_End_Date__c = null
		);
		showActiveGrants = true;
		filterGrantScheme = new Grant_Scheme__c();
	}
	private transient Integer foundRecordsCount = null;
	public void checkHeatMapQueryLimit(){
		if(foundRecordsCount == null){
			String queryString = 'SELECT COUNT() FROM Grant_Award__c WHERE Is_Postal_Code_Valid__c = true';
			queryString += ' AND Has_Postal_Code_Been_Checked__c = true';
			queryString += generateQueryConditions();
			foundRecordsCount = Database.countQuery(queryString);
		}
		if(foundRecordsCount > 1000000){
			throw new QueryLimitReachedException(Label.Heatmap_Query_Reached_Limit_Error_Message + ' : ' + String.valueOf(foundRecordsCount));
		}
	}

	public List<SelectOption> getAvailableRegions(){
		List<SelectOption> availableRegionOptions = new List<SelectOption>{
			new SelectOption('', Label.AwardPostalCodeHeatMapAllRegionsLabel)
		};
		List<String> availableRegions = new List<String>();
		for(AggregateResult availableRegion : [
			SELECT Postal_Code_Region__c
			FROM Grant_Award__c
			WHERE Postal_Code_Region__c != null
			GROUP BY Postal_Code_Region__c
		]){
			String foundRegion = (String) availableRegion.get('Postal_Code_Region__c');
			if(String.isNotBlank(foundRegion)){
				availableRegions.add(foundRegion);
			}
		}
		availableRegions.sort();
		for(String availableRegion : availableRegions){
			availableRegionOptions.add(new SelectOption(availableRegion, availableRegion));
		}
		return availableRegionOptions;
	}
	public List<SelectOption> getAvailableConstituencies(){
		List<SelectOption> availableRegionOptions = new List<SelectOption>{
			new SelectOption('', Label.AwardPostalCodeHeatMapAllConstituenciesLabel)
		};
		List<String> availableRegions = new List<String>();
		for(AggregateResult availableRegion : [
			SELECT Postal_Code_Parliamentary_Constituency__c
			FROM Grant_Award__c
			WHERE Postal_Code_Parliamentary_Constituency__c != null
			GROUP BY Postal_Code_Parliamentary_Constituency__c
		]){
			String foundRegion = (String) availableRegion.get('Postal_Code_Parliamentary_Constituency__c');
			if(String.isNotBlank(foundRegion)){
				availableRegions.add(foundRegion);
			}
		}
		availableRegions.sort();
		for(String availableRegion : availableRegions){
			availableRegionOptions.add(new SelectOption(availableRegion, availableRegion));
		}
		return availableRegionOptions;
	}

	public String generateQueryConditions(){
		String generatedConditions = '';
		if(showActiveGrants){
			generatedConditions += ' AND Award_Start_Date__c <= ' + String.valueOf(Date.today());
			generatedConditions += ' AND (';
			generatedConditions += ' Award_End_Date__c = null';
			generatedConditions += ' OR Award_End_Date__c >= ' + String.valueOf(Date.today());
			generatedConditions += ')';
		}
		if(!showActiveGrants && filterGrantAward.Award_Start_Date__c != null){
			generatedConditions += ' AND Award_Start_Date__c >= ' + String.valueOf(filterGrantAward.Award_Start_Date__c);
		}
		if(!showActiveGrants && filterGrantAward.Award_End_Date__c != null){
			generatedConditions += ' AND Award_End_Date__c <= ' + String.valueOf(filterGrantAward.Award_End_Date__c);
		}
		if(String.isNotBlank(filterGrantAward.Postal_Code_Region__c)){
			generatedConditions += ' AND Postal_Code_Region__c = \'' + filterGrantAward.Postal_Code_Region__c + '\'';
		}
		if(String.isNotBlank(filterGrantAward.Allocation_Method__c)){
			generatedConditions += ' AND Allocation_Method__c = \'' + filterGrantAward.Allocation_Method__c + '\'';
		}
		if(String.isNotBlank(filterGrantAward.Postal_Code_Parliamentary_Constituency__c)){
			generatedConditions += ' AND Postal_Code_Parliamentary_Constituency__c = \'' + filterGrantAward.Postal_Code_Parliamentary_Constituency__c + '\'';
		}
		if(String.isNotBlank(filterGrantScheme.Funder__c)){
			generatedConditions += ' AND Grant_Scheme__r.Funder__c = \'' + filterGrantScheme.Funder__c + '\'';
		}
		if(String.isNotBlank(filterGrantScheme.Primary_Purpose__c)){
			generatedConditions += ' AND Grant_Scheme__r.Primary_Purpose__c = \'' + filterGrantScheme.Primary_Purpose__c + '\'';
		}
		if(String.isNotBlank(filterGrantScheme.Recipient_Sector__c)){
			generatedConditions += ' AND Grant_Scheme__r.Recipient_Sector__c = \'' + filterGrantScheme.Recipient_Sector__c + '\'';
		}
		return generatedConditions;
	}

	public void setNewMapCenter(){
	}

	public List<Grant_Award__c> queryGrantAwards(){
		List<Grant_Award__c> foundGrantAwards = new List<Grant_Award__c>();
		String generatedQueryString = HEAT_MAP_BASE_QUERY_STRING + generateQueryConditions();
		try{
			checkHeatMapQueryLimit();
			foundGrantAwards = Database.query(generatedQueryString);
		}catch(Exception exceptionToHandle){
			ApexPages.addMessages(exceptionToHandle);
		}
		return foundGrantAwards;
	}

	public String getHeatMapPoints(){
		String returnValue = '[';
		for(Grant_Award__c grantAwardToAdd : queryGrantAwards()){
			returnValue += 'new google.maps.LatLng(' + grantAwardToAdd.Postal_Code_Geo_Location__Latitude__s + ',' + grantAwardToAdd.Postal_Code_Geo_Location__Longitude__s + '),';
		}
		returnValue += ']';
		return returnValue;
	}

	public AggregateResult getLocationBasedSummary(){
		AggregateResult returnValue;
		String queryString = 'SELECT SUM(Total_Amount_in_funding_agreement__c) awardsAmount, COUNT(Id) awardsCount';
		queryString += ' FROM Grant_Award__c';
		queryString += ' WHERE DISTANCE(Postal_Code_Geo_Location__c, GEOLOCATION(:mapCurrentCenterLat, :mapCurrentCenterLong), \'mi\') < :mapCurrentZoomRadius';
		queryString += generateQueryConditions();
		try{
			checkHeatMapQueryLimit();
			returnValue = Database.query(queryString);
		} catch (Exception exceptionToHandle){
			ApexPages.addMessages(exceptionToHandle);
		}
		return returnValue;
	}

	public List<AggregateResult> getAllRegionTotalAmounts(){
		List<AggregateResult> returnValue;
		String queryString = 'SELECT Postal_Code_Region__c, SUM(Total_Amount_in_funding_agreement__c) awardsAmount';
		queryString += ' FROM Grant_Award__c';
		queryString += ' WHERE DISTANCE(Postal_Code_Geo_Location__c, GEOLOCATION(:mapCurrentCenterLat, :mapCurrentCenterLong), \'mi\') < :mapCurrentZoomRadius';
		queryString += generateQueryConditions();
		queryString += ' GROUP BY Postal_Code_Region__c';
		queryString += ' ORDER BY Postal_Code_Region__c';
		try{
			checkHeatMapQueryLimit();
			returnValue = Database.query(queryString);
		} catch (Exception exceptionToHandle){
			ApexPages.addMessages(exceptionToHandle);
		}
		return returnValue;
	}

	public class QueryLimitReachedException extends Exception{}

}