/******************************************************************************************
@Author         Hamed Izadpanah
@Date           28/09/2015
@Project        Cloud Sherpas Cabinet Office Data Source
@Description    This class test parsing a String value to CSVDocument format
*******************************************************************************************/
@isTest
private class CSVParserTest {
	@isTest()
	static void testParseStandardDocument(){
		String csvString = 'HeaderField1,HeaderField2,HeaderField3\n';
		csvString += 'Row1Field1,Row1Field2,Row1Field3\n';
		csvString += 'Row2Field1,Row2Field2,Row2Field3';
		CSVParser parser = new CSVParser();
		CSVDocument document = parser.parse(csvString);
		System.assertEquals(2, document.allRows.size());
		System.assertEquals(3, document.columnNames.size());
		System.assertEquals('HeaderField1', document.columnNames[0]);
		System.assertEquals('HeaderField2', document.columnNames[1]);
		System.assertEquals('HeaderField3', document.columnNames[2]);
		System.assertEquals(3, document.allRows[0].columnValues.size());
		System.assertEquals('Row1Field1', document.allRows[0].columnValues[0]);
		System.assertEquals('Row1Field2', document.allRows[0].columnValues[1]);
		System.assertEquals('Row1Field3', document.allRows[0].columnValues[2]);
		System.assertEquals(3, document.allRows[1].columnValues.size());
		System.assertEquals('Row2Field1', document.allRows[1].columnValues[0]);
		System.assertEquals('Row2Field2', document.allRows[1].columnValues[1]);
		System.assertEquals('Row2Field3', document.allRows[1].columnValues[2]);
	}
	@isTest()
	static void testParseStandardDocumentFromBlob(){
		String csvString = 'HeaderField1,HeaderField2,HeaderField3\n';
		csvString += 'Row1Field1,Row1Field2,Row1Field3\n';
		csvString += 'Row2Field1,Row2Field2,Row2Field3';
		CSVParser parser = new CSVParser();
		CSVDocument document = parser.parse(Blob.valueOf(csvString));
		System.assertEquals(2, document.allRows.size());
		System.assertEquals(3, document.columnNames.size());
		System.assertEquals('HeaderField1', document.columnNames[0]);
		System.assertEquals('HeaderField2', document.columnNames[1]);
		System.assertEquals('HeaderField3', document.columnNames[2]);
		System.assertEquals(3, document.allRows[0].columnValues.size());
		System.assertEquals('Row1Field1', document.allRows[0].columnValues[0]);
		System.assertEquals('Row1Field2', document.allRows[0].columnValues[1]);
		System.assertEquals('Row1Field3', document.allRows[0].columnValues[2]);
		System.assertEquals(3, document.allRows[1].columnValues.size());
		System.assertEquals('Row2Field1', document.allRows[1].columnValues[0]);
		System.assertEquals('Row2Field2', document.allRows[1].columnValues[1]);
		System.assertEquals('Row2Field3', document.allRows[1].columnValues[2]);
	}
	@isTest()
	static void testParseDocumentWithDBLQTWindows(){
		String csvString = 'HeaderField1,HeaderField2,HeaderField3\n';
		csvString += '"Row1Field1",Row1Field2,Row1Field3';
		CSVParser parser = new CSVParser();
		CSVDocument document = parser.parse(csvString);
		System.assertEquals(1, document.allRows.size());
		System.assertEquals(3, document.columnNames.size());
		System.assertEquals('HeaderField1', document.columnNames[0]);
		System.assertEquals('HeaderField2', document.columnNames[1]);
		System.assertEquals('HeaderField3', document.columnNames[2]);
		System.assertEquals(3, document.allRows[0].columnValues.size());
		System.assertEquals('Row1Field1', document.allRows[0].columnValues[0]);
		System.assertEquals('Row1Field2', document.allRows[0].columnValues[1]);
		System.assertEquals('Row1Field3', document.allRows[0].columnValues[2]);
	}
	@isTest()
	static void testParseDocumentWithDBLQTMac(){
		String csvString = 'HeaderField1,HeaderField2,HeaderField3\r';
		csvString += '"Row1Field1",Row1Field2,Row1Field3';
		CSVParser parser = new CSVParser();
		CSVDocument document = parser.parse(csvString);
		System.assertEquals(1, document.allRows.size());
		System.assertEquals(3, document.columnNames.size());
		System.assertEquals('HeaderField1', document.columnNames[0]);
		System.assertEquals('HeaderField2', document.columnNames[1]);
		System.assertEquals('HeaderField3', document.columnNames[2]);
		System.assertEquals(3, document.allRows[0].columnValues.size());
		System.assertEquals('Row1Field1', document.allRows[0].columnValues[0]);
		System.assertEquals('Row1Field2', document.allRows[0].columnValues[1]);
		System.assertEquals('Row1Field3', document.allRows[0].columnValues[2]);
	}
	@isTest()
	static void testParseDocumentWithDBLQTWithComma(){
		String csvString = 'HeaderField1,HeaderField2,HeaderField3\n';
		csvString += '"Row1,Field1",Row1Field2,Row1Field3';
		CSVParser parser = new CSVParser();
		CSVDocument document = parser.parse(csvString);
		System.assertEquals(1, document.allRows.size());
		System.assertEquals(3, document.columnNames.size());
		System.assertEquals('HeaderField1', document.columnNames[0]);
		System.assertEquals('HeaderField2', document.columnNames[1]);
		System.assertEquals('HeaderField3', document.columnNames[2]);
		System.assertEquals(3, document.allRows[0].columnValues.size());
		System.assertEquals('Row1,Field1', document.allRows[0].columnValues[0]);
		System.assertEquals('Row1Field2', document.allRows[0].columnValues[1]);
		System.assertEquals('Row1Field3', document.allRows[0].columnValues[2]);
	}
	@isTest()
	static void testParseDocumentWithDBLQTAndReturnKeyGeneric(){
		String csvString = 'HeaderField1,HeaderField2,HeaderField3\n';
		csvString += '"Row1,Field1,\nValue",Row1Field2,Row1Field3';
		CSVParser parser = new CSVParser();
		CSVDocument document = parser.parse(csvString);
		System.assertEquals(1, document.allRows.size());
		System.assertEquals(3, document.columnNames.size());
		System.assertEquals('HeaderField1', document.columnNames[0]);
		System.assertEquals('HeaderField2', document.columnNames[1]);
		System.assertEquals('HeaderField3', document.columnNames[2]);
		System.assertEquals(3, document.allRows[0].columnValues.size());
		System.assertEquals('Row1,Field1,\nValue', document.allRows[0].columnValues[0]);
		System.assertEquals('Row1Field2', document.allRows[0].columnValues[1]);
		System.assertEquals('Row1Field3', document.allRows[0].columnValues[2]);
	}
	@isTest()
	static void testParseDocumentWithDBLQTAndReturnKeyWindows(){
		String csvString = 'HeaderField1,HeaderField2,HeaderField3\r\n';
		csvString += '"Row1,Field1\r\n,Value",Row1Field2,Row1Field3';
		CSVParser parser = new CSVParser();
		CSVDocument document = parser.parse(csvString);
		System.assertEquals(1, document.allRows.size());
		System.assertEquals(3, document.columnNames.size());
		System.assertEquals('HeaderField1', document.columnNames[0]);
		System.assertEquals('HeaderField2', document.columnNames[1]);
		System.assertEquals('HeaderField3', document.columnNames[2]);
		System.assertEquals(3, document.allRows[0].columnValues.size());
		System.assertEquals('Row1,Field1\r\n,Value', document.allRows[0].columnValues[0]);
		System.assertEquals('Row1Field2', document.allRows[0].columnValues[1]);
		System.assertEquals('Row1Field3', document.allRows[0].columnValues[2]);
	}
	@isTest()
	static void testParseDocumentWithDBLQTAndReturnKeyMac(){
		String csvString = 'HeaderField1,HeaderField2,HeaderField3\r\n';
		csvString += '"Row1,Field1\r,Value,",Row1Field2,Row1Field3';
		CSVParser parser = new CSVParser();
		CSVDocument document = parser.parse(csvString);
		System.assertEquals(1, document.allRows.size());
		System.assertEquals(3, document.columnNames.size());
		System.assertEquals('HeaderField1', document.columnNames[0]);
		System.assertEquals('HeaderField2', document.columnNames[1]);
		System.assertEquals('HeaderField3', document.columnNames[2]);
		System.assertEquals(3, document.allRows[0].columnValues.size());
		System.assertEquals('Row1,Field1\r,Value,', document.allRows[0].columnValues[0]);
		System.assertEquals('Row1Field2', document.allRows[0].columnValues[1]);
		System.assertEquals('Row1Field3', document.allRows[0].columnValues[2]);
	}
	@isTest()
	static void testParseDocumentWithEmptyRow(){
		String csvString = 'HeaderField1,HeaderField2,HeaderField3\n';
		csvString += ',,\n';
		CSVParser parser = new CSVParser();
		CSVDocument document = parser.parse(csvString);
		System.assertEquals(0, document.allRows.size());
		System.assertEquals(3, document.columnNames.size());
		System.assertEquals('HeaderField1', document.columnNames[0]);
		System.assertEquals('HeaderField2', document.columnNames[1]);
		System.assertEquals('HeaderField3', document.columnNames[2]);
	}
}