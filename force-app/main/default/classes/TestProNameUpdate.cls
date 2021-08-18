@istest
public class TestProNameUpdate {
    static testmethod void ProNameUpdateTriggerTest(){
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
        
        Product2 pro=new Product2();
        pro.name='Product 10X';
        insert pro;
        PricebookEntry pe1=new PricebookEntry();
        pe1.Pricebook2Id=Test.getStandardPricebookId();
        pe1.Product2Id=pro.id;
        pe1.UnitPrice=10;
        insert pe1;
        PricebookEntry pe12=new PricebookEntry();
        pe12.Pricebook2Id=pb.id;
        pe12.Product2Id=pro.id;
        pe12.UnitPrice=10;
        pe12.IsActive=true;
        insert pe12;
        
        OpportunityLineItem oli1=new OpportunityLineItem();
        oli1.OpportunityId=op.id;
        oli1.Product2Id=pro.id;
        oli1.PricebookEntryId=pe12.id;
        oli1.Description='';
        oli1.Quantity=1;
        oli1.TotalPrice=0;
        insert oli1;       }
}