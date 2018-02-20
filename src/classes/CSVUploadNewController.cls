<<<<<<< HEAD
/******************************************************************************************
@Author         Hamed Izadpanah
@Date           03/10/2015
@Project        Cloud Sherpas Cabinet Office Data Source
@Description    This is the page which override the default create/edit page for CSV Upload object
*******************************************************************************************/
public with sharing class CSVUploadNewController {
    private final ApexPages.StandardController stndController;
    public Boolean isAttachmentBodyValidated {get; private set;}

    public String fileName {get; set;}
    public transient Blob csvContent {get; set;}

    public String templateName {get; set;}
    public final CSV_Upload__c csvUploadToUse {get; private set;}

    public CSVUploadNewController(ApexPages.StandardController stndController) {
        this.stndController = stndController;
        csvUploadToUse = (CSV_Upload__c) stndController.getRecord();
        if (String.isBlank(stndController.getId())) {
            csvUploadToUse.Type__c = getOrderedRecordTypes()[0].Label;
            csvUploadToUse.Recipient_Type__c = Constant.GRT_ORGANISATION;
        }
        fileName = getAttachmentToValidate().Name;
        if (String.isNotBlank(fileName)) {
            validate();
        }
        isAttachmentBodyValidated = false;
    }

    public Boolean getRecordtypeNeedsRecipientType() {
        Custom_Record_Type__mdt foundRecordtype = getRecordtypeDetails();
        if (foundRecordtype != null) {
            return foundRecordtype.Requires_Recipient_Type__c;
        }
        return false;
    }

    public String getCSVTemplatePath() {
        String returnValue = '';
        Custom_Record_Type__mdt foundRecordtype = getRecordtypeDetails();
        if (foundRecordtype != null) {
            returnValue = foundRecordtype.Default_CSV_Template_Path__c;
            if (getRecordtypeNeedsRecipientType() && String.isNotBlank(csvUploadToUse.Recipient_Type__c)) {
                if (csvUploadToUse.Recipient_Type__c.equalsIgnoreCase(Constant.GRT_ORGANISATION)) {
                    returnValue = foundRecordtype.Organisation_CSV_Template_Path__c;
                    templateName = String.valueOf(foundRecordtype.Organisation_CSV_Template_Name__c);
                } else if (csvUploadToUse.Recipient_Type__c.equalsIgnoreCase(Constant.GRT_INIDIVIDUAL)) {
                    returnValue = foundRecordtype.Individual_CSV_Template_Path__c;
                    templateName = String.valueOf(foundRecordtype.Individual_CSV_Template_Name__c);
                }
            } else {
                templateName = String.valueOf(foundRecordtype.CSV_Template_Name__c);
            }
        }
        return returnValue;
    }

    public Custom_Record_Type__mdt getRecordtypeDetails() {
        Custom_Record_Type__mdt recordtypeDetails = null;
        List<Custom_Record_Type__mdt> foundRecordTypeDetails = [
                    SELECT Id, Label, Requires_Recipient_Type__c,
                    Default_CSV_Template_Path__c,
                    Individual_CSV_Template_Path__c,
                    Organisation_CSV_Template_Path__c,
                    Individual_CSV_Template_Name__c,
                    Organisation_CSV_Template_Name__c,
                    CSV_Template_Name__c
                    FROM Custom_Record_Type__mdt
                    WHERE Label = :csvUploadToUse.Type__c
                                  LIMIT 1
                ];
        if (!foundRecordTypeDetails.isEmpty()) {
            recordtypeDetails = foundRecordTypeDetails[0];
        }
        return recordtypeDetails;
    }


    public Boolean getIsReadyForFileUpload() {
        if (String.isBlank(csvUploadToUse.Type__c)) {
            return false;
        }
        if (getRecordtypeNeedsRecipientType() && String.isBlank(csvUploadToUse.Recipient_Type__c)) {
            return false;
        }
        return true;
    }

    public List<SelectOption> getAvailableTypeOptions() {
        List<SelectOption> availableTypeOptions = new List<SelectOption>();
        for (Custom_Record_Type__mdt orderedRecordType : getOrderedRecordTypes()) {
            availableTypeOptions.add(
                new SelectOption(orderedRecordType.Label, orderedRecordType.Label)
            );
        }
        return availableTypeOptions;
    }

    private transient List<Custom_Record_Type__mdt> orderedRecordTypes;
    public List<Custom_Record_Type__mdt> getOrderedRecordTypes() {
        if (orderedRecordTypes == null) {
            orderedRecordTypes = [
                                     SELECT Id, Label, Description__c, Order__c
                                     FROM Custom_Record_Type__mdt
                                     WHERE SObject_API_Name__c = 'CSV_Upload__c'
                                             ORDER BY Order__c
                                 ];
        }
        return orderedRecordTypes;
    }

    public PageReference checkCSVUploadRecord() {
        Boolean newCSVUpload = String.isBlank(stndController.getId());
        Boolean existingValidatedOnly = csvUploadToUse.Processing_Status__c == Constant.CSV_UPLOAD_PT_VALIDATED;
        return newCSVUpload || existingValidatedOnly ? null : stndController.view();
    }

    private transient Attachment attachmentToValidate;
    private Attachment getAttachmentToValidate() {
        if (csvContent != null) {
            try {
                if (String.isBlank(csvUploadToUse.Id)) {
                    csvUploadToUse.Processing_Status__c = Constant.CSV_UPLOAD_PT_VALIDATED;
                    insert csvUploadToUse;
                } else {
                    delete [SELECT Id FROM Attachment WHERE ParentId = :csvUploadToUse.Id];
                }
                attachmentToValidate = new Attachment(
                    Name = fileName,
                    Body = csvContent,
                    ParentId = csvUploadToUse.Id
                );
                insert attachmentToValidate;
                csvUploadToUse.Source_Attachment_Id__c = attachmentToValidate.Id;
                update csvUploadToUse;
            } catch (DmlException exceptionToHandle) {
                for (Integer i = 0; i < exceptionToHandle.getNumDml(); i++) {
                    Utility.addMessageToPage(ApexPages.Severity.ERROR, exceptionToHandle.getDmlMessage(i));
                }
            }
        } else if (attachmentToValidate == null) {
            List<Attachment> foundAttachments = [
                                                    SELECT Id, Name, Body
                                                    FROM Attachment
                                                    WHERE Id = :csvUploadToUse.Source_Attachment_Id__c
                                                            LIMIT 1
                                                ];
            attachmentToValidate = foundAttachments.isEmpty() ? new Attachment() : foundAttachments[0];
        }
        return attachmentToValidate;
    }

    public void changeFile() {
        fileName = null;
    }

    private transient CSVDocument csvDocumentToUploadInstance;
    private CSVDocument getCsvDocumentToUpload() {

        if (csvDocumentToUploadInstance == null) {
            CSVParser parser = new CSVParser();
            csvDocumentToUploadInstance = parser.parse(getAttachmentToValidate().body);
        }

        return csvDocumentToUploadInstance;
    }

    public void validate() {
        Attachment attachmentToValidate = getAttachmentToValidate();
        String fileName = attachmentToValidate != null ? attachmentToValidate.Name : '';
        List<InputValidator> fileValidators = new List<InputValidator> {
            new InputValidator.AttachmentValidator(attachmentToValidate),
            new InputValidator.CSVExtensionValidator(fileName)
        };
        for (InputValidator fileValidator : fileValidators) {
            if (!fileValidator.isValid()) {
                fileValidator.addAllErrorsToThePage();
                return;
            }
        }
        CSVDocument csvDocumentToUpload;
        try {
            csvDocumentToUpload = getCsvDocumentToUpload();
        } catch (System.StringException exceptionToHandle) {
            if (exceptionToHandle.getMessage().containsIgnoreCase('String length exceeds maximum')) {
                Utility.addMessageToPage(ApexPages.Severity.ERROR, Label.CSV_Upload_String_Too_Long_Error_Message);
            } else {
                Utility.addMessageToPage(ApexPages.Severity.ERROR, exceptionToHandle.getMessage());
            }
            return;
        } catch (System.LimitException exceptionToHandle) {
            Utility.addMessageToPage(ApexPages.Severity.ERROR, exceptionToHandle.getMessage());
            return;
        }
        CSVUploadMapping csvUploadMapping = new CSVUploadMapping(csvUploadToUse);
        InputValidator columnValidator = new InputValidator.CSVColumnsValidator(csvDocumentToUpload, csvUploadMapping);
        isAttachmentBodyValidated = columnValidator.isValid();
        if (!isAttachmentBodyValidated) {
            columnValidator.addAllErrorsToThePage();
            return;
        }
        String successMessage = 'Upload will contain ' + String.valueOf(csvDocumentToUpload.getDocumentRowsCount()) + ' record(s).';
        Utility.addMessageToPage(ApexPages.Severity.INFO, successMessage);
    }

    public PageReference upload() {
        PageReference returnValue;
        validate();
        if (!isAttachmentBodyValidated) {
            return returnValue;
        }
        CSVDocument csvDocumentToUpload;
        try {
            csvDocumentToUpload = getCsvDocumentToUpload();
        } catch (System.StringException exceptionToHandle) {
            Utility.addMessageToPage(ApexPages.Severity.ERROR, exceptionToHandle.getMessage());
            return null;
        } catch (System.LimitException exceptionToHandle) {
            Utility.addMessageToPage(ApexPages.Severity.ERROR, exceptionToHandle.getMessage());
            return null;
        }
        SavePoint sp = Database.setSavepoint();
        CSVUploadProcessor processor = new CSVUploadProcessor(csvDocumentToUpload, CSVUploadSObjectFactory.newInstance(csvUploadToUse));
        try {
            Id scheduledApexBatchId = Database.executeBatch(processor, 3);
            csvUploadToUse.Apex_Batch_Id__c = scheduledApexBatchId;
            csvUploadToUse.Total_Records_To_Be_Processed__c = csvDocumentToUpload.getDocumentRowsCount();
            csvUploadToUse.Total_Records_Failed__c = 0;
            csvUploadToUse.Records_Created_Count__c = 0;
            csvUploadToUse.Records_Updated_Count__c = 0;
            csvUploadToUse.Processing_Status__c = Constant.CSV_UPLOAD_PT_QUEUED;
            update csvUploadToUse;
            PageReference csvUploadDetailsPage = Page.CSVUploadDetail;
            csvUploadDetailsPage.getParameters().put('id', csvUploadToUse.Id);
            returnValue = csvUploadDetailsPage;
        } catch (Exception exceptionToHandle) {
            Database.rollback(sp);
            ApexPages.addMessages(exceptionToHandle);
        }
        return returnValue;
    }
=======
<<<<<<< HEAD
/******************************************************************************************
@Author         Hamed Izadpanah
@Date           03/10/2015
@Project        Cloud Sherpas Cabinet Office Data Source
@Description    This is the page which override the default create/edit page for CSV Upload object
*******************************************************************************************/
public with sharing class CSVUploadNewController {
    private final ApexPages.StandardController stndController;
    public Boolean isAttachmentBodyValidated {get; private set;}

    public String fileName {get; set;}
    public transient Blob csvContent {get; set;}

    public String templateName {get; set;}
    public final CSV_Upload__c csvUploadToUse {get; private set;}

    public CSVUploadNewController(ApexPages.StandardController stndController) {
        this.stndController = stndController;
        csvUploadToUse = (CSV_Upload__c) stndController.getRecord();
        if (String.isBlank(stndController.getId())) {
            csvUploadToUse.Type__c = getOrderedRecordTypes()[0].Label;
            csvUploadToUse.Recipient_Type__c = Constant.GRT_ORGANISATION;
        }
        fileName = getAttachmentToValidate().Name;
        if (String.isNotBlank(fileName)) {
            validate();
        }
        isAttachmentBodyValidated = false;
    }

    public Boolean getRecordtypeNeedsRecipientType() {
        Custom_Record_Type__mdt foundRecordtype = getRecordtypeDetails();
        if (foundRecordtype != null) {
            return foundRecordtype.Requires_Recipient_Type__c;
        }
        return false;
    }

    public String getCSVTemplatePath() {
        String returnValue = '';
        Custom_Record_Type__mdt foundRecordtype = getRecordtypeDetails();
        if (foundRecordtype != null) {
            returnValue = foundRecordtype.Default_CSV_Template_Path__c;
            if (getRecordtypeNeedsRecipientType() && String.isNotBlank(csvUploadToUse.Recipient_Type__c)) {
                if (csvUploadToUse.Recipient_Type__c.equalsIgnoreCase(Constant.GRT_ORGANISATION)) {
                    returnValue = foundRecordtype.Organisation_CSV_Template_Path__c;
                    templateName = String.valueOf(foundRecordtype.Organisation_CSV_Template_Name__c);
                } else if (csvUploadToUse.Recipient_Type__c.equalsIgnoreCase(Constant.GRT_INIDIVIDUAL)) {
                    returnValue = foundRecordtype.Individual_CSV_Template_Path__c;
                    templateName = String.valueOf(foundRecordtype.Individual_CSV_Template_Name__c);
                }
            } else {
                templateName = String.valueOf(foundRecordtype.CSV_Template_Name__c);
            }
        }
        return returnValue;
    }

    public Custom_Record_Type__mdt getRecordtypeDetails() {
        Custom_Record_Type__mdt recordtypeDetails = null;
        List<Custom_Record_Type__mdt> foundRecordTypeDetails = [
                    SELECT Id, Label, Requires_Recipient_Type__c,
                    Default_CSV_Template_Path__c,
                    Individual_CSV_Template_Path__c,
                    Organisation_CSV_Template_Path__c,
                    Individual_CSV_Template_Name__c,
                    Organisation_CSV_Template_Name__c,
                    CSV_Template_Name__c
                    FROM Custom_Record_Type__mdt
                    WHERE Label = :csvUploadToUse.Type__c
                                  LIMIT 1
                ];
        if (!foundRecordTypeDetails.isEmpty()) {
            recordtypeDetails = foundRecordTypeDetails[0];
        }
        return recordtypeDetails;
    }


    public Boolean getIsReadyForFileUpload() {
        if (String.isBlank(csvUploadToUse.Type__c)) {
            return false;
        }
        if (getRecordtypeNeedsRecipientType() && String.isBlank(csvUploadToUse.Recipient_Type__c)) {
            return false;
        }
        return true;
    }

    public List<SelectOption> getAvailableTypeOptions() {
        List<SelectOption> availableTypeOptions = new List<SelectOption>();
        for (Custom_Record_Type__mdt orderedRecordType : getOrderedRecordTypes()) {
            availableTypeOptions.add(
                new SelectOption(orderedRecordType.Label, orderedRecordType.Label)
            );
        }
        return availableTypeOptions;
    }

    private transient List<Custom_Record_Type__mdt> orderedRecordTypes;
    public List<Custom_Record_Type__mdt> getOrderedRecordTypes() {
        if (orderedRecordTypes == null) {
            orderedRecordTypes = [
                                     SELECT Id, Label, Description__c, Order__c
                                     FROM Custom_Record_Type__mdt
                                     WHERE SObject_API_Name__c = 'CSV_Upload__c'
                                             ORDER BY Order__c
                                 ];
        }
        return orderedRecordTypes;
    }

    public PageReference checkCSVUploadRecord() {
        Boolean newCSVUpload = String.isBlank(stndController.getId());
        Boolean existingValidatedOnly = csvUploadToUse.Processing_Status__c == Constant.CSV_UPLOAD_PT_VALIDATED;
        return newCSVUpload || existingValidatedOnly ? null : stndController.view();
    }

    private transient Attachment attachmentToValidate;
    private Attachment getAttachmentToValidate() {
        if (csvContent != null) {
            try {
                if (String.isBlank(csvUploadToUse.Id)) {
                    csvUploadToUse.Processing_Status__c = Constant.CSV_UPLOAD_PT_VALIDATED;
                    insert csvUploadToUse;
                } else {
                    delete [SELECT Id FROM Attachment WHERE ParentId = :csvUploadToUse.Id];
                }
                attachmentToValidate = new Attachment(
                    Name = fileName,
                    Body = csvContent,
                    ParentId = csvUploadToUse.Id
                );
                insert attachmentToValidate;
                csvUploadToUse.Source_Attachment_Id__c = attachmentToValidate.Id;
                update csvUploadToUse;
            } catch (DmlException exceptionToHandle) {
                for (Integer i = 0; i < exceptionToHandle.getNumDml(); i++) {
                    Utility.addMessageToPage(ApexPages.Severity.ERROR, exceptionToHandle.getDmlMessage(i));
                }
            }
        } else if (attachmentToValidate == null) {
            List<Attachment> foundAttachments = [
                                                    SELECT Id, Name, Body
                                                    FROM Attachment
                                                    WHERE Id = :csvUploadToUse.Source_Attachment_Id__c
                                                            LIMIT 1
                                                ];
            attachmentToValidate = foundAttachments.isEmpty() ? new Attachment() : foundAttachments[0];
        }
        return attachmentToValidate;
    }

    public void changeFile() {
        fileName = null;
    }

    private transient CSVDocument csvDocumentToUploadInstance;
    private CSVDocument getCsvDocumentToUpload() {

        if (csvDocumentToUploadInstance == null) {
            CSVParser parser = new CSVParser();
            csvDocumentToUploadInstance = parser.parse(getAttachmentToValidate().body);
        }

        return csvDocumentToUploadInstance;
    }

    public void validate() {
        Attachment attachmentToValidate = getAttachmentToValidate();
        String fileName = attachmentToValidate != null ? attachmentToValidate.Name : '';
        List<InputValidator> fileValidators = new List<InputValidator> {
            new InputValidator.AttachmentValidator(attachmentToValidate),
            new InputValidator.CSVExtensionValidator(fileName)
        };
        for (InputValidator fileValidator : fileValidators) {
            if (!fileValidator.isValid()) {
                fileValidator.addAllErrorsToThePage();
                return;
            }
        }
        CSVDocument csvDocumentToUpload;
        try {
            csvDocumentToUpload = getCsvDocumentToUpload();
        } catch (System.StringException exceptionToHandle) {
            if (exceptionToHandle.getMessage().containsIgnoreCase('String length exceeds maximum')) {
                Utility.addMessageToPage(ApexPages.Severity.ERROR, Label.CSV_Upload_String_Too_Long_Error_Message);
            } else {
                Utility.addMessageToPage(ApexPages.Severity.ERROR, exceptionToHandle.getMessage());
            }
            return;
        } catch (System.LimitException exceptionToHandle) {
            Utility.addMessageToPage(ApexPages.Severity.ERROR, exceptionToHandle.getMessage());
            return;
        }
        CSVUploadMapping csvUploadMapping = new CSVUploadMapping(csvUploadToUse);
        InputValidator columnValidator = new InputValidator.CSVColumnsValidator(csvDocumentToUpload, csvUploadMapping);
        isAttachmentBodyValidated = columnValidator.isValid();
        if (!isAttachmentBodyValidated) {
            columnValidator.addAllErrorsToThePage();
            return;
        }
        String successMessage = 'Upload will contain ' + String.valueOf(csvDocumentToUpload.getDocumentRowsCount()) + ' record(s).';
        Utility.addMessageToPage(ApexPages.Severity.INFO, successMessage);
    }

    public PageReference upload() {
        PageReference returnValue;
        validate();
        if (!isAttachmentBodyValidated) {
            return returnValue;
        }
        CSVDocument csvDocumentToUpload;
        try {
            csvDocumentToUpload = getCsvDocumentToUpload();
        } catch (System.StringException exceptionToHandle) {
            Utility.addMessageToPage(ApexPages.Severity.ERROR, exceptionToHandle.getMessage());
            return null;
        } catch (System.LimitException exceptionToHandle) {
            Utility.addMessageToPage(ApexPages.Severity.ERROR, exceptionToHandle.getMessage());
            return null;
        }
        SavePoint sp = Database.setSavepoint();
        CSVUploadProcessor processor = new CSVUploadProcessor(csvDocumentToUpload, CSVUploadSObjectFactory.newInstance(csvUploadToUse));
        try {
            Id scheduledApexBatchId = Database.executeBatch(processor, 3);
            csvUploadToUse.Apex_Batch_Id__c = scheduledApexBatchId;
            csvUploadToUse.Total_Records_To_Be_Processed__c = csvDocumentToUpload.getDocumentRowsCount();
            csvUploadToUse.Total_Records_Failed__c = 0;
            csvUploadToUse.Records_Created_Count__c = 0;
            csvUploadToUse.Records_Updated_Count__c = 0;
            csvUploadToUse.Processing_Status__c = Constant.CSV_UPLOAD_PT_QUEUED;
            update csvUploadToUse;
            PageReference csvUploadDetailsPage = Page.CSVUploadDetail;
            csvUploadDetailsPage.getParameters().put('id', csvUploadToUse.Id);
            returnValue = csvUploadDetailsPage;
        } catch (Exception exceptionToHandle) {
            Database.rollback(sp);
            ApexPages.addMessages(exceptionToHandle);
        }
        return returnValue;
    }
=======
/******************************************************************************************
@Author         Hamed Izadpanah
@Date           03/10/2015
@Project        Cloud Sherpas Cabinet Office Data Source
@Description    This is the page which override the default create/edit page for CSV Upload object
*******************************************************************************************/
public with sharing class CSVUploadNewController {
    private final ApexPages.StandardController stndController;
    public Boolean isAttachmentBodyValidated {get; private set;}

    public String fileName {get; set;}
    public transient Blob csvContent {get; set;}

    public String templateName {get; set;}
    public final CSV_Upload__c csvUploadToUse {get; private set;}

    public CSVUploadNewController(ApexPages.StandardController stndController) {
        this.stndController = stndController;
        csvUploadToUse = (CSV_Upload__c) stndController.getRecord();
        if (String.isBlank(stndController.getId())) {
            csvUploadToUse.Type__c = getOrderedRecordTypes()[0].Label;
            csvUploadToUse.Recipient_Type__c = Constant.GRT_ORGANISATION;
        }
        fileName = getAttachmentToValidate().Name;
        if (String.isNotBlank(fileName)) {
            validate();
        }
        isAttachmentBodyValidated = false;
    }

    public Boolean getRecordtypeNeedsRecipientType() {
        Custom_Record_Type__mdt foundRecordtype = getRecordtypeDetails();
        if (foundRecordtype != null) {
            return foundRecordtype.Requires_Recipient_Type__c;
        }
        return false;
    }

    public String getCSVTemplatePath() {
        String returnValue = '';
        Custom_Record_Type__mdt foundRecordtype = getRecordtypeDetails();
        if (foundRecordtype != null) {
            returnValue = foundRecordtype.Default_CSV_Template_Path__c;
            if (getRecordtypeNeedsRecipientType() && String.isNotBlank(csvUploadToUse.Recipient_Type__c)) {
                if (csvUploadToUse.Recipient_Type__c.equalsIgnoreCase(Constant.GRT_ORGANISATION)) {
                    returnValue = foundRecordtype.Organisation_CSV_Template_Path__c;
                    templateName = String.valueOf(foundRecordtype.Organisation_CSV_Template_Name__c);
                } else if (csvUploadToUse.Recipient_Type__c.equalsIgnoreCase(Constant.GRT_INIDIVIDUAL)) {
                    returnValue = foundRecordtype.Individual_CSV_Template_Path__c;
                    templateName = String.valueOf(foundRecordtype.Individual_CSV_Template_Name__c);
                }
            } else {
                templateName = String.valueOf(foundRecordtype.CSV_Template_Name__c);
            }
        }
        return returnValue;
    }

    public Custom_Record_Type__mdt getRecordtypeDetails() {
        Custom_Record_Type__mdt recordtypeDetails = null;
        List<Custom_Record_Type__mdt> foundRecordTypeDetails = [
                    SELECT Id, Label, Requires_Recipient_Type__c,
                    Default_CSV_Template_Path__c,
                    Individual_CSV_Template_Path__c,
                    Organisation_CSV_Template_Path__c,
                    Individual_CSV_Template_Name__c,
                    Organisation_CSV_Template_Name__c,
                    CSV_Template_Name__c
                    FROM Custom_Record_Type__mdt
                    WHERE Label = :csvUploadToUse.Type__c
                                  LIMIT 1
                ];
        if (!foundRecordTypeDetails.isEmpty()) {
            recordtypeDetails = foundRecordTypeDetails[0];
        }
        return recordtypeDetails;
    }


    public Boolean getIsReadyForFileUpload() {
        if (String.isBlank(csvUploadToUse.Type__c)) {
            return false;
        }
        if (getRecordtypeNeedsRecipientType() && String.isBlank(csvUploadToUse.Recipient_Type__c)) {
            return false;
        }
        return true;
    }

    public List<SelectOption> getAvailableTypeOptions() {
        List<SelectOption> availableTypeOptions = new List<SelectOption>();
        for (Custom_Record_Type__mdt orderedRecordType : getOrderedRecordTypes()) {
            availableTypeOptions.add(
                new SelectOption(orderedRecordType.Label, orderedRecordType.Label)
            );
        }
        return availableTypeOptions;
    }

    private transient List<Custom_Record_Type__mdt> orderedRecordTypes;
    public List<Custom_Record_Type__mdt> getOrderedRecordTypes() {
        if (orderedRecordTypes == null) {
            orderedRecordTypes = [
                                     SELECT Id, Label, Description__c, Order__c
                                     FROM Custom_Record_Type__mdt
                                     WHERE SObject_API_Name__c = 'CSV_Upload__c'
                                             ORDER BY Order__c
                                 ];
        }
        return orderedRecordTypes;
    }

    public PageReference checkCSVUploadRecord() {
        Boolean newCSVUpload = String.isBlank(stndController.getId());
        Boolean existingValidatedOnly = csvUploadToUse.Processing_Status__c == Constant.CSV_UPLOAD_PT_VALIDATED;
        return newCSVUpload || existingValidatedOnly ? null : stndController.view();
    }

    private transient Attachment attachmentToValidate;
    private Attachment getAttachmentToValidate() {
        if (csvContent != null) {
            try {
                if (String.isBlank(csvUploadToUse.Id)) {
                    csvUploadToUse.Processing_Status__c = Constant.CSV_UPLOAD_PT_VALIDATED;
                    insert csvUploadToUse;
                } else {
                    delete [SELECT Id FROM Attachment WHERE ParentId = :csvUploadToUse.Id];
                }
                attachmentToValidate = new Attachment(
                    Name = fileName,
                    Body = csvContent,
                    ParentId = csvUploadToUse.Id
                );
                insert attachmentToValidate;
                csvUploadToUse.Source_Attachment_Id__c = attachmentToValidate.Id;
                update csvUploadToUse;
            } catch (DmlException exceptionToHandle) {
                for (Integer i = 0; i < exceptionToHandle.getNumDml(); i++) {
                    Utility.addMessageToPage(ApexPages.Severity.ERROR, exceptionToHandle.getDmlMessage(i));
                }
            }
        } else if (attachmentToValidate == null) {
            List<Attachment> foundAttachments = [
                                                    SELECT Id, Name, Body
                                                    FROM Attachment
                                                    WHERE Id = :csvUploadToUse.Source_Attachment_Id__c
                                                            LIMIT 1
                                                ];
            attachmentToValidate = foundAttachments.isEmpty() ? new Attachment() : foundAttachments[0];
        }
        return attachmentToValidate;
    }

    public void changeFile() {
        fileName = null;
    }

    private transient CSVDocument csvDocumentToUploadInstance;
    private CSVDocument getCsvDocumentToUpload() {

        if (csvDocumentToUploadInstance == null) {
            CSVParser parser = new CSVParser();
            csvDocumentToUploadInstance = parser.parse(getAttachmentToValidate().body);
        }

        return csvDocumentToUploadInstance;
    }

    public void validate() {
        Attachment attachmentToValidate = getAttachmentToValidate();
        String fileName = attachmentToValidate != null ? attachmentToValidate.Name : '';
        System.debug(loggingLevel.Error, '*** attachmentToValidate.Name: ' + attachmentToValidate.Name);
        List<InputValidator> fileValidators = new List<InputValidator> {
            new InputValidator.AttachmentValidator(attachmentToValidate),
            new InputValidator.CSVExtensionValidator(fileName)
        };
        for (InputValidator fileValidator : fileValidators) {
            if (!fileValidator.isValid()) {
                fileValidator.addAllErrorsToThePage();
                return;
            }
        }
        CSVDocument csvDocumentToUpload;
        try {
            csvDocumentToUpload = getCsvDocumentToUpload();
        } catch (System.StringException exceptionToHandle) {
            if (exceptionToHandle.getMessage().containsIgnoreCase('String length exceeds maximum')) {
                Utility.addMessageToPage(ApexPages.Severity.ERROR, Label.CSV_Upload_String_Too_Long_Error_Message);
            } else {
                Utility.addMessageToPage(ApexPages.Severity.ERROR, exceptionToHandle.getMessage());
            }
            return;
        } catch (System.LimitException exceptionToHandle) {
            Utility.addMessageToPage(ApexPages.Severity.ERROR, exceptionToHandle.getMessage());
            return;
        }
        CSVUploadMapping csvUploadMapping = new CSVUploadMapping(csvUploadToUse);
        InputValidator columnValidator = new InputValidator.CSVColumnsValidator(csvDocumentToUpload, csvUploadMapping);
        isAttachmentBodyValidated = columnValidator.isValid();
        if (!isAttachmentBodyValidated) {
            columnValidator.addAllErrorsToThePage();
            return;
        }
        String successMessage = 'Upload will contain ' + String.valueOf(csvDocumentToUpload.getDocumentRowsCount()) + ' record(s).';
        Utility.addMessageToPage(ApexPages.Severity.INFO, successMessage);
    }

    public PageReference upload() {
        PageReference returnValue;
        validate();
        if (!isAttachmentBodyValidated) {
            return returnValue;
        }
        CSVDocument csvDocumentToUpload;
        try {
            csvDocumentToUpload = getCsvDocumentToUpload();
        } catch (System.StringException exceptionToHandle) {
            Utility.addMessageToPage(ApexPages.Severity.ERROR, exceptionToHandle.getMessage());
            return null;
        } catch (System.LimitException exceptionToHandle) {
            Utility.addMessageToPage(ApexPages.Severity.ERROR, exceptionToHandle.getMessage());
            return null;
        }
        SavePoint sp = Database.setSavepoint();
        CSVUploadProcessor processor = new CSVUploadProcessor(csvDocumentToUpload, CSVUploadSObjectFactory.newInstance(csvUploadToUse));
        try {
            Id scheduledApexBatchId = Database.executeBatch(processor, 3);
            csvUploadToUse.Apex_Batch_Id__c = scheduledApexBatchId;
            csvUploadToUse.Total_Records_To_Be_Processed__c = csvDocumentToUpload.getDocumentRowsCount();
            csvUploadToUse.Total_Records_Failed__c = 0;
            csvUploadToUse.Records_Created_Count__c = 0;
            csvUploadToUse.Records_Updated_Count__c = 0;
            csvUploadToUse.Processing_Status__c = Constant.CSV_UPLOAD_PT_QUEUED;
            update csvUploadToUse;
            PageReference csvUploadDetailsPage = Page.CSVUploadDetail;
            csvUploadDetailsPage.getParameters().put('id', csvUploadToUse.Id);
            returnValue = csvUploadDetailsPage;
        } catch (Exception exceptionToHandle) {
            Database.rollback(sp);
            ApexPages.addMessages(exceptionToHandle);
        }
        return returnValue;
    }
>>>>>>> refs/remotes/origin/master
>>>>>>> branch 'master' of https://github.com/cabinetoffice/Government-Grants-Information-System-Metadata
}