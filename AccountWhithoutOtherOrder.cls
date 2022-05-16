global with sharing class AccountWhithoutOtherOrder {
    //Vérifier qu'il n'y a pas d'autre order rattaché au compte
    //si aucun active__c = false
    global static void checkOrderWithoutProduct(List<Order> ckeckListOrder){
       for(Order orders : ckeckListOrder){
        if(orders.Status == 'Activated' && orders.OrderItems.isEmpty()){
           orders.addError('Le statut ne peut être modifié car il n\'y a pas de produits associé zzz');
         }
    }
    }
    global static void checkAccountsForOrders(List<Order> deletedOrders) {
		Set<Id> accountsIds = new Set<Id>();
		for (Order order : deletedOrders) {
			accountsIds.add(order.AccountId);
		}
		List<Account> accountsToCheck = new List<Account>(
			[SELECT Id, (SELECT Id FROM Orders) FROM Account WHERE Id IN :accountsIds]
		);
		List<Account> accountsToUpdate = new List<Account>();
		for (Account account : accountsToCheck) {
			if (account.Orders.size() == 0) {
				account.NewActive__c = false;
				accountsToUpdate.add(account);
			}
		}
		if (accountsToUpdate.size() != 0) {
			Database.update(accountsToUpdate);
		}
	}
}
   /* global static void orderDeleted(Order deletedOrder){
        List<Account> allAccounts = new List<Account>();
        allAccounts = [SELECT Id FROM Account]; 
        //List<Order> allOrdersWithAccount = new List<Order>();
        //allOrdersWithAccount = [SELECT AccountId FROM Order];
        //System.debug(allOrdersWithAccount);
        for(Account account : allAccounts){
            //for(Order ord : allOrdersWithAccount){
               // if(account.Id == deletedOrder.AccountId){
             if(account.Orders.isEmpty()){
                    account.NewActive__c = False;
                }else{
                    account.NewActive__c = True;
                }
               // deletedOrder.addError('account ' + account.Id + ' ' + deletedOrder.OrderNumber + ' ' + account.NewActive__c);
           // }
            update account;
            
        }  
        
        update allAccounts;
    }
}*/