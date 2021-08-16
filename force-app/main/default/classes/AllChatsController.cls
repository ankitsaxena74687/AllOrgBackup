public class AllChatsController {
@AuraEnabled
    public static list<Chat__c> patientListSearch(String Pid){
        system.debug('========id=========='+Pid);
        list<chat__c> plist=[select id,Doctor__c,Doctor_name__c from chat__c where patient__c=:Pid];
        system.debug('PLIST'+plist);
        return plist;
    
    
    }
}