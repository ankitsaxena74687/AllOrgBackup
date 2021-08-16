public class CheckAuthorisation {
    public static void checkAuth(){
        Http http=new Http();
        HttpRequest req=new HttpRequest();
        Httpresponse resp=new Httpresponse();
        String AccessKey='6de9cf44-0c5c-450f-80d4-f2bd4bd78b5c';
        String AccessId='fff60fe1-3fe9-5afb-812b-807434a729b7';
        string user='ApiUser';
       
         DateTime now=DateTime.now();
         DateTime expires_on=now.addSeconds(3600);
         Long Lexpires=expires_on.getTime()/1000;
         String stringtosign=Lexpires+'\n/'+AccessId;
         Blob mac=Crypto.generateMac('HMacSHA256',blob.valueOf(stringtosign),blob.valueOf(Accesskey));
         string signed=Encodingutil.base64Encode(mac);
 string url='https://easytusolve.greythr.com/api/admin/app-authenticate/user/admin/?accessId='+AccessId+'&user='+user+'&timestamp='+now+'&signature='+signed;
        system.debug(now);
        system.debug('URL======='+url);
        req.setEndpoint('https://api.greythr.com');
        req.setMethod('POST');
        resp=http.send(req);
        
        system.debug('response body'+resp);
    }
}