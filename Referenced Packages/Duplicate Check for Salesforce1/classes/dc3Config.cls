/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class dc3Config {
    global Integer batchDedupChunkSize {
        get;
        set;
    }
    global Integer batchIndexChunkSize {
        get;
        set;
    }
    global String cardIcon {
        get;
        set;
    }
    global Id configId {
        get;
        set;
    }
    global Boolean crossObject {
        get;
        set;
    }
    global Set<String> directConvertOn {
        get;
        set;
    }
    global String directConvertStatus {
        get;
        set;
    }
    global Integer directConvertThreshold {
        get;
        set;
    }
    global Set<String> directMergeOn {
        get;
        set;
    }
    global Integer directMergeThreshold {
        get;
        set;
    }
    global Integer directThreshold {
        get;
        set;
    }
    global Boolean enforceSharing {
        get;
        set;
    }
    global String icon {
        get;
        set;
    }
    global Boolean indexCreate {
        get;
        set;
    }
    global String indexCustomIndexField {
        get;
        set;
    }
    global String indexCustomObject {
        get;
        set;
    }
    global String indexCustomRecordTypeField {
        get;
        set;
    }
    global String indexField {
        get;
        set;
    }
    global Integer indexQueryLimit {
        get;
        set;
    }
    global Boolean indexWildcard {
        get;
        set;
    }
    global Boolean isDelta {
        get;
        set;
    }
    global Boolean isDirectConvert {
        get;
        set;
    }
    global Boolean isDirectMerge {
        get;
        set;
    }
    global Boolean isLogging {
        get;
        set;
    }
    global Boolean isRecordType {
        get;
        set;
    }
    global String leadConvertOwner {
        get;
        set;
    }
    global String leadConvertStatus {
        get;
        set;
    }
    global Set<String> mergeDisable {
        get;
        set;
    }
    global String mergeFallback {
        get;
        set;
    }
    global Boolean mergeFeed {
        get;
        set;
    }
    global Set<String> mergeFieldIgnore {
        get;
        set;
    }
    global Boolean mergeOverride {
        get;
        set;
    }
    global String mergeRule {
        get;
        set;
    }
    global Set<String> mergeUnique {
        get;
        set;
    }
    global String objectLabel {
        get;
        set;
    }
    global String objectLabelPlural {
        get;
        set;
    }
    global String objectName {
        get;
        set;
    }
    global String objectNameCorrect {
        get;
        set;
    }
    global String objectPrefix {
        get;
        set;
    }
    global Integer recordCount {
        get;
        set;
    }
    global String sldsIcon {
        get;
        set;
    }
    global dc3Config(dupcheck__dcObject__c objectItem, Boolean isComplete) {

    }
    global dc3Config(String objectPrefix, Boolean isComplete) {

    }
    global void buildResultFieldConfig() {

    }
    global void buildScenarioConfig() {

    }
    global Set<String> builtDisplayFieldList(Set<String> fieldList) {
        return null;
    }
    global Set<String> getAllConfiguredFields() {
        return null;
    }
    global List<dupcheck.dc3Config.ResultField> getAllResultFields() {
        return null;
    }
    global List<dupcheck.dc3Config.ScenarioField> getAllScenarioFields() {
        return null;
    }
    global String getCorrectObject() {
        return null;
    }
    global String getCorrectObjectPrefix() {
        return null;
    }
    global Map<String,dupcheck.dc3Config.CrossObject> getCrossObject() {
        return null;
    }
    global String getFieldQueryByIds(Set<Id> recordIds) {
        return null;
    }
    global Map<String,String> getIndexFields() {
        return null;
    }
    global Map<String,dupcheck.dc3Config.MergeField> getMergeConfig() {
        return null;
    }
    global String getQuery() {
        return null;
    }
    global String getQueryByIdsPart(Set<Id> recordIds) {
        return null;
    }
    global String getQueryByIds(Set<Id> recordIds) {
        return null;
    }
    global dupcheck.dc3Config.RecordTypeConfig getRecordType(Id recordType) {
        return null;
    }
    global List<dupcheck.dc3Config.RecordTypeConfig> getRecordTypeConfig() {
        return null;
    }
    global dupcheck.dc3Config.ResultCard getResultCard() {
        return null;
    }
    global List<dupcheck.dc3Config.ResultField> getResultField() {
        return null;
    }
    global List<dupcheck.dc3Config.Scenario> getScenarioByIds(Set<Id> scenarioIds) {
        return null;
    }
    global Set<String> getScenarioFieldsByFeature(Set<dupcheck.dc3Constant.Feature> onFeatureList) {
        return null;
    }
    global List<Id> getScenarioIdsByFeature(Set<dupcheck.dc3Constant.Feature> onFeatureList) {
        return null;
    }
    global List<dupcheck.dc3Config.Scenario> getScenario() {
        return null;
    }
    global List<dupcheck.dc3Config.Scenario> getScenario(Id recordType) {
        return null;
    }
    global List<dupcheck.dc3Config.Scenario> getScenariosByFeature(Set<dupcheck.dc3Constant.Feature> onFeatureList) {
        return null;
    }
    global List<dupcheck.dc3Config.Scenario> getScenariosByFeature(Set<dupcheck.dc3Constant.Feature> onFeatureList, Id recordTypeId) {
        return null;
    }
    global String getUpdateableFieldQueryByIds(Set<Id> recordIds, Boolean isLookup, Set<String> extraFieldList) {
        return null;
    }
    global Boolean isComplete() {
        return null;
    }
    global Boolean isPersonAccount() {
        return null;
    }
    global Boolean isScenarioField(String fieldName) {
        return null;
    }
global class CrossObject {
    global Id configId {
        get;
        set;
    }
    global String correctObjectName {
        get;
        set;
    }
    global String correctObjectPrefix {
        get;
        set;
    }
    global List<dupcheck.dc3Config.CrossObjectField> fieldMapping {
        get;
        set;
    }
    global String objectLabel {
        get;
        set;
    }
    global String objectName {
        get;
        set;
    }
    global String objectPrefix {
        get;
        set;
    }
    global CrossObject() {

    }
}
global class CrossObjectField {
    global Id fieldId {
        get;
        set;
    }
    global String fromField {
        get;
        set;
    }
    global String toField {
        get;
        set;
    }
    global CrossObjectField() {

    }
}
global class MergeField implements System.Comparable {
    global Boolean allowEmpty {
        get;
        set;
    }
    global String fallbackRule {
        get;
        set;
    }
    global String fieldLabel {
        get;
        set;
    }
    global String fieldName {
        get;
        set;
    }
    global Schema.DisplayType fieldType {
        get;
        set;
    }
    global Id mergeFieldId {
        get;
        set;
    }
    global String mergeRule {
        get;
        set;
    }
    global Id objectConfigId {
        get;
        set;
    }
    global Boolean readOnly {
        get;
        set;
    }
    global MergeField() {

    }
}
global class RecordTypeConfig {
    global Set<Id> matchWith {
        get;
        set;
    }
    global String name {
        get;
        set;
    }
    global Id recordTypeId {
        get;
        set;
    }
    global Set<Id> scenarios {
        get;
        set;
    }
    global RecordTypeConfig() {

    }
    global String getMatchWithIds() {
        return null;
    }
    global String getScenarioIds() {
        return null;
    }
}
global class ResultCard {
    global List<dupcheck.dc3Config.ResultField> fieldList {
        get;
        set;
    }
    global dupcheck.dc3Config.ResultField header {
        get;
        set;
    }
    global ResultCard() {

    }
}
global class ResultField implements System.Comparable {
    global String fieldLabel {
        get;
        set;
    }
    global String fieldName {
        get;
        set;
    }
    global Id recordTypeId {
        get;
        set;
    }
    global Id resultFieldId {
        get;
        set;
    }
    global Integer sortOrder {
        get;
        set;
    }
    global ResultField() {

    }
    global Integer compareTo(Object compareTo) {
        return null;
    }
}
global class Scenario {
    global List<String> actionList {
        get;
        set;
    }
    global Id configId {
        get;
        set;
    }
    global Boolean onApi {
        get;
        set;
    }
    global Boolean onBatch {
        get;
        set;
    }
    global Boolean onCheck {
        get;
        set;
    }
    global Boolean onConvert {
        get;
        set;
    }
    global Boolean onDataApi {
        get;
        set;
    }
    global Boolean onDirect {
        get;
        set;
    }
    global Boolean onEntry {
        get;
        set;
    }
    global Boolean onInsert {
        get;
        set;
    }
    global Boolean onLayout {
        get;
        set;
    }
    global Boolean onRVInsert {
        get;
        set;
    }
    global Boolean onRVUpdate {
        get;
        set;
    }
    global Boolean onSearch {
        get;
        set;
    }
    global Boolean onUpdate {
        get;
        set;
    }
    global Boolean onUpload {
        get;
        set;
    }
    global Boolean onWeb2Lead {
        get;
        set;
    }
    global Id recordTypeId {
        get;
        set;
    }
    global Id scenarioId {
        get;
        set;
    }
    global String scenarioName {
        get;
        set;
    }
    global String scoreMethod {
        get;
        set;
    }
    global Integer threshold {
        get;
        set;
    }
    global Scenario() {

    }
    global List<dupcheck.dc3Config.ScenarioField> getScenarioFields() {
        return null;
    }
}
global class ScenarioField {
    global String field {
        get;
        set;
    }
    global String frequentList {
        get;
        set;
    }
    global String matchConfig {
        get;
        set;
    }
    global String matchMethod {
        get;
        set;
    }
    global Id scenarioFieldId {
        get;
        set;
    }
    global Integer weight {
        get;
        set;
    }
    global ScenarioField() {

    }
}
}
