trigger updateproduct on OpportunityLineItem (before insert) {
    Set<id> setId= new Set<id>();
    if(!Checkrecursion.hasAlreadyRunMethod()){
        For(OpportunityLineItem oli: trigger.new)
        {    System.debug('=========oli.OpportunityId======'+(oli.OpportunityId));
         setId.add(oli.OpportunityId);
        }
        
        List<OpportunityLineItem> oppo = [select id,OpportunityId,Product2Id,Quantity,UnitPrice from OpportunityLineItem where OpportunityId in :setId];
        System.debug('=========oppo======='+oppo);
        if(oppo.size()>0){
            List<OpportunityLineItem> del_list=new List<OpportunityLineItem>(); 
            Map<id,OpportunityLineItem> olimap = new Map<id,OpportunityLineItem>();
            For(OpportunityLineItem oli : oppo)
                olimap.put(oli.Product2Id,oli);
            System.debug('=========olimap======='+olimap);
            
            For(OpportunityLineItem opli : trigger.new){     
                if(olimap.containsKey(opli.product2Id) && olimap.get(opli.product2Id).OpportunityId==opli.OpportunityId){    
                    opli.Quantity+=olimap.get(opli.product2Id).Quantity;
                    opli.UnitPrice=olimap.get(opli.product2Id).UnitPrice;
                    del_list.add(olimap.get(opli.product2Id)); 
                }    }   
            System.debug('=========del_list======='+del_list);
            if(del_list.size()>=1)
                delete del_list;
            Checkrecursion.hasAlreadyRun=true;
            
        }}
}