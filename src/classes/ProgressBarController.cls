<<<<<<< HEAD
/******************************************************************************************
@Author         Hamed Izadpanah
@Date           03/10/2015
@Project        Cloud Sherpas Cabinet Office Data Source
@Description    This is a custom component controller which helps with 
				calculating the percentage of the progress
*******************************************************************************************/
public with sharing class ProgressBarController {
	public Integer inputCompleteNumber {get; set;}
	public Integer inputCurrentNumber {get; set;}

	public Integer getProgressPercentage(){
		Decimal returnValue;
		try{
			returnValue = (Decimal.valueOf(inputCurrentNumber) / Decimal.valueOf(inputCompleteNumber)) * 100;
		}catch(Exception exceptionToHandle){
			System.debug('ProgressBarController.getProgressPercentage()->exceptionToHandle' + exceptionToHandle);
			returnValue = 0;
		}
		return returnValue.intValue();
	}
=======
<<<<<<< HEAD
/******************************************************************************************
@Author         Hamed Izadpanah
@Date           03/10/2015
@Project        Cloud Sherpas Cabinet Office Data Source
@Description    This is a custom component controller which helps with 
				calculating the percentage of the progress
*******************************************************************************************/
public with sharing class ProgressBarController {
	public Integer inputCompleteNumber {get; set;}
	public Integer inputCurrentNumber {get; set;}

	public Integer getProgressPercentage(){
		Decimal returnValue;
		try{
			returnValue = (Decimal.valueOf(inputCurrentNumber) / Decimal.valueOf(inputCompleteNumber)) * 100;
		}catch(Exception exceptionToHandle){
			System.debug('ProgressBarController.getProgressPercentage()->exceptionToHandle' + exceptionToHandle);
			returnValue = 0;
		}
		return returnValue.intValue();
	}
=======
<<<<<<< HEAD
/******************************************************************************************
@Author         Hamed Izadpanah
@Date           03/10/2015
@Project        Cloud Sherpas Cabinet Office Data Source
@Description    This is a custom component controller which helps with 
				calculating the percentage of the progress
*******************************************************************************************/
public with sharing class ProgressBarController {
	public Integer inputCompleteNumber {get; set;}
	public Integer inputCurrentNumber {get; set;}

	public Integer getProgressPercentage(){
		Decimal returnValue;
		try{
			returnValue = (Decimal.valueOf(inputCurrentNumber) / Decimal.valueOf(inputCompleteNumber)) * 100;
		}catch(Exception exceptionToHandle){
			System.debug('ProgressBarController.getProgressPercentage()->exceptionToHandle' + exceptionToHandle);
			returnValue = 0;
		}
		return returnValue.intValue();
	}
=======
<<<<<<< HEAD
/******************************************************************************************
@Author         Hamed Izadpanah
@Date           03/10/2015
@Project        Cloud Sherpas Cabinet Office Data Source
@Description    This is a custom component controller which helps with 
				calculating the percentage of the progress
*******************************************************************************************/
public with sharing class ProgressBarController {
	public Integer inputCompleteNumber {get; set;}
	public Integer inputCurrentNumber {get; set;}

	public Integer getProgressPercentage(){
		Decimal returnValue;
		try{
			returnValue = (Decimal.valueOf(inputCurrentNumber) / Decimal.valueOf(inputCompleteNumber)) * 100;
		}catch(Exception exceptionToHandle){
			System.debug('ProgressBarController.getProgressPercentage()->exceptionToHandle' + exceptionToHandle);
			returnValue = 0;
		}
		return returnValue.intValue();
	}
=======
/******************************************************************************************
@Author         Hamed Izadpanah
@Date           03/10/2015
@Project        Cloud Sherpas Cabinet Office Data Source
@Description    This is a custom component controller which helps with 
				calculating the percentage of the progress
*******************************************************************************************/
public with sharing class ProgressBarController {
	public Integer inputCompleteNumber {get; set;}
	public Integer inputCurrentNumber {get; set;}

	public Integer getProgressPercentage(){
		Decimal returnValue;
		try{
			returnValue = (Decimal.valueOf(inputCurrentNumber) / Decimal.valueOf(inputCompleteNumber)) * 100;
		}catch(Exception exceptionToHandle){
			System.debug('ProgressBarController.getProgressPercentage()->exceptionToHandle' + exceptionToHandle);
			returnValue = 0;
		}
		return returnValue.intValue();
	}
>>>>>>> refs/remotes/origin/master
>>>>>>> branch 'master' of https://github.com/cabinetoffice/Government-Grants-Information-System-Metadata
>>>>>>> branch 'master' of https://github.com/cabinetoffice/Government-Grants-Information-System-Metadata
>>>>>>> branch 'master' of https://github.com/cabinetoffice/Government-Grants-Information-System-Metadata
}