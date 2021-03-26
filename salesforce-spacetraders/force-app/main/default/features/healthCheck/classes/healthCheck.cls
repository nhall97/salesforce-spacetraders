public class healthCheck {
  // Pass in the endpoint to be used using the string url
  
  //public static String healthCheckUrl = '';
  
  public static HttpResponse getGameHealth() {
 
    // Instantiate a new http object
    Http h = new Http();
 
     // Instantiate a new HTTP request, specify the method (GET) as well as the endpoint
    HttpRequest req = new HttpRequest();
    req.setEndpoint('https://api.spacetraders.io/game/status');
    req.setMethod('GET');
 
    // Send the request, and return a response
    HttpResponse res = h.send(req);
    return res;
  }
}