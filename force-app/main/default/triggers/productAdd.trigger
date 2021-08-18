trigger productAdd on OpportunityLineItem (after insert,after update,before insert,before update) {
    
    if (Trigger.isInsert){
       if (Trigger.isafter) 
       {    if(!Checkrecursion.hasAlreadyRunMethod()){
           OppClass.ProAdd(trigger.new);}
       }}}