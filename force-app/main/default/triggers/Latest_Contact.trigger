/* Write a trigger on contact and show most recently Updated contact on account.For that make a field on account latest contact as a lookup*/

trigger Latest_Contact on Contact (after insert,after update) {
    set<id> acid=new set<id>();
    for(Contact c:Trigger.new){
        if(c.AccountId!=null)
            acid.add(c.AccountId);}
    list<Account> updatelist=new list<Account>();
    Map<id,Account> mymap=new map<id,Account>([select id,Latest_Contact__c from account where id in:acid]);
    if(trigger.isInsert){
        for(Contact con:trigger.new){
            Account acc=mymap.get(con.AccountId);
            acc.Latest_Contact__c=con.id;
            updatelist.add(acc);}
        update updatelist;}
    
    
    if(trigger.isUpdate){
        for(Contact con:Trigger.new){
            Contact c=trigger.oldmap.get(con.id);
            
            if(c.AccountId!=con.AccountId){
                Contact c1=[select id from contact where accountId =: c.AccountId order by createddate desc limit 1];
                Account a1=new Account(id=c.AccountId,Latest_Contact__c=c1.id);
                Account a2=mymap.get(con.AccountId);
                a2.Latest_Contact__c=con.id;
                updatelist.add(a1);
                updatelist.add(a2); }
            update updatelist;
        }}}