public class ConList {
@AuraEnabled  
    public static List<Contact> getcontactList(String acid){
        List<Contact> mylist=new list<contact>([select id,name,DOB__c,MobilePhone,Email from contact where AccountId =:acid And DOB__c!=null]);
        return mylist;
    }
}