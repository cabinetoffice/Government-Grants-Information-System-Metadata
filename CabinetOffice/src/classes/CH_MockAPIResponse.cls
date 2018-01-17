@isTest
global class CH_MockAPIResponse implements HttpCalloutMock {
    global HTTPResponse respond(HTTPRequest req) {
        String strEndP = req.getEndpoint();
        HttpResponse res = new HttpResponse();
        
        if(strEndP.contains('zero')) {
            res.setHeader('Content-Type', 'application/json');
            res.setBody('{"total_results" : 0}');
            res.setStatusCode(200);
        } else if (strEndP.contains('some')) {
            res.setHeader('Content-Type', 'application/json');
            res.setBody('{ "total_results" : 1,"items" : [{ "company_status" : "active","company_number" : "0123456","title" : "Test Comp","address" : {"address_line_1" : "Some Lane","postal_code" : "NE1 Here","premises" : "123","locality" : "Here"}}]}');
            res.setStatusCode(200);
        } else if (strEndP.contains('fail')) {
            res.setHeader('Content-Type', 'application/json');
            res.setBody('{"total_results" : 0}');
            res.setStatusCode(416);
        } else {
            res.setHeader('Content-Type', 'application/json');
            res.setBody('{"Test" : "Value"}');
            res.setStatusCode(200);
        }
        
        return res;
    }
}