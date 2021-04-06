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
        HTTPResponse res = generateUserAndToken.doCallout('test3');
        
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
            HttpResponse res = generateUserAndToken.doCallout('test3');
            st_user = generateUserAndToken.parseResponse(res);
        Test.stopTest();

        System.assertEquals('215bb7e6-4a69-47d7-a158-e71e2578dccb', st_user.token, 'token should be equal to staticresourcemock token');
        System.assertEquals('test3', st_user.user.username, 'test3 should be equal to staticresourcemock username');
        System.assertEquals('ckmqdaxw046048615s6oabhoc7v', st_user.user.id, 'Id should be equal to the staticresourcemock id');
    }

    @isTest static void testUserFieldsUpdated()
    {
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('generateUserAndTokenMock');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json');
        
        Test.setMock(HttpCalloutMock.class, mock);
        
        Id profileId = [SELECT Id, Name FROM Profile WHERE Name = 'Standard User' LIMIT 1].Id;

        User sf_user = new User();
        sf_user.Username = 'test3@spacetraders.io';
        sf_user.FirstName = 'Test';
        sf_user.LastName = '3';
        sf_user.email = 'test3@spacetraders.io';
        sf_user.Alias = 'test3';
        sf_user.TimeZoneSidKey = 'Europe/Berlin';
        sf_user.LocaleSidKey = 'en_GB';
        sf_user.EmailEncodingKey = 'UTF-8';
        sf_user.ProfileId = profileId;
        sf_user.LanguageLocaleKey = 'en_US';
        insert sf_user;

        Test.startTest();
            generateUserAndToken.generate(sf_user.Username);
        Test.stopTest();

        User st_user = [SELECT Id, Alias, spaceTraderId__c, spaceTraderToken__c, spaceTraderUsername__c FROM User WHERE Username = 'test3@spacetraders.io'];

        System.debug('TEST USER: ' + st_user.Id);
        System.debug('TEST USER: ' + st_user.spaceTraderId__c);
        System.debug('TEST USER: ' + st_user.Alias);

        System.assertNotEquals(NULL, st_user);
        System.assertNotEquals(NULL, st_user.Id);
        System.assertEquals('ckmqiv2oi81874115s6ip5v5ra9', st_user.spaceTraderId__c);
        System.assertEquals('215bb7e6-4a69-47d7-a158-e71e2578dccb', st_user.spaceTraderToken__c);
        System.assertEquals('test3', st_user.spaceTraderUsername__c);
    }

}
