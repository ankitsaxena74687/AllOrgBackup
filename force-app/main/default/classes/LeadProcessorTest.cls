@isTest
private class LeadProcessorTest {

    @testSetup 
    static void setup() {
        List<Lead> lds = new List<Lead>();
        for (Integer i=0;i<200;i++) {
            lds.add(new Lead(LastName='MyLead'+i,Company='XYZ'));
        }
        insert lds;  }
    
    static testmethod void test() {        
        Test.startTest();
        LeadProcessor lp=new LeadProcessor();
        Id batchId = Database.executeBatch(lp);
        Test.stopTest();
    }
}