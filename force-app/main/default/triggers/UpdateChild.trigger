trigger UpdateChild on Account (after insert,after update) {

    map<id,Account> MapAcc=new map<id,Account>();
    list<contact> conlist=new list<contact>();
    
    for(Account acc:trigger.new){
        MapAcc.put(acc.id,acc);
                                }
    
    conlist=[select id, Name,Phone,Account.Phone
             from contact
             where  AccountId IN:MapAcc.keySet()];
    
    if(conlist.size()>0){
        for(Contact con:conlist){
            
            con.phone=MapAcc.get(con.AccountId).Phone;
        }
        update conlist;
    }
}