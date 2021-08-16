import { LightningElement,track,api } from 'lwc';
import searchResult from '@salesforce/apex/WorkOrderController.SearchRecords';
export default class LookupSearch extends LightningElement {
    @api lookuptype;
    @api parentid;
    /*@api selectedname;
    @api selectedid;
    @api selectedtype;*/
    @api parentrecord;
    @track searchstring;
    @track errors;
    @track resultList;
    @track opendropdown=false;
    @track selectedValue;
    @track disableinput=false;
    @track noresultfound=false;
    @track showpopup;
    @track isloading=false;
    handleChange(event){
        this.searchstring=event.target.value;
        if(this.searchstring.length>2){
            this.isloading=true;
            searchResult({searchkeyword:this.searchstring,ParentId:'',type:'All'})  
            .then(result=>{
                this.isloading=false;
                this.resultList=result;
                this.opendropdown=true;
                if(result.length===0){
                    this.noresultfound=true;
                }
                else{
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
       
       /*this.selectedname=event.currentTarget.dataset.name ;
       this.selectedid=event.currentTarget.dataset.id;
       this.selectedtype=event.currentTarget.dataset.typevalue;*/
       this.parentrecord=event.currentTarget.dataset;
        this.opendropdown=false;
        this.disableinput=true;
        
        this.template.querySelector('.slds-combobox__input').value =event.currentTarget.dataset.name ;
        this.selectedValue=this.selectedname;
        
        this.showpopup=true;
        
    }
    clearOption(){
        this.template.querySelector('.slds-combobox__input').value ='';
        this.selectedValue='';
        this.disableinput=false;
        this.showpopup=false;
        this.isloading=false;
    }
   
    get switchclass(){
        return this.opendropdown ? 'slds-combobox slds-dropdown-trigger slds-dropdown-trigger_click slds-is-open' : 'slds-combobox slds-dropdown-trigger slds-dropdown-trigger_click';     
    }

    
}