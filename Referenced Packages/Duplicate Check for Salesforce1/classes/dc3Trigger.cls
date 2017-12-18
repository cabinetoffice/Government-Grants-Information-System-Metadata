/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class dc3Trigger {
    global static Map<String,Boolean> disableStore;
    @Deprecated
    global static String identifier;
    global static Map<String,Map<String,Set<String>>> indexContainer;
    @Deprecated
    global static Map<Id,Map<String,Set<String>>> indexMap;
    global static Map<String,Integer> triggerCount;
    global static Set<Id> triggerIds;
    global dc3Trigger(Boolean isbef, Boolean isaft, Boolean isi, Boolean isup, Boolean isd, Boolean isud) {

    }
    global dc3Trigger(Boolean isbef, Boolean isaft, Boolean isi, Boolean isup, Boolean isd, Boolean isud, String d) {

    }
    global static void addTriggerId(Id recordId) {

    }
    global static Boolean containsDisable(String keyCode) {
        return null;
    }
    global static Boolean getDisable(String keyCode) {
        return null;
    }
    global static Map<String,Set<String>> getIndex(Id recordId) {
        return null;
    }
    global static Map<String,Set<String>> getIndex(String recordId) {
        return null;
    }
    global String getTriggerContext() {
        return null;
    }
    global static Boolean isInTrigger(Id recordId) {
        return null;
    }
    global String processTrigger(Map<Id,SObject> oldMap, List<SObject> newList) {
        return null;
    }
    global static void setDisable(String keyCode, Boolean isDisabled) {

    }
    global static void setIndex(Id recordId, Map<String,Set<String>> index) {

    }
    global static void setIndex(String recordId, Map<String,Set<String>> index) {

    }
}
