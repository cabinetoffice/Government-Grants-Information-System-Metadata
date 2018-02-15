@IsTest
private class DataSolutionForgotPasswordControllerTest {
     @IsTest
     private static void testForgotPasswordController() {
        // Instantiate a new controller with all parameters in the page
        DataSolutionForgotPasswordController controller = new DataSolutionForgotPasswordController();
        controller.username = 'test@salesforce.com';        
    
        System.assertEquals(controller.forgotPassword(),null); 
    }

    @isTest
    private static void addMessagesTest() {
        DataSolutionForgotPasswordController controller = new DataSolutionForgotPasswordController();
        controller.username = ''; 

        controller.addMessages();
        List<Apexpages.Message> pageMessages = ApexPages.getMessages();
        Boolean hasMessages = false;
        for(Apexpages.Message pageMessage:pageMessages){
            if (pageMessage.getDetail().contains(Constant.FORGOT_PASSWORD_ERROR)) hasMessages = true;
        }
        system.assert(hasMessages);
    }
}