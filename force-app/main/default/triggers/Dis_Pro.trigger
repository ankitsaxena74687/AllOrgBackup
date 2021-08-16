trigger Dis_Pro on OpportunityLineItem (after insert,after update) {
   set<id> acId=new set<id>();
    set<id> opId=new set<id>();
    
    for(OpportunityLineItem op:trigger.new)
     opId.add(op.OpportunityId);
    
for(Opportunity o:[select id,AccountId from Opportunity where id =:opId])
    acId.add(o.AccountId);
    decimal max=0;
    map<id,account> mpAc=new map<id,account>([select id,Max_Pro__c from account where id in : acId]);
    
for(Aggregateresult ag:[select max(TotalPrice) max,Opportunity.AccountId at from OpportunityLineItem 
                        where Opportunity.AccountId=:acId group by Product2.Name,Opportunity.AccountId]){
          max=integer.valueof(ag.get('max'));                  
          String acid=string.valueof(ag.get('at'));
           if(mpAc.get(acid).Max_Pro__c==null){mpAc.get(acid).Max_Pro__c=0;}
           mpAc.get(acid).Max_Pro__c=max;            }
    update mpAc.values();
}