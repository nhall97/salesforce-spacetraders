public class generateUserAndToken {
    public static void generate(String userName) {
        User sf_user = getCurrentUser();

        HttpResponse res = doCallout(userName);

        //create http request
        spaceTrader st_user = parseResponse(res);

        System.debug('DEBUG st_user.token: ' + st_user.token);

        sf_user = mapResponseToBody(st_user, sf_user);

        System.debug('DEBUG sf_user.token: ' + st_user.token);
        try {
            update sf_user;
        } catch (Exception ex)
        {
            System.debug('ERROR in updating user: ' + ex);
        }
    }

    public static HttpResponse doCallout(String userName)
    {
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://api.spacetraders.io/users/' + userName + '/token');
        req.setMethod('POST');
        HttpResponse res = h.send(req);

        return res;
    }

    public static User getCurrentUser()
    {
        User currentUser = [SELECT Id, Name FROM User WHERE Id =: UserInfo.getUserId()];
        return currentUser;
    }

    @testVisible
    private static spaceTrader parseResponse(HttpResponse res)
    {
        System.debug(res.getBody());
        spaceTrader spacetraderUser = (spaceTrader)JSON.deserialize(res.getBody(), spaceTrader.class);

        spaceTrader.parse(res.getBody());

        //System.debug(spacetraderUser);
        return spacetraderUser;
    }

    private static User mapResponseToBody(spaceTrader st_user, User sf_user)
    {
        sf_user.spaceTraderToken__c = st_user.token;
        System.debug('DEBUG sf_user.spaceTraderToken__c: ' + sf_user.spaceTraderToken__c);
        sf_user.spaceTraderUsername__c = st_user.user.username;
        sf_user.spaceTraderId__c = st_user.user.id;
        return sf_user;
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
