public class AccountProcessor {
 @future
 public static void countContacts(list<id> AcId){
     
     list<Account> aclist=new list<Account>([select id,(select id from contacts) from Account where id in : AcId]);
     list<Account> updatelist=new list<Account>();
     for(Account a:aclist)
     {  a.Number_of_Contacts__c=a.contacts.size();
         updatelist.add(a);
     }
     update aclist;
 }
}