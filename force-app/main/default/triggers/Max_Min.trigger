trigger Max_Min on Contact(after insert,after update,after delete,after undelete) {
    Set<id> setId= new Set<id>();
    if(trigger.isInsert || trigger.isUpdate){
        For(Contact c: trigger.new)
        { if(c.accountid!=null && c.amount__c!=null)
            setId.add(c.AccountId);
        }
        System.debug('=========setId======'+setId);}
    
    if(trigger.isDelete){
        For(Contact c: trigger.old)
        {   if(c.accountid!=null && c.amount__c!=null)
            setId.add(c.AccountId);
        } System.debug('=========setId======'+setId);}
    
    map<id,account> mpAc=new map<id,account>([select id,name,max__c,min__c from account where id in : setId]);
    decimal max=0,min=0; 
    list<aggregateresult> agrt=new list<aggregateresult>([select max(amount__c) max,min(amount__c) min,account.id at from contact where amount__c!=null and AccountId in :setId  group by account.id]);
    for(AggregateResult ag:agrt){
        max=integer.valueof(ag.get('max'));
        min=integer.valueof(ag.get('min'));
        String acid=string.valueof(ag.get('at'));
        if(mpAc.get(acid).min__c==null){mpAc.get(acid).min__c=0;}
        if(mpAc.get(acid).max__c==null){mpAc.get(acid).max__c=0;}
        mpAc.get(acid).min__c=min;
        mpAc.get(acid).max__c=max;
    }
    update mpAc.values();   
}