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

    @testVisible
    private static spaceTraders parseResponseForUsername (HttpResponse res)
    {
        System.debug(res.getBody());
        spaceTraders spacetraderUser = (spaceTraders)JSON.deserialize(res.getBody(), spaceTraders.class);

        spaceTraders.parse(res.getBody());

        //System.debug(spacetraderUser);
        return spacetraderUser;
    }

    // {
    //     "token": "215bb7e6-4a69-47d7-a158-e71e2578dccb",
    //     "user": {
    //         "id": "ckmqdaxw046048615s6oabhoc7v",
    //         "username": "test3",
    //         "picture": null,
    //         "email": null,
    //         "credits": 0,
    //         "createdAt": "2021-03-26T13:55:59.376Z",
    //         "updatedAt": "2021-03-26T13:55:59.376Z"
    //     }
    // }
}
