({
    doinit : function(component, event, helper) {
        var action=component.get('c.getcontactList');
        action.setParams({
            acid : component.get('v.recordId')
        });
        
        action.setCallback(this,function(response){
            var responseValue=response.getReturnValue();
            component.set('v.contactList',responseValue);
        });  
        $A.enqueueAction(action,false); 
    },
    
    doRedirect:function(component, event, helper) {
        var eventsource=event.getSource();
        var id=eventsource.get('v.name');
        var navEvt=$A.get("e.force:navigateToSObject");
        navEvt.setParams({
            "recordId":id,
            "slideDevName":"detail"
        });
        navEvt.fire();
    },
})