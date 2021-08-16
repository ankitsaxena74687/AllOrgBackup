@IsTest
private class AccountProcessorTest {
    static testmethod void countContactsTest(){
        integer i;
        list<id> aclist=new list<id>();
        for(i=0;i<5;i++){
            Account a=new Account();
            a.Name='Arjun'+i;
            insert a;
            aclist.add(a.id);
        }
        for(i=0;i<5;i++){
            Contact c1=new Contact();
            c1.FirstName='C';
            c1.LastName='Dhruv'+i;
            c1.AccountId=aclist.get(i);
            insert c1;
            Contact c2=new Contact();
            c2.FirstName='D';
            c2.LastName='ritik'+i;
            c2.AccountId=aclist.get(i);
            insert c2;}
        
        Test.startTest();
        AccountProcessor.countContacts(aclist);
        Test.stopTest();
        
    } 
}