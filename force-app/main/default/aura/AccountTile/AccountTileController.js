({
	selectTile : function(component, event, helper) {
		
        var data=event.getSource().get("v.value");
        var accSelectEvent=component.getEvent("AccountSelect");
         accSelectEvent.setParams({
            
            "selectedAccount" : data
        });
        accSelectEvent.fire();
        
        var accSelectedEvent=$A.get("e.c:Account_Selected_Event");
         accSelectedEvent.setParams({
            
            "Account" : data
        });
        accSelectedEvent.fire();
	}
})