trigger OrderTrigger on Order (before update, after delete) {
    if(Trigger.isUpdate){
        AccountWhithoutOtherOrder.checkOrderWithoutProduct(Trigger.new);
    }else if(Trigger.isDelete){
         AccountWhithoutOtherOrder.checkAccountsForOrders(Trigger.old);
    }
}