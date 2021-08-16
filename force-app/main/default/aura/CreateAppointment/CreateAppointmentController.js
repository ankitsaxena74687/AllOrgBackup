({
	handleReview : function(component, event, helper) {
		var isValid=helper.requiredValidation(component, event);
        if(isValid){
            alert('success');
            console.log(v.Appointment);
           var compEvent=component.getEvent('CreateApp');
            compEvent.setParams({
             'appRecord': component.get('v.Appointment')
            });
            compEvent.fire();
        }
        
        else
        {
            alert('Please fill the required fields');
        }
	}
})