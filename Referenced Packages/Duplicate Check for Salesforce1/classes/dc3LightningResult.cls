/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class dc3LightningResult {
    global Integer DuplicateCount {
        get;
        set;
    }
    global String FirstObject {
        get;
        set;
    }
    global List<dupcheck.dc3LightningResult.ObjectResult> ObjectResult {
        get;
        set;
    }
    global dc3LightningResult(Map<String,List<dupcheck.dc3SearchResult>> searchResult) {

    }
global class IterationMap {
    global String key {
        get;
        set;
    }
    global String value {
        get;
        set;
    }
    global IterationMap(String k, String v) {

    }
}
global class ObjectResult {
    @AuraEnabled
    global Integer DuplicateCount;
    @AuraEnabled
    global Boolean isActive;
    @AuraEnabled
    global Boolean isConvert;
    @AuraEnabled
    global Boolean isMerge;
    @AuraEnabled
    global String Label;
    @AuraEnabled
    global String ObjectName;
    @AuraEnabled
    global String Prefix;
    @AuraEnabled
    global List<dupcheck.dc3LightningResult.RecordResult> ResultData;
    @AuraEnabled
    global List<dupcheck.dc3LightningResult.IterationMap> ResultFields;
    global ObjectResult() {

    }
}
global class RecordResult {
    @AuraEnabled
    global Boolean isSelected;
    @AuraEnabled
    global Map<String,Object> ObjectData;
    @AuraEnabled
    global Integer score;
    global RecordResult() {

    }
}
}
