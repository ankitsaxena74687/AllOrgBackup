({
    requiredValidation : function(component,event) {
        // get all accounts.. 	
        var allRecords = component.get("v.ConList");
        var isValid = true;
        // play a for loop on all account list and check that account name is not null,   
        for(var i = 0; i < allRecords.length;i++){
            if(allRecords[i].Name == null || allRecords[i].Name.trim() == ''){
                alert('Complete this field : Row No ' + (i+1) + ' Name is null' );
                isValid = false;
            }  
        }
        return isValid;
    },
    createContact: function(component,responsevalue) {
        var recordEvent = $A.get("e.force:createRecord");
        recordEvent.setParams({
            "entityApiName": "Contact",
            "defaultFieldValues" :{
                "AccountId" :component.get('v.recordId'),
                "Type__c"   : responsevalue
            },  
            
        });
        recordEvent.fire(); }
    
})