({
	 searchHandler : function (component, event, helper) {
        const searchString = event.target.value;
        
        if (searchString.length >= 2) {
           helper.searchRecords(component,searchString);
        } else if(searchString.length < 2){
            console.log('string=='+searchString);
            component.set("v.results", null);
            component.set("v.openDropDown", false);
        }
    },
})