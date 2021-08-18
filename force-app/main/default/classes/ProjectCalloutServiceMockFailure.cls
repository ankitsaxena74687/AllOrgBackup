@isTest
global class ProjectCalloutServiceMockFailure implements HttpCalloutMock{
    global HttpResponse respond(HttpRequest request){
        HttpResponse resp=new HttpResponse();
        resp.setHeader('Content-Type','application/json;charset=UTF-8');
        resp.setStatus('Bad Response');
        resp.setStatusCode(500);
        return resp;
    }
}