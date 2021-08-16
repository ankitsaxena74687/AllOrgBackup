// step 1 : create callback
const store={};
		
//step2 create subscribe model
const subscribe=(eventname,callback)=>{
if(!store[eventname]){
   store[eventname]=new Set();
}
  store[eventname].add(callback);
}

//step 3 : Create publish method
const publish=(eventname,payload)=>{
if(store[eventname]){
store[eventname].forEach(callback=>{
try{
callback(payload);
}
catch(error){
    /* eslint-disable no-console */
    console.log('Inside Error'+error);
}
})
}
}

//step 3 : Create unsubscribe method
const unsubscribe=(eventname,callback)=>{
    if(store[eventname]){
        store[eventname].delete(callback);
    }
}

export default{
 subscribe,
 unsubscribe,
 publish  
}