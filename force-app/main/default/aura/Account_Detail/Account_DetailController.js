({
	doInit : function(component, event, helper) {
        var redirectToSObjectPageEvent=$A.get("e.force:navigateToSObject");
        if(redirectToSObjectPageEvent)
            component.set("v.showButton",true);
	},
    
})