/******************************************************************************************
@Author         Bhushan Sukumar
@Date           21 Mar 2016
@Project        Cloud Sherpas Cabinet Office Data Source
@Description    This is an extension class for the GrantSchemePrivilegeBanner VF banner. The
rendering logic of the warning messages are handled in this class
*******************************************************************************************/
public with sharing class GrantSchemePrivilegeBannerExt {
    private final ApexPages.StandardController stdCon;
    
    public GrantSchemePrivilegeBannerExt(ApexPages.StandardController stdCon) {
        this.stdCon = stdCon;
    }

    public Integer getCountOfRelatedIntermediaries() {
        return [
            SELECT COUNT()
            FROM Intermediary__c
            WHERE Grant_Scheme__c = :stdCon.getId()
            LIMIT 1
        ];
    }
}