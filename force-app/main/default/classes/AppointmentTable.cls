public class AppointmentTable {
@AuraEnabled
    public static List <Appointment_ID__c> getAppointments(String pid) {
        System.debug('======String pid========'+pid);
        List<Appointment_ID__c> appList = new List<Appointment_ID__c>();
        for(Appointment_ID__c App : [SELECT  id,Name,Appointment_Type__c,Appointment_Date__c,Status__c,Description__c,Doctor_Appointed__c,Fee__c,Patient_s_mail__c FROM Appointment_ID__c where Patient_Id__c=:pid]){
            appList.add(App);
        }
         System.debug('========appList==========='+appList);
      return appList;
   
    }}