import { LightningElement,api,track } from 'lwc';

export default class ShowMap extends LightningElement {
@api openmodal=false; 
@api coordinates;
@track lati;
@track longi;
connectedCallback() {
     /* eslint-disable no-console */
     let geocodes=this.coordinates.split(',');
     this.lati=geocodes[0];
     this.longi=geocodes[1].trim()
     console.log('this.lati==='+this.lati);
     console.log('this.longi==='+this.longi);
}
closeModal(){
this.openmodal=false; 
}
mapMarkers = [{
    location: {
        Latitude:this.lati,
        Longitude: this.longi
    }
}];
}