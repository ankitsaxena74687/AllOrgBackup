({
	handleSearchEvent: function(component, event, helper) {
	var searchParam=event.getParam('searchText');
        var action=component.get('c.searchAccount');
        action.setParams({
            searchParam:searchParam
        });
        action.setCallback(this,function(response){
            var state=response.getState();
            if(state==='SUCCESS'){
                var responsevalue=response.getReturnValue();
                console.log('responseValue',responsevalue);
                component.set('v.AcList',responsevalue);
               }
            else{ console.log(response.getError());}
        });
        $A.enqueueAction(action);
	}
    
})