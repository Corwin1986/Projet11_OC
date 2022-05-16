@isTest
private class OrderTriggerTest{
    @isTest static void testAccountCA(){
      Integer nbAccount = 1;
      Integer nbOrder=1;
      Integer price=1;
      Integer quantity=1;
   List<Account> testAccounts =  TestDataFactory.createAccounts(nbAccount);
   List <Order> testOrders =  TestDataFactory.createOrdersForAccounts(testAccounts, nbOrder,price,quantity); 
        
     Test.startTest();
        Database.delete(testOrders);
       List<Account> dataBaseAccount = [SELECT Id, NewActive__c FROM Account];
        List<Order> dataBaseOrder = [SELECT AccountId FROM Order];
        for(Account account : dataBaseAccount){
            for(Order order : dataBaseOrder){
                   if(account.Id == order.AccountId){
                    System.assertEquals(True, account.NewActive__c);
                }else{
                    System.assertEquals(False, account.NewActive__c);
                }
                if(order.Status == 'Activated' && order.OrderItems.isEmpty()){
                    System.assertEquals(True,order.Status == 'Draft');
                }else{
                    System.assertEquals(False, order.Status == 'Activated');
                }  
            }
            }
   Test.stopTest();
    }
}