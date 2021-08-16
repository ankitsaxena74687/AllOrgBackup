public class vfclass2 {
//public List<Patient__c>pList {get;set;}
 String keyword; 
 List<Appointment_ID__c> appList;
 
public String getkeyword(){
        return keyword;}
   
    public List<Appointment_ID__c> getappList(){
        return appList;}
    
    public void setkeyword(String s){
        keyword=s;}
    
    public PageReference Search(){
         list<Patient__c> plist=new list<Patient__c>([select id from Patient__c where Name like :'%'+keyword+'%' Limit 1]);
        appList =[select name,Appointment_Type__c,Fee__c from Appointment_ID__c where Patient_Id__c in:plist];
        return null;
    }}