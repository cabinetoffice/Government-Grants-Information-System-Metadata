/*
This file is generated and isn't the actual source code for this
managed global class.
This read-only file shows the class's global constructors,
methods, variables, and properties.
To enable code to compile, all methods return null.
*/
global class dc3ComponentCheck {
    global String cssUrl {
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
    global dupcheck.dc3Config objectConfig {
        get;
        set;
    }
    global SObject objectData {
        get;
        set;
    }
    global String objectFieldName {
        get;
        set;
    }
    global Id objectId {
        get;
        set;
    }
    global dupcheck.dc3Settings settings {
        get;
        set;
    }
    global dc3ComponentCheck() {

    }
    @RemoteAction
    global static dupcheck.dc3HelperGlobal.remoteResult doCheck(Id recordId) {
        return null;
    }
    global String getAssetsUrl() {
        return null;
    }
    global String getAssetsUrlNew() {
        return null;
    }
    global String getAssetsUrlStatic() {
        return null;
    }
}
