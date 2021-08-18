public class OppClass {
    
    public static void ProAdd(List<OpportunityLineItem> mylist){
        list<opportunityLineItem> opli = new list<opportunityLineItem>([select id ,Product2.Name,Product2Id,PricebookEntryId,opportunityId,UnitPrice,Quantity 
                                                                        from opportunitylineitem 
                                                                        where Id IN : mylist]);
 system.debug('===============opli=================='+opli);
        list<opportunity> updatelist=new list<opportunity>();
        set<id> opid=new set<id>();
        for(OpportunityLineItem o:mylist)
            opid.add(o.OpportunityId);
      system.debug('===============opid=================='+opid);    
        map<id,Opportunity> opmap=new map<id,opportunity>([select id,(select id from OpportunityLineItems) from Opportunity
                                                           where id in : opid]); 
        system.debug('===============opmap=================='+opmap);
        Product2 mpa = [select id from product2 where name='Minutes Per Agent' Limit 1];
     /*   Product2 cli = [select id from product2 where name='CRM Licenses' Limit 1];
        Product2 ali = [select id from product2 where name='Administrators License' Limit 1];
        Product2 did = [select id from product2 where name='DID' Limit 1];  */
        
        
        for(opportunityLineItem o : opli){
            opportunity obj=new opportunity(); 
            obj=opmap.get(o.OpportunityId);
            obj.Product_Name__c=o.product2.name;
            updatelist.add(obj);
            update updatelist;
            
            system.debug('===============opportu obj=================='+obj);
            system.debug('===============update list=================='+updatelist);
            if(obj.OpportunityLineItems.size()<=1 && (o.product2.name=='Product 10X' || o.product2.name=='Product 20X' || o.product2.name=='Product 30X' )){
                OpportunityLineItem newop2=new OpportunityLineItem();
                
              /*  newop2.OpportunityId=o.opportunityid;
                newop2.Product2Id=cli.id;
                newop2.Description='Cloud Based Customer Relationship Software';
                newop2.TotalPrice=0;
                newop2.Quantity=o.Quantity;
                insert newop2;
                
                
                OpportunityLineItem newop3=new OpportunityLineItem();
                newop3.OpportunityId=o.opportunityid;
                newop3.Product2Id=ali.id;
                newop3.Description='';
                newop3.TotalPrice=0;
                newop3.Quantity=1;
                insert newop3;
                
                
                OpportunityLineItem newop4=new OpportunityLineItem();
                newop4.OpportunityId=o.opportunityid;
                newop4.Product2Id=did.id;
                newop4.Description='';
                newop4.TotalPrice=0;
                newop4.Quantity=1;
                insert newop4;     */
                
                
                OpportunityLineItem newop=new OpportunityLineItem();
                newop.OpportunityId=o.opportunityid;
                newop.Product2Id=mpa.id;
                newop.Description='';
                newop.TotalPrice=0;       
                if(o.product2.name=='Product 10X')
                    newop.Quantity=1000;
                else  if(o.product2.name=='Product 20X')
                    newop.Quantity=6500;
                else if(o.product2.name=='Product 30X' )
                    newop.Quantity=7500;
                else if(o.product2.name=='Months to Months' )
                    newop.Quantity=5000;
                insert newop;
                system.debug('===============newop=================='+newop);    
                Checkrecursion.hasAlreadyRun=true;}
            
        }}}