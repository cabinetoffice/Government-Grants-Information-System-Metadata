/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class dc3DuplicateResult {
    global Integer duplicateCount {
        get;
        set;
    }
    global Map<String,Map<String,dupcheck.dc3Meta.fieldMeta>> fieldMeta {
        get;
        set;
    }
    global Map<String,dupcheck.dc3Meta.objectMeta> objectMeta {
        get;
        set;
    }
    global Map<String,List<Map<String,Object>>> searchResult {
        get;
        set;
    }
    global Map<String,List<dupcheck.dc3Config.ResultField>> searchResultField {
        get;
        set;
    }
    global dc3DuplicateResult(Map<String,List<dupcheck.dc3SearchResult>> searchResult) {

    }
}
