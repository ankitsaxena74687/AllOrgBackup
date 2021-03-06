@istest
public class productAddTest{
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
        
        Product2 pro=new Product2();
        pro.name='Product 10X';
        insert pro;
        Product2 pro2=new Product2();
        pro2.name='Minutes Per Agent';
        insert pro2;
        Product2 pro3=new Product2();
        pro3.name='CRM Licenses';
        insert pro3;
        Product2 pro4=new Product2();
        pro4.name='Administrators License';
        insert pro4;
        Product2 pro5=new Product2();
        pro5.name='DID';
        insert pro5;
        
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
        PricebookEntry pe2=new PricebookEntry();
        pe2.Pricebook2Id=Test.getStandardPricebookId();
        pe2.Product2Id=pro2.id;
        pe2.UnitPrice=10;
        insert pe2;
        PricebookEntry pe22=new PricebookEntry();
        pe22.Pricebook2Id=pb.id;
        pe22.Product2Id=pro2.id;
        pe22.UnitPrice=10;
        pe22.IsActive=true;
        insert pe22;
        PricebookEntry pe3=new PricebookEntry();
        pe3.Pricebook2Id=Test.getStandardPricebookId();
        pe3.Product2Id=pro3.id;
        pe3.UnitPrice=10;
        insert pe3;
        PricebookEntry pe32=new PricebookEntry();
        pe32.Pricebook2Id=pb.id;
        pe32.Product2Id=pro3.id;
        pe32.UnitPrice=10;
        pe32.IsActive=true;
        insert pe32;
        PricebookEntry pe4=new PricebookEntry();
        pe4.Pricebook2Id=Test.getStandardPricebookId();
        pe4.Product2Id=pro4.id;
        pe4.UnitPrice=10;
        insert pe4;
        PricebookEntry pe42=new PricebookEntry();
        pe42.Pricebook2Id=pb.id;
        pe42.Product2Id=pro4.id;
        pe42.UnitPrice=10;
        pe42.IsActive=true;
        insert pe42;
        PricebookEntry pe5=new PricebookEntry();
        pe5.Pricebook2Id=Test.getStandardPricebookId();
        pe5.Product2Id=pro5.id;
        pe5.UnitPrice=10;
        insert pe5;
        PricebookEntry pe52=new PricebookEntry();
        pe52.Pricebook2Id=pb.id;
        pe52.Product2Id=pro5.id;
        pe52.UnitPrice=10;
        pe52.IsActive=true;
        insert pe52;
        
        OpportunityLineItem oli1=new OpportunityLineItem();
        oli1.OpportunityId=op.id;
        oli1.Product2Id=pro.id;
        oli1.PricebookEntryId=pe12.id;
        oli1.Description='';
        oli1.Quantity=1;
        oli1.TotalPrice=0;
        insert oli1;
    }}