trigger OrderEventTrigger on Order_Event__e (after insert) {

    List<Task> tasks = new List<Task>();
    String userId = UserInfo.getUserId(); 
for (Order_Event__e event : Trigger.New ) {

        if(event.Has_Shipped__c == true){
            tasks.add(new Task(
                Priority = 'Medium',
                Subject = 'Follow up on shipped order ' + event.Order_Number__c, 
                OwnerId = userId
                ));
        }
    }

    insert tasks;

}