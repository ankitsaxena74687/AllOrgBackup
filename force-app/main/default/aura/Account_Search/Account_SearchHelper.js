({
    LoadType : function(component,event) {
        
        var action=component.get("c.AccountTypeListSearch");
        action.setCallback(this,function(response){
            var state=response.getState();
            if(state=='SUCCESS'){
                component.set("v.AccountTypeList",response.getReturnValue());
                console.log(response.getReturnValue());
            }
            else {
                alert('ERROR');
            }
        });
        $A.enqueueAction(action);    
    }
})