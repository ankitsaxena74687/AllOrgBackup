public with sharing class WarehouseCalloutService {

    private static final String WAREHOUSE_URL = 'https://th-superbadge-apex.herokuapp.com/equipment';
   @future(callout=true)
    public static void runWarehouseEquipmentSync() {
     list<product2> prolist=new List<Product2>();
        
        
        Http http=new Http();
        HttpRequest req=new Httprequest();
        req.setEndpoint(WAREHOUSE_URL);
        req.setMethod('GET');
        
        HttpResponse resp=http.send(req);
        if(resp.getStatusCode()==200){
            list<JSON2APEX> results=(list<JSON2APEX>)JSON.deserialize(resp.getBody(),List<JSON2APEX>.class);
            for(JSON2APEX j:results){
                
                product2 pro=new product2();
                pro.Cost__c=j.cost;
                pro.Lifespan_Months__c=j.lifespan;
                pro.Maintenance_Cycle__c=j.maintenanceperiod;
                pro.Name=j.name;
                pro.Current_Inventory__c=j.quantity;
                pro.Replacement_Part__c=j.Replacement;
                pro.Warehouse_SKU__c=j.SKU;
               system.debug('=======product============='+pro);
                prolist.add(pro);
            }
            
        }
                if(prolist.size()>0)
                    upsert prolist 	Warehouse_SKU__c;
    }
    
    private class JSON2APEX {
        private boolean Replacement;
        private integer cost;
        private string id;
        private integer maintenanceperiod;
        private string name;
        private integer quantity;
        private string SKU;
        private integer lifespan;
    }
}