({
	handleClick : function(component, event, helper)  {
        var cls=component.find('btn').get('v.class');
        alert('class is '+cls);
        var target=component.find('btn');
        $A.util.addClass(target,'.popover-btn');
   
    
}
})