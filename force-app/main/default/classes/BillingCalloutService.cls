public class BillingCalloutService {
    @future(callout=true)
    public static void callBillingService(String ProjectRef,Decimal BillingAmount){
        ServiceCredentials__c serv=ServiceCredentials__c.getValues('BillingServiceCredential');
        BillingServiceProxy.project pro=new BillingServiceProxy.project();
        pro.username=serv.Username__c;
        pro.password=serv.Password__c;
        pro.projectid=ProjectRef;
        pro.billAmount=BillingAmount;
        
        BillingServiceProxy.InvoicesPortSoap11 myobj=new BillingServiceProxy.InvoicesPortSoap11();
        String response=myobj.billProject(pro);
        
        List<Project__c> updatepro=new List<Project__c>();
        
        if(response!=null && response.equalsIgnoreCase('OK')){
            list<project__c> getpro=[select status__c from project__c where ProjectRef__c =: ProjectRef];
            for(Project__c p:getpro)
            {
                p.status__c='Billed';
                updatepro.add(p);
            }
            update updatepro;
        }
        
        
    }
}