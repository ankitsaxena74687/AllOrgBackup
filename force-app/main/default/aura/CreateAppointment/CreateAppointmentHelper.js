({
	 requiredValidation : function(component,event) {
        // get all accounts.. 	
         var isValid = component.find("newApp").reduce(function(validFields,inputComp){
             
             inputCmp.showHelpMessageIfInvalid();
             inputCmp.set('v.validity',{valid:false,badInput:true});
             return validSoFar && inputCmp.get('v.validity').valid;
         },true)
        return isValid;
    }
})