/******************************************************************************************
@Author         Daniel Lagar
@Date           26/10/2016
@Project        Cloud Sherpas Cabinet Office Data Source
@Description    Trigger to calculate the Financial Year of Grant Schemes
*******************************************************************************************/
Public Class FYcal{ 
    public static void FinancialYear(list<Grant_Scheme__c> piNewList){
        For(Grant_Scheme__c GS : piNewList){
            If(gs.End_Date__c == NULL){
                continue;
            }
            string strFY = '';
            string strSD = '';
            string strED = '';
            string strSDyear = '';
            string strEDyear = '';
            integer intSD = 0;
            integer intED = 0;
            integer intSDyear = 0;
            integer intEDyear = 0;
            integer intDuration = 0;
            intSD = GS.Start_Date__c.year();
            intED = GS.End_Date__c.year();
            
            strSD = string.valueOf(intSD);
            strED = string.valueOf(intED);
            strSDyear = strSD.mid(2, 2);
            strEDyear = strED.mid(2, 2);
            intSDyear = integer.valueOf(strSDyear);
            intEDyear = integer.valueOf(strEDyear);
            intDuration = integer.valueOf(gs.Duration__C);
            
            system.debug('intSD   ' + intSD);
            system.debug('intED   ' + intED);
            system.debug('GS start date       ' + GS.Start_Date__c.format());
            
            date dt = date.valueOf('1914-12-31');
            If(GS.Start_Date__c <= dt){
                system.debug('im here');
                strFY = 'FY 14/15';
            }
            Else{
                For(Integer i = 0; i < intDuration; i++){
                   
                   
            
                    system.debug('Start_Date__c    ' + GS.Start_Date__c + '     ' +  GS.Start_Date__c.month());
                    system.debug('End Date    ' + GS.End_Date__c + '     ' +  GS.End_Date__c.month());
                    
                If(i == intED && GS.End_Date__c.month() < 4 && GS.Start_Date__c.month() >= 4){
                        
                        break;
                    }
                    
                    If(GS.Start_Date__c.month() >= 4 && GS.End_Date__c.month()<=12){
                        If(strSD == '1999'){
                            strFY = strFY + 'FY ' + string.valueOf(intSDyear) + '/' + '00' + ';';
                        }
                        Else {
                            strFY = strFY + 'FY ' + string.valueOf(intSDyear) + '/' + string.valueOf((intSDyear+1)) + ';'; 
                        }
                        
                    }
                    Else If(GS.Start_Date__c.month() < 4 && GS.End_Date__c.month()<=12){
                        If(strSD == '1999'){
                            strFY = strFY + 'FY ' + string.valueOf(intSDyear) + '/' + '00' + ';';
                        }
                        Else{
                            strFY = strFY + 'FY ' + string.valueOf((intSDyear-1)) + '/' + string.valueOf(intSDyear) + ';'; 
                        }
                        
                    }
                   intSDyear++; 
                }
            }
            system.debug('String FY    ' + strFY);
            gs.Financial_Year_Multi__c = strFY;
        }
     }
}