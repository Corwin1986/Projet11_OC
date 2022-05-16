@isTest
private class AccountWithoutOtherOrderTest{
    @isTest static void testAccountCA(){
      Integer nbAccount = 1;
      Integer nbOrder=1;
      Integer price=1;
      Integer quantity=1;
   List<Account> testAccounts =  TestDataFactory.createAccounts(nbAccount);
   List <Order> testOrders =  TestDataFactory.createOrdersForAccounts(testAccounts, nbOrder,price,quantity); 
        Test.startTest();
        for(Account account : testAccounts){
                if(account.Orders.isEmpty()){
                    System.assertEquals(False, account.NewActive__c);
                }else{
                    System.assertEquals(True, account.NewActive__c);
                }  
        
        }
        Test.stopTest();
      }
}