/******************************************************************************************
@Author         Daniel Lagar
@Date           26/10/2016
@Project        Cloud Sherpas Cabinet Office Data Source
@Description    Trigger to calculate the Financial Year of Grant Schemes
*******************************************************************************************/
Public Class GrantFYcal{ 
    public static void GrantFinancialYear(list<Grant_Award__c> piNewList){
        For(Grant_Award__c GS : piNewList){
            If(gs.Award_End_Date__c == NULL){
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
            intSD = GS.Award_Start_Date__c.year();
            intED = GS.Award_End_Date__c.year();
            
            strSD = string.valueOf(intSD);
            strED = string.valueOf(intED);
            strSDyear = strSD.mid(2, 2);
            strEDyear = strED.mid(2, 2);
            intSDyear = integer.valueOf(strSDyear);
            intEDyear = integer.valueOf(strEDyear);
            intDuration = integer.valueOf(gs.Award_Duration_number__c);
            
            date dt = date.valueOf('1914-12-31');
            If(GS.Award_Start_Date__c <= dt){
                system.debug('im here');
                strFY = 'FY 14/15';
            }
            Else{
                For(Integer i = 0; i < intDuration; i++){
                   
                   
            
                    system.debug('Award_Start_Date__c    ' + GS.Award_Start_Date__c + '     ' +  GS.Award_Start_Date__c.month());
                    system.debug('End Date    ' + GS.Award_End_Date__c + '     ' +  GS.Award_End_Date__c.month());
                    
<<<<<<< HEAD
                    /**If(i == intED && GS.Award_End_Date__c.month() < 4 && GS.Award_Start_Date__c.month() >= 4){
                        
                        break;
                    }**/
                    
                    If(GS.Award_Start_Date__c.month() >= 4 && GS.Award_End_Date__c.month()<=12){
                        If(intSDyear == 99){
                            system.debug('first if');
                            strFY = strFY + 'FY ' + string.valueOf(intSDyear) + '/' + '00' + ';';
                        }
                        Else {
                            strFY = strFY + 'FY ' + string.valueOf(intSDyear) + '/' + string.valueOf((intSDyear+1)) + ';'; 
                        }
                        
                    }
                    Else If(GS.Award_Start_Date__c.month() < 4 && GS.Award_End_Date__c.month()<=12){
                        If(intSDyear == 0){
                            system.debug('second if');
                            strFY = strFY + 'FY ' + '99' + '/' + '00' + ';';
                        }
                        Else{
                            strFY = strFY + 'FY ' + string.valueOf((intSDyear-1)) + '/' + string.valueOf(intSDyear) + ';'; 
                        }
                        
                    }
                    
=======
<<<<<<< HEAD
                    /**If(i == intED && GS.Award_End_Date__c.month() < 4 && GS.Award_Start_Date__c.month() >= 4){
                        
                        break;
                    }**/
                    
                    If(GS.Award_Start_Date__c.month() >= 4 && GS.Award_End_Date__c.month()<=12){
                        If(intSDyear == 99){
                            system.debug('first if');
                            strFY = strFY + 'FY ' + string.valueOf(intSDyear) + '/' + '00' + ';';
                        }
                        Else {
                            strFY = strFY + 'FY ' + string.valueOf(intSDyear) + '/' + string.valueOf((intSDyear+1)) + ';'; 
                        }
                        
                    }
                    Else If(GS.Award_Start_Date__c.month() < 4 && GS.Award_End_Date__c.month()<=12){
                        If(intSDyear == 0){
                            system.debug('second if');
                            strFY = strFY + 'FY ' + '99' + '/' + '00' + ';';
                        }
                        Else{
                            strFY = strFY + 'FY ' + string.valueOf((intSDyear-1)) + '/' + string.valueOf(intSDyear) + ';'; 
                        }
                        
                    }
                    
=======
<<<<<<< HEAD
                    /**If(i == intED && GS.Award_End_Date__c.month() < 4 && GS.Award_Start_Date__c.month() >= 4){
                        
                        break;
                    }**/
                    
                    If(GS.Award_Start_Date__c.month() >= 4 && GS.Award_End_Date__c.month()<=12){
                        If(intSDyear == 99){
                            system.debug('first if');
                            strFY = strFY + 'FY ' + string.valueOf(intSDyear) + '/' + '00' + ';';
                        }
                        Else {
                            strFY = strFY + 'FY ' + string.valueOf(intSDyear) + '/' + string.valueOf((intSDyear+1)) + ';'; 
                        }
                        
                    }
                    Else If(GS.Award_Start_Date__c.month() < 4 && GS.Award_End_Date__c.month()<=12){
                        If(intSDyear == 0){
                            system.debug('second if');
                            strFY = strFY + 'FY ' + '99' + '/' + '00' + ';';
                        }
                        Else{
                            strFY = strFY + 'FY ' + string.valueOf((intSDyear-1)) + '/' + string.valueOf(intSDyear) + ';'; 
                        }
                        
                    }
                    
=======
                    If(i == intED && GS.Award_End_Date__c.month() < 4 && GS.Award_Start_Date__c.month() >= 4){
                        
                        break;
                    }
                    
                    If(GS.Award_Start_Date__c.month() >= 4 && GS.Award_End_Date__c.month()<=12){
                        If(intSDyear == 99){
                            system.debug('first if');
                            strFY = strFY + 'FY ' + string.valueOf(intSDyear) + '/' + '00' + ';';
                        }
                        Else {
                            strFY = strFY + 'FY ' + string.valueOf(intSDyear) + '/' + string.valueOf((intSDyear+1)) + ';'; 
                        }
                        
                    }
                    Else If(GS.Award_Start_Date__c.month() < 4 && GS.Award_End_Date__c.month()<=12){
                        If(intSDyear == 99){
                            system.debug('second if');
                            strFY = strFY + 'FY ' + string.valueOf(intSDyear) + '/' + '00' + ';';
                        }
                        strFY = strFY + 'FY ' + string.valueOf((intSDyear-1)) + '/' + string.valueOf(intSDyear) + ';'; 
                    }
>>>>>>> refs/remotes/origin/master
>>>>>>> branch 'master' of https://github.com/cabinetoffice/Government-Grants-Information-System-Metadata
>>>>>>> branch 'master' of https://github.com/cabinetoffice/Government-Grants-Information-System-Metadata
                    if(intSDyear < 99){
                        intSDyear++; 
                    }
                    Else{
                        intSDyear = 0;
                    }
                        
                   
                }
            }
            system.debug('String FY    ' + strFY);
            gs.Financial_Year__c = strFY;
        }
     }
}