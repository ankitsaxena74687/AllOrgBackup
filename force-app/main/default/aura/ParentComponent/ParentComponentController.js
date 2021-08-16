({
	doInit : function(component, event, helper) {
        component.set("v.MyName",'Pcomponent');
		
	},
    changeName: function(component, event, helper) {
        component.set("v.MyName",'Pcomponent changed');
        alert("Button clicked");
		
	},
    
    onCallChildMethod : function(component, event, helper) {
        alert("Method clicked");
        console.log('child is called');
        var attribute1 = component.get('v.parentAttribute1');
        var attribute2 = component.get('v.parentAttribute2');
        var childComponent = component.find('child');
        childComponent.myMethod(attribute1, attribute2);
        
    }

})