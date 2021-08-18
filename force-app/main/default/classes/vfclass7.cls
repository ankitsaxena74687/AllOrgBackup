public class vfclass7
{    public vfclass7(ApexPages.StandardController c){}
    public string OldA{get;set;}
    public string NewA {get;set;}
 List<Contact> conList;
    public List<Contact> getconList(){
        return conList;}
 public PageReference Search(){
     conlist = [select name,Phone,email from contact where AccountId=: OldA];
     return null;
}
}