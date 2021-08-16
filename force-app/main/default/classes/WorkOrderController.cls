public with sharing class WorkOrderController {
public WorkOrderController() {

}
@AuraEnabled(cacheable=true)
public static list<wrapper> SearchRecords(String searchkeyword,String ParentId,String type){
list<wrapper> recordList=new list<wrapper>();
String queryName = '%' + searchkeyword + '%';
String AccountQuery;
String LocationQuery;
String ContactQuery;
String LeadQuery;

if(String.IsNotBlank(searchkeyword))
{
if(type.equals('All')){
AccountQuery='Select Id,Name,BillingState,BillingCity,BillingCountry, BillingStreet, BillingPostalCode from Account where Name like :queryName limit 10';
LocationQuery='Select Id,Name,city__c,state__c,Country__c,Zip_Code__c,latitude__c,longitude__c from Location__c where Name like :queryName limit 10';
for(Account acc:Database.query(AccountQuery)){
recordList.add(new wrapper('Account',acc.id,acc.Name,acc.BillingState,acc.BillingCity,acc.BillingStreet,acc.BillingCountry,acc.BillingPostalCode,'standard:account','',''));
}
for(Location__c loc:Database.query(LocationQuery)){
    string lati=String.valueOf(loc.latitude__c);
    string longi=string.valueOf(loc.longitude__c);
recordList.add(new wrapper('Location',loc.id,loc.name,loc.state__c,loc.city__c,loc.name,loc.country__c,loc.Zip_Code__c,'standard:location',lati,longi));
}
}
if(type.equals('Location')){
LocationQuery='Select Id,Name,city__c,state__c,Country__c,Zip_Code__c,latitude__c,longitude__c from Location__c where Name like :queryName limit 10';
for(Location__c loc:Database.query(LocationQuery)){
    string lati=String.valueOf(loc.latitude__c);
    string longi=string.valueOf(loc.longitude__c);
    recordList.add(new wrapper('Location',loc.id,loc.name,loc.state__c,loc.city__c,loc.name,loc.country__c,loc.Zip_Code__c,'standard:location',lati,longi));
    }    
}
if(type.equals('Account')){
AccountQuery='Select Id,Name,BillingState,BillingCity,BillingCountry, BillingStreet, BillingPostalCode from Account where Name like :queryName limit 10';
for(Account acc:Database.query(AccountQuery)){
    recordList.add(new wrapper('Account',acc.id,acc.Name,acc.BillingState,acc.BillingCity,acc.BillingStreet,acc.BillingCountry,acc.BillingPostalCode,'standard:account','',''));
    }    
}
if(type.equals('Contact')){
ContactQuery='Select Id,Name from Contact where Name like :queryName limit 10';
for(Contact loc:Database.query(ContactQuery)){
    recordList.add(new wrapper('Contact',loc.id,loc.name,'','','','','','standard:contact','',''));
    }    
}
if(type.equals('Lead')){
LeadQuery='Select Id,Name from Lead where Name like :queryName limit 10';
for(Lead loc:Database.query(LeadQuery)){
    recordList.add(new wrapper('Lead',loc.id,loc.name,'','','','','','standard:lead','',''));
    }    
}
System.debug('recordList== '+recordList.size());
if(recordList.size()>0){
return recordList;
}
else if(type.equals('All') || type.equals('Location')){ 
    list<wrapper> myreclist=searchLocationAPI(searchkeyword);
    System.debug('myreclist==='+myreclist);
    if(!myreclist.isempty()){
        return myreclist;
    }
    else return null;
   
}
else {
return null;
}
}
return null;
}
@AuraEnabled
public static string saveWorkorder(WorkOrder__c work,list<Product2> prolist,String locationname){
System.debug('prolist======='+prolist);
System.debug('locationname======='+locationname);
System.debug('Workorder========'+work);
string createloc;
if(string.isblank(work.Location__c) && string.isNotBlank(locationname)){
   createloc=createLocation(locationname,work.Account__c);
}
if(createloc!=null || string.isNotBlank(work.Location__c) ){
    if(createloc!=null){
        work.Location__c=createloc;
    }
    try{
       insert work;
       System.debug('Create Workorder');
    }catch(Exception e){
        System.debug('Inside Exception Workorder'+e.getMessage());
    }
    
}
if(string.isNotBlank(work.id) && prolist==null){
    return work.id;
}
else if(string.isNotBlank(work.id) && prolist!=null){
    string prostatus=AddProducts( work.id,prolist);
    if(prostatus=='Success' || prostatus=='empty list'){
        return work.id;   
    }
    else{
        return 'Error';  
    }
}
else {
    return 'Error';
}
}
@AuraEnabled(cacheable=true)
public static list<sobject> searchProducts(string searchpro){
String queryName = '%' + searchpro + '%'; 
String productQuery='';
list<sobject> myprolist=new list<sobject>();
if(String.IsNotBlank(searchpro)){
productQuery='Select Id,Name from Product2 where Name like :queryName limit 10';
myprolist.addAll(database.query(productQuery));
} 
if(myprolist.size()>0){
return myprolist;
}
else{ return null;}
}

@AuraEnabled
public static string AddProducts(string woid,list<Product2> prolist){ 
list<Estimate_Object__c> estlist=new list<Estimate_Object__c>();
if(prolist.size()>0 && String.IsNotBlank(woid)){
for(Product2 pro:prolist){
Estimate_Object__c est=new Estimate_Object__c();
est.Product__c=pro.Id;
est.WorkOrder__c=woid;
estlist.add(est);
}
}
System.debug('estlist==='+estlist);
if(estlist.size()>0){
insert estlist;
return 'Success'; 
}
else if(estlist.size()==0){
return 'empty list';
}
else {
return 'Error';
}
}
@AuraEnabled
public static string getGeocodes(String Address){
    system.debug('Addressgeo==>'+Address);
    Double Latitude;
    Double Longitude;
    String Lat = '';
    String Lon = '';
    String GeoCodes = '';
    Address = Address.replaceAll(' ','');
    system.debug('Addressgeo2==>'+Address);
    // Address = EncodingUtil.urlEncode(Address, 'UTF-8');
    Http http = new Http();
    HttpRequest Request = new HttpRequest();
    Request.setMethod('GET');
    Request.setEndPoint('https://maps.googleapis.com/maps/api/geocode/json?address='+Address+'&key=AIzaSyBaVpF0yXz8O_bkWIFkzasNSJQx0BxrFlM');
    HttpResponse Response = http.send(Request);
    if(Response.getStatusCode()==200){
        system.debug('Response for Long =='+Response.getBody());
        JSON2Apex_Autocomplete Json2Apex1= parse1(Response.getbody());
        for(JSON2Apex_Autocomplete.results result : Json2Apex1.results){
            system.debug('If results come==> ');
            Latitude= result.geometry.location.lat;
            Lat = string.valueOf(Latitude);
            Longitude= result.geometry.location.lng;
            Lon = string.valueOf(Longitude);
            GeoCodes = Lat+' , '+Lon;
            system.debug('GeoCodes2 api hit==>'+GeoCodes);
        }    
    }
    if(GeoCodes=='' || GeoCodes==null){
         system.debug('GeoCodes2 not found==>');
         GeoCodes='null';  
    }
    else {
        system.debug('===GeoCodes 207==='+GeoCodes);
    }
    return GeoCodes;
}     
@AuraEnabled
public static list<wrapper> searchLocationAPI(String searchkeyword){
    list<wrapper> recordList=new list<wrapper>();
    searchkeyword = EncodingUtil.urlEncode(searchkeyword, 'UTF-8');
    Http http = new Http();
    HttpRequest Request = new HttpRequest();
    Request.setMethod('GET');
    Request.setEndPoint('https://maps.googleapis.com/maps/api/place/autocomplete/json?input='+searchkeyword+'&key=AIzaSyBaVpF0yXz8O_bkWIFkzasNSJQx0BxrFlM');
    HttpResponse Response = http.send(Request);
    if(Response.getStatusCode()==200){
        system.debug('Response.getbody'+Response.getbody());
        JSON2ApexSuggestion Json2Apex= parse(Response.getbody());
        system.debug('Json2Apex'+Json2Apex);
        string CompleteAddress = '';
        List<String> completeaddressList = new List<String>();
        system.debug('Json2Apex.Predictions==== '+Json2Apex.Predictions);
        if(Json2Apex.Predictions != null){
            for(JSON2ApexSuggestion.Predictions Prediction : Json2Apex.Predictions)
            {
                if(string.isNotBlank(Prediction.description)){
                    CompleteAddress = Prediction.description;     
                }
                system.System.debug('Complete Adddress------'+CompleteAddress);
                String getloc=getGeocodes(CompleteAddress);
                System.debug('getgeocodes==='+getloc);
                String[] geocodes=getloc.split(',');
                String lati=geocodes[0];
                String longi=geocodes[1];
                lati= lati.replaceAll( '\\s+', '');
                longi= longi.replaceAll( '\\s+', '');
                System.debug('Latitude'+lati);
                System.debug('Longitude'+longi);
                recordList.add(new wrapper('LocationAPI','Site.id',CompleteAddress,'','','','','','standard:location',lati,longi));  
            }
        }
        system.debug('********resultEnd Final=== '+recordList);
        return recordList; 
    }
    else return null; 
}
@AuraEnabled
public static string createLocation(String SiteAddress,String accountId){
    Location__c site = new Location__c();
    String LocationName = '';
    if((string.isNotBlank(SiteAddress)) ){
        SiteAddress = SiteAddress.replace(' ','');
        system.debug('debug site'+SiteAddress);
        Http http = new Http();
        HttpRequest Request = new HttpRequest();
        Request.setMethod('GET');
        Request.setEndPoint('https://maps.googleapis.com/maps/api/geocode/json?address='+SiteAddress+'&key=AIzaSyBaVpF0yXz8O_bkWIFkzasNSJQx0BxrFlM');
        HttpResponse Response = http.send(Request);
        system.debug('Response=='+Response.getBody());
        if(Response.getStatusCode()==200){
            JSON2Apex_Autocomplete Json2Apex= parse1(Response.getbody());
            
            String StreetNumber = '';
            String StreetName = '';
            String LocationCityName ='';
            String LocationStateName = '';
            String LocationCountryName = '';
            String LocationZipName = '';
           
            Double Latitude;
            Double Longitude;
            for(JSON2Apex_Autocomplete.results result : Json2Apex.results){
                system.debug('Geometry cordinates==>'+ result.geometry.location.lat);
                system.debug('Geometry cordinates long==> '+ result.geometry.location.lng);
                Latitude= result.geometry.location.lat;
                Longitude= result.geometry.location.lng;
                for(JSON2Apex_Autocomplete.address_components address_component: result.address_components){
                    if(String.isNotBlank(accountId)){
                        site.Account__c = accountId;
                    }
                    if(String.isNotBlank(address_component.types[0]) && (address_component.types[0]=='street_number')){ 
                        StreetNumber = address_component.long_name;
                    }if(String.isNotBlank(address_component.types[0]) && (address_component.types[0]=='route')){ 
                        StreetName = StreetNumber+' '+address_component.long_name;
                    }
                    site.Name = StreetName;
                    System.debug('StreetName'+StreetName);
                    if (String.isNotBlank(address_component.types[0]) && (address_component.types[0]=='locality' || address_component.types[0]=='sublocality_level_1')){
                        site.city__c = address_component.long_name;
                        LocationCityName = address_component.long_name;
                        System.debug('LocationCityName'+LocationCityName);
                    }if (String.isNotBlank(address_component.types[0]) && address_component.types[0]=='administrative_area_level_1'){
                        site.State__c =address_component.long_name;   
                        LocationStateName = address_component.long_name; 
                        System.debug('LocationStateName'+LocationStateName);
                    }if (String.isNotBlank(address_component.types[0]) && address_component.types[0]=='postal_code'){
                        site.Zip_Code__c =address_component.long_name; 
                        LocationZipName = address_component.long_name;
                        System.debug('LocationZipName'+LocationZipName);
                    }if (String.isNotBlank(address_component.types[0]) && address_component.types[0]=='country'){
                        site.Country__c =address_component.long_name;
                        LocationCountryName = address_component.long_name;
                        System.debug('LocationCountryName'+LocationCountryName);
                    }if(Latitude != null){
                        site.Latitude__c = Latitude;
                    }if(Longitude != null){
                        site.Longitude__c = Longitude; 
                    }
                    LocationName = StreetName+' '+LocationCityName+' '+LocationStateName+' '+LocationCountryName+' '+LocationZipName;
                 }
            }
        }
    } 
    if(String.isNotEmpty(LocationName)){
       System.debug('site=='+LocationName);
        try{
            insert site;
            System.debug('Site inserted'+site.id);
        }catch(Exception e){
            System.debug('Location Exception');
        }
       
        return site.id;   
      }
      else {
        System.debug('==Null==');  
        return null;}
    
}
public class wrapper{
@AuraEnabled public String DataType{get;set;}
@AuraEnabled public String RecordId{get;set;}
@AuraEnabled public String DataValue{get;set;}
@AuraEnabled public String State{get;set;}
@AuraEnabled public String City{get;set;}
@AuraEnabled public String Street{get;set;}
@AuraEnabled public String Country{get;set;}
@AuraEnabled public String Zip{get;set;}
@AuraEnabled public String iconname{get;set;}
@AuraEnabled public String Latitude{get;set;}
@AuraEnabled public String Longitude{get;set;}

public wrapper(String datatype1,string RecordIdd,string DataValuee,String State1, string City1, string street1, string country1, string Zip1,string iconname1,string latitude1,string longitude1){
DataType = datatype1;
RecordId = RecordIdd;
DataValue = DataValuee;
State = State1;
City = City1;
Street = street1;
Country = country1;
Zip = Zip1;
iconname=iconname1;
Latitude=latitude1;
Longitude=longitude1;
}
}
public static JSON2ApexSuggestion parse(String json) {
return (JSON2ApexSuggestion) System.JSON.deserialize(json, JSON2ApexSuggestion.class);
}
public static JSON2Apex_Autocomplete parse1(String json) {
    return (JSON2Apex_Autocomplete) System.JSON.deserialize(json, JSON2Apex_Autocomplete.class);
}
}