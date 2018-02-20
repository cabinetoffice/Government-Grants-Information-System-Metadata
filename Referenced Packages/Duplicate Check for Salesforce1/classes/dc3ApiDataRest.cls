/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
@RestResource(urlMapping='/dc3DataApi/*')
global class dc3ApiDataRest {
    global dc3ApiDataRest() {

    }
    @HttpPost
    global static dupcheck.dc3ApiDataRest.UpsertDataOutput doUpsert(dupcheck.dc3ApiDataRest.UpsertDataInput input) {
        return null;
    }
global class RelatedDataInput {
    global Boolean duplicateCheck {
        get;
        set;
    }
    global Integer duplicateScore {
        get;
        set;
    }
    global Map<String,String> objectData {
        get;
        set;
    }
    global String objectType {
        get;
        set;
    }
    global String recordType {
        get;
        set;
    }
    global String referenceField {
        get;
        set;
    }
    global List<dupcheck.dc3ApiDataRest.RelatedDataInput> relatedList {
        get;
        set;
    }
    global RelatedDataInput() {

    }
}
global class RelatedDataOutput {
    global String errorMessage {
        get;
        set;
    }
    global Boolean isCreated {
        get;
        set;
    }
    global Boolean isSuccess {
        get;
        set;
    }
    global SObject objectData {
        get;
        set;
    }
    global Id objectId {
        get;
        set;
    }
    global List<dupcheck.dc3ApiDataRest.RelatedDataOutput> relatedList {
        get;
        set;
    }
    global RelatedDataOutput() {

    }
}
global class UpsertDataInput {
    global Boolean allOrNone {
        get;
        set;
    }
    global Boolean duplicateCheck {
        get;
        set;
    }
    global Integer duplicateScore {
        get;
        set;
    }
    global Map<String,String> objectData {
        get;
        set;
    }
    global String objectType {
        get;
        set;
    }
    global String recordType {
        get;
        set;
    }
    global List<dupcheck.dc3ApiDataRest.RelatedDataInput> relatedList {
        get;
        set;
    }
    global UpsertDataInput() {

    }
}
global class UpsertDataOutput {
    global String errorMessage {
        get;
        set;
    }
    global Boolean isCreated {
        get;
        set;
    }
    global Boolean isSuccess {
        get;
        set;
    }
    global SObject objectData {
        get;
        set;
    }
    global Id objectId {
        get;
        set;
    }
    global List<dupcheck.dc3ApiDataRest.RelatedDataOutput> relatedList {
        get;
        set;
    }
    global UpsertDataOutput() {

    }
}
}
