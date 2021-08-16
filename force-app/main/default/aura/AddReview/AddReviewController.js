({
	doInit : function(component, event, helper) {
		 component.find("AddReview").getNewRecord(
            "MyReviews__c", 
            null,            
            false,          
            $A.getCallback( function() {
                var rec=component.get("v.simpleAddReview");
                var error=component.get("v.recordError");
                if(error || (rec === null)) {
                    console.log("Error initializing record template: " + error);
                }
                else { 
                    component.set("v.addReview.Account__c", component.get("v.account.Id"));
                    console.log("Record template initialized: " + rec.apiName);
                }
            })
        );
        
	},
    onRecordUpdated :  function(component, event, helper) {},
    
    AddReview :  function(component, event, helper) {
        
        component.find("AddReview").saveRecord(function(saveResult) {
            
             if (saveResult.state === "SUCCESS" || saveResult.state === "DRAFT") {
                var resultsToast = $A.get("e.force:showToast");
                if(resultsToast == undefined){
                    alert("The record was saved.");
                }else{
                    resultsToast.setParams({
                        "title": "Saved",
                        "message": "The record was saved."
                    });
                    resultsToast.fire();
                    doInit(component); 
                   
                }
            } else if (saveResult.state === "INCOMPLETE") {
                console.log("User is offline, device doesn't support drafts.");
            } else if (saveResult.state === "ERROR") {
                console.log('Problem saving contact, error: ' +
                            JSON.stringify(saveResult.error));
            } else {
                console.log('Unknown problem, state: ' + saveResult.state +
                            ', error: ' + JSON.stringify(saveResult.error));
            }
        });     
        }
    
})