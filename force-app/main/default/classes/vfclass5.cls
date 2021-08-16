public class vfclass5 {
 private final Account a;
    public vfclass5(ApexPages.StandardController con){
        this.a=(Account)con.getRecord();  
        system.debug('=========  Contact ======='+a);}
    
    List<Contact> conList;
    public List<Contact> getconList(){
        return conList;}
    
    public void accountSelected(){
        
        conList =[select name,Email,MobilePhone from Contact where AccountId =: a.id];
        system.debug('=========   list======='+conList);
        
    }
}