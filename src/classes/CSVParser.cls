/******************************************************************************************
@Author         Hamed Izadpanah
@Date           28/09/2015
@Project        Cloud Sherpas Cabinet Office Data Source
@Description    This class parses a String value to a strucured CSVDocument object
*******************************************************************************************/
public with sharing class CSVParser {

	private static final String WINDOWS_ROW_SEPERATOR = '\r\n';
	private static final String STANDARD_ROW_SEPERATOR = '\n';
	private static final String MAC_ROW_SEPERATOR = '\r';
	private static final String COMMA_COLUMN_SEPERATOR = ',';
	private static final String DBLQT_CHRCT = '"';

	public CSVDocument parse(Blob csvBlobValue) {
		return parse(convertBlobToString(csvBlobValue, 'ISO-8859-1'));
	}

	public String convertBlobToString(Blob input, String inCharset){
	    String hex = EncodingUtil.convertToHex(input);
	    System.assertEquals(0, hex.length() & 1);
	    final Integer bytesCount = hex.length() >> 1;
	    String[] bytes = new String[bytesCount];
	    for(Integer i = 0; i < bytesCount; ++i){
	        bytes[i] =  hex.mid(i << 1, 2);
	    }
	    return EncodingUtil.urlDecode('%' + String.join(bytes, '%'), inCharset);
	}

	public CSVDocument parse(String csvStringToParse) {
		List<List<String>> allRows = new List<List<String>>();
		String rowSeperator;
		if(csvStringToParse.contains(WINDOWS_ROW_SEPERATOR)){
			rowSeperator = WINDOWS_ROW_SEPERATOR;
		} else if(csvStringToParse.contains(STANDARD_ROW_SEPERATOR)){
			rowSeperator = STANDARD_ROW_SEPERATOR;
		} else {
			rowSeperator = MAC_ROW_SEPERATOR;
		}
		List<String> parsedRows = parseStringToStringList(csvStringToParse, rowSeperator);
		for(String csvRow : parsedRows){
			List<String> parsedColumns = parseStringToStringList(csvRow, COMMA_COLUMN_SEPERATOR);
			if(!parsedColumns.isEmpty()){
				allRows.add(parsedColumns);
			}

		}
		return new CSVDocument(allRows);
	}

	private List<String> parseStringToStringList(String stringToParse, String separator){
		List<String> returnValue = new List<String>();
		List<String> parsedFields;
		try {
			StringWrapper stringWrapperToUse = new StringWrapper(stringToParse);
			parsedFields = stringWrapperToUse.split(separator);
		} catch (System.ListException exceptionToHandle) {
			throw new ColumnExceedException(exceptionToHandle.getMessage());
		}
		String compositeField;
		Boolean makeCompositeField = false;
		for(Integer i = 0; i < parsedFields.size(); i++) {
			String parsedField = parsedFields[i];
			if (!makeCompositeField && parsedField.startsWith(DBLQT_CHRCT) && parsedField.endsWith(DBLQT_CHRCT)) {
				returnValue.add(clearSurroundingDBLQTs(parsedField));
			} else if(parsedField.contains(DBLQT_CHRCT) && Math.mod(parsedField.countMatches(DBLQT_CHRCT), 2) == 0){
				returnValue.add(clearSurroundingDBLQTs(parsedField));
			} else if (!makeCompositeField && parsedField.startsWith(DBLQT_CHRCT)) {
				makeCompositeField = true;
				compositeField = parsedField;
			} else if (parsedField.endsWith(DBLQT_CHRCT)) {
				compositeField += separator + parsedField;
				returnValue.add(clearSurroundingDBLQTs(compositeField));
				makeCompositeField = false;
			} else if (makeCompositeField) {
				Boolean isThisLastFieldToCheckInTheList = i + 1 == parsedFields.size();
				compositeField +=  separator + parsedField;
				if(isThisLastFieldToCheckInTheList){
					returnValue.add(clearSurroundingDBLQTs(compositeField));
				}
			} else {
				returnValue.add(clearSurroundingDBLQTs(parsedField));
			}
		}
		Boolean rowHasValue = false;
		for(String fieldValueToCheck : returnValue){
			if(String.isNotBlank(fieldValueToCheck)){
				rowHasValue = true;
				break;
			}
		}
		return rowHasValue ? returnValue : new List<String>();
	}

	private String clearSurroundingDBLQTs(String valueToFix){
		if(valueToFix.startsWith(DBLQT_CHRCT) && valueToFix.endsWith(DBLQT_CHRCT)){
			valueToFix = valueToFix.replaceAll('DBLQT', '').replaceAll(DBLQT_CHRCT, '');
		}
		return valueToFix;
	}

	public class RowExceedException extends Exception{}
	public class ColumnExceedException extends Exception{}
}