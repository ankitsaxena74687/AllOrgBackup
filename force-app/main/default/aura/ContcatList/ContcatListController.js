({
    
/*    doInit: function(component, event, helper) {
      // call the fetchPickListVal(component, field_API_Name, aura_attribute_name_for_store_options) -
      // method for get picklist values dynamic   
        helper.fetchPickListVal(component, 'Rating', 'ratingPicklistOpts');
    },*/
    
    inlineEditName : function(component,event,helper){   
        // show the name edit field popup 
        component.set("v.nameEditMode", true);  
        setTimeout(function(){ 
            component.find("ConName").focus();
        }, 100);
    },
    
    inlineEditEmail : function(component,event,helper){   
        component.set("v.EmailEditMode", true);
         setTimeout(function(){ 
            component.find("ConEmail").focus();
        }, 100);
    },
    
    inlineEditPhone : function(component,event,helper){   
        component.set("v.PhoneEditMode", true);
         setTimeout(function(){ 
            component.find("ConPhone").focus();
        }, 100);
    },
    
     onNameChange : function(component,event,helper){ 
        if(event.getSource().get("v.value").trim() != ''){ 
            component.set("v.showSaveCancelBtn",true);
        }
    },
 
    onEmailChange : function(component,event,helper){ 
        if(event.getSource().get("v.value").trim() != ''){
            component.set("v.showSaveCancelBtn",true);}
    },
     onPhoneChange : function(component,event,helper){ 
        if(event.getSource().get("v.value").trim() != ''){
            component.set("v.showSaveCancelBtn",true);}
    }, 
    
    closeNameBox : function (component, event, helper) {  
        component.set("v.nameEditMode", false); 
        if(event.getSource().get("v.value").trim() == ''){
            component.set("v.showErrorClass",true);
        }else{
            component.set("v.showErrorClass",false);
        }
    }, 
    
    closeEmailBox : function (component, event, helper) {
        component.set("v.EmailEditMode", false); 
        if(event.getSource().get("v.value").trim() == ''){
            component.set("v.showErrorClass",true);
        }else{
            component.set("v.showErrorClass",false);
        }
    },
    
    closePhoneBox : function (component, event, helper) {  
        component.set("v.PhoneEditMode", false); 
        if(event.getSource().get("v.value").trim() == ''){
            component.set("v.showErrorClass",true);
        }else{
            component.set("v.showErrorClass",false);
        }
    },
   
})