({
    quickContact: function(component, event, helper){
        var action=component.get('c.Mymethod');
        action.setParams({
            AcId :component.get('v.recordId')
        });
        action.setCallback(this,function(response){
            var state=response.getState();
            if(state==='SUCCESS'){
                
                    var responsevalue=response.getReturnValue(); 
                    helper.createContact(component,responsevalue)
                
            }
            else{ console.log(response.getError());}
        });
        $A.enqueueAction(action); 
    },
    
    navigate:function(component){
        
        var idx= event.currentTarget.id;
        var navEvt = $A.get("e.force:navigateToSObject");
        navEvt.setParams({
            "recordId": idx,
            "slideDevName": "detail"
         });
        navEvt.fire(); 
    }   
})