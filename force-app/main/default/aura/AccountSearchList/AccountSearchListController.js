({  showDetails: function(component, event, helper){
    var eventSource=event.getSource();
    var Ac=eventSource.get('v.name');
    component.set('v.AccountId',Ac);
    $A.createComponent(
        "c:AccountDetail",
        { "AccountId" :Ac },
        function(AccountDetail,status,errorMessage){
            if(status=="SUCCESS"){
                console.log('inside success');
                component.find('overlayLib').showCustomModal({
                    header: "Account Detail",
                    body:AccountDetail,
                    footer:'Footer',
                    showCloseButton: true,
                    closeCallback: function() {
                    } 
                }); 
            }             
        });
    
},
  
  showContact: function(component, event, helper) {
      var eventSource=event.getSource();
      var Ac=eventSource.get('v.name');
      var action=component.get('c.searchContact');
      action.setParams({
          AcId:Ac
      });
      action.setCallback(this,function(response){
          var state=response.getState();
          if(state==='SUCCESS'){
              var responsevalue=response.getReturnValue();
              console.log(responsevalue);
              component.set('v.ConList',responsevalue);
          }
          else{ console.log(response.getError());}
      });
      $A.enqueueAction(action);
  },
  Save: function(component, event, helper) {
      
      if (helper.requiredValidation(component, event)){ 
          var action = component.get("c.saveContact");
          action.setParams({
              'lstContact': component.get("v.ConList")
          });
          action.setCallback(this, function(response) {
              var state = response.getState();
              if (state === "SUCCESS") {
                  var storeResponse = response.getReturnValue();
                  component.set("v.ConList", storeResponse);
                  component.set("v.showSaveCancelBtn",false);
                  alert('Updated...');
              }
          });
          $A.enqueueAction(action);
      } 
  },
  
  cancel : function(component,event,helper){
      $A.get('e.force:refreshView').fire(); 
  },
  
  quickContact : function(component, event, helper) {
      var eventSource=event.getSource();
      var Ac=eventSource.get('v.name');
      var action=component.get('c.Mymethod');
      action.setParams({
          AcId :Ac
      });
      action.setCallback(this,function(response){
          var state=response.getState();
          if(state==='SUCCESS'){
              
              var responsevalue=response.getReturnValue(); 
              helper.createContact(component,responsevalue)
              
          }
          else{ console.log(response.getError());}
      });
      $A.enqueueAction(action);
  }
  
 })