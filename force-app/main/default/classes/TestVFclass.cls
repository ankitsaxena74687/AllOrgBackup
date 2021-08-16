public class TestVFclass {
    private contact c1;
    public TestVFclass(apexpages.StandardController c){
        this.c1=(contact)c.getRecord();
    }
    public list<contact> conlist{get;set;}
    public pageReference search(){
        conlist=new list<contact>();
        if(conlist!=null)
            conlist.clear();
        conlist=[select id,name,MobilePhone,Email from contact where AccountId=:c1.AccountId];
        return null;
    }

    public pageReference deleted(){
        String delcon=ApexPages.currentPage().getparameters().get('rowid');
        for(integer i=0;i<conlist.size();i++){
            contact c=conlist[i];
            if(c.id==delcon)
            { delete c;
             conlist.remove(i); 
             break; }
        } return null;
    }
}