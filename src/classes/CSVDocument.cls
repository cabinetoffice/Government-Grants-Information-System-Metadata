<<<<<<< HEAD
/******************************************************************************************
@Author         Hamed Izadpanah
@Date           28/09/2015
@Project        Cloud Sherpas Cabinet Office Data Source
@Description    This class holds the data for a strcutured(Column-values) CSV document
*******************************************************************************************/
public with sharing class CSVDocument {

	public final List<String> columnNames {get; private set;}
	public final List<CSVRow> allRows {get; private set;}

	public CSVDocument(List<String> columnNames, List<CSVRow> allRows){
		this.columnNames = columnNames;
		this.allRows = allRows;
	}

	public CSVDocument(List<List<String>> allRowsString) {
		allRows = new List<CSVRow>();
		for(List<String> csvRowToAdd : allRowsString){
			if(columnNames == null){
				columnNames = csvRowToAdd;
			} else {
				allRows.add(new CSVRow(columnNames, csvRowToAdd));
			}
		}
		if(columnNames == null){
			columnNames =  new List<String>();
		}

	}

	public Integer getDocumentRowsCount(){
		return allRows.size();
	}

	public String convertToString(){
		List<String> rowsString = new List<String>{
			String.join(columnNames, ',')
		};
		for(CSVRow rowToConvert : allRows){
			rowsString.add(rowToConvert.convertToString());
		}
		return String.join(rowsString, '\n');
	}
	public class CSVRow{
		public final List<String> columnNames {get; private set;}
		public final List<String> columnValues {get; private set;}
		private CSVRow(List<String> columnNames, List<String> columnValues){
			this.columnNames = columnNames;
			this.columnValues = columnValues;
		}
		public String getValue(String columnNameToRetrieve){
			String returnValue;
			for(Integer i = 0; i < columnNames.size(); i++){
				String columnName = columnNames[i];
				if(columnName.equalsIgnoreCase(columnNameToRetrieve)){
					returnValue = columnValues.size() > i ? columnValues[i] : null;
					break;
				}

			}
			return returnValue;
		}
		public String getValue(CSV_Upload_Mapping_Column__c mappingColumn){
			return getValue(mappingColumn.Mapped_From_Field__c);
		}

		public String convertToString(){
			List<String> csvReadyColumns = new List<String>();
			for(String columnToAdd : columnValues){
				columnToAdd = columnToAdd == null ? '' : columnToAdd;
				csvReadyColumns.add(columnToAdd.escapeCsv());
			}
			return String.join(csvReadyColumns, ',');
		}
	}
=======
/******************************************************************************************
@Author         Hamed Izadpanah
@Date           28/09/2015
@Project        Cloud Sherpas Cabinet Office Data Source
@Description    This class holds the data for a strcutured(Column-values) CSV document
*******************************************************************************************/
public with sharing class CSVDocument {

	public final List<String> columnNames {get; private set;}
	public final List<CSVRow> allRows {get; private set;}

	public CSVDocument(List<String> columnNames, List<CSVRow> allRows){
		this.columnNames = columnNames;
		this.allRows = allRows;
	}

	public CSVDocument(List<List<String>> allRowsString) {
		allRows = new List<CSVRow>();
		for(List<String> csvRowToAdd : allRowsString){
			if(columnNames == null){
				columnNames = csvRowToAdd;
			} else {
				allRows.add(new CSVRow(columnNames, csvRowToAdd));
			}
		}
		if(columnNames == null){
			columnNames =  new List<String>();
		}

	}

	public Integer getDocumentRowsCount(){
		return allRows.size();
	}

	public String convertToString(){
		List<String> rowsString = new List<String>{
			String.join(columnNames, ',')
		};
		for(CSVRow rowToConvert : allRows){
			rowsString.add(rowToConvert.convertToString());
		}
		return String.join(rowsString, '\n');
	}
	public class CSVRow{
		public final List<String> columnNames {get; private set;}
		public final List<String> columnValues {get; private set;}
		private CSVRow(List<String> columnNames, List<String> columnValues){
			this.columnNames = columnNames;
			this.columnValues = columnValues;
		}
		public String getValue(String columnNameToRetrieve){
			String returnValue;
			for(Integer i = 0; i < columnNames.size(); i++){
				String columnName = columnNames[i];
				if(columnName.equalsIgnoreCase(columnNameToRetrieve)){
					returnValue = columnValues.size() > i ? columnValues[i] : null;
					break;
				}

			}
			return returnValue;
		}
		public String getValue(CSV_Upload_Mapping_Column__c mappingColumn){
			return getValue(mappingColumn.Mapped_From_Field__c);
		}

		public String convertToString(){
			List<String> csvReadyColumns = new List<String>();
			for(String columnToAdd : columnValues){
				columnToAdd = columnToAdd == null ? '' : columnToAdd;
				csvReadyColumns.add(columnToAdd.escapeCsv());
			}
			return String.join(csvReadyColumns, ',');
		}
	}
>>>>>>> refs/remotes/origin/master
}