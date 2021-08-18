trigger MaintenanceRequest on Case (after update) {
    map<id,case> mycases=new map<id,case>();
    for(Case c:Trigger.new){
        if((c.type=='Repair'|| c.type=='Routine Maintenance')&& c.Status=='closed')
            mycases.put(c.id,c);
    }
    
    system.debug('mycases'+mycases);
    if(mycases.size()>0)
        MaintenanceRequestHelper.updateWorkOrders(mycases);
}