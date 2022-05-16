global class AccountWithoutOrderBatch implements Database.Batchable<sObject>{
    
global Database.QueryLocator start(Database.BatchableContext info){ 
        //Request accounts with his order and task
        return Database.getQueryLocator('SELECT OwnerId, (SELECT Id FROM Orders), (SELECT Id FROM Tasks WHERE Subject=\'Call\') FROM Account');
    }
    
    global void execute(Database.BatchableContext info, List<Account> scope){
        List<Task> allTasksToUpdate = new List<Task>();
        //Check if there are order or task with call's subjet
        for(Account account: scope){
            if(account.Orders.size() == 0 && account.Tasks.size() == 0){
                Task newCallTask = new Task(
                    OwnerId = account.OwnerId,
                    Subject = 'Call',
                    Status = 'Not Started',
                    Priority = 'Normal',
                    IsReminderSet = true,
                    WhatId = account.Id,
                    ReminderDateTime = System.now()+5
                );
                allTasksToUpdate.add(newCallTask);
            }
        }
        insert allTasksToUpdate;
    }
    global void finish(Database.BatchableContext info){
        
    }
}