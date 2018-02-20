//****************************************************************************
// Author:         Alexander Cross
// Name:           CH_CompanySearchPageExtTestClass
// Creation Date:  14/03/2017
// Description:    Test Class for Company House Intergration Page
//****************************************************************************

@isTest
public class CH_CompanySearchPageExtTestClass {
    //Test cancel button
    public static testMethod void testCancel() {
        test.startTest();
        
        PageReference pageRef = Page.CH_CompanySearch;
        Test.setCurrentPage(PageRef);
        
        CH_CompanySearchPageExtClass cnt = new CH_CompanySearchPageExtClass();
        
        cnt.cancelCS();
        
        test.stopTest();
    }
    //Test search button with no results
    public static testMethod void testSearchNoReults() {
        test.startTest();
        
        PageReference pageRef = Page.CH_CompanySearch;
        Test.setCurrentPage(PageRef);
        
        CH_CompanySearchPageExtClass cnt = new CH_CompanySearchPageExtClass();
        
        Test.setMock(HttpCalloutMock.class, new CH_MockAPIResponse());
        
        cnt.strSearchTerm = 'zero';
        cnt.searchCS();
        
        test.stopTest();
    }
    //Test search button with results
    public static testMethod void testSearchReults() {
        test.startTest();
        
        PageReference pageRef = Page.CH_CompanySearch;
        Test.setCurrentPage(PageRef);
        
        CH_CompanySearchPageExtClass cnt = new CH_CompanySearchPageExtClass();
        
        Test.setMock(HttpCalloutMock.class, new CH_MockAPIResponse());
        
        cnt.strSearchTerm = 'some';
        cnt.searchCS();
        
        test.stopTest();
    }
    //Test search button not 200
    public static testMethod void testSearchNot200() {
        test.startTest();
        
        PageReference pageRef = Page.CH_CompanySearch;
        Test.setCurrentPage(PageRef);
        
        CH_CompanySearchPageExtClass cnt = new CH_CompanySearchPageExtClass();
        
        Test.setMock(HttpCalloutMock.class, new CH_MockAPIResponse());
        
        cnt.strSearchTerm = 'fail';
        cnt.searchCS();
        
        test.stopTest();
    }
    //Test search button fail web service
    public static testMethod void testSearchFailWS() {
        test.startTest();
        
        PageReference pageRef = Page.CH_CompanySearch;
        Test.setCurrentPage(PageRef);
        
        CH_CompanySearchPageExtClass cnt = new CH_CompanySearchPageExtClass();
        
        cnt.strSearchTerm = 'fail';
        cnt.searchCS();
        
        test.stopTest();
    }
    //Test selecting result
    public static testMethod void testSelectResult() {
        test.startTest();
        
        PageReference pageRef = Page.CH_CompanySearch;
        Test.setCurrentPage(PageRef);
        
        CH_CompanySearchPageExtClass cnt = new CH_CompanySearchPageExtClass();
        
        cnt.setComp();
        
        test.stopTest();
    }
    //Test create button no record selected
    public static testMethod void testCreateNoRecord() {
        test.startTest();
        
        PageReference pageRef = Page.CH_CompanySearch;
        Test.setCurrentPage(PageRef);
        
        CH_CompanySearchPageExtClass cnt = new CH_CompanySearchPageExtClass();
        
        cnt.CreateCS();
        
        test.stopTest();
    }
    //Test create button with record selected
    public static testMethod void testCreateRecord() {
        test.startTest();
        
        PageReference pageRef = Page.CH_CompanySearch;
        Test.setCurrentPage(PageRef);
        
        CH_CompanySearchPageExtClass cnt = new CH_CompanySearchPageExtClass();
        
        Test.setMock(HttpCalloutMock.class, new CH_MockAPIResponse());
        
        cnt.strSearchTerm = 'some';
        cnt.searchCS();
        
        cnt.strSelected = cnt.ListItems[0].company_number;
        
        cnt.CreateCS();
        
        test.stopTest();
    }
}