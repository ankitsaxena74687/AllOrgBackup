@istest
public class Mytestclass{
    static testmethod void productAddTriggerTest(){
        
        account acc=new Account();
        acc.name='account1';
        insert acc;
        system.debug('===============Account=================='+acc.id);
        
       Pricebook2 pb=new Pricebook2();
        pb.Name='pricebook1';
        pb.IsActive=true;
        insert pb;
        system.debug('===============price book=================='+pb.id);
        
        opportunity op=new opportunity();
        op.Name = 'test';
        op.AccountId=acc.id;
        op.CloseDate=date.today()+7;
        op.StageName='Prospecting';
        op.Pricebook2Id=pb.id;
        insert op;
        system.debug('===============opportunity=================='+op.id);
        
        list<String> proname=new list<String>{'Product 10X','Minutes Per Agent','CRM Licenses','Administrators License','DID'};
            list<Product2> prolist=new list<Product2>();
        integer i;
        for(i=0;i<proname.size();i++)
          prolist.add(new Product2(Name=proname.get(i)));          //create above products and put in list
        insert prolist;
        
        map<integer,id> mypromap=new map<integer,id>();
        for(i=0;i<prolist.size();i++){
            Product2 p=prolist.get(i);                             //create map of index_number and products_id
            mypromap.put(i,p.id);}
        
        list<PricebookEntry> pblist=new list<PricebookEntry>();
        for(i=0;i<prolist.size();i++){
            pblist.add(new PricebookEntry(Pricebook2Id=Test.getStandardPricebookId(),Product2Id=mypromap.get(i),UnitPrice=10));
        } insert pblist;                                       //create StandardPricebookEntry for products and put in list
        
        for(i=0;i<prolist.size();i++){
            pblist.add(new PricebookEntry(Pricebook2Id=pb.id,Product2Id=mypromap.get(i),UnitPrice=10,IsActive=true));
        }
        upsert pblist;										//create custom PricebookEntry for products and put in list
        
        OpportunityLineItem oli1=new OpportunityLineItem();
        oli1.OpportunityId=op.id;
        oli1.Product2Id=mypromap.get(0);
        id pbe_id;
        for(PricebookEntry pe:pblist){
            if(pe.Product2Id==mypromap.get(0))
                pbe_id=pe.id;}
        oli1.PricebookEntryId=pbe_id;
        oli1.Description='';
        oli1.Quantity=1;
        oli1.TotalPrice=0;
        insert oli1;
    }}