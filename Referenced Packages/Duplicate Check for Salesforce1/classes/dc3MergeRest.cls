/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
@RestResource(urlMapping='/dc3Merge/*')
global class dc3MergeRest {
    global dc3MergeRest() {

    }
    @HttpPost
    global static Boolean doMerge(dupcheck.dc3MergeRest.MergeInput mergeInput) {
        return null;
    }
global class MergeInput {
    global SObject masterObject {
        get;
        set;
    }
    global String mergeData {
        get;
        set;
    }
    global List<SObject> objectList {
        get;
        set;
    }
    global String objectPrefix {
        get;
        set;
    }
    global MergeInput() {

    }
    global String toJson() {
        return null;
    }
}
}
