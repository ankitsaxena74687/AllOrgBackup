({
    fetchAppointments : function(component, event, helper) {
     var tableColumns = [
            {
        label: 'Action',
        type: 'button-icon',
        initialWidth: 75,
        typeAttributes: {
            iconName: 'action:preview',
            title: 'Preview',
            variant: 'border-filled',
            alternativeText: 'View'
        }
    },
            
            {
                "label": "Status",
                "fieldName": "Status__c",
                "cellAttributes": {
                    "class": {
                        "fieldName": "showClass"
                    },
                    "iconName": {
                        "fieldName": "displayIconName"
                    }
                }
            },
        {
                "label": "Appointment Id",
                "fieldName": "linkName",
                "type": "url",
                "typeAttributes": {
                    "label": {
                        "fieldName": "Name"
                    },
                    "target": "_blank"
                },
                "cellAttributes": {
                    "class": {
                        "fieldName": "showClass"
                    }
                }
            },
            {
                "label": "Appointment_Type__c",
                "fieldName": "Appointment_Type__c",
                "type": "picklist",
                "cellAttributes": {
                    "class": {
                        "fieldName": "showClass"
                    }
                }
            },
            {
                "label": "Appointment Date",
                "fieldName": "Appointment_Date__c",
                "type": "Date",
                "cellAttributes": {
                    "class": {
                        "fieldName": "showClass"
                    }
                }
            }
        ];
        
        component.set('v.tableCol', tableColumns);
        
        // call server side apex method to fetch account records
        var action = component.get("c.getAppointments");
        action.setParams({
            
            pid : component.get("v.recordId")
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                var records = response.getReturnValue();
                records.forEach(function(record){ 
                    if(record.Status__c=='open'){
                        record.showClass = (record.Status__c === 'open' ? 'greencolor' : 'redcolor');
                        record.displayIconName = 'utility:check';  
                    }
                    else{
                        record.showClass = (record.status__c=== 'closed' ? 'blackcolor' : 'redcolor');
                        record.displayIconName = 'utility:close';     
                    }
                    // set the record link with record id  
                    record.linkName = '/'+record.Id;   
                    
                });
                // after the loop set the updated account records on "accountList" aura attribute
                component.set("v.appList", records);
            }
        });
        $A.enqueueAction(action);
    },
    openModel: function(component, event, helper) {
        
        component.set("v.isOpen", true);
    },
    
    closeModel: function(component, event, helper) { 
        component.set("v.isOpen", false);
    },
    
    handleRowAction: function(component, event, helper) { 
   
        var action = event.getParam('Action');
        var row = event.getParam('row');
       component.set("v.rec",row);
        component.set("v.isOpen", true); 

    }
    
})