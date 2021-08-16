trigger ProjectTrigger on Project__c (after update) {
    for(Project__c p:trigger.new){
        if(p.Status__c==' Billable'){
            BillingCalloutService.callBillingService(p.ProjectRef__c,p.Billable_Amount__c);
        }
    }
}