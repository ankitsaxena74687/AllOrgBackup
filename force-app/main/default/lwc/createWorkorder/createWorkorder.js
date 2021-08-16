import { LightningElement,track,api,wire } from 'lwc';
import {getPicklistValues} from 'lightning/uiObjectInfoApi';
import PRIORITY_FIELD from '@salesforce/schema/WorkOrder__c.Priority__c';
import SENDTOINTACCT_FIELD from '@salesforce/schema/WorkOrder__c.Send_to_Intacct__c';
import QUOTEREQUIRED_FIELD from '@salesforce/schema/WorkOrder__c.Quote_required__c';
import saveworkorder from '@salesforce/apex/WorkOrderController.saveWorkorder';
import { NavigationMixin } from 'lightning/navigation';
import { ShowToastEvent } from 'lightning/platformShowToastEvent'

export default class CreateWorkorder extends NavigationMixin(LightningElement) {
//coming from parent
@api openmodal;
@api parentselectedrecord; 
//hold values for fields on workorder
@track contracttype='Field Service';
@track Priority_value;
@track sendtointacct_value='No';
@track quoterequired='No';
@track gpscoordinates;
@track locationid='';
@track customerid='';
@track contactid='';
@track leadid='';
@track productlists;
//hold errors
@track error1;
@track error2;
//these are used to prepoulate  values on common lookup component
@track locationname;
@track customername;
// these are used to show or hide required messages
@track isLoading=false;
@track showlocationmsg;
@track showaccountmsg;
@track showcontactmsg;
@track showleadmsg;
@track showprioritymsg;
@track showproductmsg;
@track showmap=false;



connectedCallback() {
    let prec=this.parentselectedrecord;
    /* eslint-disable no-console */
    let ptype=prec.typevalue;
    if(ptype==='Location'){
      this.locationname=prec.name;
      this.locationid=prec.id;
      this.gpscoordinates=prec.latitude+' '+prec.longitude;
    }
    else if(ptype==='Account'){
      this.customername=prec.name; 
      this.customerid=prec.id;
    }
    else if(ptype==='LocationAPI'){
      this.locationname=prec.name;
      this.gpscoordinates=prec.latitude+' , '+prec.longitude;
    }
}
closeModal(){
  this.openmodal=false;
  const clearsearch= new CustomEvent('clearhomesearch', {});
    this.dispatchEvent(clearsearch);
}
@wire(getPicklistValues,{
  recordTypeId : '012000000000000AAA',
  fieldApiName : PRIORITY_FIELD
})priorityvalues;

@wire(getPicklistValues,{
  recordTypeId:'012000000000000AAA',
  fieldApiName:SENDTOINTACCT_FIELD
})sendtointacctvalues;

@wire(getPicklistValues,{
  recordTypeId:'012000000000000AAA',
  fieldApiName:QUOTEREQUIRED_FIELD
})quoterequiredvalues;

toggleSection(event){
      /* eslint-disable no-console */
      console.log('Inside Togglesection');
  // dynamically get aura:id name from 'data-auraId' attribute
      var sectionAuraId = event.target.getAttribute("data-auraid");
      // get section Div element using aura:id
      console.log('sectionAuraId== '+sectionAuraId);
      var sectionDiv = component.find(sectionAuraId).getElement();
      console.log('sectionDiv== '+sectionDiv);
      var sectionState = sectionDiv.getAttribute('class').search('slds-is-open'); 
      if(sectionState == -1){
          sectionDiv.setAttribute('class' , 'slds-section slds-is-open');
      }else{
          sectionDiv.setAttribute('class' , 'slds-section slds-is-close');
      }
}
handlerecordselection(event){
let getselrec=event.detail.selrecord;
  /* eslint-disable no-console */
if(getselrec!=null){
console.log('Inside Handling event id '+getselrec.id+' and type '+getselrec.typevalue);
if(getselrec.typevalue==='Account'){
    this.customerid=getselrec.id;
    this.showaccountmsg=false;
}
else if(getselrec.typevalue==='Location'){
    this.locationid=getselrec.id;
    this.showlocationmsg=false;
    if(getselrec.id==='' || getselrec.id===null || getselrec.id===undefined){
      this.gpscoordinates='';
    }
    else {
      this.gpscoordinates=getselrec.latitude+' , '+getselrec.longitude;
    }
}
else if(getselrec.typevalue==='Contact'){
  this.contactid=getselrec.id;
  this.showcontactmsg=false;
}
else if(getselrec.typevalue==='Lead'){
  this.leadid=getselrec.id;
  this.showleadmsg=false;
}
else if(getselrec.typevalue==='LocationAPI') {
  if(getselrec.id==='' || getselrec.id===null || getselrec.id===undefined){
    this.gpscoordinates='';
  }else {
    this.gpscoordinates=getselrec.latitude+' , '+getselrec.longitude;
  }
} }
}
handlepicklistchnage(event){
if(event.currentTarget.name==='PriorityValues'){
  this.Priority_value=event.detail.value;
  this.showprioritymsg=false;
}
else if(event.currentTarget.name==='QuoteRequiredValues'){
  this.quoterequired=event.detail.value;
}
else if(event.currentTarget.name==='SendToIntacctValues'){
  this.sendtointacct_value=event.detail.value;
  if(event.detail.value==='No' && this.showleadmsg==true){
    this.showleadmsg=false;
  }
}
}
createWO(){
  var workorder={
Account__c:this.customerid,
Location__c:this.locationid,
Contact__c:this.contactid,
Project__c:this.leadid,
Send_to_Intacct__c:this.sendtointacct_value,
Priority__c:this.Priority_value,
Order_Type__c:this.contracttype,
Quote_required__c:this.quoterequired,
Status__c:'Open'
};

let getvalidation=this.validation(workorder);
/* eslint-disable no-console */
console.log('getvalidation==='+getvalidation);
if(getvalidation){
  this.isLoading=true;
saveworkorder({work:workorder,prolist:this.productlists,locationname:this.locationname})
.then(result=>{
  let getresponse=result;
  if(getresponse && getresponse!='Error'){
    this.isLoading=false;
/* eslint-disable no-console */
console.log('response value'+getresponse);
this.showToast('Successfull','success','Work Order is successfully created');
this.closeModal();
this[NavigationMixin.Navigate]({
  type: 'standard__recordPage',
  attributes: {
      recordId: getresponse,
      objectApiName: 'WorkOrder__c',
      actionName: 'view'
  }
}); 
    }

})
.catch(error=>{
    this.error1=error;
    this.showToast('Error','error','Something wrong !!! check server logs');
})
} 
}

validation(order){
var dosave=true;
if(order.Account__c===undefined || order.Account__c===null || order.Account__c===''){
this.showaccountmsg=true;
dosave=false;
}

if((this.locationname===undefined || this.locationname===null || this.locationnamec==='')
&& (order.Location__c===undefined || order.Location__c===null || order.Location__c==='')){
this.showlocationmsg=true;
dosave=false;
}
if(order.Contact__c===undefined || order.Contact__c===null || order.Contact__c===''){
this.showcontactmsg=true;
dosave=false;
}
if((order.Project__c===undefined || order.Project__c===null || order.Project__c==='') && order.Send_to_Intacct__c==='Yes'){
this.showleadmsg=true;
dosave=false;
}
if(order.Priority__c===undefined || order.Priority__c===null || order.Priority__c===''){
this.showprioritymsg=true;
dosave=false;
}


if(this.productlists===undefined || this.productlists===null){
  this.showproductmsg=true;
  dosave=false;
}
else {
  if(this.productlists.length<=0){
    this.showproductmsg=true;
    dosave=false;
  }
}
return dosave;
}
showToast(toasttitle,variantType,msg) {
  const event = new ShowToastEvent({
      title: toasttitle,
      message: msg,
      variant: variantType,
  });
  this.dispatchEvent(event);
}
setproductlist(event){
  this.productlists=event.detail.selrecordlist;
  this.showproductmsg=false;
}
showmapmarker(){
  this.showmap=true;
}
}