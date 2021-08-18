trigger Name_Suffix on Doctor__c (before insert) {
         for(Doctor__c d:trigger.new)
        d.Name='Dr. '+ d.Name;
}