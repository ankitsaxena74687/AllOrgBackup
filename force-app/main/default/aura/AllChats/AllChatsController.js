({
	doInit : function(component, event, helper) {
		var action=component.get("c.patientListSearch");
        var myid=component.get("v.recId");
        console.log('Patient Id'+myid);
        action.setParams({
            Pid : myid
        });
        action.setCallback(this,function(response){
            var state=response.getState();
            if(state=='SUCCESS'){
                console.log('Inside Sucess');
                component.set("v.PList",response.getReturnValue());
                console.log(response.getReturnValue());
            }
            else {
                alert('ERROR');
            }
        });
        $A.enqueueAction(action); 
	},
    
handleLikeButtonClick : function (component) {
component.set('v.liked', !component.get('v.liked'));
},
handleAnswerButtonClick: function (component) {
component.set('v.answered', !component.get('v.answered'));
}

})