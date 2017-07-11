/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class dc3HelperGlobal {
    global dc3HelperGlobal() {

    }
    global static Map<String,Object> getRelatedTypeAheadAdvanced(String objectName, String objectQuery, List<String> additionalFields) {
        return null;
    }
    global static List<dupcheck.dc3HelperGlobal.relatedInformation> getRelatedTypeAhead(String objectName, String objectQuery) {
        return null;
    }
    global static void setPreventionStatus(Id recordId, dupcheck.dc3Plugin.PreventionStatus status) {

    }
    global static void setPreventionStatus(Set<Id> recordIdSet, dupcheck.dc3Plugin.PreventionStatus status) {

    }
global class relatedInformation {
    global String id {
        get;
        set;
    }
    global String name {
        get;
        set;
    }
    global relatedInformation() {

    }
}
global class remoteResult {
    global String errorMessage {
        get;
        set;
    }
    global Boolean isError {
        get;
        set;
    }
    global Integer totalItems {
        get;
        set;
    }
    global Integer totalPages {
        get;
        set;
    }
    global Object value {
        get;
        set;
    }
    global remoteResult() {

    }
}
}
