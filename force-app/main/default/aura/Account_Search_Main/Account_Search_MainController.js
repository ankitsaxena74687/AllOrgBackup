({
	onSearchAccount: function(component, event, helper) {
		var type=event.getParam("AccountType");
        var AccSearchResultComp=component.find("Account_Search_Result");
        if(AccSearchResultComp){
            alert('Hey i m in parent and ur type is'+type);
           AccSearchResultComp.search(type);
        }
	}
})