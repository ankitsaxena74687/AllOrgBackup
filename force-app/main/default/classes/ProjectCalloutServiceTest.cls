@isTest
private class ProjectCalloutServiceTest {
  
    @testSetup
    static void setup(){
        Opportunity op1=new Opportunity();
        op1.Name='TestOp1';
        op1.StageName='Submitted Project';
        op1.Type='New Project';
        op1.Amount=100;
        op1.CloseDate=Date.today();
        insert op1;
        
        Opportunity op2=new Opportunity();
        op2.Name='TestOp2';
        op2.StageName='Resubmit Project';
        op2.Type='New Project';
        op2.Amount=100;
        op2.CloseDate=Date.today();
        insert op2;
        
        ServiceTokens__c servToken=new ServiceTokens__c();
        servToken.Name='ProjectServiceToken';
        servToken.Token__c='a3200177-d606-475f-bbdf-5fc7ea7fe5b9';
        insert servToken;
    }
  @isTest
    static void testPostCalloutSuccess(){
    list<id> mylist=new list<id>();
    Opportunity opp=[select id from Opportunity where name ='TestOp1' limit 1];
    mylist.add(opp.id);
        Test.setMock(HttpCalloutMock.class,new ProjectCalloutServiceMock());
        Test.startTest();
     ProjectCalloutService.postOpportunityToPMS(mylist);
        Test.stopTest();
    }
    
     @isTest
    static void testPostCalloutFailure(){
    list<id> mylist=new list<id>();
    Opportunity opp=[select id from Opportunity where name ='TestOp2' limit 1];
    mylist.add(opp.id);
        Test.setMock(HttpCalloutMock.class,new ProjectCalloutServiceMock());
        Test.startTest();
     ProjectCalloutService.postOpportunityToPMS(mylist);
        Test.stopTest();
    }
    
}