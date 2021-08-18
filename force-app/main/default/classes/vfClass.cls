public class vfClass {
//public List<Patient__c>pList {get;set;}
 String keyword; 
 List<Patient__c> pList = new List<Patient__c>([select id,name,(select id,name from Appointments__r) from Patient__c]);
 
public String getkeyoword(){
        return keyword;
    }
   
    public List<Patient__c> getpList(){
        return pList;
    }
    
    public void Save(){
        
    }}