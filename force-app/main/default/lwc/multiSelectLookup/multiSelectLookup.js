import { LightningElement,track,api } from 'lwc';
import searchResult from '@salesforce/apex/WorkOrderController.searchProducts';
import addpro from '@salesforce/apex/WorkOrderController.AddProducts';
export default class MultiSelectLookup extends LightningElement {
@track resultList;
@track opendropdown=false;
@track selectedValue;
@track disableinput=false;
@track noresultfound=false;
@track selectedProductList=[];
@track searchstring;
@api recordId;
@track savestatus;
@api showrequired=false;
handleChange(event){
    this.searchstring=event.target.value;
    /* eslint-disable no-console */
    console.log('Searching...'+this.searchstring);
    if(this.searchstring.length>2){
        searchResult({searchpro:this.searchstring})  
        .then(result=>{
            this.resultList=result;
            /* eslint-disable no-console */
            console.log('OK ....');
            this.opendropdown=true;
            if(result.length===0){
                this.noresultfound=true;
            }
            else{
                /* eslint-disable no-console */
                    console.log('Something is wrong ...');
                this.noresultfound=false;
            }
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
    let proname=event.currentTarget.dataset.name; 
    let proid=event.currentTarget.dataset.id;
    this.showrequired=false;
    /* eslint-disable no-console */
    console.log('Selected product id ....'+proid);
    let prodetails={
        Id : proid,
        Name : proname
    };
    this.selectedProductList.push(prodetails);
    this.template.querySelector('.slds-lookup__search-input').value ='';
    this.opendropdown=false;
    this.callparentevent(this.selectedProductList);
}

clearpill(event){
/* eslint-disable no-console */
        var selectedPillId = event.target.name;
        let index;
        console.log('pill id to clearrrr ....'+selectedPillId);
    let founddeletedpill=this.selectedProductList.find(pillDetail => pillDetail.Id === selectedPillId);
    for(let i = 0; i < this.selectedProductList.length; i++){
    if(this.selectedProductList[i].id===selectedPillId){
            index=i;
    }  
}

this.selectedProductList.splice(index, 1);
    if(this.selectedProductList.length===0){
    }
    this.callparentevent(this.selectedProductList);

}
get switchclass(){
    return this.opendropdown ? 'slds-combobox slds-dropdown-trigger slds-dropdown-trigger_click slds-is-open' : 'slds-combobox slds-dropdown-trigger slds-dropdown-trigger_click';     
}
addProducts(){
    /* eslint-disable no-console */
    console.log('Current workorder id..'+this.recordId);
    console.log('Products to inserted '+this.selectedProductList.length);
    addpro({woid:this.recordId,prolist:this.selectedProductList})
    .then(result=>{
        this.savestatus=result;
            if(this.savestatus==='Success') {
             /* eslint-disable no-console */
              console.log('product inserted successfully ....');
              this.selectedProductList=null;
            }
            else {
            /* eslint-disable no-console */
             console.log('Insertion error ....'); 
            }
        
    })
    .catch(error=>{
        this.errors=error;
    })
}
callparentevent(selectedprolist){
    const passEvent = new CustomEvent('recordsselection', {
        detail:{ selrecordlist:selectedprolist
        } 
    });
   this.dispatchEvent(passEvent);
}
get getdivclass(){
    return this.showrequired ? "slds-combobox__form-element slds-input-has-icon slds-input-has-icon_right slds-has-error" : "slds-combobox__form-element slds-input-has-icon slds-input-has-icon_right" ;
}
}