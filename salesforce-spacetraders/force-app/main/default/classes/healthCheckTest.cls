@isTest
public with sharing class healthCheckTest {
    @isTest static void testCallout() {
        // Set mock callout class 
        Test.setMock(HttpCalloutMock.class, new healthCheckMock());
        
        Test.startTest();
            HttpResponse res = healthCheck.getGameHealth();
        Test.stopTest();

        // Verify response received contains fake values
        String contentType = res.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        String actualValue = res.getBody();
        String expectedValue = '{"status": "spacetraders is currently online and available to play"}';
        System.assertEquals(actualValue, expectedValue);
        System.assertEquals(200, res.getStatusCode());
    }
}