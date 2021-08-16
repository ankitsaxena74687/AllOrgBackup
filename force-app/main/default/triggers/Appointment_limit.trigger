trigger Appointment_limit on Appointment_ID__c (before insert) {
    set<id> PatId=new set<id>();
    for(Appointment_ID__c app:trigger.new){
       if(app.Patient_Id__c !=null){
         PatId.add(app.Patient_Id__c);  
        }}
    
    Map<id,Patient__c> pmap=new Map<id,patient__c>([select id,name,(select id from Appointments__r)  from patient__c where id in:PatId]);
   for(Appointment_ID__C app:trigger.new){
        if(app.Patient_Id__c !=null && pmap.containsKey(app.Patient_Id__c)){
          Patient__c pp= pmap.get(app.Patient_Id__c);
           if(pp.Appointments__r.size()>=3)
           app.addError('A patient cannot have more than 3 appointments');
         
        }    }  
}