/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class dc3Plugin {
    global dc3Plugin() {

    }
global class DefaultConvert implements dupcheck.dc3Plugin.InterfaceConvert {
    global DefaultConvert() {

    }
    global void afterConvert(Database.LeadConvertResult leadConvertResult, Task taskData) {

    }
    global void beforeConvert(Database.LeadConvert leadConvertData) {

    }
    global void convertFailed(Database.LeadConvert leadConvertData, dupcheck.dc3Exception.ConvertException exceptionData) {

    }
}
global class DefaultMerge implements dupcheck.dc3Plugin.InterfaceMerge {
    global DefaultMerge() {

    }
    global void afterMerge(String objectPrefix, SObject masterRecord, Set<Id> mergedRecordIds) {

    }
    global void beforeMerge(String objectPrefix, SObject masterRecord, List<SObject> mergedRecordList) {

    }
    global void mergeFailed(String objectPrefix, SObject masterRecord, Set<Id> mergedRecordsIds, dupcheck.dc3Exception.MergeException exceptionData) {

    }
}
global class DefaultPrevention implements dupcheck.dc3Plugin.InterfacePrevention {
    global DefaultPrevention() {

    }
    global void processStatus(Set<Id> recordIdSet, dupcheck.dc3Plugin.PreventionStatus status) {

    }
}
global class DefaultSearch implements dupcheck.dc3Plugin.InterfaceSearch {
    global DefaultSearch() {

    }
    global void processResults(String methodName, Id sourceId, Map<String,List<dupcheck.dc3SearchResult>> searchResults) {

    }
}
global interface InterfaceConvert {
}
global interface InterfaceMerge {
}
global interface InterfacePrevention {
}
global interface InterfaceSearch {
}
global enum PreventionStatus {DELTA, DIRECT, DUPLICATE, OVERRIDDEN, UNIQUE, WEB2LEAD}
}
