@isTest
private class BillingCalloutServiceTest {
    @testSetup static void setup(){
        
        Opportunity opp=new Opportunity();
        opp.Name='TestOpp';
        opp.CloseDate=Date.today();
        opp.StageName='Prospecting';
        insert opp;
        
        Project__c pro=new project__c();
        pro.name='testPro';
        pro.Billable_Amount__c=1000;
        pro.ProjectRef__c='testRef';
        pro.Status__c='Running';
        pro.Opportunity__c=opp.id;
        insert pro;
        
        ServiceCredentials__c serv=new ServiceCredentials__c();
        serv.Name='BillingServiceCredential';
        serv.Username__c='usr1';
        serv.Password__c='pass1';
        insert serv;
    }
    
    @isTest static void testCalloutSuccess(){
        test.setMock(WebServiceMock.class,new BillingCalloutServiceMock());
         project__c p=[select id ,ProjectRef__c,Billable_Amount__c from project__c where ProjectRef__c =: 'testRef' ];
      Test.startTest();
        BillingCalloutService.callBillingService(p.ProjectRef__c,p.Billable_Amount__c);
         Test.stopTest();
    }
    
     @isTest static void testCalloutFailure(){
        test.setMock(WebServiceMock.class,new BillingCalloutServiceMockFailure());
        
         project__c p=[select id ,ProjectRef__c,Billable_Amount__c from project__c where ProjectRef__c =: 'testRef' ];
       Test.startTest();
         BillingCalloutService.callBillingService(p.ProjectRef__c,p.Billable_Amount__c);
         Test.stopTest();
    }
}