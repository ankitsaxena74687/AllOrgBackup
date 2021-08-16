public class lookupVF {
    private Contact c1;
    public lookupVF(ApexPages.StandardController c){
        this.c1=(Contact)c.getRecord();
    } 
    public string AcId{get;set;}
    public   List<Contact> conList{get;set;}
    public PageReference Search(){
        conList=new list<Contact>();
         conList =[select id,name,phone,Email,AccountId from Contact where AccountId=:c1.AccountId];
        return null;        
    }}