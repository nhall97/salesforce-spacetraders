@isTest
public with sharing class generateUserAndTokenTest {
    @isTest static void generateUserAndTokenTest() {
        //create mock from static resources
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('generateUserAndTokenMock');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json');
        
        // Set the mock callout mode
        Test.setMock(HttpCalloutMock.class, mock);
        
        // Call the method that performs the callout
        HTTPResponse res = generateUserAndToken.generateUserAndToken('test3');
        
        // Verify response received contains values returned by
        // the mock response.
        // This is the content of the static resource.
        System.assertEquals('{ "token": "215bb7e6-4a69-47d7-a158-e71e2578dccb", "user": { "id": "ckmqdaxw046048615s6oabhoc7v", "username": "test3", "picture": null, "email": null, "credits": 0, "createdAt": "2021-03-26T13:55:59.376Z", "updatedAt": "2021-03-26T13:55:59.376Z" } }', res.getBody());
        System.assertEquals(200,res.getStatusCode());
        System.assertEquals('application/json', res.getHeader('Content-Type'));   
    }

    @isTest static void testParseToUserObject()
    {
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('generateUserAndTokenMock');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json');
        
        Test.setMock(HttpCalloutMock.class, mock);
        spaceTrader st_user;

        Test.startTest();
            HttpResponse res = generateUserAndToken.generateUserAndToken('test3');
            st_user = generateUserAndToken.parseResponseForUsername(res);
        Test.stopTest();

        System.assertEquals('215bb7e6-4a69-47d7-a158-e71e2578dccb', st_user.token, 'token should be equal to staticresourcemock token');
        System.assertEquals('test3', st_user.user.username, 'test3 should be equal to staticresourcemock username');
        System.assertEquals('ckmqdaxw046048615s6oabhoc7v', st_user.user.id, 'Id should be equal to the staticresourcemock id');
    }
}
