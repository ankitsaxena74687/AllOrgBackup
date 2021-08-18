({
    onSelectedAccount : function(component,event,helper){
        var data=event.getParam('Account');
        component.set("v.getAccount",data);
        
    },
    onRecordUpdated : function(component,event,helper){
        
         component.find("recordLoader").reloadRecord();
    }
    
    
})