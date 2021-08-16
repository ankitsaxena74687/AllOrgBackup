({
    handleClick : function(component, event, helper) {
        var buttonName=event.getSource().get("v.name")
        alert(buttonName);
    },
    
    doInit : function(component, event, helper) {
        helper.LoadType(component,event);     
    },
    
    onTypeChange : function(component, event, helper) {
        
        var getType=component.find("type").get("v.value");
        component.set("v.SelectedType",getType); 
        alert(getType);
    },
    
    onSearch : function(component,event,helper){
        var getType=component.find("type").get("v.value");
        var AccountEvent=component.getEvent("searchAccounts");
        AccountEvent.setParams({
            "AccountType" : getType
        });
        alert('Event is Getting Fired'+AccountEvent);
        AccountEvent.fire();
    }
    
})