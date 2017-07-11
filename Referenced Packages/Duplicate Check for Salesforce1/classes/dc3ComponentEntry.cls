/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class dc3ComponentEntry {
    global String assetsUrl;
    global String cssUrl {
        get;
        set;
    }
    global String dateFormat {
        get;
        set;
    }
    global String entryStage {
        get;
        set;
    }
    global Boolean isClone {
        get;
        set;
    }
    global Boolean isDev {
        get;
        set;
    }
    global dupcheck.dc3License license {
        get;
        set;
    }
    global Boolean noAccess {
        get;
        set;
    }
    global Id objectId {
        get;
        set;
    }
    global Id objectIdSet {
        get;
        set;
    }
    global String objectInput {
        get;
        set;
    }
    global dupcheck.dc3Meta.objectMeta objectMeta {
        get;
        set;
    }
    global String objectPrefix {
        get;
        set;
    }
    global String objectPrefixSet {
        get;
        set;
    }
    global Id recordTypeId {
        get;
        set;
    }
    global Id recordTypeIdSet {
        get;
        set;
    }
    global String returnUrl {
        get;
        set;
    }
    global Boolean saveAndNew {
        get;
        set;
    }
    global dupcheck.dc3Settings settings {
        get;
        set;
    }
    global String staticUrl;
    global dc3ComponentEntry() {

    }
    @RemoteAction
    global static Object doSaveOrClone(String objectPrefix, String recordType, Id recordId, Boolean doClone, Map<String,String> inputData) {
        return null;
    }
    @RemoteAction
    global static Object doSave(String objectPrefix, String recordType, Id recordId, Map<String,String> inputData) {
        return null;
    }
    @RemoteAction
    global static Object doSearch(String objectPrefix, Id recordTypeId, Id recordId, Map<String,String> inputData) {
        return null;
    }
    global String getAssetsUrl() {
        return null;
    }
    @RemoteAction
    global static Object getLayout(String prefix, Id recordTypeId, Id recordId) {
        return null;
    }
    @RemoteAction
    global static Object getLayoutData(String prefix, Id recordTypeId, Id recordId, String dataString) {
        return null;
    }
    @RemoteAction
    global static Object getObjectList() {
        return null;
    }
    @RemoteAction
    global static Object getRecordTypeList(String prefix) {
        return null;
    }
    @RemoteAction
    global static Map<String,Object> getRelatedTypeAheadAdvanced(String objectName, String objectQuery, List<String> additionalFields) {
        return null;
    }
    @RemoteAction
    global static List<dupcheck.dc3HelperGlobal.relatedInformation> getRelatedTypeAhead(String objectName, String objectQuery) {
        return null;
    }
    global String getStaticUrl() {
        return null;
    }
    global String getStorageName() {
        return null;
    }
}
