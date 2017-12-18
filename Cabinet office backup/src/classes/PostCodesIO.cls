/******************************************************************************************
@Author         Hamed Izadpanah
@Date           18/02/2016
@Project        Cloud Sherpas Cabinet Office Data Source
@Description    This object provide connectivity between Salesforce and PostCodesIO webservice
*******************************************************************************************/
public with sharing class PostCodesIO {
	public PostCodeResult retrievePostCodeDetails(String postCodetoValidate){
		HttpRequest request = new HttpRequest();
		String trimmedPostCode = String.isNotBlank(postCodetoValidate) ? postCodetoValidate.replaceAll(' ', '') : '';
		request.setEndpoint(Label.PostCodesIO_Base_URL + '/postcodes/' + trimmedPostCode);
		request.setMethod('GET');
		Http httpChannel = new Http();
		HttpResponse response = httpChannel.send(request);
		ResponseWrapper postcodesioResponse = (ResponseWrapper) JSON.deserialize(
			response.getBody(), ResponseWrapper.class
		);
		if(postcodesioResponse.status != 200){
			throw new PostCodeNotFoundException(Label.Invalid_Postal_Code_Error_Message);
		}
		return postcodesioResponse.result;
	}

	public class ResponseWrapper{
		public Integer status;
		public String error;
		public PostCodeResult result;
	}
	public class PostCodeResult{
		public String postcode;
		public Integer quality;
		public Integer eastings;
		public Integer northings;
		public String country;
		public String nhs_ha;
		public Decimal longitude;
		public Decimal latitude;
		public String parliamentary_constituency;
		public String european_electoral_region;
		public String primary_care_trust;
		public String region;
		public String lsoa;
		public String msoa;
		public String incode;
		public String outcode;
		public String admin_district;
		public String parish;
		public String admin_county;
		public String admin_ward;
		public String ccg;
		public String nuts;
	}

	public class PostCodeNotFoundException extends Exception{}

	public static PostCodeResult generateMockResult(){
		PostCodesIO.PostCodeResult mockResult = new PostCodesIO.PostCodeResult();
		mockResult.postcode = 'SW1A 2HQ';
		mockResult.quality = 1;
		mockResult.eastings = 529096;
		mockResult.northings = 187084;
		mockResult.country = 'England';
		mockResult.nhs_ha = 'London';
		mockResult.longitude = -0.138776253708989;
		mockResult.latitude = 51.567859622079;
		mockResult.parliamentary_constituency = 'Islington North';
		mockResult.european_electoral_region = 'London';
		mockResult.primary_care_trust = 'Islington';
		mockResult.region = 'London';
		mockResult.lsoa = 'Islington 004B';
		mockResult.msoa = 'Islington 004';
		mockResult.incode = '5NL';
		mockResult.outcode = 'N19';
		mockResult.admin_district = 'Islington';
		mockResult.parish = 'Islington, unparished area';
		mockResult.admin_county = null;
		mockResult.admin_ward = 'Junction';
		mockResult.ccg = 'NHS Islington';
		mockResult.nuts = 'Haringey and Islington';
		return mockResult;
	}
}