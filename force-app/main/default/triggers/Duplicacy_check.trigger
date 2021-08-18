trigger Duplicacy_check on Patient__c (before insert,before update) {

    list<string> pnew=new list<string>();
    list<patient__c> pold=new list<patient__c>();
    map<string,list<Patient__c>> patientMap=new map<string,list<Patient__c>>();
  
    
    for(Patient__c p:trigger.new)
    { pnew.add(p.Name);
    } system.debug('==============List of inserting pateint============='+pnew);
    
    pold=[select id,name from patient__c
          where name IN : pnew];
    system.debug('============== list of already existing patient============='+pold);
   
    
    for(patient__c p:pold){
        
        if(patientMap.containsKey(p.name))
          patientMap.get(p.name).add(p);
        else{ patientMap.put(p.name,new list<Patient__c>());
             patientMap.get(p.name).add(p);    
             }}
                 
system.debug('==============map of patient============='+patientMap);
    
for(patient__c p:trigger.new)
    {  if(patientMap.containsKey(p.name) && patientMap.get(p.name).size()>1)
        p.addError('Sorry the u could not have more than two records of same name');
        
        system.debug('==============Size of List============='+ patientMap.get(p.name).size());
    }
}