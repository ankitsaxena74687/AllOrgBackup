trigger proupdate on OpportunityLineItem (before insert) {
    
    list<id> pnew=new list<id>();
    list<OpportunityLineItem> pold=new list<OpportunityLineItem>();
    map<id,list<OpportunityLineItem>> myMap=new map<id,list<OpportunityLineItem>>();
    
    
    for(OpportunityLineItem p:trigger.new)
    { pnew.add(p.Product2Id);
    } system.debug('==============List of inserting pateint============='+pnew);
    
    pold=[select id,OpportunityId,Product2Id from OpportunityLineItem
          where Product2Id IN : pnew];
    system.debug('============== list of already existing patient============='+pold);
    
     for(OpportunityLineItem op:pold){
        if(myMap.containsKey(op.Product2Id))
          myMap.get(op.Product2Id).add(op);
        else{ myMap.put(op.Product2Id,new list<OpportunityLineItem>());
             myMap.get(op.Product2Id).add(op);    
             }}
    
}