@isTest
private class AccountWithoutOrderBatchTest {
@TestSetup
    static void makeData(){
      Integer nbAccount = 1;
      List<Account> testAccounts =  TestDataFactory.createAccounts(nbAccount);
    }
    @isTest static void test_WhenBatchExecuted(){
        Test.startTest();
        AccountWithoutOrderBatch obj = new AccountWithoutOrderBatch();
        Id batchId = DataBase.executeBatch(obj);
        Test.stopTest();
        
        List<Account> results = [SELECT Id, (SELECT AccountId FROM Orders),(SELECT WhatId FROM Tasks)FROM  Account];
        List<Task> tasks = [SELECT WhatId FROM Task];
        for (Account account : results){
        System.assertEquals(False, tasks.isEmpty());
        }
        }
    }