({
	init : function(component, event, helper) {
		var action=component.get("c.getAllAccounts");
       component.set('v.columns', [
            {label: 'Account name', fieldName: 'Name', type: 'text'},
            {label: 'Account Id', fieldName: 'Id', type: 'String'},
            {label: 'Type', fieldName: 'Type', Type: 'String'},
            {label: 'Industry', fieldName: 'industry', type: 'String'},
           {label: 'CreatedDate', fieldName: 'CreatedDate', type: 'Date'},
           {label: '', type: 'button-icon', typeAttributes: { label: { fieldName: 'actionLabel'}, title: 'Edit Record', name: 'Edit_record', iconName: 'utility:edit', disabled: {fieldName: 'actionDisabled'}, class: 'btn_next'}},
            {label: '', type: 'button-icon', typeAttributes: { label: { fieldName: 'actionLabel'}, title: 'delete Record', name: 'Delete_record', iconName: 'utility:delete', disabled: {fieldName: 'actionDisabled'}, class: 'btn_next'}}
        ]);
	       console.log('inside init');
            
            action.setCallback(this, function(response){
             console.log('Status====='+response.getState());
                if (response.getState() == "SUCCESS") {
                 var accList = response.getReturnValue();

                component.set("v.data",accList);
            }
            else{
                console.log('Error');
            }
            
            
            });  
    $A.enqueueAction(action);
    },
    
    handleRowAction:  function(component,event,helper){
        var recId = event.getParam('row').Id;
         component.set("v.IdInput",recId);
        console.log('recId=='+recId);
        var myname=event.getParam('row').Name;
        component.set("v.nameInput",myname);
        var mytype=event.getParam('row').Type;
        component.set("v.typeInput",mytype);
        var myIndustry=event.getParam('row').Industry;
        component.set("v.industryInput",myIndustry);
        var actionName = event.getParam('action').name;
        console.log('actionName=='+actionName);
        if(actionName == 'Edit_record'){
            component.set("v.isModalOpen",true);
        }
    },
    EditAcc :function(component,event,helper){
         console.log('====here====');
        var updname=component.get("v.nameInput");
        console.log('====v.nameInput===='+updname);
        component.set("v.updateAcc.Name",component.get("v.nameInput"));
       component.set("v.updateAcc.Type",component.get("v.typeInput"));
        component.set("v.updateAcc.industry",component.get("v.industryInput"));
        component.set("v.updateAcc.Id",component.get("v.IdInput"));
        var updAccc=component.get("v.updateAcc");
        console.log('====updateAcc===='+updAccc);
         console.log('====updateAcc ID===='+updAccc.Id);
        
    var action = component.get( "c.updateAccount" );  
        action.setParams({  
            'acc' : updAccc,  
        });
         action.setCallback( this, function( response ) { 
            var state = response.getState(); 
            console.log("state=="+state);
             if ( state === "SUCCESS" ) {
                 var MessageReturn =  response.getReturnValue();
                 console.log('====MessageReturn===='+MessageReturn);
                 component.set("v.isModalOpen" , false);
             }
             else{
                 console.log('====ERROR===');
                 
             } });
         $A.enqueueAction(action);
    },
     NewMappingPopUp : function(component,event,helper){
        console.log("+++PopUpOpens+++");
        component.set("v.isModalOpen",true);
    },
    
    closePopUp: function(component, event, helper) {
        // Set isModalOpen attribute to false  
        component.set("v.isModalOpen", false);
        component.set("v.StarkCoInput",'');
        component.set("v.LocationInput",'');
        component.set("v.LegacyCoInput",'');
        component.set("v.DivInput",'');
        component.set("v.TLBInput",'');
        component.set("v.TLBCodeInput",'');
    },
    
    
})