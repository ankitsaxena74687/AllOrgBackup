({
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