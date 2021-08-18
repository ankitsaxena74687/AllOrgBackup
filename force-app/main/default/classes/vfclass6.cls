public class vfclass6 {
  public list<wrapper_Test> wrapAccountList{get; set;}
   public list<Account> selectedList{get; set;}  
    public  vfclass6(){
        if(wrapAccountList == null) {
            wrapAccountList = new List<wrapper_Test>();
            for(Account a: [select Id, Name,BillingState, Website, Phone from Account limit 10]) 
                wrapAccountList.add(new wrapper_Test(a));
        }
    }
    public void processSelected() {
    selectedList= new List<Account>();
 
        for(wrapper_Test wt : wrapAccountList) {
            if(wt.selected == true) {
                selectedList.add(wt.a);
            }
        }
    }
    
    
    
    class wrapper_Test{
       public Account a{get;set;}
        public boolean selected{get; set;} 
        
        public wrapper_Test(Account a){
            this.a=a;
            selected=false;}
    }
}