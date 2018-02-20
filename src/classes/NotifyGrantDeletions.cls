/******************************************************************************************
@Author         Bhushan Sukumar
@Date           14 Apr 2016
@Project        Cloud Sherpas Cabinet Office Data Source
@Description    This class is responsible for sending deletion notification email with the list
of Grant Schemes and Grant Awards that were deleted by the user in SF UI
*******************************************************************************************/

public without sharing class NotifyGrantDeletions {

    //Sets to hold the sfdc fields for Grant Awards and Grant Schemes
    Set<String> grantAwardFields;
    Set<String> grantSchemeFields;
    Set<String> programmeFields;

    public NotifyGrantDeletions() {
        //retrieving the API fields names for objects
        grantAwardFields = Schema.getGlobalDescribe().get(
                               Constant.SOBJECT_TYPE_GRANT_AWARD).getDescribe().fields.getMap().keySet();
        grantSchemeFields = Schema.getGlobalDescribe().get(
                                Constant.SOBJECT_TYPE_GRANT_SCHEME).getDescribe().fields.getMap().keySet();
        programmeFields = Schema.getGlobalDescribe().get(
                              Constant.SOBJECT_TYPE_PROGRAMME).getDescribe().fields.getMap().keySet();
    }

    /**
     * method to retrieve Grant Awards related to the given schemes
     * @author  Bhushan Sukumar
     * @date    14 Apr 2016
     * @param   schemesToDel  Schemes deleted by the admin
     * @return                list of related Grant awards
     */
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

    /**
     * generic method to query records and return it in a Sobject list
     * @author  Bhushan Sukumar
     * @date    14 Apr 2016
     * @param   sobjectType  type of the Sobject that needs to be queried
     * @param   filterSet    filter set that will be added to the query
     * @return               list of queried SObjects
     */
    public List<SObject> retrieveRecords(Schema.SObjectType sobjectType, Set<Id> filterSet) {
        //building soql dynamically based on the SObjectType
        String soql = 'SELECT ';
        if (String.valueOf(sobjectType) == Constant.SOBJECT_TYPE_GRANT_AWARD) {
            for (String fieldName : grantAwardFields) {
                soql += fieldName + ',';
            }
        } else if (String.valueOf(sobjectType) == Constant.SOBJECT_TYPE_GRANT_SCHEME) {
            for (String fieldName : grantSchemeFields) {
                soql += fieldName + ',';
            }
        } else if (String.valueOf(sobjectType) == Constant.SOBJECT_TYPE_PROGRAMME) {
            for (String fieldName : programmeFields) {
                soql += fieldName + ',';
            }
        } else {
            return new List<SObject>();
        }
        soql = soql.left(soql.lastIndexOf(','));
        soql += ' FROM ' + String.valueOf(sobjectType) + ' WHERE Id IN :filterSet';
        return Database.Query(soql);
    }

    /**
     * Creates a .csv attachment from the list of records and fields given
     * @author  Bhushan Sukumar
     * @date    14 Apr 2016
     * @param   fieldNames      SObject field API names
     * @param   records         list of SObject records that should be added to the .csv
     * @param   attachmentName  name of the attachment file
     * @return                  created email file attachment
     */
    public Messaging.EmailFileAttachment createAttachment(Set<String> fieldNames, List<SObject> records, String attachmentName) {
        //looping through the given fields and bulding the header row for the .csv
        String headerString;
        for (String fieldName : fieldNames) {
            if (String.isBlank(headerString)) {
                headerString = fieldName;
            } else {
                headerString += ',' + fieldName;
            }
        }
        headerString += ' \n';

        //looping through the SObject records and building up the record rows for the .csv
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
        }
        String finalString = headerString + recordRow;

        //Creating Email attachment
        Messaging.EmailFileAttachment csvAttachment = new Messaging.EmailFileAttachment();
        Blob csvBlob = Blob.valueOf(finalString);
        csvAttachment.setFileName(attachmentName);
        csvAttachment.setBody(csvBlob);

        return csvAttachment;
    }

    /**
     * Creates csv attachment for the given records and sends email to the Grant Hub Support
     * @author  Bhushan Sukumar
     * @date    14 Apr 2016
     * @param   recordsDeleted  records selected for deletion by the admin
     * @return                  email successful result
     */
    public boolean notifyGrantHubSupport(Map<Id, SObject> recordsDeleted) {
        //List to hold the email attachments.
        List<Messaging.EmailFileAttachment> attachments = new List<Messaging.EmailFileAttachment>();

        //Adding the ids to a list to determine the SObject Type of the list
        List<Id> keys = new List<Id>();
        keys.addAll(recordsDeleted.keySet());
        Schema.SObjectType listType = keys[0].getSObjectType();

        List<SObject> recordsToDelete = retrieveRecords(listType, recordsDeleted.keySet());
        //retrieving records for the appropriate SObjectType and then creating attachments from
        //the queried records
        if (String.valueOf(listType) == Constant.SOBJECT_TYPE_GRANT_SCHEME) {
            attachments.add(createAttachment(grantSchemeFields, recordsToDelete, Constant.CSV_ATTACH_NAME_GRANTSCHEMES));
            //retrieving the related Grant Awards
            List<SObject> grantAwards = retrieveRelatedGrantAwards(recordsDeleted);
            //creating an attachment for the 'Grant Awards'
            if (!grantAwards.isEmpty()) {
                attachments.add(createAttachment(
                                    grantAwardFields,
                                    grantAwards,
                                    Constant.CSV_ATTACH_NAME_GRANTAWARDS));
            }
        } else if (String.valueOf(listType) == Constant.SOBJECT_TYPE_GRANT_AWARD) {
            attachments.add(createAttachment(
                                grantAwardFields,
                                recordsToDelete,
                                Constant.CSV_ATTACH_NAME_GRANTAWARDS));
        } else if (String.valueOf(listType) == Constant.SOBJECT_TYPE_PROGRAMME) {
            attachments.add(createAttachment(
                                programmeFields,
                                recordsToDelete,
                                Constant.CSV_ATTACH_NAME_PROGRAMMES));
        }

        //calling method to send the attachments in an email to Grant Hub Support
        sendEmail(attachments);
        return true;
    }

    /**
     * method to send the deletion notification email to the support team
     * @author  Bhushan Sukumar
     * @date    14 Apr 2016
     * @param   attachments  list of email attachments(.csv)
     */
    public void sendEmail(List<Messaging.EmailFileAttachment> attachments) {
        //Instantiating new email message
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        //Retrieving all the email address to which the notifications should be sent
<<<<<<< HEAD
           List<Grant_Hub_Email_Address__mdt> addresses = [SELECT Email__c FROM Grant_Hub_Email_Address__mdt];
           List<String> toAddress = new List<String>();
           for (Grant_Hub_Email_Address__mdt address : addresses) {
           toAddress.add(address.Email__c);       
        }
        //building the email content and body
            if (!toAddress.isEmpty()) {
            String emailSubject = Label.Deletion_Notification_Email_Subject;
            email.setSenderDisplayName(label.Deletion_Notification);
=======
<<<<<<< HEAD
           List<Grant_Hub_Email_Address__mdt> addresses = [SELECT Email__c FROM Grant_Hub_Email_Address__mdt];
           List<String> toAddress = new List<String>();
           for (Grant_Hub_Email_Address__mdt address : addresses) {
           toAddress.add(address.Email__c);       
        }
        //building the email content and body
            if (!toAddress.isEmpty()) {
            String emailSubject = Label.Deletion_Notification_Email_Subject;
            email.setSenderDisplayName(label.Deletion_Notification);
=======
<<<<<<< HEAD
           List<Grant_Hub_Email_Address__mdt> addresses = [SELECT Email__c FROM Grant_Hub_Email_Address__mdt];
           List<String> toAddress = new List<String>();
           for (Grant_Hub_Email_Address__mdt address : addresses) {
           toAddress.add(address.Email__c);       
        }
        //building the email content and body
            if (!toAddress.isEmpty()) {
            String emailSubject = Label.Deletion_Notification_Email_Subject;
            email.setSenderDisplayName(label.Deletion_Notification);
=======
        List<Grant_Hub_Email_Address__mdt> addresses = [SELECT Email__c FROM Grant_Hub_Email_Address__mdt];
        List<String> toAddress = new List<String>();
        for (Grant_Hub_Email_Address__mdt address : addresses) {
            toAddress.add(address.Email__c);
        }

        //building the email content and body
        if (!toAddress.isEmpty()) {
            String emailSubject = Label.Deletion_Notification_Email_Subject;
>>>>>>> refs/remotes/origin/master
>>>>>>> branch 'master' of https://github.com/cabinetoffice/Government-Grants-Information-System-Metadata
>>>>>>> branch 'master' of https://github.com/cabinetoffice/Government-Grants-Information-System-Metadata
            email.setSubject(emailSubject);
            email.setToAddresses(toAddress);
            email.setHTMLBody(Label.Deletion_Notification_Email_Body);
            email.setPlainTextBody(Label.Deletion_Notification_Email_Body);
            email.setFileAttachments(attachments);
            //sending email
            Messaging.SendEmailResult [] emailResult = Messaging.SendEmail(
                        new Messaging.SingleEmailMessage[] {email});
        }
    }
}