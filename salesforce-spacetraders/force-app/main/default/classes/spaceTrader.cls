public with sharing class spaceTrader {
    public String token;	//43eb84d8-ccdf-461a-8894-913793018868
    public cls_user user;

    public class cls_user {
        public String id;	//ckmqiv2oi81874115s6ip5v5ra9
        public String username;	//DT123
        public cls_picture picture;
        public cls_email email;
        public Integer credits;	//0
        public String createdAt;	//2021-03-26T16:31:36.786Z
        public String updatedAt;	//2021-03-26T16:31:36.786Z
    }

    class cls_picture {
    }
    class cls_email {
    }

    public static spaceTrader parse(String json){
        return (spaceTrader) System.JSON.deserialize(json, spaceTrader.class);
    }
    
    // @isTest static testMethod void testParse() {
    //     String json=		'{'+
    //     '    "token": "43eb84d8-ccdf-461a-8894-913793018868",'+
    //     '    "user": {'+
    //     '        "id": "ckmqiv2oi81874115s6ip5v5ra9",'+
    //     '        "username": "DT123",'+
    //     '        "picture": null,'+
    //     '        "email": null,'+
    //     '        "credits": 0,'+
    //     '        "createdAt": "2021-03-26T16:31:36.786Z",'+
    //     '        "updatedAt": "2021-03-26T16:31:36.786Z"'+
    //     '    }'+
    //     '}';
    //     fromJSON obj = parse(json);
    //     System.assert(obj != null);
    //     }
}
