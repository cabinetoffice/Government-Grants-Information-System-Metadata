public without sharing class BS_SendDeletionNotification {
    public BS_SendDeletionNotification() {
        grantAwardFields = Schema.getGlobalDescribe().get('Grant_Award__c').getDescribe().fields.getMap().keySet();
        grantSchemeFields = Schema.getGlobalDescribe().get('Grant_Scheme__c').getDescribe().fields.getMap().keySet();

    }

    Set<String> grantAwardFields;
    Set<String> grantSchemeFields;


    public boolean deleteRecords(Map<Id, SObject> recordsDeleted) {
        List<Id> keys = new List<Id>();
        keys.addAll(recordsDeleted.keySet());
        Schema.SObjectType listType = keys[0].getSObjectType();
        List<Messaging.EmailFileAttachment> attachments = new List<Messaging.EmailFileAttachment>();
        if (String.valueOf(listType) == 'Grant_Scheme__c') {

            String soql = 'SELECT ';
            for (String fieldName : grantSchemeFields) {
                soql += fieldName + ',';
            }
            soql = soql.left(soql.lastIndexOf(','));
            //adding filters and running query
            soql += ' FROM Grant_Scheme__c WHERE Id IN :keys';
            attachments.add(createAttachment(grantSchemeFields,  recordsDeleted.values(), 'Deleted Grant Schemes'));
            List<SObject> grantAwards = retrieveRelatedGrantAwards(recordsDeleted);
            if (!grantAwards.isEmpty()) {
                attachments.add(createAttachment(grantAwardFields, grantAwards, 'Deleted Grant Awards'));
            }
        } else if (String.valueOf(listType) == 'Grant_Award__c') {
            attachments.add(createAttachment(grantAwardFields, recordsDeleted.values(), 'Deleted Grant Awards'));
        }
        sendEmail(attachments);
        return true;
    }

    public List<SObject> retrieveRelatedGrantAwards(Map<Id, SObject> schemesToDel) {
        //Building query to retrieve all fields in Grant Awards
        String soql = 'SELECT ';
        for (String fieldName : grantAwardFields) {
            soql += fieldName + ',';
        }
        soql = soql.left(soql.lastIndexOf(','));
        //adding filters and running query
        Set<Id> schemeIds = schemesToDel.keySet();
        soql += ' FROM Grant_Award__c WHERE Grant_Scheme__c IN :schemeIds';
        return Database.query(soql);
    }

    public Messaging.EmailFileAttachment createAttachment(Set<String> fieldNames, List<SObject> records, String attachmentName) {

        //building the header row
        String headerString;
        for (String fieldName : fieldNames) {
            if (String.isBlank(headerString)) {
                headerString = fieldName;
            } else {
                headerString += ',' + fieldName;
            }
        }
        headerString += ' \n';
        //adding records to a string in a .csv format
        String recordRow;
        for (SObject so : records) {
            for (String fieldName : fieldNames) {
                if (String.isBlank(recordRow)) {
                    recordRow = '"' + so.get(fieldName) + '"' + ',';
                } else {
                    recordRow = recordRow + '"' + so.get(fieldName) + '"' + ',';
                }
            }
            recordRow += '\n';
            System.debug(loggingLevel.Error, '*** recordRow: ' + recordRow);
        }
        String finalString = headerString + recordRow;

        //Building attachment
        Messaging.EmailFileAttachment csvAttachment = new Messaging.EmailFileAttachment();
        Blob csvBlob = Blob.valueOf(finalString);
        csvAttachment.setFileName(attachmentName + '-' + Date.today() + '-' + System.now() + '.csv');
        csvAttachment.setBody(csvBlob);

        return csvAttachment;
    }

    public void sendEmail(List<Messaging.EmailFileAttachment> attachments) {
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        List<String> toAddress = new List<String> {'bhushan.k.sukumar@accenture.com'};
        String emailSubject = 'Grant Record Deletion Notification';
        email.setSubject(emailSubject);
        email.setToAddresses(toAddress);
        email.setPlainTextBody('This is the email body text');
        email.setFileAttachments(attachments);
        Messaging.SendEmailResult [] emailResult = Messaging.SendEmail(
                    new Messaging.SingleEmailMessage[] {email});
    }
}