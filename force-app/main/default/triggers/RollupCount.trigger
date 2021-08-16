trigger RollupCount on Contact (after insert,after update){
		List<Account> updateList = new List<Account>();
       
          for(Account acc :[SELECT Id,Name,(SELECT ID FROM Contacts) FROM Account ]){
            if(acc.contacts.size()>0)
                acc.Count__c =acc.contacts.size();
               
            else
                acc.Count__c = 0;
            
            updateList.add(acc);
        }
        if(!updateList.isEmpty())
            update updateList;
        
    }