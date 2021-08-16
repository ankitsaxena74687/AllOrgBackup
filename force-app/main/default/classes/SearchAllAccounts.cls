public class SearchAllAccounts {
@AuraEnabled
    public static list<Account> getAllAccounts(){
        
        list<Account> mylist=new list<Account>([select id,name,type,industry,createdDate from account]);
        return mylist;
    }
    
    @AuraEnabled
    public static string updateAccount(Account acc){
        update acc;
        return 'success';
        
    }
}