public class generateUserAndToken {
    public static HttpResponse generateUserAndToken(String userName) {
 
        // Instantiate a new http object
        Http h = new Http();
     
        HttpRequest req = new HttpRequest();

        //https://api.spacetraders.io/users/:username/token
        //https://api.spacetraders.io/users/test3/token

        req.setEndpoint('https://api.spacetraders.io/users/' + userName + '/token');
        req.setMethod('POST');
     
        // Send the request, and return a response
        HttpResponse res = h.send(req);
        return res;
    }
}
