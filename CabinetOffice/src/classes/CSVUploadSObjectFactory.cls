/******************************************************************************************
@Author         Hamed Izadpanah
@Date           03/10/2015
@Project        Cloud Sherpas Cabinet Office Data Source
@Description    This is the abstract SObject factory which is used to create/update records in the database
*******************************************************************************************/
public abstract class CSVUploadSObjectFactory {
    private static FieldSetWrapper EXTERNAL_IDS_WRAPPER = new FieldSetWrapper(SObjectType.Account.FieldSets.External_Ids_for_CSV_upload);
    protected List<SObjectCreator> sobjectCreators;
    protected CSV_Upload__c csvUpload;
    public void addOperationsCountDetails(CSV_Upload__c csvUploadToUse) {
        for (SObjectCreator sobjectCreator : sobjectCreators) {
            csvUploadToUse.Records_Created_Count__c = sobjectCreator.recordsInsertedCount;
            csvUploadToUse.Records_Updated_Count__c = sobjectCreator.recordsUpdatedCount;
        }
    }

    public void setCSVUpload(CSV_Upload__c csvUpload) {
        this.csvUpload = csvUpload;
    }

    public abstract void build(CSVDocument.CSVRow csvRow);
    public abstract void setCSVMapping(CSVUploadMapping mappingToUse);

    public String getType() {
        return csvUpload.Type__c;
    }

    public class CreateAwardsFactory extends CSVUploadSObjectFactory {
        public override void setCSVMapping(CSVUploadMapping mappingToUse) {
            SObjectCreator grantAwardCreatorInstance = new GrantAwardCreator(csvUpload);
            grantAwardCreatorInstance.setAllObjectsColumnsMapping(mappingToUse);
            sobjectCreators = new List<SObjectCreator> {
                grantAwardCreatorInstance
            };
        }

        public override void build(CSVDocument.CSVRow csvRow) {
            for (SObjectCreator sobjectCreator : sobjectCreators) {
                sobjectCreator.createSObject(csvRow);
            }
        }
    }

    public class AmendAwardsFactory extends CSVUploadSObjectFactory {
        public override void setCSVMapping(CSVUploadMapping mappingToUse) {
            SObjectCreator grantAwardCreatorInstance = new GrantAwardUpdater();
            grantAwardCreatorInstance.setAllObjectsColumnsMapping(mappingToUse);
            sobjectCreators = new List<SObjectCreator> {
                grantAwardCreatorInstance
            };
        }

        public override void build(CSVDocument.CSVRow csvRow) {
            for (SObjectCreator sobjectCreator : sobjectCreators) {
                sobjectCreator.createSObject(csvRow);
            }
        }
    }

    public abstract class SObjectCreator {
        public Integer recordsInsertedCount = 0;
        public Integer recordsUpdatedCount = 0;

        protected CSVUploadMapping allObjectsColumnsMapping;
        public Decimal groupNoDecimal; // This value limits the mapped fields to specific group number
        public Map<String, Object> readOnlyValues = new Map<String, Object>();
        private List<SObject> sobjects = new List<SObject>();
        public void setAllObjectsColumnsMapping(CSVUploadMapping allObjectsColumnsMapping) {
            this.allObjectsColumnsMapping = allObjectsColumnsMapping;
        }
        public List<SObject> getSObjects() {
            return sobjects;
        }
        protected void addMappedFieldValues(String targetCreator, SObject sobjectToAddValuesTo, CSVDocument.CSVRow csvRowToUse) {
            List<String> requiredFieldsMissing = new List<String>();
            for (CSV_Upload_Mapping_Column__c columnToMap : allObjectsColumnsMapping.getColumnsSObjectCreator(groupNoDecimal, targetCreator)) {
                String currentFieldMappedTo = getFieldMappedToFieldValue(columnToMap, csvRowToUse);
                String valueString = csvRowToUse.getValue(columnToMap.Mapped_From_Field__c);
                if (columnToMap.Required__c && String.isBlank(valueString)) {
                    requiredFieldsMissing.add(columnToMap.Mapped_From_Field__c);
                }
                Boolean columnHasValueParser = String.isNotBlank(columnToMap.Value_Parser__c);
                Object valueToAdd;
                String finalFieldMappedTo = String.isNotBlank(columnToMap.Query_Result_Id_Mapped_to_Field__c) ? columnToMap.Query_Result_Id_Mapped_to_Field__c : currentFieldMappedTo;
                if (String.isBlank(valueString)) {
                    continue;
                } else if (String.isNotBlank(columnToMap.Record_Locator_Query__c)) {
                    String queryString = columnToMap.Record_Locator_Query__c.replaceAll(Constant.QUERY_INPUT_VALUE_TEMPLATE, String.escapeSingleQuotes(valueString));
                    queryString = queryString.replaceAll(Constant.QUERY_INPUT_FIELD_TEMPLATE, currentFieldMappedTo);
                    List<SObject> foundRecords = Database.query(queryString);
                    if (foundRecords.isEmpty()) {
                        if (String.isNotBlank(columnToMap.Run_SObject_Creator_On_Record_Not_Found__c)) {
                            String childSObjectCreator = columnToMap.Run_SObject_Creator_On_Record_Not_Found__c;
                            SObjectCreator creator = (SObjectCreator) Type.forName(childSObjectCreator).newInstance();
                            creator.groupNoDecimal = groupNoDecimal;
                            creator.setAllObjectsColumnsMapping(allObjectsColumnsMapping);
                            creator.createSObject(csvRowToUse);
                            foundRecords = creator.getSObjects();
                        } else {
                            throw new NoRecordFoundException(columnToMap.Not_Found_Error_Message__c);
                        }
                    }
                    valueToAdd = foundRecords[0].Id;
                } else if (columnHasValueParser) {
                    StringValueParser parserToUse = (StringValueParser) Type.forName(columnToMap.Value_Parser__c).newInstance();
                    parserToUse.setTargetMappingSetting(columnToMap);
                    valueToAdd = parserToUse.parse(valueString);
                } else {
                    valueToAdd = valueString;
                }

                if (columnToMap.Read_Only__c) {
                    readOnlyValues.put(finalFieldMappedTo, valueToAdd);
                } else {
                    sobjectToAddValuesTo.put(finalFieldMappedTo, valueToAdd);
                }
            }
            if (!requiredFieldsMissing.isEmpty()) {
                String errorMessage = Label.Required_Field_Values_Missing_Error_Message.replaceAll(Constant.ERR_MSG_TEMP_REQ_FIELDS_MISSING, String.join(requiredFieldsMissing, ', '));
                throw new RequiredFieldEmptyException(errorMessage);
            }
        }
        private String getFieldMappedToFieldValue(CSV_Upload_Mapping_Column__c columnToMap, CSVDocument.CSVRow csvRowToUse) {
            if (!columnToMap.External_Id_Type_Column__c) {
                return columnToMap.Mapped_To_Field__c;
            }
            String externalIdName = columnToMap.Mapped_From_Field__c;
            String externalIdTypeName = columnToMap.Mapped_To_Field__c;
            String externalIdValue = csvRowToUse.getValue(externalIdName);
            String externalIdTypeValue = csvRowToUse.getValue(externalIdTypeName);
            if (String.isBlank(externalIdName) || String.isBlank(externalIdTypeValue)) {
                throw new EmptyValueException(externalIdName + ' and ' + externalIdTypeName + ' should have values.');
            }
            if (!EXTERNAL_IDS_WRAPPER.hasFieldByLabel(externalIdTypeValue)) {
                throw new InvalidExternalIdTypeException(externalIdName + ' - Input External Id type is invalid : ' + externalIdTypeValue);
            }
            return EXTERNAL_IDS_WRAPPER.getFieldApiNameFromLabel(externalIdTypeValue);
        }
        public abstract void createSObject(CSVDocument.CSVRow csvRowToUse);

    }
    public class RecepientCreator extends SObjectCreator {
        public override void createSObject(CSVDocument.CSVRow csvRowToUse) {
            Account organisationToCreate = new Account(
                Type__c = Constant.ORGANISATION_TYPE_RECEPIENT
            );
            addMappedFieldValues(Constant.CSV_SOBJECT_CREATOR_GRANT_AWARD_RECEPIENT, organisationToCreate, csvRowToUse);
            insert organisationToCreate;
            sobjects.add(organisationToCreate);
        }

    }
    public class GrantAwardCreator extends SObjectCreator {
        private Id grantAwardRecordToUse;

        public GrantAwardCreator(CSV_Upload__c csvUpload) {
            if (csvUpload != null && csvUpload.Recipient_Type__c == Constant.GRT_INIDIVIDUAL) {
                grantAwardRecordToUse = Grant_Award__c.SObjectType.getDescribe().getRecordTypeInfosByName().get(Constant.GRANT_AWARD_INDIVIDUAL_RT_NAME).getRecordTypeId();
            } else {
                grantAwardRecordToUse = Grant_Award__c.SObjectType.getDescribe().getRecordTypeInfosByName().get(Constant.GRANT_AWARD_ORGANISATION_RT_NAME).getRecordTypeId();
            }
        }

        public override void createSObject(CSVDocument.CSVRow csvRowToUse) {
            String grantSchemeIdToUse = csvRowToUse.getValue(Constant.GRANT_SCHEME_AND_SYSTEM_REFERENCE_LABEL);
            if (String.isBlank(grantSchemeIdToUse)) {
                throw new NoGrantSchemeIdException(Constant.GRANT_SCHEME_AND_SYSTEM_REFERENCE_LABEL + ' cannot be empty.');
            }
            Grant_Award__c grantAwardToInsert = new Grant_Award__c(
                RecordTypeId = grantAwardRecordToUse
            );
            addMappedFieldValues(Constant.CSV_SOBJECT_CREATOR_GRANT_AWARD, grantAwardToInsert, csvRowToUse);
            insert grantAwardToInsert;
            Set<Decimal> intermediaryGroups = new Set<Decimal>();
            for (CSV_Upload_Mapping_Column__c columnToMap : allObjectsColumnsMapping.getColumnsSObjectCreator(Constant.CSV_SOBJECT_CREATOR_GRANT_AWARD_INTERMEDIARY)) {
                intermediaryGroups.add(columnToMap.Group__c);
            }
            for (Decimal groupNoDecimal : new List<Decimal>(intermediaryGroups)) {
                IntermediaryCreator intermediaryCreator = new IntermediaryCreator(grantAwardToInsert);
                intermediaryCreator.groupNoDecimal = groupNoDecimal;
                intermediaryCreator.setAllObjectsColumnsMapping(allObjectsColumnsMapping);
                try {
                    intermediaryCreator.createSObject(csvRowToUse);
                } catch (EmptyValueException exceptionToHandle) { // Bypasses the creation of intermediary of no value has been
                    continue;
                }
            }
            recordsInsertedCount++;
        }
    }

    public class GrantAwardUpdater extends SObjectCreator {
        public override void createSObject(CSVDocument.CSVRow csvRowToUse) {
            Grant_Award__c grantAwardToUpsert = new Grant_Award__c();
            addMappedFieldValues(Constant.CSV_SOBJECT_AMEND_GRANT_AWARD, grantAwardToUpsert, csvRowToUse);
            List<Grant_Award__c> foundExistingGrantAwards = [
                        SELECT Id
                        FROM Grant_Award__c
                        WHERE Name = :String.valueOf(readOnlyValues.get('Name'))
                                     OR (
                                         Grant_Award_Reference_Number__c != null
                                         AND Grant_Award_Reference_Number__c = :grantAwardToUpsert.Grant_Award_Reference_Number__c
                                     )
                                     LIMIT 1
                    ];

            //GEPDS-801 - 06 Apr 2016 - Showing different error message based on the checks
            if (foundExistingGrantAwards.isEmpty() && grantAwardToUpsert.Grant_Award_Reference_Number__c != null) {
                throw new NoRecordFoundException(Label.Invalid_Grant_Ref_Num_Error);
            } else if (foundExistingGrantAwards.isEmpty() && String.valueOf(readOnlyValues.get('Name')) != null) {
                throw new NoRecordFoundException(Label.Invalid_Grant_Sys_Ref_Num_Error);
            } else {
                grantAwardToUpsert.Id = foundExistingGrantAwards[0].Id;
                update grantAwardToUpsert;
            }
            recordsUpdatedCount++;
        }
    }

    public class IntermediaryCreator extends SObjectCreator {
        private Grant_Award__c parentGrantAward;
        public IntermediaryCreator(Grant_Award__c parentGrantAward) {
            this.parentGrantAward = parentGrantAward;
        }
        public override void createSObject(CSVDocument.CSVRow csvRowToUse) {
            Intermediary__c newIntermediary = new Intermediary__c(
                Grant_Award__c = parentGrantAward.Id
            );
            addMappedFieldValues(Constant.CSV_SOBJECT_CREATOR_GRANT_AWARD_INTERMEDIARY, newIntermediary, csvRowToUse);
            if (String.isBlank(newIntermediary.Intermediary_Organisation__c)) {
                throw new EmptyValueException('No Organisation has been selected!');
            }
            insert newIntermediary;
        }
    }

    public class IntermediaryOrganisationCreator extends SObjectCreator {
        public override void createSObject(CSVDocument.CSVRow csvRowToUse) {
            Account organisationToCreate = new Account(
                Type__c = Constant.ORGANISATION_TYPE_INTERMEDIARY
            );
            addMappedFieldValues(Constant.CSV_SOBJECT_CREATOR_GRANT_AWARD_INTERMEDIARY_ORGANISATION, organisationToCreate, csvRowToUse);
            insert organisationToCreate;
            sobjects.add(organisationToCreate);
        }

    }

    public static CSVUploadSObjectFactory newInstance(CSV_Upload__c csvUploadProcess) {
        Custom_Record_Type__mdt customRecordType = [
                    SELECT Processor__c
                    FROM Custom_Record_Type__mdt
                    WHERE Label = :csvUploadProcess.Type__c
                                  AND SObject_API_Name__c = 'CSV_Upload__c'
                ];
        CSVUploadSObjectFactory returnValue = (CSVUploadSObjectFactory) Type.forName(customRecordType.Processor__c).newInstance();
        returnValue.setCSVUpload(csvUploadProcess);
        CSVUploadMapping csvUploadMapping = new CSVUploadMapping(csvUploadProcess);
        returnValue.setCSVMapping(csvUploadMapping);
        return returnValue;
    }


    public class EmptyValueException extends Exception {}
    public class InvalidExternalIdTypeException extends Exception {}
    public class NoGrantSchemeIdException extends Exception {}
    public class NoRecordFoundException extends Exception {}
    public class RequiredFieldEmptyException extends Exception {}

}