({
    doSearch : function(component, event, helper) {
        
        
        var params=event.getParam('arguments');
        if(params){
            var type=params.type;
        }
        alert('Inside Search Result and type is '+type);
        var action=component.get("c.getAccounts");
        action.setParams({
            "types" : type
        });
        action.setCallback(this,function(response){
            var state=response.getState();
            if(state=='SUCCESS'){
                component.set("v.AccountList",response.getReturnValue());
                var checkList=component.get("v.AccountList");
                console.log('INSIDE SUCCESS');
                console.log(checkList);
            }
            else if(state=="ERROR"){
                console.log('INSIDE ERROR');
                var errors=response.getError();
                if(errors)
                {
                    if(errors[0] && errors[0].message)
                        console.log("Error Message : "+ errors[0].message);
                }  alert('ERROR');
            }
                else 
                    alert('Nothing');
            
        });
        $A.enqueueAction(action);
    },
    
    onAccountSelect : function(component,event,helper){
        
        var eve=event.getParam("selectedAccount");
        component.set("v.SelectedAccount",eve);
        
    }
})