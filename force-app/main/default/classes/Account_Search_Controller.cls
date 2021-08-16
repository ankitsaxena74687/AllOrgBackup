public class Account_Search_Controller {
@AuraEnabled
    public static List<String> AccountTypeListSearch(){
        List<String> type=new List<String>();
         Schema.DescribeFieldResult fieldResult = Account.Type.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        for( Schema.PicklistEntry pickListVal : ple){
            type.add(pickListVal.getLabel());
           
        }  
        return type;
       }
    
    @AuraEnabled
    public static list<Account> getAccounts(String types){
        list<Account> myAcc=new List<Account>([select id,name,type,Description,Phone,Industry from Account where type=:types]);
        System.debug('=================list==========='+myAcc);
        return myAcc;
    }
}