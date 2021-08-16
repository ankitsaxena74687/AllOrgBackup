public with sharing class MaintenanceRequestHelper {
    public static void updateWorkOrders(map<id,case> mycases) {
        map<id,integer> mypro=new map<id,integer>();
        list<product2> prolist=new list<product2>([select id,Maintenance_Cycle__c from product2]);
        for(Product2 p:prolist)
        {    if(p!=null)
            if(p.Maintenance_Cycle__c!=null)
                mypro.put(p.id,integer.valueOf(p.Maintenance_Cycle__c));
        }
        List<case> newCaseList=new List<Case>();  
        for(Case c:mycases.values()){
            case  newCase=new Case();
            newCase.Origin=c.Origin;
            newCase.Vehicle__c=c.Vehicle__c;
            newCase.Equipment__c=c.Equipment__c;
            newCase.Type='Routine Maintenance';
            newCase.Subject='abc';
            newCase.Status='New';
            newCase.Date_Reported__c=Date.today();
            newCase.Date_Due__c=GetDueDate(c,mypro);
            
            newCaseList.add(newCase);
        }
        if(newCaseList.size()>0)
            insert newCaseList;
    }        
    public static date GetDueDate(case c,Map<id,integer> mypro){
        Date dt=Date.today();
        if(mypro.get(c.Equipment__c)!=null)
            dt=Date.today().addDays(Integer.valueOf(mypro.get(c.Equipment__c)));
        return dt;
    }  
}