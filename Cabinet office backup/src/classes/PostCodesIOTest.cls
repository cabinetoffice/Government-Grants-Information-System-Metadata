/******************************************************************************************
@Author         Hamed Izadpanah
@Date           18/02/2015
@Project        Cloud Sherpas Cabinet Office Data Source
@Description    This is the test unit for PostCodesIO class
*******************************************************************************************/
@isTest
private class PostCodesIOTest{

	@isTest
	static void testCheckInvalidPostCode(){
		PostCodesIO.ResponseWrapper responseWrapper = new PostCodesIO.ResponseWrapper();
		responseWrapper.status = 404;

		BasicHttpCalloutMock calloutMock = new BasicHttpCalloutMock(
			200,
			'OK',
			JSON.serializePretty(responseWrapper),
			new Map<String, String>()
		);
		Test.setMock(HttpCalloutMock.class, calloutMock);
		PostCodesIO postCodesIOInstance = new PostCodesIO();
		try{
			PostCodesIO.PostCodeResult calloutResult = postCodesIOInstance.retrievePostCodeDetails('N19 5NL');
			System.assert(false, 'This line should never execute');
		} catch (PostCodesIO.PostCodeNotFoundException invalidPostCodeException){
			System.assertEquals(Label.Invalid_Postal_Code_Error_Message, invalidPostCodeException.getMessage());
		}
		
	}

	@isTest
	static void testCheckValidPostCode(){
		PostCodesIO.PostCodeResult mockResult = PostCodesIO.generateMockResult();
		PostCodesIO.ResponseWrapper responseWrapper = new PostCodesIO.ResponseWrapper();
		responseWrapper.status = 200;
		responseWrapper.result = mockResult;

		BasicHttpCalloutMock calloutMock = new BasicHttpCalloutMock(
			200,
			'OK',
			JSON.serializePretty(responseWrapper),
			new Map<String, String>()
		);
		Test.setMock(HttpCalloutMock.class, calloutMock);

		PostCodesIO postCodesIOInstance = new PostCodesIO();
		PostCodesIO.PostCodeResult calloutResult = postCodesIOInstance.retrievePostCodeDetails('N19 5NL');
		System.assertEquals('SW1A 2HQ', calloutResult.postcode);
		System.assertEquals(1, calloutResult.quality);
		System.assertEquals(529096, calloutResult.eastings);
		System.assertEquals(187084, calloutResult.northings);
		System.assertEquals('England', calloutResult.country);
		System.assertEquals('London', calloutResult.nhs_ha);
		System.assertEquals(-0.138776253708989, calloutResult.longitude);
		System.assertEquals(51.567859622079, calloutResult.latitude);
		System.assertEquals('Islington North', calloutResult.parliamentary_constituency);
		System.assertEquals('London', calloutResult.european_electoral_region);
		System.assertEquals('Islington', calloutResult.primary_care_trust);
		System.assertEquals('London', calloutResult.region);
		System.assertEquals('Islington 004B', calloutResult.lsoa);
		System.assertEquals('Islington 004', calloutResult.msoa);
		System.assertEquals('5NL', calloutResult.incode);
		System.assertEquals('N19', calloutResult.outcode);
		System.assertEquals('Islington', calloutResult.admin_district);
		System.assertEquals('Islington, unparished area', calloutResult.parish);
		System.assertEquals(null, calloutResult.admin_county);
		System.assertEquals('Junction', calloutResult.admin_ward);
		System.assertEquals('NHS Islington', calloutResult.ccg);
		System.assertEquals('Haringey and Islington', calloutResult.nuts);
	}
}