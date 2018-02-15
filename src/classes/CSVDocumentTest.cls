<<<<<<< HEAD
/******************************************************************************************
@Author         Hamed Izadpanah
@Date           28/09/2015
@Project        Cloud Sherpas Cabinet Office Data Source
@Description    This is the test unit for CSVDocument object
*******************************************************************************************/
@isTest
private class CSVDocumentTest{

	@isTest
	static void testDocumentInitiation(){
		List<List<String>> allCSVRows = new List<List<String>>{
			new List<String>{
				'header1',
				'header2',
				'header3'
			},
			new List<String>{
				'row1Value',
				'row1Value',
				'row1Value'
			},
			new List<String>{
				'row2Value',
				'row2Value',
				'row2Value'
			}
		};
		CSVDocument documentToUse = new CSVDocument(allCSVRows);
		System.assertEquals(allCSVRows[0], documentToUse.columnNames);
		System.assertEquals(allCSVRows[0], documentToUse.allRows[0].columnNames);
		System.assertEquals(allCSVRows[1], documentToUse.allRows[0].columnValues);
		System.assertEquals(allCSVRows[0], documentToUse.allRows[1].columnNames);
		System.assertEquals(allCSVRows[2], documentToUse.allRows[1].columnValues);

	}
=======
/******************************************************************************************
@Author         Hamed Izadpanah
@Date           28/09/2015
@Project        Cloud Sherpas Cabinet Office Data Source
@Description    This is the test unit for CSVDocument object
*******************************************************************************************/
@isTest
private class CSVDocumentTest{

	@isTest
	static void testDocumentInitiation(){
		List<List<String>> allCSVRows = new List<List<String>>{
			new List<String>{
				'header1',
				'header2',
				'header3'
			},
			new List<String>{
				'row1Value',
				'row1Value',
				'row1Value'
			},
			new List<String>{
				'row2Value',
				'row2Value',
				'row2Value'
			}
		};
		CSVDocument documentToUse = new CSVDocument(allCSVRows);
		System.assertEquals(allCSVRows[0], documentToUse.columnNames);
		System.assertEquals(allCSVRows[0], documentToUse.allRows[0].columnNames);
		System.assertEquals(allCSVRows[1], documentToUse.allRows[0].columnValues);
		System.assertEquals(allCSVRows[0], documentToUse.allRows[1].columnNames);
		System.assertEquals(allCSVRows[2], documentToUse.allRows[1].columnValues);

	}
>>>>>>> refs/remotes/origin/master
}