import { LightningElement,track,api} from 'lwc';
import searchResult from '@salesforce/apex/WorkOrderController.SearchRecords';
export default class Searchlookup extends LightningElement {
@api lookuptype;
@api parentId;
@track serachstring;
@track errors;
@track resultList;
handleChange(event){
    this.serachstring=event.target.value;
    /* eslint-disable no-console */
    console.log('SearchString'+this.serachstring);

    searchResult({searchkeyword:this.serachstring,ParentId:'',type:'All'})  
    .then(result=>{
        this.resultList=result;
    })
    .catch(error=>{
        this.errors=error;
    })
}
}