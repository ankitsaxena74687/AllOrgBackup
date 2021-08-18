({
    
   doHandleEvent : function(component, event, helper){
    var appRecord=event.getParam('appRecord');
    var AppRecordList=component.get('v.appRecord');
       if(AppRecordList){
           alert('handled event');
      AppRecordList.push(appRecord);
       component.set('v.appRecord', AppRecordList);
       }
      else
          alert('handled event');
      { AppRecordList=[];
        AppRecordList.push(appRecord);
       component.set('v.appRecord', AppRecordList);
       
      }
       
}
})