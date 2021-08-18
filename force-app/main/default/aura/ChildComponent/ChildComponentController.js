({
	executeMyMethod : function (component, event, helper) {
        var params = event.getParam('arguments');
        console.log('Param 1: '+ params.param1);
        console.log('Param 2: '+ params.param2);
        component.set("v.MyFirstName",params.param1);
        component.set("v.MyLastName",params.param2);
        
    }
})