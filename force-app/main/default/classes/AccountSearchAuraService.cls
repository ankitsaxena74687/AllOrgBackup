public class AccountSearchAuraService {
    @AuraEnabled
    public static List<sObject> searchAccount(String searchParam){
        String likeParam='%' +searchParam+'%';
        String Query='';
        if(likeParam==null){
            Query='select Id,name,Phone,AccountNumber from Account limit 10';
        }
        else{ Query='select Id,name,Phone,AccountNumber from Account where name like :likeParam limit 10';   
            }
        List<sObject> mylist=Database.query(Query);
        return mylist;
    }
    @AuraEnabled
    public static List<Contact> searchContact(String AcId){
        List<Contact> mylist=[select name,MobilePhone,Email from contact where AccountId =:AcId ];
        return mylist;
    }
    
    @AuraEnabled
    public static List<Contact> saveContact(List<Contact> lstContact) {
        update lstContact;
        return lstContact;
    }
    
     @AuraEnabled
    public static String Mymethod(String AcId){
        Account ac=[select id,Type from Account where Id =:AcId];
        return ac.Type;
    }
}