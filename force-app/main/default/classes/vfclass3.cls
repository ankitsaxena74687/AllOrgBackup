public with sharing class vfclass3 {
    
    private Contact c1;
    public string AcId{get;set;}
    public   List<Contact> conList=new List<Contact>();
    public List<Contact> selectedList{get;set;}
    public List<Contact> updatelist{get;set;}
    public List<wrapper_Test> wrlist{get;set;}
    public vfclass3(ApexPages.StandardController c){
        this.c1=(Contact)c.getRecord();   } 
    
    public List<Contact> getconList(){
        return conList;}
    
    public PageReference Search(){
        if(wrlist==null)
            wrlist= new List<wrapper_Test>();    
        wrlist.clear();
        conList =[select id,Firstname,Lastname,MobilePhone,Email,AccountId from Contact where AccountId=:c1.AccountId];
        for(contact c:conList){
            wrlist.add(new wrapper_Test(c));
        }return null;}
    
    public PageReference Deleted(){
        selectedList= new List<Contact>();
        for(integer i=0;i<wrList.size();i++) {
            wrapper_Test w=wrList[i];
            if(w.check_del== true){
                selectedList.add(w.con);
                wrlist.remove(i);}}
        if(selectedList.size()>0)
            delete selectedList;
        return null;
    }
    public PageReference Edited()
    {   
        return null;
    }
    
    public PageReference Saved()
    {   updatelist=new list<contact>();
     for(wrapper_Test w:wrList) {
         if(w.check_edit== true){
             updatelist.add(w.con);
             w.check_edit=false; }
         if(updatelist.size()>0)
             update updatelist;
     }return null;}
    
    class wrapper_Test{
        public Contact con{get;set;}
        public boolean check_del{get; set;}
        public boolean check_edit{get; set;}
        public wrapper_test(Contact con)
        { this.con=con;
         check_del=false;
         check_edit=false;
        }
    }
    
    public void newcon(){}
}