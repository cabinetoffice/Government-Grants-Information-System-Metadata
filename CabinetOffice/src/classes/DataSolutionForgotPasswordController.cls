/**
 * An apex page controller that exposes the site forgot password functionality
 */
public with sharing class DataSolutionForgotPasswordController {
    public String username {get; set;}   
	
  	public PageReference forgotPassword() {
  		Boolean success = Site.forgotPassword(username);
        PageReference pr = Page.DataSolutionForgotPasswordConfirm;
  		pr.setRedirect(false);
  		
  		if (success) {  			
  			return pr;
  		}
  		return null;
  	}

    // method called in the page to throw an error for blank usernames
    public void addMessages() {
        ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR, Constant.FORGOT_PASSWORD_ERROR));
    }
}