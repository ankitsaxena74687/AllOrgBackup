({
	doClick : function(component, event, helper) {
		alert(component.isValid());
        alert(component.getName());
        var Name=component.find("name");
         Name.get();
	}
})