import { LightningElement,track,api } from 'lwc';
import searchResult from '@salesforce/apex/WorkOrderController.SearchRecords';
import pubsub from 'c/pubsub';
export default class CommonLookup extends LightningElement {
@api lookuptype;
@api parentid;
@api placeholdervalue;
@track resultList;
@api iconname;
@api namevalue;
@api showrequired;
@track searchstring;
@track disableinput=false;
@track opendropdown=false;
@track noresultfound=false;
@track errors;
@track selectedValue;
@track isloading=false;
@track hasRendered = true;
connectedCallback() {
    if(this.namevalue!=undefined || this.namevalue!=null ){
       this.selectedValue= this.namevalue; 
       this.disableinput=true;
    }
   // this.callsubscriber(this.lookuptype);
}
renderedCallback() {
    if((this.namevalue!=undefined || this.namevalue!=null) && this.hasRendered===true){
   this.template.querySelector('.slds-lookup__search-input').value=this.namevalue;
   this.hasRendered = false;
}
} 
handleChange(event){
    this.searchstring=event.target.value;
    if(this.searchstring.length>2){
        this.isloading=true;
        searchResult({searchkeyword:this.searchstring,ParentId:this.parentid,type:this.lookuptype})  
        .then(result=>{
            this.isloading=false;
            this.resultList=result;
            this.opendropdown=true;
           if(result){
            if(result.length===0){
                this.noresultfound=true;
            }
            else{
                this.noresultfound=false;
            } }
        })
        .catch(error=>{
            this.errors=error;
          })
    }
    else{
        this.opendropdown=false;
    }
}
optionClickHandler(event){
    let selname=event.currentTarget.dataset.name; 
    let selid=event.currentTarget.dataset.id;
    let seltype=event.currentTarget.dataset.typevalue;  
    let selrec=event.currentTarget.dataset;
    this.selectedValue=selname;
    this.opendropdown=false;
    this.disableinput=true;
    this.showrequired=false;
    this.template.querySelector('.slds-lookup__search-input').value =event.currentTarget.dataset.name ;
    //this.callparentevent(selid,seltype);
    this.callparentevent(selrec);
}
/*get getselectedValue(){
   let searchstring=this.template.querySelector('.slds-lookup__search-input').value;
    return  ? : '';
   
}*/
clearOption(){
    const clearselection={
        id:'',
    typevalue: this.lookuptype}
    this.template.querySelector('.slds-lookup__search-input').value ='';
    this.selectedValue='';
    this.disableinput=false;
    //this.callparentevent('',this.lookuptype);
    this.callparentevent(clearselection);
    let lktype=this.lookuptype;
    this.eventpublisher(lktype);

    
}
get switchclass(){
    return this.opendropdown ? 'slds-combobox slds-dropdown-trigger slds-dropdown-trigger_click slds-is-open' : 'slds-combobox slds-dropdown-trigger slds-dropdown-trigger_click';     
}
callparentevent(selrec){
    const passEvent = new CustomEvent('recordselection', {
        detail:{ selrecord:selrec
                //selrecid:selid,
                //selrectype:seltype
        } 
    });
   this.dispatchEvent(passEvent);
}
get getdivclass(){
    return this.showrequired ? "slds-combobox__form-element slds-input-has-icon slds-input-has-icon_right slds-has-error" : "slds-combobox__form-element slds-input-has-icon slds-input-has-icon_right" ;
}

}