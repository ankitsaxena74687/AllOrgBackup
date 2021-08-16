@isTest
public class MaintenanceRequestTest {
    @testSetup
    static void setup(){
        
        list<product2> prolist=new list<product2>();
        product2 pro=new product2();
        pro.Name='Testquip';
        pro.Cost__c=100;
        pro.Lifespan_Months__c=2;
        pro.Maintenance_Cycle__c=10;
        pro.Current_Inventory__c=10;
        pro.Replacement_Part__c=true;
        pro.Warehouse_SKU__c='abc';
        prolist.add(pro);
        insert prolist;
        
        
    }
   
    @isTest
    static void testMaintenanceRequest(){
     
    vehicle__c v=new vehicle__c();
    v.Name='TestVehicle';
    insert v;
        id equipid=[select id from product2 limit 1].get(0).id;
        list<case> mycases=new list<case>();
        list<case> updatemycases=new list<case>();
        for(integer i=0;i<10;i++){
            case c=new case();
            c.Origin='Phone';
            c.Vehicle__c=v.id;
            c.Equipment__c=equipid;
            c.Type='Routine Maintenance';
            c.Subject='abc';
            c.Status='New';
            c.Date_Reported__c=Date.today();
            mycases.add(c);
        }
        
       insert mycases;
        for(case c :mycases){
            c.Status='closed';
            updatemycases.add(c);
        }
        update updatemycases;
    }
    
    
}