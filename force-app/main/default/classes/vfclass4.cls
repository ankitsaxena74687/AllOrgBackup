public class vfclass4 {
 public List<selectoption> industryPickList{get;set;}
    public string selectedIndustry{get;set;}
    public list<Account>accList {get;set;}
    
    
    public vfclass4(){
    accList = new List<Account>();
        industryPickList = new List<selectoption>();
        industryPickList.add(new selectoption('None','None'));
        industryPickList.add(new selectoption('Agriculture','Agriculture'));
        industryPickList.add(new selectoption('Banking','Banking'));
        industryPickList.add(new selectoption('Energy','Energy'));
        industryPickList.add(new selectoption('Apparel','Apparel'));
    }
    public void afterSelectedIndustry(){
        system.debug('selectedIndustry'+selectedIndustry);
        accList = [select name, industry from Account where industry=:selectedIndustry];
       
         system.debug('accList'+accList.size());
        
     }


}